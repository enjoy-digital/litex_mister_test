#!/usr/bin/env python3

#
# This file is part of LiteX.
#
# Copyright (c) 2015-2020 Florent Kermarrec <florent@enjoy-digital.fr>
# Copyright (c) 2020 Antmicro <www.antmicro.com>
# Copyright (c) 2017 Pierre-Olivier Vauboin <po@lambdaconcept>
# Copyright (c) 2023 Victor Suarez Rovere <suarezvictor@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

import sys
import argparse

from migen import *

from litex.build.generic_platform import *
from litex.build.sim import SimPlatform
from litex.build.sim.config import SimConfig
from litex.build.vhd2v_converter import *

from litex.soc.interconnect.avalon import AvalonMM2Wishbone
from litex.soc.integration.common import *
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.integration.soc import *
from litex.soc.cores.bitbang import *
from litex.soc.cores.cpu import CPUS
from litex.soc.cores.video import VideoTimingGenerator, ColorBarsPattern

from litedram import modules as litedram_modules
from litedram.modules import parse_spd_hexdump
from litedram.phy.model import sdram_module_nphases, get_sdram_phy_settings
from litedram.phy.model import SDRAMPHYModel
from litex.soc.interconnect.avalon import AvalonMMInterface
from litedram.frontend.avalon import LiteDRAMAvalonMM2Native

from liteeth.common import *

from litex.soc.cores.video import VideoGenericPHY

from gateware.mister import MiSTeR
from gateware.vga_capture import VGACapture

# IOs ----------------------------------------------------------------------------------------------

_io = [
    # Clk / Rst.
    ("sys_clkin",    0, Pins(1)),
    ("sys_rst",      0, Pins(1)),
    ("emu_clkin",    0, Pins(1)),
    ("lowres_clkin", 0, Pins(1)),
    ("hdmi_clkin",   0, Pins(1)),

    # Serial.
    ("serial", 0,
        Subsignal("source_valid", Pins(1)),
        Subsignal("source_ready", Pins(1)),
        Subsignal("source_data",  Pins(8)),

        Subsignal("sink_valid",   Pins(1)),
        Subsignal("sink_ready",   Pins(1)),
        Subsignal("sink_data",    Pins(8)),
    ),

    # Video (VGA).
    ("vga", 0,
        Subsignal("clk",     Pins(1)),
        Subsignal("hsync",   Pins(1)),
        Subsignal("vsync",   Pins(1)),
        Subsignal("de",      Pins(1)),
        Subsignal("r",       Pins(8)),
        Subsignal("g",       Pins(8)),
        Subsignal("b",       Pins(8)),
    )
]

# Platform -----------------------------------------------------------------------------------------

class Platform(SimPlatform):
    def __init__(self):
        SimPlatform.__init__(self, "SIM", _io)

# CRG -----------------------------------------------------------------------------------------

class _CRG(Module):
    def __init__(self, platform):
        self.clock_domains.cd_sys    = ClockDomain()
        self.clock_domains.cd_por    = ClockDomain(reset_less=True)
        self.clock_domains.cd_emu    = ClockDomain()
        self.clock_domains.cd_lowres = ClockDomain()
        self.clock_domains.cd_hdmi   = ClockDomain()

        sys_clk = platform.request("sys_clkin")
        rst = 0

        # Power on Reset (vendor agnostic)
        int_rst = Signal(reset=1)
        self.sync.por += int_rst.eq(rst)

        self.comb += [
            self.cd_sys    .clk.eq(sys_clk),
            self.cd_sys    .rst.eq(int_rst),
            self.cd_por    .clk.eq(sys_clk),

            self.cd_emu    .clk.eq(platform.request("emu_clkin")),
            self.cd_lowres .clk.eq(platform.request("lowres_clkin")),
            self.cd_hdmi   .clk.eq(platform.request("hdmi_clkin")),
        ]

# Simulation SoC -----------------------------------------------------------------------------------

