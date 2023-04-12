#!/usr/bin/env python3

#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2018-2019 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *

from litex.gen import *

from litex_boards.platforms import digilent_nexys4ddr

from litex.soc.cores.clock import *
from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.cores.video import VideoVGAPHY
from litex.soc.cores.led import LedChaser

from litedram.modules import MT47H64M16
from litedram.phy import s7ddrphy

from liteeth.phy.rmii import LiteEthPHYRMII

# CRG ----------------------------------------------------------------------------------------------

class _CRG(LiteXModule):
    def __init__(self, platform, sys_clk_freq):
        self.rst          = Signal()
        self.cd_sys       = ClockDomain()
        self.cd_sys2x     = ClockDomain()
        self.cd_sys2x_dqs = ClockDomain()
        self.cd_idelay    = ClockDomain()
        self.cd_eth       = ClockDomain()
        self.cd_vga       = ClockDomain()
        # # #

        self.pll = pll = S7MMCM(speedgrade=-1)
        self.comb += pll.reset.eq(~platform.request("cpu_reset") | self.rst)
        pll.register_clkin(platform.request("clk100"), 100e6)
        pll.create_clkout(self.cd_sys,       sys_clk_freq)
        pll.create_clkout(self.cd_sys2x,     2*sys_clk_freq)
        pll.create_clkout(self.cd_sys2x_dqs, 2*sys_clk_freq, phase=90)
        pll.create_clkout(self.cd_idelay,    200e6)
        pll.create_clkout(self.cd_eth,       50e6)
        platform.add_false_path_constraints(self.cd_sys.clk, pll.clkin) # Ignore sys_clk to pll.clkin path created by SoC's rst.

        self.idelayctrl = S7IDELAYCTRL(self.cd_idelay)

# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self, sys_clk_freq=50e6,
        with_ethernet          = False,
        with_etherbone         = False,
        with_led_chaser        = True,
        **kwargs):
        platform = digilent_nexys4ddr.Platform()

        # CRG --------------------------------------------------------------------------------------
        self.crg = _CRG(platform, sys_clk_freq)

        # SoCCore ----------------------------------_-----------------------------------------------
        SoCCore.__init__(self, platform, sys_clk_freq, ident="LiteX SoC on Nexys4DDR", **kwargs)

        # DDR2 SDRAM -------------------------------------------------------------------------------
        if not self.integrated_main_ram_size:
            self.ddrphy = s7ddrphy.A7DDRPHY(platform.request("ddram"),
                memtype      = "DDR2",
                nphases      = 2,
                sys_clk_freq = sys_clk_freq)
            self.add_sdram("sdram",
                phy           = self.ddrphy,
                module        = MT47H64M16(sys_clk_freq, "1:2"),
                l2_cache_size = kwargs.get("l2_size", 8192)
            )

        # Ethernet / Etherbone ---------------------------------------------------------------------
        if with_ethernet or with_etherbone:
            self.ethphy = LiteEthPHYRMII(
                clock_pads = self.platform.request("eth_clocks"),
                pads       = self.platform.request("eth"))
            if with_ethernet:
                self.add_ethernet(phy=self.ethphy)
            if with_etherbone:
                self.add_etherbone(phy=self.ethphy)

        # Leds -------------------------------------------------------------------------------------
        if with_led_chaser:
            self.leds = LedChaser(
                pads         = platform.request_all("user_led"),
                sys_clk_freq = sys_clk_freq)

        # MiSTeR / Video ---------------------------------------------------------------------------
        vga_pads = platform.request("vga")
        self.specials += Instance("emu",
            # Clk/Rst.
            i_CLK_50M          = ClockSignal("sys"),
            i_RESET            = ResetSignal("sys"),

            # HPS Bus.
            io_HPS_BUS         = Open(), # FIXME.

            # Video (Generic).
            o_CLK_VIDEO        = Open(),
            o_CE_PIXEL         = Open(), # FIXME.
            o_VIDEO_ARX        = Open(), # FIXME.
            o_VIDEO_ARY        = Open(), # FIXME.

            # Video VGA.
            o_VGA_R            = Cat(Open(), [s for s in reversed(vga_pads.r)]),
            o_VGA_G            = Cat(        [s for s in reversed(vga_pads.g)]),
            o_VGA_B            = Cat(Open(), [s for s in reversed(vga_pads.b)]),
            o_VGA_HS           = vga_pads.hsync_n,
            o_VGA_VS           = vga_pads.vsync_n,
            o_VGA_DE           = Open(), # FIXME.
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
        )
        platform.add_verilog_include_path("Template_MiSTer")
        platform.add_source_dir("Template_MiSTer")
        platform.add_source_dir("Template_MiSTer/rtl/")
        platform.add_source_dir("Template_MiSTer/sys/")

# Build --------------------------------------------------------------------------------------------

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(platform=digilent_nexys4ddr.Platform, description="LiteX-MiSTeR SoC on Nexys4DDR.")
    parser.add_target_argument("--sys-clk-freq", default=50e6, type=float, help="System clock frequency.")
    ethopts = parser.target_group.add_mutually_exclusive_group()
    ethopts.add_argument("--with-ethernet",         action="store_true", help="Enable Ethernet support.")
    ethopts.add_argument("--with-etherbone",        action="store_true", help="Enable Etherbone support.")
    sdopts = parser.target_group.add_mutually_exclusive_group()
    sdopts.add_argument("--with-spi-sdcard",        action="store_true", help="Enable SPI-mode SDCard support.")
    sdopts.add_argument("--with-sdcard",            action="store_true", help="Enable SDCard support.")
    args = parser.parse_args()

    soc = BaseSoC(
        sys_clk_freq           = args.sys_clk_freq,
        with_ethernet          = args.with_ethernet,
        with_etherbone         = args.with_etherbone,
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
