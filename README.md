# LiteX-MiSTer Test

This repository explores using LiteX as a portable carrier/framework for MiSTer-style `emu`
cores. The goal is to keep existing cores close to their upstream shape while replacing
board-specific MiSTer plumbing with generated LiteX infrastructure.

Current status:

- MiSTer `template` and `memtest` cores are registered through `cores/*.yaml` manifests.
- `gateware/mister.py` instantiates the declared `emu` top and exposes carrier-side LiteX
  records for video, audio, SD-SPI, DDRAM, UART, user I/O, LEDs and status controls.
- `cyclonev_hps/` provides an out-of-tree LiteX CPU prototype for the Cyclone V HPS
  lightweight HPS-to-FPGA AXI bridge.
- `terasic_de10nano_hps.py` builds a DE10-Nano HPS target and can use an active synthesis
  stub for Quartus smoke builds before the generated Platform Designer HPS IP is available.
- Simulation and existing board targets still use the legacy `mister.vga` alias.

Useful commands:

```sh
python3 tools/check_mister_manifests.py
python3 tools/smoke_mister_cores.py
python3 tools/describe_host_bridges.py
python3 tools/check_cyclonev_hps_cpu.py
python3 sim.py --core template --cpu-type=None --no-compile
python3 sim.py --core memtest --cpu-type=None --no-compile
python3 terasic_de10nano_hps.py --help
PATH=/opt/quartus_lite_23.1/quartus/bin:$PATH python3 terasic_de10nano_hps.py --build --no-compile-software --output-dir /tmp/litex_de10nano_hps_quartus_stub --with-hps-stub
PATH=/opt/quartus_lite_23.1/quartus/bin:$PATH python3 terasic_de10nano_hps.py --build --no-compile-software --output-dir /tmp/litex_de10nano_hps_quartus_stub_template --with-hps-stub --with-mister --core template
```

See `docs/architecture.md`, `docs/porting.md`, `docs/host-bridges.md`,
`docs/cyclonev-hps-litex.md` and `docs/roadmap.md` for the intended direction.
