#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from dataclasses import dataclass


@dataclass(frozen=True)
class HostBridgeProfile:
    name: str
    family: str
    control_plane: str
    bulk_plane: str
    interrupts: str
    clock_reset: str
    upstream_status: str
    first_milestone: str


_PROFILES = (
    HostBridgeProfile(
        name="softcore",
        family="litex",
        control_plane="Native LiteX Wishbone/CSR bus.",
        bulk_plane="LiteDRAM or integrated RAM, with optional Wishbone DMA.",
        interrupts="LiteX EventManager IRQs to the soft CPU.",
        clock_reset="LiteX CRG owns sys/emu/video domains.",
        upstream_status="Already supported by LiteX.",
        first_milestone="Keep simulation and FPGA smoke targets working.",
    ),
    HostBridgeProfile(
        name="zynq",
        family="xilinx",
        control_plane="PS AXI GP master mapped to the LiteX CSR/Wishbone bus.",
        bulk_plane="PS HP/HPC slave ports for frame, audio and storage DMA buffers.",
        interrupts="Fabric-to-PS IRQ lines exposed by the zynq7000/zynqmp CPU cores.",
        clock_reset="PS FCLK can drive sys, or board PLL can drive independent domains.",
        upstream_status="LiteX already has zynq7000 and zynqmp hard CPU classes.",
        first_milestone="Instantiate MiSTeR carrier behind PS GP0 and toggle status CSRs from PS software.",
    ),
    HostBridgeProfile(
        name="cyclonev-hps",
        family="intel",
        control_plane="Lightweight HPS-to-FPGA AXI3 master window at 0xff200000 for LiteX CSRs.",
        bulk_plane="HPS-to-FPGA full bridge for fabric buffers, FPGA-to-HPS bridge for DMA into HPS DDR.",
        interrupts="FPGA-to-HPS interrupt lines from the HPS component.",
        clock_reset="FPGA fabric clocks feed the bridge clocks; HPS reset release must be sequenced.",
        upstream_status="Missing in LiteX today; needs a cyclonev_hps hard CPU/bridge class.",
        first_milestone="Expose a LiteX scratch CSR over the lightweight bridge on DE10-Nano Linux.",
    ),
    HostBridgeProfile(
        name="pcie",
        family="pcie",
        control_plane="LitePCIe BAR0 Wishbone master mapped to LiteX CSRs.",
        bulk_plane="LitePCIe DMA rings for video frames, audio samples and storage blocks.",
        interrupts="MSI/MSI-X events through LitePCIe.",
        clock_reset="PCIe PHY clock/reset plus LiteX-generated user domains.",
        upstream_status="LitePCIe already provides BAR, Wishbone and DMA frontends.",
        first_milestone="Capture video into a host DMA ring before attempting direct display output.",
    ),
)

_ALIASES = {
    "litex":      "softcore",
    "uartbone":  "softcore",
    "etherbone": "softcore",
    "zynq7000":  "zynq",
    "zynqmp":    "zynq",
    "cyclonev":  "cyclonev-hps",
    "de10nano":  "cyclonev-hps",
    "m2":        "pcie",
    "litepcie":  "pcie",
}


def iter_host_bridge_profiles():
    return _PROFILES


def get_host_bridge_profile(name):
    key = name.lower()
    key = _ALIASES.get(key, key)
    for profile in _PROFILES:
        if profile.name == key:
            return profile
    available = ", ".join(profile.name for profile in _PROFILES)
    raise ValueError(f"Unknown host bridge profile '{name}'. Available profiles: {available}")
