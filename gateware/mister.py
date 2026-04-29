#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2023 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *

from litex.gen import *

from litex.soc.interconnect.csr import *

from gateware.mister_manifest import add_manifest_sources, load_core_manifest

# MiSTeR Top Level ---------------------------------------------------------------------------------

_video_layout = [
    # Generic video.
    ("clk",       1),
    ("ce",        1),
    ("arx",      13),
    ("ary",      13),

    # VGA-style core output.
    ("hsync_n",   1),
    ("vsync_n",   1),
    ("de",        1),
    ("f1",        1),
    ("sl",        2),
    ("scaler",    1),
    ("disable",   1),
    ("r",         8),
    ("g",         8),
    ("b",         8),
]

_audio_layout = [
    ("l",    16),
    ("r",    16),
    ("s",     1),
    ("mix",   2),
]

_sd_spi_layout = [
    ("sck",   1),
    ("mosi",  1),
    ("miso",  1),
    ("cs",    1),
    ("cd",    1),
]

_ddram_layout = [
    ("clk",        1),
    ("busy",       1),
    ("burstcnt",   8),
    ("addr",      29),
    ("dout",      64),
    ("dout_ready", 1),
    ("rd",         1),
    ("din",       64),
    ("be",         8),
    ("we",         1),
]

_uart_layout = [
    ("cts", 1),
    ("rts", 1),
    ("rxd", 1),
    ("txd", 1),
    ("dtr", 1),
    ("dsr", 1),
]

_user_io_layout = [
    ("i", 7),
    ("o", 7),
]

_leds_layout = [
    ("user",  1),
    ("power", 2),
    ("disk",  2),
]


class MiSTeR(LiteXModule):
    def __init__(self, platform, core="template"):
        self.manifest = manifest = load_core_manifest(core)

        # Control/Status Signals.
        # -----------------------
        self.status  = status  = Signal(128)
        self.control = control = status # Backward-compatible alias.

        # Carrier-side interfaces.
        # ------------------------
        self.video = video = Record(_video_layout)
        self.vga   = video # Backward-compatible alias used by existing targets.

        self.audio  = audio  = Record(_audio_layout)
        self.sd_spi = sd_spi = Record(_sd_spi_layout)
        self.ddram  = ddram  = Record(_ddram_layout)
        self.uart   = uart   = Record(_uart_layout)
        self.user   = user   = Record(_user_io_layout)
        self.leds   = leds   = Record(_leds_layout)

        self.buttons     = Signal(2)
        self.adc_bus     = Signal(4)
        self.clk_audio   = Signal()
        self.hdmi_width  = Signal(12)
        self.hdmi_height = Signal(12)
        self.hdmi_freeze = Signal()
        self.osd_status  = Signal()

        # Core Instance.
        # --------------
        arx = Signal(manifest.video_aspect_width)
        ary = Signal(manifest.video_aspect_width)
        self.comb += [
            video.arx.eq(arx),
            video.ary.eq(ary),
        ]

        self.specials += Instance(manifest.top,
            # Clk/Rst.
            i_CLK_50M          = ClockSignal("emu"),
            i_RESET            = ResetSignal("emu"),

            # HPS Bus.
            io_HPS_BUS         = Open(manifest.hps_bus_width),

            # Video (Generic).
            o_CLK_VIDEO        = video.clk,
            o_CE_PIXEL         = video.ce,
            o_VIDEO_ARX        = arx,
            o_VIDEO_ARY        = ary,

            # Video VGA.
            o_VGA_R            = video.r[::-1],
            o_VGA_G            = video.g[::-1],
            o_VGA_B            = video.b[::-1],
            o_VGA_HS           = video.hsync_n,
            o_VGA_VS           = video.vsync_n,
            o_VGA_DE           = video.de,
            o_VGA_F1           = video.f1,
            o_VGA_SL           = video.sl,
            o_VGA_SCALER       = video.scaler,
            o_VGA_DISABLE      = video.disable,

            # HDMI.
            i_HDMI_WIDTH       = self.hdmi_width,
            i_HDMI_HEIGHT      = self.hdmi_height,
            o_HDMI_FREEZE      = self.hdmi_freeze,

            # Leds.
            o_LED_USER         = leds.user,
            o_LED_POWER        = leds.power,
            o_LED_DISK         = leds.disk,

            # Buttons.
            o_BUTTONS          = self.buttons,

            # Audio.
            i_CLK_AUDIO        = self.clk_audio,
            o_AUDIO_L          = audio.l,
            o_AUDIO_R          = audio.r,
            o_AUDIO_S          = audio.s,
            o_AUDIO_MIX        = audio.mix,
            io_ADC_BUS         = self.adc_bus,

            # SDCard.
            o_SD_SCK           = sd_spi.sck,
            o_SD_MOSI          = sd_spi.mosi,
            i_SD_MISO          = sd_spi.miso,
            o_SD_CS            = sd_spi.cs,
            i_SD_CD            = sd_spi.cd,

            # DDRAM (DDR3).
            o_DDRAM_CLK        = ddram.clk,
            i_DDRAM_BUSY       = ddram.busy,
            o_DDRAM_BURSTCNT   = ddram.burstcnt,
            o_DDRAM_ADDR       = ddram.addr,
            i_DDRAM_DOUT       = ddram.dout,
            i_DDRAM_DOUT_READY = ddram.dout_ready,
            o_DDRAM_RD         = ddram.rd,
            o_DDRAM_DIN        = ddram.din,
            o_DDRAM_BE         = ddram.be,
            o_DDRAM_WE         = ddram.we,

            # SDRAM.
            #o_SDRAM_CLK        = Open(),   # FIXME.
            #o_SDRAM_CKE        = Open(),   # FIXME.
            #o_SDRAM_A          = Open(),   # FIXME.
            #o_SDRAM_BA         = Open(),   # FIXME.
            #io_SDRAM_DQ        = Open(16), # FIXME.
            #o_SDRAM_DQML       = Open(),   # FIXME.
            #o_SDRAM_DQMH       = Open(),   # FIXME.
            #o_SDRAM_nCS        = Open(),   # FIXME.
            #o_SDRAM_nCAS       = Open(),   # FIXME.
            #o_SDRAM_nRAS       = Open(),   # FIXME.
            #o_SDRAM_nWE        = Open(),   # FIXME.

            # UART.
            i_UART_CTS         = uart.cts,
            o_UART_RTS         = uart.rts,
            i_UART_RXD         = uart.rxd,
            o_UART_TXD         = uart.txd,
            o_UART_DTR         = uart.dtr,
            i_UART_DSR         = uart.dsr,

            # USER.
            i_USER_IN          = user.i,
            o_USER_OUT         = user.o,

            # OSD.
            i_OSD_STATUS       = self.osd_status,

            # STATUS
            i_status           = control, # FIXME: Name.
        )
        add_manifest_sources(platform, manifest)

    def add_control_status_csr(self):
        # Control CSRs.
        for control in self.manifest.status_controls:
            name  = control["name"]
            bit   = int(control["bit"])
            width = int(control.get("width", 1))
            csr   = CSRStorage(width)
            setattr(self, f"control_{name}", csr)
            self.comb += self.control[bit:bit + width].eq(csr.storage)
