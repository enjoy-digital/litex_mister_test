# Current Status

This branch is a non-hardware prototype for a LiteX-based MiSTer carrier and Cyclone V HPS
host bridge.

## Implemented

- Manifest-driven MiSTer source registration for `template` and `memtest`.
- A `MiSTeR` LiteX wrapper that instantiates the upstream-style `emu` top and exposes
  carrier-side records for video, audio, SD-SPI, DDRAM, UART, user I/O, LEDs and status.
- Manifest-selected platform source directories for simulation, Altera/Quartus, Xilinx and
  Lattice shims.
- Out-of-tree `cyclonev_hps` LiteX CPU prototype with the lightweight HPS-to-FPGA AXI3
  master connected to the LiteX bus.
- DE10-Nano HPS target with scratch/status CSRs at the HPS lightweight bridge window.
- Active Quartus HPS smoke stub for builds before the Platform Designer HPS wrapper exists.
- Static tools for manifest checks, CONF_STR extraction, Cyclone V HPS wrapper ABI checks
  and Linux-side CSR probing.

## Validated Without Hardware

- `template` and `memtest` simulation elaboration smoke checks.
- DE10-Nano HPS no-compile elaboration with the HPS smoke stub.
- Full Quartus compile, fit, timing, RBF and SVF generation with the HPS smoke stub for:
  - base DE10-Nano HPS target,
  - MiSTer `template`,
  - MiSTer `memtest`.

## Not Yet Validated

- Real Platform Designer HPS wrapper generation.
- Build with `--hps-ip` instead of `--with-hps-stub`.
- Linux bridge enablement and `/dev/mem` access to `0xff200000`.
- FPGA-to-HPS IRQ delivery.
- Real MiSTer `HPS_BUS`/`hps_io` compatibility.
- Video/audio/storage services beyond the current wrapper-level signal exposure.
- SDRAM or LiteDRAM-backed MiSTer memory replacement.

## Known Limitations

- `HPS_BUS` is intentionally not implemented as a full MiSTer `hps_io` replacement yet.
  Current smoke cores bypass `hps_io` and receive LiteX-generated `status` directly.
- The Quartus HPS stub is only a synthesis/fit/timing aid. It is not a behavioral model of
  the Cyclone V HPS and must not be used for hardware bring-up.
- The current MiSTer wrapper is a carrier boundary, not yet a complete replacement for
  MiSTer's Linux-side services.