modes = {
    "lowres" : {
        "pix_clk"       : 5e6,
        "h_active"      : 320,
        "h_blanking"    : 80,
        "h_sync_offset" : 8,
        "h_sync_width"  : 32,
        "v_active"      : 200,
        "v_blanking"    : 15,
        "v_sync_offset" : 3,
        "v_sync_width"  : 6,
    },
    "midres" : {
        "pix_clk"          : 25e6,
        "h_active"         : 1024,
        "h_blanking"       : 80,
        "h_sync_offset"    : 8,
        "h_sync_width"     : 32,
        "h_sync_backporch" : 40,
        "v_active"         : 768,
        "v_blanking"       : 15,
        "v_sync_offset"    : 1,
        "v_sync_width"     : 8,
        "v_sync_backporch" : 6,
    },
    "highres": {
        "pix_clk"          : 100e6,
        "h_active"         : 1280,
        "h_blanking"       : 80,
        "h_sync_offset"    : 110,
        "h_sync_width"     : 40,
        "h_sync_backporch" : 220,
        "v_active"         : 720,
        "v_blanking"       : 34,
        "v_sync_offset"    : 5,
        "v_sync_width"     : 5,
        "v_sync_backporch" : 20,
    },
}

class SimSoC(SoCCore):
    def __init__(self,
        with_sdram            = False,
        with_sdram_bist       = False,
        sdram_module          = "MT48LC16M16",
        sdram_init            = [],
        sdram_data_width      = 128,
        sdram_spd_data        = None,
        sdram_verbosity       = 0,
        trace_reset_on        = False,
        mister_core           = "template",
        **kwargs):
        platform     = Platform()
        sys_clk_freq = int(100e6)

        # CRG --------------------------------------------------------------------------------------
        self.crg = _CRG(platform)

        # SoCCore ----------------------------------------------------------------------------------
        SoCCore.__init__(self, platform, clk_freq=sys_clk_freq,
            ident = "LiteX Simulation",
            **kwargs)

        # BIOS Config ------------------------------------------------------------------------------
        # FIXME: Expose?
        #self.add_config("BIOS_NO_PROMPT")
        #self.add_config("BIOS_NO_DELAYS")
        #self.add_config("BIOS_NO_BUILD_TIME")
        #self.add_config("BIOS_NO_CRC")

        # SDRAM ------------------------------------------------------------------------------------
        sdram_clk_freq = int(100e6) # FIXME: use 100MHz timings
        if sdram_spd_data is None:
            sdram_module_cls = getattr(litedram_modules, sdram_module)
            sdram_rate       = "1:{}".format(sdram_module_nphases[sdram_module_cls.memtype])
            sdram_module     = sdram_module_cls(sdram_clk_freq, sdram_rate)
        else:
            sdram_module = litedram_modules.SDRAMModule.from_spd_data(sdram_spd_data, sdram_clk_freq)
        self.sdrphy = SDRAMPHYModel(
            module     = sdram_module,
            data_width = sdram_data_width,
            clk_freq   = sdram_clk_freq,
            verbosity  = sdram_verbosity,
            init       = sdram_init)
        self.add_sdram("sdram",
            phy                     = self.sdrphy,
            module                  = sdram_module,
            l2_cache_size           = 0,
            l2_cache_min_data_width = 0,
            l2_cache_reverse        = False,
            with_bist               = 0
        )

        self.add_constant("SDRAM_TEST_DISABLE")

        # ascal can't take more than 28 bits of address width
        avalon_data_width = 64
        avalon_address_width = 28

        scaler_ddram_port  = self.sdram.crossbar.get_port(data_width=avalon_data_width)
        self.scaler_ddram = scaler_ddram   = AvalonMMInterface(data_width=avalon_data_width, adr_width=avalon_address_width)
        self.submodules.scaler_avalon_port = LiteDRAMAvalonMM2Native(scaler_ddram, scaler_ddram_port)

        # MiSTeR -----------------------------------------------------------------------------------
        source_r  = Signal(8)
        source_g  = Signal(8)
        source_b  = Signal(8)
        source_hs = Signal()
        source_vs = Signal()
        source_de = Signal()

        test_pattern = True
        if test_pattern:
            # Video Timing Generator.
            vtg = VideoTimingGenerator(default_video_timings=modes["lowres"])
            vtg = ClockDomainsRenamer("lowres")(vtg)
            self.add_module(name="vtg", module=vtg)

            # ColorsBars Pattern.
            colorbars = ClockDomainsRenamer("lowres")(ColorBarsPattern())
            self.add_module(name="colorbars", module=colorbars)

            # Connect Video Timing Generator to ColorsBars Pattern.
            self.comb += [
                vtg.source.connect(colorbars.vtg_sink),
                colorbars.source.ready.eq(1),

                source_r        .eq(colorbars.source.r),
                source_g        .eq(colorbars.source.g),
                source_b        .eq(colorbars.source.b),
                source_hs       .eq(colorbars.source.hsync),
                source_vs       .eq(colorbars.source.vsync),
                source_de       .eq(colorbars.source.de),
            ]
        else:
            self.mister = mister = MiSTeR(platform, core=mister_core)
            #self.mister = mister = MiSTeR(platform, core="memtest")
            self.mister.add_control_status_csr()
            self.comb += [
                source_r    .eq(mister.vga.r[::-1]),
                source_g    .eq(mister.vga.g[::-1]),
                source_b    .eq(mister.vga.b[::-1]),
                source_hs   .eq(mister.vga.hsync_n),
                source_vs   .eq(mister.vga.vsync_n),
                source_de   .eq(mister.vga.de),
            ]

        self.submodules.ascal = VHD2VConverter(platform,
            top_entity    = "ascal",
            build_dir     = os.path.abspath(os.path.dirname(__file__)),
            force_convert = True,
            files = ['ascal.vhd'],
            params = dict(
                p_RAMBASE = 0x0,
                p_PALETTE2 = "false",
                p_N_AW    = avalon_address_width,
                p_N_DW    = avalon_data_width,
                p_N_BURST = 64
            )
        )

        mode    = modes["midres"]
        WIDTH   = mode['h_active']
        HFP     = mode['h_sync_offset']
        HS      = mode['h_sync_width']
        HBP     = mode['h_sync_backporch']
        HEIGHT  = mode['v_active']
        VFP     = mode['v_sync_offset']
        VS      = mode['v_sync_width']
        VBP     = mode['v_sync_backporch']
        HDMI_PR = 0

        vga_out_r  = Signal(8)
        vga_out_g  = Signal(8)
        vga_out_b  = Signal(8)
        vga_out_hs = Signal()
        vga_out_vs = Signal()
        vga_out_de = Signal()

        self.specials += Instance("ascal",
            i_reset_na = 1,
            i_run      = 1,
            i_freeze   = 0,
            i_iauto    = 1,
        	i_himin    = 0,
        	i_himax    = 0,
        	i_vimin    = 0,
        	i_vimax    = 0,

            # video input
            i_i_r   = source_r, # 0x0,
            i_i_g   = source_g, # 0x0,
            i_i_b   = source_b, # 0x0,
            i_i_hs  = source_hs,
            i_i_vs  = source_vs,
            i_i_de  = source_de,
            i_i_fl  = 0,
            i_i_ce  = 1,
            i_i_clk = ClockSignal("lowres"),

            # video output
            o_o_r   = vga_out_r,
            o_o_g   = vga_out_g,
            o_o_b   = vga_out_b,
            o_o_hs  = vga_out_hs,
            o_o_vs  = vga_out_vs,
            o_o_de  = vga_out_de,
            o_o_vbl = Open(),
            o_o_brd = Open(),
            i_o_ce  = 1,
            i_o_clk = ClockSignal("hdmi"),

            o_o_lltune = Open(),

            # operational parameters
	        i_htotal   = WIDTH + HFP + HBP + HS,
	        i_hsstart  = WIDTH + HFP,
	        i_hsend    = WIDTH + HFP + HS,
	        i_hdisp    = WIDTH,
	        i_hmin     = 0,      # TODO: What should go here?
	        i_hmax     = WIDTH,  # TODO: What should go here?
	        i_vtotal   = HEIGHT + VFP + VBP + VS,
	        i_vsstart  = HEIGHT + VFP,
	        i_vsend    = HEIGHT + VFP + VS,
	        i_vdisp    = HEIGHT,
	        i_vmin     = 0,       # TODO: What should go here?
	        i_vmax     = HEIGHT,  # TODO: What should go here?
	        i_vrr      = 0,       #
	        i_vrrmax   = HEIGHT + VBP + VS + 1,

            i_mode     = Constant(0, 4),

            # polyphase filter coefficients
            i_poly_clk = ClockSignal("hdmi"),
            i_poly_a   = 0,
            i_poly_dw  = 0,
            i_poly_wr  = 0,

            # i_pal1_clk = ClockSignal(),
            # i_pal1_dw  = 0,
            # i_pal1_a   = 0,
            # i_pal1_wr  = 0,

            # avalon interface

            i_avl_clk           = ClockSignal(),
            i_avl_waitrequest   = scaler_ddram.waitrequest,
            i_avl_readdata      = scaler_ddram.readdata,
            i_avl_readdatavalid = scaler_ddram.readdatavalid,
            o_avl_burstcount    = scaler_ddram.burstcount,
            o_avl_writedata     = scaler_ddram.writedata,
            o_avl_address       = scaler_ddram.address,
            o_avl_write         = scaler_ddram.write,
            o_avl_read          = scaler_ddram.read,
            o_avl_byteenable    = scaler_ddram.byteenable,
        )

        # Video ------------------------------------------------------------------------------------
        vga_pads = platform.request("vga")
        self.comb += [
            vga_pads.clk.eq(ClockSignal("hdmi")),
            vga_pads.r.eq(vga_out_r),
            vga_pads.g.eq(vga_out_g),
            vga_pads.b.eq(vga_out_b),
            vga_pads.hsync.eq(vga_out_hs),
            vga_pads.vsync.eq(vga_out_vs),
            vga_pads.de.eq(vga_out_de),
        ]

        # Simulation debugging ----------------------------------------------------------------------
        platform.add_debug(self, reset=1 if trace_reset_on else 0)

