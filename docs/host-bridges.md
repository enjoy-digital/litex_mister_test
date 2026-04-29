# Host Bridges

## Objective

The MiSTer core wrapper should not care whether the host is a LiteX softcore, a Cyclone V
HPS, a Zynq PS or a PCIe root complex. Each host should provide the same carrier services:
control/status, input, storage, video, audio, memory and events.

The host bridge is the layer that adapts those services to the physical transport.

## Common Contract

Every host bridge should expose:

- Control plane: 32-bit MMIO access to LiteX CSRs.
- Bulk plane: a DMA-capable path for frame buffers, audio rings and storage blocks.
- Events: interrupt-capable notifications, with polling as the fallback.
- Reset ownership: a documented way to reset the carrier and the emulated core.
- Clock ownership: an explicit sys clock and an explicit emu/video clock strategy.
- Software map: generated CSR headers and a stable device-tree/UIO/driver binding.

The carrier above this contract should be identical for all hosts. `status` bits, joystick
state, block-device requests, video-frame descriptors and audio descriptors should not be
rewritten for each board.

## Host Mapping

| Host | Control Plane | Bulk Plane | Events | LiteX Status |
| --- | --- | --- | --- | --- |
| LiteX softcore | Native Wishbone/CSR | LiteDRAM or integrated RAM | LiteX IRQs | Already supported |
| Zynq/ZynqMP | PS AXI GP master to LiteX bus | PS HP/HPC slave ports | Fabric-to-PS IRQs | Already supported by `zynq7000` and `zynqmp` CPU classes |
| Cyclone V HPS | Lightweight HPS-to-FPGA AXI3 window at `0xff200000` | HPS-to-FPGA full bridge and FPGA-to-HPS bridge | FPGA-to-HPS IRQs | Missing hard-CPU bridge class |
| PCIe/M.2 | LitePCIe BAR0 Wishbone master | LitePCIe DMA rings | MSI/MSI-X | Already supported by LitePCIe frontends |

For Cyclone V, Intel documents the lightweight HPS-to-FPGA bridge as a 32-bit AXI master
intended for FPGA-side control/status access, and the full HPS-to-FPGA bridge as a wider
AXI path. The HPS address map places the lightweight FPGA slave window at `0xff200000`
and the full FPGA slave window at `0xc0000000`.

## MiSTer Services On The Contract

Status/control:
Use generated LiteX CSRs for the MiSTer `status` vector. Longer term, parse `CONF_STR`
and generate the register map automatically.

Input/OSD:
Expose keyboard, joystick, mouse and OSD commands as host-written CSRs or small command
rings. Keep the core-facing signals MiSTer-compatible.

Storage:
Start with SD-SPI pass-through where a board has the pins. Add a block-device service
where the host supplies image data from files. The core should still see MiSTer-style
mount semantics.

Video:
Use direct video output on boards with a suitable PHY. For HPS/PS/PCIe hosts, add a frame
ring: core video is captured into buffers, the host consumes descriptors, and direct
display redirection can be evaluated after latency is measurable.

Audio:
Route to a board PHY when available. Otherwise use a host-consumed sample ring with format
metadata preserved from the MiSTer audio outputs.

Memory:
Keep physical MiSTer SDRAM pins for compatible boards. Add a high-latency DDRAM-to-LiteDRAM
bridge for generic FPGA memory. Treat low-latency SDRAM replacement as a separate risk item.

## Incremental Implementation

1. Keep the current softcore/simulation path as the reference path.
2. Add the host bridge profiles as configuration, not as core-specific code.
3. Bring up Cyclone V HPS with one scratch CSR over the lightweight bridge.
4. Connect the existing MiSTer status CSRs to that bridge.
5. Add one host-side event source and prove IRQ or polling.
6. Add a frame ring using the existing VGA capture path.
7. Reuse the same ring descriptor and status/control model on Zynq and PCIe.
