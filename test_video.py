#!/usr/bin/env python3

import time

from litex import RemoteClient

bus = RemoteClient()
bus.open()

# # #

# Stop Video.
bus.regs.video_capture_dma_enable.write(0)
bus.regs.video_framebuffer_dma_enable.write(0)
time.sleep(0.1)

# Configure Template core.
bus.regs.main_ctrl_pal.write(0)

# Configure and enable Video Capture.
bus.regs.video_capture_dma_base.write(0x40c00000)
bus.regs.video_capture_dma_length.write(640*480*4)
bus.regs.video_capture_dma_loop.write(1)
bus.regs.video_capture_dma_enable.write(1)

# Configure and enable Video Framebuffer.
bus.regs.video_framebuffer_dma_base.write(0x40c00000)
bus.regs.video_framebuffer_dma_length.write(640*480*4) # Nexys Video.
#bus.regs.video_framebuffer_dma_length.write(800*480*4) # Siglent.
bus.regs.video_framebuffer_dma_loop.write(1)
bus.regs.video_framebuffer_dma_enable.write(1)

# # #

bus.close()