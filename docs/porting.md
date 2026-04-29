# Porting A MiSTer Core

## Objective

Porting an existing core such as NES or PlayStation must be mostly mechanical. The target
workflow is:

1. Keep the upstream MiSTer `emu` top-level port list.
2. Add a `cores/<core>.yaml` manifest.
3. Point the manifest at source directories and platform shims.
4. Run the smoke check.
5. Fix only the core-specific vendor primitives or unsupported framework assumptions.

Developers should not need to write a new LiteX target, a new HPS bridge, a new video
pipeline or board-specific project files just to try a core.

## Minimal Manifest

```yaml
name: nes
display_name: NES MiSTer
top: emu
source_root: NES_MiSTer
hps_bus_width: 49
video_aspect_width: 13

include_dirs:
  - .

source_dirs:
  - path: .
    recursive: false
  - path: rtl
  - path: sys

platform_source_dirs:
  sim:
    - path: rtl_sim
  xilinx:
    - path: rtl_xilinx
  lattice:
    - path: rtl_lattice

copy_sources:
  - rtl/some_rom.init

interfaces:
  video: true
  audio: true
  sd_spi: true
  ddram: true
  sdram: true
  uart: true
  user_io: true

status_controls:
  - name: rst
    bit: 0
    width: 1
```

`source_root` is the core repository or imported source directory. Paths inside the manifest
are relative to `source_root`.

## First-Port Checklist

- Run `python3 tools/check_mister_manifests.py <core>`.
- Run `python3 sim.py --core <core> --cpu-type=None --no-compile`.
- If elaboration fails, first check for missing source files, include paths and vendor RAM/PLL
  primitives.
- Keep platform-specific shims in `rtl_sim`, `rtl_xilinx`, `rtl_lattice` or similar named
  directories.
- Do not edit board targets for core-specific needs; express those needs in the manifest.

## Adoption Requirements

The framework should absorb common porting pain:

- source lists and include paths,
- PLL/RAM primitive replacement directories,
- MiSTer status bit exposure,
- video/audio/storage/control wiring,
- board and host selection,
- smoke tests that fail before a developer has to wait for full place-and-route.

When a second core needs the same manual patch as the first core, that patch belongs in the
LiteX-MiSTer framework.
