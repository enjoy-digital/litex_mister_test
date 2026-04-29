# Linux HPS Bring-Up

This is the first hardware milestone once a real Platform Designer HPS wrapper exists:
prove that Linux on the Cyclone V HPS can read and write LiteX CSRs through the lightweight
HPS-to-FPGA bridge at `0xff200000`.

## Build The Bitstream

Generate the real HPS Platform Designer component first, then build with `--hps-ip`.
Keep the CSR CSV; the Linux probe uses it to avoid hardcoded offsets.

```sh
PATH=/opt/quartus_lite_23.1/quartus/bin:$PATH \
python3 terasic_de10nano_hps.py --build --no-compile-software \
  --output-dir build/de10nano_hps \
  --soc-csv build/de10nano_hps/csr.csv \
  --hps-ip path/to/cyclonev_hps_litex.qip
```

Do not use `--with-hps-stub` for this step. The stub only proves Quartus can compile the
fabric side.

## Program The FPGA

The exact command depends on the DE10-Nano Linux image. Common FPGA-manager based images use
`/sys/class/fpga_manager/fpga0/firmware` and firmware files copied under `/lib/firmware`.
Older images can expose a direct FPGA programming device instead. Use the flow already
validated for that image and program:

```text
build/de10nano_hps/gateware/terasic_de10nano.rbf
```

After programming, enable the lightweight HPS-to-FPGA bridge. On FPGA-bridge based Linux
images this is usually exposed under `/sys/class/fpga-bridge/`; names vary by kernel and
device tree, so check the directory on the board:

```sh
ls /sys/class/fpga-bridge
```

Enable the lightweight bridge entry, commonly named `lwhps2fpga`:

```sh
echo 1 > /sys/class/fpga-bridge/lwhps2fpga/enable
```

For early testing it is acceptable to enable all listed FPGA bridges after the bitstream is
loaded, provided the board image supports that policy.

## Probe The LiteX CSR

Copy this repository or just `tools/hps_csr_probe.py` and the generated `csr.csv` to the
HPS Linux system. Then run as root:

```sh
python3 tools/hps_csr_probe.py --csr-csv build/de10nano_hps/csr.csv
```

Expected result:

- `main_hps_scratch` resolves to `0xff201000`.
- `main_hps_status` resolves to `0xff201004`.
- A write to scratch reads back from scratch.
- Status mirrors scratch, since the target wires `hps_status` to `hps_scratch`.

For a read-only check:

```sh
python3 tools/hps_csr_probe.py --csr-csv build/de10nano_hps/csr.csv --read-only
```

For address verification without touching `/dev/mem`:

```sh
python3 tools/hps_csr_probe.py --csr-csv build/de10nano_hps/csr.csv --dry-run
```

## Troubleshooting

- If `/dev/mem` access faults or returns all ones/all zeroes, verify the FPGA is programmed
  and the lightweight bridge is enabled.
- If scratch changes but status does not mirror it, verify the CSR CSV matches the loaded
  bitstream.
- If the design does not build with `--hps-ip`, run `tools/check_cyclonev_hps_wrapper.py`
  on the generated wrapper and fix module or port-name mismatches.
- If Linux hangs on bridge access, re-check reset sequencing and the clock connected to
  the lightweight bridge.
