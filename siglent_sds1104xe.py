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
        control    = Signal(128)
        video_clk  = Signal()
        video_pads = Record([
            ("clk",     1),
            # Synchronization signals.
            ("hsync_n", 1),
            ("vsync_n", 1),
            ("de",      1),
            # Data signals.
            ("r",       8),
            ("g",       8),
            ("b",       8),
        ])
        self.specials += Instance("emu",
            # Clk/Rst.
            i_CLK_50M          = ClockSignal("sys"),
            i_RESET            = ResetSignal("sys"),

            # HPS Bus.
            io_HPS_BUS         = Open(), # FIXME.

            # Video (Generic).
            o_CLK_VIDEO        = video_pads.clk,
            o_CE_PIXEL         = Open(), # FIXME.
            o_VIDEO_ARX        = Open(), # FIXME.
            o_VIDEO_ARY        = Open(), # FIXME.

            # Video VGA.
            o_VGA_R            = video_pads.r[::-1],
            o_VGA_G            = video_pads.g[::-1],
            o_VGA_B            = video_pads.b[::-1],
            o_VGA_HS           = video_pads.hsync_n,
            o_VGA_VS           = video_pads.vsync_n,
            o_VGA_DE           = video_pads.de,
            o_VGA_F1           = Open(), # FIXME.
            o_VGA_SL           = Open(), # FIXME.
            o_VGA_SCALER       = Open(), # FIXME.
            o_VGA_DISABLE      = Open(), # FIXME.

            # HDMI.
            i_HDMI_WIDTH       = 0,      # FIXME.
            i_HDMI_HEIGHT      = 0,      # FIXME.
            o_HDMI_FREEZE      = Open(), # FIXME.

            # Leds.
            o_LED_USER         = Open(), # FIXME.
            o_LED_POWER        = Open(), # FIXME.
            o_LED_DISK         = Open(), # FIXME.

            # Buttons.
            o_BUTTONS          = Open(), # FIXME.

            # Audio.
            i_CLK_AUDIO        = 0,      # FIXME.
            o_AUDIO_L          = Open(), # FIXME.
            o_AUDIO_R          = Open(), # FIXME.
            o_AUDIO_S          = Open(), # FIXME.
            o_AUDIO_MIX        = Open(), # FIXME.
            io_ADC_BUS         = Open(), # FIXME.

            # SDCard.
            o_SD_SCK           = Open(), # FIXME.
            o_SD_MOSI          = Open(), # FIXME.
            i_SD_MISO          = 0,      # FIXME.
            o_SD_CS            = Open(), # FIXME.
            i_SD_CD            = 0,      # FIXME.

            # DDRAM (DDR3).
            o_DDRAM_CLK        = Open(), # FIXME.
            i_DDRAM_BUSY       = 0,      # FIXME.
            o_DDRAM_BURSTCNT   = Open(), # FIXME.
            o_DDRAM_ADDR       = Open(), # FIXME.
            i_DDRAM_DOUT       = 0,      # FIXME.
            i_DDRAM_DOUT_READY = 0,      # FIXME.
            o_DDRAM_RD         = Open(), # FIXME.
            o_DDRAM_DIN        = Open(), # FIXME.
            o_DDRAM_BE         = Open(), # FIXME.
            o_DDRAM_WE         = Open(), # FIXME.

            # SDRAM.
            o_SDRAM_CLK        = Open(), # FIXME.
            o_SDRAM_CKE        = Open(), # FIXME.
            o_SDRAM_A          = Open(), # FIXME.
            o_SDRAM_BA         = Open(), # FIXME.
            io_SDRAM_DQ        = Open(), # FIXME.
            o_SDRAM_DQML       = Open(), # FIXME.
            o_SDRAM_DQMH       = Open(), # FIXME.
            o_SDRAM_nCS        = Open(), # FIXME.
            o_SDRAM_nCAS       = Open(), # FIXME.
            o_SDRAM_nRAS       = Open(), # FIXME.
            o_SDRAM_nWE        = Open(), # FIXME.

            # UART.
            i_UART_CTS         = 0,      # FIXME.
            o_UART_RTS         = Open(), # FIXME.
            i_UART_RXD         = 0,      # FIXME.
            o_UART_TXD         = Open(), # FIXME.
            o_UART_DTR         = Open(), # FIXME.
            i_UART_DSR         = 0,      # FIXME.

            # USER.
            i_USER_IN          = 0,      # FIXME.
            o_USER_OUT         = Open(), # FIXME.

            # OSD.
            i_OSD_STATUS       = 0,      # FIXME.

            # STATUS
            i_status           = control, # FIXME: Name.
        )
        platform.add_verilog_include_path("Template_MiSTer")
        platform.add_source_dir("Template_MiSTer")
        platform.add_source_dir("Template_MiSTer/rtl/")
        platform.add_source_dir("Template_MiSTer/sys/")

        # Control CSRs.
        self.ctrl_rst = CSRStorage(1)
        self.ctrl_pal = CSRStorage(1)
        self.ctrl_col = CSRStorage(2)
        self.ctrl_ar  = CSRStorage(2)

        self.comb += [
            control[        0].eq(self.ctrl_rst.storage),
            control[        2].eq(self.ctrl_pal.storage),
            control[    3:3+2].eq(self.ctrl_col.storage),
            control[121:121+2].eq( self.ctrl_ar.storage),
        ]

        # Video Clk Domain.
        self.cd_video = ClockDomain()
        self.comb += self.cd_video.clk.eq(video_pads.clk)

        # Video Capture/DMA.
        class VideoCapture(LiteXModule):
            def __init__(self, fifo_depth=128):
                self.sink = stream.Endpoint([("data", 32), ("vsync_n", 1)])
                self.bus  = wishbone.Interface(data_width=32, address_width=32)

                # # #

                # Clock Domain Crossing (pix_clk -> sys_clk).
                # -------------------------------------------
                self.cdc = stream.ClockDomainCrossing(
                    layout   = [("data", 32)],
                    cd_from  = "video",
                    cd_to    = "sys",
                    buffered = True,
                    depth    = fifo_depth
                )

                # DMA.
                # ----
                self.dma = WishboneDMAWriter(bus=self.bus, with_csr=True)

                # Pipeline.
                # ---------
                self.comb += self.cdc.source.connect(self.dma.sink, omit={"last"})

                # FSM.
                # ----
                enable = Signal()
                self.specials += MultiReg(self.dma._enable.storage, enable, "video")

                fsm = FSM(reset_state="IDLE")
                fsm = ClockDomainsRenamer("video")(fsm)
                fsm = ResetInserter()(fsm)
                self.fsm = fsm
                self.comb += fsm.reset.eq(~enable)
                fsm.act("IDLE",
                    self.sink.ready.eq(1),
                    If(self.sink.vsync_n,
                        NextState("RUN")
                    )
                )
                fsm.act("RUN",
                    self.sink.connect(self.cdc.sink, omit={"vsync_n"})
                )

        self.video_capture = VideoCapture(fifo_depth=128)
        self.comb += [
            self.video_capture.sink.valid.eq(video_pads.de),
            self.video_capture.sink.vsync_n.eq(video_pads.vsync_n),
            self.video_capture.sink.data[ 0: 8].eq(video_pads.r),
            self.video_capture.sink.data[ 8:16].eq(video_pads.g),
            self.video_capture.sink.data[16:24].eq(video_pads.b),
        ]
        self.bus.add_master(name="video_capture", master=self.video_capture.bus)


        from litescope import LiteScopeAnalyzer
        analyzer_signals = [
            video_pads,
            self.video_capture.fsm,
            self.video_capture.cdc.sink,
            self.video_capture.cdc.source,
            self.video_capture.bus,
        ]
        self.analyzer = LiteScopeAnalyzer(analyzer_signals,
            depth        = 2048,
            clock_domain = "sys",
            samplerate   = sys_clk_freq,
            csr_csv      = "analyzer.csv"
        )

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
