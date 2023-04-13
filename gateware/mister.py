#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2023 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *

from litex.gen import *

from litex.soc.interconnect.csr import *

# MiSTeR Top Level ---------------------------------------------------------------------------------

class MiSTeR(LiteXModule):
    def __init__(self, platform, core="template"):
        # Control/Status Signals.
        # -----------------------
        self.control = control = Signal(128)

        # VGA Signals.
        # ------------
        self.vga = vga = Record([
            # Synchronization signals.
            ("clk",     1),
            ("hsync_n", 1),
            ("vsync_n", 1),
            ("de",      1),
            # Data signals.
            ("r",       8),
            ("g",       8),
            ("b",       8),
        ])

        # Core Instance.
        # --------------
        self.specials += Instance("emu",
            # Clk/Rst.
            i_CLK_50M          = ClockSignal("emu"),
            i_RESET            = ResetSignal("emu"),

            # HPS Bus.
            io_HPS_BUS         = Open(), # FIXME.

            # Video (Generic).
            o_CLK_VIDEO        = vga.clk,
            o_CE_PIXEL         = Open(), # FIXME.
            o_VIDEO_ARX        = Open(), # FIXME.
            o_VIDEO_ARY        = Open(), # FIXME.

            # Video VGA.
            o_VGA_R            = vga.r[::-1],
            o_VGA_G            = vga.g[::-1],
            o_VGA_B            = vga.b[::-1],
            o_VGA_HS           = vga.hsync_n,
            o_VGA_VS           = vga.vsync_n,
            o_VGA_DE           = vga.de,
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
        if core == "template":
            platform.add_verilog_include_path("../Template_MiSTer")
            platform.add_source_dir("../Template_MiSTer")
            platform.add_source_dir("../Template_MiSTer/rtl/")
            platform.add_source_dir("../Template_MiSTer/sys/")
        else:
            raise NotImplementedError("Unsuported MiSTeR core.")

    def add_control_status_csr(self):
        # Control CSRs.
        self.control_rst = CSRStorage(1)
        self.control_pal = CSRStorage(1)
        self.control_col = CSRStorage(2)
        self.control_ar  = CSRStorage(2)

        self.comb += [
            self.control[        0].eq(self.control_rst.storage),
            self.control[        2].eq(self.control_pal.storage),
            self.control[    3:3+2].eq(self.control_col.storage),
            self.control[121:121+2].eq(self.control_ar.storage),
        ]
