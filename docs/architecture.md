# Architecture

## Goal

LiteX should act as a portable MiSTer carrier. Existing MiSTer cores should keep their
usual `emu` top-level contract, while the board, host, memory, video, storage and control
plumbing is generated from LiteX.

The adoption rule is simple: a core developer should not have to invent a new SoC wrapper
for every board. For a first port, they should provide a small manifest, keep the MiSTer
`emu` ABI, and only patch vendor-specific primitives when unavoidable.

## Boundary

The stable boundary is the MiSTer `emu` module. LiteX owns the carrier side:

- clock/reset domains,
- source registration and platform shims,
- status/control CSRs,
- video capture or direct video output,
- audio routing,
- SD/storage services,
- DDRAM/LiteDRAM bridging,
- host transport over UARTBone, Etherbone, hard SoC buses or PCIe.

The core owns system-specific logic:

- the machine or console implementation,
- core-local timing,
- core-visible status bits,
- optional low-latency memory assumptions,
- ROM/image loader semantics.

## Current Implementation

`gateware/mister.py` loads `cores/<name>.yaml`, instantiates the declared `emu` top and
adds the source files described by the manifest. It exposes the following carrier-side
interfaces:

- `mister.video` / `mister.vga`: clock, CE, aspect ratio, RGB, sync, DE and scaler flags.
- `mister.audio`: left/right samples and MiSTer audio metadata.
- `mister.sd_spi`: MiSTer SD-SPI pins.
- `mister.ddram`: MiSTer high-latency DDRAM request/response pins.
- `mister.uart`: UART pins.
- `mister.user`: open-drain user port pins.
- `mister.leds`, `mister.buttons`, `mister.osd_status`, `mister.status`.

Only part of this is connected to full LiteX services today. The important step is that
the signals now have named ownership and can be connected incrementally by board/host
carriers.

## Host Models

The same carrier boundary should support several hosts:

- Softcore or no CPU: useful for simulation, smoke tests and minimal boards.
- LiteX softcore with UARTBone/Etherbone: useful for bring-up and debugging.
- Cyclone V HPS: compatibility path for MiSTer-like SoC FPGA boards.
- Zynq/ZynqMP PS: ARM host with AXI access to LiteX-generated peripherals.
- PCIe/M.2 FPGA card: PC host controls CSRs and DMA buffers through LitePCIe.

PCIe video should begin as raw frame DMA into a host ring buffer. A native display path can
come later after timing, latency and buffering are measurable.

`docs/host-bridges.md` defines the shared control/bulk/event contract. Cyclone V HPS is
the main missing upstream LiteX piece; `docs/cyclonev-hps-litex.md` describes the proposed
LiteX CPU/bridge class and DE10-Nano bring-up sequence.