# Build --------------------------------------------------------------------------------------------

def generate_gtkw_savefile(builder, vns, trace_fst):
    from litex.build.sim import gtkwave as gtkw
    dumpfile = os.path.join(builder.gateware_dir, "sim.{}".format("fst" if trace_fst else "vcd"))
    savefile = os.path.join(builder.gateware_dir, "sim.gtkw")
    soc = builder.soc

    with gtkw.GTKWSave(vns, savefile=savefile, dumpfile=dumpfile) as save:
        save.clocks()
        save.fsm_states(soc)
        if "main_ram" in soc.bus.slaves.keys():
            save.add(soc.bus.slaves["main_ram"], mappers=[gtkw.wishbone_sorter(), gtkw.wishbone_colorer()])

        if hasattr(soc, "sdrphy"):
            # all dfi signals
            save.add(soc.sdrphy.dfi, mappers=[gtkw.dfi_sorter(), gtkw.dfi_in_phase_colorer()])

            # each phase in separate group
            with save.gtkw.group("dfi phaseX", closed=True):
                for i, phase in enumerate(soc.sdrphy.dfi.phases):
                    save.add(phase, group_name="dfi p{}".format(i), mappers=[
                        gtkw.dfi_sorter(phases=False),
                        gtkw.dfi_in_phase_colorer(),
                    ])

            # only dfi command/data signals
            def dfi_group(name, suffixes):
                save.add(soc.sdrphy.dfi, group_name=name, mappers=[
                    gtkw.regex_filter(gtkw.suffixes2re(suffixes)),
                    gtkw.dfi_sorter(),
                    gtkw.dfi_per_phase_colorer(),
                ])

            dfi_group("dfi commands", ["cas_n", "ras_n", "we_n"])
            dfi_group("dfi commands", ["wrdata"])
            dfi_group("dfi commands", ["wrdata_mask"])
            dfi_group("dfi commands", ["rddata"])

