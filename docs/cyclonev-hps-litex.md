# Cyclone V HPS In LiteX

## Current Gap

LiteX already has hard-CPU integration for Zynq and ZynqMP. The local LiteX-Boards tree
also has DE10-Nano, DE1-SoC and SoCKit targets, but those targets use the FPGA fabric only.
They do not expose the Cyclone V HPS as a LiteX CPU/bus master in the same way that
`zynq7000` exposes the PS AXI ports.

For this project, the missing piece is an upstreamable `cyclonev_hps` LiteX CPU/bridge
class and a DE10-Nano HPS target that can host the MiSTer carrier through normal LiteX
CSRs and DMA paths.

## Prior LiteX Discussion

The same direction was already discussed upstream:

- `litex-hub/litex-boards#63` asked whether the DE1-SoC target could use the hard
  processor. The useful conclusions were that HPS support is worthwhile, the first design
  should be inspired by the Zynq integration, the Cyclone V fabric bridges are AXI3, and
  the easiest merge path is AXI-to-Wishbone for LiteX control.
- `enjoy-digital/litex#466` tracked "Add hard processor support for Cyclone V". The
  maintainer guidance was to first create a CPU-less LiteX SoC, instantiate the HPS, add
  it as a Wishbone master through `AXI2Wishbone`, and only then decide the final upstream
  shape. The thread also converged on a CPU-class approach, `cpu_type="hps"` in that
  discussion, because it reuses normal `SoCCore` parser and integration behavior.
- The same thread suggested using a Qsys/Platform Designer project file and letting
  Quartus regenerate HPS HDL during the build, rather than committing generated vendor HDL.
- `enjoy-digital/litex#2236` later added flexibility around custom UART pads. The motivating
  use case was a DE10-Nano Linux HPS-to-FPGA UART path, using
  `cyclonev_hps_interface_peripheral_uart`, so it is adjacent bring-up work but not a
  replacement for a real HPS bus-master CPU class.
- `enjoy-digital/litex#2224` shows a current DE1-SoC/Cyclone V JTAG pain point: the ARM HPS
  TAP appears in the scan chain and can confuse `litex_term`/OpenOCD use. That is not part
  of the HPS MMIO bridge, but it matters for developer ergonomics.

The plan here should therefore not restart the debate. It should produce the missing
working prototype, keep it close to the Zynq/ZynqMP CPU classes, then upstream the
minimal useful subset.

## Out-Of-Tree Prototype

LiteX can discover CPU classes from the current working directory. A local prototype can
live outside LiteX while still being selected by normal target arguments:

```text
cyclonev_hps/
  __init__.py
  core.py
```

`__init__.py` imports the class from `core.py`, and the class name should normalize to the
directory name:

```python
from cyclonev_hps.core import CycloneVHPS
```

This lets a target started from this repository use `--cpu-type=cyclonev_hps` without
patching the LiteX checkout. Once the class works, the same directory can be copied into
`litex/soc/cores/cpu/cyclonev_hps/` for the upstream PR.

This branch now provides that out-of-tree package in `cyclonev_hps/` and a first
DE10-Nano target in `terasic_de10nano_hps.py`.

The first prototype should avoid MiSTer complexity:

1. Instantiate a minimal HPS component generated from Platform Designer.
2. Expose only the lightweight HPS-to-FPGA AXI3 master.
3. Append that AXI bus to `self.periph_buses`, just as `Zynq7000` appends PS GP0.
4. Let LiteX convert AXI to the main Wishbone/CSR bus.
5. Build a `SoCMini`/small `SoCCore` target with identifier, scratch CSR and LED CSR.
6. Boot Linux on the HPS, enable FPGA bridges, map `0xff200000`, and read/write the CSR.

The generated HPS wrapper is expected to expose this minimal ABI:

