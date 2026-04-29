# LiteX-MiSTer Test

This repository explores using LiteX as a portable carrier/framework for MiSTer-style `emu`
cores. The goal is to keep existing cores close to their upstream shape while replacing
board-specific MiSTer plumbing with generated LiteX infrastructure.

Current status:

- MiSTer `template` and `memtest` cores are registered through `cores/*.yaml` manifests.
- `gateware/mister.py` instantiates the declared `emu` top and exposes carrier-side LiteX
  records for video, audio, SD-SPI, DDRAM, UART, user I/O, LEDs and status controls.
- Simulation and existing board targets still use the legacy `mister.vga` alias.

Useful commands:

```sh
python3 tools/check_mister_manifests.py
python3 tools/smoke_mister_cores.py
python3 tools/describe_host_bridges.py
python3 sim.py --core template --cpu-type=None --no-compile
python3 sim.py --core memtest --cpu-type=None --no-compile
```

See `docs/architecture.md`, `docs/porting.md`, `docs/host-bridges.md`,
`docs/cyclonev-hps-litex.md` and `docs/roadmap.md` for the intended direction.