def sim_args(parser):
    # ROM / RAM.
    parser.add_argument("--rom-init",               default=None,            help="ROM init file (.bin or .json).")
    parser.add_argument("--ram-init",               default=None,            help="RAM init file (.bin or .json).")
    parser.add_argument("--sdram-init",             default=None,            help="RAM init file (.bin or .json).")

    # Debug/Waveform.
    parser.add_argument("--gtkwave-savefile",     action="store_true",     help="Generate GTKWave savefile.")
    parser.add_argument("--non-interactive",      action="store_true",     help="Run simulation without user input.")

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(description="LiteX SoC Simulation utility")
    parser.set_platform(SimPlatform)
    parser.add_target_argument("--core",            default="template",  help="MiSTeR core.")
    sim_args(parser)
    args = parser.parse_args()

    soc_kwargs = soc_core_argdict(args)

    sim_config   = SimConfig()
    sim_config.add_clocker("sys_clkin",    freq_hz=int(100e6))
    sim_config.add_clocker("lowres_clkin", freq_hz=int(5e6))
    sim_config.add_clocker("hdmi_clkin",   freq_hz=int(25e6))
    sim_config.add_clocker("emu_clkin",    freq_hz=int(50e6))

    # Configuration --------------------------------------------------------------------------------

    # UART.
    if soc_kwargs["uart_name"] == "serial":
        soc_kwargs["uart_name"] = "sim"
        #sim_config.add_module("serial2console", "serial", clocks="sys_clkin")

    # Create config SoC that will be used to prepare/configure real one.
    conf_soc = SimSoC(**soc_kwargs)

    # ROM.
    if args.rom_init:
        soc_kwargs["integrated_rom_init"] = get_mem_data(args.rom_init,
            data_width = conf_soc.bus.data_width,
            endianness = conf_soc.cpu.endianness
        )

    # RAM / SDRAM.
    ram_boot_address = None
    soc_kwargs["integrated_main_ram_size"] = args.integrated_main_ram_size
    if args.integrated_main_ram_size:
        if args.ram_init is not None:
            soc_kwargs["integrated_main_ram_init"] = get_mem_data(args.ram_init,
                data_width = conf_soc.bus.data_width,
                endianness = conf_soc.cpu.endianness,
                offset     = conf_soc.mem_map["main_ram"]
            )
            ram_boot_address = get_boot_address(args.ram_init)
    else:
        assert args.ram_init is None
        if args.sdram_init is not None:
            soc_kwargs["sdram_init"] = get_mem_data(args.sdram_init,
                data_width = conf_soc.bus.data_width,
                endianness = conf_soc.cpu.endianness,
                offset     = conf_soc.mem_map["main_ram"]
            )
            ram_boot_address = get_boot_address(args.sdram_init)

    # Video.
    sim_config.add_module("video", "vga", clocks="hdmi_clkin")

    # SoC ------------------------------------------------------------------------------------------
    soc = SimSoC(
        trace_reset_on        = int(float(args.trace_start)) > 0 or int(float(args.trace_end)) > 0,
        mister_core           = args.core,
        **soc_kwargs)
    if ram_boot_address is not None:
        if ram_boot_address == 0:
            ram_boot_address = conf_soc.mem_map["main_ram"]
        soc.add_constant("ROM_BOOT_ADDRESS", ram_boot_address)

    # Build/Run ------------------------------------------------------------------------------------
    def pre_run_callback(vns):
        if args.trace and False:
            generate_gtkw_savefile(builder, vns, args.trace_fst)

    builder = Builder(soc, **parser.builder_argdict)
    builder.build(
        sim_config       = sim_config,
        interactive      = not args.non_interactive,
        video            = True,
        pre_run_callback = pre_run_callback,
        **parser.toolchain_argdict,
    )

if __name__ == "__main__":
    main()
