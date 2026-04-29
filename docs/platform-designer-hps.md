# Platform Designer HPS Wrapper

The LiteX `cyclonev_hps` prototype expects a generated Cyclone V HPS wrapper with a small,
stable ABI. This keeps the LiteX CPU class independent from generated vendor HDL while
still allowing Quartus to own the HPS component.

## Required Shape

Default module and prefix:

- module: `cyclonev_hps_litex`
- lightweight AXI prefix: `h2f_lw`

Both can be overridden in the target:

```sh
python3 terasic_de10nano_hps.py --hps-module-name <module> --hps-lw-prefix <prefix>
```

The wrapper must expose:

- `h2f_rst_n`
- `h2f_user0_clk`
- `f2h_cold_rst_req_n`
- `f2h_warm_rst_req_n`
- `f2h_dbg_rst_req_n`
- `f2h_pending_rst_ack`
- `f2h_irq[63:0]`
- `<prefix>_aclk`
- `<prefix>_areset_n`
- AXI3 lightweight HPS-to-FPGA master ports named `<prefix>_awvalid`,
  `<prefix>_awready`, `<prefix>_awaddr`, `<prefix>_wvalid`, and so on.

The exact required port list is encoded in:

```sh
python3 tools/check_cyclonev_hps_wrapper.py path/to/cyclonev_hps_litex.v
```

The checker also accepts simple `.qip`, `.sip` or `.qsys` files when it can find referenced
Verilog/SystemVerilog sources.

## Platform Designer Configuration

Start minimal:

1. Instantiate the Cyclone V HPS component.
2. Enable the lightweight HPS-to-FPGA AXI master.
3. Export the lightweight AXI master with the `h2f_lw` prefix.
4. Export the HPS reset and user clock pins listed above.
5. Export the FPGA-to-HPS IRQ vector.
6. Generate a `.qip` or wrapper Verilog file and pass it to `--hps-ip`.

Do not enable full HPS-to-FPGA or FPGA-to-HPS bridges for the first milestone. They are for
bulk transfers and DMA after the scratch CSR and IRQ paths are proven.

## Build

```sh
PATH=/opt/quartus_lite_23.1/quartus/bin:$PATH \
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --output-dir build/de10nano_hps \
  --soc-csv build/de10nano_hps/csr.csv \
  --hps-ip path/to/cyclonev_hps_litex.qip
```

If the generated module or lightweight prefix differs from the defaults:

```sh
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --hps-module-name <module> \
  --hps-lw-prefix <prefix> \
  --hps-ip path/to/generated.qip
```

## Upstream Constraint

Generated vendor HDL should not be committed to LiteX or this repository. The upstreamable
piece is the stable LiteX CPU/bridge class plus documentation describing how to generate the
HPS component.
