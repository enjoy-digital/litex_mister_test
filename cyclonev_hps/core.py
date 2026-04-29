#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from pathlib import Path

from migen import *
from migen.genlib.resetsync import AsyncResetSynchronizer

from litex.gen import *
from litex.soc.cores.cpu import CPU
from litex.soc.interconnect import axi


# Cyclone V HPS ------------------------------------------------------------------------------------

class CycloneVHPS(CPU):
    variants                 = ["standard"]
    category                 = "hardcore"
    family                   = "arm"
    name                     = "cyclonev_hps"
    human_name               = "Cyclone V HPS"
    data_width               = 32
    endianness               = "little"
    reset_address            = 0x0000_0000
    gcc_triple               = "arm-none-eabi"
    gcc_flags                = "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard"
    linker_output_format     = "elf32-littlearm"
    nop                      = "nop"
    io_regions               = {0xc000_0000: 0x4000_0000}
    csr_decode               = True
    integrated_rom_supported = False

    @property
    def mem_map(self):
        return {
            "sram": 0x0000_0000,  # HPS DDR from the HPS point of view.
            "csr":  0xff20_0000,  # Lightweight HPS-to-FPGA bridge window.
            "rom":  0x0000_0000,  # Not used by the Linux-hosted HPS flow.
        }

    def __init__(self, platform, variant, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.platform     = platform
        self.reset        = Signal()
        self.periph_buses = []
        self.memory_buses = []
        self.interrupts   = {}

        self.hps_module_name = "cyclonev_hps_litex"
        self.hps_ip_files    = []
        self.h2f_lw_prefix   = "h2f_lw"

        self.interrupt = Signal(64)
        self.h2f_rst_n = Signal(reset=1)
        self.cd_hps    = ClockDomain()

        self.lw_h2f = axi.AXIInterface(
            data_width    = 32,
            address_width = 32,
            id_width      = 12,
            version       = "axi3",
            clock_domain  = "sys",
        )
        self.periph_buses.append(self.lw_h2f)

        self.specials += AsyncResetSynchronizer(self.cd_hps, ~self.h2f_rst_n)

    def set_reset_address(self, reset_address):
        self.reset_address = reset_address

    def set_hps_component(self, module_name=None, h2f_lw_prefix=None, ip_files=None):
        if module_name is not None:
            self.hps_module_name = module_name
        if h2f_lw_prefix is not None:
            self.h2f_lw_prefix = h2f_lw_prefix
        if ip_files is not None:
            self.hps_ip_files = [str(Path(filename)) for filename in ip_files]

    def add_hps_ip(self, filename):
        self.hps_ip_files.append(str(Path(filename)))

    def do_finalize(self):
        for filename in self.hps_ip_files:
            if hasattr(self.platform, "add_ip"):
                self.platform.add_ip(filename)
            else:
                self.platform.add_source(filename)

        self.cpu_params = dict(
            # HPS clocks/resets exported by the wrapper.
            o_h2f_rst_n           = self.h2f_rst_n,
            o_h2f_user0_clk       = ClockSignal("hps"),
            i_f2h_cold_rst_req_n  = ~self.reset,
            i_f2h_warm_rst_req_n  = ~self.reset,
            i_f2h_dbg_rst_req_n   = 1,
            i_f2h_pending_rst_ack = 1,

            # FPGA-to-HPS interrupts.
            i_f2h_irq             = self.interrupt,
        )
        self.cpu_params.update(_axi3_master_params(self.h2f_lw_prefix, self.lw_h2f))
        self.specials += Instance(self.hps_module_name, **self.cpu_params)


def _axi3_master_params(prefix, bus):
    # Port ABI expected from the generated Platform Designer wrapper:
    # <prefix>_aclk, <prefix>_areset_n and lower-case AXI3 channel names.
    params = {
        f"i_{prefix}_aclk"     : ClockSignal(bus.clock_domain),
        f"i_{prefix}_areset_n" : ~ResetSignal(bus.clock_domain),
    }

    params.update({
        f"o_{prefix}_awvalid" : bus.aw.valid,
        f"i_{prefix}_awready" : bus.aw.ready,
        f"o_{prefix}_awid"    : bus.aw.id,
        f"o_{prefix}_awaddr"  : bus.aw.addr,
        f"o_{prefix}_awlen"   : bus.aw.len,
        f"o_{prefix}_awsize"  : bus.aw.size,
        f"o_{prefix}_awburst" : bus.aw.burst,
        f"o_{prefix}_awlock"  : bus.aw.lock,
        f"o_{prefix}_awcache" : bus.aw.cache,
        f"o_{prefix}_awprot"  : bus.aw.prot,
        f"o_{prefix}_awqos"   : bus.aw.qos,

        f"o_{prefix}_wvalid"  : bus.w.valid,
        f"i_{prefix}_wready"  : bus.w.ready,
        f"o_{prefix}_wid"     : bus.w.id,
        f"o_{prefix}_wdata"   : bus.w.data,
        f"o_{prefix}_wstrb"   : bus.w.strb,
        f"o_{prefix}_wlast"   : bus.w.last,

        f"i_{prefix}_bvalid"  : bus.b.valid,
        f"o_{prefix}_bready"  : bus.b.ready,
        f"i_{prefix}_bid"     : bus.b.id,
        f"i_{prefix}_bresp"   : bus.b.resp,

        f"o_{prefix}_arvalid" : bus.ar.valid,
        f"i_{prefix}_arready" : bus.ar.ready,
        f"o_{prefix}_arid"    : bus.ar.id,
        f"o_{prefix}_araddr"  : bus.ar.addr,
        f"o_{prefix}_arlen"   : bus.ar.len,
        f"o_{prefix}_arsize"  : bus.ar.size,
        f"o_{prefix}_arburst" : bus.ar.burst,
        f"o_{prefix}_arlock"  : bus.ar.lock,
        f"o_{prefix}_arcache" : bus.ar.cache,
        f"o_{prefix}_arprot"  : bus.ar.prot,
        f"o_{prefix}_arqos"   : bus.ar.qos,

        f"i_{prefix}_rvalid"  : bus.r.valid,
        f"o_{prefix}_rready"  : bus.r.ready,
        f"i_{prefix}_rid"     : bus.r.id,
        f"i_{prefix}_rdata"   : bus.r.data,
        f"i_{prefix}_rresp"   : bus.r.resp,
        f"i_{prefix}_rlast"   : bus.r.last,
    })
    return params
