#!/usr/bin/env python3

#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *

from litex.gen import *

from litex_boards.platforms import terasic_de10nano

from litex.soc.cores.clock import CycloneVPLL
from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.interconnect.csr import *

from gateware.mister import MiSTeR

# CRG ----------------------------------------------------------------------------------------------

class _CRG(LiteXModule):
    def __init__(self, platform, sys_clk_freq):
        self.rst    = Signal()
        self.cd_sys = ClockDomain()
        self.cd_emu = ClockDomain()

        clk50 = platform.request("clk50")

        self.pll = pll = CycloneVPLL(speedgrade="-I7")
        self.comb += pll.reset.eq(self.rst)
        pll.register_clkin(clk50, 50e6)
        pll.create_clkout(self.cd_sys, sys_clk_freq)
        pll.create_clkout(self.cd_emu, 50e6)

# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self, sys_clk_freq=50e6,
        hps_module_name = "cyclonev_hps_litex",
        hps_lw_prefix   = "h2f_lw",
        hps_ip          = None,
        hps_ddr_size    = 0x4000_0000,
        with_mister     = False,
        mister_core     = "template",
        **kwargs):
        platform = terasic_de10nano.Platform()

        # The HPS/Linux host owns boot and console. LiteX exposes CSRs behind the HPS bridge.
        if kwargs.get("cpu_type", None) == "cyclonev_hps":
            kwargs["integrated_rom_size"]  = 0
            kwargs["integrated_sram_size"] = 0
            kwargs["with_uart"]            = False

        self.crg = _CRG(platform, sys_clk_freq)

        SoCCore.__init__(self, platform, sys_clk_freq,
            ident = "LiteX Cyclone V HPS bridge on DE10-Nano",
            **kwargs)

        if self.cpu_type == "cyclonev_hps":
            self.cpu.set_hps_component(
                module_name   = hps_module_name,
                h2f_lw_prefix = hps_lw_prefix,
                ip_files      = hps_ip or [],
            )
            self.bus.add_region("sram", SoCRegion(
                origin = self.cpu.mem_map["sram"],
                size   = hps_ddr_size,
            ))

        # Scratch CSR for the first Linux-side bridge validation.
        self.hps_scratch = CSRStorage(32, reset=0x5ca62300)
        self.hps_status  = CSRStatus(32)

        leds = platform.request_all("user_led")
        for n, led in enumerate(leds):
            self.comb += led.eq(self.hps_scratch.storage[n])
        self.comb += self.hps_status.status.eq(self.hps_scratch.storage)

        if with_mister:
            self.mister = mister = MiSTeR(platform, core=mister_core)
            mister.add_control_status_csr()
            self.comb += [
                mister.clk_audio.eq(ClockSignal("emu")),
                mister.osd_status.eq(self.hps_scratch.storage[8]),
            ]

# Build --------------------------------------------------------------------------------------------

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(platform=terasic_de10nano.Platform, description="LiteX Cyclone V HPS bridge on DE10-Nano.")
    parser.add_target_argument("--sys-clk-freq",   default=50e6, type=float, help="System clock frequency.")
    parser.add_target_argument("--hps-module-name", default="cyclonev_hps_litex", help="Generated HPS wrapper module name.")
    parser.add_target_argument("--hps-lw-prefix",   default="h2f_lw",             help="Lightweight HPS-to-FPGA AXI port prefix.")
    parser.add_target_argument("--hps-ip",          action="append", default=[],  help="Generated HPS .qsys/.qip/.sip file to add to Quartus.")
    parser.add_target_argument("--hps-ddr-size",    default=0x4000_0000, type=lambda v: int(v, 0),
        help="HPS DDR size exposed in the LiteX memory map.")
    parser.add_target_argument("--with-mister",     action="store_true",          help="Instantiate the manifest-driven MiSTer carrier.")
    parser.add_target_argument("--core",            default="template",           help="MiSTer core manifest to instantiate.")
    parser.set_defaults(cpu_type="cyclonev_hps")
    parser.set_defaults(no_uart=True)
    parser.set_defaults(integrated_rom_size=0)
    parser.set_defaults(integrated_sram_size=0)
    args = parser.parse_args()

    soc = BaseSoC(
        sys_clk_freq    = args.sys_clk_freq,
        hps_module_name = args.hps_module_name,
        hps_lw_prefix   = args.hps_lw_prefix,
        hps_ip          = args.hps_ip,
        hps_ddr_size    = args.hps_ddr_size,
        with_mister     = args.with_mister,
        mister_core     = args.core,
        **parser.soc_argdict
    )
    builder = Builder(soc, **parser.builder_argdict)
    if args.build:
        builder.build(**parser.toolchain_argdict)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(builder.get_bitstream_filename(mode="sram"))

if __name__ == "__main__":
    main()
