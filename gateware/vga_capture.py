#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2023 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *

from litex.gen import *

from litex.soc.interconnect import stream
from litex.soc.interconnect import wishbone

from litex.soc.cores.dma import WishboneDMAWriter

# VGA Capture --------------------------------------------------------------------------------------

class VGACapture(LiteXModule):
    def __init__(self, vga_ios, ram_base=0x40c0_0000, video_width=800, video_height=600):
        self.bus   = wishbone.Interface(data_width=32, address_width=32)
        self.reset = Signal()

        # # #

        # Convert VGA IOs to VGA MMAP Stream (Word addressing).
        # -----------------------------------------------------
        vga_mmap  = stream.Endpoint([("address", 32), ("data", 32)])
        vga_pixel = Signal(16)
        vga_line  = Signal(16)
        self.comb += vga_mmap.address.eq(ram_base//4 + vga_line*video_width + vga_pixel)

        vga_vsync_n_r = Signal()
        vga_hsync_n_r = Signal()
        self.sync.video += vga_vsync_n_r.eq(vga_ios.vsync_n)
        self.sync.video += vga_hsync_n_r.eq(vga_ios.hsync_n)

        fsm = FSM(reset_state="IDLE")
        fsm = ClockDomainsRenamer("video")(fsm)
        fsm = ResetInserter()(fsm)
        self.submodules.fsm = fsm
        self.comb += fsm.reset.eq(self.reset)
        fsm.act("IDLE",
            NextValue(vga_pixel, 0),
            NextValue(vga_line,  0),
            NextState("CLEAR")
        )
        fsm.act("CLEAR",
            vga_mmap.valid.eq(1),
            vga_mmap.data.eq(0),
            If(vga_mmap.ready,
                NextValue(vga_pixel, vga_pixel + 1),
                If(vga_pixel >= (video_width - 1),
                    NextValue(vga_pixel, 0),
                    NextValue(vga_line, vga_line + 1),
                    If(vga_line >= (video_height - 1),
                        NextState("VSYNC")
                    )
                )
            )
        )
        fsm.act("VSYNC",
            NextValue(vga_pixel, 0),
            NextValue(vga_line,  0),
            NextState("RUN")
        )
        fsm.act("HSYNC",
            NextValue(vga_pixel,       0),
            NextValue(vga_line, vga_line + 1),
            NextState("RUN")
        )
        fsm.act("RUN",
            vga_mmap.data[ 0: 8].eq(vga_ios.r << 3), # 5-bit dynamic.
            vga_mmap.data[ 8:16].eq(vga_ios.g << 2), # 6-bit dynamic.
            vga_mmap.data[16:24].eq(vga_ios.b << 3), # 5-bit dynamic.
            If(vga_ios.de,
                vga_mmap.valid.eq(1),
                If(vga_pixel >= video_width,
                    vga_mmap.valid.eq(0)
                ),
                If(vga_line >= video_height,
                    vga_mmap.valid.eq(0)
                ),
                NextValue(vga_pixel, vga_pixel + 1),
            ),
            If(vga_ios.hsync_n & ~vga_hsync_n_r,
                NextState("HSYNC")
            ),
            If(vga_ios.vsync_n & ~vga_vsync_n_r,
                NextState("VSYNC")
            )
        )

        # Clock Domain Crossing (video_clk -> sys_clk).
        # ---------------------------------------------
        self.cdc = stream.ClockDomainCrossing(
            layout   = [("address", 32), ("data", 32)],
            cd_from  = "video",
            cd_to    = "sys",
            buffered = True,
            depth    = 128,
        )

        # DMA.
        # ----
        self.dma = WishboneDMAWriter(bus=self.bus, endianness="big", with_csr=False)

        # Pipeline.
        # ---------
        self.comb += vga_mmap.connect(self.cdc.sink)
        self.comb += self.cdc.source.connect(self.dma.sink)
