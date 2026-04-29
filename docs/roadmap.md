# Roadmap

## Phase 0: Baseline

- Keep `template` and `memtest` building or elaborating.
- Document the `emu` ABI and ownership boundary.
- Add smoke checks that run without vendor place-and-route.

Status: implemented for manifest checks and simulation/no-compile smoke checks. Full
vendor smoke is available for DE10-Nano through the temporary HPS stub.

## Phase 1: Manifest-Driven Cores

- Move source lists, HPS bus width, platform shims and status controls to manifests.
- Keep board targets generic.
- Make adding NES/PlayStation-style cores a metadata-first task.

Status: implemented for `template` and `memtest`. `tools/extract_mister_confstr.py`
provides a first helper for generating status metadata from `CONF_STR`.

## Phase 2: Control, Input And OSD

- Parse enough of `CONF_STR` to generate control/status CSRs.
- Add keyboard, joystick, button and OSD control services.
- Provide host tools to inspect and modify core settings.

Status: partial. Status controls are manifest-driven and CONF_STR extraction exists, but
keyboard, joystick and OSD services are not implemented.

## Phase 3: Video

- Support direct video output where the board has suitable pins/PHYs.
- Support framebuffer capture through LiteX DMA for generic boards.
- Add simulation frame checks so a port can prove sync and active pixels before hardware.

## Phase 4: Audio

- Route MiSTer sample outputs to LiteX audio PHYs or host DMA buffers.
- Preserve MiSTer signed/unsigned and mono-mix metadata.

## Phase 5: Storage

- Provide SD-SPI pass-through first.
- Add block/image services that can be backed by files on a host.
- Keep image mounting semantics close to MiSTer so existing cores need minimal changes.

## Phase 6: Memory

- Pass through physical MiSTer-style SDRAM pins on compatible boards.
- Add a DDRAM-to-LiteDRAM bridge for high-latency RAM.
- Study low-latency SDRAM replacement separately; this is the main risk for large cores.

## Phase 7: Hard SoC Hosts

- Keep Zynq/ZynqMP on the existing LiteX hard-CPU classes.
- Add an upstreamable `cyclonev_hps` LiteX hard-CPU/bridge class.
- Bring up DE10-Nano HPS with a scratch CSR over the lightweight bridge.
- Reuse the same host bridge contract for MiSTer status, input, storage, video and audio.

Status: design documented in this branch.
The out-of-tree `cyclonev_hps` CPU prototype, DE10-Nano HPS target, HPS wrapper ABI checker,
Linux CSR probe and Quartus HPS smoke stub are implemented. Real Platform Designer HPS IP,
Linux bridge access and IRQ delivery still need hardware validation.

## Phase 8: PCIe/M.2 FPGA Host

- Use LitePCIe BARs for CSRs and control/status.
- Use DMA rings for storage, audio and video buffers.
- Start with host-rendered video before attempting direct display integration.
- Keep descriptor formats shared with Zynq and Cyclone V HPS.

Status: design documented in this branch.

## Phase 9: Core Corpus

- Port a small arcade core, then NES, then a demanding core such as PlayStation.
- Every repeated manual step should become framework metadata or reusable gateware.
