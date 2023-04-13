#!/usr/bin/env python3

#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2020 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

# Build/Use ----------------------------------------------------------------------------------------
# Build/Load bitstream:
# ./siglent_sds1104xe.py --cpu-type=vexriscv --uart-name=crossover --with-etherbone --csr-csv=csr.csv --build --load
#
# Test Ethernet:
# ping 192.168.1.50
#
# Test Console:
# litex_server --udp
# litex_cli --gui
# --------------------------------------------------------------------------------------------------

from migen import *
from migen.genlib.cdc import MultiReg

from litex.gen import *

from litex_boards.platforms import siglent_sds1104xe

from litex.soc.cores.clock import *
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *

from litex.soc.interconnect.csr import *
from litex.soc.interconnect import stream
from litex.soc.interconnect import wishbone

from litedram.common import PHYPadsReducer
from litedram.modules import MT41K64M16
from litedram.phy import s7ddrphy

from liteeth.phy.mii import LiteEthPHYMII

from litex.soc.cores.video import VideoVGAPHY

from litex.soc.cores.dma import WishboneDMAWriter

from gateware.mister import MiSTeR

# CRG ----------------------------------------------------------------------------------------------

class _CRG(LiteXModule):
    def __init__(self, platform, sys_clk_freq, with_ethernet=False):
        self.rst          = Signal()
        self.cd_sys       = ClockDomain()
        self.cd_sys4x     = ClockDomain()
        self.cd_sys4x_dqs = ClockDomain()
        self.cd_idelay    = ClockDomain()
        self.cd_dvi       = ClockDomain()

        # # #

        # Clk / Rst
        clk25 = ClockSignal("eth_tx") if with_ethernet else platform.request("eth_clocks").rx

        # PLL
        self.pll = pll = S7PLL(speedgrade=-1)
        pll.register_clkin(clk25, 25e6)
        pll.create_clkout(self.cd_sys,       sys_clk_freq)
        pll.create_clkout(self.cd_sys4x,     4*sys_clk_freq)
        pll.create_clkout(self.cd_sys4x_dqs, 4*sys_clk_freq, phase=90)
        pll.create_clkout(self.cd_idelay,    200e6)
        pll.create_clkout(self.cd_dvi,       33.3e6)
        platform.add_false_path_constraints(self.cd_sys.clk, pll.clkin) # Ignore sys_clk to pll.clkin path created by SoC's rst.

        self.idelayctrl = S7IDELAYCTRL(self.cd_idelay)

# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self, sys_clk_freq=50e6,
        with_etherbone         = True,
        eth_ip                 = "192.168.1.50",
        **kwargs):
        platform = siglent_sds1104xe.Platform()

        # CRG --------------------------------------------------------------------------------------
        self.crg = _CRG(platform, sys_clk_freq, with_ethernet=with_etherbone)

        # SoCCore ----------------------------------------------------------------------------------
        if kwargs.get("uart_name", "serial") == "serial":
            kwargs["uart_name"] = "crossover" # Defaults to Crossover UART.
        SoCCore.__init__(self, platform, sys_clk_freq, ident="LiteX SoC on Siglent SDS1104X-E", **kwargs)
        self.uart.add_auto_tx_flush(sys_clk_freq=sys_clk_freq, timeout=1, interval=128)

        # DDR3 SDRAM -------------------------------------------------------------------------------
        if not self.integrated_main_ram_size:
            self.ddrphy = s7ddrphy.A7DDRPHY(
                pads           = PHYPadsReducer(platform.request("ddram"), [0, 1, 2, 3]),
                memtype        = "DDR3",
                nphases        = 4,
                sys_clk_freq   = sys_clk_freq)
            self.add_sdram("sdram",
                phy           = self.ddrphy,
                module        = MT41K64M16(sys_clk_freq, "1:4"),
                l2_cache_size = kwargs.get("l2_size", 8192)
            )

        # Etherbone --------------------------------------------------------------------------------
        if with_etherbone:
            self.submodules.ethphy = LiteEthPHYMII(
                clock_pads = self.platform.request("eth_clocks"),
                pads       = self.platform.request("eth"))
            self.add_etherbone(phy=self.ethphy, ip_address=eth_ip)

        # MiSTeR -----------------------------------------------------------------------------------
        self.mister = mister = MiSTeR(platform, core="template")
        self.mister.add_control_status_csr()

        # Video ------------------------------------------------------------------------------------
        # Video Clk Domain.
        self.cd_video = ClockDomain()
        self.comb += self.cd_video.clk.eq(mister.vga.clk)

        # Video Capture/DMA.

        class VGACapture(LiteXModule):
            def __init__(self, vga_pads, base=0x40c0_0000, width=800):
                self.source = source = stream.Endpoint([("address", 32), ("data", 32)])

                # # #

                self.pixel = pixel = Signal(16)
                self.line  = line  = Signal(16)

                vsync_n_r = Signal()
                hsync_n_r = Signal()
                self.sync.video += vsync_n_r.eq(vga_pads.vsync_n)
                self.sync.video += hsync_n_r.eq(vga_pads.hsync_n)

                fsm = FSM(reset_state="VSYNC")
                fsm = ClockDomainsRenamer("video")(fsm)
                self.submodules.fsm = fsm
                fsm.act("VSYNC",
                    NextValue(pixel, 0),
                    NextValue(line,  0),
                    NextState("RUN"),
                )
                fsm.act("HSYNC",
                    NextValue(pixel,       0),
                    NextValue(line, line + 1),
                    NextState("RUN"),
                )
                fsm.act("RUN",
                    source.address.eq(base//4 + line*width + pixel), # Word addressing.
                    source.data[ 0: 8].eq(vga_pads.r),
                    source.data[ 8:16].eq(vga_pads.g),
                    source.data[16:24].eq(vga_pads.b),
                    If(vga_pads.de,
                        source.valid.eq(1),
                        NextValue(pixel, pixel + 1),
                    ),
                    If(vga_pads.hsync_n & ~hsync_n_r,
                        NextState("HSYNC")
                    ),
                    If(vga_pads.vsync_n & ~vsync_n_r,
                        NextState("VSYNC")
                    ),
                )

        class VideoCapture(LiteXModule):
            def __init__(self, vga_pads, fifo_depth=128):
                self.bus  = wishbone.Interface(data_width=32, address_width=32)

                # # #

                # VGA Capture.
                # ------------
                self.vga_capture = VGACapture(vga_pads, base=0x40c0_0000, width=800)

                # Clock Domain Crossing (pix_clk -> sys_clk).
                # -------------------------------------------
                self.cdc = stream.ClockDomainCrossing(
                    layout   = [("address", 32), ("data", 32)],
                    cd_from  = "video",
                    cd_to    = "sys",
                    buffered = True,
                    depth    = fifo_depth
                )

                # DMA.
                # ----
                self.dma = WishboneDMAWriter(bus=self.bus, with_csr=False)

                # Pipeline.
                # ---------
                self.comb += self.vga_capture.source.connect(self.cdc.sink)
                self.comb += self.cdc.source.connect(self.dma.sink)


        self.video_capture = VideoCapture(vga_pads=mister.vga, fifo_depth=128)
        #self.comb += self.video_capture.bus.ack.eq(1)
        self.bus.add_master(name="video_capture", master=self.video_capture.bus)

#        from litescope import LiteScopeAnalyzer
#        analyzer_signals = [
#            mister.vga,
#            self.video_capture.vga_capture.fsm,
#            self.video_capture.vga_capture.line,
#            self.video_capture.vga_capture.pixel,
#            self.video_capture.vga_capture.source,
#        ]
#        self.analyzer = LiteScopeAnalyzer(analyzer_signals,
#            depth        = 512,
#            clock_domain = "video",
#            samplerate   = sys_clk_freq,
#            csr_csv      = "analyzer.csv"
#        )

        # Video Framebuffer.
        video_timings = ("800x480@60Hz", {
            "pix_clk"       : 33.3e6,
            "h_active"      : 800,
            "h_blanking"    : 256,
            "h_sync_offset" : 210,
            "h_sync_width"  : 1,
            "v_active"      : 480,
            "v_blanking"    : 45,
            "v_sync_offset" : 22,
            "v_sync_width"  : 1,
        })
        self.videophy = VideoVGAPHY(platform.request("lcd"), clock_domain="dvi")
        self.add_video_framebuffer(phy=self.videophy, timings=video_timings, clock_domain="dvi")

# Build --------------------------------------------------------------------------------------------

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(platform=siglent_sds1104xe.Platform, description="LiteX SoC on SDS1104X-E.")
    parser.add_target_argument("--sys-clk-freq",   default=50e6, type=float, help="System clock frequency.")
    parser.add_target_argument("--with-etherbone", action="store_true",       help="Enable Etherbone support.")
    parser.add_target_argument("--eth-ip",         default="192.168.1.50",     help="Ethernet/Etherbone IP address.")
    args = parser.parse_args()

    soc = BaseSoC(
        sys_clk_freq   = args.sys_clk_freq,
        with_etherbone = args.with_etherbone,
        eth_ip         = args.eth_ip,
        **parser.soc_argdict
    )

    builder = Builder(soc, **parser.builder_argdict)
    if args.build:
        builder.build(**parser.toolchain_argdict)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(builder.get_bitstream_filename(mode="sram"), device=1)

if __name__ == "__main__":
    main()
