#!/usr/bin/env python3

#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2015-2019 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

# ./digilent_nexys_video.py --uart-name=uartbone --csr-csv=csr.csv --build --load
# litex_server --uart --uart-port=/dev/ttyUSBX
# ./test_video.py

from migen import *
from migen.genlib.cdc import MultiReg

from litex.gen import *

from litex_boards.platforms import digilent_nexys_video

from litex.soc.cores.clock import *
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *

from litex.soc.interconnect.csr import *
from litex.soc.interconnect import stream
from litex.soc.interconnect import wishbone

from litex.soc.cores.video import VideoS7HDMIPHY
from litex.soc.cores.led import LedChaser

from litedram.modules import MT41K256M16
from litedram.phy import s7ddrphy

from liteeth.phy.s7rgmii import LiteEthPHYRGMII

from litex.soc.cores.dma import WishboneDMAWriter

# CRG ----------------------------------------------------------------------------------------------

class _CRG(LiteXModule):
    def __init__(self, platform, sys_clk_freq, toolchain="vivado", with_video_pll=False):
        self.rst          = Signal()
        self.cd_sys       = ClockDomain()
        self.cd_sys4x     = ClockDomain()
        self.cd_sys4x_dqs = ClockDomain()
        self.cd_idelay    = ClockDomain()
        self.cd_hdmi      = ClockDomain()
        self.cd_hdmi5x    = ClockDomain()
        self.cd_clk100    = ClockDomain()
        self.cd_emu       = ClockDomain()

        # # #

        # Clk / Rst.
        clk100 = platform.request("clk100")
        rst_n  = platform.request("cpu_reset")

        # PLL.
        if toolchain == "vivado":
            self.pll = pll = S7MMCM(speedgrade=-1)
        else:
            self.pll = pll = S7PLL(speedgrade=-1)
        self.comb += pll.reset.eq(~rst_n | self.rst)
        pll.register_clkin(clk100, 100e6)
        pll.create_clkout(self.cd_sys,       sys_clk_freq)
        pll.create_clkout(self.cd_sys4x,     4*sys_clk_freq)
        pll.create_clkout(self.cd_sys4x_dqs, 4*sys_clk_freq, phase=90)
        pll.create_clkout(self.cd_idelay,    200e6)
        pll.create_clkout(self.cd_clk100,    100e6)
        platform.add_false_path_constraints(self.cd_sys.clk, pll.clkin) # Ignore sys_clk to pll.clkin path created by SoC's rst.

        self.idelayctrl = S7IDELAYCTRL(self.cd_idelay)

        # Video PLL.
        if with_video_pll:
            self.video_pll = video_pll = S7MMCM(speedgrade=-1)
            video_pll.reset.eq(~rst_n | self.rst)
            video_pll.register_clkin(clk100, 100e6)
            video_pll.create_clkout(self.cd_emu,    50e6)
            video_pll.create_clkout(self.cd_hdmi,   40e6)
            video_pll.create_clkout(self.cd_hdmi5x, 5*40e6)

# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self, toolchain="vivado", sys_clk_freq=100e6,
        with_ethernet          = False,
        with_led_chaser        = True,
        with_sata              = False, sata_gen="gen2",
        vadj                   = "1.2V",
        **kwargs):
        platform = digilent_nexys_video.Platform(toolchain=toolchain)

        # CRG --------------------------------------------------------------------------------------
        with_video_pll = True
        self.crg = _CRG(platform, sys_clk_freq, toolchain,
            with_video_pll       = with_video_pll
        )

        # SoCCore ----------------------------------------------------------------------------------
        SoCCore.__init__(self, platform, sys_clk_freq, ident="LiteX SoC on Nexys Video", **kwargs)

        # DDR3 SDRAM -------------------------------------------------------------------------------
        if not self.integrated_main_ram_size:
            self.ddrphy = s7ddrphy.A7DDRPHY(platform.request("ddram"),
                memtype      = "DDR3",
                nphases      = 4,
                sys_clk_freq = sys_clk_freq)
            self.add_sdram("sdram",
                phy           = self.ddrphy,
                module        = MT41K256M16(sys_clk_freq, "1:4"),
                l2_cache_size = kwargs.get("l2_size", 8192)
            )

        # Ethernet ---------------------------------------------------------------------------------
        if with_ethernet:
            self.ethphy = LiteEthPHYRGMII(
                clock_pads = self.platform.request("eth_clocks"),
                pads       = self.platform.request("eth"))
            self.add_ethernet(phy=self.ethphy)

        # SATA -------------------------------------------------------------------------------------
        if with_sata:
            from litex.build.generic_platform import Subsignal, Pins
            from litesata.phy import LiteSATAPHY

            # IOs
            _sata_io = [
                # AB09-FMCRAID / https://www.dgway.com/AB09-FMCRAID_E.html
                ("fmc2sata", 0,
                    Subsignal("clk_p", Pins("LPC:GBTCLK0_M2C_P")),
                    Subsignal("clk_n", Pins("LPC:GBTCLK0_M2C_N")),
                    Subsignal("tx_p",  Pins("LPC:DP0_C2M_P")),
                    Subsignal("tx_n",  Pins("LPC:DP0_C2M_N")),
                    Subsignal("rx_p",  Pins("LPC:DP0_M2C_P")),
                    Subsignal("rx_n",  Pins("LPC:DP0_M2C_N"))
                ),
            ]
            platform.add_extension(_sata_io)

            # RefClk, generate 150MHz from PLL.
            self.cd_sata_refclk = ClockDomain()
            self.crg.pll.create_clkout(self.cd_sata_refclk, 150e6)
            sata_refclk = ClockSignal("sata_refclk")
            platform.add_platform_command("set_property SEVERITY {{WARNING}} [get_drc_checks REQP-49]")

            # PHY
            self.sata_phy = LiteSATAPHY(platform.device,
                refclk     = sata_refclk,
                pads       = platform.request("fmc2sata"),
                gen        = sata_gen,
                clk_freq   = sys_clk_freq,
                data_width = 16)

            # Core
            self.add_sata(phy=self.sata_phy, mode="read+write")

        # MiSTeR -----------------------------------------------------------------------------------
        control    = Signal(128)
        vga_pads = Record([
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
            i_CLK_50M          = ClockSignal("emu"),
            i_RESET            = ResetSignal("emu"),

            # HPS Bus.
            io_HPS_BUS         = Open(), # FIXME.

            # Video (Generic).
            o_CLK_VIDEO        = vga_pads.clk,
            o_CE_PIXEL         = Open(), # FIXME.
            o_VIDEO_ARX        = Open(), # FIXME.
            o_VIDEO_ARY        = Open(), # FIXME.

            # Video VGA.
            o_VGA_R            = vga_pads.r[::-1],
            o_VGA_G            = vga_pads.g[::-1],
            o_VGA_B            = vga_pads.b[::-1],
            o_VGA_HS           = vga_pads.hsync_n,
            o_VGA_VS           = vga_pads.vsync_n,
            o_VGA_DE           = vga_pads.de,
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
        self.comb += self.cd_video.clk.eq(vga_pads.clk)

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


        self.video_capture = VideoCapture(vga_pads=vga_pads, fifo_depth=128)
        #self.comb += self.video_capture.bus.ack.eq(1)
        self.bus.add_master(name="video_capture", master=self.video_capture.bus)

#        from litescope import LiteScopeAnalyzer
#        analyzer_signals = [
#            vga_pads,
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
        self.videophy = VideoS7HDMIPHY(platform.request("hdmi_out"), clock_domain="hdmi")
        self.add_video_framebuffer(phy=self.videophy, timings="800x600@60Hz", clock_domain="hdmi")

        # Leds -------------------------------------------------------------------------------------
        if with_led_chaser:
            self.leds = LedChaser(
                pads         = platform.request_all("user_led"),
                sys_clk_freq = sys_clk_freq)

        # VADJ -------------------------------------------------------------------------------------
        vadj_map = {"1.2V": 0b00, "1.8V": 0b01, "2.5V": 0b10, "3.3V": 0b11}
        platform.request_all("vadj").eq(vadj_map[vadj])

# Build --------------------------------------------------------------------------------------------

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(platform=digilent_nexys_video.Platform, description="LiteX SoC on Nexys Video.")
    parser.add_target_argument("--sys-clk-freq",  default=100e6, type=float, help="System clock frequency.")
    parser.add_target_argument("--with-ethernet", action="store_true",       help="Enable Ethernet support.")
    sdopts = parser.target_group.add_mutually_exclusive_group()
    sdopts.add_argument("--with-spi-sdcard", action="store_true", help="Enable SPI-mode SDCard support.")
    sdopts.add_argument("--with-sdcard",     action="store_true", help="Enable SDCard support.")
    parser.add_target_argument("--with-sata",            action="store_true", help="Enable SATA support (over FMCRAID).")
    parser.add_target_argument("--sata-gen",             default="2",         help="SATA Gen.", choices=["1", "2"])
    parser.add_target_argument("--vadj",                 default="1.2V",      help="FMC VADJ value.", choices=["1.2V", "1.8V", "2.5V", "3.3V"])
    args = parser.parse_args()

    soc = BaseSoC(
        toolchain              = args.toolchain,
        sys_clk_freq           = args.sys_clk_freq,
        with_ethernet          = args.with_ethernet,
        with_sata              = args.with_sata,
        sata_gen               = "gen" + args.sata_gen,
        vadj                   = args.vadj,
        **parser.soc_argdict
    )
    if args.with_spi_sdcard:
        soc.add_spi_sdcard()
    if args.with_sdcard:
        soc.add_sdcard()
    builder = Builder(soc, **parser.builder_argdict)
    if args.build:
        builder.build(**parser.toolchain_argdict)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(builder.get_bitstream_filename(mode="sram"))

if __name__ == "__main__":
    main()