- module name: `cyclonev_hps_litex` by default, override with `--hps-module-name`,
- lightweight AXI prefix: `h2f_lw` by default, override with `--hps-lw-prefix`,
- clock/reset ports: `h2f_lw_aclk`, `h2f_lw_areset_n`, `h2f_rst_n`,
- IRQ port: `f2h_irq[63:0]`,
- AXI3 ports named `<prefix>_awvalid`, `<prefix>_awready`, `<prefix>_awaddr`, and so on.

The wrapper should be generated from Platform Designer and added with `--hps-ip`. For
elaboration-only checks it can remain a blackbox.

Full Quartus smoke builds can temporarily use `--with-hps-stub` when the Platform Designer
component has not been generated yet. This writes a Verilog module under
`/tmp/litex_mister_hps_stubs/` with the same port ABI and adds it to the Quartus project.
The stub drives the exported HPS reset/clock pins and periodically issues single-beat AXI3
writes to `--hps-stub-addr`, which defaults to `0xff201000` and targets the `hps_scratch`
CSR. This is useful for synthesis, fit, timing and MiSTer source-list validation, but it is
not a HPS model and is not a hardware bring-up path. Real HPS/Linux builds still require
`--hps-ip`; the target rejects combining `--with-hps-stub` and `--hps-ip`.
`docs/platform-designer-hps.md` describes the generated wrapper shape and
`tools/check_cyclonev_hps_wrapper.py` validates it before a full Quartus build.

The DE10-Nano target declares HPS DDR as a LiteX bus region at `0x00000000` so the
hard CPU reset address is valid in LiteX metadata. Its default size is `0x40000000`
and can be adjusted with `--hps-ddr-size` for boards with a different HPS memory map.

After this succeeds, expand the prototype in small steps:

1. Add FPGA-to-HPS IRQ lines and validate one LiteX event from Linux.
2. Add optional full HPS-to-FPGA bridge for wider host reads/writes.
3. Add optional FPGA-to-HPS or FPGA-to-SDRAM path for DMA/rings.
4. Add the MiSTer carrier and drive `status` CSRs from Linux.
5. Add video/audio/storage rings only after the control path and IRQ path are stable.

## Proposed LiteX Shape

Add a new LiteX CPU core directory:

```text
litex/soc/cores/cpu/cyclonev_hps/
  __init__.py
  core.py
```

The `CycloneVHPS` class should be a hard CPU integration class, similar in role to
`Zynq7000`, but using the Intel HPS component generated by Quartus/Platform Designer.

Expected class responsibilities:

- Declare the HPS as `category = "hardcore"`, `family = "arm"` and `name = "cyclonev_hps"`.
- Use `variants = ["standard"]` first; add variants only for real bridge-width or board
  generation differences.
- Define `mem_map["csr"]` at the HPS-visible lightweight bridge address and set
  `csr_decode = True`, matching the Zynq model where the bridge decodes the external
  address window.
- Add the lightweight HPS-to-FPGA AXI3 master as a LiteX peripheral bus.
- Optionally add the full HPS-to-FPGA AXI3 master for wider host-to-fabric access.
- Optionally add the FPGA-to-HPS AXI bridge so FPGA DMA masters can write HPS DDR.
- Expose FPGA-to-HPS interrupt inputs.
- Expose HPS-provided clock/reset signals, or accept fabric clocks for bridge domains.
- Generate or include the Quartus HPS component in a reproducible way.

LiteX already has AXI and Avalon support. The preferred first version should keep the HPS
fabric side in AXI3 and use existing LiteX AXI-to-Wishbone conversion for CSRs. Since LiteX
Wishbone does not need bursts for the CSR path, the first bridge can be AXI-Lite-like
behavior over the AXI3 pins. Full AXI3 burst coverage belongs in the later bulk/DMA phase,
not the initial scratch-CSR milestone. Avalon-MM can be supported later if Platform Designer
generation makes that path easier for some boards.

## Address Map

The first implementation should use the standard Cyclone V HPS bridge windows:

- `0xff200000`: lightweight HPS-to-FPGA slave window, 32-bit control/status path.
- `0xc0000000`: full HPS-to-FPGA slave window, wider host-to-fabric path.

The LiteX CSR region should fit inside the lightweight window first. Bulk services should
not be forced into that window; they should use a DMA path or the full bridge depending
on the board and operating system.

## DE10-Nano Target

Add a target in LiteX-Boards once the CPU class exists:

```text
litex_boards/targets/terasic_de10nano_hps.py
```

Target behavior:

- Default to `cpu_type="cyclonev_hps"`.
- Disable the normal LiteX UART unless explicitly requested; Linux/HPS owns console first.
- Use the HPS lightweight bridge for LiteX CSRs.
- Keep the existing MiSTer SDRAM/video/SD-card expansion IO definitions from the current
  DE10-Nano platform.
- Optionally instantiate the HPS peripheral UART path described in the UART pads PR for
  low-friction development from Linux.
- Emit CSR CSV/header files for Linux-side tests and drivers.

The first board proof should be deliberately small:

1. Build a DE10-Nano bitstream with only CRG, CSR bus and a scratch CSR.
2. Boot Linux on the HPS, enable bridges and map `0xff200000`.
3. Read the LiteX identifier and scratch CSR.
4. Write the scratch CSR and observe an FPGA LED.
5. Add one FPGA-to-HPS IRQ counter.

Only after this path is stable should the target instantiate the MiSTer carrier.

## Quartus Smoke Build

The smoke path intentionally separates "does Quartus accept the LiteX generated design" from
"does Linux on the HPS access the FPGA fabric". With Quartus in `PATH`, the base target can
be checked without generated HPS IP:

```sh
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --output-dir /tmp/litex_de10nano_hps_quartus_stub \
  --with-hps-stub
```

The same path can include a MiSTer manifest:

```sh
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --output-dir /tmp/litex_de10nano_hps_quartus_stub_template \
  --with-hps-stub --with-mister --core template
```

For hardware work, replace `--with-hps-stub` with the generated Platform Designer file:

```sh
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --output-dir build/de10nano_hps \
  --hps-ip path/to/cyclonev_hps_litex.qip
```

After the bitstream is built, follow `docs/linux-hps-bringup.md` for the Linux bridge and
CSR probe sequence.

## Project Integration

In this repository, `cyclonev-hps` should become a host bridge profile rather than a
core-specific target. The MiSTer wrapper should be the same wrapper used by softcore,
Zynq and PCIe builds:

```text
MiSTer emu core
  -> carrier services
  -> host bridge contract
  -> Cyclone V HPS / Zynq PS / PCIe / softcore transport
```

For Cyclone V specifically:

- `status` CSRs are driven by HPS writes over the lightweight bridge.
- input and OSD commands use CSRs first, then a command ring.
- video starts with direct DE10-Nano video output and then frame capture to HPS memory.
- storage starts with SD-SPI pass-through, then host-backed image blocks.
- DDRAM replacement should target LiteDRAM after control/video/storage are proven.

## Risks

- Reproducible HPS component generation must fit LiteX/Quartus flows.
- Linux bridge enablement and device-tree bindings need to be documented.
- AXI3 burst behavior and width conversion need simulation or hardware tests.
- Cache coherency for HPS DDR DMA must be explicit in the software API.
- Reset sequencing must avoid releasing the MiSTer core before HPS bridge clocks are valid.

## Upstream Sequence

1. Post the out-of-tree scratch-CSR prototype and link it to `litex#466`.
2. Upstream the minimal `cyclonev_hps` CPU class with lightweight bridge only.
3. Upstream a DE10-Nano HPS target with scratch CSR validation.
4. Add IRQ support.
5. Add optional full HPS-to-FPGA bridge.
6. Add optional FPGA-to-HPS DMA bridge.
7. Move this repository's `cyclonev-hps` host profile from design note to real target.

## References

- https://github.com/litex-hub/litex-boards/issues/63
- https://github.com/enjoy-digital/litex/issues/466
- https://github.com/enjoy-digital/litex/pull/2236
- https://github.com/enjoy-digital/litex/issues/2224
