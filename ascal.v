module ascal
  (input  [7:0] i_r,
   input  [7:0] i_g,
   input  [7:0] i_b,
   input  i_hs,
   input  i_vs,
   input  i_fl,
   input  i_de,
   input  i_ce,
   input  i_clk,
   input  o_ce,
   input  o_clk,
   input  [23:0] o_border,
   input  o_fb_ena,
   input  [11:0] o_fb_hsize,
   input  [11:0] o_fb_vsize,
   input  [5:0] o_fb_format,
   input  [31:0] o_fb_base,
   input  [13:0] o_fb_stride,
   input  pal1_clk,
   input  [47:0] pal1_dw,
   input  [6:0] pal1_a,
   input  pal1_wr,
   input  pal_n,
   input  pal2_clk,
   input  [23:0] pal2_dw,
   input  [7:0] pal2_a,
   input  pal2_wr,
   input  iauto,
   input  [11:0] himin,
   input  [11:0] himax,
   input  [11:0] vimin,
   input  [11:0] vimax,
   input  run,
   input  freeze,
   input  [4:0] mode,
   input  [11:0] htotal,
   input  [11:0] hsstart,
   input  [11:0] hsend,
   input  [11:0] hdisp,
   input  [11:0] hmin,
   input  [11:0] hmax,
   input  [11:0] vtotal,
   input  [11:0] vsstart,
   input  [11:0] vsend,
   input  [11:0] vdisp,
   input  [11:0] vmin,
   input  [11:0] vmax,
   input  vrr,
   input  [11:0] vrrmax,
   input  [1:0] format,
   input  poly_clk,
   input  [9:0] poly_dw,
   input  [7:0] poly_a,
   input  poly_wr,
   input  avl_clk,
   input  avl_waitrequest,
   input  [127:0] avl_readdata,
   input  avl_readdatavalid,
   input  reset_na,
   output [7:0] o_r,
   output [7:0] o_g,
   output [7:0] o_b,
   output o_hs,
   output o_vs,
   output o_de,
   output o_vbl,
   output o_brd,
   output [47:0] pal1_dr,
   output [23:0] pal2_dr,
   output [15:0] o_lltune,
   output [11:0] i_hdmax,
   output [11:0] i_vdmax,
   output [7:0] avl_burstcount,
   output [127:0] avl_writedata,
   output [27:0] avl_address,
   output avl_write,
   output avl_read,
   output [15:0] avl_byteenable);
  wire i_pvs;
  wire i_pfl;
  wire i_pde;
  wire i_pce;
  wire [23:0] i_ppix;
  wire i_freeze;
  wire [2:0] i_count;
  wire [11:0] i_hsize;
  wire [11:0] i_hmin;
  wire [11:0] i_hmax;
  wire [11:0] i_hcpt;
  wire [11:0] i_hrsize;
  wire [11:0] i_vrsize;
  wire [11:0] i_himax;
  wire [11:0] i_vimax;
  wire [11:0] i_vsize;
  wire [11:0] i_vmaxmin;
  wire [11:0] i_vmin;
  wire [11:0] i_vmax;
  wire [11:0] i_vcpt;
  wire i_iauto;
  wire [4:0] i_mode;
  wire [1:0] i_format;
  wire i_ven;
  wire i_sof;
  wire i_wr;
  wire i_divstart;
  wire i_divrun;
  wire i_de_pre;
  wire i_vs_pre;
  wire i_fl_pre;
  wire [4:0] i_de_delay;
  wire [1:0] i_intercnt;
  wire i_inter;
  wire i_half;
  wire i_flm;
  wire i_write;
  wire i_wreq;
  wire i_alt;
  wire i_line;
  wire i_wline;
  wire i_wline_mem;
  wire i_walt;
  wire i_walt_mem;
  wire i_wreq_mem;
  wire [2:0] i_wdelay;
  wire i_push;
  wire i_pushend;
  wire i_pushend2;
  wire i_eol;
  wire i_pushhead;
  wire i_pushhead2;
  wire i_pushhead3;
  wire [4:0] i_hburst;
  wire [4:0] i_hbcpt;
  reg [119:0] i_shift;
  wire [127:0] i_head;
  wire [3:0] i_acpt;
  wire i_endframe0;
  wire i_endframe1;
  wire i_vss;
  wire [4:0] i_wad;
  wire [127:0] i_dw;
  wire [31:0] i_adrs;
  wire [31:0] i_adrsi;
  wire [31:0] i_wadrs;
  wire [31:0] i_wadrs_mem;
  wire i_reset_na;
  wire i_hnp;
  wire i_vnp;
  wire [11:0] i_ohsize;
  wire [11:0] i_ovsize;
  wire [12:0] i_vdivi;
  wire [24:0] i_vdivr;
  wire [16:0] i_div;
  wire [11:0] i_dir;
  wire [11:0] i_h_frac;
  wire [11:0] i_v_frac;
  wire [12:0] i_hacc;
  wire [12:0] i_vacc;
  wire i_hdown;
  wire i_vdown;
  wire [5:0] i_divcpt;
  wire [10:0] i_lwad;
  wire [10:0] i_lrad;
  wire i_lwr;
  wire i_bil;
  wire [23:0] i_ldw;
  wire [23:0] i_ldrm;
  wire [23:0] i_hpixp;
  wire [23:0] i_hpix0;
  wire [23:0] i_hpix1;
  wire [23:0] i_hpix2;
  wire [23:0] i_hpix3;
  wire [23:0] i_hpix4;
  wire [23:0] i_hpix;
  wire [23:0] i_pix;
  wire i_hnp1;
  wire i_hnp2;
  wire i_hnp3;
  wire i_hnp4;
  wire i_ven1;
  wire i_ven2;
  wire i_ven3;
  wire i_ven4;
  wire i_ven5;
  wire i_ven6;
  wire [1:0] avl_state;
  wire avl_write_i;
  wire avl_write_sync;
  wire avl_write_sync2;
  wire avl_read_i;
  wire avl_read_sync;
  wire avl_read_sync2;
  wire avl_read_pulse;
  wire avl_write_pulse;
  wire avl_read_sr;
  wire avl_write_sr;
  wire avl_read_clr;
  wire avl_write_clr;
  wire [4:0] avl_rad;
  wire [4:0] avl_rad_c;
  wire [4:0] avl_wad;
  wire avl_walt;
  wire avl_wline;
  wire avl_rline;
  wire [127:0] avl_dw;
  wire [127:0] avl_dr;
  wire avl_wr;
  wire avl_readdataack;
  wire avl_readack;
  wire [31:0] avl_radrs;
  wire [31:0] avl_wadrs;
  wire [31:0] avl_i_offset0;
  wire [31:0] avl_o_offset0;
  wire [31:0] avl_i_offset1;
  wire [31:0] avl_o_offset1;
  wire avl_reset_na;
  wire avl_o_vs_sync;
  wire avl_o_vs;
  wire avl_fb_ena;
  wire o_run;
  wire o_freeze;
  wire [4:0] o_mode;
  wire [4:0] o_hmode;
  wire [4:0] o_vmode;
  wire [5:0] o_format;
  wire [23:0] o_fb_pal_dr;
  wire [23:0] o_fb_pal_dr2;
  wire [47:0] o_fb_pal_dr_x2;
  wire [7:0] pal_idx;
  wire pal_idx_lsb;
  wire [11:0] o_htotal;
  wire [11:0] o_hsstart;
  wire [11:0] o_hsend;
  wire [11:0] o_hmin;
  wire [11:0] o_hmax;
  wire [11:0] o_hdisp;
  wire [11:0] o_v_hmin_adj;
  wire [11:0] o_hsize;
  wire [11:0] o_vsize;
  wire [11:0] o_vtotal;
  wire [11:0] o_vsstart;
  wire [11:0] o_vsend;
  wire o_vrr;
  wire o_isync;
  wire o_isync2;
  wire o_vrr_sync;
  wire o_vrr_sync2;
  wire o_vrr_min;
  wire o_vrr_min2;
  wire o_vrr_max;
  wire o_vrr_max2;
  wire [11:0] o_vcpt_sync;
  wire [11:0] o_vcpt_sync2;
  wire [11:0] o_vrrmax;
  wire o_sync;
  wire o_sync_max;
  wire [11:0] o_vmin;
  wire [11:0] o_vmax;
  wire [11:0] o_vdisp;
  wire [5:0] o_divcpt;
  wire o_iendframe0;
  wire o_iendframe02;
  wire o_iendframe1;
  wire o_iendframe12;
  wire o_bufup0;
  wire o_bufup1;
  wire o_inter;
  wire [1:0] o_ibuf0;
  wire [1:0] o_ibuf1;
  wire [1:0] o_obuf0;
  wire [1:0] o_obuf1;
  wire [1:0] o_state;
  wire [1:0] o_copy;
  wire [3:0] o_pshift;
  wire o_readack;
  wire o_readack_sync;
  wire o_readack_sync2;
  wire o_readdataack;
  wire o_readdataack_sync;
  wire o_readdataack_sync2;
  wire [14:0] o_copyv;
  wire [31:0] o_adrs;
  wire [23:0] o_adrs_pre;
  wire [13:0] o_stride;
  wire o_adrsa;
  wire o_adrsb;
  wire o_rline;
  wire [4:0] o_ad;
  wire [4:0] o_ad1;
  wire [4:0] o_ad2;
  wire [4:0] o_ad3;
  wire o_adturn;
  wire [127:0] o_dr;
  wire [143:0] o_shift;
  wire o_sh;
  wire o_sh1;
  wire o_sh2;
  wire o_sh3;
  wire o_sh4;
  wire o_reset_na;
  wire [10:0] o_wadl;
  wire [10:0] o_radl0;
  wire [10:0] o_radl1;
  wire [10:0] o_radl2;
  wire [10:0] o_radl3;
  wire [23:0] o_ldw;
  wire [23:0] o_ldr0;
  wire [23:0] o_ldr1;
  wire [23:0] o_ldr2;
  wire [23:0] o_ldr3;
  wire [3:0] o_wr;
  wire [11:0] o_hcpt;
  wire [11:0] o_vcpt;
  wire [11:0] o_vcpt_pre;
  wire [11:0] o_vcpt_pre2;
  wire [11:0] o_vcpt_pre3;
  wire [11:0] o_vcpt2;
  wire [11:0] o_ihsize;
  wire [11:0] o_ihsizem;
  wire [11:0] o_ivsize;
  wire [14:0] o_ihsize_temp;
  wire [14:0] o_ihsize_temp2;
  wire [11:0] o_vfrac;
  wire [119:0] o_hfrac;
  wire [12:0] o_hacc;
  wire [12:0] o_hacc_ini;
  wire [12:0] o_hacc_next;
  wire [12:0] o_vacc;
  wire [12:0] o_vacc_next;
  wire [12:0] o_vacc_ini;
  wire [11:0] o_hsv;
  wire [11:0] o_vsv;
  wire [11:0] o_dev;
  wire [11:0] o_pev;
  wire [11:0] o_end;
  wire o_hsp;
  wire o_vss;
  wire o_vcarrym;
  wire o_prim;
  wire o_read;
  wire o_read_pre;
  wire [1:0] o_readlev;
  wire [1:0] o_copylev;
  wire [4:0] o_hburst;
  wire [4:0] o_hbcpt;
  wire [1:0] o_fload;
  wire [3:0] o_acpt;
  wire [3:0] o_acpt1;
  wire [3:0] o_acpt2;
  wire [3:0] o_acpt3;
  wire [3:0] o_acpt4;
  wire [1:0] o_dshi;
  wire o_first;
  wire o_last;
  wire o_last1;
  wire o_last2;
  wire o_lastt1;
  wire o_lastt2;
  wire o_lastt3;
  wire o_lastt4;
  wire [3:0] o_alt;
  wire [3:0] o_altx;
  wire o_hdown;
  wire o_vdown;
  wire [2:0] o_primv;
  wire [2:0] o_lastv;
  wire [2:0] o_bibv;
  wire [11:0] o_off;
  reg o_bibu;
  wire [167:0] o_dcptv;
  wire [11:0] o_dcpt;
  wire [23:0] o_hpixs;
  wire [23:0] o_hpix0;
  wire [23:0] o_hpix1;
  wire [23:0] o_hpix2;
  wire [23:0] o_hpix3;
  wire [671:0] o_hpixq;
  wire [95:0] o_vpixq;
  wire [95:0] o_vpixq_pre;
  wire [71:0] o_vpix_outer;
  wire [167:0] o_vpix_inner;
  wire o_vpe;
  wire [62:0] o_div;
  wire [35:0] o_dir;
  wire [12:0] o_vdivi;
  wire [24:0] o_vdivr;
  wire o_divstart;
  wire o_divrun;
  wire [11:0] o_hacpt;
  wire [11:0] o_vacpt;
  wire [1:0] o_vacptl;
  wire [3:0] o_h_bil_frac;
  wire [3:0] o_v_bil_frac;
  wire [23:0] o_h_bil_pix;
  wire [23:0] o_v_bil_pix;
  wire [38:0] o_h_bil_t;
  wire [38:0] o_v_bil_t;
  wire [38:0] i_h_bil_t;
  wire [7:0] o_h_sbil_t;
  wire [7:0] o_v_sbil_t;
  wire [23:0] o_h_bic_pix;
  wire [23:0] o_v_bic_pix;
  wire [146:0] o_h_bic_abcd1;
  wire [146:0] o_v_bic_abcd1;
  wire [95:0] o_h_bic_tt1;
  wire [95:0] o_v_bic_tt1;
  wire [59:0] o_h_bic_tt2;
  wire [59:0] o_v_bic_tt2;
  wire [639:0] o_h_poly_mem;
  wire [639:0] o_v_poly_mem;
  wire [639:0] o_a_poly_mem;
  wire [3:0] o_a_poly_addr;
  wire [3:0] o_v_poly_addr;
  wire [39:0] o_h_poly_phase_a;
  wire [39:0] o_h_poly_phase_a2;
  wire [39:0] o_h_poly_phase_a3;
  wire [39:0] o_h_poly_phase_a4;
  wire [39:0] o_h_poly_phase_a5;
  wire [39:0] o_v_poly_phase_a;
  wire [39:0] o_v_poly_phase_a2;
  wire [39:0] o_v_poly_phase_a3;
  wire [39:0] o_v_poly_phase_a4;
  wire [39:0] o_v_poly_phase_a5;
  wire [39:0] o_poly_phase_a;
  wire [39:0] o_poly_phase_a2;
  wire [39:0] o_poly_phase_b;
  wire [39:0] o_poly_phase_b2;
  wire [71:0] o_v_poly_phase;
  wire [71:0] o_h_poly_phase;
  wire [71:0] o_poly_phase;
  wire [71:0] o_poly_phase1;
  wire [23:0] o_v_poly_pix;
  wire [23:0] o_h_poly_pix;
  wire [23:0] o_h_lum_pix;
  wire [23:0] o_v_lum_pix;
  wire [7:0] o_poly_lum;
  wire [7:0] o_poly_lum1;
  wire [9:0] o_poly_lerp_ta;
  wire [9:0] o_poly_lerp_tb;
  wire [161:0] o_h_poly_t;
  wire [161:0] o_v_poly_t;
  wire o_v_poly_adaptive;
  wire o_h_poly_adaptive;
  wire o_v_poly_use_adaptive;
  wire o_h_poly_use_adaptive;
  wire [2:0] poly_wr_mode;
  wire [39:0] poly_tdw;
  wire [3:0] poly_a2;
  wire n24_o;
  reg n29_q;
  wire n31_o;
  reg n36_q;
  wire n38_o;
  reg n43_q;
  wire n49_o;
  wire [7:0] n53_o;
  localparam [15:0] n55_o = 16'b0000000000000000;
  wire n60_o;
  wire [7:0] n62_o;
  wire [15:0] n65_o;
  wire [15:0] n68_o;
  wire [31:0] n69_o;
  wire [31:0] n71_o;
  wire [30:0] n72_o;
  wire [15:0] n73_o;
  wire [15:0] n76_o;
  wire [15:0] n79_o;
  wire [23:0] n80_o;
  wire n81_o;
  wire n82_o;
  wire n83_o;
  wire [31:0] n84_o;
  wire n86_o;
  wire n87_o;
  wire [31:0] n88_o;
  wire [31:0] n90_o;
  wire [1:0] n91_o;
  wire [1:0] n92_o;
  wire [1:0] n94_o;
  wire [31:0] n96_o;
  wire n98_o;
  wire n105_o;
  wire n106_o;
  wire n107_o;
  wire n109_o;
  wire n110_o;
  wire n111_o;
  wire n113_o;
  wire n114_o;
  wire n115_o;
  wire n116_o;
  wire n117_o;
  wire n119_o;
  wire [31:0] n120_o;
  wire [31:0] n122_o;
  wire [30:0] n123_o;
  wire [31:0] n124_o;
  wire [31:0] n127_o;
  wire n131_o;
  wire [31:0] n133_o;
  wire [11:0] n135_o;
  wire n137_o;
  wire [31:0] n139_o;
  wire [31:0] n141_o;
  wire [31:0] n142_o;
  wire n143_o;
  wire [31:0] n144_o;
  wire [31:0] n145_o;
  wire n146_o;
  wire n147_o;
  wire [31:0] n148_o;
  wire [31:0] n149_o;
  wire n150_o;
  wire n151_o;
  wire [31:0] n152_o;
  wire [31:0] n153_o;
  wire n154_o;
  wire n155_o;
  wire n162_o;
  wire n163_o;
  wire n164_o;
  wire n165_o;
  wire n166_o;
  wire n167_o;
  wire n168_o;
  wire n169_o;
  wire [31:0] n171_o;
  wire [31:0] n172_o;
  wire n173_o;
  wire [31:0] n174_o;
  wire [31:0] n175_o;
  wire n176_o;
  wire n177_o;
  wire n184_o;
  wire n185_o;
  wire n186_o;
  wire [31:0] n187_o;
  wire [31:0] n189_o;
  wire [11:0] n190_o;
  wire [11:0] n193_o;
  wire n195_o;
  wire n196_o;
  wire n198_o;
  wire n199_o;
  wire n200_o;
  wire n201_o;
  wire n202_o;
  wire n203_o;
  wire [11:0] n204_o;
  wire n205_o;
  wire n206_o;
  wire n207_o;
  wire n208_o;
  wire n209_o;
  wire n210_o;
  wire [11:0] n211_o;
  wire [11:0] n213_o;
  wire [11:0] n214_o;
  wire [11:0] n216_o;
  wire [11:0] n217_o;
  wire n218_o;
  wire n219_o;
  wire n220_o;
  wire n221_o;
  wire n222_o;
  wire n223_o;
  wire n226_o;
  wire n228_o;
  wire n229_o;
  wire [31:0] n230_o;
  wire [31:0] n232_o;
  wire [31:0] n234_o;
  wire [31:0] n236_o;
  wire [31:0] n238_o;
  wire [4:0] n239_o;
  wire n241_o;
  wire [31:0] n242_o;
  wire [31:0] n244_o;
  wire [31:0] n246_o;
  wire [31:0] n248_o;
  wire [31:0] n250_o;
  wire [4:0] n251_o;
  wire [31:0] n252_o;
  wire [31:0] n254_o;
  wire [31:0] n256_o;
  wire [31:0] n258_o;
  wire [31:0] n260_o;
  wire [4:0] n261_o;
  wire [4:0] n262_o;
  wire [4:0] n263_o;
  wire [2:0] n265_o;
  wire n267_o;
  wire n269_o;
  wire n276_o;
  wire [31:0] n278_o;
  wire [31:0] n279_o;
  wire n280_o;
  wire n282_o;
  wire n289_o;
  wire [31:0] n291_o;
  wire [31:0] n292_o;
  wire n293_o;
  wire n295_o;
  wire n302_o;
  wire [31:0] n303_o;
  wire [31:0] n305_o;
  wire [31:0] n306_o;
  wire [31:0] n307_o;
  wire [31:0] n309_o;
  wire [11:0] n310_o;
  wire [31:0] n312_o;
  wire [31:0] n314_o;
  wire [31:0] n315_o;
  wire [31:0] n316_o;
  wire [31:0] n318_o;
  wire [11:0] n319_o;
  wire n321_o;
  wire [31:0] n322_o;
  wire [31:0] n323_o;
  wire [31:0] n325_o;
  wire n326_o;
  wire [31:0] n327_o;
  wire [31:0] n329_o;
  wire [11:0] n330_o;
  wire [11:0] n331_o;
  wire n334_o;
  wire [11:0] n335_o;
  wire n337_o;
  wire [31:0] n338_o;
  wire n340_o;
  wire [31:0] n341_o;
  wire [31:0] n342_o;
  wire [31:0] n344_o;
  wire [31:0] n345_o;
  wire [31:0] n346_o;
  wire [31:0] n348_o;
  wire n349_o;
  wire [31:0] n350_o;
  wire [31:0] n351_o;
  wire [31:0] n353_o;
  wire [31:0] n354_o;
  wire [12:0] n355_o;
  wire [31:0] n357_o;
  wire [31:0] n358_o;
  wire [31:0] n360_o;
  wire [31:0] n361_o;
  wire [31:0] n362_o;
  wire [31:0] n364_o;
  wire [31:0] n365_o;
  wire [31:0] n367_o;
  wire [12:0] n368_o;
  wire n372_o;
  wire [12:0] n373_o;
  wire [31:0] n374_o;
  wire [31:0] n375_o;
  wire n376_o;
  wire [31:0] n377_o;
  wire [31:0] n378_o;
  wire [31:0] n379_o;
  wire [31:0] n381_o;
  wire [12:0] n382_o;
  wire n385_o;
  wire [12:0] n386_o;
  wire n389_o;
  wire n391_o;
  wire n393_o;
  wire n395_o;
  wire [31:0] n396_o;
  wire [31:0] n397_o;
  wire [31:0] n399_o;
  wire [31:0] n400_o;
  wire [31:0] n401_o;
  wire [31:0] n403_o;
  wire n404_o;
  wire [31:0] n405_o;
  wire [31:0] n406_o;
  wire [31:0] n408_o;
  wire [31:0] n409_o;
  wire [12:0] n410_o;
  wire [31:0] n412_o;
  wire [31:0] n413_o;
  wire [31:0] n415_o;
  wire [31:0] n416_o;
  wire [31:0] n417_o;
  wire [31:0] n419_o;
  wire [31:0] n420_o;
  wire [31:0] n422_o;
  wire [12:0] n423_o;
  wire n427_o;
  wire [12:0] n428_o;
  wire n429_o;
  wire [12:0] n430_o;
  wire n431_o;
  wire n433_o;
  wire [31:0] n434_o;
  wire [31:0] n436_o;
  wire [30:0] n437_o;
  wire [16:0] n438_o;
  wire [31:0] n439_o;
  wire [31:0] n441_o;
  wire [30:0] n442_o;
  wire [16:0] n443_o;
  wire [16:0] n444_o;
  wire n445_o;
  wire n446_o;
  localparam [11:0] n447_o = 12'b000000000000;
  wire n449_o;
  wire n450_o;
  wire [31:0] n451_o;
  wire [31:0] n453_o;
  wire [30:0] n454_o;
  wire [16:0] n455_o;
  wire [16:0] n456_o;
  wire [31:0] n457_o;
  wire [31:0] n459_o;
  wire [30:0] n460_o;
  wire [16:0] n461_o;
  wire [16:0] n462_o;
  wire [16:0] n463_o;
  wire n464_o;
  wire n465_o;
  wire [9:0] n466_o;
  wire [11:0] n467_o;
  wire n468_o;
  wire n469_o;
  wire [31:0] n470_o;
  wire [31:0] n472_o;
  wire [30:0] n473_o;
  wire [16:0] n474_o;
  wire [16:0] n475_o;
  wire [31:0] n476_o;
  wire [31:0] n478_o;
  wire [30:0] n479_o;
  wire [16:0] n480_o;
  wire [16:0] n481_o;
  wire [16:0] n482_o;
  wire n483_o;
  wire n484_o;
  wire [1:0] n485_o;
  wire n487_o;
  wire n488_o;
  wire [31:0] n489_o;
  wire [31:0] n491_o;
  wire [30:0] n492_o;
  wire [16:0] n493_o;
  wire [16:0] n494_o;
  wire [31:0] n495_o;
  wire [31:0] n497_o;
  wire [30:0] n498_o;
  wire [16:0] n499_o;
  wire [16:0] n500_o;
  wire [16:0] n501_o;
  wire n502_o;
  wire n503_o;
  wire [7:0] n504_o;
  wire [11:0] n505_o;
  wire n506_o;
  wire n513_o;
  wire n514_o;
  wire n515_o;
  wire n516_o;
  wire [3:0] n517_o;
  wire [95:0] n520_o;
  wire n529_o;
  wire n530_o;
  wire [23:0] n531_o;
  wire [7:0] n532_o;
  wire [8:0] n534_o;
  wire [12:0] n536_o;
  wire [23:0] n537_o;
  wire [7:0] n538_o;
  wire [8:0] n540_o;
  wire [12:0] n542_o;
  wire [23:0] n543_o;
  wire [7:0] n544_o;
  wire [8:0] n546_o;
  wire [12:0] n548_o;
  wire [23:0] n549_o;
  wire [7:0] n550_o;
  wire [8:0] n552_o;
  wire [12:0] n554_o;
  wire [23:0] n555_o;
  wire [7:0] n556_o;
  wire [8:0] n558_o;
  wire [12:0] n560_o;
  wire [23:0] n561_o;
  wire [7:0] n562_o;
  wire [8:0] n564_o;
  wire [12:0] n566_o;
  wire [38:0] n567_o;
  wire [38:0] n568_o;
  wire [38:0] n569_o;
  wire [3:0] n576_o;
  wire [95:0] n578_o;
  wire [4:0] n588_o;
  wire n589_o;
  wire [4:0] n591_o;
  wire [4:0] n592_o;
  wire [4:0] n595_o;
  wire [23:0] n597_o;
  wire [7:0] n598_o;
  wire [12:0] n599_o;
  wire [12:0] n600_o;
  wire [12:0] n601_o;
  wire [23:0] n602_o;
  wire [7:0] n603_o;
  wire [12:0] n604_o;
  wire [12:0] n605_o;
  wire [12:0] n606_o;
  wire [12:0] n607_o;
  wire [23:0] n611_o;
  wire [7:0] n612_o;
  wire [12:0] n613_o;
  wire [12:0] n614_o;
  wire [12:0] n615_o;
  wire [23:0] n616_o;
  wire [7:0] n617_o;
  wire [12:0] n618_o;
  wire [12:0] n619_o;
  wire [12:0] n620_o;
  wire [12:0] n621_o;
  wire [23:0] n623_o;
  wire [7:0] n624_o;
  wire [12:0] n625_o;
  wire [12:0] n626_o;
  wire [12:0] n627_o;
  wire [23:0] n628_o;
  wire [7:0] n629_o;
  wire [12:0] n630_o;
  wire [12:0] n631_o;
  wire [12:0] n632_o;
  wire [12:0] n633_o;
  wire [38:0] n634_o;
  wire [38:0] n635_o;
  wire [12:0] n638_o;
  wire n643_o;
  wire n645_o;
  wire n647_o;
  wire [7:0] n649_o;
  wire [7:0] n650_o;
  wire [7:0] n651_o;
  wire [12:0] n653_o;
  wire n658_o;
  wire n660_o;
  wire n662_o;
  wire [7:0] n664_o;
  wire [7:0] n665_o;
  wire [7:0] n666_o;
  wire [12:0] n668_o;
  wire n673_o;
  wire n675_o;
  wire n677_o;
  wire [7:0] n679_o;
  wire [7:0] n680_o;
  wire [7:0] n681_o;
  wire n682_o;
  wire [23:0] n683_o;
  wire [23:0] n684_o;
  wire n685_o;
  wire n692_o;
  wire n693_o;
  wire n694_o;
  wire n695_o;
  wire [3:0] n696_o;
  wire [95:0] n699_o;
  wire n708_o;
  wire n709_o;
  wire [23:0] n710_o;
  wire [7:0] n711_o;
  wire [8:0] n713_o;
  wire [12:0] n715_o;
  wire [23:0] n716_o;
  wire [7:0] n717_o;
  wire [8:0] n719_o;
  wire [12:0] n721_o;
  wire [23:0] n722_o;
  wire [7:0] n723_o;
  wire [8:0] n725_o;
  wire [12:0] n727_o;
  wire [23:0] n728_o;
  wire [7:0] n729_o;
  wire [8:0] n731_o;
  wire [12:0] n733_o;
  wire [23:0] n734_o;
  wire [7:0] n735_o;
  wire [8:0] n737_o;
  wire [12:0] n739_o;
  wire [23:0] n740_o;
  wire [7:0] n741_o;
  wire [8:0] n743_o;
  wire [12:0] n745_o;
  wire [38:0] n746_o;
  wire [38:0] n747_o;
  wire [38:0] n748_o;
  wire [3:0] n755_o;
  wire [95:0] n757_o;
  wire [4:0] n767_o;
  wire n768_o;
  wire [4:0] n770_o;
  wire [4:0] n771_o;
  wire [4:0] n774_o;
  wire [23:0] n776_o;
  wire [7:0] n777_o;
  wire [12:0] n778_o;
  wire [12:0] n779_o;
  wire [12:0] n780_o;
  wire [23:0] n781_o;
  wire [7:0] n782_o;
  wire [12:0] n783_o;
  wire [12:0] n784_o;
  wire [12:0] n785_o;
  wire [12:0] n786_o;
  wire [23:0] n790_o;
  wire [7:0] n791_o;
  wire [12:0] n792_o;
  wire [12:0] n793_o;
  wire [12:0] n794_o;
  wire [23:0] n795_o;
  wire [7:0] n796_o;
  wire [12:0] n797_o;
  wire [12:0] n798_o;
  wire [12:0] n799_o;
  wire [12:0] n800_o;
  wire [23:0] n802_o;
  wire [7:0] n803_o;
  wire [12:0] n804_o;
  wire [12:0] n805_o;
  wire [12:0] n806_o;
  wire [23:0] n807_o;
  wire [7:0] n808_o;
  wire [12:0] n809_o;
  wire [12:0] n810_o;
  wire [12:0] n811_o;
  wire [12:0] n812_o;
  wire [38:0] n813_o;
  wire [38:0] n815_o;
  wire [12:0] n817_o;
  wire n822_o;
  wire n824_o;
  wire n826_o;
  wire [7:0] n828_o;
  wire [7:0] n829_o;
  wire [7:0] n830_o;
  wire [12:0] n832_o;
  wire n837_o;
  wire n839_o;
  wire n841_o;
  wire [7:0] n843_o;
  wire [7:0] n844_o;
  wire [7:0] n845_o;
  wire [12:0] n847_o;
  wire n852_o;
  wire n854_o;
  wire n856_o;
  wire [7:0] n858_o;
  wire [7:0] n859_o;
  wire [7:0] n860_o;
  wire n861_o;
  wire [23:0] n862_o;
  wire [23:0] n863_o;
  wire n864_o;
  wire n865_o;
  wire [95:0] n871_o;
  wire [7:0] n872_o;
  wire [103:0] n873_o;
  wire [7:0] n874_o;
  wire [111:0] n875_o;
  wire [7:0] n876_o;
  wire [119:0] n877_o;
  wire n879_o;
  wire [87:0] n880_o;
  wire [7:0] n881_o;
  wire [95:0] n882_o;
  wire [7:0] n883_o;
  wire [103:0] n884_o;
  wire [7:0] n885_o;
  wire [111:0] n886_o;
  wire [119:0] n888_o;
  wire n890_o;
  wire [103:0] n891_o;
  wire [2:0] n892_o;
  wire [106:0] n893_o;
  wire [4:0] n894_o;
  wire [111:0] n895_o;
  wire [4:0] n896_o;
  wire [116:0] n897_o;
  wire [2:0] n898_o;
  wire [119:0] n899_o;
  wire [1:0] n900_o;
  reg [119:0] n901_o;
  wire [31:0] n909_o;
  wire n911_o;
  wire [7:0] n912_o;
  wire [127:0] n913_o;
  wire [31:0] n914_o;
  wire n916_o;
  wire [111:0] n917_o;
  wire [7:0] n918_o;
  wire [119:0] n919_o;
  wire [7:0] n920_o;
  wire [127:0] n921_o;
  wire [31:0] n922_o;
  wire n924_o;
  wire [103:0] n925_o;
  wire [7:0] n926_o;
  wire [111:0] n927_o;
  wire [7:0] n928_o;
  wire [119:0] n929_o;
  wire [7:0] n930_o;
  wire [127:0] n931_o;
  wire [127:0] n932_o;
  wire [127:0] n933_o;
  wire [127:0] n934_o;
  wire n936_o;
  wire [31:0] n937_o;
  wire [1:0] n938_o;
  wire [31:0] n939_o;
  wire n941_o;
  wire n943_o;
  wire n945_o;
  wire [95:0] n946_o;
  wire [7:0] n947_o;
  wire [103:0] n948_o;
  wire [7:0] n949_o;
  wire [111:0] n950_o;
  wire [7:0] n951_o;
  wire [119:0] n952_o;
  wire [127:0] n954_o;
  wire [127:0] n955_o;
  wire n957_o;
  wire [31:0] n958_o;
  wire [2:0] n959_o;
  wire [31:0] n960_o;
  wire n962_o;
  wire n964_o;
  wire n966_o;
  wire [111:0] n967_o;
  wire [2:0] n968_o;
  wire [114:0] n969_o;
  wire [4:0] n970_o;
  wire [119:0] n971_o;
  wire [4:0] n972_o;
  wire [124:0] n973_o;
  wire [2:0] n974_o;
  wire [127:0] n975_o;
  wire [127:0] n976_o;
  wire [1:0] n977_o;
  reg [127:0] n978_o;
  wire [31:0] n984_o;
  wire n986_o;
  wire [31:0] n987_o;
  wire n989_o;
  wire n990_o;
  wire [31:0] n991_o;
  wire n993_o;
  wire n994_o;
  wire n996_o;
  wire n998_o;
  wire n1000_o;
  wire [31:0] n1001_o;
  wire [1:0] n1002_o;
  wire [31:0] n1003_o;
  wire n1005_o;
  wire n1007_o;
  wire n1009_o;
  wire n1011_o;
  wire [31:0] n1012_o;
  wire [2:0] n1013_o;
  wire [31:0] n1014_o;
  wire n1016_o;
  wire n1018_o;
  wire n1020_o;
  wire [1:0] n1021_o;
  reg n1022_o;
  wire n1023_o;
  wire n1026_o;
  wire n1028_o;
  wire [31:0] n1029_o;
  wire [31:0] n1031_o;
  wire [3:0] n1032_o;
  wire n1035_o;
  wire n1036_o;
  wire [3:0] n1038_o;
  wire [127:0] n1039_o;
  wire n1040_o;
  wire n1041_o;
  wire n1042_o;
  wire n1044_o;
  wire n1045_o;
  wire n1046_o;
  wire n1049_o;
  wire n1050_o;
  wire n1051_o;
  wire [31:0] n1052_o;
  wire n1054_o;
  wire [31:0] n1055_o;
  wire [31:0] n1057_o;
  wire [4:0] n1058_o;
  wire [4:0] n1059_o;
  wire [4:0] n1061_o;
  wire [31:0] n1062_o;
  wire n1064_o;
  wire [31:0] n1065_o;
  wire [31:0] n1067_o;
  wire [11:0] n1068_o;
  wire [31:0] n1069_o;
  wire [31:0] n1070_o;
  wire [31:0] n1071_o;
  wire [31:0] n1073_o;
  wire [12:0] n1074_o;
  wire [11:0] n1076_o;
  wire [4:0] n1078_o;
  wire [12:0] n1079_o;
  wire [10:0] n1081_o;
  wire [10:0] n1083_o;
  wire [31:0] n1084_o;
  wire n1086_o;
  wire [3:0] n1088_o;
  wire [4:0] n1090_o;
  wire n1091_o;
  wire n1092_o;
  wire n1096_o;
  wire n1098_o;
  wire n1103_o;
  wire n1104_o;
  wire n1122_o;
  wire n1123_o;
  wire n1125_o;
  wire n1130_o;
  wire n1133_o;
  wire n1136_o;
  wire n1137_o;
  wire n1142_o;
  wire n1143_o;
  wire n1144_o;
  wire n1153_o;
  wire n1156_o;
  wire n1157_o;
  wire n1183_o;
  wire n1184_o;
  wire [31:0] n1185_o;
  wire [31:0] n1187_o;
  wire [10:0] n1188_o;
  wire [10:0] n1190_o;
  wire n1191_o;
  wire n1192_o;
  wire [31:0] n1193_o;
  wire [31:0] n1195_o;
  wire [10:0] n1196_o;
  wire [10:0] n1198_o;
  wire n1199_o;
  wire n1200_o;
  wire [2:0] n1202_o;
  wire n1203_o;
  wire n1207_o;
  wire n1210_o;
  wire n1213_o;
  wire [4:0] n1215_o;
  wire [127:0] n1216_o;
  wire [31:0] n1218_o;
  wire [4:0] n1222_o;
  wire n1223_o;
  wire n1224_o;
  wire [31:0] n1225_o;
  wire [31:0] n1227_o;
  wire [4:0] n1228_o;
  wire [31:0] n1230_o;
  wire [31:0] n1232_o;
  wire [3:0] n1233_o;
  wire [31:0] n1234_o;
  wire n1236_o;
  wire [31:0] n1237_o;
  wire [31:0] n1238_o;
  wire n1239_o;
  wire n1240_o;
  wire [31:0] n1241_o;
  wire [31:0] n1243_o;
  wire [4:0] n1244_o;
  wire n1246_o;
  wire [31:0] n1248_o;
  wire [31:0] n1250_o;
  wire [31:0] n1252_o;
  wire n1254_o;
  wire n1261_o;
  wire [31:0] n1263_o;
  wire n1264_o;
  wire n1265_o;
  wire [4:0] n1266_o;
  wire [31:0] n1267_o;
  wire [31:0] n1268_o;
  wire n1270_o;
  wire n1271_o;
  wire n1272_o;
  wire n1273_o;
  wire [4:0] n1274_o;
  wire n1275_o;
  wire n1276_o;
  wire n1277_o;
  wire n1278_o;
  wire [31:0] n1279_o;
  wire [3:0] n1280_o;
  wire [31:0] n1281_o;
  wire n1283_o;
  wire [31:0] n1284_o;
  wire [31:0] n1285_o;
  wire n1286_o;
  wire n1287_o;
  wire [31:0] n1288_o;
  wire [31:0] n1290_o;
  wire [4:0] n1291_o;
  wire n1293_o;
  wire [31:0] n1295_o;
  wire [31:0] n1297_o;
  wire n1299_o;
  wire n1306_o;
  wire n1307_o;
  wire n1308_o;
  wire [31:0] n1309_o;
  wire [31:0] n1311_o;
  wire [31:0] n1313_o;
  wire [30:0] n1314_o;
  wire [31:0] n1315_o;
  wire [31:0] n1316_o;
  wire [31:0] n1318_o;
  wire [31:0] n1319_o;
  wire n1320_o;
  wire n1321_o;
  wire [31:0] n1322_o;
  wire [31:0] n1324_o;
  wire [30:0] n1325_o;
  wire [31:0] n1326_o;
  wire [31:0] n1327_o;
  wire [31:0] n1328_o;
  wire n1329_o;
  wire n1330_o;
  wire [4:0] n1331_o;
  wire [31:0] n1332_o;
  wire [31:0] n1333_o;
  wire n1334_o;
  wire n1335_o;
  wire n1336_o;
  wire n1337_o;
  wire [31:0] n1338_o;
  wire n1342_o;
  wire [31:0] n1344_o;
  wire n1346_o;
  wire n1347_o;
  wire n1348_o;
  wire [31:0] n1349_o;
  wire n1351_o;
  wire [31:0] n1352_o;
  wire [31:0] n1354_o;
  wire [2:0] n1355_o;
  wire [2:0] n1356_o;
  wire n1361_o;
  wire [2:0] n1363_o;
  wire [127:0] n1420_o;
  wire n1578_o;
  wire n1579_o;
  wire [11:0] n1580_o;
  reg [11:0] n1581_q;
  wire n1582_o;
  wire n1583_o;
  wire [11:0] n1584_o;
  reg [11:0] n1585_q;
  wire n1586_o;
  wire n1587_o;
  reg n1588_q;
  wire n1589_o;
  wire n1590_o;
  reg n1591_q;
  wire n1592_o;
  wire n1593_o;
  reg n1594_q;
  wire n1595_o;
  wire n1596_o;
  reg n1597_q;
  wire n1598_o;
  wire [23:0] n1599_o;
  reg [23:0] n1600_q;
  wire n1601_o;
  wire n1602_o;
  reg n1603_q;
  wire n1604_o;
  wire n1605_o;
  wire [2:0] n1606_o;
  reg [2:0] n1607_q;
  wire n1608_o;
  wire n1609_o;
  wire [11:0] n1610_o;
  reg [11:0] n1611_q;
  wire n1612_o;
  wire n1613_o;
  wire [11:0] n1614_o;
  reg [11:0] n1615_q;
  wire n1616_o;
  wire n1617_o;
  wire [11:0] n1618_o;
  reg [11:0] n1619_q;
  wire n1620_o;
  wire n1621_o;
  wire [11:0] n1622_o;
  reg [11:0] n1623_q;
  wire n1624_o;
  wire n1625_o;
  wire [11:0] n1626_o;
  reg [11:0] n1627_q;
  wire n1628_o;
  wire n1629_o;
  wire [11:0] n1630_o;
  reg [11:0] n1631_q;
  wire n1632_o;
  wire n1633_o;
  wire [11:0] n1634_o;
  reg [11:0] n1635_q;
  wire n1636_o;
  wire n1637_o;
  wire [11:0] n1638_o;
  reg [11:0] n1639_q;
  wire n1640_o;
  wire n1641_o;
  wire [11:0] n1642_o;
  reg [11:0] n1643_q;
  wire n1644_o;
  wire n1645_o;
  wire [11:0] n1646_o;
  reg [11:0] n1647_q;
  wire n1648_o;
  wire n1649_o;
  wire [11:0] n1650_o;
  reg [11:0] n1651_q;
  wire n1652_o;
  wire n1653_o;
  reg n1654_q;
  wire n1655_o;
  wire n1656_o;
  wire [4:0] n1657_o;
  reg [4:0] n1658_q;
  wire n1659_o;
  wire n1660_o;
  wire [1:0] n1661_o;
  reg [1:0] n1662_q;
  wire n1663_o;
  wire n1664_o;
  wire n1665_o;
  reg n1666_q;
  wire n1667_o;
  wire n1668_o;
  wire n1669_o;
  reg n1670_q;
  wire n1671_o;
  wire n1672_o;
  reg n1673_q;
  wire n1674_o;
  wire n1675_o;
  wire n1676_o;
  reg n1677_q;
  wire n1678_o;
  wire n1679_o;
  wire n1680_o;
  reg n1681_q;
  wire n1682_o;
  wire n1683_o;
  wire n1684_o;
  reg n1685_q;
  wire n1686_o;
  wire n1687_o;
  wire n1688_o;
  reg n1689_q;
  wire n1690_o;
  wire n1691_o;
  wire [4:0] n1692_o;
  reg [4:0] n1693_q;
  wire n1694_o;
  wire n1695_o;
  wire [1:0] n1696_o;
  reg [1:0] n1697_q;
  wire n1698_o;
  wire n1699_o;
  wire n1700_o;
  reg n1701_q;
  wire n1702_o;
  wire n1703_o;
  wire n1704_o;
  reg n1705_q;
  wire n1706_o;
  wire n1707_o;
  wire n1708_o;
  reg n1709_q;
  wire n1710_o;
  reg n1711_q;
  wire n1712_o;
  wire n1713_o;
  reg n1714_q;
  wire n1715_o;
  wire n1716_o;
  reg n1717_q;
  wire n1718_o;
  wire n1719_o;
  wire n1720_o;
  reg n1721_q;
  wire n1722_o;
  wire n1723_o;
  wire n1724_o;
  reg n1725_q;
  wire n1726_o;
  wire n1727_o;
  wire n1728_o;
  reg n1729_q;
  wire n1730_o;
  wire n1731_o;
  wire n1732_o;
  reg n1733_q;
  wire n1734_o;
  wire n1735_o;
  wire n1736_o;
  reg n1737_q;
  wire n1738_o;
  wire n1739_o;
  reg n1740_q;
  wire n1741_o;
  wire [2:0] n1742_o;
  reg [2:0] n1743_q;
  wire n1744_o;
  wire n1745_o;
  reg n1746_q;
  wire n1747_o;
  wire n1748_o;
  wire n1749_o;
  reg n1750_q;
  wire n1751_o;
  wire n1752_o;
  wire n1753_o;
  reg n1754_q;
  wire n1755_o;
  wire n1756_o;
  reg n1757_q;
  wire n1758_o;
  wire n1759_o;
  reg n1760_q;
  wire n1761_o;
  wire n1762_o;
  reg n1763_q;
  wire n1764_o;
  wire n1765_o;
  reg n1766_q;
  wire n1767_o;
  wire n1768_o;
  wire [4:0] n1769_o;
  reg [4:0] n1770_q;
  wire n1771_o;
  wire [4:0] n1772_o;
  reg [4:0] n1773_q;
  wire n1774_o;
  wire n1775_o;
  wire [119:0] n1776_o;
  reg [119:0] n1777_q;
  wire n1778_o;
  wire [127:0] n1779_o;
  reg [127:0] n1780_q;
  wire n1781_o;
  wire n1782_o;
  wire [3:0] n1783_o;
  reg [3:0] n1784_q;
  wire n1785_o;
  wire n1786_o;
  wire n1787_o;
  reg n1788_q;
  wire n1789_o;
  wire n1790_o;
  wire n1791_o;
  reg n1792_q;
  wire n1793_o;
  wire n1794_o;
  wire n1795_o;
  reg n1796_q;
  wire n1797_o;
  wire [4:0] n1798_o;
  reg [4:0] n1799_q;
  wire n1800_o;
  wire [127:0] n1801_o;
  reg [127:0] n1802_q;
  wire n1803_o;
  wire [31:0] n1804_o;
  reg [31:0] n1805_q;
  wire n1806_o;
  wire [31:0] n1807_o;
  reg [31:0] n1808_q;
  wire n1809_o;
  wire n1810_o;
  wire [31:0] n1811_o;
  reg [31:0] n1812_q;
  wire n1813_o;
  wire n1814_o;
  wire [31:0] n1815_o;
  reg [31:0] n1816_q;
  wire n1817_o;
  wire n1818_o;
  wire n1819_o;
  reg n1820_q;
  wire n1821_o;
  wire n1822_o;
  wire n1823_o;
  reg n1824_q;
  wire n1825_o;
  wire n1826_o;
  wire [11:0] n1827_o;
  reg [11:0] n1828_q;
  wire n1829_o;
  wire n1830_o;
  wire [11:0] n1831_o;
  reg [11:0] n1832_q;
  wire n1833_o;
  wire n1834_o;
  wire [16:0] n1835_o;
  reg [16:0] n1836_q;
  wire n1837_o;
  wire n1838_o;
  wire [11:0] n1839_o;
  reg [11:0] n1840_q;
  wire n1841_o;
  wire n1842_o;
  wire [11:0] n1843_o;
  reg [11:0] n1844_q;
  wire n1845_o;
  wire n1846_o;
  wire [12:0] n1847_o;
  reg [12:0] n1848_q;
  wire n1849_o;
  wire n1850_o;
  wire [12:0] n1851_o;
  reg [12:0] n1852_q;
  wire n1853_o;
  wire n1854_o;
  wire n1855_o;
  reg n1856_q;
  wire n1857_o;
  wire n1858_o;
  wire n1859_o;
  reg n1860_q;
  wire n1861_o;
  wire [10:0] n1862_o;
  reg [10:0] n1863_q;
  wire n1864_o;
  wire [10:0] n1865_o;
  reg [10:0] n1866_q;
  wire n1867_o;
  wire n1868_o;
  reg n1869_q;
  wire n1870_o;
  wire n1871_o;
  wire n1872_o;
  reg n1873_q;
  wire n1874_o;
  wire [23:0] n1875_o;
  reg [23:0] n1876_q;
  wire n1877_o;
  wire n1878_o;
  wire [23:0] n1879_o;
  reg [23:0] n1880_q;
  wire n1881_o;
  wire n1882_o;
  wire [23:0] n1883_o;
  reg [23:0] n1884_q;
  wire n1885_o;
  wire n1886_o;
  wire [23:0] n1887_o;
  reg [23:0] n1888_q;
  wire n1889_o;
  wire n1890_o;
  wire [23:0] n1891_o;
  reg [23:0] n1892_q;
  wire n1893_o;
  wire n1894_o;
  wire [23:0] n1895_o;
  reg [23:0] n1896_q;
  wire n1897_o;
  wire n1898_o;
  wire [23:0] n1899_o;
  reg [23:0] n1900_q;
  wire n1901_o;
  wire n1902_o;
  wire [23:0] n1903_o;
  reg [23:0] n1904_q;
  wire n1905_o;
  wire n1906_o;
  wire [23:0] n1907_o;
  reg [23:0] n1908_q;
  wire n1909_o;
  wire n1910_o;
  wire n1911_o;
  reg n1912_q;
  wire n1913_o;
  wire n1914_o;
  wire n1915_o;
  reg n1916_q;
  wire n1917_o;
  wire n1918_o;
  wire n1919_o;
  reg n1920_q;
  wire n1921_o;
  wire n1922_o;
  wire n1923_o;
  reg n1924_q;
  wire n1925_o;
  wire n1926_o;
  wire n1927_o;
  reg n1928_q;
  wire n1929_o;
  wire n1930_o;
  wire n1931_o;
  reg n1932_q;
  wire n1933_o;
  wire n1934_o;
  wire n1935_o;
  reg n1936_q;
  wire n1937_o;
  wire n1938_o;
  wire n1939_o;
  reg n1940_q;
  wire n1941_o;
  wire n1942_o;
  wire n1943_o;
  reg n1944_q;
  wire n1945_o;
  wire n1946_o;
  wire n1947_o;
  reg n1948_q;
  wire n1949_o;
  wire n1950_o;
  wire [38:0] n1951_o;
  reg [38:0] n1952_q;
  wire n1969_o;
  wire [11:0] n1970_o;
  wire n1971_o;
  wire [11:0] n1972_o;
  wire n1974_o;
  wire [31:0] n1976_o;
  wire [31:0] n1978_o;
  wire [30:0] n1979_o;
  wire [12:0] n1980_o;
  wire [31:0] n1981_o;
  wire [31:0] n1983_o;
  wire [30:0] n1984_o;
  wire [24:0] n1985_o;
  wire [31:0] n1986_o;
  wire n1988_o;
  wire [4:0] n1989_o;
  wire n1990_o;
  wire n1991_o;
  wire [5:0] n1992_o;
  wire [11:0] n1994_o;
  wire [31:0] n1995_o;
  wire [31:0] n1997_o;
  wire [5:0] n1998_o;
  wire n2000_o;
  wire [11:0] n2001_o;
  wire [5:0] n2002_o;
  wire n2003_o;
  wire n2004_o;
  wire [12:0] n2005_o;
  wire [12:0] n2006_o;
  wire [12:0] n2007_o;
  wire [12:0] n2008_o;
  wire [12:0] n2009_o;
  wire [10:0] n2010_o;
  wire n2011_o;
  wire n2012_o;
  wire [11:0] n2013_o;
  wire n2014_o;
  wire [24:0] n2015_o;
  wire [24:0] n2016_o;
  wire n2017_o;
  wire [5:0] n2018_o;
  wire n2020_o;
  wire [24:0] n2021_o;
  wire [11:0] n2022_o;
  wire [5:0] n2024_o;
  wire n2036_o;
  wire n2037_o;
  reg n2038_q;
  wire n2039_o;
  wire [12:0] n2040_o;
  reg [12:0] n2041_q;
  wire n2042_o;
  wire [24:0] n2043_o;
  reg [24:0] n2044_q;
  wire n2045_o;
  wire [11:0] n2046_o;
  reg [11:0] n2047_q;
  wire n2048_o;
  wire [5:0] n2049_o;
  reg [5:0] n2050_q;
  wire [31:0] n2071_o;
  wire [10:0] n2072_o;
  wire [31:0] n2079_o;
  wire [10:0] n2080_o;
  wire n2095_o;
  wire n2097_o;
  wire [31:0] n2099_o;
  wire n2103_o;
  wire n2104_o;
  wire n2105_o;
  wire [31:0] n2111_o;
  wire n2113_o;
  wire n2117_o;
  wire [31:0] n2123_o;
  wire [31:0] n2124_o;
  wire n2126_o;
  wire n2129_o;
  wire [31:0] n2132_o;
  wire n2133_o;
  wire n2135_o;
  wire n2136_o;
  wire n2138_o;
  wire [31:0] n2144_o;
  wire [31:0] n2146_o;
  wire [31:0] n2152_o;
  wire n2154_o;
  wire n2158_o;
  wire [31:0] n2164_o;
  wire [31:0] n2165_o;
  wire n2167_o;
  wire n2170_o;
  wire [31:0] n2173_o;
  wire n2174_o;
  wire n2176_o;
  wire n2177_o;
  wire n2179_o;
  wire [31:0] n2185_o;
  wire [31:0] n2187_o;
  wire n2188_o;
  wire n2189_o;
  wire [31:0] n2190_o;
  wire [31:0] n2191_o;
  wire [31:0] n2192_o;
  wire [31:0] n2193_o;
  wire [31:0] n2199_o;
  wire n2201_o;
  wire n2205_o;
  wire [31:0] n2211_o;
  wire [31:0] n2212_o;
  wire n2214_o;
  wire n2217_o;
  wire [31:0] n2220_o;
  wire n2221_o;
  wire n2223_o;
  wire n2224_o;
  wire n2226_o;
  wire [31:0] n2232_o;
  wire [31:0] n2238_o;
  wire n2240_o;
  wire n2244_o;
  wire [31:0] n2250_o;
  wire [31:0] n2251_o;
  wire n2253_o;
  wire n2256_o;
  wire [31:0] n2259_o;
  wire n2260_o;
  wire n2262_o;
  wire n2263_o;
  wire n2265_o;
  wire [31:0] n2271_o;
  wire [7:0] n2278_o;
  wire [7:0] n2281_o;
  wire [7:0] n2283_o;
  wire [7:0] n2285_o;
  wire [7:0] n2287_o;
  wire [7:0] n2289_o;
  wire [7:0] n2291_o;
  wire [7:0] n2293_o;
  wire [7:0] n2295_o;
  wire [7:0] n2297_o;
  wire [7:0] n2299_o;
  wire [7:0] n2301_o;
  wire [7:0] n2303_o;
  wire [7:0] n2305_o;
  wire [7:0] n2307_o;
  wire [7:0] n2309_o;
  wire [127:0] n2310_o;
  wire n2311_o;
  wire n2312_o;
  wire n2313_o;
  wire n2314_o;
  wire n2315_o;
  wire n2316_o;
  wire n2317_o;
  wire [4:0] n2320_o;
  wire n2321_o;
  wire [27:0] n2322_o;
  wire [27:0] n2323_o;
  wire [27:0] n2324_o;
  wire [27:0] n2325_o;
  wire [27:0] n2326_o;
  wire [27:0] n2327_o;
  wire [27:0] n2328_o;
  wire [1:0] n2330_o;
  wire n2333_o;
  wire [27:0] n2334_o;
  wire [1:0] n2336_o;
  wire n2338_o;
  wire n2341_o;
  wire [4:0] n2342_o;
  wire n2344_o;
  wire n2345_o;
  wire n2346_o;
  wire [31:0] n2347_o;
  wire [3:0] n2348_o;
  wire [31:0] n2349_o;
  wire n2351_o;
  wire [1:0] n2353_o;
  wire n2356_o;
  wire n2357_o;
  wire n2359_o;
  wire n2362_o;
  wire n2363_o;
  wire [31:0] n2364_o;
  wire [31:0] n2365_o;
  wire [31:0] n2366_o;
  wire [27:0] n2367_o;
  wire n2368_o;
  wire n2369_o;
  wire n2370_o;
  wire [1:0] n2372_o;
  wire n2375_o;
  wire n2377_o;
  wire n2379_o;
  wire [2:0] n2380_o;
  reg [27:0] n2382_o;
  reg [1:0] n2384_o;
  reg n2387_o;
  reg n2391_o;
  reg n2395_o;
  reg n2399_o;
  reg [4:0] n2402_o;
  reg n2404_o;
  wire [31:0] n2407_o;
  wire [31:0] n2409_o;
  wire [4:0] n2410_o;
  wire [31:0] n2412_o;
  wire [3:0] n2413_o;
  wire [31:0] n2414_o;
  wire n2416_o;
  wire n2417_o;
  wire [4:0] n2419_o;
  wire n2422_o;
  wire n2424_o;
  wire n2425_o;
  wire n2426_o;
  wire [4:0] n2428_o;
  wire n2501_o;
  wire [27:0] n2502_o;
  reg [27:0] n2503_q;
  reg [1:0] n2504_q;
  wire n2505_o;
  wire n2506_o;
  reg n2507_q;
  wire n2508_o;
  wire n2509_o;
  reg n2510_q;
  wire n2511_o;
  wire n2512_o;
  reg n2513_q;
  wire n2514_o;
  wire n2515_o;
  reg n2516_q;
  wire n2517_o;
  wire n2518_o;
  reg n2519_q;
  wire n2520_o;
  wire n2521_o;
  reg n2522_q;
  wire n2523_o;
  wire n2524_o;
  reg n2525_q;
  wire n2526_o;
  wire n2527_o;
  reg n2528_q;
  reg n2529_q;
  reg n2530_q;
  wire n2531_o;
  wire n2532_o;
  reg n2533_q;
  wire n2534_o;
  wire n2535_o;
  reg n2536_q;
  wire n2537_o;
  wire [4:0] n2538_o;
  reg [4:0] n2539_q;
  wire n2540_o;
  wire [4:0] n2541_o;
  reg [4:0] n2542_q;
  wire n2543_o;
  wire n2544_o;
  wire n2545_o;
  reg n2546_q;
  wire n2547_o;
  wire n2548_o;
  wire n2549_o;
  reg n2550_q;
  wire n2551_o;
  wire n2552_o;
  reg n2553_q;
  wire n2554_o;
  wire [127:0] n2555_o;
  reg [127:0] n2556_q;
  wire n2557_o;
  wire n2558_o;
  reg n2559_q;
  wire n2560_o;
  reg n2561_q;
  reg n2562_q;
  wire n2563_o;
  wire [31:0] n2564_o;
  reg [31:0] n2565_q;
  wire n2566_o;
  wire n2567_o;
  wire [31:0] n2568_o;
  reg [31:0] n2569_q;
  wire n2570_o;
  wire [31:0] n2571_o;
  reg [31:0] n2572_q;
  wire n2573_o;
  wire [31:0] n2574_o;
  reg [31:0] n2575_q;
  wire n2576_o;
  wire [31:0] n2577_o;
  reg [31:0] n2578_q;
  wire n2579_o;
  wire [31:0] n2580_o;
  reg [31:0] n2581_q;
  wire n2582_o;
  wire n2583_o;
  reg n2584_q;
  wire n2585_o;
  wire n2586_o;
  reg n2587_q;
  wire n2588_o;
  wire n2589_o;
  reg n2590_q;
  wire [7:0] n2600_o;
  wire [7:0] n2603_o;
  wire [7:0] n2605_o;
  wire [7:0] n2607_o;
  wire [7:0] n2609_o;
  wire [7:0] n2611_o;
  wire [7:0] n2613_o;
  wire [7:0] n2615_o;
  wire [7:0] n2617_o;
  wire [7:0] n2619_o;
  wire [7:0] n2621_o;
  wire [7:0] n2623_o;
  wire [7:0] n2625_o;
  wire [7:0] n2627_o;
  wire [7:0] n2629_o;
  wire [7:0] n2631_o;
  wire [127:0] n2632_o;
  localparam [7:0] n2633_o = 8'b00010000;
  localparam [15:0] n2634_o = 16'b1111111111111111;
  wire [31:0] n2635_o;
  wire [31:0] n2637_o;
  wire [4:0] n2638_o;
  wire n2640_o;
  wire n2641_o;
  wire [4:0] n2642_o;
  wire n2662_o;
  wire [31:0] n2664_o;
  wire [31:0] n2666_o;
  wire [30:0] n2667_o;
  wire [12:0] n2668_o;
  wire [31:0] n2669_o;
  wire [31:0] n2671_o;
  wire [30:0] n2672_o;
  wire [24:0] n2673_o;
  wire [31:0] n2674_o;
  wire n2676_o;
  wire [10:0] n2677_o;
  wire n2678_o;
  wire n2679_o;
  wire [11:0] n2680_o;
  wire [31:0] n2681_o;
  wire [31:0] n2683_o;
  wire [5:0] n2684_o;
  wire [5:0] n2685_o;
  wire [11:0] n2686_o;
  wire n2688_o;
  wire n2689_o;
  wire n2690_o;
  wire [12:0] n2691_o;
  wire [12:0] n2692_o;
  wire [12:0] n2693_o;
  wire [12:0] n2694_o;
  wire [12:0] n2695_o;
  wire [10:0] n2696_o;
  wire n2697_o;
  wire n2698_o;
  wire [11:0] n2699_o;
  wire [5:0] n2700_o;
  wire n2701_o;
  wire [24:0] n2702_o;
  wire [24:0] n2703_o;
  wire n2704_o;
  wire [5:0] n2706_o;
  wire [11:0] n2707_o;
  wire [24:0] n2708_o;
  wire n2710_o;
  wire n2722_o;
  wire [5:0] n2723_o;
  reg [5:0] n2724_q;
  wire n2725_o;
  wire [11:0] n2726_o;
  reg [11:0] n2727_q;
  wire n2728_o;
  wire [12:0] n2729_o;
  reg [12:0] n2730_q;
  wire n2731_o;
  wire [24:0] n2732_o;
  reg [24:0] n2733_q;
  wire n2734_o;
  wire n2735_o;
  reg n2736_q;
  reg scalaire_prim_v;
  reg scalaire_last_v;
  reg scalaire_bib_v;
  reg [3:0] scalaire_off_v;
  wire n2749_o;
  wire [5:0] n2752_o;
  wire [31:0] n2753_o;
  wire [31:0] n2754_o;
  wire [31:0] n2755_o;
  wire [31:0] n2757_o;
  wire [11:0] n2758_o;
  wire [31:0] n2759_o;
  wire [31:0] n2760_o;
  wire [31:0] n2761_o;
  wire [31:0] n2763_o;
  wire [11:0] n2764_o;
  wire n2765_o;
  wire n2766_o;
  wire [30:0] n2772_o;
  wire n2775_o;
  wire [30:0] n2781_o;
  wire [31:0] n2782_o;
  wire n2784_o;
  wire [31:0] n2785_o;
  wire n2787_o;
  wire n2788_o;
  wire [31:0] n2789_o;
  wire n2791_o;
  wire [31:0] n2792_o;
  wire n2794_o;
  wire n2795_o;
  wire n2796_o;
  wire n2799_o;
  wire [30:0] n2802_o;
  wire n2803_o;
  wire n2805_o;
  wire n2806_o;
  wire n2808_o;
  wire [31:0] n2809_o;
  wire n2811_o;
  wire [31:0] n2812_o;
  wire n2814_o;
  wire n2815_o;
  wire [31:0] n2816_o;
  wire n2818_o;
  wire [31:0] n2819_o;
  wire n2821_o;
  wire n2822_o;
  wire n2823_o;
  wire n2826_o;
  wire [30:0] n2829_o;
  wire n2830_o;
  wire n2832_o;
  wire n2833_o;
  wire n2835_o;
  wire [30:0] n2841_o;
  wire [1:0] n2842_o;
  wire n2845_o;
  wire n2848_o;
  wire [1:0] n2849_o;
  wire n2850_o;
  wire n2851_o;
  wire [30:0] n2857_o;
  wire n2860_o;
  wire [30:0] n2866_o;
  wire [31:0] n2867_o;
  wire n2869_o;
  wire [31:0] n2870_o;
  wire n2872_o;
  wire n2873_o;
  wire [31:0] n2874_o;
  wire n2876_o;
  wire [31:0] n2877_o;
  wire n2879_o;
  wire n2880_o;
  wire n2881_o;
  wire n2884_o;
  wire [30:0] n2887_o;
  wire n2888_o;
  wire n2890_o;
  wire n2891_o;
  wire n2893_o;
  wire [31:0] n2894_o;
  wire n2896_o;
  wire [31:0] n2897_o;
  wire n2899_o;
  wire n2900_o;
  wire [31:0] n2901_o;
  wire n2903_o;
  wire [31:0] n2904_o;
  wire n2906_o;
  wire n2907_o;
  wire n2908_o;
  wire n2911_o;
  wire [30:0] n2914_o;
  wire n2915_o;
  wire n2917_o;
  wire n2918_o;
  wire n2920_o;
  wire [30:0] n2926_o;
  wire [1:0] n2927_o;
  wire n2929_o;
  wire n2931_o;
  wire [1:0] n2932_o;
  wire n2933_o;
  wire n2934_o;
  wire n2935_o;
  wire n2936_o;
  wire n2937_o;
  wire [30:0] n2943_o;
  wire n2946_o;
  wire [30:0] n2952_o;
  wire [31:0] n2953_o;
  wire n2955_o;
  wire [31:0] n2956_o;
  wire n2958_o;
  wire n2959_o;
  wire [31:0] n2960_o;
  wire n2962_o;
  wire [31:0] n2963_o;
  wire n2965_o;
  wire n2966_o;
  wire n2967_o;
  wire n2970_o;
  wire [30:0] n2973_o;
  wire n2974_o;
  wire n2976_o;
  wire n2977_o;
  wire n2979_o;
  wire [31:0] n2980_o;
  wire n2982_o;
  wire [31:0] n2983_o;
  wire n2985_o;
  wire n2986_o;
  wire [31:0] n2987_o;
  wire n2989_o;
  wire [31:0] n2990_o;
  wire n2992_o;
  wire n2993_o;
  wire n2994_o;
  wire n2997_o;
  wire [30:0] n3000_o;
  wire n3001_o;
  wire n3003_o;
  wire n3004_o;
  wire n3006_o;
  wire [30:0] n3012_o;
  wire [1:0] n3013_o;
  wire n3015_o;
  wire [1:0] n3016_o;
  wire n3017_o;
  wire n3018_o;
  wire n3019_o;
  wire n3020_o;
  wire n3021_o;
  wire [30:0] n3027_o;
  wire n3030_o;
  wire [30:0] n3036_o;
  wire [31:0] n3037_o;
  wire n3039_o;
  wire [31:0] n3040_o;
  wire n3042_o;
  wire n3043_o;
  wire [31:0] n3044_o;
  wire n3046_o;
  wire [31:0] n3047_o;
  wire n3049_o;
  wire n3050_o;
  wire n3051_o;
  wire n3054_o;
  wire [30:0] n3057_o;
  wire n3058_o;
  wire n3060_o;
  wire n3061_o;
  wire n3063_o;
  wire [31:0] n3064_o;
  wire n3066_o;
  wire [31:0] n3067_o;
  wire n3069_o;
  wire n3070_o;
  wire [31:0] n3071_o;
  wire n3073_o;
  wire [31:0] n3074_o;
  wire n3076_o;
  wire n3077_o;
  wire n3078_o;
  wire n3081_o;
  wire [30:0] n3084_o;
  wire n3085_o;
  wire n3087_o;
  wire n3088_o;
  wire n3090_o;
  wire [30:0] n3096_o;
  wire [1:0] n3097_o;
  wire n3099_o;
  wire [1:0] n3100_o;
  wire [11:0] n3101_o;
  wire [11:0] n3102_o;
  wire n3103_o;
  wire n3104_o;
  wire n3105_o;
  wire n3106_o;
  wire n3107_o;
  wire n3108_o;
  wire n3109_o;
  wire n3110_o;
  wire n3111_o;
  wire n3113_o;
  wire [1:0] n3114_o;
  wire n3115_o;
  wire n3116_o;
  wire n3117_o;
  wire n3118_o;
  wire n3119_o;
  wire n3120_o;
  wire n3121_o;
  wire n3123_o;
  wire [1:0] n3124_o;
  wire n3125_o;
  wire [1:0] n3126_o;
  wire [1:0] n3127_o;
  wire n3128_o;
  wire n3129_o;
  wire [1:0] n3131_o;
  wire [1:0] n3133_o;
  wire [1:0] n3135_o;
  wire [1:0] n3137_o;
  wire [5:0] n3138_o;
  wire [11:0] n3139_o;
  wire [11:0] n3140_o;
  wire n3142_o;
  wire n3144_o;
  wire [2:0] n3145_o;
  wire [14:0] n3146_o;
  wire n3148_o;
  wire [31:0] n3149_o;
  wire [31:0] n3151_o;
  wire [14:0] n3152_o;
  wire n3154_o;
  wire [31:0] n3155_o;
  wire [31:0] n3157_o;
  wire [14:0] n3158_o;
  wire n3160_o;
  wire [31:0] n3161_o;
  wire [31:0] n3163_o;
  wire [14:0] n3164_o;
  wire [2:0] n3165_o;
  reg [14:0] n3166_o;
  wire [31:0] n3167_o;
  wire [31:0] n3169_o;
  wire [31:0] n3171_o;
  wire [14:0] n3172_o;
  wire [31:0] n3173_o;
  wire [31:0] n3175_o;
  wire [4:0] n3176_o;
  wire n3178_o;
  wire n3179_o;
  wire [13:0] n3181_o;
  wire [5:0] n3183_o;
  wire [13:0] n3184_o;
  wire [13:0] n3185_o;
  wire n3187_o;
  wire [2:0] n3189_o;
  wire [2:0] n3190_o;
  wire [1:0] n3191_o;
  wire n3193_o;
  wire [2:0] n3195_o;
  wire [2:0] n3196_o;
  wire [1:0] n3197_o;
  wire n3198_o;
  wire n3199_o;
  wire n3200_o;
  wire n3201_o;
  wire n3202_o;
  wire n3203_o;
  wire [31:0] n3204_o;
  wire [31:0] n3205_o;
  wire n3206_o;
  wire [1:0] n3208_o;
  wire n3210_o;
  wire n3212_o;
  wire n3213_o;
  wire n3214_o;
  wire [31:0] n3216_o;
  wire [31:0] n3217_o;
  wire n3218_o;
  wire [31:0] n3219_o;
  wire [31:0] n3220_o;
  wire n3221_o;
  wire n3222_o;
  wire n3229_o;
  wire [31:0] n3230_o;
  wire [31:0] n3231_o;
  wire [31:0] n3232_o;
  wire [31:0] n3234_o;
  wire [12:0] n3235_o;
  wire [31:0] n3237_o;
  wire [31:0] n3238_o;
  wire [31:0] n3239_o;
  wire [31:0] n3241_o;
  wire [12:0] n3242_o;
  wire [1:0] n3245_o;
  wire n3247_o;
  wire n3249_o;
  wire [31:0] n3250_o;
  wire [31:0] n3251_o;
  wire [31:0] n3253_o;
  wire [31:0] n3254_o;
  wire [31:0] n3256_o;
  wire [13:0] n3257_o;
  wire [31:0] n3259_o;
  wire n3261_o;
  wire [12:0] n3262_o;
  wire [12:0] n3263_o;
  wire [12:0] n3264_o;
  wire [31:0] n3265_o;
  wire n3267_o;
  wire [31:0] n3268_o;
  wire [31:0] n3269_o;
  wire [31:0] n3271_o;
  wire [31:0] n3272_o;
  wire [12:0] n3273_o;
  wire [12:0] n3275_o;
  wire [12:0] n3276_o;
  wire n3279_o;
  wire [31:0] n3280_o;
  wire [31:0] n3281_o;
  wire n3282_o;
  wire [31:0] n3283_o;
  wire [31:0] n3284_o;
  wire [31:0] n3286_o;
  wire [31:0] n3287_o;
  wire [12:0] n3288_o;
  wire [12:0] n3289_o;
  wire [12:0] n3290_o;
  wire [11:0] n3292_o;
  wire [1:0] n3294_o;
  wire n3296_o;
  wire [11:0] n3298_o;
  wire [11:0] n3299_o;
  wire n3300_o;
  wire [1:0] n3302_o;
  wire [1:0] n3303_o;
  wire n3304_o;
  wire n3306_o;
  wire n3313_o;
  wire n3314_o;
  wire [31:0] n3315_o;
  wire n3317_o;
  wire n3318_o;
  wire n3319_o;
  wire [31:0] n3320_o;
  wire n3322_o;
  wire n3323_o;
  wire [1:0] n3326_o;
  wire [1:0] n3327_o;
  wire n3329_o;
  wire [31:0] n3330_o;
  wire n3332_o;
  wire n3333_o;
  wire n3334_o;
  wire n3335_o;
  wire [1:0] n3337_o;
  wire n3338_o;
  wire n3339_o;
  wire n3342_o;
  wire [31:0] n3344_o;
  wire n3346_o;
  wire n3353_o;
  wire [31:0] n3355_o;
  wire [31:0] n3356_o;
  wire [31:0] n3358_o;
  wire n3359_o;
  wire n3366_o;
  wire [3:0] n3368_o;
  wire [31:0] n3369_o;
  wire [31:0] n3370_o;
  wire [2:0] n3375_o;
  wire [3:0] n3376_o;
  wire [30:0] n3377_o;
  wire n3379_o;
  wire [2:0] n3380_o;
  wire [30:0] n3381_o;
  wire n3383_o;
  wire [1:0] n3384_o;
  wire [30:0] n3385_o;
  wire [1:0] n3386_o;
  reg [30:0] n3387_o;
  wire [3:0] n3388_o;
  wire n3389_o;
  wire [3:0] n3391_o;
  wire n3393_o;
  wire [31:0] n3394_o;
  wire [31:0] n3396_o;
  wire [4:0] n3397_o;
  wire [31:0] n3398_o;
  wire [31:0] n3399_o;
  wire [31:0] n3401_o;
  wire n3402_o;
  wire [31:0] n3403_o;
  wire n3405_o;
  wire [31:0] n3406_o;
  wire [31:0] n3408_o;
  wire [1:0] n3409_o;
  wire [1:0] n3410_o;
  wire [1:0] n3413_o;
  wire [1:0] n3414_o;
  wire [1:0] n3415_o;
  wire [4:0] n3416_o;
  wire [1:0] n3417_o;
  wire n3419_o;
  wire [3:0] n3420_o;
  reg [1:0] n3422_o;
  reg n3426_o;
  reg [12:0] n3429_o;
  reg [12:0] n3431_o;
  reg n3433_o;
  reg n3436_o;
  reg n3440_o;
  reg n3442_o;
  reg [4:0] n3445_o;
  reg [1:0] n3447_o;
  reg n3449_o;
  reg n3452_o;
  reg [11:0] n3455_o;
  reg [1:0] n3457_o;
  reg n3460_o;
  reg n3463_o;
  reg n3465_o;
  reg n3467_o;
  reg [3:0] n3473_o;
  wire n3474_o;
  wire n3475_o;
  wire [30:0] n3476_o;
  wire [31:0] n3477_o;
  wire [30:0] n3478_o;
  wire [31:0] n3479_o;
  wire [31:0] n3480_o;
  wire [23:0] n3481_o;
  wire [31:0] n3482_o;
  wire n3484_o;
  wire [31:0] n3485_o;
  wire [31:0] n3487_o;
  wire [30:0] n3488_o;
  wire [31:0] n3489_o;
  wire [31:0] n3490_o;
  wire n3492_o;
  wire [31:0] n3493_o;
  wire [31:0] n3495_o;
  wire [30:0] n3496_o;
  wire [31:0] n3497_o;
  wire [31:0] n3498_o;
  wire [31:0] n3499_o;
  wire [31:0] n3500_o;
  wire [31:0] n3501_o;
  wire [31:0] n3503_o;
  wire [31:0] n3504_o;
  wire [30:0] n3505_o;
  wire [31:0] n3506_o;
  wire [1:0] n3509_o;
  wire n3516_o;
  wire n3519_o;
  wire n3522_o;
  wire [2:0] n3524_o;
  reg [3:0] n3525_o;
  wire [31:0] n3526_o;
  wire [3:0] n3528_o;
  wire [31:0] n3529_o;
  wire [3:0] n3531_o;
  wire [31:0] n3535_o;
  wire n3537_o;
  wire n3538_o;
  wire n3539_o;
  wire n3540_o;
  wire [3:0] n3541_o;
  wire [31:0] n3542_o;
  wire n3544_o;
  wire n3545_o;
  wire n3546_o;
  wire [1:0] n3549_o;
  wire [1:0] n3551_o;
  wire [3:0] n3552_o;
  wire [3:0] n3553_o;
  wire [31:0] n3554_o;
  wire [31:0] n3556_o;
  wire [3:0] n3557_o;
  wire n3558_o;
  wire [31:0] n3559_o;
  wire [3:0] n3560_o;
  wire [31:0] n3561_o;
  wire [31:0] n3562_o;
  wire [31:0] n3564_o;
  wire [11:0] n3565_o;
  wire [31:0] n3566_o;
  wire [31:0] n3567_o;
  wire [31:0] n3569_o;
  wire [31:0] n3570_o;
  wire [12:0] n3571_o;
  wire [11:0] n3572_o;
  wire [12:0] n3573_o;
  wire [12:0] n3574_o;
  wire [3:0] n3576_o;
  wire [1:0] n3578_o;
  wire n3580_o;
  wire n3582_o;
  wire [11:0] n3584_o;
  wire [11:0] n3586_o;
  wire n3587_o;
  wire n3588_o;
  wire [4:0] n3591_o;
  wire n3593_o;
  wire [11:0] n3595_o;
  wire [31:0] n3596_o;
  wire [31:0] n3598_o;
  wire [3:0] n3599_o;
  wire [2:0] n3606_o;
  wire [31:0] n3607_o;
  wire n3609_o;
  wire n3611_o;
  wire n3613_o;
  wire n3615_o;
  wire [31:0] n3616_o;
  wire [2:0] n3617_o;
  wire [31:0] n3618_o;
  wire n3620_o;
  wire n3622_o;
  wire n3624_o;
  wire n3626_o;
  wire [31:0] n3627_o;
  wire n3629_o;
  wire [31:0] n3630_o;
  wire n3632_o;
  wire n3633_o;
  wire [31:0] n3634_o;
  wire n3636_o;
  wire n3637_o;
  wire n3639_o;
  wire n3641_o;
  wire n3643_o;
  wire [31:0] n3644_o;
  wire [1:0] n3645_o;
  wire [31:0] n3646_o;
  wire n3648_o;
  wire n3650_o;
  wire n3652_o;
  wire [2:0] n3653_o;
  reg n3654_o;
  wire [31:0] n3655_o;
  wire [31:0] n3657_o;
  wire [4:0] n3658_o;
  wire [4:0] n3660_o;
  wire [31:0] n3661_o;
  wire [31:0] n3663_o;
  wire [3:0] n3664_o;
  wire [31:0] n3665_o;
  wire n3667_o;
  wire [1:0] n3669_o;
  wire n3671_o;
  wire [31:0] n3672_o;
  wire n3674_o;
  wire [31:0] n3675_o;
  wire [31:0] n3676_o;
  wire [31:0] n3678_o;
  wire [31:0] n3679_o;
  wire [31:0] n3681_o;
  wire [13:0] n3682_o;
  wire [31:0] n3684_o;
  wire n3686_o;
  wire [31:0] n3687_o;
  wire [31:0] n3688_o;
  wire [31:0] n3690_o;
  wire [31:0] n3691_o;
  wire [12:0] n3692_o;
  wire [12:0] n3693_o;
  wire [31:0] n3694_o;
  wire [31:0] n3695_o;
  wire [31:0] n3697_o;
  wire [31:0] n3698_o;
  wire [31:0] n3700_o;
  wire [12:0] n3701_o;
  wire [12:0] n3703_o;
  wire [12:0] n3704_o;
  wire n3707_o;
  wire [31:0] n3708_o;
  wire [31:0] n3710_o;
  wire [11:0] n3711_o;
  wire [31:0] n3713_o;
  wire [31:0] n3715_o;
  wire [1:0] n3716_o;
  wire [12:0] n3717_o;
  wire [12:0] n3718_o;
  wire [1:0] n3719_o;
  wire [11:0] n3720_o;
  wire n3722_o;
  wire [31:0] n3724_o;
  wire n3726_o;
  wire n3728_o;
  wire n3729_o;
  wire [11:0] n3731_o;
  wire n3734_o;
  wire n3741_o;
  wire n3742_o;
  wire [11:0] n3743_o;
  wire [31:0] n3744_o;
  wire n3746_o;
  wire n3747_o;
  wire [31:0] n3748_o;
  wire [31:0] n3750_o;
  wire [3:0] n3751_o;
  wire [2:0] n3758_o;
  wire [31:0] n3759_o;
  wire n3761_o;
  wire n3763_o;
  wire n3765_o;
  wire n3767_o;
  wire [31:0] n3768_o;
  wire [2:0] n3769_o;
  wire [31:0] n3770_o;
  wire n3772_o;
  wire n3774_o;
  wire n3776_o;
  wire n3778_o;
  wire [31:0] n3779_o;
  wire n3781_o;
  wire [31:0] n3782_o;
  wire n3784_o;
  wire n3785_o;
  wire [31:0] n3786_o;
  wire n3788_o;
  wire n3789_o;
  wire n3791_o;
  wire n3793_o;
  wire n3795_o;
  wire [31:0] n3796_o;
  wire [1:0] n3797_o;
  wire [31:0] n3798_o;
  wire n3800_o;
  wire n3802_o;
  wire n3804_o;
  wire [2:0] n3805_o;
  reg n3806_o;
  wire [31:0] n3807_o;
  wire [31:0] n3809_o;
  wire [4:0] n3810_o;
  wire [4:0] n3812_o;
  wire [31:0] n3814_o;
  wire [31:0] n3816_o;
  wire [3:0] n3817_o;
  wire [2:0] n3823_o;
  wire [31:0] n3824_o;
  wire n3826_o;
  wire n3828_o;
  wire n3830_o;
  wire n3832_o;
  wire [31:0] n3833_o;
  wire [2:0] n3834_o;
  wire [31:0] n3835_o;
  wire n3837_o;
  wire n3839_o;
  wire n3841_o;
  wire n3843_o;
  wire [31:0] n3844_o;
  wire n3846_o;
  wire [31:0] n3847_o;
  wire n3849_o;
  wire n3850_o;
  wire [31:0] n3851_o;
  wire n3853_o;
  wire n3854_o;
  wire n3856_o;
  wire n3858_o;
  wire n3860_o;
  wire [31:0] n3861_o;
  wire [1:0] n3862_o;
  wire [31:0] n3863_o;
  wire n3865_o;
  wire n3867_o;
  wire n3869_o;
  wire [2:0] n3870_o;
  reg n3871_o;
  wire n3872_o;
  wire [31:0] n3873_o;
  wire [3:0] n3874_o;
  wire [31:0] n3875_o;
  wire n3877_o;
  wire n3878_o;
  wire n3879_o;
  wire n3880_o;
  wire n3881_o;
  wire n3882_o;
  wire [1:0] n3884_o;
  wire n3887_o;
  wire [31:0] n3888_o;
  wire [3:0] n3889_o;
  wire [31:0] n3890_o;
  wire n3892_o;
  wire n3894_o;
  wire n3895_o;
  wire n3896_o;
  wire n3897_o;
  wire n3900_o;
  wire [3:0] n3901_o;
  wire n3902_o;
  wire n3903_o;
  wire n3905_o;
  wire n3907_o;
  wire [2:0] n3908_o;
  reg [1:0] n3910_o;
  reg [3:0] n3912_o;
  wire n3913_o;
  reg n3915_o;
  reg [4:0] n3917_o;
  reg n3920_o;
  reg n3924_o;
  reg [11:0] n3927_o;
  reg [12:0] n3929_o;
  reg [12:0] n3931_o;
  reg [3:0] n3933_o;
  reg [1:0] n3935_o;
  reg n3937_o;
  reg n3939_o;
  reg n3941_o;
  reg n3943_o;
  reg [3:0] n3945_o;
  reg [11:0] n3947_o;
  reg [11:0] n3949_o;
  reg n3952_o;
  wire [2:0] n3964_o;
  wire [31:0] n3965_o;
  wire n3967_o;
  wire n3969_o;
  wire n3971_o;
  wire [15:0] n3972_o;
  wire [143:0] n3973_o;
  wire [135:0] n3974_o;
  wire [7:0] n3975_o;
  wire [143:0] n3976_o;
  wire [143:0] n3977_o;
  wire n3979_o;
  wire [31:0] n3980_o;
  wire [2:0] n3981_o;
  wire [31:0] n3982_o;
  wire n3984_o;
  wire n3986_o;
  wire n3988_o;
  wire [15:0] n3989_o;
  wire [143:0] n3990_o;
  wire [127:0] n3991_o;
  wire [15:0] n3992_o;
  wire [143:0] n3993_o;
  wire [143:0] n3994_o;
  wire n3996_o;
  wire [31:0] n3997_o;
  wire n3999_o;
  wire [15:0] n4000_o;
  wire [143:0] n4001_o;
  wire [31:0] n4002_o;
  wire n4004_o;
  wire [7:0] n4005_o;
  wire [135:0] n4006_o;
  wire [7:0] n4007_o;
  wire [143:0] n4008_o;
  wire [31:0] n4009_o;
  wire n4011_o;
  wire [15:0] n4012_o;
  wire [143:0] n4013_o;
  wire [119:0] n4014_o;
  wire [23:0] n4015_o;
  wire [143:0] n4016_o;
  wire [143:0] n4017_o;
  wire [143:0] n4018_o;
  wire [143:0] n4019_o;
  wire n4021_o;
  wire [31:0] n4022_o;
  wire [1:0] n4023_o;
  wire [31:0] n4024_o;
  wire n4026_o;
  wire n4028_o;
  wire n4030_o;
  wire [15:0] n4031_o;
  wire [143:0] n4032_o;
  wire [111:0] n4033_o;
  wire [31:0] n4034_o;
  wire [143:0] n4035_o;
  wire [143:0] n4036_o;
  wire [2:0] n4037_o;
  reg [143:0] n4038_o;
  wire [3:0] n4045_o;
  wire [4:0] n4046_o;
  wire [2:0] n4047_o;
  wire [7:0] n4048_o;
  wire [2:0] n4049_o;
  wire [2:0] n4050_o;
  wire [5:0] n4051_o;
  wire [1:0] n4052_o;
  wire [7:0] n4053_o;
  wire [4:0] n4054_o;
  wire [2:0] n4055_o;
  wire [7:0] n4056_o;
  wire [23:0] n4057_o;
  wire n4059_o;
  wire [4:0] n4060_o;
  wire [2:0] n4061_o;
  wire [7:0] n4062_o;
  wire [1:0] n4063_o;
  wire [2:0] n4064_o;
  wire [4:0] n4065_o;
  wire [1:0] n4066_o;
  wire [6:0] n4067_o;
  wire n4068_o;
  wire [7:0] n4069_o;
  wire [4:0] n4070_o;
  wire [2:0] n4071_o;
  wire [7:0] n4072_o;
  wire [23:0] n4073_o;
  wire n4075_o;
  wire [7:0] n4076_o;
  wire [7:0] n4077_o;
  wire [7:0] n4078_o;
  wire [23:0] n4079_o;
  wire n4081_o;
  wire n4083_o;
  wire n4084_o;
  wire [7:0] n4085_o;
  wire [7:0] n4086_o;
  wire [7:0] n4087_o;
  wire [23:0] n4088_o;
  wire [2:0] n4089_o;
  reg [23:0] n4090_o;
  wire n4094_o;
  wire [7:0] n4095_o;
  wire [7:0] n4096_o;
  wire [7:0] n4097_o;
  wire [23:0] n4098_o;
  wire [23:0] n4099_o;
  wire [2:0] n4100_o;
  wire n4102_o;
  wire [7:0] n4103_o;
  wire [7:0] n4104_o;
  wire [7:0] n4105_o;
  wire [23:0] n4106_o;
  wire [23:0] n4107_o;
  wire n4109_o;
  wire [23:0] n4110_o;
  wire [23:0] n4111_o;
  wire [23:0] n4112_o;
  wire n4113_o;
  wire n4119_o;
  wire n4120_o;
  wire [31:0] n4121_o;
  wire [31:0] n4123_o;
  wire [1:0] n4124_o;
  wire n4125_o;
  wire n4126_o;
  wire [31:0] n4127_o;
  wire [31:0] n4129_o;
  wire [1:0] n4130_o;
  wire [1:0] n4131_o;
  wire [1:0] n4132_o;
  wire n4133_o;
  wire n4134_o;
  wire [31:0] n4135_o;
  wire [31:0] n4137_o;
  wire [1:0] n4138_o;
  wire n4139_o;
  wire n4140_o;
  wire [31:0] n4141_o;
  wire [31:0] n4143_o;
  wire [1:0] n4144_o;
  wire [1:0] n4145_o;
  wire [1:0] n4146_o;
  wire [1:0] n4147_o;
  wire [1:0] n4148_o;
  wire [1:0] n4149_o;
  wire [7:0] n4150_o;
  wire [1:0] n4151_o;
  wire [1:0] n4152_o;
  wire [1:0] n4153_o;
  wire [1:0] n4154_o;
  wire [1:0] n4155_o;
  wire [1:0] n4156_o;
  wire [7:0] n4157_o;
  wire [7:0] n4158_o;
  wire [31:0] n4159_o;
  wire n4161_o;
  wire [31:0] n4162_o;
  wire n4164_o;
  wire n4165_o;
  wire n4166_o;
  wire [31:0] n4167_o;
  wire n4169_o;
  wire n4170_o;
  wire n4171_o;
  wire [31:0] n4172_o;
  wire n4174_o;
  wire n4175_o;
  wire n4176_o;
  wire n4177_o;
  wire n4178_o;
  wire n4179_o;
  wire n4180_o;
  wire n4181_o;
  wire n4182_o;
  wire n4183_o;
  wire n4184_o;
  wire n4185_o;
  wire n4186_o;
  wire n4187_o;
  wire n4188_o;
  wire [3:0] n4189_o;
  wire [3:0] n4190_o;
  wire [3:0] n4191_o;
  wire [3:0] n4192_o;
  wire n4193_o;
  wire n4194_o;
  wire n4195_o;
  wire n4196_o;
  wire n4197_o;
  wire n4198_o;
  wire n4199_o;
  wire n4200_o;
  wire n4201_o;
  wire n4202_o;
  wire n4203_o;
  wire n4204_o;
  wire n4205_o;
  wire n4206_o;
  wire n4207_o;
  wire n4208_o;
  wire n4209_o;
  wire n4210_o;
  wire n4211_o;
  wire n4212_o;
  wire n4213_o;
  wire n4214_o;
  wire n4215_o;
  wire n4216_o;
  wire [3:0] n4217_o;
  wire [3:0] n4218_o;
  wire [3:0] n4219_o;
  wire [3:0] n4220_o;
  wire [3:0] n4221_o;
  wire [3:0] n4222_o;
  wire [3:0] n4223_o;
  wire [3:0] n4224_o;
  wire [2:0] n4225_o;
  wire n4226_o;
  wire [2:0] n4227_o;
  wire [2:0] n4228_o;
  wire [2:0] n4229_o;
  wire n4230_o;
  wire [2:0] n4231_o;
  wire [2:0] n4232_o;
  wire [2:0] n4233_o;
  wire n4234_o;
  wire [2:0] n4235_o;
  wire [2:0] n4236_o;
  wire [11:0] n4237_o;
  wire [3:0] n4238_o;
  wire [11:0] n4239_o;
  wire [11:0] n4240_o;
  wire [4:0] n4244_o;
  wire [4:0] n4246_o;
  wire n4508_o;
  wire n4509_o;
  reg n4510_q;
  wire n4511_o;
  wire n4512_o;
  reg n4513_q;
  wire n4514_o;
  wire [4:0] n4515_o;
  reg [4:0] n4516_q;
  wire n4517_o;
  wire [4:0] n4518_o;
  reg [4:0] n4519_q;
  wire n4520_o;
  wire [4:0] n4521_o;
  reg [4:0] n4522_q;
  wire n4523_o;
  wire [5:0] n4524_o;
  reg [5:0] n4525_q;
  wire n4526_o;
  wire [11:0] n4527_o;
  reg [11:0] n4528_q;
  wire n4529_o;
  wire [11:0] n4530_o;
  reg [11:0] n4531_q;
  wire n4532_o;
  wire [11:0] n4533_o;
  reg [11:0] n4534_q;
  wire n4535_o;
  wire [11:0] n4536_o;
  reg [11:0] n4537_q;
  wire n4538_o;
  wire [11:0] n4539_o;
  reg [11:0] n4540_q;
  wire n4541_o;
  wire [11:0] n4542_o;
  reg [11:0] n4543_q;
  wire n4544_o;
  wire [11:0] n4545_o;
  reg [11:0] n4546_q;
  wire n4547_o;
  wire [11:0] n4548_o;
  reg [11:0] n4549_q;
  wire n4550_o;
  wire [11:0] n4551_o;
  reg [11:0] n4552_q;
  wire n4553_o;
  wire [11:0] n4554_o;
  reg [11:0] n4555_q;
  wire n4556_o;
  wire [11:0] n4557_o;
  reg [11:0] n4558_q;
  wire n4559_o;
  wire n4560_o;
  reg n4561_q;
  wire n4562_o;
  wire n4563_o;
  reg n4564_q;
  wire n4565_o;
  wire n4566_o;
  reg n4567_q;
  wire n4568_o;
  wire [11:0] n4569_o;
  reg [11:0] n4570_q;
  wire n4571_o;
  wire [11:0] n4572_o;
  reg [11:0] n4573_q;
  wire n4574_o;
  wire [11:0] n4575_o;
  reg [11:0] n4576_q;
  wire n4577_o;
  wire [11:0] n4578_o;
  reg [11:0] n4579_q;
  wire n4580_o;
  wire n4581_o;
  reg n4582_q;
  wire n4583_o;
  wire n4584_o;
  reg n4585_q;
  wire n4586_o;
  wire n4587_o;
  reg n4588_q;
  wire n4589_o;
  wire n4590_o;
  reg n4591_q;
  wire n4592_o;
  wire n4593_o;
  reg n4594_q;
  wire n4595_o;
  wire n4596_o;
  reg n4597_q;
  wire n4598_o;
  wire n4599_o;
  reg n4600_q;
  wire n4601_o;
  wire [1:0] n4602_o;
  reg [1:0] n4603_q;
  wire n4604_o;
  wire [1:0] n4605_o;
  reg [1:0] n4606_q;
  wire n4607_o;
  wire [1:0] n4608_o;
  reg [1:0] n4609_q;
  wire n4610_o;
  wire [1:0] n4611_o;
  reg [1:0] n4612_q;
  reg [1:0] n4613_q;
  reg [1:0] n4614_q;
  wire n4615_o;
  wire [3:0] n4616_o;
  reg [3:0] n4617_q;
  wire n4618_o;
  wire n4619_o;
  reg n4620_q;
  wire n4621_o;
  wire n4622_o;
  reg n4623_q;
  wire n4624_o;
  wire n4625_o;
  reg n4626_q;
  wire n4627_o;
  wire n4628_o;
  reg n4629_q;
  wire n4630_o;
  wire n4631_o;
  reg n4632_q;
  wire n4633_o;
  wire n4634_o;
  reg n4635_q;
  wire n4636_o;
  wire n4637_o;
  wire n4638_o;
  reg n4639_q;
  wire n4640_o;
  wire n4641_o;
  wire [31:0] n4642_o;
  reg [31:0] n4643_q;
  wire n4644_o;
  wire [23:0] n4645_o;
  reg [23:0] n4646_q;
  wire n4647_o;
  wire [13:0] n4648_o;
  reg [13:0] n4649_q;
  wire n4650_o;
  wire n4651_o;
  reg n4652_q;
  wire n4653_o;
  wire n4654_o;
  reg n4655_q;
  wire n4656_o;
  wire n4657_o;
  reg n4658_q;
  wire n4659_o;
  wire [4:0] n4660_o;
  reg [4:0] n4661_q;
  wire n4662_o;
  wire [4:0] n4663_o;
  reg [4:0] n4664_q;
  wire n4665_o;
  wire [4:0] n4666_o;
  reg [4:0] n4667_q;
  wire n4668_o;
  wire [4:0] n4669_o;
  reg [4:0] n4670_q;
  wire n4671_o;
  wire n4672_o;
  reg n4673_q;
  wire n4674_o;
  wire n4675_o;
  wire [143:0] n4676_o;
  reg [143:0] n4677_q;
  wire n4678_o;
  wire n4679_o;
  reg n4680_q;
  wire n4681_o;
  wire n4682_o;
  reg n4683_q;
  wire n4684_o;
  wire n4685_o;
  reg n4686_q;
  wire n4687_o;
  wire n4688_o;
  reg n4689_q;
  wire n4690_o;
  wire n4691_o;
  reg n4692_q;
  wire n4693_o;
  wire [11:0] n4694_o;
  reg [11:0] n4695_q;
  wire n4696_o;
  wire [11:0] n4697_o;
  reg [11:0] n4698_q;
  wire n4699_o;
  wire [11:0] n4700_o;
  reg [11:0] n4701_q;
  wire n4702_o;
  wire [14:0] n4703_o;
  reg [14:0] n4704_q;
  wire n4705_o;
  wire [14:0] n4706_o;
  reg [14:0] n4707_q;
  wire n4708_o;
  wire [12:0] n4709_o;
  reg [12:0] n4710_q;
  wire n4711_o;
  wire [12:0] n4712_o;
  reg [12:0] n4713_q;
  wire n4714_o;
  wire [12:0] n4715_o;
  reg [12:0] n4716_q;
  wire n4717_o;
  wire [12:0] n4718_o;
  reg [12:0] n4719_q;
  wire n4720_o;
  wire [12:0] n4721_o;
  reg [12:0] n4722_q;
  wire n4723_o;
  wire [12:0] n4724_o;
  reg [12:0] n4725_q;
  reg n4726_q;
  wire n4727_o;
  wire n4728_o;
  reg n4729_q;
  wire n4730_o;
  wire n4731_o;
  reg n4732_q;
  wire n4733_o;
  wire n4734_o;
  reg n4735_q;
  reg n4736_q;
  reg [1:0] n4737_q;
  reg [1:0] n4738_q;
  wire n4739_o;
  wire [4:0] n4740_o;
  reg [4:0] n4741_q;
  wire n4742_o;
  wire [4:0] n4743_o;
  reg [4:0] n4744_q;
  wire n4745_o;
  wire [1:0] n4746_o;
  reg [1:0] n4747_q;
  wire n4748_o;
  wire [3:0] n4749_o;
  reg [3:0] n4750_q;
  wire n4751_o;
  wire [3:0] n4752_o;
  reg [3:0] n4753_q;
  wire n4754_o;
  wire [3:0] n4755_o;
  reg [3:0] n4756_q;
  wire n4757_o;
  wire [3:0] n4758_o;
  reg [3:0] n4759_q;
  wire n4760_o;
  wire [3:0] n4761_o;
  reg [3:0] n4762_q;
  wire n4763_o;
  wire [1:0] n4764_o;
  reg [1:0] n4765_q;
  wire n4766_o;
  wire n4767_o;
  reg n4768_q;
  wire n4769_o;
  wire n4770_o;
  reg n4771_q;
  wire n4772_o;
  wire n4773_o;
  reg n4774_q;
  wire n4775_o;
  wire n4776_o;
  reg n4777_q;
  wire n4778_o;
  wire n4779_o;
  reg n4780_q;
  wire n4781_o;
  wire n4782_o;
  reg n4783_q;
  wire n4784_o;
  wire n4785_o;
  reg n4786_q;
  wire n4787_o;
  wire n4788_o;
  reg n4789_q;
  wire n4790_o;
  wire n4791_o;
  wire [3:0] n4792_o;
  reg [3:0] n4793_q;
  wire n4794_o;
  wire [3:0] n4795_o;
  reg [3:0] n4796_q;
  wire n4797_o;
  wire n4798_o;
  reg n4799_q;
  wire n4800_o;
  wire n4801_o;
  reg n4802_q;
  wire n4803_o;
  wire [2:0] n4804_o;
  reg [2:0] n4805_q;
  wire n4806_o;
  wire [2:0] n4807_o;
  reg [2:0] n4808_q;
  wire n4809_o;
  wire [2:0] n4810_o;
  reg [2:0] n4811_q;
  wire n4812_o;
  wire [11:0] n4813_o;
  reg [11:0] n4814_q;
  wire n4815_o;
  wire n4816_o;
  reg n4817_q;
  wire n4818_o;
  wire [11:0] n4819_o;
  reg [11:0] n4820_q;
  wire n4821_o;
  wire n4822_o;
  wire [23:0] n4823_o;
  reg [23:0] n4824_q;
  wire n4825_o;
  wire n4826_o;
  wire [23:0] n4827_o;
  reg [23:0] n4828_q;
  wire n4829_o;
  wire n4830_o;
  wire [23:0] n4831_o;
  reg [23:0] n4832_q;
  wire n4833_o;
  wire n4834_o;
  wire [23:0] n4835_o;
  reg [23:0] n4836_q;
  wire n4837_o;
  wire n4838_o;
  wire [23:0] n4839_o;
  reg [23:0] n4840_q;
  wire n4841_o;
  wire n4842_o;
  reg n4843_q;
  wire n4844_o;
  wire n4845_o;
  reg n4846_q;
  wire n4847_o;
  wire [11:0] n4848_o;
  reg [11:0] n4849_q;
  wire n4850_o;
  wire [11:0] n4851_o;
  reg [11:0] n4852_q;
  wire n4853_o;
  wire [1:0] n4854_o;
  reg [1:0] n4855_q;
  wire n4862_o;
  wire n4863_o;
  reg n4864_q;
  wire n4865_o;
  wire n4866_o;
  reg n4867_q;
  wire n4868_o;
  wire n4869_o;
  reg n4870_q;
  wire n4888_o;
  wire [3:0] n4889_o;
  reg [3:0] n4890_q;
  wire [3:0] n4895_o;
  wire [3:0] n4896_o;
  wire [2:0] n4898_o;
  wire n4900_o;
  wire n4901_o;
  wire n4908_o;
  wire [2:0] n4910_o;
  wire n4912_o;
  wire n4913_o;
  wire n4920_o;
  wire [3:0] n4921_o;
  wire [2:0] n4923_o;
  wire n4925_o;
  wire [3:0] n4928_o;
  wire [9:0] n4936_o;
  wire [9:0] n4939_o;
  wire [9:0] n4941_o;
  wire [9:0] n4943_o;
  wire [39:0] n4944_o;
  wire n4951_o;
  wire n4952_o;
  wire [39:0] n4955_o;
  wire [39:0] n4957_o;
  wire [2:0] n4958_o;
  wire n4960_o;
  wire [3:0] n4964_o;
  wire [9:0] n4972_o;
  wire [9:0] n4975_o;
  wire [9:0] n4977_o;
  wire [9:0] n4979_o;
  wire [39:0] n4980_o;
  wire n4987_o;
  wire n4988_o;
  wire [39:0] n4991_o;
  wire [39:0] n4993_o;
  wire [7:0] n5000_o;
  wire [7:0] n5001_o;
  wire n5002_o;
  wire [7:0] n5003_o;
  wire [7:0] n5004_o;
  wire [7:0] n5005_o;
  wire [7:0] n5007_o;
  wire n5008_o;
  wire [7:0] n5009_o;
  wire [7:0] n5010_o;
  wire [7:0] n5017_o;
  wire [7:0] n5018_o;
  wire n5019_o;
  wire [7:0] n5020_o;
  wire [7:0] n5021_o;
  wire [7:0] n5022_o;
  wire [7:0] n5024_o;
  wire n5025_o;
  wire [7:0] n5026_o;
  wire [7:0] n5027_o;
  wire [3:0] n5029_o;
  wire [7:0] n5030_o;
  wire [3:0] n5031_o;
  wire [7:0] n5032_o;
  wire [3:0] n5035_o;
  wire [9:0] n5043_o;
  wire [9:0] n5046_o;
  wire [9:0] n5048_o;
  wire [9:0] n5050_o;
  wire [39:0] n5051_o;
  wire [39:0] n5052_o;
  wire [39:0] n5053_o;
  wire [9:0] n5054_o;
  wire [9:0] n5056_o;
  wire [9:0] n5057_o;
  wire [9:0] n5068_o;
  wire [19:0] n5069_o;
  wire [19:0] n5070_o;
  wire [19:0] n5071_o;
  wire [9:0] n5072_o;
  wire [19:0] n5073_o;
  wire [19:0] n5074_o;
  wire [19:0] n5075_o;
  wire [19:0] n5076_o;
  wire [9:0] n5078_o;
  wire [19:0] n5079_o;
  wire [19:0] n5080_o;
  wire [19:0] n5081_o;
  wire [9:0] n5082_o;
  wire [19:0] n5083_o;
  wire [19:0] n5084_o;
  wire [19:0] n5085_o;
  wire [19:0] n5086_o;
  wire [9:0] n5088_o;
  wire [19:0] n5089_o;
  wire [19:0] n5090_o;
  wire [19:0] n5091_o;
  wire [9:0] n5092_o;
  wire [19:0] n5093_o;
  wire [19:0] n5094_o;
  wire [19:0] n5095_o;
  wire [19:0] n5096_o;
  wire [9:0] n5098_o;
  wire [19:0] n5099_o;
  wire [19:0] n5100_o;
  wire [19:0] n5101_o;
  wire [9:0] n5102_o;
  wire [19:0] n5103_o;
  wire [19:0] n5104_o;
  wire [19:0] n5105_o;
  wire [19:0] n5106_o;
  wire [17:0] n5108_o;
  wire [17:0] n5111_o;
  wire [17:0] n5113_o;
  wire [17:0] n5115_o;
  wire [71:0] n5116_o;
  wire [9:0] n5123_o;
  wire [16:0] n5125_o;
  wire [17:0] n5126_o;
  wire [9:0] n5129_o;
  wire [16:0] n5131_o;
  wire [17:0] n5132_o;
  wire [9:0] n5134_o;
  wire [16:0] n5136_o;
  wire [17:0] n5137_o;
  wire [9:0] n5139_o;
  wire [16:0] n5141_o;
  wire [17:0] n5142_o;
  wire [71:0] n5143_o;
  wire [9:0] n5150_o;
  wire [16:0] n5152_o;
  wire [17:0] n5153_o;
  wire [9:0] n5156_o;
  wire [16:0] n5158_o;
  wire [17:0] n5159_o;
  wire [9:0] n5161_o;
  wire [16:0] n5163_o;
  wire [17:0] n5164_o;
  wire [9:0] n5166_o;
  wire [16:0] n5168_o;
  wire [17:0] n5169_o;
  wire [71:0] n5170_o;
  wire [71:0] n5171_o;
  wire [71:0] n5172_o;
  wire [71:0] n5173_o;
  reg [3:0] n5203_q;
  reg [3:0] n5204_q;
  reg [39:0] n5205_q;
  reg [39:0] n5206_q;
  reg [39:0] n5207_q;
  reg [39:0] n5208_q;
  reg [39:0] n5209_q;
  reg [39:0] n5210_q;
  reg [39:0] n5211_q;
  reg [39:0] n5212_q;
  reg [39:0] n5213_q;
  reg [39:0] n5214_q;
  reg [39:0] n5215_q;
  reg [39:0] n5216_q;
  reg [39:0] n5217_q;
  reg [39:0] n5218_q;
  reg [71:0] n5219_q;
  reg [71:0] n5220_q;
  reg [71:0] n5221_q;
  reg [71:0] n5222_q;
  reg [7:0] n5223_q;
  reg [7:0] n5224_q;
  reg [9:0] n5225_q;
  reg [9:0] n5226_q;
  reg n5227_q;
  reg n5228_q;
  reg [47:0] n5245_q;
  wire [2:0] n5253_o;
  wire [31:0] n5254_o;
  wire n5256_o;
  wire n5258_o;
  wire n5260_o;
  wire [15:0] n5261_o;
  wire [143:0] n5262_o;
  wire [135:0] n5263_o;
  wire [7:0] n5264_o;
  wire [143:0] n5265_o;
  wire [143:0] n5266_o;
  wire n5268_o;
  wire [31:0] n5269_o;
  wire [2:0] n5270_o;
  wire [31:0] n5271_o;
  wire n5273_o;
  wire n5275_o;
  wire n5277_o;
  wire [15:0] n5278_o;
  wire [143:0] n5279_o;
  wire [127:0] n5280_o;
  wire [15:0] n5281_o;
  wire [143:0] n5282_o;
  wire [143:0] n5283_o;
  wire n5285_o;
  wire [31:0] n5286_o;
  wire n5288_o;
  wire [15:0] n5289_o;
  wire [143:0] n5290_o;
  wire [31:0] n5291_o;
  wire n5293_o;
  wire [7:0] n5294_o;
  wire [135:0] n5295_o;
  wire [7:0] n5296_o;
  wire [143:0] n5297_o;
  wire [31:0] n5298_o;
  wire n5300_o;
  wire [15:0] n5301_o;
  wire [143:0] n5302_o;
  wire [119:0] n5303_o;
  wire [23:0] n5304_o;
  wire [143:0] n5305_o;
  wire [143:0] n5306_o;
  wire [143:0] n5307_o;
  wire [143:0] n5308_o;
  wire n5310_o;
  wire [31:0] n5311_o;
  wire [1:0] n5312_o;
  wire [31:0] n5313_o;
  wire n5315_o;
  wire n5317_o;
  wire n5319_o;
  wire [15:0] n5320_o;
  wire [143:0] n5321_o;
  wire [111:0] n5322_o;
  wire [31:0] n5323_o;
  wire [143:0] n5324_o;
  wire [143:0] n5325_o;
  wire [2:0] n5326_o;
  reg [143:0] n5327_o;
  wire [7:0] n5329_o;
  wire n5330_o;
  reg n5333_q;
  wire [6:0] n5334_o;
  reg [23:0] n5359_q;
  wire [23:0] n5369_o;
  wire [23:0] n5370_o;
  wire [23:0] n5371_o;
  wire [23:0] n5372_o;
  wire n5374_o;
  wire [1:0] n5375_o;
  wire [1:0] n5392_o;
  wire n5396_o;
  wire n5397_o;
  wire n5398_o;
  wire n5399_o;
  wire n5400_o;
  wire n5401_o;
  wire n5402_o;
  wire n5405_o;
  wire [3:0] n5406_o;
  wire [3:0] n5409_o;
  wire n5413_o;
  wire [3:0] n5416_o;
  wire n5420_o;
  wire [3:0] n5423_o;
  wire n5427_o;
  wire [3:0] n5430_o;
  wire n5434_o;
  wire [3:0] n5435_o;
  reg [639:0] n5436_o;
  reg [639:0] n5437_o;
  reg [639:0] n5438_o;
  reg n5441_o;
  reg n5444_o;
  wire [2:0] n5450_o;
  reg [639:0] n5455_q;
  reg [639:0] n5456_q;
  reg [639:0] n5457_q;
  reg n5458_q;
  reg n5459_q;
  reg [2:0] n5460_q;
  wire n5461_o;
  reg [3:0] n5462_q;
  wire [31:0] n5467_o;
  wire [31:0] n5469_o;
  wire [30:0] n5470_o;
  wire [20:0] n5471_o;
  wire [31:0] n5472_o;
  wire [31:0] n5474_o;
  wire [30:0] n5475_o;
  wire [20:0] n5476_o;
  wire [20:0] n5477_o;
  wire n5478_o;
  wire n5479_o;
  localparam [11:0] n5480_o = 12'b000000000000;
  wire n5482_o;
  wire n5483_o;
  wire [31:0] n5484_o;
  wire [31:0] n5486_o;
  wire [30:0] n5487_o;
  wire [20:0] n5488_o;
  wire [20:0] n5489_o;
  wire [31:0] n5490_o;
  wire [31:0] n5492_o;
  wire [30:0] n5493_o;
  wire [20:0] n5494_o;
  wire [20:0] n5495_o;
  wire [20:0] n5496_o;
  wire n5497_o;
  wire n5498_o;
  wire [9:0] n5499_o;
  wire [11:0] n5500_o;
  wire [20:0] n5501_o;
  wire n5503_o;
  wire n5504_o;
  wire [31:0] n5505_o;
  wire [31:0] n5507_o;
  wire [30:0] n5508_o;
  wire [20:0] n5509_o;
  wire [20:0] n5510_o;
  wire [31:0] n5511_o;
  wire [31:0] n5513_o;
  wire [30:0] n5514_o;
  wire [20:0] n5515_o;
  wire [20:0] n5516_o;
  wire [20:0] n5517_o;
  wire n5518_o;
  wire n5519_o;
  wire [1:0] n5520_o;
  wire n5522_o;
  wire n5523_o;
  wire [31:0] n5524_o;
  wire [31:0] n5526_o;
  wire [30:0] n5527_o;
  wire [20:0] n5528_o;
  wire [20:0] n5529_o;
  wire [31:0] n5530_o;
  wire [31:0] n5532_o;
  wire [30:0] n5533_o;
  wire [20:0] n5534_o;
  wire [20:0] n5535_o;
  wire [20:0] n5536_o;
  wire n5537_o;
  wire n5538_o;
  wire [7:0] n5539_o;
  wire [11:0] n5540_o;
  wire [20:0] n5541_o;
  wire [11:0] n5542_o;
  wire [11:0] n5544_o;
  wire [95:0] n5545_o;
  wire [11:0] n5547_o;
  wire [31:0] n5548_o;
  wire [31:0] n5549_o;
  wire n5550_o;
  wire n5552_o;
  wire n5553_o;
  wire n5554_o;
  wire [11:0] n5555_o;
  wire [11:0] n5556_o;
  wire [31:0] n5557_o;
  wire [10:0] n5558_o;
  wire [11:0] n5560_o;
  wire [143:0] n5561_o;
  wire [95:0] n5562_o;
  wire [575:0] n5563_o;
  wire [11:0] n5565_o;
  wire n5573_o;
  wire n5574_o;
  wire [3:0] n5575_o;
  wire [3:0] n5576_o;
  wire [3:0] n5577_o;
  wire [3:0] n5578_o;
  wire [7:0] n5580_o;
  wire [7:0] n5581_o;
  wire [7:0] n5582_o;
  wire [3:0] n5586_o;
  wire [7:0] n5587_o;
  wire n5588_o;
  wire [11:0] n5590_o;
  wire [3:0] n5595_o;
  wire [11:0] n5597_o;
  wire [3:0] n5603_o;
  wire [3:0] n5604_o;
  wire [7:0] n5605_o;
  wire [7:0] n5606_o;
  wire [7:0] n5607_o;
  wire n5609_o;
  wire n5610_o;
  wire [3:0] n5611_o;
  wire [3:0] n5612_o;
  wire [3:0] n5613_o;
  wire [3:0] n5614_o;
  wire [3:0] n5615_o;
  wire [95:0] n5618_o;
  wire [4:0] n5628_o;
  wire n5629_o;
  wire [4:0] n5631_o;
  wire [4:0] n5632_o;
  wire [4:0] n5635_o;
  wire [23:0] n5637_o;
  wire [7:0] n5638_o;
  wire [12:0] n5639_o;
  wire [12:0] n5640_o;
  wire [12:0] n5641_o;
  wire [23:0] n5642_o;
  wire [7:0] n5643_o;
  wire [12:0] n5644_o;
  wire [12:0] n5645_o;
  wire [12:0] n5646_o;
  wire [12:0] n5647_o;
  wire [23:0] n5651_o;
  wire [7:0] n5652_o;
  wire [12:0] n5653_o;
  wire [12:0] n5654_o;
  wire [12:0] n5655_o;
  wire [23:0] n5656_o;
  wire [7:0] n5657_o;
  wire [12:0] n5658_o;
  wire [12:0] n5659_o;
  wire [12:0] n5660_o;
  wire [12:0] n5661_o;
  wire [23:0] n5663_o;
  wire [7:0] n5664_o;
  wire [12:0] n5665_o;
  wire [12:0] n5666_o;
  wire [12:0] n5667_o;
  wire [23:0] n5668_o;
  wire [7:0] n5669_o;
  wire [12:0] n5670_o;
  wire [12:0] n5671_o;
  wire [12:0] n5672_o;
  wire [12:0] n5673_o;
  wire [38:0] n5674_o;
  wire [12:0] n5676_o;
  wire n5681_o;
  wire n5683_o;
  wire n5685_o;
  wire [7:0] n5687_o;
  wire [7:0] n5688_o;
  wire [7:0] n5689_o;
  wire [12:0] n5691_o;
  wire n5696_o;
  wire n5698_o;
  wire n5700_o;
  wire [7:0] n5702_o;
  wire [7:0] n5703_o;
  wire [7:0] n5704_o;
  wire [12:0] n5706_o;
  wire n5711_o;
  wire n5713_o;
  wire n5715_o;
  wire [7:0] n5717_o;
  wire [7:0] n5718_o;
  wire [7:0] n5719_o;
  wire [11:0] n5721_o;
  wire [95:0] n5722_o;
  wire [23:0] n5728_o;
  wire [7:0] n5729_o;
  wire [23:0] n5730_o;
  wire [7:0] n5731_o;
  wire [23:0] n5732_o;
  wire [7:0] n5733_o;
  wire [23:0] n5734_o;
  wire [7:0] n5735_o;
  wire [3:0] n5741_o;
  wire [4:0] n5743_o;
  wire [3:0] n5744_o;
  wire [4:0] n5746_o;
  wire [9:0] n5747_o;
  wire [9:0] n5748_o;
  wire [9:0] n5749_o;
  wire [8:0] n5752_o;
  wire [8:0] n5754_o;
  wire [8:0] n5755_o;
  wire [10:0] n5757_o;
  wire [11:0] n5759_o;
  wire [9:0] n5761_o;
  wire [11:0] n5763_o;
  wire [11:0] n5764_o;
  wire [11:0] n5766_o;
  wire [11:0] n5767_o;
  wire [9:0] n5769_o;
  wire [11:0] n5771_o;
  wire [11:0] n5772_o;
  wire [11:0] n5774_o;
  wire [11:0] n5775_o;
  wire [9:0] n5777_o;
  wire [10:0] n5779_o;
  wire [9:0] n5781_o;
  wire [10:0] n5783_o;
  wire [10:0] n5784_o;
  wire [10:0] n5786_o;
  wire [10:0] n5787_o;
  wire [10:0] n5789_o;
  wire [10:0] n5790_o;
  wire [10:0] n5792_o;
  wire [10:0] n5793_o;
  wire [10:0] n5795_o;
  wire [10:0] n5796_o;
  wire [8:0] n5797_o;
  wire [40:0] n5798_o;
  wire [48:0] n5799_o;
  wire [23:0] n5801_o;
  wire [7:0] n5802_o;
  wire [23:0] n5803_o;
  wire [7:0] n5804_o;
  wire [23:0] n5805_o;
  wire [7:0] n5806_o;
  wire [23:0] n5807_o;
  wire [7:0] n5808_o;
  wire [3:0] n5814_o;
  wire [4:0] n5816_o;
  wire [3:0] n5817_o;
  wire [4:0] n5819_o;
  wire [9:0] n5820_o;
  wire [9:0] n5821_o;
  wire [9:0] n5822_o;
  wire [8:0] n5825_o;
  wire [8:0] n5827_o;
  wire [8:0] n5828_o;
  wire [10:0] n5830_o;
  wire [11:0] n5832_o;
  wire [9:0] n5834_o;
  wire [11:0] n5836_o;
  wire [11:0] n5837_o;
  wire [11:0] n5839_o;
  wire [11:0] n5840_o;
  wire [9:0] n5842_o;
  wire [11:0] n5844_o;
  wire [11:0] n5845_o;
  wire [11:0] n5847_o;
  wire [11:0] n5848_o;
  wire [9:0] n5850_o;
  wire [10:0] n5852_o;
  wire [9:0] n5854_o;
  wire [10:0] n5856_o;
  wire [10:0] n5857_o;
  wire [10:0] n5859_o;
  wire [10:0] n5860_o;
  wire [10:0] n5862_o;
  wire [10:0] n5863_o;
  wire [10:0] n5865_o;
  wire [10:0] n5866_o;
  wire [10:0] n5868_o;
  wire [10:0] n5869_o;
  wire [8:0] n5870_o;
  wire [40:0] n5871_o;
  wire [48:0] n5872_o;
  wire [23:0] n5874_o;
  wire [7:0] n5875_o;
  wire [23:0] n5876_o;
  wire [7:0] n5877_o;
  wire [23:0] n5878_o;
  wire [7:0] n5879_o;
  wire [23:0] n5880_o;
  wire [7:0] n5881_o;
  wire [3:0] n5887_o;
  wire [4:0] n5889_o;
  wire [3:0] n5890_o;
  wire [4:0] n5892_o;
  wire [9:0] n5893_o;
  wire [9:0] n5894_o;
  wire [9:0] n5895_o;
  wire [8:0] n5898_o;
  wire [8:0] n5900_o;
  wire [8:0] n5901_o;
  wire [10:0] n5903_o;
  wire [11:0] n5905_o;
  wire [9:0] n5907_o;
  wire [11:0] n5909_o;
  wire [11:0] n5910_o;
  wire [11:0] n5912_o;
  wire [11:0] n5913_o;
  wire [9:0] n5915_o;
  wire [11:0] n5917_o;
  wire [11:0] n5918_o;
  wire [11:0] n5920_o;
  wire [11:0] n5921_o;
  wire [9:0] n5923_o;
  wire [10:0] n5925_o;
  wire [9:0] n5927_o;
  wire [10:0] n5929_o;
  wire [10:0] n5930_o;
  wire [10:0] n5932_o;
  wire [10:0] n5933_o;
  wire [10:0] n5935_o;
  wire [10:0] n5936_o;
  wire [10:0] n5938_o;
  wire [10:0] n5939_o;
  wire [10:0] n5941_o;
  wire [10:0] n5942_o;
  wire [8:0] n5943_o;
  wire [40:0] n5944_o;
  wire [48:0] n5945_o;
  wire [146:0] n5946_o;
  wire [11:0] n5948_o;
  wire [11:0] n5950_o;
  wire [95:0] n5951_o;
  wire [23:0] n5957_o;
  wire [7:0] n5958_o;
  wire [23:0] n5959_o;
  wire [7:0] n5960_o;
  wire [23:0] n5961_o;
  wire [7:0] n5962_o;
  wire [23:0] n5963_o;
  wire [7:0] n5964_o;
  wire [3:0] n5970_o;
  wire [4:0] n5972_o;
  wire [3:0] n5973_o;
  wire [4:0] n5975_o;
  wire [9:0] n5976_o;
  wire [9:0] n5977_o;
  wire [9:0] n5978_o;
  wire [8:0] n5981_o;
  wire [8:0] n5983_o;
  wire [8:0] n5984_o;
  wire [10:0] n5986_o;
  wire [11:0] n5988_o;
  wire [9:0] n5990_o;
  wire [11:0] n5992_o;
  wire [11:0] n5993_o;
  wire [11:0] n5995_o;
  wire [11:0] n5996_o;
  wire [9:0] n5998_o;
  wire [11:0] n6000_o;
  wire [11:0] n6001_o;
  wire [11:0] n6003_o;
  wire [11:0] n6004_o;
  wire [9:0] n6006_o;
  wire [10:0] n6008_o;
  wire [9:0] n6010_o;
  wire [10:0] n6012_o;
  wire [10:0] n6013_o;
  wire [10:0] n6015_o;
  wire [10:0] n6016_o;
  wire [10:0] n6018_o;
  wire [10:0] n6019_o;
  wire [10:0] n6021_o;
  wire [10:0] n6022_o;
  wire [10:0] n6024_o;
  wire [10:0] n6025_o;
  wire [8:0] n6026_o;
  wire [40:0] n6027_o;
  wire [48:0] n6028_o;
  wire [23:0] n6030_o;
  wire [7:0] n6031_o;
  wire [23:0] n6032_o;
  wire [7:0] n6033_o;
  wire [23:0] n6034_o;
  wire [7:0] n6035_o;
  wire [23:0] n6036_o;
  wire [7:0] n6037_o;
  wire [3:0] n6043_o;
  wire [4:0] n6045_o;
  wire [3:0] n6046_o;
  wire [4:0] n6048_o;
  wire [9:0] n6049_o;
  wire [9:0] n6050_o;
  wire [9:0] n6051_o;
  wire [8:0] n6054_o;
  wire [8:0] n6056_o;
  wire [8:0] n6057_o;
  wire [10:0] n6059_o;
  wire [11:0] n6061_o;
  wire [9:0] n6063_o;
  wire [11:0] n6065_o;
  wire [11:0] n6066_o;
  wire [11:0] n6068_o;
  wire [11:0] n6069_o;
  wire [9:0] n6071_o;
  wire [11:0] n6073_o;
  wire [11:0] n6074_o;
  wire [11:0] n6076_o;
  wire [11:0] n6077_o;
  wire [9:0] n6079_o;
  wire [10:0] n6081_o;
  wire [9:0] n6083_o;
  wire [10:0] n6085_o;
  wire [10:0] n6086_o;
  wire [10:0] n6088_o;
  wire [10:0] n6089_o;
  wire [10:0] n6091_o;
  wire [10:0] n6092_o;
  wire [10:0] n6094_o;
  wire [10:0] n6095_o;
  wire [10:0] n6097_o;
  wire [10:0] n6098_o;
  wire [8:0] n6099_o;
  wire [40:0] n6100_o;
  wire [48:0] n6101_o;
  wire [23:0] n6103_o;
  wire [7:0] n6104_o;
  wire [23:0] n6105_o;
  wire [7:0] n6106_o;
  wire [23:0] n6107_o;
  wire [7:0] n6108_o;
  wire [23:0] n6109_o;
  wire [7:0] n6110_o;
  wire [3:0] n6116_o;
  wire [4:0] n6118_o;
  wire [3:0] n6119_o;
  wire [4:0] n6121_o;
  wire [9:0] n6122_o;
  wire [9:0] n6123_o;
  wire [9:0] n6124_o;
  wire [8:0] n6127_o;
  wire [8:0] n6129_o;
  wire [8:0] n6130_o;
  wire [10:0] n6132_o;
  wire [11:0] n6134_o;
  wire [9:0] n6136_o;
  wire [11:0] n6138_o;
  wire [11:0] n6139_o;
  wire [11:0] n6141_o;
  wire [11:0] n6142_o;
  wire [9:0] n6144_o;
  wire [11:0] n6146_o;
  wire [11:0] n6147_o;
  wire [11:0] n6149_o;
  wire [11:0] n6150_o;
  wire [9:0] n6152_o;
  wire [10:0] n6154_o;
  wire [9:0] n6156_o;
  wire [10:0] n6158_o;
  wire [10:0] n6159_o;
  wire [10:0] n6161_o;
  wire [10:0] n6162_o;
  wire [10:0] n6164_o;
  wire [10:0] n6165_o;
  wire [10:0] n6167_o;
  wire [10:0] n6168_o;
  wire [10:0] n6170_o;
  wire [10:0] n6171_o;
  wire [8:0] n6172_o;
  wire [40:0] n6173_o;
  wire [48:0] n6174_o;
  wire [146:0] n6175_o;
  wire [48:0] n6184_o;
  wire [8:0] n6185_o;
  wire [3:0] n6186_o;
  wire [4:0] n6188_o;
  wire [13:0] n6189_o;
  wire [13:0] n6190_o;
  wire [13:0] n6191_o;
  wire [8:0] n6193_o;
  wire [48:0] n6196_o;
  wire [11:0] n6197_o;
  wire [48:0] n6198_o;
  wire [8:0] n6199_o;
  wire [20:0] n6200_o;
  wire [20:0] n6201_o;
  wire [20:0] n6202_o;
  wire [11:0] n6204_o;
  wire [48:0] n6207_o;
  wire [10:0] n6208_o;
  wire [48:0] n6209_o;
  wire [8:0] n6210_o;
  wire [19:0] n6211_o;
  wire [19:0] n6212_o;
  wire [19:0] n6213_o;
  wire [10:0] n6215_o;
  wire [48:0] n6218_o;
  wire [8:0] n6219_o;
  wire [3:0] n6220_o;
  wire [4:0] n6222_o;
  wire [13:0] n6223_o;
  wire [13:0] n6224_o;
  wire [13:0] n6225_o;
  wire [8:0] n6226_o;
  wire [48:0] n6228_o;
  wire [11:0] n6229_o;
  wire [48:0] n6230_o;
  wire [8:0] n6231_o;
  wire [20:0] n6232_o;
  wire [20:0] n6233_o;
  wire [20:0] n6234_o;
  wire [11:0] n6235_o;
  wire [48:0] n6237_o;
  wire [10:0] n6238_o;
  wire [48:0] n6239_o;
  wire [8:0] n6240_o;
  wire [19:0] n6241_o;
  wire [19:0] n6242_o;
  wire [19:0] n6243_o;
  wire [10:0] n6244_o;
  wire [48:0] n6246_o;
  wire [8:0] n6247_o;
  wire [3:0] n6248_o;
  wire [4:0] n6250_o;
  wire [13:0] n6251_o;
  wire [13:0] n6252_o;
  wire [13:0] n6253_o;
  wire [8:0] n6254_o;
  wire [48:0] n6255_o;
  wire [11:0] n6256_o;
  wire [48:0] n6257_o;
  wire [8:0] n6258_o;
  wire [20:0] n6259_o;
  wire [20:0] n6260_o;
  wire [20:0] n6261_o;
  wire [11:0] n6262_o;
  wire [48:0] n6263_o;
  wire [10:0] n6264_o;
  wire [48:0] n6265_o;
  wire [8:0] n6266_o;
  wire [19:0] n6267_o;
  wire [19:0] n6268_o;
  wire [19:0] n6269_o;
  wire [10:0] n6270_o;
  wire [95:0] n6271_o;
  wire [11:0] n6273_o;
  wire n6280_o;
  wire [8:0] n6281_o;
  wire [9:0] n6282_o;
  wire [48:0] n6283_o;
  wire [7:0] n6284_o;
  wire [9:0] n6286_o;
  wire [9:0] n6287_o;
  wire [9:0] n6288_o;
  wire [9:0] n6289_o;
  wire n6292_o;
  wire [8:0] n6293_o;
  wire [9:0] n6294_o;
  wire [48:0] n6295_o;
  wire [7:0] n6296_o;
  wire [9:0] n6298_o;
  wire [9:0] n6299_o;
  wire [9:0] n6300_o;
  wire [9:0] n6301_o;
  wire n6303_o;
  wire [8:0] n6304_o;
  wire [9:0] n6305_o;
  wire [48:0] n6306_o;
  wire [7:0] n6307_o;
  wire [9:0] n6309_o;
  wire [9:0] n6310_o;
  wire [9:0] n6311_o;
  wire [9:0] n6312_o;
  wire [10:0] n6314_o;
  wire [3:0] n6315_o;
  wire [4:0] n6317_o;
  wire [15:0] n6318_o;
  wire [15:0] n6319_o;
  wire [15:0] n6320_o;
  wire [9:0] n6322_o;
  wire [10:0] n6324_o;
  wire [3:0] n6325_o;
  wire [4:0] n6327_o;
  wire [15:0] n6328_o;
  wire [15:0] n6329_o;
  wire [15:0] n6330_o;
  wire [9:0] n6331_o;
  wire [10:0] n6333_o;
  wire [3:0] n6334_o;
  wire [4:0] n6336_o;
  wire [15:0] n6337_o;
  wire [15:0] n6338_o;
  wire [15:0] n6339_o;
  wire [9:0] n6340_o;
  wire [59:0] n6341_o;
  wire [9:0] n6350_o;
  wire [9:0] n6351_o;
  wire [9:0] n6352_o;
  wire n6359_o;
  wire [1:0] n6361_o;
  wire n6363_o;
  wire [7:0] n6365_o;
  wire [7:0] n6366_o;
  wire [7:0] n6367_o;
  wire [9:0] n6370_o;
  wire [9:0] n6371_o;
  wire [9:0] n6372_o;
  wire n6378_o;
  wire [1:0] n6380_o;
  wire n6382_o;
  wire [7:0] n6384_o;
  wire [7:0] n6385_o;
  wire [7:0] n6386_o;
  wire [9:0] n6388_o;
  wire [9:0] n6389_o;
  wire [9:0] n6390_o;
  wire n6396_o;
  wire [1:0] n6398_o;
  wire n6400_o;
  wire [7:0] n6402_o;
  wire [7:0] n6403_o;
  wire [7:0] n6404_o;
  wire [23:0] n6405_o;
  wire n6406_o;
  wire n6407_o;
  wire [23:0] n6408_o;
  wire [95:0] n6410_o;
  wire [17:0] n6416_o;
  wire [23:0] n6417_o;
  wire [7:0] n6418_o;
  wire [8:0] n6420_o;
  wire [26:0] n6421_o;
  wire [26:0] n6422_o;
  wire [26:0] n6423_o;
  wire [17:0] n6424_o;
  wire [23:0] n6425_o;
  wire [7:0] n6426_o;
  wire [8:0] n6428_o;
  wire [26:0] n6429_o;
  wire [26:0] n6430_o;
  wire [26:0] n6431_o;
  wire [26:0] n6432_o;
  wire [17:0] n6435_o;
  wire [23:0] n6436_o;
  wire [7:0] n6437_o;
  wire [8:0] n6439_o;
  wire [26:0] n6440_o;
  wire [26:0] n6441_o;
  wire [26:0] n6442_o;
  wire [17:0] n6443_o;
  wire [23:0] n6444_o;
  wire [7:0] n6445_o;
  wire [8:0] n6447_o;
  wire [26:0] n6448_o;
  wire [26:0] n6449_o;
  wire [26:0] n6450_o;
  wire [26:0] n6451_o;
  wire [17:0] n6453_o;
  wire [23:0] n6454_o;
  wire [7:0] n6455_o;
  wire [8:0] n6457_o;
  wire [26:0] n6458_o;
  wire [26:0] n6459_o;
  wire [26:0] n6460_o;
  wire [17:0] n6461_o;
  wire [23:0] n6462_o;
  wire [7:0] n6463_o;
  wire [8:0] n6465_o;
  wire [26:0] n6466_o;
  wire [26:0] n6467_o;
  wire [26:0] n6468_o;
  wire [26:0] n6469_o;
  wire [17:0] n6472_o;
  wire [23:0] n6473_o;
  wire [7:0] n6474_o;
  wire [8:0] n6476_o;
  wire [26:0] n6477_o;
  wire [26:0] n6478_o;
  wire [26:0] n6479_o;
  wire [17:0] n6480_o;
  wire [23:0] n6481_o;
  wire [7:0] n6482_o;
  wire [8:0] n6484_o;
  wire [26:0] n6485_o;
  wire [26:0] n6486_o;
  wire [26:0] n6487_o;
  wire [26:0] n6488_o;
  wire [17:0] n6489_o;
  wire [23:0] n6490_o;
  wire [7:0] n6491_o;
  wire [8:0] n6493_o;
  wire [26:0] n6494_o;
  wire [26:0] n6495_o;
  wire [26:0] n6496_o;
  wire [17:0] n6497_o;
  wire [23:0] n6498_o;
  wire [7:0] n6499_o;
  wire [8:0] n6501_o;
  wire [26:0] n6502_o;
  wire [26:0] n6503_o;
  wire [26:0] n6504_o;
  wire [26:0] n6505_o;
  wire [17:0] n6507_o;
  wire [23:0] n6508_o;
  wire [7:0] n6509_o;
  wire [8:0] n6511_o;
  wire [26:0] n6512_o;
  wire [26:0] n6513_o;
  wire [26:0] n6514_o;
  wire [17:0] n6515_o;
  wire [23:0] n6516_o;
  wire [7:0] n6517_o;
  wire [8:0] n6519_o;
  wire [26:0] n6520_o;
  wire [26:0] n6521_o;
  wire [26:0] n6522_o;
  wire [26:0] n6523_o;
  wire [161:0] n6524_o;
  wire [18:0] n6532_o;
  wire [18:0] n6533_o;
  wire [18:0] n6534_o;
  wire n6539_o;
  wire [3:0] n6541_o;
  wire n6543_o;
  wire [7:0] n6545_o;
  wire [7:0] n6546_o;
  wire [7:0] n6547_o;
  wire [18:0] n6551_o;
  wire [18:0] n6552_o;
  wire [18:0] n6553_o;
  wire n6558_o;
  wire [3:0] n6560_o;
  wire n6562_o;
  wire [7:0] n6564_o;
  wire [7:0] n6565_o;
  wire [7:0] n6566_o;
  wire [18:0] n6569_o;
  wire [18:0] n6570_o;
  wire [18:0] n6571_o;
  wire n6576_o;
  wire [3:0] n6578_o;
  wire n6580_o;
  wire [7:0] n6582_o;
  wire [7:0] n6583_o;
  wire [7:0] n6584_o;
  wire [23:0] n6585_o;
  wire [11:0] n6586_o;
  wire [10:0] n6587_o;
  wire n6588_o;
  wire n6589_o;
  wire [1:0] n6590_o;
  wire n6591_o;
  wire [2:0] n6592_o;
  wire n6593_o;
  wire [3:0] n6594_o;
  wire [3:0] n6595_o;
  wire [2:0] n6596_o;
  wire n6598_o;
  wire n6600_o;
  wire n6602_o;
  wire n6603_o;
  wire n6605_o;
  wire [2:0] n6606_o;
  reg [23:0] n6607_o;
  wire [13:0] n6609_o;
  wire [107:0] n6615_o;
  wire [167:0] n6618_o;
  wire [671:0] n6620_o;
  wire [62:0] n6622_o;
  wire [35:0] n6624_o;
  wire [23:0] n6627_o;
  reg [13:0] n6642_q;
  reg [10:0] n6643_q;
  reg [23:0] n6644_q;
  reg [3:0] n6645_q;
  reg [107:0] n6646_q;
  reg [167:0] n6647_q;
  reg [671:0] n6648_q;
  reg [62:0] n6649_q;
  reg [35:0] n6650_q;
  reg [3:0] n6651_q;
  reg [23:0] n6652_q;
  reg [38:0] n6653_q;
  reg [7:0] n6654_q;
  reg [23:0] n6655_q;
  reg [146:0] n6656_q;
  reg [95:0] n6658_q;
  reg [59:0] n6659_q;
  reg [23:0] n6660_q;
  reg [23:0] n6661_q;
  reg [161:0] n6662_q;
  wire n6665_o;
  wire n6671_o;
  wire n6677_o;
  wire n6683_o;
  wire [31:0] n6724_o;
  wire [31:0] n6726_o;
  wire [31:0] n6727_o;
  wire n6728_o;
  wire [31:0] n6729_o;
  wire [31:0] n6731_o;
  wire [11:0] n6732_o;
  wire [31:0] n6734_o;
  wire n6736_o;
  wire [31:0] n6737_o;
  wire [31:0] n6739_o;
  wire [11:0] n6740_o;
  wire [11:0] n6741_o;
  wire [31:0] n6742_o;
  wire [31:0] n6744_o;
  wire [31:0] n6745_o;
  wire n6746_o;
  wire [31:0] n6747_o;
  wire [31:0] n6749_o;
  wire [11:0] n6750_o;
  wire n6753_o;
  wire [11:0] n6754_o;
  wire n6755_o;
  wire [11:0] n6757_o;
  wire [11:0] n6758_o;
  wire n6759_o;
  wire [11:0] n6761_o;
  wire [11:0] n6762_o;
  wire [11:0] n6763_o;
  wire [11:0] n6764_o;
  wire [11:0] n6765_o;
  wire [31:0] n6767_o;
  wire [31:0] n6768_o;
  wire n6769_o;
  wire n6776_o;
  wire [31:0] n6778_o;
  wire [31:0] n6779_o;
  wire n6780_o;
  wire [31:0] n6781_o;
  wire [31:0] n6782_o;
  wire n6783_o;
  wire n6784_o;
  wire n6791_o;
  wire [31:0] n6793_o;
  wire [31:0] n6794_o;
  wire n6795_o;
  wire [31:0] n6796_o;
  wire [31:0] n6797_o;
  wire n6798_o;
  wire n6799_o;
  wire [31:0] n6800_o;
  wire [31:0] n6801_o;
  wire n6802_o;
  wire n6803_o;
  wire [31:0] n6804_o;
  wire [31:0] n6805_o;
  wire n6806_o;
  wire n6807_o;
  wire n6814_o;
  wire [31:0] n6816_o;
  wire [31:0] n6817_o;
  wire n6818_o;
  wire [31:0] n6819_o;
  wire [31:0] n6820_o;
  wire n6821_o;
  wire n6822_o;
  wire n6829_o;
  wire [31:0] n6831_o;
  wire [31:0] n6832_o;
  wire n6833_o;
  wire [31:0] n6834_o;
  wire [31:0] n6835_o;
  wire n6836_o;
  wire n6837_o;
  wire [31:0] n6838_o;
  wire [31:0] n6839_o;
  wire n6840_o;
  wire [31:0] n6841_o;
  wire [31:0] n6842_o;
  wire n6843_o;
  wire n6844_o;
  wire n6845_o;
  wire [31:0] n6846_o;
  wire [31:0] n6847_o;
  wire n6848_o;
  wire [31:0] n6849_o;
  wire [31:0] n6850_o;
  wire n6851_o;
  wire n6852_o;
  wire n6853_o;
  wire n6860_o;
  wire [31:0] n6862_o;
  wire [31:0] n6863_o;
  wire n6864_o;
  wire [31:0] n6865_o;
  wire [31:0] n6866_o;
  wire n6867_o;
  wire n6868_o;
  wire n6875_o;
  wire n6881_o;
  wire n6887_o;
  wire n6888_o;
  wire n6889_o;
  wire [8:0] n6890_o;
  wire n6891_o;
  wire n6892_o;
  wire n6893_o;
  wire [8:0] n6894_o;
  wire n6895_o;
  wire n6896_o;
  wire n6897_o;
  wire [8:0] n6898_o;
  wire n6899_o;
  wire n6900_o;
  wire n6901_o;
  wire [8:0] n6902_o;
  wire n6903_o;
  wire n6904_o;
  wire n6905_o;
  wire [8:0] n6906_o;
  wire [11:0] n6907_o;
  wire n6908_o;
  wire [11:0] n6914_o;
  wire [11:0] n6916_o;
  wire [11:0] n6918_o;
  wire [11:0] n6920_o;
  wire [11:0] n6922_o;
  wire [31:0] n6925_o;
  wire [31:0] n6926_o;
  wire n6927_o;
  wire [31:0] n6928_o;
  wire [31:0] n6929_o;
  wire n6930_o;
  wire n6932_o;
  wire [11:0] n6934_o;
  wire n6935_o;
  wire n6937_o;
  wire n6938_o;
  wire [31:0] n6939_o;
  wire [31:0] n6940_o;
  wire n6941_o;
  wire n6942_o;
  wire [31:0] n6943_o;
  wire [31:0] n6944_o;
  wire n6945_o;
  wire n6946_o;
  reg n6970_q;
  reg n6971_q;
  reg n6972_q;
  reg n6973_q;
  reg n6974_q;
  reg n6975_q;
  reg [11:0] n6976_q;
  reg [11:0] n6977_q;
  reg n6978_q;
  wire n6979_o;
  reg n6980_q;
  wire [11:0] n6981_o;
  reg [11:0] n6982_q;
  wire [11:0] n6983_o;
  reg [11:0] n6984_q;
  wire [11:0] n6985_o;
  reg [11:0] n6986_q;
  wire [11:0] n6987_o;
  reg [11:0] n6988_q;
  wire [11:0] n6989_o;
  reg [11:0] n6990_q;
  reg [11:0] n6991_q;
  wire [11:0] n6992_o;
  reg [11:0] n6993_q;
  wire [11:0] n6994_o;
  reg [11:0] n6995_q;
  wire [11:0] n6996_o;
  reg [11:0] n6997_q;
  wire [11:0] n6998_o;
  reg [11:0] n6999_q;
  wire [11:0] n7000_o;
  reg [11:0] n7001_q;
  wire n7002_o;
  reg n7003_q;
  wire [31:0] n7011_o;
  wire [31:0] n7013_o;
  wire [11:0] n7014_o;
  wire n7015_o;
  wire [31:0] n7016_o;
  wire [31:0] n7017_o;
  wire [31:0] n7018_o;
  wire [31:0] n7020_o;
  wire [10:0] n7021_o;
  wire [31:0] n7023_o;
  wire [31:0] n7024_o;
  wire [31:0] n7025_o;
  wire [31:0] n7027_o;
  wire [10:0] n7028_o;
  wire n7030_o;
  wire n7032_o;
  wire n7034_o;
  wire n7036_o;
  wire [2:0] n7037_o;
  reg [10:0] n7038_o;
  reg [10:0] n7039_o;
  reg [10:0] n7040_o;
  reg [10:0] n7041_o;
  wire n7043_o;
  wire n7045_o;
  wire n7047_o;
  wire [2:0] n7048_o;
  reg [10:0] n7049_o;
  reg [10:0] n7050_o;
  reg [10:0] n7051_o;
  reg [10:0] n7052_o;
  wire [10:0] n7053_o;
  wire [10:0] n7054_o;
  wire [10:0] n7055_o;
  wire [10:0] n7056_o;
  wire [95:0] n7057_o;
  wire n7059_o;
  wire [95:0] n7060_o;
  wire n7062_o;
  wire [95:0] n7063_o;
  wire n7065_o;
  wire [95:0] n7066_o;
  wire [2:0] n7067_o;
  reg [95:0] n7068_o;
  wire n7069_o;
  wire [23:0] n7070_o;
  wire [23:0] n7071_o;
  wire [23:0] n7072_o;
  wire [71:0] n7073_o;
  wire [23:0] n7074_o;
  wire [23:0] n7075_o;
  wire [23:0] n7076_o;
  wire [23:0] n7077_o;
  wire [71:0] n7078_o;
  wire [23:0] n7079_o;
  wire [71:0] n7080_o;
  wire [23:0] n7081_o;
  wire [119:0] n7082_o;
  wire [30:0] n7083_o;
  wire [31:0] n7084_o;
  wire [31:0] n7085_o;
  wire n7086_o;
  wire n7087_o;
  wire [23:0] n7088_o;
  wire [23:0] n7089_o;
  wire [23:0] n7090_o;
  wire [23:0] n7091_o;
  wire [95:0] n7092_o;
  wire [23:0] n7093_o;
  wire [23:0] n7094_o;
  wire [23:0] n7095_o;
  wire [23:0] n7096_o;
  wire [95:0] n7097_o;
  wire [95:0] n7098_o;
  wire [30:0] n7099_o;
  wire [31:0] n7100_o;
  wire [31:0] n7101_o;
  wire n7102_o;
  wire n7103_o;
  wire [23:0] n7104_o;
  wire [23:0] n7105_o;
  wire [23:0] n7106_o;
  wire [23:0] n7107_o;
  wire [95:0] n7108_o;
  wire [23:0] n7109_o;
  wire [23:0] n7110_o;
  wire [23:0] n7111_o;
  wire [23:0] n7112_o;
  wire [95:0] n7113_o;
  wire [95:0] n7114_o;
  wire n7115_o;
  wire [23:0] n7116_o;
  wire [23:0] n7117_o;
  wire [23:0] n7118_o;
  wire [23:0] n7119_o;
  wire [95:0] n7120_o;
  wire [23:0] n7121_o;
  wire [23:0] n7122_o;
  wire [23:0] n7123_o;
  wire [23:0] n7124_o;
  wire [95:0] n7125_o;
  wire [95:0] n7126_o;
  wire [95:0] n7127_o;
  wire [95:0] n7128_o;
  wire n7137_o;
  wire n7138_o;
  wire [3:0] n7139_o;
  wire [3:0] n7140_o;
  wire [3:0] n7141_o;
  wire [3:0] n7142_o;
  wire [7:0] n7144_o;
  wire [7:0] n7145_o;
  wire [7:0] n7146_o;
  wire [3:0] n7150_o;
  wire [7:0] n7151_o;
  wire n7152_o;
  wire [3:0] n7158_o;
  wire [3:0] n7165_o;
  wire [3:0] n7166_o;
  wire [7:0] n7167_o;
  wire [7:0] n7168_o;
  wire [7:0] n7169_o;
  wire n7171_o;
  wire n7172_o;
  wire [3:0] n7173_o;
  wire [3:0] n7174_o;
  wire [3:0] n7175_o;
  wire [3:0] n7176_o;
  wire [3:0] n7177_o;
  wire [4:0] n7189_o;
  wire n7190_o;
  wire [4:0] n7192_o;
  wire [4:0] n7193_o;
  wire [4:0] n7196_o;
  wire [23:0] n7198_o;
  wire [7:0] n7199_o;
  wire [12:0] n7200_o;
  wire [12:0] n7201_o;
  wire [12:0] n7202_o;
  wire [23:0] n7203_o;
  wire [7:0] n7204_o;
  wire [12:0] n7205_o;
  wire [12:0] n7206_o;
  wire [12:0] n7207_o;
  wire [12:0] n7208_o;
  wire [23:0] n7212_o;
  wire [7:0] n7213_o;
  wire [12:0] n7214_o;
  wire [12:0] n7215_o;
  wire [12:0] n7216_o;
  wire [23:0] n7217_o;
  wire [7:0] n7218_o;
  wire [12:0] n7219_o;
  wire [12:0] n7220_o;
  wire [12:0] n7221_o;
  wire [12:0] n7222_o;
  wire [23:0] n7224_o;
  wire [7:0] n7225_o;
  wire [12:0] n7226_o;
  wire [12:0] n7227_o;
  wire [12:0] n7228_o;
  wire [23:0] n7229_o;
  wire [7:0] n7230_o;
  wire [12:0] n7231_o;
  wire [12:0] n7232_o;
  wire [12:0] n7233_o;
  wire [12:0] n7234_o;
  wire [38:0] n7235_o;
  wire [12:0] n7237_o;
  wire n7242_o;
  wire n7244_o;
  wire n7246_o;
  wire [7:0] n7248_o;
  wire [7:0] n7249_o;
  wire [7:0] n7250_o;
  wire [12:0] n7252_o;
  wire n7257_o;
  wire n7259_o;
  wire n7261_o;
  wire [7:0] n7263_o;
  wire [7:0] n7264_o;
  wire [7:0] n7265_o;
  wire [12:0] n7267_o;
  wire n7272_o;
  wire n7274_o;
  wire n7276_o;
  wire [7:0] n7278_o;
  wire [7:0] n7279_o;
  wire [7:0] n7280_o;
  wire [23:0] n7287_o;
  wire [7:0] n7288_o;
  wire [23:0] n7289_o;
  wire [7:0] n7290_o;
  wire [23:0] n7291_o;
  wire [7:0] n7292_o;
  wire [23:0] n7293_o;
  wire [7:0] n7294_o;
  wire [3:0] n7300_o;
  wire [4:0] n7302_o;
  wire [3:0] n7303_o;
  wire [4:0] n7305_o;
  wire [9:0] n7306_o;
  wire [9:0] n7307_o;
  wire [9:0] n7308_o;
  wire [8:0] n7311_o;
  wire [8:0] n7313_o;
  wire [8:0] n7314_o;
  wire [10:0] n7316_o;
  wire [11:0] n7318_o;
  wire [9:0] n7320_o;
  wire [11:0] n7322_o;
  wire [11:0] n7323_o;
  wire [11:0] n7325_o;
  wire [11:0] n7326_o;
  wire [9:0] n7328_o;
  wire [11:0] n7330_o;
  wire [11:0] n7331_o;
  wire [11:0] n7333_o;
  wire [11:0] n7334_o;
  wire [9:0] n7336_o;
  wire [10:0] n7338_o;
  wire [9:0] n7340_o;
  wire [10:0] n7342_o;
  wire [10:0] n7343_o;
  wire [10:0] n7345_o;
  wire [10:0] n7346_o;
  wire [10:0] n7348_o;
  wire [10:0] n7349_o;
  wire [10:0] n7351_o;
  wire [10:0] n7352_o;
  wire [10:0] n7354_o;
  wire [10:0] n7355_o;
  wire [8:0] n7356_o;
  wire [40:0] n7357_o;
  wire [48:0] n7358_o;
  wire [23:0] n7360_o;
  wire [7:0] n7361_o;
  wire [23:0] n7362_o;
  wire [7:0] n7363_o;
  wire [23:0] n7364_o;
  wire [7:0] n7365_o;
  wire [23:0] n7366_o;
  wire [7:0] n7367_o;
  wire [3:0] n7373_o;
  wire [4:0] n7375_o;
  wire [3:0] n7376_o;
  wire [4:0] n7378_o;
  wire [9:0] n7379_o;
  wire [9:0] n7380_o;
  wire [9:0] n7381_o;
  wire [8:0] n7384_o;
  wire [8:0] n7386_o;
  wire [8:0] n7387_o;
  wire [10:0] n7389_o;
  wire [11:0] n7391_o;
  wire [9:0] n7393_o;
  wire [11:0] n7395_o;
  wire [11:0] n7396_o;
  wire [11:0] n7398_o;
  wire [11:0] n7399_o;
  wire [9:0] n7401_o;
  wire [11:0] n7403_o;
  wire [11:0] n7404_o;
  wire [11:0] n7406_o;
  wire [11:0] n7407_o;
  wire [9:0] n7409_o;
  wire [10:0] n7411_o;
  wire [9:0] n7413_o;
  wire [10:0] n7415_o;
  wire [10:0] n7416_o;
  wire [10:0] n7418_o;
  wire [10:0] n7419_o;
  wire [10:0] n7421_o;
  wire [10:0] n7422_o;
  wire [10:0] n7424_o;
  wire [10:0] n7425_o;
  wire [10:0] n7427_o;
  wire [10:0] n7428_o;
  wire [8:0] n7429_o;
  wire [40:0] n7430_o;
  wire [48:0] n7431_o;
  wire [23:0] n7433_o;
  wire [7:0] n7434_o;
  wire [23:0] n7435_o;
  wire [7:0] n7436_o;
  wire [23:0] n7437_o;
  wire [7:0] n7438_o;
  wire [23:0] n7439_o;
  wire [7:0] n7440_o;
  wire [3:0] n7446_o;
  wire [4:0] n7448_o;
  wire [3:0] n7449_o;
  wire [4:0] n7451_o;
  wire [9:0] n7452_o;
  wire [9:0] n7453_o;
  wire [9:0] n7454_o;
  wire [8:0] n7457_o;
  wire [8:0] n7459_o;
  wire [8:0] n7460_o;
  wire [10:0] n7462_o;
  wire [11:0] n7464_o;
  wire [9:0] n7466_o;
  wire [11:0] n7468_o;
  wire [11:0] n7469_o;
  wire [11:0] n7471_o;
  wire [11:0] n7472_o;
  wire [9:0] n7474_o;
  wire [11:0] n7476_o;
  wire [11:0] n7477_o;
  wire [11:0] n7479_o;
  wire [11:0] n7480_o;
  wire [9:0] n7482_o;
  wire [10:0] n7484_o;
  wire [9:0] n7486_o;
  wire [10:0] n7488_o;
  wire [10:0] n7489_o;
  wire [10:0] n7491_o;
  wire [10:0] n7492_o;
  wire [10:0] n7494_o;
  wire [10:0] n7495_o;
  wire [10:0] n7497_o;
  wire [10:0] n7498_o;
  wire [10:0] n7500_o;
  wire [10:0] n7501_o;
  wire [8:0] n7502_o;
  wire [40:0] n7503_o;
  wire [48:0] n7504_o;
  wire [146:0] n7505_o;
  wire [23:0] n7513_o;
  wire [7:0] n7514_o;
  wire [23:0] n7515_o;
  wire [7:0] n7516_o;
  wire [23:0] n7517_o;
  wire [7:0] n7518_o;
  wire [23:0] n7519_o;
  wire [7:0] n7520_o;
  wire [3:0] n7526_o;
  wire [4:0] n7528_o;
  wire [3:0] n7529_o;
  wire [4:0] n7531_o;
  wire [9:0] n7532_o;
  wire [9:0] n7533_o;
  wire [9:0] n7534_o;
  wire [8:0] n7537_o;
  wire [8:0] n7539_o;
  wire [8:0] n7540_o;
  wire [10:0] n7542_o;
  wire [11:0] n7544_o;
  wire [9:0] n7546_o;
  wire [11:0] n7548_o;
  wire [11:0] n7549_o;
  wire [11:0] n7551_o;
  wire [11:0] n7552_o;
  wire [9:0] n7554_o;
  wire [11:0] n7556_o;
  wire [11:0] n7557_o;
  wire [11:0] n7559_o;
  wire [11:0] n7560_o;
  wire [9:0] n7562_o;
  wire [10:0] n7564_o;
  wire [9:0] n7566_o;
  wire [10:0] n7568_o;
  wire [10:0] n7569_o;
  wire [10:0] n7571_o;
  wire [10:0] n7572_o;
  wire [10:0] n7574_o;
  wire [10:0] n7575_o;
  wire [10:0] n7577_o;
  wire [10:0] n7578_o;
  wire [10:0] n7580_o;
  wire [10:0] n7581_o;
  wire [8:0] n7582_o;
  wire [40:0] n7583_o;
  wire [48:0] n7584_o;
  wire [23:0] n7586_o;
  wire [7:0] n7587_o;
  wire [23:0] n7588_o;
  wire [7:0] n7589_o;
  wire [23:0] n7590_o;
  wire [7:0] n7591_o;
  wire [23:0] n7592_o;
  wire [7:0] n7593_o;
  wire [3:0] n7599_o;
  wire [4:0] n7601_o;
  wire [3:0] n7602_o;
  wire [4:0] n7604_o;
  wire [9:0] n7605_o;
  wire [9:0] n7606_o;
  wire [9:0] n7607_o;
  wire [8:0] n7610_o;
  wire [8:0] n7612_o;
  wire [8:0] n7613_o;
  wire [10:0] n7615_o;
  wire [11:0] n7617_o;
  wire [9:0] n7619_o;
  wire [11:0] n7621_o;
  wire [11:0] n7622_o;
  wire [11:0] n7624_o;
  wire [11:0] n7625_o;
  wire [9:0] n7627_o;
  wire [11:0] n7629_o;
  wire [11:0] n7630_o;
  wire [11:0] n7632_o;
  wire [11:0] n7633_o;
  wire [9:0] n7635_o;
  wire [10:0] n7637_o;
  wire [9:0] n7639_o;
  wire [10:0] n7641_o;
  wire [10:0] n7642_o;
  wire [10:0] n7644_o;
  wire [10:0] n7645_o;
  wire [10:0] n7647_o;
  wire [10:0] n7648_o;
  wire [10:0] n7650_o;
  wire [10:0] n7651_o;
  wire [10:0] n7653_o;
  wire [10:0] n7654_o;
  wire [8:0] n7655_o;
  wire [40:0] n7656_o;
  wire [48:0] n7657_o;
  wire [23:0] n7659_o;
  wire [7:0] n7660_o;
  wire [23:0] n7661_o;
  wire [7:0] n7662_o;
  wire [23:0] n7663_o;
  wire [7:0] n7664_o;
  wire [23:0] n7665_o;
  wire [7:0] n7666_o;
  wire [3:0] n7672_o;
  wire [4:0] n7674_o;
  wire [3:0] n7675_o;
  wire [4:0] n7677_o;
  wire [9:0] n7678_o;
  wire [9:0] n7679_o;
  wire [9:0] n7680_o;
  wire [8:0] n7683_o;
  wire [8:0] n7685_o;
  wire [8:0] n7686_o;
  wire [10:0] n7688_o;
  wire [11:0] n7690_o;
  wire [9:0] n7692_o;
  wire [11:0] n7694_o;
  wire [11:0] n7695_o;
  wire [11:0] n7697_o;
  wire [11:0] n7698_o;
  wire [9:0] n7700_o;
  wire [11:0] n7702_o;
  wire [11:0] n7703_o;
  wire [11:0] n7705_o;
  wire [11:0] n7706_o;
  wire [9:0] n7708_o;
  wire [10:0] n7710_o;
  wire [9:0] n7712_o;
  wire [10:0] n7714_o;
  wire [10:0] n7715_o;
  wire [10:0] n7717_o;
  wire [10:0] n7718_o;
  wire [10:0] n7720_o;
  wire [10:0] n7721_o;
  wire [10:0] n7723_o;
  wire [10:0] n7724_o;
  wire [10:0] n7726_o;
  wire [10:0] n7727_o;
  wire [8:0] n7728_o;
  wire [40:0] n7729_o;
  wire [48:0] n7730_o;
  wire [146:0] n7731_o;
  wire [48:0] n7740_o;
  wire [8:0] n7741_o;
  wire [3:0] n7742_o;
  wire [4:0] n7744_o;
  wire [13:0] n7745_o;
  wire [13:0] n7746_o;
  wire [13:0] n7747_o;
  wire [8:0] n7749_o;
  wire [48:0] n7752_o;
  wire [11:0] n7753_o;
  wire [48:0] n7754_o;
  wire [8:0] n7755_o;
  wire [20:0] n7756_o;
  wire [20:0] n7757_o;
  wire [20:0] n7758_o;
  wire [11:0] n7760_o;
  wire [48:0] n7763_o;
  wire [10:0] n7764_o;
  wire [48:0] n7765_o;
  wire [8:0] n7766_o;
  wire [19:0] n7767_o;
  wire [19:0] n7768_o;
  wire [19:0] n7769_o;
  wire [10:0] n7771_o;
  wire [48:0] n7774_o;
  wire [8:0] n7775_o;
  wire [3:0] n7776_o;
  wire [4:0] n7778_o;
  wire [13:0] n7779_o;
  wire [13:0] n7780_o;
  wire [13:0] n7781_o;
  wire [8:0] n7782_o;
  wire [48:0] n7784_o;
  wire [11:0] n7785_o;
  wire [48:0] n7786_o;
  wire [8:0] n7787_o;
  wire [20:0] n7788_o;
  wire [20:0] n7789_o;
  wire [20:0] n7790_o;
  wire [11:0] n7791_o;
  wire [48:0] n7793_o;
  wire [10:0] n7794_o;
  wire [48:0] n7795_o;
  wire [8:0] n7796_o;
  wire [19:0] n7797_o;
  wire [19:0] n7798_o;
  wire [19:0] n7799_o;
  wire [10:0] n7800_o;
  wire [48:0] n7802_o;
  wire [8:0] n7803_o;
  wire [3:0] n7804_o;
  wire [4:0] n7806_o;
  wire [13:0] n7807_o;
  wire [13:0] n7808_o;
  wire [13:0] n7809_o;
  wire [8:0] n7810_o;
  wire [48:0] n7811_o;
  wire [11:0] n7812_o;
  wire [48:0] n7813_o;
  wire [8:0] n7814_o;
  wire [20:0] n7815_o;
  wire [20:0] n7816_o;
  wire [20:0] n7817_o;
  wire [11:0] n7818_o;
  wire [48:0] n7819_o;
  wire [10:0] n7820_o;
  wire [48:0] n7821_o;
  wire [8:0] n7822_o;
  wire [19:0] n7823_o;
  wire [19:0] n7824_o;
  wire [19:0] n7825_o;
  wire [10:0] n7826_o;
  wire [95:0] n7827_o;
  wire n7835_o;
  wire [8:0] n7836_o;
  wire [9:0] n7837_o;
  wire [48:0] n7838_o;
  wire [7:0] n7839_o;
  wire [9:0] n7841_o;
  wire [9:0] n7842_o;
  wire [9:0] n7843_o;
  wire [9:0] n7844_o;
  wire n7847_o;
  wire [8:0] n7848_o;
  wire [9:0] n7849_o;
  wire [48:0] n7850_o;
  wire [7:0] n7851_o;
  wire [9:0] n7853_o;
  wire [9:0] n7854_o;
  wire [9:0] n7855_o;
  wire [9:0] n7856_o;
  wire n7858_o;
  wire [8:0] n7859_o;
  wire [9:0] n7860_o;
  wire [48:0] n7861_o;
  wire [7:0] n7862_o;
  wire [9:0] n7864_o;
  wire [9:0] n7865_o;
  wire [9:0] n7866_o;
  wire [9:0] n7867_o;
  wire [10:0] n7869_o;
  wire [3:0] n7870_o;
  wire [4:0] n7872_o;
  wire [15:0] n7873_o;
  wire [15:0] n7874_o;
  wire [15:0] n7875_o;
  wire [9:0] n7877_o;
  wire [10:0] n7879_o;
  wire [3:0] n7880_o;
  wire [4:0] n7882_o;
  wire [15:0] n7883_o;
  wire [15:0] n7884_o;
  wire [15:0] n7885_o;
  wire [9:0] n7886_o;
  wire [10:0] n7888_o;
  wire [3:0] n7889_o;
  wire [4:0] n7891_o;
  wire [15:0] n7892_o;
  wire [15:0] n7893_o;
  wire [15:0] n7894_o;
  wire [9:0] n7895_o;
  wire [59:0] n7896_o;
  wire [9:0] n7904_o;
  wire [9:0] n7905_o;
  wire [9:0] n7906_o;
  wire n7913_o;
  wire [1:0] n7915_o;
  wire n7917_o;
  wire [7:0] n7919_o;
  wire [7:0] n7920_o;
  wire [7:0] n7921_o;
  wire [9:0] n7924_o;
  wire [9:0] n7925_o;
  wire [9:0] n7926_o;
  wire n7932_o;
  wire [1:0] n7934_o;
  wire n7936_o;
  wire [7:0] n7938_o;
  wire [7:0] n7939_o;
  wire [7:0] n7940_o;
  wire [9:0] n7942_o;
  wire [9:0] n7943_o;
  wire [9:0] n7944_o;
  wire n7950_o;
  wire [1:0] n7952_o;
  wire n7954_o;
  wire [7:0] n7956_o;
  wire [7:0] n7957_o;
  wire [7:0] n7958_o;
  wire [23:0] n7959_o;
  wire [23:0] n7960_o;
  wire [17:0] n7967_o;
  wire [23:0] n7968_o;
  wire [7:0] n7969_o;
  wire [8:0] n7971_o;
  wire [26:0] n7972_o;
  wire [26:0] n7973_o;
  wire [26:0] n7974_o;
  wire [17:0] n7975_o;
  wire [23:0] n7976_o;
  wire [7:0] n7977_o;
  wire [8:0] n7979_o;
  wire [26:0] n7980_o;
  wire [26:0] n7981_o;
  wire [26:0] n7982_o;
  wire [26:0] n7983_o;
  wire [17:0] n7986_o;
  wire [23:0] n7987_o;
  wire [7:0] n7988_o;
  wire [8:0] n7990_o;
  wire [26:0] n7991_o;
  wire [26:0] n7992_o;
  wire [26:0] n7993_o;
  wire [17:0] n7994_o;
  wire [23:0] n7995_o;
  wire [7:0] n7996_o;
  wire [8:0] n7998_o;
  wire [26:0] n7999_o;
  wire [26:0] n8000_o;
  wire [26:0] n8001_o;
  wire [26:0] n8002_o;
  wire [17:0] n8004_o;
  wire [23:0] n8005_o;
  wire [7:0] n8006_o;
  wire [8:0] n8008_o;
  wire [26:0] n8009_o;
  wire [26:0] n8010_o;
  wire [26:0] n8011_o;
  wire [17:0] n8012_o;
  wire [23:0] n8013_o;
  wire [7:0] n8014_o;
  wire [8:0] n8016_o;
  wire [26:0] n8017_o;
  wire [26:0] n8018_o;
  wire [26:0] n8019_o;
  wire [26:0] n8020_o;
  wire [17:0] n8023_o;
  wire [23:0] n8024_o;
  wire [7:0] n8025_o;
  wire [8:0] n8027_o;
  wire [26:0] n8028_o;
  wire [26:0] n8029_o;
  wire [26:0] n8030_o;
  wire [17:0] n8031_o;
  wire [23:0] n8032_o;
  wire [7:0] n8033_o;
  wire [8:0] n8035_o;
  wire [26:0] n8036_o;
  wire [26:0] n8037_o;
  wire [26:0] n8038_o;
  wire [26:0] n8039_o;
  wire [17:0] n8040_o;
  wire [23:0] n8041_o;
  wire [7:0] n8042_o;
  wire [8:0] n8044_o;
  wire [26:0] n8045_o;
  wire [26:0] n8046_o;
  wire [26:0] n8047_o;
  wire [17:0] n8048_o;
  wire [23:0] n8049_o;
  wire [7:0] n8050_o;
  wire [8:0] n8052_o;
  wire [26:0] n8053_o;
  wire [26:0] n8054_o;
  wire [26:0] n8055_o;
  wire [26:0] n8056_o;
  wire [17:0] n8058_o;
  wire [23:0] n8059_o;
  wire [7:0] n8060_o;
  wire [8:0] n8062_o;
  wire [26:0] n8063_o;
  wire [26:0] n8064_o;
  wire [26:0] n8065_o;
  wire [17:0] n8066_o;
  wire [23:0] n8067_o;
  wire [7:0] n8068_o;
  wire [8:0] n8070_o;
  wire [26:0] n8071_o;
  wire [26:0] n8072_o;
  wire [26:0] n8073_o;
  wire [26:0] n8074_o;
  wire [161:0] n8075_o;
  wire [18:0] n8083_o;
  wire [18:0] n8084_o;
  wire [18:0] n8085_o;
  wire n8090_o;
  wire [3:0] n8092_o;
  wire n8094_o;
  wire [7:0] n8096_o;
  wire [7:0] n8097_o;
  wire [7:0] n8098_o;
  wire [18:0] n8102_o;
  wire [18:0] n8103_o;
  wire [18:0] n8104_o;
  wire n8109_o;
  wire [3:0] n8111_o;
  wire n8113_o;
  wire [7:0] n8115_o;
  wire [7:0] n8116_o;
  wire [7:0] n8117_o;
  wire [18:0] n8120_o;
  wire [18:0] n8121_o;
  wire [18:0] n8122_o;
  wire n8127_o;
  wire [3:0] n8129_o;
  wire n8131_o;
  wire [7:0] n8133_o;
  wire [7:0] n8134_o;
  wire [7:0] n8135_o;
  wire [23:0] n8136_o;
  wire n8137_o;
  wire n8138_o;
  wire n8139_o;
  wire n8140_o;
  wire n8141_o;
  wire n8142_o;
  wire [2:0] n8143_o;
  wire [7:0] n8144_o;
  wire [7:0] n8145_o;
  wire [7:0] n8146_o;
  wire n8148_o;
  wire [7:0] n8149_o;
  wire [7:0] n8150_o;
  wire [7:0] n8151_o;
  wire n8153_o;
  wire n8155_o;
  wire n8156_o;
  wire [7:0] n8157_o;
  wire [7:0] n8158_o;
  wire [7:0] n8159_o;
  wire n8161_o;
  wire [7:0] n8162_o;
  wire [7:0] n8163_o;
  wire [7:0] n8164_o;
  wire [2:0] n8165_o;
  reg [7:0] n8166_o;
  reg [7:0] n8168_o;
  reg [7:0] n8170_o;
  wire n8172_o;
  wire n8173_o;
  wire [7:0] n8174_o;
  wire [7:0] n8175_o;
  wire [7:0] n8176_o;
  wire [7:0] n8177_o;
  wire [7:0] n8178_o;
  wire [7:0] n8179_o;
  wire [143:0] n8196_o;
  wire [23:0] n8200_o;
  wire [7:0] n8251_o;
  reg [7:0] n8252_q;
  wire [7:0] n8253_o;
  reg [7:0] n8254_q;
  wire [7:0] n8255_o;
  reg [7:0] n8256_q;
  wire n8257_o;
  reg n8258_q;
  wire n8259_o;
  reg n8260_q;
  wire n8261_o;
  reg n8262_q;
  wire n8263_o;
  reg n8264_q;
  wire n8265_o;
  reg n8266_q;
  wire [11:0] n8267_o;
  reg [11:0] n8268_q;
  wire [10:0] n8269_o;
  reg [10:0] n8270_q;
  wire [10:0] n8271_o;
  reg [10:0] n8272_q;
  wire [10:0] n8273_o;
  reg [10:0] n8274_q;
  wire [10:0] n8275_o;
  reg [10:0] n8276_q;
  wire [95:0] n8277_o;
  reg [95:0] n8278_q;
  wire [95:0] n8279_o;
  reg [95:0] n8280_q;
  wire [71:0] n8281_o;
  reg [71:0] n8282_q;
  wire [143:0] n8283_o;
  wire [143:0] n8284_o;
  reg [143:0] n8285_q;
  wire [3:0] n8286_o;
  reg [3:0] n8287_q;
  wire [23:0] n8288_o;
  reg [23:0] n8289_q;
  wire [38:0] n8290_o;
  reg [38:0] n8291_q;
  wire [7:0] n8292_o;
  reg [7:0] n8293_q;
  wire [23:0] n8294_o;
  reg [23:0] n8295_q;
  wire [146:0] n8296_o;
  reg [146:0] n8297_q;
  wire [95:0] n8300_o;
  reg [95:0] n8301_q;
  wire [59:0] n8302_o;
  reg [59:0] n8303_q;
  wire [23:0] n8304_o;
  reg [23:0] n8305_q;
  wire [23:0] n8306_o;
  reg [23:0] n8307_q;
  wire [161:0] n8308_o;
  reg [161:0] n8309_q;
  wire [3:0] n8318_o;
  wire [3:0] n8319_o;
  wire [3:0] n8320_o;
  wire [3:0] n8321_o;
  wire [15:0] n8322_o;
  wire [14:0] n8323_o;
  wire [119:0] n8325_o;
  wire [167:0] n8327_o;
  reg [127:0] n8337_data; // mem_rd
  reg [23:0] n8339_data; // mem_rd
  reg [127:0] n8342_data; // mem_rd
  reg [47:0] n8345_data; // mem_rd
  wire [47:0] n8346_data; // mem_rd
  reg [23:0] n8349_data; // mem_rd
  wire [23:0] n8350_data; // mem_rd
  reg [23:0] n8353_data; // mem_rd
  reg [23:0] n8356_data; // mem_rd
  reg [23:0] n8359_data; // mem_rd
  reg [23:0] n8362_data; // mem_rd
  wire [39:0] n8364_o;
  wire [39:0] n8365_o;
  wire [39:0] n8366_o;
  wire [39:0] n8367_o;
  wire [39:0] n8368_o;
  wire [39:0] n8369_o;
  wire [39:0] n8370_o;
  wire [39:0] n8371_o;
  wire [39:0] n8372_o;
  wire [39:0] n8373_o;
  wire [39:0] n8374_o;
  wire [39:0] n8375_o;
  wire [39:0] n8376_o;
  wire [39:0] n8377_o;
  wire [39:0] n8378_o;
  wire [39:0] n8379_o;
  wire [1:0] n8380_o;
  reg [39:0] n8381_o;
  wire [1:0] n8382_o;
  reg [39:0] n8383_o;
  wire [1:0] n8384_o;
  reg [39:0] n8385_o;
  wire [1:0] n8386_o;
  reg [39:0] n8387_o;
  wire [1:0] n8388_o;
  reg [39:0] n8389_o;
  wire [39:0] n8390_o;
  wire [39:0] n8391_o;
  wire [39:0] n8392_o;
  wire [39:0] n8393_o;
  wire [39:0] n8394_o;
  wire [39:0] n8395_o;
  wire [39:0] n8396_o;
  wire [39:0] n8397_o;
  wire [39:0] n8398_o;
  wire [39:0] n8399_o;
  wire [39:0] n8400_o;
  wire [39:0] n8401_o;
  wire [39:0] n8402_o;
  wire [39:0] n8403_o;
  wire [39:0] n8404_o;
  wire [39:0] n8405_o;
  wire [1:0] n8406_o;
  reg [39:0] n8407_o;
  wire [1:0] n8408_o;
  reg [39:0] n8409_o;
  wire [1:0] n8410_o;
  reg [39:0] n8411_o;
  wire [1:0] n8412_o;
  reg [39:0] n8413_o;
  wire [1:0] n8414_o;
  reg [39:0] n8415_o;
  wire [39:0] n8416_o;
  wire [39:0] n8417_o;
  wire [39:0] n8418_o;
  wire [39:0] n8419_o;
  wire [39:0] n8420_o;
  wire [39:0] n8421_o;
  wire [39:0] n8422_o;
  wire [39:0] n8423_o;
  wire [39:0] n8424_o;
  wire [39:0] n8425_o;
  wire [39:0] n8426_o;
  wire [39:0] n8427_o;
  wire [39:0] n8428_o;
  wire [39:0] n8429_o;
  wire [39:0] n8430_o;
  wire [39:0] n8431_o;
  wire [1:0] n8432_o;
  reg [39:0] n8433_o;
  wire [1:0] n8434_o;
  reg [39:0] n8435_o;
  wire [1:0] n8436_o;
  reg [39:0] n8437_o;
  wire [1:0] n8438_o;
  reg [39:0] n8439_o;
  wire [1:0] n8440_o;
  reg [39:0] n8441_o;
  wire n8442_o;
  wire n8443_o;
  wire n8444_o;
  wire n8445_o;
  wire n8446_o;
  wire n8447_o;
  wire n8448_o;
  wire n8449_o;
  wire [9:0] n8450_o;
  wire n8451_o;
  wire [9:0] n8452_o;
  wire [9:0] n8453_o;
  wire n8454_o;
  wire [9:0] n8455_o;
  wire [9:0] n8456_o;
  wire n8457_o;
  wire [9:0] n8458_o;
  wire [9:0] n8459_o;
  wire n8460_o;
  wire [9:0] n8461_o;
  wire [39:0] n8462_o;
  wire n8463_o;
  wire n8464_o;
  wire n8465_o;
  wire n8466_o;
  wire n8467_o;
  wire n8468_o;
  wire n8469_o;
  wire n8470_o;
  wire n8471_o;
  wire n8472_o;
  wire n8473_o;
  wire n8474_o;
  wire n8475_o;
  wire n8476_o;
  wire n8477_o;
  wire n8478_o;
  wire n8479_o;
  wire n8480_o;
  wire n8481_o;
  wire n8482_o;
  wire n8483_o;
  wire n8484_o;
  wire n8485_o;
  wire n8486_o;
  wire n8487_o;
  wire n8488_o;
  wire n8489_o;
  wire n8490_o;
  wire n8491_o;
  wire n8492_o;
  wire n8493_o;
  wire n8494_o;
  wire n8495_o;
  wire n8496_o;
  wire n8497_o;
  wire n8498_o;
  wire [39:0] n8499_o;
  wire [39:0] n8500_o;
  wire [39:0] n8501_o;
  wire [39:0] n8502_o;
  wire [39:0] n8503_o;
  wire [39:0] n8504_o;
  wire [39:0] n8505_o;
  wire [39:0] n8506_o;
  wire [39:0] n8507_o;
  wire [39:0] n8508_o;
  wire [39:0] n8509_o;
  wire [39:0] n8510_o;
  wire [39:0] n8511_o;
  wire [39:0] n8512_o;
  wire [39:0] n8513_o;
  wire [39:0] n8514_o;
  wire [39:0] n8515_o;
  wire [39:0] n8516_o;
  wire [39:0] n8517_o;
  wire [39:0] n8518_o;
  wire [39:0] n8519_o;
  wire [39:0] n8520_o;
  wire [39:0] n8521_o;
  wire [39:0] n8522_o;
  wire [39:0] n8523_o;
  wire [39:0] n8524_o;
  wire [39:0] n8525_o;
  wire [39:0] n8526_o;
  wire [39:0] n8527_o;
  wire [39:0] n8528_o;
  wire [39:0] n8529_o;
  wire [39:0] n8530_o;
  wire [639:0] n8531_o;
  wire n8532_o;
  wire n8533_o;
  wire n8534_o;
  wire n8535_o;
  wire n8536_o;
  wire n8537_o;
  wire n8538_o;
  wire n8539_o;
  wire n8540_o;
  wire n8541_o;
  wire n8542_o;
  wire n8543_o;
  wire n8544_o;
  wire n8545_o;
  wire n8546_o;
  wire n8547_o;
  wire n8548_o;
  wire n8549_o;
  wire n8550_o;
  wire n8551_o;
  wire n8552_o;
  wire n8553_o;
  wire n8554_o;
  wire n8555_o;
  wire n8556_o;
  wire n8557_o;
  wire n8558_o;
  wire n8559_o;
  wire n8560_o;
  wire n8561_o;
  wire n8562_o;
  wire n8563_o;
  wire n8564_o;
  wire n8565_o;
  wire n8566_o;
  wire n8567_o;
  wire [39:0] n8568_o;
  wire [39:0] n8569_o;
  wire [39:0] n8570_o;
  wire [39:0] n8571_o;
  wire [39:0] n8572_o;
  wire [39:0] n8573_o;
  wire [39:0] n8574_o;
  wire [39:0] n8575_o;
  wire [39:0] n8576_o;
  wire [39:0] n8577_o;
  wire [39:0] n8578_o;
  wire [39:0] n8579_o;
  wire [39:0] n8580_o;
  wire [39:0] n8581_o;
  wire [39:0] n8582_o;
  wire [39:0] n8583_o;
  wire [39:0] n8584_o;
  wire [39:0] n8585_o;
  wire [39:0] n8586_o;
  wire [39:0] n8587_o;
  wire [39:0] n8588_o;
  wire [39:0] n8589_o;
  wire [39:0] n8590_o;
  wire [39:0] n8591_o;
  wire [39:0] n8592_o;
  wire [39:0] n8593_o;
  wire [39:0] n8594_o;
  wire [39:0] n8595_o;
  wire [39:0] n8596_o;
  wire [39:0] n8597_o;
  wire [39:0] n8598_o;
  wire [39:0] n8599_o;
  wire [639:0] n8600_o;
  wire n8601_o;
  wire n8602_o;
  wire n8603_o;
  wire n8604_o;
  wire n8605_o;
  wire n8606_o;
  wire n8607_o;
  wire n8608_o;
  wire n8609_o;
  wire n8610_o;
  wire n8611_o;
  wire n8612_o;
  wire n8613_o;
  wire n8614_o;
  wire n8615_o;
  wire n8616_o;
  wire n8617_o;
  wire n8618_o;
  wire n8619_o;
  wire n8620_o;
  wire n8621_o;
  wire n8622_o;
  wire n8623_o;
  wire n8624_o;
  wire n8625_o;
  wire n8626_o;
  wire n8627_o;
  wire n8628_o;
  wire n8629_o;
  wire n8630_o;
  wire n8631_o;
  wire n8632_o;
  wire n8633_o;
  wire n8634_o;
  wire n8635_o;
  wire n8636_o;
  wire [39:0] n8637_o;
  wire [39:0] n8638_o;
  wire [39:0] n8639_o;
  wire [39:0] n8640_o;
  wire [39:0] n8641_o;
  wire [39:0] n8642_o;
  wire [39:0] n8643_o;
  wire [39:0] n8644_o;
  wire [39:0] n8645_o;
  wire [39:0] n8646_o;
  wire [39:0] n8647_o;
  wire [39:0] n8648_o;
  wire [39:0] n8649_o;
  wire [39:0] n8650_o;
  wire [39:0] n8651_o;
  wire [39:0] n8652_o;
  wire [39:0] n8653_o;
  wire [39:0] n8654_o;
  wire [39:0] n8655_o;
  wire [39:0] n8656_o;
  wire [39:0] n8657_o;
  wire [39:0] n8658_o;
  wire [39:0] n8659_o;
  wire [39:0] n8660_o;
  wire [39:0] n8661_o;
  wire [39:0] n8662_o;
  wire [39:0] n8663_o;
  wire [39:0] n8664_o;
  wire [39:0] n8665_o;
  wire [39:0] n8666_o;
  wire [39:0] n8667_o;
  wire [39:0] n8668_o;
  wire [639:0] n8669_o;
  wire n8670_o;
  wire n8671_o;
  wire n8672_o;
  wire n8673_o;
  wire n8674_o;
  wire n8675_o;
  wire n8676_o;
  wire n8677_o;
  wire n8678_o;
  wire n8679_o;
  wire n8680_o;
  wire n8681_o;
  wire n8682_o;
  wire n8683_o;
  wire n8684_o;
  wire n8685_o;
  wire n8686_o;
  wire n8687_o;
  wire n8688_o;
  wire n8689_o;
  wire n8690_o;
  wire n8691_o;
  wire n8692_o;
  wire n8693_o;
  wire n8694_o;
  wire n8695_o;
  wire n8696_o;
  wire n8697_o;
  wire n8698_o;
  wire n8699_o;
  wire n8700_o;
  wire n8701_o;
  wire n8702_o;
  wire n8703_o;
  wire n8704_o;
  wire n8705_o;
  wire [39:0] n8706_o;
  wire [39:0] n8707_o;
  wire [39:0] n8708_o;
  wire [39:0] n8709_o;
  wire [39:0] n8710_o;
  wire [39:0] n8711_o;
  wire [39:0] n8712_o;
  wire [39:0] n8713_o;
  wire [39:0] n8714_o;
  wire [39:0] n8715_o;
  wire [39:0] n8716_o;
  wire [39:0] n8717_o;
  wire [39:0] n8718_o;
  wire [39:0] n8719_o;
  wire [39:0] n8720_o;
  wire [39:0] n8721_o;
  wire [39:0] n8722_o;
  wire [39:0] n8723_o;
  wire [39:0] n8724_o;
  wire [39:0] n8725_o;
  wire [39:0] n8726_o;
  wire [39:0] n8727_o;
  wire [39:0] n8728_o;
  wire [39:0] n8729_o;
  wire [39:0] n8730_o;
  wire [39:0] n8731_o;
  wire [39:0] n8732_o;
  wire [39:0] n8733_o;
  wire [39:0] n8734_o;
  wire [39:0] n8735_o;
  wire [39:0] n8736_o;
  wire [39:0] n8737_o;
  wire [639:0] n8738_o;
  assign o_r = n8252_q;
  assign o_g = n8254_q;
  assign o_b = n8256_q;
  assign o_hs = n8258_q;
  assign o_vs = n8260_q;
  assign o_de = n8262_q;
  assign o_vbl = n8264_q;
  assign o_brd = n8266_q;
  assign pal1_dr = n5245_q;
  assign pal2_dr = n5359_q;
  assign o_lltune = n8322_o;
  assign i_hdmax = n1581_q;
  assign i_vdmax = n1585_q;
  assign avl_burstcount = n2633_o;
  assign avl_writedata = n2632_o;
  assign avl_address = n2503_q;
  assign avl_write = avl_write_i;
  assign avl_read = avl_read_i;
  assign avl_byteenable = n2634_o;
  /* ascal.vhd:318:16  */
  assign i_pvs = n1588_q; // (signal)
  /* ascal.vhd:318:22  */
  assign i_pfl = n1591_q; // (signal)
  /* ascal.vhd:318:28  */
  assign i_pde = n1594_q; // (signal)
  /* ascal.vhd:318:34  */
  assign i_pce = n1597_q; // (signal)
  /* ascal.vhd:319:16  */
  assign i_ppix = n1600_q; // (signal)
  /* ascal.vhd:320:16  */
  assign i_freeze = n1603_q; // (signal)
  /* ascal.vhd:321:16  */
  assign i_count = n1607_q; // (signal)
  /* ascal.vhd:322:16  */
  assign i_hsize = n1611_q; // (signal)
  /* ascal.vhd:322:24  */
  assign i_hmin = n1615_q; // (signal)
  /* ascal.vhd:322:31  */
  assign i_hmax = n1619_q; // (signal)
  /* ascal.vhd:322:38  */
  assign i_hcpt = n1623_q; // (signal)
  /* ascal.vhd:323:16  */
  assign i_hrsize = n1970_o; // (signal)
  /* ascal.vhd:323:25  */
  assign i_vrsize = n1972_o; // (signal)
  /* ascal.vhd:324:16  */
  assign i_himax = n1627_q; // (signal)
  /* ascal.vhd:324:24  */
  assign i_vimax = n1631_q; // (signal)
  /* ascal.vhd:325:16  */
  assign i_vsize = n1635_q; // (signal)
  /* ascal.vhd:325:24  */
  assign i_vmaxmin = n1639_q; // (signal)
  /* ascal.vhd:325:34  */
  assign i_vmin = n1643_q; // (signal)
  /* ascal.vhd:325:41  */
  assign i_vmax = n1647_q; // (signal)
  /* ascal.vhd:325:48  */
  assign i_vcpt = n1651_q; // (signal)
  /* ascal.vhd:326:16  */
  assign i_iauto = n1654_q; // (signal)
  /* ascal.vhd:327:16  */
  assign i_mode = n1658_q; // (signal)
  /* ascal.vhd:328:16  */
  assign i_format = n1662_q; // (signal)
  /* ascal.vhd:329:16  */
  assign i_ven = n1666_q; // (signal)
  /* ascal.vhd:329:22  */
  assign i_sof = n1670_q; // (signal)
  /* ascal.vhd:330:16  */
  assign i_wr = n1673_q; // (signal)
  /* ascal.vhd:331:16  */
  assign i_divstart = n1677_q; // (signal)
  /* ascal.vhd:331:27  */
  assign i_divrun = n2038_q; // (signal)
  /* ascal.vhd:332:16  */
  assign i_de_pre = n1681_q; // (signal)
  /* ascal.vhd:332:25  */
  assign i_vs_pre = n1685_q; // (signal)
  /* ascal.vhd:332:34  */
  assign i_fl_pre = n1689_q; // (signal)
  /* ascal.vhd:333:16  */
  assign i_de_delay = n1693_q; // (signal)
  /* ascal.vhd:334:16  */
  assign i_intercnt = n1697_q; // (signal)
  /* ascal.vhd:335:16  */
  assign i_inter = n1701_q; // (signal)
  /* ascal.vhd:335:24  */
  assign i_half = n1705_q; // (signal)
  /* ascal.vhd:335:31  */
  assign i_flm = n1709_q; // (signal)
  /* ascal.vhd:336:16  */
  assign i_write = n1711_q; // (signal)
  /* ascal.vhd:336:24  */
  assign i_wreq = n1714_q; // (signal)
  /* ascal.vhd:336:31  */
  assign i_alt = n1717_q; // (signal)
  /* ascal.vhd:336:37  */
  assign i_line = n1721_q; // (signal)
  /* ascal.vhd:336:44  */
  assign i_wline = n1725_q; // (signal)
  /* ascal.vhd:336:52  */
  assign i_wline_mem = n1729_q; // (signal)
  /* ascal.vhd:337:16  */
  assign i_walt = n1733_q; // (signal)
  /* ascal.vhd:337:23  */
  assign i_walt_mem = n1737_q; // (signal)
  /* ascal.vhd:337:34  */
  assign i_wreq_mem = n1740_q; // (signal)
  /* ascal.vhd:338:16  */
  assign i_wdelay = n1743_q; // (signal)
  /* ascal.vhd:339:16  */
  assign i_push = n1746_q; // (signal)
  /* ascal.vhd:339:23  */
  assign i_pushend = n1750_q; // (signal)
  /* ascal.vhd:339:33  */
  assign i_pushend2 = n1754_q; // (signal)
  /* ascal.vhd:340:16  */
  assign i_eol = n1757_q; // (signal)
  /* ascal.vhd:341:16  */
  assign i_pushhead = n1760_q; // (signal)
  /* ascal.vhd:341:27  */
  assign i_pushhead2 = n1763_q; // (signal)
  /* ascal.vhd:341:39  */
  assign i_pushhead3 = n1766_q; // (signal)
  /* ascal.vhd:342:16  */
  assign i_hburst = n1770_q; // (signal)
  /* ascal.vhd:342:25  */
  assign i_hbcpt = n1773_q; // (signal)
  /* ascal.vhd:542:69  */
  always @*
    i_shift = n1777_q; // (isignal)
  initial
    i_shift <= 120'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* ascal.vhd:1469:45  */
  assign i_head = n1780_q; // (signal)
  /* ascal.vhd:345:16  */
  assign i_acpt = n1784_q; // (signal)
  /* ascal.vhd:348:16  */
  assign i_endframe0 = n1788_q; // (signal)
  /* ascal.vhd:348:28  */
  assign i_endframe1 = n1792_q; // (signal)
  /* ascal.vhd:348:40  */
  assign i_vss = n1796_q; // (signal)
  /* ascal.vhd:349:16  */
  assign i_wad = n1799_q; // (signal)
  /* ascal.vhd:350:16  */
  assign i_dw = n1802_q; // (signal)
  /* ascal.vhd:351:16  */
  assign i_adrs = n1805_q; // (signal)
  /* ascal.vhd:351:23  */
  assign i_adrsi = n1808_q; // (signal)
  /* ascal.vhd:351:31  */
  assign i_wadrs = n1812_q; // (signal)
  /* ascal.vhd:351:39  */
  assign i_wadrs_mem = n1816_q; // (signal)
  /* ascal.vhd:352:16  */
  assign i_reset_na = n29_q; // (signal)
  /* ascal.vhd:353:16  */
  assign i_hnp = n1820_q; // (signal)
  /* ascal.vhd:353:22  */
  assign i_vnp = n1824_q; // (signal)
  /* ascal.vhd:356:16  */
  assign i_ohsize = n1828_q; // (signal)
  /* ascal.vhd:356:25  */
  assign i_ovsize = n1832_q; // (signal)
  /* ascal.vhd:357:16  */
  assign i_vdivi = n2041_q; // (signal)
  /* ascal.vhd:358:16  */
  assign i_vdivr = n2044_q; // (signal)
  /* ascal.vhd:359:16  */
  assign i_div = n1836_q; // (signal)
  /* ascal.vhd:360:16  */
  assign i_dir = n1840_q; // (signal)
  /* ascal.vhd:361:16  */
  assign i_h_frac = n1844_q; // (signal)
  /* ascal.vhd:1390:66  */
  assign i_v_frac = n2047_q; // (signal)
  /* ascal.vhd:362:16  */
  assign i_hacc = n1848_q; // (signal)
  /* ascal.vhd:362:23  */
  assign i_vacc = n1852_q; // (signal)
  /* ascal.vhd:363:16  */
  assign i_hdown = n1856_q; // (signal)
  /* ascal.vhd:363:24  */
  assign i_vdown = n1860_q; // (signal)
  /* ascal.vhd:364:16  */
  assign i_divcpt = n2050_q; // (signal)
  /* ascal.vhd:365:16  */
  assign i_lwad = n1863_q; // (signal)
  /* ascal.vhd:365:23  */
  assign i_lrad = n1866_q; // (signal)
  /* ascal.vhd:366:16  */
  assign i_lwr = n1869_q; // (signal)
  /* ascal.vhd:366:22  */
  assign i_bil = n1873_q; // (signal)
  /* ascal.vhd:367:16  */
  assign i_ldw = n1876_q; // (signal)
  /* ascal.vhd:367:22  */
  assign i_ldrm = n8339_data; // (signal)
  /* ascal.vhd:368:16  */
  assign i_hpixp = n1880_q; // (signal)
  /* ascal.vhd:368:24  */
  assign i_hpix0 = n1884_q; // (signal)
  /* ascal.vhd:368:32  */
  assign i_hpix1 = n1888_q; // (signal)
  /* ascal.vhd:368:40  */
  assign i_hpix2 = n1892_q; // (signal)
  /* ascal.vhd:368:48  */
  assign i_hpix3 = n1896_q; // (signal)
  /* ascal.vhd:368:56  */
  assign i_hpix4 = n1900_q; // (signal)
  /* ascal.vhd:369:16  */
  assign i_hpix = n1904_q; // (signal)
  /* ascal.vhd:369:23  */
  assign i_pix = n1908_q; // (signal)
  /* ascal.vhd:370:16  */
  assign i_hnp1 = n1912_q; // (signal)
  /* ascal.vhd:370:23  */
  assign i_hnp2 = n1916_q; // (signal)
  /* ascal.vhd:370:30  */
  assign i_hnp3 = n1920_q; // (signal)
  /* ascal.vhd:370:37  */
  assign i_hnp4 = n1924_q; // (signal)
  /* ascal.vhd:371:16  */
  assign i_ven1 = n1928_q; // (signal)
  /* ascal.vhd:371:23  */
  assign i_ven2 = n1932_q; // (signal)
  /* ascal.vhd:371:30  */
  assign i_ven3 = n1936_q; // (signal)
  /* ascal.vhd:371:37  */
  assign i_ven4 = n1940_q; // (signal)
  /* ascal.vhd:371:44  */
  assign i_ven5 = n1944_q; // (signal)
  /* ascal.vhd:371:51  */
  assign i_ven6 = n1948_q; // (signal)
  /* ascal.vhd:376:16  */
  assign avl_state = n2504_q; // (signal)
  /* ascal.vhd:377:16  */
  assign avl_write_i = n2507_q; // (signal)
  /* ascal.vhd:377:28  */
  assign avl_write_sync = n2510_q; // (signal)
  /* ascal.vhd:377:43  */
  assign avl_write_sync2 = n2513_q; // (signal)
  /* ascal.vhd:378:16  */
  assign avl_read_i = n2516_q; // (signal)
  /* ascal.vhd:378:27  */
  assign avl_read_sync = n2519_q; // (signal)
  /* ascal.vhd:378:41  */
  assign avl_read_sync2 = n2522_q; // (signal)
  /* ascal.vhd:379:16  */
  assign avl_read_pulse = n2525_q; // (signal)
  /* ascal.vhd:379:31  */
  assign avl_write_pulse = n2528_q; // (signal)
  /* ascal.vhd:380:16  */
  assign avl_read_sr = n2529_q; // (signal)
  /* ascal.vhd:380:28  */
  assign avl_write_sr = n2530_q; // (signal)
  /* ascal.vhd:380:41  */
  assign avl_read_clr = n2533_q; // (signal)
  /* ascal.vhd:380:54  */
  assign avl_write_clr = n2536_q; // (signal)
  /* ascal.vhd:381:16  */
  assign avl_rad = n2539_q; // (signal)
  /* ascal.vhd:381:24  */
  assign avl_rad_c = n2642_o; // (signal)
  /* ascal.vhd:381:34  */
  assign avl_wad = n2542_q; // (signal)
  /* ascal.vhd:382:16  */
  assign avl_walt = n2546_q; // (signal)
  /* ascal.vhd:382:25  */
  assign avl_wline = n2550_q; // (signal)
  /* ascal.vhd:382:35  */
  assign avl_rline = n2553_q; // (signal)
  /* ascal.vhd:383:16  */
  assign avl_dw = n2556_q; // (signal)
  /* ascal.vhd:383:23  */
  assign avl_dr = n8337_data; // (signal)
  /* ascal.vhd:384:16  */
  assign avl_wr = n2559_q; // (signal)
  /* ascal.vhd:385:16  */
  assign avl_readdataack = n2561_q; // (signal)
  /* ascal.vhd:385:32  */
  assign avl_readack = n2562_q; // (signal)
  /* ascal.vhd:386:16  */
  assign avl_radrs = n2565_q; // (signal)
  /* ascal.vhd:386:26  */
  assign avl_wadrs = n2569_q; // (signal)
  /* ascal.vhd:387:16  */
  assign avl_i_offset0 = n2572_q; // (signal)
  /* ascal.vhd:387:30  */
  assign avl_o_offset0 = n2575_q; // (signal)
  /* ascal.vhd:388:16  */
  assign avl_i_offset1 = n2578_q; // (signal)
  /* ascal.vhd:388:30  */
  assign avl_o_offset1 = n2581_q; // (signal)
  /* ascal.vhd:389:16  */
  assign avl_reset_na = n43_q; // (signal)
  /* ascal.vhd:390:16  */
  assign avl_o_vs_sync = n2584_q; // (signal)
  /* ascal.vhd:390:30  */
  assign avl_o_vs = n2587_q; // (signal)
  /* ascal.vhd:391:16  */
  assign avl_fb_ena = n2590_q; // (signal)
  /* ascal.vhd:411:16  */
  assign o_run = n4510_q; // (signal)
  /* ascal.vhd:412:16  */
  assign o_freeze = n4513_q; // (signal)
  /* ascal.vhd:413:16  */
  assign o_mode = n4516_q; // (signal)
  /* ascal.vhd:413:23  */
  assign o_hmode = n4519_q; // (signal)
  /* ascal.vhd:413:31  */
  assign o_vmode = n4522_q; // (signal)
  /* ascal.vhd:414:16  */
  assign o_format = n4525_q; // (signal)
  /* ascal.vhd:415:16  */
  assign o_fb_pal_dr = n5369_o; // (signal)
  /* ascal.vhd:416:16  */
  assign o_fb_pal_dr2 = n8349_data; // (signal)
  /* ascal.vhd:417:16  */
  assign o_fb_pal_dr_x2 = n8345_data; // (signal)
  /* ascal.vhd:2395:60  */
  assign pal_idx = n5329_o; // (signal)
  /* ascal.vhd:419:16  */
  assign pal_idx_lsb = n5333_q; // (signal)
  /* ascal.vhd:424:16  */
  assign o_htotal = n4528_q; // (signal)
  /* ascal.vhd:424:25  */
  assign o_hsstart = n4531_q; // (signal)
  /* ascal.vhd:424:35  */
  assign o_hsend = n4534_q; // (signal)
  /* ascal.vhd:425:16  */
  assign o_hmin = n4537_q; // (signal)
  /* ascal.vhd:425:23  */
  assign o_hmax = n4540_q; // (signal)
  /* ascal.vhd:425:30  */
  assign o_hdisp = n4543_q; // (signal)
  /* ascal.vhd:425:38  */
  assign o_v_hmin_adj = n8268_q; // (signal)
  /* ascal.vhd:426:16  */
  assign o_hsize = n4546_q; // (signal)
  /* ascal.vhd:426:24  */
  assign o_vsize = n4549_q; // (signal)
  /* ascal.vhd:427:16  */
  assign o_vtotal = n4552_q; // (signal)
  /* ascal.vhd:427:25  */
  assign o_vsstart = n4555_q; // (signal)
  /* ascal.vhd:427:35  */
  assign o_vsend = n4558_q; // (signal)
  /* ascal.vhd:428:16  */
  assign o_vrr = n4561_q; // (signal)
  /* ascal.vhd:428:22  */
  assign o_isync = n4564_q; // (signal)
  /* ascal.vhd:428:30  */
  assign o_isync2 = n4567_q; // (signal)
  /* ascal.vhd:429:16  */
  assign o_vrr_sync = n6970_q; // (signal)
  /* ascal.vhd:429:27  */
  assign o_vrr_sync2 = n6971_q; // (signal)
  /* ascal.vhd:430:16  */
  assign o_vrr_min = n6972_q; // (signal)
  /* ascal.vhd:430:26  */
  assign o_vrr_min2 = n6973_q; // (signal)
  /* ascal.vhd:431:16  */
  assign o_vrr_max = n6974_q; // (signal)
  /* ascal.vhd:431:26  */
  assign o_vrr_max2 = n6975_q; // (signal)
  /* ascal.vhd:432:16  */
  assign o_vcpt_sync = n6976_q; // (signal)
  /* ascal.vhd:432:28  */
  assign o_vcpt_sync2 = n6977_q; // (signal)
  /* ascal.vhd:432:42  */
  assign o_vrrmax = n4570_q; // (signal)
  /* ascal.vhd:433:16  */
  assign o_sync = n6978_q; // (signal)
  /* ascal.vhd:433:24  */
  assign o_sync_max = n6980_q; // (signal)
  /* ascal.vhd:434:16  */
  assign o_vmin = n4573_q; // (signal)
  /* ascal.vhd:434:23  */
  assign o_vmax = n4576_q; // (signal)
  /* ascal.vhd:434:30  */
  assign o_vdisp = n4579_q; // (signal)
  /* ascal.vhd:435:16  */
  assign o_divcpt = n2724_q; // (signal)
  /* ascal.vhd:436:16  */
  assign o_iendframe0 = n4582_q; // (signal)
  /* ascal.vhd:436:29  */
  assign o_iendframe02 = n4585_q; // (signal)
  /* ascal.vhd:436:43  */
  assign o_iendframe1 = n4588_q; // (signal)
  /* ascal.vhd:436:56  */
  assign o_iendframe12 = n4591_q; // (signal)
  /* ascal.vhd:437:16  */
  assign o_bufup0 = n4594_q; // (signal)
  /* ascal.vhd:437:25  */
  assign o_bufup1 = n4597_q; // (signal)
  /* ascal.vhd:437:34  */
  assign o_inter = n4600_q; // (signal)
  /* ascal.vhd:438:16  */
  assign o_ibuf0 = n4603_q; // (signal)
  /* ascal.vhd:438:24  */
  assign o_ibuf1 = n4606_q; // (signal)
  /* ascal.vhd:438:32  */
  assign o_obuf0 = n4609_q; // (signal)
  /* ascal.vhd:438:40  */
  assign o_obuf1 = n4612_q; // (signal)
  /* ascal.vhd:440:16  */
  assign o_state = n4613_q; // (signal)
  /* ascal.vhd:442:16  */
  assign o_copy = n4614_q; // (signal)
  /* ascal.vhd:443:16  */
  assign o_pshift = n4617_q; // (signal)
  /* ascal.vhd:444:16  */
  assign o_readack = n4620_q; // (signal)
  /* ascal.vhd:444:26  */
  assign o_readack_sync = n4623_q; // (signal)
  /* ascal.vhd:444:41  */
  assign o_readack_sync2 = n4626_q; // (signal)
  /* ascal.vhd:445:16  */
  assign o_readdataack = n4629_q; // (signal)
  /* ascal.vhd:445:30  */
  assign o_readdataack_sync = n4632_q; // (signal)
  /* ascal.vhd:445:49  */
  assign o_readdataack_sync2 = n4635_q; // (signal)
  /* ascal.vhd:446:16  */
  assign o_copyv = n8323_o; // (signal)
  /* ascal.vhd:447:16  */
  assign o_adrs = n4643_q; // (signal)
  /* ascal.vhd:448:16  */
  assign o_adrs_pre = n4646_q; // (signal)
  /* ascal.vhd:449:16  */
  assign o_stride = n4649_q; // (signal)
  /* ascal.vhd:450:16  */
  assign o_adrsa = n4652_q; // (signal)
  /* ascal.vhd:450:24  */
  assign o_adrsb = n4655_q; // (signal)
  /* ascal.vhd:450:32  */
  assign o_rline = n4658_q; // (signal)
  /* ascal.vhd:451:16  */
  assign o_ad = n4661_q; // (signal)
  /* ascal.vhd:451:21  */
  assign o_ad1 = n4664_q; // (signal)
  /* ascal.vhd:451:27  */
  assign o_ad2 = n4667_q; // (signal)
  /* ascal.vhd:451:33  */
  assign o_ad3 = n4670_q; // (signal)
  /* ascal.vhd:452:16  */
  assign o_adturn = n4673_q; // (signal)
  /* ascal.vhd:453:16  */
  assign o_dr = n8342_data; // (signal)
  /* ascal.vhd:454:16  */
  assign o_shift = n4677_q; // (signal)
  /* ascal.vhd:455:16  */
  assign o_sh = n4680_q; // (signal)
  /* ascal.vhd:455:21  */
  assign o_sh1 = n4683_q; // (signal)
  /* ascal.vhd:455:27  */
  assign o_sh2 = n4686_q; // (signal)
  /* ascal.vhd:455:33  */
  assign o_sh3 = n4689_q; // (signal)
  /* ascal.vhd:455:39  */
  assign o_sh4 = n4692_q; // (signal)
  /* ascal.vhd:456:16  */
  assign o_reset_na = n36_q; // (signal)
  /* ascal.vhd:464:16  */
  assign o_wadl = n6643_q; // (signal)
  /* ascal.vhd:464:23  */
  assign o_radl0 = n8270_q; // (signal)
  /* ascal.vhd:464:31  */
  assign o_radl1 = n8272_q; // (signal)
  /* ascal.vhd:464:39  */
  assign o_radl2 = n8274_q; // (signal)
  /* ascal.vhd:464:47  */
  assign o_radl3 = n8276_q; // (signal)
  /* ascal.vhd:465:16  */
  assign o_ldw = n6644_q; // (signal)
  /* ascal.vhd:465:22  */
  assign o_ldr0 = n8353_data; // (signal)
  /* ascal.vhd:465:29  */
  assign o_ldr1 = n8356_data; // (signal)
  /* ascal.vhd:465:36  */
  assign o_ldr2 = n8359_data; // (signal)
  /* ascal.vhd:465:43  */
  assign o_ldr3 = n8362_data; // (signal)
  /* ascal.vhd:466:16  */
  assign o_wr = n6645_q; // (signal)
  /* ascal.vhd:467:16  */
  assign o_hcpt = n6982_q; // (signal)
  /* ascal.vhd:467:23  */
  assign o_vcpt = n6984_q; // (signal)
  /* ascal.vhd:467:30  */
  assign o_vcpt_pre = n6986_q; // (signal)
  /* ascal.vhd:467:41  */
  assign o_vcpt_pre2 = n6988_q; // (signal)
  /* ascal.vhd:467:53  */
  assign o_vcpt_pre3 = n6990_q; // (signal)
  /* ascal.vhd:467:65  */
  assign o_vcpt2 = n6991_q; // (signal)
  /* ascal.vhd:468:16  */
  assign o_ihsize = n4695_q; // (signal)
  /* ascal.vhd:468:25  */
  assign o_ihsizem = n4698_q; // (signal)
  /* ascal.vhd:468:35  */
  assign o_ivsize = n4701_q; // (signal)
  /* ascal.vhd:469:16  */
  assign o_ihsize_temp = n4704_q; // (signal)
  /* ascal.vhd:469:31  */
  assign o_ihsize_temp2 = n4707_q; // (signal)
  /* ascal.vhd:471:16  */
  assign o_vfrac = n2727_q; // (signal)
  /* ascal.vhd:472:16  */
  assign o_hfrac = n8325_o; // (signal)
  /* ascal.vhd:475:16  */
  assign o_hacc = n4710_q; // (signal)
  /* ascal.vhd:475:23  */
  assign o_hacc_ini = n4713_q; // (signal)
  /* ascal.vhd:475:34  */
  assign o_hacc_next = n4716_q; // (signal)
  /* ascal.vhd:475:46  */
  assign o_vacc = n4719_q; // (signal)
  /* ascal.vhd:475:53  */
  assign o_vacc_next = n4722_q; // (signal)
  /* ascal.vhd:475:65  */
  assign o_vacc_ini = n4725_q; // (signal)
  /* ascal.vhd:476:16  */
  assign o_hsv = n6993_q; // (signal)
  /* ascal.vhd:476:22  */
  assign o_vsv = n6995_q; // (signal)
  /* ascal.vhd:476:28  */
  assign o_dev = n6997_q; // (signal)
  /* ascal.vhd:476:34  */
  assign o_pev = n6999_q; // (signal)
  /* ascal.vhd:476:40  */
  assign o_end = n7001_q; // (signal)
  /* ascal.vhd:477:16  */
  assign o_hsp = n4726_q; // (signal)
  /* ascal.vhd:477:22  */
  assign o_vss = n7003_q; // (signal)
  /* ascal.vhd:478:16  */
  assign o_vcarrym = n4729_q; // (signal)
  /* ascal.vhd:478:26  */
  assign o_prim = n4732_q; // (signal)
  /* ascal.vhd:479:16  */
  assign o_read = n4735_q; // (signal)
  /* ascal.vhd:479:23  */
  assign o_read_pre = n4736_q; // (signal)
  /* ascal.vhd:480:16  */
  assign o_readlev = n4737_q; // (signal)
  /* ascal.vhd:480:26  */
  assign o_copylev = n4738_q; // (signal)
  /* ascal.vhd:481:16  */
  assign o_hburst = n4741_q; // (signal)
  /* ascal.vhd:481:25  */
  assign o_hbcpt = n4744_q; // (signal)
  /* ascal.vhd:482:16  */
  assign o_fload = n4747_q; // (signal)
  /* ascal.vhd:483:16  */
  assign o_acpt = n4750_q; // (signal)
  /* ascal.vhd:483:23  */
  assign o_acpt1 = n4753_q; // (signal)
  /* ascal.vhd:483:31  */
  assign o_acpt2 = n4756_q; // (signal)
  /* ascal.vhd:483:39  */
  assign o_acpt3 = n4759_q; // (signal)
  /* ascal.vhd:483:47  */
  assign o_acpt4 = n4762_q; // (signal)
  /* ascal.vhd:484:16  */
  assign o_dshi = n4765_q; // (signal)
  /* ascal.vhd:485:16  */
  assign o_first = n4768_q; // (signal)
  /* ascal.vhd:485:24  */
  assign o_last = n4771_q; // (signal)
  /* ascal.vhd:485:31  */
  assign o_last1 = n4774_q; // (signal)
  /* ascal.vhd:485:39  */
  assign o_last2 = n4777_q; // (signal)
  /* ascal.vhd:486:16  */
  assign o_lastt1 = n4780_q; // (signal)
  /* ascal.vhd:486:25  */
  assign o_lastt2 = n4783_q; // (signal)
  /* ascal.vhd:486:34  */
  assign o_lastt3 = n4786_q; // (signal)
  /* ascal.vhd:486:43  */
  assign o_lastt4 = n4789_q; // (signal)
  /* ascal.vhd:487:16  */
  assign o_alt = n4793_q; // (signal)
  /* ascal.vhd:487:22  */
  assign o_altx = n4796_q; // (signal)
  /* ascal.vhd:488:16  */
  assign o_hdown = n4799_q; // (signal)
  /* ascal.vhd:488:24  */
  assign o_vdown = n4802_q; // (signal)
  /* ascal.vhd:489:16  */
  assign o_primv = n4805_q; // (signal)
  /* ascal.vhd:489:24  */
  assign o_lastv = n4808_q; // (signal)
  /* ascal.vhd:489:32  */
  assign o_bibv = n4811_q; // (signal)
  /* ascal.vhd:491:16  */
  assign o_off = n4814_q; // (signal)
  /* ascal.vhd:492:16  */
  always @*
    o_bibu = n4817_q; // (isignal)
  initial
    o_bibu <= 1'b0;
  /* ascal.vhd:493:16  */
  assign o_dcptv = n6647_q; // (signal)
  /* ascal.vhd:494:16  */
  assign o_dcpt = n4820_q; // (signal)
  /* ascal.vhd:495:16  */
  assign o_hpixs = n4824_q; // (signal)
  /* ascal.vhd:495:24  */
  assign o_hpix0 = n4828_q; // (signal)
  /* ascal.vhd:495:32  */
  assign o_hpix1 = n4832_q; // (signal)
  /* ascal.vhd:495:40  */
  assign o_hpix2 = n4836_q; // (signal)
  /* ascal.vhd:495:48  */
  assign o_hpix3 = n4840_q; // (signal)
  /* ascal.vhd:496:16  */
  assign o_hpixq = n6648_q; // (signal)
  /* ascal.vhd:498:16  */
  assign o_vpixq = n8278_q; // (signal)
  /* ascal.vhd:498:25  */
  assign o_vpixq_pre = n8280_q; // (signal)
  /* ascal.vhd:499:16  */
  assign o_vpix_outer = n8282_q; // (signal)
  /* ascal.vhd:500:16  */
  assign o_vpix_inner = n8327_o; // (signal)
  /* ascal.vhd:503:16  */
  assign o_vpe = n4843_q; // (signal)
  /* ascal.vhd:504:16  */
  assign o_div = n6649_q; // (signal)
  /* ascal.vhd:505:16  */
  assign o_dir = n6650_q; // (signal)
  /* ascal.vhd:507:16  */
  assign o_vdivi = n2730_q; // (signal)
  /* ascal.vhd:508:16  */
  assign o_vdivr = n2733_q; // (signal)
  /* ascal.vhd:509:16  */
  assign o_divstart = n4846_q; // (signal)
  /* ascal.vhd:510:16  */
  assign o_divrun = n2736_q; // (signal)
  /* ascal.vhd:511:16  */
  assign o_hacpt = n4849_q; // (signal)
  /* ascal.vhd:511:24  */
  assign o_vacpt = n4852_q; // (signal)
  /* ascal.vhd:512:16  */
  assign o_vacptl = n4855_q; // (signal)
  /* ascal.vhd:734:16  */
  assign o_h_bil_frac = n6651_q; // (signal)
  /* ascal.vhd:734:29  */
  assign o_v_bil_frac = n8287_q; // (signal)
  /* ascal.vhd:735:16  */
  assign o_h_bil_pix = n6652_q; // (signal)
  /* ascal.vhd:735:28  */
  assign o_v_bil_pix = n8289_q; // (signal)
  /* ascal.vhd:785:16  */
  assign o_h_bil_t = n6653_q; // (signal)
  /* ascal.vhd:785:26  */
  assign o_v_bil_t = n8291_q; // (signal)
  /* ascal.vhd:787:16  */
  assign i_h_bil_t = n1952_q; // (signal)
  /* ascal.vhd:799:16  */
  assign o_h_sbil_t = n6654_q; // (signal)
  /* ascal.vhd:799:27  */
  assign o_v_sbil_t = n8293_q; // (signal)
  /* ascal.vhd:950:16  */
  assign o_h_bic_pix = n6655_q; // (signal)
  /* ascal.vhd:950:28  */
  assign o_v_bic_pix = n8295_q; // (signal)
  /* ascal.vhd:951:16  */
  assign o_h_bic_abcd1 = n6656_q; // (signal)
  /* ascal.vhd:952:16  */
  assign o_v_bic_abcd1 = n8297_q; // (signal)
  /* ascal.vhd:953:16  */
  assign o_h_bic_tt1 = n6658_q; // (signal)
  /* ascal.vhd:953:28  */
  assign o_v_bic_tt1 = n8301_q; // (signal)
  /* ascal.vhd:954:16  */
  assign o_h_bic_tt2 = n6659_q; // (signal)
  /* ascal.vhd:954:28  */
  assign o_v_bic_tt2 = n8303_q; // (signal)
  /* ascal.vhd:973:16  */
  assign o_h_poly_mem = n5455_q; // (signal)
  /* ascal.vhd:974:16  */
  assign o_v_poly_mem = n5456_q; // (signal)
  /* ascal.vhd:975:16  */
  assign o_a_poly_mem = n5457_q; // (signal)
  /* ascal.vhd:979:16  */
  assign o_a_poly_addr = n5203_q; // (signal)
  /* ascal.vhd:979:31  */
  assign o_v_poly_addr = n5204_q; // (signal)
  /* ascal.vhd:980:16  */
  assign o_h_poly_phase_a = n5205_q; // (signal)
  /* ascal.vhd:980:33  */
  assign o_h_poly_phase_a2 = n5206_q; // (signal)
  /* ascal.vhd:980:51  */
  assign o_h_poly_phase_a3 = n5207_q; // (signal)
  /* ascal.vhd:980:70  */
  assign o_h_poly_phase_a4 = n5208_q; // (signal)
  /* ascal.vhd:980:89  */
  assign o_h_poly_phase_a5 = n5209_q; // (signal)
  /* ascal.vhd:981:16  */
  assign o_v_poly_phase_a = n5210_q; // (signal)
  /* ascal.vhd:981:33  */
  assign o_v_poly_phase_a2 = n5211_q; // (signal)
  /* ascal.vhd:981:51  */
  assign o_v_poly_phase_a3 = n5212_q; // (signal)
  /* ascal.vhd:981:70  */
  assign o_v_poly_phase_a4 = n5213_q; // (signal)
  /* ascal.vhd:981:89  */
  assign o_v_poly_phase_a5 = n5214_q; // (signal)
  /* ascal.vhd:982:16  */
  assign o_poly_phase_a = n5215_q; // (signal)
  /* ascal.vhd:982:32  */
  assign o_poly_phase_a2 = n5216_q; // (signal)
  /* ascal.vhd:983:16  */
  assign o_poly_phase_b = n5217_q; // (signal)
  /* ascal.vhd:983:31  */
  assign o_poly_phase_b2 = n5218_q; // (signal)
  /* ascal.vhd:984:16  */
  assign o_v_poly_phase = n5219_q; // (signal)
  /* ascal.vhd:984:49  */
  assign o_h_poly_phase = n5220_q; // (signal)
  /* ascal.vhd:984:65  */
  assign o_poly_phase = n5221_q; // (signal)
  /* ascal.vhd:984:79  */
  assign o_poly_phase1 = n5222_q; // (signal)
  /* ascal.vhd:985:16  */
  assign o_v_poly_pix = n8305_q; // (signal)
  /* ascal.vhd:985:30  */
  assign o_h_poly_pix = n6660_q; // (signal)
  /* ascal.vhd:985:44  */
  assign o_h_lum_pix = n6661_q; // (signal)
  /* ascal.vhd:985:57  */
  assign o_v_lum_pix = n8307_q; // (signal)
  /* ascal.vhd:986:16  */
  assign o_poly_lum = n5223_q; // (signal)
  /* ascal.vhd:986:28  */
  assign o_poly_lum1 = n5224_q; // (signal)
  /* ascal.vhd:987:16  */
  assign o_poly_lerp_ta = n5225_q; // (signal)
  /* ascal.vhd:987:32  */
  assign o_poly_lerp_tb = n5226_q; // (signal)
  /* ascal.vhd:988:16  */
  assign o_h_poly_t = n6662_q; // (signal)
  /* ascal.vhd:988:39  */
  assign o_v_poly_t = n8309_q; // (signal)
  /* ascal.vhd:990:16  */
  assign o_v_poly_adaptive = n5458_q; // (signal)
  /* ascal.vhd:990:35  */
  assign o_h_poly_adaptive = n5459_q; // (signal)
  /* ascal.vhd:990:54  */
  assign o_v_poly_use_adaptive = n5227_q; // (signal)
  /* ascal.vhd:990:77  */
  assign o_h_poly_use_adaptive = n5228_q; // (signal)
  /* ascal.vhd:991:16  */
  assign poly_wr_mode = n5460_q; // (signal)
  /* ascal.vhd:992:16  */
  assign poly_tdw = n8462_o; // (signal)
  /* ascal.vhd:993:16  */
  assign poly_a2 = n5462_q; // (signal)
  /* ascal.vhd:1112:40  */
  assign n24_o = ~reset_na;
  /* ascal.vhd:1112:45  */
  always @(posedge i_clk or posedge n24_o)
    if (n24_o)
      n29_q <= 1'b0;
    else
      n29_q <= 1'b1;
  /* ascal.vhd:1113:40  */
  assign n31_o = ~reset_na;
  /* ascal.vhd:1113:45  */
  always @(posedge o_clk or posedge n31_o)
    if (n31_o)
      n36_q <= 1'b0;
    else
      n36_q <= 1'b1;
  /* ascal.vhd:1114:40  */
  assign n38_o = ~reset_na;
  /* ascal.vhd:1114:45  */
  always @(posedge avl_clk or posedge n38_o)
    if (n38_o)
      n43_q <= 1'b0;
    else
      n43_q <= 1'b1;
  /* ascal.vhd:1125:30  */
  assign n49_o = ~i_reset_na;
  /* ascal.vhd:1139:58  */
  assign n53_o = {6'b000000, i_format};
  /* ascal.vhd:1146:43  */
  assign n60_o = i_mode[3];
  assign n62_o = n55_o[15:8];
  /* ascal.vhd:1148:54  */
  assign n65_o = {4'b0000, i_hrsize};
  /* ascal.vhd:1149:54  */
  assign n68_o = {4'b0000, i_vrsize};
  /* ascal.vhd:1150:68  */
  assign n69_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1150:68  */
  assign n71_o = 32'b00000000000000000000000100000000 * n69_o; // smul
  /* ascal.vhd:1150:60  */
  assign n72_o = n71_o[30:0];  // trunc
  /* ascal.vhd:1150:48  */
  assign n73_o = n72_o[15:0];  // trunc
  /* ascal.vhd:1151:54  */
  assign n76_o = {4'b0000, i_ohsize};
  /* ascal.vhd:1152:54  */
  assign n79_o = {4'b0000, i_ovsize};
  assign n80_o = {i_b, i_g, i_r};
  /* ascal.vhd:1172:44  */
  assign n81_o = i_pfl != i_fl_pre;
  /* ascal.vhd:1174:61  */
  assign n82_o = ~i_vs_pre;
  /* ascal.vhd:1174:49  */
  assign n83_o = i_pvs & n82_o;
  /* ascal.vhd:1174:80  */
  assign n84_o = {30'b0, i_intercnt};  //  uext
  /* ascal.vhd:1174:80  */
  assign n86_o = $signed(n84_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:1174:66  */
  assign n87_o = n83_o & n86_o;
  /* ascal.vhd:1175:63  */
  assign n88_o = {30'b0, i_intercnt};  //  uext
  /* ascal.vhd:1175:63  */
  assign n90_o = n88_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:1175:53  */
  assign n91_o = n90_o[1:0];  // trunc
  /* ascal.vhd:1174:33  */
  assign n92_o = n87_o ? n91_o : i_intercnt;
  /* ascal.vhd:1172:33  */
  assign n94_o = n81_o ? 2'b11 : n92_o;
  /* ascal.vhd:1177:65  */
  assign n96_o = {30'b0, i_intercnt};  //  uext
  /* ascal.vhd:1177:65  */
  assign n98_o = $signed(n96_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:285:17  */
  assign n105_o = n98_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1180:58  */
  assign n106_o = ~i_vs_pre;
  /* ascal.vhd:1180:46  */
  assign n107_o = i_pvs & n106_o;
  /* ascal.vhd:1180:33  */
  assign n109_o = n107_o ? 1'b1 : i_sof;
  /* ascal.vhd:1184:58  */
  assign n110_o = ~i_de_pre;
  /* ascal.vhd:1184:46  */
  assign n111_o = i_pde & n110_o;
  /* ascal.vhd:1188:46  */
  assign n113_o = i_pde & i_sof;
  /* ascal.vhd:1191:65  */
  assign n114_o = ~i_flm;
  /* ascal.vhd:1191:56  */
  assign n115_o = i_inter & n114_o;
  /* ascal.vhd:1191:80  */
  assign n116_o = ~i_half;
  /* ascal.vhd:1191:70  */
  assign n117_o = n115_o & n116_o;
  /* ascal.vhd:1191:85  */
  assign n119_o = n117_o & 1'b1;
  /* ascal.vhd:1193:78  */
  assign n120_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1193:78  */
  assign n122_o = 32'b00000000000000000000000100000000 * n120_o; // smul
  /* ascal.vhd:1193:70  */
  assign n123_o = n122_o[30:0];  // trunc
  /* ascal.vhd:1193:58  */
  assign n124_o = {1'b0, n123_o};  //  uext
  /* ascal.vhd:1193:93  */
  assign n127_o = n124_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1191:41  */
  assign n131_o = n119_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1191:41  */
  assign n133_o = n119_o ? n127_o : 32'b00000000000000000000000100000000;
  /* ascal.vhd:1188:33  */
  assign n135_o = n113_o ? 12'b000000000000 : i_vcpt;
  /* ascal.vhd:1188:33  */
  assign n137_o = n113_o ? 1'b0 : n109_o;
  /* ascal.vhd:1162:25  */
  assign n139_o = n1144_o ? n133_o : i_adrsi;
  /* ascal.vhd:1203:59  */
  assign n141_o = {20'b0, i_hcpt};  //  uext
  /* ascal.vhd:1203:59  */
  assign n142_o = {20'b0, i_hmin};  //  uext
  /* ascal.vhd:1203:59  */
  assign n143_o = $signed(n141_o) >= $signed(n142_o);
  /* ascal.vhd:1203:78  */
  assign n144_o = {20'b0, i_hcpt};  //  uext
  /* ascal.vhd:1203:78  */
  assign n145_o = {20'b0, i_hmax};  //  uext
  /* ascal.vhd:1203:78  */
  assign n146_o = $signed(n144_o) <= $signed(n145_o);
  /* ascal.vhd:1203:68  */
  assign n147_o = n143_o & n146_o;
  /* ascal.vhd:1204:119  */
  assign n148_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1204:119  */
  assign n149_o = {20'b0, i_vmin};  //  uext
  /* ascal.vhd:1204:119  */
  assign n150_o = $signed(n148_o) >= $signed(n149_o);
  /* ascal.vhd:1203:87  */
  assign n151_o = n147_o & n150_o;
  /* ascal.vhd:1204:138  */
  assign n152_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1204:138  */
  assign n153_o = {20'b0, i_vmax};  //  uext
  /* ascal.vhd:1204:138  */
  assign n154_o = $signed(n152_o) <= $signed(n153_o);
  /* ascal.vhd:1204:128  */
  assign n155_o = n151_o & n154_o;
  /* ascal.vhd:285:17  */
  assign n162_o = n155_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1207:56  */
  assign n163_o = ~i_inter;
  /* ascal.vhd:1207:68  */
  assign n164_o = n163_o | i_flm;
  /* ascal.vhd:1207:51  */
  assign n165_o = i_vs & n164_o;
  /* ascal.vhd:1208:56  */
  assign n166_o = ~i_inter;
  /* ascal.vhd:1208:71  */
  assign n167_o = ~i_flm;
  /* ascal.vhd:1208:68  */
  assign n168_o = n166_o | n167_o;
  /* ascal.vhd:1208:51  */
  assign n169_o = i_vs & n168_o;
  /* ascal.vhd:1210:59  */
  assign n171_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1210:59  */
  assign n172_o = {20'b0, i_vmin};  //  uext
  /* ascal.vhd:1210:59  */
  assign n173_o = $signed(n171_o) >= $signed(n172_o);
  /* ascal.vhd:1210:78  */
  assign n174_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1210:78  */
  assign n175_o = {20'b0, i_vmax};  //  uext
  /* ascal.vhd:1210:78  */
  assign n176_o = $signed(n174_o) <= $signed(n175_o);
  /* ascal.vhd:1210:68  */
  assign n177_o = n173_o & n176_o;
  /* ascal.vhd:285:17  */
  assign n184_o = n177_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1213:58  */
  assign n185_o = ~i_de_pre;
  /* ascal.vhd:1213:46  */
  assign n186_o = i_pde & n185_o;
  /* ascal.vhd:1217:56  */
  assign n187_o = {20'b0, i_hcpt};  //  uext
  /* ascal.vhd:1217:56  */
  assign n189_o = n187_o + 32'b00000000000000000000000000000001;
  assign n190_o = n189_o[11:0];
  /* ascal.vhd:1213:33  */
  assign n193_o = n186_o ? 12'b000000000000 : n190_o;
  /* ascal.vhd:1220:41  */
  assign n195_o = ~i_pde;
  /* ascal.vhd:1220:46  */
  assign n196_o = n195_o & i_de_pre;
  /* ascal.vhd:1229:66  */
  assign n198_o = ~i_vs_pre;
  /* ascal.vhd:1229:54  */
  assign n199_o = i_pvs & n198_o;
  /* ascal.vhd:1229:83  */
  assign n200_o = ~i_inter;
  /* ascal.vhd:1229:96  */
  assign n201_o = ~i_pfl;
  /* ascal.vhd:1229:88  */
  assign n202_o = n200_o | n201_o;
  /* ascal.vhd:1229:71  */
  assign n203_o = n199_o & n202_o;
  /* ascal.vhd:1229:41  */
  assign n204_o = n203_o ? i_vimax : i_vmax;
  /* ascal.vhd:1237:66  */
  assign n205_o = ~i_vs_pre;
  /* ascal.vhd:1237:54  */
  assign n206_o = i_pvs & n205_o;
  /* ascal.vhd:1237:83  */
  assign n207_o = ~i_inter;
  /* ascal.vhd:1237:96  */
  assign n208_o = ~i_pfl;
  /* ascal.vhd:1237:88  */
  assign n209_o = n207_o | n208_o;
  /* ascal.vhd:1237:71  */
  assign n210_o = n206_o & n209_o;
  /* ascal.vhd:1237:41  */
  assign n211_o = n210_o ? vimax : i_vmax;
  /* ascal.vhd:1224:33  */
  assign n213_o = i_iauto ? 12'b000000000000 : himin;
  /* ascal.vhd:1224:33  */
  assign n214_o = i_iauto ? i_himax : himax;
  /* ascal.vhd:1224:33  */
  assign n216_o = i_iauto ? 12'b000000000000 : vimin;
  /* ascal.vhd:1224:33  */
  assign n217_o = i_iauto ? n204_o : n211_o;
  /* ascal.vhd:1242:58  */
  assign n218_o = ~i_vs_pre;
  /* ascal.vhd:1242:46  */
  assign n219_o = i_pvs & n218_o;
  /* ascal.vhd:1242:75  */
  assign n220_o = ~i_inter;
  /* ascal.vhd:1242:88  */
  assign n221_o = ~i_pfl;
  /* ascal.vhd:1242:80  */
  assign n222_o = n220_o | n221_o;
  /* ascal.vhd:1242:63  */
  assign n223_o = n219_o & n222_o;
  /* ascal.vhd:1247:44  */
  assign n226_o = i_format == 2'b00;
  /* ascal.vhd:1247:61  */
  assign n228_o = i_format == 2'b11;
  /* ascal.vhd:1247:50  */
  assign n229_o = n226_o | n228_o;
  /* ascal.vhd:1248:60  */
  assign n230_o = {20'b0, i_hrsize};  //  uext
  /* ascal.vhd:1248:60  */
  assign n232_o = n230_o * 32'b00000000000000000000000000000010; // smul
  /* ascal.vhd:1248:63  */
  assign n234_o = n232_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1248:73  */
  assign n236_o = n234_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:1248:78  */
  assign n238_o = n236_o / 32'b00000000000000000000000100000000; // sdiv
  /* ascal.vhd:1248:51  */
  assign n239_o = n238_o[4:0];  // trunc
  /* ascal.vhd:1249:47  */
  assign n241_o = i_format == 2'b01;
  /* ascal.vhd:1250:60  */
  assign n242_o = {20'b0, i_hrsize};  //  uext
  /* ascal.vhd:1250:60  */
  assign n244_o = n242_o * 32'b00000000000000000000000000000011; // smul
  /* ascal.vhd:1250:63  */
  assign n246_o = n244_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1250:73  */
  assign n248_o = n246_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:1250:78  */
  assign n250_o = n248_o / 32'b00000000000000000000000100000000; // sdiv
  /* ascal.vhd:1250:51  */
  assign n251_o = n250_o[4:0];  // trunc
  /* ascal.vhd:1252:60  */
  assign n252_o = {20'b0, i_hrsize};  //  uext
  /* ascal.vhd:1252:60  */
  assign n254_o = n252_o * 32'b00000000000000000000000000000100; // smul
  /* ascal.vhd:1252:63  */
  assign n256_o = n254_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1252:73  */
  assign n258_o = n256_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:1252:78  */
  assign n260_o = n258_o / 32'b00000000000000000000000100000000; // sdiv
  /* ascal.vhd:1252:51  */
  assign n261_o = n260_o[4:0];  // trunc
  /* ascal.vhd:1249:33  */
  assign n262_o = n241_o ? n251_o : n261_o;
  /* ascal.vhd:1247:33  */
  assign n263_o = n229_o ? n239_o : n262_o;
  /* ascal.vhd:1259:59  */
  assign n265_o = i_mode[2:0];
  /* ascal.vhd:1259:71  */
  assign n267_o = n265_o != 3'b000;
  /* ascal.vhd:1259:79  */
  assign n269_o = n267_o & 1'b1;
  /* ascal.vhd:285:17  */
  assign n276_o = n269_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1261:62  */
  assign n278_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1261:62  */
  assign n279_o = {20'b0, i_ohsize};  //  uext
  /* ascal.vhd:1261:62  */
  assign n280_o = $signed(n278_o) > $signed(n279_o);
  /* ascal.vhd:1261:72  */
  assign n282_o = n280_o & 1'b1;
  /* ascal.vhd:285:17  */
  assign n289_o = n282_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1262:62  */
  assign n291_o = {20'b0, i_vsize};  //  uext
  /* ascal.vhd:1262:62  */
  assign n292_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1262:62  */
  assign n293_o = $signed(n291_o) > $signed(n292_o);
  /* ascal.vhd:1262:72  */
  assign n295_o = n293_o & 1'b1;
  /* ascal.vhd:285:17  */
  assign n302_o = n295_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1265:49  */
  assign n303_o = {20'b0, i_hmax};  //  uext
  /* ascal.vhd:1265:49  */
  assign n305_o = 32'b00000000000000000001000000000000 + n303_o;
  /* ascal.vhd:1265:56  */
  assign n306_o = {20'b0, i_hmin};  //  uext
  /* ascal.vhd:1265:56  */
  assign n307_o = n305_o - n306_o;
  /* ascal.vhd:1265:63  */
  assign n309_o = n307_o + 32'b00000000000000000000000000000001;
  assign n310_o = n309_o[11:0];
  /* ascal.vhd:1266:49  */
  assign n312_o = {20'b0, i_vmax};  //  uext
  /* ascal.vhd:1266:49  */
  assign n314_o = 32'b00000000000000000001000000000000 + n312_o;
  /* ascal.vhd:1266:56  */
  assign n315_o = {20'b0, i_vmin};  //  uext
  /* ascal.vhd:1266:56  */
  assign n316_o = n314_o - n315_o;
  /* ascal.vhd:1266:63  */
  assign n318_o = n316_o + 32'b00000000000000000000000000000001;
  assign n319_o = n318_o[11:0];
  /* ascal.vhd:1268:43  */
  assign n321_o = ~i_inter;
  /* ascal.vhd:1272:47  */
  assign n322_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1272:49  */
  assign n323_o = {20'b0, i_vmaxmin};  //  uext
  /* ascal.vhd:1272:49  */
  assign n325_o = 32'b00000000000000000000000000000010 * n323_o; // smul
  /* ascal.vhd:1272:47  */
  assign n326_o = $signed(n322_o) < $signed(n325_o);
  /* ascal.vhd:1278:51  */
  assign n327_o = {20'b0, i_vmaxmin};  //  uext
  /* ascal.vhd:1278:51  */
  assign n329_o = 32'b00000000000000000000000000000010 * n327_o; // smul
  /* ascal.vhd:1278:50  */
  assign n330_o = n329_o[11:0];  // trunc
  /* ascal.vhd:1272:33  */
  assign n331_o = n326_o ? i_vmaxmin : n330_o;
  /* ascal.vhd:1272:33  */
  assign n334_o = n326_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1268:33  */
  assign n335_o = n321_o ? i_vmaxmin : n331_o;
  /* ascal.vhd:1268:33  */
  assign n337_o = n321_o ? 1'b0 : n334_o;
  /* ascal.vhd:1288:46  */
  assign n338_o = {27'b0, i_de_delay};  //  uext
  /* ascal.vhd:1288:46  */
  assign n340_o = n338_o == 32'b00000000000000000000000000010000;
  /* ascal.vhd:1289:52  */
  assign n341_o = {19'b0, i_vacc};  //  uext
  /* ascal.vhd:1289:55  */
  assign n342_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1289:55  */
  assign n344_o = 32'b00000000000000000000000000000010 * n342_o; // smul
  /* ascal.vhd:1289:52  */
  assign n345_o = n341_o + n344_o;
  /* ascal.vhd:1289:69  */
  assign n346_o = {20'b0, i_vsize};  //  uext
  /* ascal.vhd:1289:69  */
  assign n348_o = 32'b00000000000000000000000000000010 * n346_o; // smul
  /* ascal.vhd:1289:66  */
  assign n349_o = $signed(n345_o) < $signed(n348_o);
  /* ascal.vhd:1290:65  */
  assign n350_o = {19'b0, i_vacc};  //  uext
  /* ascal.vhd:1290:68  */
  assign n351_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1290:68  */
  assign n353_o = 32'b00000000000000000000000000000010 * n351_o; // smul
  /* ascal.vhd:1290:65  */
  assign n354_o = n350_o + n353_o;
  assign n355_o = n354_o[12:0];
  /* ascal.vhd:1293:65  */
  assign n357_o = {19'b0, i_vacc};  //  uext
  /* ascal.vhd:1293:68  */
  assign n358_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1293:68  */
  assign n360_o = 32'b00000000000000000000000000000010 * n358_o; // smul
  /* ascal.vhd:1293:65  */
  assign n361_o = n357_o + n360_o;
  /* ascal.vhd:1293:81  */
  assign n362_o = {20'b0, i_vsize};  //  uext
  /* ascal.vhd:1293:81  */
  assign n364_o = 32'b00000000000000000000000000000010 * n362_o; // smul
  /* ascal.vhd:1293:78  */
  assign n365_o = n361_o - n364_o;
  /* ascal.vhd:1293:90  */
  assign n367_o = n365_o + 32'b00000000000000000010000000000000;
  assign n368_o = n367_o[12:0];
  /* ascal.vhd:1289:41  */
  assign n372_o = n349_o ? 1'b0 : 1'b1;
  /* ascal.vhd:1289:41  */
  assign n373_o = n349_o ? n355_o : n368_o;
  /* ascal.vhd:1298:50  */
  assign n374_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1298:50  */
  assign n375_o = {20'b0, i_vmin};  //  uext
  /* ascal.vhd:1298:50  */
  assign n376_o = n374_o == n375_o;
  /* ascal.vhd:1299:59  */
  assign n377_o = {20'b0, i_vsize};  //  uext
  /* ascal.vhd:1299:59  */
  assign n378_o = {20'b0, i_ovsize};  //  uext
  /* ascal.vhd:1299:59  */
  assign n379_o = n377_o - n378_o;
  /* ascal.vhd:1299:70  */
  assign n381_o = n379_o + 32'b00000000000000000010000000000000;
  assign n382_o = n381_o[12:0];
  /* ascal.vhd:1298:41  */
  assign n385_o = n376_o ? 1'b1 : n372_o;
  /* ascal.vhd:1298:41  */
  assign n386_o = n376_o ? n382_o : n373_o;
  /* ascal.vhd:1288:33  */
  assign n389_o = n340_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1288:33  */
  assign n391_o = n340_o ? n385_o : i_vnp;
  /* ascal.vhd:1304:43  */
  assign n393_o = ~i_vdown;
  /* ascal.vhd:1304:33  */
  assign n395_o = n393_o ? 1'b1 : n391_o;
  /* ascal.vhd:1310:51  */
  assign n396_o = {19'b0, i_hacc};  //  uext
  /* ascal.vhd:1310:54  */
  assign n397_o = {20'b0, i_ohsize};  //  uext
  /* ascal.vhd:1310:54  */
  assign n399_o = 32'b00000000000000000000000000000010 * n397_o; // smul
  /* ascal.vhd:1310:51  */
  assign n400_o = n396_o + n399_o;
  /* ascal.vhd:1310:67  */
  assign n401_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1310:67  */
  assign n403_o = 32'b00000000000000000000000000000010 * n401_o; // smul
  /* ascal.vhd:1310:64  */
  assign n404_o = $signed(n400_o) < $signed(n403_o);
  /* ascal.vhd:1311:65  */
  assign n405_o = {19'b0, i_hacc};  //  uext
  /* ascal.vhd:1311:68  */
  assign n406_o = {20'b0, i_ohsize};  //  uext
  /* ascal.vhd:1311:68  */
  assign n408_o = 32'b00000000000000000000000000000010 * n406_o; // smul
  /* ascal.vhd:1311:65  */
  assign n409_o = n405_o + n408_o;
  assign n410_o = n409_o[12:0];
  /* ascal.vhd:1314:65  */
  assign n412_o = {19'b0, i_hacc};  //  uext
  /* ascal.vhd:1314:68  */
  assign n413_o = {20'b0, i_ohsize};  //  uext
  /* ascal.vhd:1314:68  */
  assign n415_o = 32'b00000000000000000000000000000010 * n413_o; // smul
  /* ascal.vhd:1314:65  */
  assign n416_o = n412_o + n415_o;
  /* ascal.vhd:1314:81  */
  assign n417_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1314:81  */
  assign n419_o = 32'b00000000000000000000000000000010 * n417_o; // smul
  /* ascal.vhd:1314:78  */
  assign n420_o = n416_o - n419_o;
  /* ascal.vhd:1314:90  */
  assign n422_o = n420_o + 32'b00000000000000000010000000000000;
  assign n423_o = n422_o[12:0];
  /* ascal.vhd:1310:41  */
  assign n427_o = n404_o ? 1'b0 : 1'b1;
  /* ascal.vhd:1310:41  */
  assign n428_o = n404_o ? n410_o : n423_o;
  /* ascal.vhd:1309:33  */
  assign n429_o = i_ven ? n427_o : i_hnp;
  /* ascal.vhd:1309:33  */
  assign n430_o = i_ven ? n428_o : i_hacc;
  /* ascal.vhd:1318:43  */
  assign n431_o = ~i_hdown;
  /* ascal.vhd:1318:33  */
  assign n433_o = n431_o ? 1'b1 : n429_o;
  /* ascal.vhd:1337:59  */
  assign n434_o = {19'b0, i_hacc};  //  uext
  /* ascal.vhd:1337:59  */
  assign n436_o = n434_o * 32'b00000000000000000000000000010000; // smul
  /* ascal.vhd:1337:52  */
  assign n437_o = n436_o[30:0];  // trunc
  /* ascal.vhd:1337:40  */
  assign n438_o = n437_o[16:0];  // trunc
  /* ascal.vhd:1339:65  */
  assign n439_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1339:65  */
  assign n441_o = n439_o * 32'b00000000000000000000000000010000; // smul
  /* ascal.vhd:1339:58  */
  assign n442_o = n441_o[30:0];  // trunc
  /* ascal.vhd:1339:46  */
  assign n443_o = n442_o[16:0];  // trunc
  /* ascal.vhd:1339:45  */
  assign n444_o = n438_o - n443_o;
  /* ascal.vhd:1340:53  */
  assign n445_o = n444_o[16];
  /* ascal.vhd:1340:44  */
  assign n446_o = ~n445_o;
  /* ascal.vhd:1341:41  */
  assign n449_o = n444_o[16];
  /* ascal.vhd:1341:45  */
  assign n450_o = ~n449_o;
  /* ascal.vhd:1342:73  */
  assign n451_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1342:73  */
  assign n453_o = n451_o * 32'b00000000000000000000000000001000; // smul
  /* ascal.vhd:1342:66  */
  assign n454_o = n453_o[30:0];  // trunc
  /* ascal.vhd:1342:54  */
  assign n455_o = n454_o[16:0];  // trunc
  /* ascal.vhd:1342:53  */
  assign n456_o = n444_o - n455_o;
  /* ascal.vhd:1344:73  */
  assign n457_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1344:73  */
  assign n459_o = n457_o * 32'b00000000000000000000000000001000; // smul
  /* ascal.vhd:1344:66  */
  assign n460_o = n459_o[30:0];  // trunc
  /* ascal.vhd:1344:54  */
  assign n461_o = n460_o[16:0];  // trunc
  /* ascal.vhd:1344:53  */
  assign n462_o = n444_o + n461_o;
  /* ascal.vhd:1341:33  */
  assign n463_o = n450_o ? n456_o : n462_o;
  /* ascal.vhd:1346:53  */
  assign n464_o = n463_o[16];
  /* ascal.vhd:1346:44  */
  assign n465_o = ~n464_o;
  assign n466_o = n447_o[9:0];
  assign n467_o = {n446_o, n465_o, n466_o};
  /* ascal.vhd:1353:41  */
  assign n468_o = i_div[16];
  /* ascal.vhd:1353:45  */
  assign n469_o = ~n468_o;
  /* ascal.vhd:1354:73  */
  assign n470_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1354:73  */
  assign n472_o = n470_o * 32'b00000000000000000000000000000100; // smul
  /* ascal.vhd:1354:66  */
  assign n473_o = n472_o[30:0];  // trunc
  /* ascal.vhd:1354:54  */
  assign n474_o = n473_o[16:0];  // trunc
  /* ascal.vhd:1354:53  */
  assign n475_o = i_div - n474_o;
  /* ascal.vhd:1356:73  */
  assign n476_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1356:73  */
  assign n478_o = n476_o * 32'b00000000000000000000000000000100; // smul
  /* ascal.vhd:1356:66  */
  assign n479_o = n478_o[30:0];  // trunc
  /* ascal.vhd:1356:54  */
  assign n480_o = n479_o[16:0];  // trunc
  /* ascal.vhd:1356:53  */
  assign n481_o = i_div + n480_o;
  /* ascal.vhd:1353:33  */
  assign n482_o = n469_o ? n475_o : n481_o;
  /* ascal.vhd:1358:52  */
  assign n483_o = n482_o[16];
  /* ascal.vhd:1358:43  */
  assign n484_o = ~n483_o;
  assign n485_o = i_dir[11:10];
  /* ascal.vhd:1360:41  */
  assign n487_o = n482_o[16];
  /* ascal.vhd:1360:45  */
  assign n488_o = ~n487_o;
  /* ascal.vhd:1361:73  */
  assign n489_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1361:73  */
  assign n491_o = n489_o * 32'b00000000000000000000000000000010; // smul
  /* ascal.vhd:1361:66  */
  assign n492_o = n491_o[30:0];  // trunc
  /* ascal.vhd:1361:54  */
  assign n493_o = n492_o[16:0];  // trunc
  /* ascal.vhd:1361:53  */
  assign n494_o = n482_o - n493_o;
  /* ascal.vhd:1363:73  */
  assign n495_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1363:73  */
  assign n497_o = n495_o * 32'b00000000000000000000000000000010; // smul
  /* ascal.vhd:1363:66  */
  assign n498_o = n497_o[30:0];  // trunc
  /* ascal.vhd:1363:54  */
  assign n499_o = n498_o[16:0];  // trunc
  /* ascal.vhd:1363:53  */
  assign n500_o = n482_o + n499_o;
  /* ascal.vhd:1360:33  */
  assign n501_o = n488_o ? n494_o : n500_o;
  /* ascal.vhd:1365:52  */
  assign n502_o = n501_o[16];
  /* ascal.vhd:1365:43  */
  assign n503_o = ~n502_o;
  assign n504_o = i_dir[7:0];
  assign n505_o = {n485_o, n484_o, n503_o, n504_o};
  /* ascal.vhd:1369:41  */
  assign n506_o = ~i_bil;
  /* ascal.vhd:729:31  */
  assign n513_o = i_h_frac[11];
  /* ascal.vhd:729:31  */
  assign n514_o = i_h_frac[11];
  /* ascal.vhd:729:31  */
  assign n515_o = i_h_frac[11];
  /* ascal.vhd:729:31  */
  assign n516_o = i_h_frac[11];
  assign n517_o = {n513_o, n514_o, n515_o, n516_o};
  assign n520_o = {i_hpix2, i_hpix2, i_hpix3, i_hpix3};
  /* ascal.vhd:773:21  */
  assign n529_o = n517_o[3];
  /* ascal.vhd:773:29  */
  assign n530_o = ~n529_o;
  /* ascal.vhd:774:39  */
  assign n531_o = n520_o[71:48];
  /* ascal.vhd:774:43  */
  assign n532_o = n531_o[7:0];
  /* ascal.vhd:774:36  */
  assign n534_o = {1'b0, n532_o};
  /* ascal.vhd:774:45  */
  assign n536_o = {n534_o, 4'b0000};
  /* ascal.vhd:775:39  */
  assign n537_o = n520_o[71:48];
  /* ascal.vhd:775:43  */
  assign n538_o = n537_o[15:8];
  /* ascal.vhd:775:36  */
  assign n540_o = {1'b0, n538_o};
  /* ascal.vhd:775:45  */
  assign n542_o = {n540_o, 4'b0000};
  /* ascal.vhd:776:39  */
  assign n543_o = n520_o[71:48];
  /* ascal.vhd:776:43  */
  assign n544_o = n543_o[23:16];
  /* ascal.vhd:776:36  */
  assign n546_o = {1'b0, n544_o};
  /* ascal.vhd:776:45  */
  assign n548_o = {n546_o, 4'b0000};
  /* ascal.vhd:778:39  */
  assign n549_o = n520_o[47:24];
  /* ascal.vhd:778:43  */
  assign n550_o = n549_o[7:0];
  /* ascal.vhd:778:36  */
  assign n552_o = {1'b0, n550_o};
  /* ascal.vhd:778:45  */
  assign n554_o = {n552_o, 4'b0000};
  /* ascal.vhd:779:39  */
  assign n555_o = n520_o[47:24];
  /* ascal.vhd:779:43  */
  assign n556_o = n555_o[15:8];
  /* ascal.vhd:779:36  */
  assign n558_o = {1'b0, n556_o};
  /* ascal.vhd:779:45  */
  assign n560_o = {n558_o, 4'b0000};
  /* ascal.vhd:780:39  */
  assign n561_o = n520_o[47:24];
  /* ascal.vhd:780:43  */
  assign n562_o = n561_o[23:16];
  /* ascal.vhd:780:36  */
  assign n564_o = {1'b0, n562_o};
  /* ascal.vhd:780:45  */
  assign n566_o = {n564_o, 4'b0000};
  assign n567_o = {n566_o, n560_o, n554_o};
  assign n568_o = {n548_o, n542_o, n536_o};
  /* ascal.vhd:773:17  */
  assign n569_o = n530_o ? n568_o : n567_o;
  /* ascal.vhd:741:25  */
  assign n576_o = i_h_frac[11:8];
  assign n578_o = {i_hpix2, i_hpix2, i_hpix3, i_hpix3};
  /* ascal.vhd:755:26  */
  assign n588_o = {1'b0, n576_o};
  /* ascal.vhd:755:39  */
  assign n589_o = n576_o[3];
  /* ascal.vhd:755:36  */
  assign n591_o = {4'b0000, n589_o};
  /* ascal.vhd:755:31  */
  assign n592_o = n588_o + n591_o;
  /* ascal.vhd:756:31  */
  assign n595_o = 5'b10000 - n592_o;
  /* ascal.vhd:757:21  */
  assign n597_o = n578_o[47:24];
  /* ascal.vhd:757:25  */
  assign n598_o = n597_o[7:0];
  /* ascal.vhd:757:27  */
  assign n599_o = {5'b0, n598_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n600_o = {8'b0, n592_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n601_o = n599_o * n600_o; // smul
  /* ascal.vhd:757:35  */
  assign n602_o = n578_o[71:48];
  /* ascal.vhd:757:39  */
  assign n603_o = n602_o[7:0];
  /* ascal.vhd:757:41  */
  assign n604_o = {5'b0, n603_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n605_o = {8'b0, n595_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n606_o = n604_o * n605_o; // smul
  /* ascal.vhd:757:32  */
  assign n607_o = n601_o + n606_o;
  /* ascal.vhd:759:21  */
  assign n611_o = n578_o[47:24];
  /* ascal.vhd:759:25  */
  assign n612_o = n611_o[15:8];
  /* ascal.vhd:759:27  */
  assign n613_o = {5'b0, n612_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n614_o = {8'b0, n592_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n615_o = n613_o * n614_o; // smul
  /* ascal.vhd:759:35  */
  assign n616_o = n578_o[71:48];
  /* ascal.vhd:759:39  */
  assign n617_o = n616_o[15:8];
  /* ascal.vhd:759:41  */
  assign n618_o = {5'b0, n617_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n619_o = {8'b0, n595_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n620_o = n618_o * n619_o; // smul
  /* ascal.vhd:759:32  */
  assign n621_o = n615_o + n620_o;
  /* ascal.vhd:761:21  */
  assign n623_o = n578_o[47:24];
  /* ascal.vhd:761:25  */
  assign n624_o = n623_o[23:16];
  /* ascal.vhd:761:27  */
  assign n625_o = {5'b0, n624_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n626_o = {8'b0, n592_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n627_o = n625_o * n626_o; // smul
  /* ascal.vhd:761:35  */
  assign n628_o = n578_o[71:48];
  /* ascal.vhd:761:39  */
  assign n629_o = n628_o[23:16];
  /* ascal.vhd:761:41  */
  assign n630_o = {5'b0, n629_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n631_o = {8'b0, n595_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n632_o = n630_o * n631_o; // smul
  /* ascal.vhd:761:32  */
  assign n633_o = n627_o + n632_o;
  assign n634_o = {n633_o, n621_o, n607_o};
  /* ascal.vhd:1369:33  */
  assign n635_o = n506_o ? n569_o : n634_o;
  /* ascal.vhd:1377:59  */
  assign n638_o = i_h_bil_t[12:0];
  /* ascal.vhd:715:21  */
  assign n643_o = n638_o[12];
  /* ascal.vhd:717:24  */
  assign n645_o = n638_o[12];
  /* ascal.vhd:717:41  */
  assign n647_o = n645_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n649_o = n638_o[11:4];
  /* ascal.vhd:717:17  */
  assign n650_o = n647_o ? 8'b11111111 : n649_o;
  /* ascal.vhd:715:17  */
  assign n651_o = n643_o ? 8'b00000000 : n650_o;
  /* ascal.vhd:1378:59  */
  assign n653_o = i_h_bil_t[25:13];
  /* ascal.vhd:715:21  */
  assign n658_o = n653_o[12];
  /* ascal.vhd:717:24  */
  assign n660_o = n653_o[12];
  /* ascal.vhd:717:41  */
  assign n662_o = n660_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n664_o = n653_o[11:4];
  /* ascal.vhd:717:17  */
  assign n665_o = n662_o ? 8'b11111111 : n664_o;
  /* ascal.vhd:715:17  */
  assign n666_o = n658_o ? 8'b00000000 : n665_o;
  /* ascal.vhd:1379:59  */
  assign n668_o = i_h_bil_t[38:26];
  /* ascal.vhd:715:21  */
  assign n673_o = n668_o[12];
  /* ascal.vhd:717:24  */
  assign n675_o = n668_o[12];
  /* ascal.vhd:717:41  */
  assign n677_o = n675_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n679_o = n668_o[11:4];
  /* ascal.vhd:717:17  */
  assign n680_o = n677_o ? 8'b11111111 : n679_o;
  /* ascal.vhd:715:17  */
  assign n681_o = n673_o ? 8'b00000000 : n680_o;
  /* ascal.vhd:1381:43  */
  assign n682_o = ~i_hdown;
  assign n683_o = {n681_o, n666_o, n651_o};
  /* ascal.vhd:1381:33  */
  assign n684_o = n682_o ? i_hpix4 : n683_o;
  /* ascal.vhd:1386:41  */
  assign n685_o = ~i_bil;
  /* ascal.vhd:729:31  */
  assign n692_o = i_v_frac[11];
  /* ascal.vhd:729:31  */
  assign n693_o = i_v_frac[11];
  /* ascal.vhd:729:31  */
  assign n694_o = i_v_frac[11];
  /* ascal.vhd:729:31  */
  assign n695_o = i_v_frac[11];
  assign n696_o = {n692_o, n693_o, n694_o, n695_o};
  assign n699_o = {i_hpix, i_hpix, i_ldrm, i_ldrm};
  /* ascal.vhd:773:21  */
  assign n708_o = n696_o[3];
  /* ascal.vhd:773:29  */
  assign n709_o = ~n708_o;
  /* ascal.vhd:774:39  */
  assign n710_o = n699_o[71:48];
  /* ascal.vhd:774:43  */
  assign n711_o = n710_o[7:0];
  /* ascal.vhd:774:36  */
  assign n713_o = {1'b0, n711_o};
  /* ascal.vhd:774:45  */
  assign n715_o = {n713_o, 4'b0000};
  /* ascal.vhd:775:39  */
  assign n716_o = n699_o[71:48];
  /* ascal.vhd:775:43  */
  assign n717_o = n716_o[15:8];
  /* ascal.vhd:775:36  */
  assign n719_o = {1'b0, n717_o};
  /* ascal.vhd:775:45  */
  assign n721_o = {n719_o, 4'b0000};
  /* ascal.vhd:776:39  */
  assign n722_o = n699_o[71:48];
  /* ascal.vhd:776:43  */
  assign n723_o = n722_o[23:16];
  /* ascal.vhd:776:36  */
  assign n725_o = {1'b0, n723_o};
  /* ascal.vhd:776:45  */
  assign n727_o = {n725_o, 4'b0000};
  /* ascal.vhd:778:39  */
  assign n728_o = n699_o[47:24];
  /* ascal.vhd:778:43  */
  assign n729_o = n728_o[7:0];
  /* ascal.vhd:778:36  */
  assign n731_o = {1'b0, n729_o};
  /* ascal.vhd:778:45  */
  assign n733_o = {n731_o, 4'b0000};
  /* ascal.vhd:779:39  */
  assign n734_o = n699_o[47:24];
  /* ascal.vhd:779:43  */
  assign n735_o = n734_o[15:8];
  /* ascal.vhd:779:36  */
  assign n737_o = {1'b0, n735_o};
  /* ascal.vhd:779:45  */
  assign n739_o = {n737_o, 4'b0000};
  /* ascal.vhd:780:39  */
  assign n740_o = n699_o[47:24];
  /* ascal.vhd:780:43  */
  assign n741_o = n740_o[23:16];
  /* ascal.vhd:780:36  */
  assign n743_o = {1'b0, n741_o};
  /* ascal.vhd:780:45  */
  assign n745_o = {n743_o, 4'b0000};
  assign n746_o = {n745_o, n739_o, n733_o};
  assign n747_o = {n727_o, n721_o, n715_o};
  /* ascal.vhd:773:17  */
  assign n748_o = n709_o ? n747_o : n746_o;
  /* ascal.vhd:741:25  */
  assign n755_o = i_v_frac[11:8];
  assign n757_o = {i_hpix, i_hpix, i_ldrm, i_ldrm};
  /* ascal.vhd:755:26  */
  assign n767_o = {1'b0, n755_o};
  /* ascal.vhd:755:39  */
  assign n768_o = n755_o[3];
  /* ascal.vhd:755:36  */
  assign n770_o = {4'b0000, n768_o};
  /* ascal.vhd:755:31  */
  assign n771_o = n767_o + n770_o;
  /* ascal.vhd:756:31  */
  assign n774_o = 5'b10000 - n771_o;
  /* ascal.vhd:757:21  */
  assign n776_o = n757_o[47:24];
  /* ascal.vhd:757:25  */
  assign n777_o = n776_o[7:0];
  /* ascal.vhd:757:27  */
  assign n778_o = {5'b0, n777_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n779_o = {8'b0, n771_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n780_o = n778_o * n779_o; // smul
  /* ascal.vhd:757:35  */
  assign n781_o = n757_o[71:48];
  /* ascal.vhd:757:39  */
  assign n782_o = n781_o[7:0];
  /* ascal.vhd:757:41  */
  assign n783_o = {5'b0, n782_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n784_o = {8'b0, n774_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n785_o = n783_o * n784_o; // smul
  /* ascal.vhd:757:32  */
  assign n786_o = n780_o + n785_o;
  /* ascal.vhd:759:21  */
  assign n790_o = n757_o[47:24];
  /* ascal.vhd:759:25  */
  assign n791_o = n790_o[15:8];
  /* ascal.vhd:759:27  */
  assign n792_o = {5'b0, n791_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n793_o = {8'b0, n771_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n794_o = n792_o * n793_o; // smul
  /* ascal.vhd:759:35  */
  assign n795_o = n757_o[71:48];
  /* ascal.vhd:759:39  */
  assign n796_o = n795_o[15:8];
  /* ascal.vhd:759:41  */
  assign n797_o = {5'b0, n796_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n798_o = {8'b0, n774_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n799_o = n797_o * n798_o; // smul
  /* ascal.vhd:759:32  */
  assign n800_o = n794_o + n799_o;
  /* ascal.vhd:761:21  */
  assign n802_o = n757_o[47:24];
  /* ascal.vhd:761:25  */
  assign n803_o = n802_o[23:16];
  /* ascal.vhd:761:27  */
  assign n804_o = {5'b0, n803_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n805_o = {8'b0, n771_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n806_o = n804_o * n805_o; // smul
  /* ascal.vhd:761:35  */
  assign n807_o = n757_o[71:48];
  /* ascal.vhd:761:39  */
  assign n808_o = n807_o[23:16];
  /* ascal.vhd:761:41  */
  assign n809_o = {5'b0, n808_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n810_o = {8'b0, n774_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n811_o = n809_o * n810_o; // smul
  /* ascal.vhd:761:32  */
  assign n812_o = n806_o + n811_o;
  assign n813_o = {n812_o, n800_o, n786_o};
  /* ascal.vhd:1386:33  */
  assign n815_o = n685_o ? n748_o : n813_o;
  /* ascal.vhd:1394:56  */
  assign n817_o = n815_o[12:0];
  /* ascal.vhd:715:21  */
  assign n822_o = n817_o[12];
  /* ascal.vhd:717:24  */
  assign n824_o = n817_o[12];
  /* ascal.vhd:717:41  */
  assign n826_o = n824_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n828_o = n817_o[11:4];
  /* ascal.vhd:717:17  */
  assign n829_o = n826_o ? 8'b11111111 : n828_o;
  /* ascal.vhd:715:17  */
  assign n830_o = n822_o ? 8'b00000000 : n829_o;
  /* ascal.vhd:1395:56  */
  assign n832_o = n815_o[25:13];
  /* ascal.vhd:715:21  */
  assign n837_o = n832_o[12];
  /* ascal.vhd:717:24  */
  assign n839_o = n832_o[12];
  /* ascal.vhd:717:41  */
  assign n841_o = n839_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n843_o = n832_o[11:4];
  /* ascal.vhd:717:17  */
  assign n844_o = n841_o ? 8'b11111111 : n843_o;
  /* ascal.vhd:715:17  */
  assign n845_o = n837_o ? 8'b00000000 : n844_o;
  /* ascal.vhd:1396:56  */
  assign n847_o = n815_o[38:26];
  /* ascal.vhd:715:21  */
  assign n852_o = n847_o[12];
  /* ascal.vhd:717:24  */
  assign n854_o = n847_o[12];
  /* ascal.vhd:717:41  */
  assign n856_o = n854_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n858_o = n847_o[11:4];
  /* ascal.vhd:717:17  */
  assign n859_o = n856_o ? 8'b11111111 : n858_o;
  /* ascal.vhd:715:17  */
  assign n860_o = n852_o ? 8'b00000000 : n859_o;
  /* ascal.vhd:1398:43  */
  assign n861_o = ~i_vdown;
  assign n862_o = {n860_o, n845_o, n830_o};
  /* ascal.vhd:1398:33  */
  assign n863_o = n861_o ? i_hpix : n862_o;
  /* ascal.vhd:1407:48  */
  assign n864_o = i_hnp4 & i_ven6;
  /* ascal.vhd:1407:64  */
  assign n865_o = n864_o | i_pushend;
  /* ascal.vhd:521:45  */
  assign n871_o = i_shift[95:0];
  /* ascal.vhd:521:63  */
  assign n872_o = i_pix[7:0];
  /* ascal.vhd:521:57  */
  assign n873_o = {n871_o, n872_o};
  /* ascal.vhd:521:71  */
  assign n874_o = i_pix[15:8];
  /* ascal.vhd:521:65  */
  assign n875_o = {n873_o, n874_o};
  /* ascal.vhd:521:79  */
  assign n876_o = i_pix[23:16];
  /* ascal.vhd:521:73  */
  assign n877_o = {n875_o, n876_o};
  /* ascal.vhd:520:25  */
  assign n879_o = i_format == 2'b01;
  /* ascal.vhd:523:45  */
  assign n880_o = i_shift[87:0];
  /* ascal.vhd:523:63  */
  assign n881_o = i_pix[7:0];
  /* ascal.vhd:523:57  */
  assign n882_o = {n880_o, n881_o};
  /* ascal.vhd:523:71  */
  assign n883_o = i_pix[15:8];
  /* ascal.vhd:523:65  */
  assign n884_o = {n882_o, n883_o};
  /* ascal.vhd:523:79  */
  assign n885_o = i_pix[23:16];
  /* ascal.vhd:523:73  */
  assign n886_o = {n884_o, n885_o};
  /* ascal.vhd:523:81  */
  assign n888_o = {n886_o, 8'b00000000};
  /* ascal.vhd:522:25  */
  assign n890_o = i_format == 2'b10;
  /* ascal.vhd:525:45  */
  assign n891_o = i_shift[103:0];
  /* ascal.vhd:526:46  */
  assign n892_o = i_pix[12:10];
  /* ascal.vhd:525:57  */
  assign n893_o = {n891_o, n892_o};
  /* ascal.vhd:526:66  */
  assign n894_o = i_pix[7:3];
  /* ascal.vhd:526:59  */
  assign n895_o = {n893_o, n894_o};
  /* ascal.vhd:527:46  */
  assign n896_o = i_pix[23:19];
  /* ascal.vhd:526:79  */
  assign n897_o = {n895_o, n896_o};
  /* ascal.vhd:527:66  */
  assign n898_o = i_pix[15:13];
  /* ascal.vhd:527:59  */
  assign n899_o = {n897_o, n898_o};
  assign n900_o = {n890_o, n879_o};
  /* ascal.vhd:519:17  */
  always @*
    case (n900_o)
      2'b10: n901_o <= n888_o;
      2'b01: n901_o <= n877_o;
    endcase
  /* ascal.vhd:542:51  */
  assign n909_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:542:51  */
  assign n911_o = n909_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:542:86  */
  assign n912_o = i_pix[7:0];
  /* ascal.vhd:542:80  */
  assign n913_o = {i_shift, n912_o};
  /* ascal.vhd:543:51  */
  assign n914_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:543:51  */
  assign n916_o = n914_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:543:69  */
  assign n917_o = i_shift[111:0];
  /* ascal.vhd:543:86  */
  assign n918_o = i_pix[7:0];
  /* ascal.vhd:543:80  */
  assign n919_o = {n917_o, n918_o};
  /* ascal.vhd:543:94  */
  assign n920_o = i_pix[15:8];
  /* ascal.vhd:543:88  */
  assign n921_o = {n919_o, n920_o};
  /* ascal.vhd:544:51  */
  assign n922_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:544:51  */
  assign n924_o = n922_o == 32'b00000000000000000000000000001111;
  /* ascal.vhd:544:69  */
  assign n925_o = i_shift[103:0];
  /* ascal.vhd:544:87  */
  assign n926_o = i_pix[7:0];
  /* ascal.vhd:544:81  */
  assign n927_o = {n925_o, n926_o};
  /* ascal.vhd:544:95  */
  assign n928_o = i_pix[15:8];
  /* ascal.vhd:544:89  */
  assign n929_o = {n927_o, n928_o};
  /* ascal.vhd:544:103  */
  assign n930_o = i_pix[23:16];
  /* ascal.vhd:544:97  */
  assign n931_o = {n929_o, n930_o};
  /* ascal.vhd:544:41  */
  assign n932_o = n924_o ? n931_o : i_dw;
  /* ascal.vhd:543:41  */
  assign n933_o = n916_o ? n921_o : n932_o;
  /* ascal.vhd:542:41  */
  assign n934_o = n911_o ? n913_o : n933_o;
  /* ascal.vhd:540:25  */
  assign n936_o = i_format == 2'b01;
  /* ascal.vhd:553:56  */
  assign n937_o = {28'b0, i_acpt};  //  uext
  assign n938_o = n937_o[1:0];
  /* ascal.vhd:553:56  */
  assign n939_o = {30'b0, n938_o};  //  uext
  /* ascal.vhd:553:62  */
  assign n941_o = n939_o == 32'b00000000000000000000000000000011;
  /* ascal.vhd:553:46  */
  assign n943_o = 1'b1 & n941_o;
  /* ascal.vhd:553:66  */
  assign n945_o = n943_o | 1'b0;
  /* ascal.vhd:554:50  */
  assign n946_o = i_shift[95:0];
  /* ascal.vhd:554:77  */
  assign n947_o = i_pix[7:0];
  /* ascal.vhd:554:71  */
  assign n948_o = {n946_o, n947_o};
  /* ascal.vhd:554:85  */
  assign n949_o = i_pix[15:8];
  /* ascal.vhd:554:79  */
  assign n950_o = {n948_o, n949_o};
  /* ascal.vhd:554:93  */
  assign n951_o = i_pix[23:16];
  /* ascal.vhd:554:87  */
  assign n952_o = {n950_o, n951_o};
  /* ascal.vhd:554:95  */
  assign n954_o = {n952_o, 8'b00000000};
  /* ascal.vhd:553:33  */
  assign n955_o = n945_o ? n954_o : i_dw;
  /* ascal.vhd:552:25  */
  assign n957_o = i_format == 2'b10;
  /* ascal.vhd:557:56  */
  assign n958_o = {28'b0, i_acpt};  //  uext
  assign n959_o = n958_o[2:0];
  /* ascal.vhd:557:56  */
  assign n960_o = {29'b0, n959_o};  //  uext
  /* ascal.vhd:557:62  */
  assign n962_o = n960_o == 32'b00000000000000000000000000000111;
  /* ascal.vhd:557:46  */
  assign n964_o = 1'b1 & n962_o;
  /* ascal.vhd:557:66  */
  assign n966_o = n964_o | 1'b0;
  /* ascal.vhd:558:50  */
  assign n967_o = i_shift[111:0];
  /* ascal.vhd:558:77  */
  assign n968_o = i_pix[12:10];
  /* ascal.vhd:558:70  */
  assign n969_o = {n967_o, n968_o};
  /* ascal.vhd:558:97  */
  assign n970_o = i_pix[7:3];
  /* ascal.vhd:558:90  */
  assign n971_o = {n969_o, n970_o};
  /* ascal.vhd:559:63  */
  assign n972_o = i_pix[23:19];
  /* ascal.vhd:558:110  */
  assign n973_o = {n971_o, n972_o};
  /* ascal.vhd:559:83  */
  assign n974_o = i_pix[15:13];
  /* ascal.vhd:559:76  */
  assign n975_o = {n973_o, n974_o};
  /* ascal.vhd:557:33  */
  assign n976_o = n966_o ? n975_o : i_dw;
  assign n977_o = {n957_o, n936_o};
  /* ascal.vhd:539:17  */
  always @*
    case (n977_o)
      2'b10: n978_o <= n955_o;
      2'b01: n978_o <= n934_o;
    endcase
  /* ascal.vhd:570:59  */
  assign n984_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:570:59  */
  assign n986_o = n984_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:570:69  */
  assign n987_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:570:69  */
  assign n989_o = n987_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:570:62  */
  assign n990_o = n986_o | n989_o;
  /* ascal.vhd:570:80  */
  assign n991_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:570:80  */
  assign n993_o = n991_o == 32'b00000000000000000000000000001111;
  /* ascal.vhd:570:73  */
  assign n994_o = n990_o | n993_o;
  /* ascal.vhd:570:50  */
  assign n996_o = 1'b1 & n994_o;
  /* ascal.vhd:570:86  */
  assign n998_o = n996_o | 1'b0;
  /* ascal.vhd:569:25  */
  assign n1000_o = i_format == 2'b01;
  /* ascal.vhd:573:61  */
  assign n1001_o = {28'b0, i_acpt};  //  uext
  assign n1002_o = n1001_o[1:0];
  /* ascal.vhd:573:61  */
  assign n1003_o = {30'b0, n1002_o};  //  uext
  /* ascal.vhd:573:67  */
  assign n1005_o = n1003_o == 32'b00000000000000000000000000000011;
  /* ascal.vhd:573:50  */
  assign n1007_o = 1'b1 & n1005_o;
  /* ascal.vhd:573:72  */
  assign n1009_o = n1007_o | 1'b0;
  /* ascal.vhd:572:25  */
  assign n1011_o = i_format == 2'b10;
  /* ascal.vhd:576:61  */
  assign n1012_o = {28'b0, i_acpt};  //  uext
  assign n1013_o = n1012_o[2:0];
  /* ascal.vhd:576:61  */
  assign n1014_o = {29'b0, n1013_o};  //  uext
  /* ascal.vhd:576:67  */
  assign n1016_o = n1014_o == 32'b00000000000000000000000000000111;
  /* ascal.vhd:576:50  */
  assign n1018_o = 1'b1 & n1016_o;
  /* ascal.vhd:576:72  */
  assign n1020_o = n1018_o | 1'b0;
  assign n1021_o = {n1011_o, n1000_o};
  /* ascal.vhd:568:17  */
  always @*
    case (n1021_o)
      2'b10: n1022_o <= n1009_o;
      2'b01: n1022_o <= n998_o;
    endcase
  /* ascal.vhd:1411:73  */
  assign n1023_o = n1022_o & i_vnp;
  /* ascal.vhd:1411:41  */
  assign n1026_o = n1023_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1407:33  */
  assign n1028_o = n1036_o ? 1'b0 : i_pushend;
  /* ascal.vhd:1415:56  */
  assign n1029_o = {28'b0, i_acpt};  //  uext
  /* ascal.vhd:1415:56  */
  assign n1031_o = n1029_o + 32'b00000000000000000000000000000001;
  assign n1032_o = n1031_o[3:0];
  /* ascal.vhd:1407:33  */
  assign n1035_o = n865_o ? n1026_o : 1'b0;
  /* ascal.vhd:1407:33  */
  assign n1036_o = n865_o & n1023_o;
  /* ascal.vhd:1407:33  */
  assign n1038_o = n865_o ? n1032_o : i_acpt;
  /* ascal.vhd:1162:25  */
  assign n1039_o = n1143_o ? n978_o : i_dw;
  /* ascal.vhd:1418:57  */
  assign n1040_o = ~i_ven5;
  /* ascal.vhd:1418:47  */
  assign n1041_o = i_ven6 & n1040_o;
  /* ascal.vhd:1418:62  */
  assign n1042_o = n1041_o & i_vnp;
  /* ascal.vhd:1418:33  */
  assign n1044_o = n1042_o ? 1'b1 : n1028_o;
  /* ascal.vhd:1423:64  */
  assign n1045_o = ~i_pushend;
  /* ascal.vhd:1423:51  */
  assign n1046_o = i_pushend2 & n1045_o;
  /* ascal.vhd:1423:33  */
  assign n1049_o = n1046_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1427:41  */
  assign n1050_o = ~i_pde;
  /* ascal.vhd:1427:46  */
  assign n1051_o = n1050_o & i_de_pre;
  /* ascal.vhd:1429:49  */
  assign n1052_o = {27'b0, i_de_delay};  //  uext
  /* ascal.vhd:1429:49  */
  assign n1054_o = $signed(n1052_o) < $signed(32'b00000000000000000000000000010010);
  /* ascal.vhd:1430:63  */
  assign n1055_o = {27'b0, i_de_delay};  //  uext
  /* ascal.vhd:1430:63  */
  assign n1057_o = n1055_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1430:53  */
  assign n1058_o = n1057_o[4:0];  // trunc
  /* ascal.vhd:1429:33  */
  assign n1059_o = n1054_o ? n1058_o : i_de_delay;
  /* ascal.vhd:1427:33  */
  assign n1061_o = n1051_o ? 5'b00000 : n1059_o;
  /* ascal.vhd:1433:46  */
  assign n1062_o = {27'b0, i_de_delay};  //  uext
  /* ascal.vhd:1433:46  */
  assign n1064_o = n1062_o == 32'b00000000000000000000000000010000;
  /* ascal.vhd:1436:55  */
  assign n1065_o = {20'b0, i_vcpt};  //  uext
  /* ascal.vhd:1436:55  */
  assign n1067_o = n1065_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1436:49  */
  assign n1068_o = n1067_o[11:0];  // trunc
  /* ascal.vhd:1437:58  */
  assign n1069_o = {20'b0, i_hsize};  //  uext
  /* ascal.vhd:1437:58  */
  assign n1070_o = {20'b0, i_ohsize};  //  uext
  /* ascal.vhd:1437:58  */
  assign n1071_o = n1069_o - n1070_o;
  /* ascal.vhd:1437:69  */
  assign n1073_o = n1071_o + 32'b00000000000000000010000000000000;
  assign n1074_o = n1073_o[12:0];
  /* ascal.vhd:1433:33  */
  assign n1076_o = n1064_o ? n1068_o : n135_o;
  /* ascal.vhd:1162:25  */
  assign n1078_o = n1136_o ? 5'b00000 : i_hbcpt;
  /* ascal.vhd:1433:33  */
  assign n1079_o = n1064_o ? n1074_o : n430_o;
  /* ascal.vhd:1162:25  */
  assign n1081_o = n1156_o ? 11'b00000000000 : i_lwad;
  /* ascal.vhd:1162:25  */
  assign n1083_o = n1157_o ? 11'b00000000000 : i_lrad;
  /* ascal.vhd:1440:46  */
  assign n1084_o = {27'b0, i_de_delay};  //  uext
  /* ascal.vhd:1440:46  */
  assign n1086_o = n1084_o == 32'b00000000000000000000000000010001;
  /* ascal.vhd:1440:33  */
  assign n1088_o = n1086_o ? 4'b0000 : n1038_o;
  /* ascal.vhd:1162:25  */
  assign n1090_o = n1142_o ? 5'b11111 : i_wad;
  /* ascal.vhd:1445:41  */
  assign n1091_o = ~i_pvs;
  /* ascal.vhd:1445:46  */
  assign n1092_o = n1091_o & i_vs_pre;
  /* ascal.vhd:1445:33  */
  assign n1096_o = n1092_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1162:25  */
  assign n1098_o = i_pce & n223_o;
  /* ascal.vhd:1162:25  */
  assign n1103_o = i_pce & n196_o;
  /* ascal.vhd:1162:25  */
  assign n1104_o = i_pce & n186_o;
  /* ascal.vhd:1162:25  */
  assign n1122_o = i_pce & n111_o;
  /* ascal.vhd:1162:25  */
  assign n1123_o = i_pce & n113_o;
  /* ascal.vhd:1162:25  */
  assign n1125_o = i_pce ? n1035_o : 1'b0;
  /* ascal.vhd:1162:25  */
  assign n1130_o = i_pce ? n1049_o : 1'b0;
  /* ascal.vhd:1162:25  */
  assign n1133_o = i_pce ? n1096_o : 1'b0;
  /* ascal.vhd:1162:25  */
  assign n1136_o = i_pce & n1064_o;
  /* ascal.vhd:1162:25  */
  assign n1137_o = i_pce & n865_o;
  /* ascal.vhd:1162:25  */
  assign n1142_o = i_pce & n1086_o;
  /* ascal.vhd:1162:25  */
  assign n1143_o = i_pce & n865_o;
  /* ascal.vhd:1162:25  */
  assign n1144_o = i_pce & n113_o;
  /* ascal.vhd:1162:25  */
  assign n1153_o = i_pce & n340_o;
  /* ascal.vhd:1162:25  */
  assign n1156_o = i_pce & n1064_o;
  /* ascal.vhd:1162:25  */
  assign n1157_o = i_pce & n1064_o;
  /* ascal.vhd:1454:39  */
  assign n1183_o = i_hnp4 & i_ven5;
  /* ascal.vhd:1454:50  */
  assign n1184_o = n1183_o & i_pce;
  /* ascal.vhd:1456:48  */
  assign n1185_o = {21'b0, i_lwad};  //  uext
  /* ascal.vhd:1456:48  */
  assign n1187_o = n1185_o + 32'b00000000000000000000000000000001;
  assign n1188_o = n1187_o[10:0];
  /* ascal.vhd:1455:25  */
  assign n1190_o = i_lwr ? n1188_o : n1081_o;
  /* ascal.vhd:1460:39  */
  assign n1191_o = i_hnp3 & i_ven4;
  /* ascal.vhd:1460:54  */
  assign n1192_o = n1191_o & i_pce;
  /* ascal.vhd:1461:48  */
  assign n1193_o = {21'b0, i_lrad};  //  uext
  /* ascal.vhd:1461:48  */
  assign n1195_o = n1193_o + 32'b00000000000000000000000000000001;
  assign n1196_o = n1195_o[10:0];
  /* ascal.vhd:1460:25  */
  assign n1198_o = n1192_o ? n1196_o : n1083_o;
  /* ascal.vhd:1468:55  */
  assign n1199_o = ~i_freeze;
  /* ascal.vhd:1468:43  */
  assign n1200_o = i_pushhead & n1199_o;
  /* ascal.vhd:1470:49  */
  assign n1202_o = i_count + 3'b001;
  /* ascal.vhd:1475:49  */
  assign n1203_o = ~i_freeze;
  /* ascal.vhd:1468:25  */
  assign n1207_o = n1200_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1468:25  */
  assign n1210_o = n1200_o ? n1203_o : 1'b0;
  /* ascal.vhd:1468:25  */
  assign n1213_o = n1200_o ? 1'b0 : i_alt;
  /* ascal.vhd:1468:25  */
  assign n1215_o = n1200_o ? 5'b00000 : n1090_o;
  /* ascal.vhd:1468:25  */
  assign n1216_o = n1200_o ? i_head : n1039_o;
  /* ascal.vhd:1468:25  */
  assign n1218_o = n1200_o ? 32'b00000000000000000000000000000000 : i_adrs;
  /* ascal.vhd:1488:25  */
  assign n1222_o = i_pushhead3 ? 5'b01111 : n1215_o;
  /* ascal.vhd:1494:51  */
  assign n1223_o = ~i_freeze;
  /* ascal.vhd:1494:39  */
  assign n1224_o = i_push & n1223_o;
  /* ascal.vhd:1496:46  */
  assign n1225_o = {27'b0, i_wad};  //  uext
  /* ascal.vhd:1496:46  */
  assign n1227_o = n1225_o + 32'b00000000000000000000000000000001;
  assign n1228_o = n1227_o[4:0];
  /* ascal.vhd:1497:42  */
  assign n1230_o = {27'b0, i_wad};  //  uext
  /* ascal.vhd:1497:42  */
  assign n1232_o = n1230_o + 32'b00000000000000000000000000000001;
  assign n1233_o = n1232_o[3:0];
  /* ascal.vhd:1497:46  */
  assign n1234_o = {28'b0, n1233_o};  //  uext
  /* ascal.vhd:1497:54  */
  assign n1236_o = n1234_o == 32'b00000000000000000000000000001111;
  /* ascal.vhd:1497:73  */
  assign n1237_o = {27'b0, i_hbcpt};  //  uext
  /* ascal.vhd:1497:73  */
  assign n1238_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1497:73  */
  assign n1239_o = $signed(n1237_o) < $signed(n1238_o);
  /* ascal.vhd:1497:62  */
  assign n1240_o = n1236_o & n1239_o;
  /* ascal.vhd:1498:58  */
  assign n1241_o = {27'b0, i_hbcpt};  //  uext
  /* ascal.vhd:1498:58  */
  assign n1243_o = n1241_o + 32'b00000000000000000000000000000001;
  assign n1244_o = n1243_o[4:0];
  /* ascal.vhd:1499:49  */
  assign n1246_o = ~i_freeze;
  /* ascal.vhd:1500:67  */
  assign n1248_o = {27'b0, i_wad};  //  uext
  /* ascal.vhd:1500:67  */
  assign n1250_o = n1248_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1500:70  */
  assign n1252_o = n1250_o / 32'b00000000000000000000000000010000; // sdiv
  /* ascal.vhd:1500:76  */
  assign n1254_o = n1252_o != 32'b00000000000000000000000000000000;
  /* ascal.vhd:285:17  */
  assign n1261_o = n1254_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1502:57  */
  assign n1263_o = i_adrsi + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1494:25  */
  assign n1264_o = n1271_o ? n1246_o : n1210_o;
  /* ascal.vhd:1494:25  */
  assign n1265_o = n1272_o ? n1261_o : n1213_o;
  /* ascal.vhd:1494:25  */
  assign n1266_o = n1273_o ? n1244_o : n1078_o;
  /* ascal.vhd:1494:25  */
  assign n1267_o = n1275_o ? i_adrsi : n1218_o;
  /* ascal.vhd:1494:25  */
  assign n1268_o = n1276_o ? n1263_o : n139_o;
  /* ascal.vhd:1494:25  */
  assign n1270_o = n1224_o ? 1'b1 : n1207_o;
  /* ascal.vhd:1494:25  */
  assign n1271_o = n1224_o & n1240_o;
  /* ascal.vhd:1494:25  */
  assign n1272_o = n1224_o & n1240_o;
  /* ascal.vhd:1494:25  */
  assign n1273_o = n1224_o & n1240_o;
  /* ascal.vhd:1494:25  */
  assign n1274_o = n1224_o ? n1228_o : n1222_o;
  /* ascal.vhd:1494:25  */
  assign n1275_o = n1224_o & n1240_o;
  /* ascal.vhd:1494:25  */
  assign n1276_o = n1224_o & n1240_o;
  /* ascal.vhd:1507:50  */
  assign n1277_o = ~i_freeze;
  /* ascal.vhd:1507:38  */
  assign n1278_o = i_eol & n1277_o;
  /* ascal.vhd:1508:43  */
  assign n1279_o = {27'b0, i_wad};  //  uext
  assign n1280_o = n1279_o[3:0];
  /* ascal.vhd:1508:43  */
  assign n1281_o = {28'b0, n1280_o};  //  uext
  /* ascal.vhd:1508:52  */
  assign n1283_o = n1281_o != 32'b00000000000000000000000000001111;
  /* ascal.vhd:1508:72  */
  assign n1284_o = {27'b0, i_hbcpt};  //  uext
  /* ascal.vhd:1508:72  */
  assign n1285_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1508:72  */
  assign n1286_o = $signed(n1284_o) < $signed(n1285_o);
  /* ascal.vhd:1508:61  */
  assign n1287_o = n1283_o & n1286_o;
  /* ascal.vhd:1510:58  */
  assign n1288_o = {27'b0, i_hbcpt};  //  uext
  /* ascal.vhd:1510:58  */
  assign n1290_o = n1288_o + 32'b00000000000000000000000000000001;
  assign n1291_o = n1290_o[4:0];
  /* ascal.vhd:1511:49  */
  assign n1293_o = ~i_freeze;
  /* ascal.vhd:1512:67  */
  assign n1295_o = {27'b0, i_wad};  //  uext
  /* ascal.vhd:1512:67  */
  assign n1297_o = n1295_o / 32'b00000000000000000000000000010000; // sdiv
  /* ascal.vhd:1512:73  */
  assign n1299_o = n1297_o != 32'b00000000000000000000000000000000;
  /* ascal.vhd:285:17  */
  assign n1306_o = n1299_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1514:66  */
  assign n1307_o = ~i_half;
  /* ascal.vhd:1514:56  */
  assign n1308_o = i_inter & n1307_o;
  /* ascal.vhd:1516:88  */
  assign n1309_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1516:88  */
  assign n1311_o = n1309_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1516:76  */
  assign n1313_o = 32'b00000000000000000000000100000000 * n1311_o; // smul
  /* ascal.vhd:1516:66  */
  assign n1314_o = n1313_o[30:0];  // trunc
  /* ascal.vhd:1516:66  */
  assign n1315_o = {1'b0, n1314_o};  //  uext
  /* ascal.vhd:1516:66  */
  assign n1316_o = i_adrsi + n1315_o;
  /* ascal.vhd:1518:66  */
  assign n1318_o = i_adrsi + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1514:41  */
  assign n1319_o = n1308_o ? n1316_o : n1318_o;
  /* ascal.vhd:1521:66  */
  assign n1320_o = ~i_half;
  /* ascal.vhd:1521:56  */
  assign n1321_o = i_inter & n1320_o;
  /* ascal.vhd:1523:76  */
  assign n1322_o = {27'b0, i_hburst};  //  uext
  /* ascal.vhd:1523:76  */
  assign n1324_o = 32'b00000000000000000000000100000000 * n1322_o; // smul
  /* ascal.vhd:1523:66  */
  assign n1325_o = n1324_o[30:0];  // trunc
  /* ascal.vhd:1523:66  */
  assign n1326_o = {1'b0, n1325_o};  //  uext
  /* ascal.vhd:1523:66  */
  assign n1327_o = i_adrsi + n1326_o;
  /* ascal.vhd:1521:41  */
  assign n1328_o = n1321_o ? n1327_o : n1268_o;
  /* ascal.vhd:1507:25  */
  assign n1329_o = n1334_o ? n1293_o : n1264_o;
  /* ascal.vhd:1507:25  */
  assign n1330_o = n1335_o ? n1306_o : n1265_o;
  /* ascal.vhd:1507:25  */
  assign n1331_o = n1336_o ? n1291_o : n1266_o;
  /* ascal.vhd:1507:25  */
  assign n1332_o = n1337_o ? i_adrsi : n1267_o;
  /* ascal.vhd:1508:33  */
  assign n1333_o = n1287_o ? n1319_o : n1328_o;
  /* ascal.vhd:1507:25  */
  assign n1334_o = n1278_o & n1287_o;
  /* ascal.vhd:1507:25  */
  assign n1335_o = n1278_o & n1287_o;
  /* ascal.vhd:1507:25  */
  assign n1336_o = n1278_o & n1287_o;
  /* ascal.vhd:1507:25  */
  assign n1337_o = n1278_o & n1287_o;
  /* ascal.vhd:1507:25  */
  assign n1338_o = n1278_o ? n1333_o : n1268_o;
  /* ascal.vhd:1529:25  */
  assign n1342_o = i_wreq ? 1'b1 : i_wreq_mem;
  /* ascal.vhd:1535:55  */
  assign n1344_o = {29'b0, i_wdelay};  //  uext
  /* ascal.vhd:1535:55  */
  assign n1346_o = n1344_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:1535:43  */
  assign n1347_o = i_wreq_mem & n1346_o;
  /* ascal.vhd:1536:42  */
  assign n1348_o = ~i_write;
  /* ascal.vhd:1542:39  */
  assign n1349_o = {29'b0, i_wdelay};  //  uext
  /* ascal.vhd:1542:39  */
  assign n1351_o = $signed(n1349_o) < $signed(32'b00000000000000000000000000000101);
  /* ascal.vhd:1543:51  */
  assign n1352_o = {29'b0, i_wdelay};  //  uext
  /* ascal.vhd:1543:51  */
  assign n1354_o = n1352_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1543:43  */
  assign n1355_o = n1354_o[2:0];  // trunc
  /* ascal.vhd:1542:25  */
  assign n1356_o = n1351_o ? n1355_o : i_wdelay;
  /* ascal.vhd:1535:25  */
  assign n1361_o = n1347_o ? 1'b0 : n1342_o;
  /* ascal.vhd:1535:25  */
  assign n1363_o = n1347_o ? 3'b000 : n1356_o;
  assign n1420_o = {8'b00000001, n53_o, 16'b0000000100000000, n62_o, i_count, n60_o, i_vdown, i_hdown, i_flm, i_inter, n65_o, n68_o, n73_o, n76_o, n79_o};
  /* ascal.vhd:1118:9  */
  assign n1578_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1579_o = i_pce & n1578_o;
  /* ascal.vhd:1128:17  */
  assign n1580_o = n1579_o ? i_himax : n1581_q;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1581_q <= n1580_o;
  /* ascal.vhd:1118:9  */
  assign n1582_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1583_o = n1098_o & n1582_o;
  /* ascal.vhd:1128:17  */
  assign n1584_o = n1583_o ? i_vimax : n1585_q;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1585_q <= n1584_o;
  /* ascal.vhd:1118:9  */
  assign n1586_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1587_o = n1586_o ? i_vs : i_pvs;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1588_q <= n1587_o;
  /* ascal.vhd:1118:9  */
  assign n1589_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1590_o = n1589_o ? i_fl : i_pfl;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1591_q <= n1590_o;
  /* ascal.vhd:1118:9  */
  assign n1592_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1593_o = n1592_o ? i_de : i_pde;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1594_q <= n1593_o;
  /* ascal.vhd:1118:9  */
  assign n1595_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1596_o = n1595_o ? i_ce : i_pce;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1597_q <= n1596_o;
  /* ascal.vhd:1118:9  */
  assign n1598_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1599_o = n1598_o ? n80_o : i_ppix;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1600_q <= n1599_o;
  /* ascal.vhd:1118:9  */
  assign n1601_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1602_o = n1601_o ? freeze : i_freeze;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1603_q <= n1602_o;
  /* ascal.vhd:1118:9  */
  assign n1604_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1605_o = n1200_o & n1604_o;
  /* ascal.vhd:1128:17  */
  assign n1606_o = n1605_o ? n1202_o : i_count;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1607_q <= n1606_o;
  /* ascal.vhd:1118:9  */
  assign n1608_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1609_o = i_pce & n1608_o;
  /* ascal.vhd:1128:17  */
  assign n1610_o = n1609_o ? n310_o : i_hsize;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1611_q <= n1610_o;
  /* ascal.vhd:1118:9  */
  assign n1612_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1613_o = i_pce & n1612_o;
  /* ascal.vhd:1128:17  */
  assign n1614_o = n1613_o ? n213_o : i_hmin;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1615_q <= n1614_o;
  /* ascal.vhd:1118:9  */
  assign n1616_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1617_o = i_pce & n1616_o;
  /* ascal.vhd:1128:17  */
  assign n1618_o = n1617_o ? n214_o : i_hmax;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1619_q <= n1618_o;
  /* ascal.vhd:1118:9  */
  assign n1620_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1621_o = i_pce & n1620_o;
  /* ascal.vhd:1128:17  */
  assign n1622_o = n1621_o ? n193_o : i_hcpt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1623_q <= n1622_o;
  /* ascal.vhd:1118:9  */
  assign n1624_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1625_o = n1103_o & n1624_o;
  /* ascal.vhd:1128:17  */
  assign n1626_o = n1625_o ? i_hcpt : i_himax;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1627_q <= n1626_o;
  /* ascal.vhd:1118:9  */
  assign n1628_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1629_o = n1104_o & n1628_o;
  /* ascal.vhd:1128:17  */
  assign n1630_o = n1629_o ? i_vcpt : i_vimax;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1631_q <= n1630_o;
  /* ascal.vhd:1118:9  */
  assign n1632_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1633_o = i_pce & n1632_o;
  /* ascal.vhd:1128:17  */
  assign n1634_o = n1633_o ? n335_o : i_vsize;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1635_q <= n1634_o;
  /* ascal.vhd:1118:9  */
  assign n1636_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1637_o = i_pce & n1636_o;
  /* ascal.vhd:1128:17  */
  assign n1638_o = n1637_o ? n319_o : i_vmaxmin;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1639_q <= n1638_o;
  /* ascal.vhd:1118:9  */
  assign n1640_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1641_o = i_pce & n1640_o;
  /* ascal.vhd:1128:17  */
  assign n1642_o = n1641_o ? n216_o : i_vmin;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1643_q <= n1642_o;
  /* ascal.vhd:1118:9  */
  assign n1644_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1645_o = i_pce & n1644_o;
  /* ascal.vhd:1128:17  */
  assign n1646_o = n1645_o ? n217_o : i_vmax;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1647_q <= n1646_o;
  /* ascal.vhd:1118:9  */
  assign n1648_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1649_o = i_pce & n1648_o;
  /* ascal.vhd:1128:17  */
  assign n1650_o = n1649_o ? n1076_o : i_vcpt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1651_q <= n1650_o;
  /* ascal.vhd:1118:9  */
  assign n1652_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1653_o = n1652_o ? iauto : i_iauto;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1654_q <= n1653_o;
  /* ascal.vhd:1118:9  */
  assign n1655_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1656_o = i_pce & n1655_o;
  /* ascal.vhd:1128:17  */
  assign n1657_o = n1656_o ? mode : i_mode;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1658_q <= n1657_o;
  /* ascal.vhd:1118:9  */
  assign n1659_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1660_o = i_pce & n1659_o;
  /* ascal.vhd:1128:17  */
  assign n1661_o = n1660_o ? format : i_format;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1662_q <= n1661_o;
  /* ascal.vhd:1118:9  */
  assign n1663_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1664_o = i_pce & n1663_o;
  /* ascal.vhd:1128:17  */
  assign n1665_o = n1664_o ? n162_o : i_ven;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1666_q <= n1665_o;
  /* ascal.vhd:1118:9  */
  assign n1667_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1668_o = i_pce & n1667_o;
  /* ascal.vhd:1128:17  */
  assign n1669_o = n1668_o ? n137_o : i_sof;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1670_q <= n1669_o;
  /* ascal.vhd:1118:9  */
  assign n1671_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1672_o = n1671_o ? n1270_o : i_wr;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1673_q <= n1672_o;
  /* ascal.vhd:1118:9  */
  assign n1674_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1675_o = i_pce & n1674_o;
  /* ascal.vhd:1128:17  */
  assign n1676_o = n1675_o ? n389_o : i_divstart;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1677_q <= n1676_o;
  /* ascal.vhd:1118:9  */
  assign n1678_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1679_o = i_pce & n1678_o;
  /* ascal.vhd:1128:17  */
  assign n1680_o = n1679_o ? i_pde : i_de_pre;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1681_q <= n1680_o;
  /* ascal.vhd:1118:9  */
  assign n1682_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1683_o = i_pce & n1682_o;
  /* ascal.vhd:1128:17  */
  assign n1684_o = n1683_o ? i_pvs : i_vs_pre;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1685_q <= n1684_o;
  /* ascal.vhd:1118:9  */
  assign n1686_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1687_o = i_pce & n1686_o;
  /* ascal.vhd:1128:17  */
  assign n1688_o = n1687_o ? i_pfl : i_fl_pre;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1689_q <= n1688_o;
  /* ascal.vhd:1118:9  */
  assign n1690_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1691_o = i_pce & n1690_o;
  /* ascal.vhd:1128:17  */
  assign n1692_o = n1691_o ? n1061_o : i_de_delay;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1693_q <= n1692_o;
  /* ascal.vhd:1118:9  */
  assign n1694_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1695_o = i_pce & n1694_o;
  /* ascal.vhd:1128:17  */
  assign n1696_o = n1695_o ? n94_o : i_intercnt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1697_q <= n1696_o;
  /* ascal.vhd:1118:9  */
  assign n1698_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1699_o = i_pce & n1698_o;
  /* ascal.vhd:1128:17  */
  assign n1700_o = n1699_o ? n105_o : i_inter;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1701_q <= n1700_o;
  /* ascal.vhd:1118:9  */
  assign n1702_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1703_o = i_pce & n1702_o;
  /* ascal.vhd:1128:17  */
  assign n1704_o = n1703_o ? n337_o : i_half;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1705_q <= n1704_o;
  /* ascal.vhd:1118:9  */
  assign n1706_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1707_o = n1122_o & n1706_o;
  /* ascal.vhd:1128:17  */
  assign n1708_o = n1707_o ? i_pfl : i_flm;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1709_q <= n1708_o;
  /* ascal.vhd:1128:17  */
  assign n1710_o = n1347_o ? n1348_o : i_write;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk or posedge n49_o)
    if (n49_o)
      n1711_q <= 1'b0;
    else
      n1711_q <= n1710_o;
  /* ascal.vhd:1118:9  */
  assign n1712_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1713_o = n1712_o ? n1329_o : i_wreq;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1714_q <= n1713_o;
  /* ascal.vhd:1118:9  */
  assign n1715_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1716_o = n1715_o ? n1330_o : i_alt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1717_q <= n1716_o;
  /* ascal.vhd:1118:9  */
  assign n1718_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1719_o = n1123_o & n1718_o;
  /* ascal.vhd:1128:17  */
  assign n1720_o = n1719_o ? n131_o : i_line;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1721_q <= n1720_o;
  /* ascal.vhd:1118:9  */
  assign n1722_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1723_o = n1347_o & n1722_o;
  /* ascal.vhd:1128:17  */
  assign n1724_o = n1723_o ? i_wline_mem : i_wline;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1725_q <= n1724_o;
  /* ascal.vhd:1118:9  */
  assign n1726_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1727_o = i_wreq & n1726_o;
  /* ascal.vhd:1128:17  */
  assign n1728_o = n1727_o ? i_line : i_wline_mem;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1729_q <= n1728_o;
  /* ascal.vhd:1118:9  */
  assign n1730_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1731_o = n1347_o & n1730_o;
  /* ascal.vhd:1128:17  */
  assign n1732_o = n1731_o ? i_walt_mem : i_walt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1733_q <= n1732_o;
  /* ascal.vhd:1118:9  */
  assign n1734_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1735_o = i_wreq & n1734_o;
  /* ascal.vhd:1128:17  */
  assign n1736_o = n1735_o ? i_alt : i_walt_mem;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1737_q <= n1736_o;
  /* ascal.vhd:1118:9  */
  assign n1738_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1739_o = n1738_o ? n1361_o : i_wreq_mem;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1740_q <= n1739_o;
  /* ascal.vhd:1118:9  */
  assign n1741_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1742_o = n1741_o ? n1363_o : i_wdelay;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1743_q <= n1742_o;
  /* ascal.vhd:1118:9  */
  assign n1744_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1745_o = n1744_o ? n1125_o : i_push;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1746_q <= n1745_o;
  /* ascal.vhd:1118:9  */
  assign n1747_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1748_o = i_pce & n1747_o;
  /* ascal.vhd:1128:17  */
  assign n1749_o = n1748_o ? n1044_o : i_pushend;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1750_q <= n1749_o;
  /* ascal.vhd:1118:9  */
  assign n1751_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1752_o = i_pce & n1751_o;
  /* ascal.vhd:1128:17  */
  assign n1753_o = n1752_o ? i_pushend : i_pushend2;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1754_q <= n1753_o;
  /* ascal.vhd:1118:9  */
  assign n1755_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1756_o = n1755_o ? n1130_o : i_eol;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1757_q <= n1756_o;
  /* ascal.vhd:1118:9  */
  assign n1758_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1759_o = n1758_o ? n1133_o : i_pushhead;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1760_q <= n1759_o;
  /* ascal.vhd:1118:9  */
  assign n1761_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1762_o = n1761_o ? i_pushhead : i_pushhead2;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1763_q <= n1762_o;
  /* ascal.vhd:1118:9  */
  assign n1764_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1765_o = n1764_o ? i_pushhead2 : i_pushhead3;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1766_q <= n1765_o;
  /* ascal.vhd:1118:9  */
  assign n1767_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1768_o = i_pce & n1767_o;
  /* ascal.vhd:1128:17  */
  assign n1769_o = n1768_o ? n263_o : i_hburst;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1770_q <= n1769_o;
  /* ascal.vhd:1118:9  */
  assign n1771_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1772_o = n1771_o ? n1331_o : i_hbcpt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1773_q <= n1772_o;
  /* ascal.vhd:1118:9  */
  assign n1774_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1775_o = n1137_o & n1774_o;
  /* ascal.vhd:1128:17  */
  assign n1776_o = n1775_o ? n901_o : i_shift;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1777_q <= n1776_o;
  initial
    n1777_q <= 120'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* ascal.vhd:1118:9  */
  assign n1778_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1779_o = n1778_o ? n1420_o : i_head;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1780_q <= n1779_o;
  /* ascal.vhd:1118:9  */
  assign n1781_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1782_o = i_pce & n1781_o;
  /* ascal.vhd:1128:17  */
  assign n1783_o = n1782_o ? n1088_o : i_acpt;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1784_q <= n1783_o;
  /* ascal.vhd:1118:9  */
  assign n1785_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1786_o = i_pce & n1785_o;
  /* ascal.vhd:1128:17  */
  assign n1787_o = n1786_o ? n165_o : i_endframe0;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1788_q <= n1787_o;
  /* ascal.vhd:1118:9  */
  assign n1789_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1790_o = i_pce & n1789_o;
  /* ascal.vhd:1128:17  */
  assign n1791_o = n1790_o ? n169_o : i_endframe1;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1792_q <= n1791_o;
  /* ascal.vhd:1118:9  */
  assign n1793_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1794_o = i_pce & n1793_o;
  /* ascal.vhd:1128:17  */
  assign n1795_o = n1794_o ? n184_o : i_vss;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1796_q <= n1795_o;
  /* ascal.vhd:1118:9  */
  assign n1797_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1798_o = n1797_o ? n1274_o : i_wad;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1799_q <= n1798_o;
  /* ascal.vhd:1118:9  */
  assign n1800_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1801_o = n1800_o ? n1216_o : i_dw;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1802_q <= n1801_o;
  /* ascal.vhd:1118:9  */
  assign n1803_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1804_o = n1803_o ? n1332_o : i_adrs;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1805_q <= n1804_o;
  /* ascal.vhd:1118:9  */
  assign n1806_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1807_o = n1806_o ? n1338_o : i_adrsi;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1808_q <= n1807_o;
  /* ascal.vhd:1118:9  */
  assign n1809_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1810_o = n1347_o & n1809_o;
  /* ascal.vhd:1128:17  */
  assign n1811_o = n1810_o ? i_wadrs_mem : i_wadrs;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1812_q <= n1811_o;
  /* ascal.vhd:1118:9  */
  assign n1813_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1814_o = i_wreq & n1813_o;
  /* ascal.vhd:1128:17  */
  assign n1815_o = n1814_o ? i_adrs : i_wadrs_mem;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1816_q <= n1815_o;
  /* ascal.vhd:1118:9  */
  assign n1817_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1818_o = i_pce & n1817_o;
  /* ascal.vhd:1128:17  */
  assign n1819_o = n1818_o ? n433_o : i_hnp;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1820_q <= n1819_o;
  /* ascal.vhd:1118:9  */
  assign n1821_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1822_o = i_pce & n1821_o;
  /* ascal.vhd:1128:17  */
  assign n1823_o = n1822_o ? n395_o : i_vnp;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1824_q <= n1823_o;
  /* ascal.vhd:1118:9  */
  assign n1825_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1826_o = i_pce & n1825_o;
  /* ascal.vhd:1128:17  */
  assign n1827_o = n1826_o ? o_hsize : i_ohsize;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1828_q <= n1827_o;
  /* ascal.vhd:1118:9  */
  assign n1829_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1830_o = i_pce & n1829_o;
  /* ascal.vhd:1128:17  */
  assign n1831_o = n1830_o ? o_vsize : i_ovsize;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1832_q <= n1831_o;
  /* ascal.vhd:1118:9  */
  assign n1833_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1834_o = i_pce & n1833_o;
  /* ascal.vhd:1128:17  */
  assign n1835_o = n1834_o ? n463_o : i_div;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1836_q <= n1835_o;
  /* ascal.vhd:1118:9  */
  assign n1837_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1838_o = i_pce & n1837_o;
  /* ascal.vhd:1128:17  */
  assign n1839_o = n1838_o ? n467_o : i_dir;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1840_q <= n1839_o;
  /* ascal.vhd:1118:9  */
  assign n1841_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1842_o = i_pce & n1841_o;
  /* ascal.vhd:1128:17  */
  assign n1843_o = n1842_o ? n505_o : i_h_frac;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1844_q <= n1843_o;
  /* ascal.vhd:1118:9  */
  assign n1845_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1846_o = i_pce & n1845_o;
  /* ascal.vhd:1128:17  */
  assign n1847_o = n1846_o ? n1079_o : i_hacc;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1848_q <= n1847_o;
  /* ascal.vhd:1118:9  */
  assign n1849_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1850_o = n1153_o & n1849_o;
  /* ascal.vhd:1128:17  */
  assign n1851_o = n1850_o ? n386_o : i_vacc;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1852_q <= n1851_o;
  /* ascal.vhd:1118:9  */
  assign n1853_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1854_o = i_pce & n1853_o;
  /* ascal.vhd:1128:17  */
  assign n1855_o = n1854_o ? n289_o : i_hdown;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1856_q <= n1855_o;
  /* ascal.vhd:1118:9  */
  assign n1857_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1858_o = i_pce & n1857_o;
  /* ascal.vhd:1128:17  */
  assign n1859_o = n1858_o ? n302_o : i_vdown;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1860_q <= n1859_o;
  /* ascal.vhd:1118:9  */
  assign n1861_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1862_o = n1861_o ? n1190_o : i_lwad;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1863_q <= n1862_o;
  /* ascal.vhd:1118:9  */
  assign n1864_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1865_o = n1864_o ? n1198_o : i_lrad;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1866_q <= n1865_o;
  /* ascal.vhd:1118:9  */
  assign n1867_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1868_o = n1867_o ? n1184_o : i_lwr;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1869_q <= n1868_o;
  /* ascal.vhd:1118:9  */
  assign n1870_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1871_o = i_pce & n1870_o;
  /* ascal.vhd:1128:17  */
  assign n1872_o = n1871_o ? n276_o : i_bil;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1873_q <= n1872_o;
  /* ascal.vhd:1118:9  */
  assign n1874_o = ~n49_o;
  /* ascal.vhd:1128:17  */
  assign n1875_o = n1874_o ? i_hpix : i_ldw;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1876_q <= n1875_o;
  /* ascal.vhd:1118:9  */
  assign n1877_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1878_o = i_pce & n1877_o;
  /* ascal.vhd:1128:17  */
  assign n1879_o = n1878_o ? i_ppix : i_hpixp;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1880_q <= n1879_o;
  /* ascal.vhd:1118:9  */
  assign n1881_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1882_o = i_pce & n1881_o;
  /* ascal.vhd:1128:17  */
  assign n1883_o = n1882_o ? i_hpixp : i_hpix0;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1884_q <= n1883_o;
  /* ascal.vhd:1118:9  */
  assign n1885_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1886_o = i_pce & n1885_o;
  /* ascal.vhd:1128:17  */
  assign n1887_o = n1886_o ? i_hpix0 : i_hpix1;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1888_q <= n1887_o;
  /* ascal.vhd:1118:9  */
  assign n1889_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1890_o = i_pce & n1889_o;
  /* ascal.vhd:1128:17  */
  assign n1891_o = n1890_o ? i_hpix1 : i_hpix2;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1892_q <= n1891_o;
  /* ascal.vhd:1118:9  */
  assign n1893_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1894_o = i_pce & n1893_o;
  /* ascal.vhd:1128:17  */
  assign n1895_o = n1894_o ? i_hpix2 : i_hpix3;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1896_q <= n1895_o;
  /* ascal.vhd:1118:9  */
  assign n1897_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1898_o = i_pce & n1897_o;
  /* ascal.vhd:1128:17  */
  assign n1899_o = n1898_o ? i_hpix3 : i_hpix4;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1900_q <= n1899_o;
  /* ascal.vhd:1118:9  */
  assign n1901_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1902_o = i_pce & n1901_o;
  /* ascal.vhd:1128:17  */
  assign n1903_o = n1902_o ? n684_o : i_hpix;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1904_q <= n1903_o;
  /* ascal.vhd:1118:9  */
  assign n1905_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1906_o = i_pce & n1905_o;
  /* ascal.vhd:1128:17  */
  assign n1907_o = n1906_o ? n863_o : i_pix;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1908_q <= n1907_o;
  /* ascal.vhd:1118:9  */
  assign n1909_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1910_o = i_pce & n1909_o;
  /* ascal.vhd:1128:17  */
  assign n1911_o = n1910_o ? i_hnp : i_hnp1;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1912_q <= n1911_o;
  /* ascal.vhd:1118:9  */
  assign n1913_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1914_o = i_pce & n1913_o;
  /* ascal.vhd:1128:17  */
  assign n1915_o = n1914_o ? i_hnp1 : i_hnp2;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1916_q <= n1915_o;
  /* ascal.vhd:1118:9  */
  assign n1917_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1918_o = i_pce & n1917_o;
  /* ascal.vhd:1128:17  */
  assign n1919_o = n1918_o ? i_hnp2 : i_hnp3;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1920_q <= n1919_o;
  /* ascal.vhd:1118:9  */
  assign n1921_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1922_o = i_pce & n1921_o;
  /* ascal.vhd:1128:17  */
  assign n1923_o = n1922_o ? i_hnp3 : i_hnp4;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1924_q <= n1923_o;
  /* ascal.vhd:1118:9  */
  assign n1925_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1926_o = i_pce & n1925_o;
  /* ascal.vhd:1128:17  */
  assign n1927_o = n1926_o ? i_ven : i_ven1;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1928_q <= n1927_o;
  /* ascal.vhd:1118:9  */
  assign n1929_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1930_o = i_pce & n1929_o;
  /* ascal.vhd:1128:17  */
  assign n1931_o = n1930_o ? i_ven1 : i_ven2;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1932_q <= n1931_o;
  /* ascal.vhd:1118:9  */
  assign n1933_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1934_o = i_pce & n1933_o;
  /* ascal.vhd:1128:17  */
  assign n1935_o = n1934_o ? i_ven2 : i_ven3;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1936_q <= n1935_o;
  /* ascal.vhd:1118:9  */
  assign n1937_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1938_o = i_pce & n1937_o;
  /* ascal.vhd:1128:17  */
  assign n1939_o = n1938_o ? i_ven3 : i_ven4;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1940_q <= n1939_o;
  /* ascal.vhd:1118:9  */
  assign n1941_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1942_o = i_pce & n1941_o;
  /* ascal.vhd:1128:17  */
  assign n1943_o = n1942_o ? i_ven4 : i_ven5;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1944_q <= n1943_o;
  /* ascal.vhd:1118:9  */
  assign n1945_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1946_o = i_pce & n1945_o;
  /* ascal.vhd:1128:17  */
  assign n1947_o = n1946_o ? i_ven5 : i_ven6;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1948_q <= n1947_o;
  /* ascal.vhd:1118:9  */
  assign n1949_o = ~n49_o;
  /* ascal.vhd:1118:9  */
  assign n1950_o = i_pce & n1949_o;
  /* ascal.vhd:1128:17  */
  assign n1951_o = n1950_o ? n635_o : i_h_bil_t;
  /* ascal.vhd:1128:17  */
  always @(posedge i_clk)
    n1952_q <= n1951_o;
  /* ascal.vhd:1550:39  */
  assign n1969_o = ~i_hdown;
  /* ascal.vhd:1550:27  */
  assign n1970_o = n1969_o ? i_hsize : i_ohsize;
  /* ascal.vhd:1551:39  */
  assign n1971_o = ~i_vdown;
  /* ascal.vhd:1551:27  */
  assign n1972_o = n1971_o ? i_vsize : i_ovsize;
  /* ascal.vhd:1558:30  */
  assign n1974_o = ~i_reset_na;
  /* ascal.vhd:1564:47  */
  assign n1976_o = {20'b0, i_vsize};  //  uext
  /* ascal.vhd:1564:47  */
  assign n1978_o = 32'b00000000000000000000000000000010 * n1976_o; // smul
  /* ascal.vhd:1564:46  */
  assign n1979_o = n1978_o[30:0];  // trunc
  /* ascal.vhd:1564:34  */
  assign n1980_o = n1979_o[12:0];  // trunc
  /* ascal.vhd:1565:52  */
  assign n1981_o = {19'b0, i_vacc};  //  uext
  /* ascal.vhd:1565:52  */
  assign n1983_o = n1981_o * 32'b00000000000000000001000000000000; // smul
  /* ascal.vhd:1565:46  */
  assign n1984_o = n1983_o[30:0];  // trunc
  /* ascal.vhd:1565:34  */
  assign n1985_o = n1984_o[24:0];  // trunc
  /* ascal.vhd:1574:44  */
  assign n1986_o = {26'b0, i_divcpt};  //  uext
  /* ascal.vhd:1574:44  */
  assign n1988_o = n1986_o == 32'b00000000000000000000000000000110;
  /* ascal.vhd:1576:58  */
  assign n1989_o = i_vdivr[4:0];
  /* ascal.vhd:1576:84  */
  assign n1990_o = i_vdivr[24];
  /* ascal.vhd:1576:73  */
  assign n1991_o = ~n1990_o;
  /* ascal.vhd:1576:71  */
  assign n1992_o = {n1989_o, n1991_o};
  /* ascal.vhd:1576:89  */
  assign n1994_o = {n1992_o, 6'b000000};
  /* ascal.vhd:1578:59  */
  assign n1995_o = {26'b0, i_divcpt};  //  uext
  /* ascal.vhd:1578:59  */
  assign n1997_o = n1995_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1578:51  */
  assign n1998_o = n1997_o[5:0];  // trunc
  /* ascal.vhd:1572:25  */
  assign n2000_o = n2014_o ? 1'b0 : i_divrun;
  /* ascal.vhd:1572:25  */
  assign n2001_o = n2017_o ? n1994_o : i_v_frac;
  /* ascal.vhd:1574:33  */
  assign n2002_o = n1988_o ? i_divcpt : n1998_o;
  /* ascal.vhd:1581:43  */
  assign n2003_o = i_vdivr[24];
  /* ascal.vhd:1581:47  */
  assign n2004_o = ~n2003_o;
  /* ascal.vhd:1582:71  */
  assign n2005_o = i_vdivr[23:11];
  /* ascal.vhd:1582:86  */
  assign n2006_o = n2005_o - i_vdivi;
  /* ascal.vhd:1584:71  */
  assign n2007_o = i_vdivr[23:11];
  /* ascal.vhd:1584:86  */
  assign n2008_o = n2007_o + i_vdivi;
  /* ascal.vhd:1581:33  */
  assign n2009_o = n2004_o ? n2006_o : n2008_o;
  /* ascal.vhd:1586:62  */
  assign n2010_o = i_vdivr[10:0];
  /* ascal.vhd:1586:89  */
  assign n2011_o = i_vdivr[24];
  /* ascal.vhd:1586:78  */
  assign n2012_o = ~n2011_o;
  /* ascal.vhd:1586:76  */
  assign n2013_o = {n2010_o, n2012_o};
  /* ascal.vhd:1572:25  */
  assign n2014_o = i_divrun & n1988_o;
  assign n2015_o = {n2009_o, n2013_o};
  /* ascal.vhd:1572:25  */
  assign n2016_o = i_divrun ? n2015_o : n1985_o;
  /* ascal.vhd:1572:25  */
  assign n2017_o = i_divrun & n1988_o;
  /* ascal.vhd:1572:25  */
  assign n2018_o = i_divrun ? n2002_o : i_divcpt;
  /* ascal.vhd:1568:25  */
  assign n2020_o = i_divstart ? 1'b1 : n2000_o;
  /* ascal.vhd:1568:25  */
  assign n2021_o = i_divstart ? n1985_o : n2016_o;
  /* ascal.vhd:1568:25  */
  assign n2022_o = i_divstart ? i_v_frac : n2001_o;
  /* ascal.vhd:1568:25  */
  assign n2024_o = i_divstart ? 6'b000000 : n2018_o;
  /* ascal.vhd:1556:9  */
  assign n2036_o = ~n1974_o;
  /* ascal.vhd:1563:17  */
  assign n2037_o = n2036_o ? n2020_o : i_divrun;
  /* ascal.vhd:1563:17  */
  always @(posedge i_clk)
    n2038_q <= n2037_o;
  /* ascal.vhd:1556:9  */
  assign n2039_o = ~n1974_o;
  /* ascal.vhd:1563:17  */
  assign n2040_o = n2039_o ? n1980_o : i_vdivi;
  /* ascal.vhd:1563:17  */
  always @(posedge i_clk)
    n2041_q <= n2040_o;
  /* ascal.vhd:1556:9  */
  assign n2042_o = ~n1974_o;
  /* ascal.vhd:1563:17  */
  assign n2043_o = n2042_o ? n2021_o : i_vdivr;
  /* ascal.vhd:1563:17  */
  always @(posedge i_clk)
    n2044_q <= n2043_o;
  /* ascal.vhd:1556:9  */
  assign n2045_o = ~n1974_o;
  /* ascal.vhd:1563:17  */
  assign n2046_o = n2045_o ? n2022_o : i_v_frac;
  /* ascal.vhd:1563:17  */
  always @(posedge i_clk)
    n2047_q <= n2046_o;
  /* ascal.vhd:1556:9  */
  assign n2048_o = ~n1974_o;
  /* ascal.vhd:1563:17  */
  assign n2049_o = n2048_o ? n2024_o : i_divcpt;
  /* ascal.vhd:1563:17  */
  always @(posedge i_clk)
    n2050_q <= n2049_o;
  /* ascal.vhd:1612:54  */
  assign n2071_o = {21'b0, i_lwad};  //  uext
  assign n2072_o = n2071_o[10:0];
  /* ascal.vhd:1615:62  */
  assign n2079_o = {21'b0, i_lrad};  //  uext
  assign n2080_o = n2079_o[10:0];
  /* ascal.vhd:1626:32  */
  assign n2095_o = ~avl_reset_na;
  /* ascal.vhd:1637:57  */
  assign n2097_o = avl_write_sync ^ avl_write_sync2;
  /* ascal.vhd:1639:53  */
  assign n2099_o = i_wadrs & 32'b00000000011111111111111111111111;
  /* ascal.vhd:1647:55  */
  assign n2103_o = avl_read_sync ^ avl_read_sync2;
  /* ascal.vhd:1652:45  */
  assign n2104_o = o_vsv[11];
  /* ascal.vhd:1656:38  */
  assign n2105_o = ~avl_fb_ena;
  /* ascal.vhd:404:21  */
  assign n2111_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:404:21  */
  assign n2113_o = n2111_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:404:17  */
  assign n2117_o = n2113_o ? 1'b0 : 1'b1;
  /* ascal.vhd:404:17  */
  assign n2123_o = n2113_o ? 32'b00000000100000000000000000000000 : 32'bX;
  /* ascal.vhd:405:21  */
  assign n2124_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:405:21  */
  assign n2126_o = n2124_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:405:17  */
  assign n2129_o = n2136_o ? 1'b0 : n2117_o;
  /* ascal.vhd:405:17  */
  assign n2132_o = n2138_o ? 32'b00000001000000000000000000000000 : n2123_o;
  /* ascal.vhd:405:17  */
  assign n2133_o = n2126_o & n2117_o;
  /* ascal.vhd:405:17  */
  assign n2135_o = n2126_o & n2117_o;
  /* ascal.vhd:405:17  */
  assign n2136_o = n2117_o & n2133_o;
  /* ascal.vhd:405:17  */
  assign n2138_o = n2117_o & n2135_o;
  /* ascal.vhd:406:17  */
  assign n2144_o = n2129_o ? 32'b00000000000000000000000000000000 : n2132_o;
  /* ascal.vhd:1658:92  */
  assign n2146_o = n2144_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:404:21  */
  assign n2152_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:404:21  */
  assign n2154_o = n2152_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:404:17  */
  assign n2158_o = n2154_o ? 1'b0 : 1'b1;
  /* ascal.vhd:404:17  */
  assign n2164_o = n2154_o ? 32'b00000000100000000000000000000000 : 32'bX;
  /* ascal.vhd:405:21  */
  assign n2165_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:405:21  */
  assign n2167_o = n2165_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:405:17  */
  assign n2170_o = n2177_o ? 1'b0 : n2158_o;
  /* ascal.vhd:405:17  */
  assign n2173_o = n2179_o ? 32'b00000001000000000000000000000000 : n2164_o;
  /* ascal.vhd:405:17  */
  assign n2174_o = n2167_o & n2158_o;
  /* ascal.vhd:405:17  */
  assign n2176_o = n2167_o & n2158_o;
  /* ascal.vhd:405:17  */
  assign n2177_o = n2158_o & n2174_o;
  /* ascal.vhd:405:17  */
  assign n2179_o = n2158_o & n2176_o;
  /* ascal.vhd:406:17  */
  assign n2185_o = n2170_o ? 32'b00000000000000000000000000000000 : n2173_o;
  /* ascal.vhd:1659:92  */
  assign n2187_o = n2185_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1664:44  */
  assign n2188_o = ~avl_o_vs_sync;
  /* ascal.vhd:1664:49  */
  assign n2189_o = n2188_o & avl_o_vs;
  /* ascal.vhd:1664:25  */
  assign n2190_o = n2189_o ? o_fb_base : avl_o_offset0;
  /* ascal.vhd:1664:25  */
  assign n2191_o = n2189_o ? o_fb_base : avl_o_offset1;
  /* ascal.vhd:1656:25  */
  assign n2192_o = n2105_o ? n2146_o : n2190_o;
  /* ascal.vhd:1656:25  */
  assign n2193_o = n2105_o ? n2187_o : n2191_o;
  /* ascal.vhd:404:21  */
  assign n2199_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:404:21  */
  assign n2201_o = n2199_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:404:17  */
  assign n2205_o = n2201_o ? 1'b0 : 1'b1;
  /* ascal.vhd:404:17  */
  assign n2211_o = n2201_o ? 32'b00000000100000000000000000000000 : 32'bX;
  /* ascal.vhd:405:21  */
  assign n2212_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:405:21  */
  assign n2214_o = n2212_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:405:17  */
  assign n2217_o = n2224_o ? 1'b0 : n2205_o;
  /* ascal.vhd:405:17  */
  assign n2220_o = n2226_o ? 32'b00000001000000000000000000000000 : n2211_o;
  /* ascal.vhd:405:17  */
  assign n2221_o = n2214_o & n2205_o;
  /* ascal.vhd:405:17  */
  assign n2223_o = n2214_o & n2205_o;
  /* ascal.vhd:405:17  */
  assign n2224_o = n2205_o & n2221_o;
  /* ascal.vhd:405:17  */
  assign n2226_o = n2205_o & n2223_o;
  /* ascal.vhd:406:17  */
  assign n2232_o = n2217_o ? 32'b00000000000000000000000000000000 : n2220_o;
  /* ascal.vhd:404:21  */
  assign n2238_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:404:21  */
  assign n2240_o = n2238_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:404:17  */
  assign n2244_o = n2240_o ? 1'b0 : 1'b1;
  /* ascal.vhd:404:17  */
  assign n2250_o = n2240_o ? 32'b00000000100000000000000000000000 : 32'bX;
  /* ascal.vhd:405:21  */
  assign n2251_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:405:21  */
  assign n2253_o = n2251_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:405:17  */
  assign n2256_o = n2263_o ? 1'b0 : n2244_o;
  /* ascal.vhd:405:17  */
  assign n2259_o = n2265_o ? 32'b00000001000000000000000000000000 : n2250_o;
  /* ascal.vhd:405:17  */
  assign n2260_o = n2253_o & n2244_o;
  /* ascal.vhd:405:17  */
  assign n2262_o = n2253_o & n2244_o;
  /* ascal.vhd:405:17  */
  assign n2263_o = n2244_o & n2260_o;
  /* ascal.vhd:405:17  */
  assign n2265_o = n2244_o & n2262_o;
  /* ascal.vhd:406:17  */
  assign n2271_o = n2256_o ? 32'b00000000000000000000000000000000 : n2259_o;
  /* ascal.vhd:692:55  */
  assign n2278_o = avl_readdata[127:120];
  /* ascal.vhd:692:55  */
  assign n2281_o = avl_readdata[119:112];
  /* ascal.vhd:692:55  */
  assign n2283_o = avl_readdata[111:104];
  /* ascal.vhd:692:55  */
  assign n2285_o = avl_readdata[103:96];
  /* ascal.vhd:692:55  */
  assign n2287_o = avl_readdata[95:88];
  /* ascal.vhd:692:55  */
  assign n2289_o = avl_readdata[87:80];
  /* ascal.vhd:692:55  */
  assign n2291_o = avl_readdata[79:72];
  /* ascal.vhd:692:55  */
  assign n2293_o = avl_readdata[71:64];
  /* ascal.vhd:692:55  */
  assign n2295_o = avl_readdata[63:56];
  /* ascal.vhd:692:55  */
  assign n2297_o = avl_readdata[55:48];
  /* ascal.vhd:692:55  */
  assign n2299_o = avl_readdata[47:40];
  /* ascal.vhd:692:55  */
  assign n2301_o = avl_readdata[39:32];
  /* ascal.vhd:692:55  */
  assign n2303_o = avl_readdata[31:24];
  /* ascal.vhd:692:55  */
  assign n2305_o = avl_readdata[23:16];
  /* ascal.vhd:692:55  */
  assign n2307_o = avl_readdata[15:8];
  /* ascal.vhd:692:55  */
  assign n2309_o = avl_readdata[7:0];
  assign n2310_o = {n2309_o, n2307_o, n2305_o, n2303_o, n2301_o, n2299_o, n2297_o, n2295_o, n2293_o, n2291_o, n2289_o, n2287_o, n2285_o, n2283_o, n2281_o, n2278_o};
  /* ascal.vhd:1678:53  */
  assign n2311_o = avl_write_sr | avl_write_pulse;
  /* ascal.vhd:1678:77  */
  assign n2312_o = ~avl_write_clr;
  /* ascal.vhd:1678:73  */
  assign n2313_o = n2311_o & n2312_o;
  /* ascal.vhd:1679:53  */
  assign n2314_o = avl_read_sr | avl_read_pulse;
  /* ascal.vhd:1679:77  */
  assign n2315_o = ~avl_read_clr;
  /* ascal.vhd:1679:73  */
  assign n2316_o = n2314_o & n2315_o;
  /* ascal.vhd:1691:60  */
  assign n2317_o = ~avl_walt;
  /* ascal.vhd:1691:49  */
  assign n2320_o = n2317_o ? 5'b00000 : 5'b10000;
  /* ascal.vhd:1696:61  */
  assign n2321_o = ~avl_wline;
  /* ascal.vhd:1698:74  */
  assign n2322_o = avl_wadrs[31:4];
  /* ascal.vhd:1699:78  */
  assign n2323_o = avl_i_offset0[31:4];
  /* ascal.vhd:1698:102  */
  assign n2324_o = n2322_o + n2323_o;
  /* ascal.vhd:1702:74  */
  assign n2325_o = avl_wadrs[31:4];
  /* ascal.vhd:1703:78  */
  assign n2326_o = avl_i_offset1[31:4];
  /* ascal.vhd:1702:102  */
  assign n2327_o = n2325_o + n2326_o;
  /* ascal.vhd:1696:49  */
  assign n2328_o = n2321_o ? n2324_o : n2327_o;
  /* ascal.vhd:1705:41  */
  assign n2330_o = avl_read_sr ? 2'b10 : avl_state;
  /* ascal.vhd:1705:41  */
  assign n2333_o = avl_read_sr ? 1'b1 : 1'b0;
  /* ascal.vhd:1688:41  */
  assign n2334_o = avl_write_sr ? n2328_o : n2503_q;
  /* ascal.vhd:1688:41  */
  assign n2336_o = avl_write_sr ? 2'b01 : n2330_o;
  /* ascal.vhd:1688:41  */
  assign n2338_o = avl_write_sr ? 1'b0 : n2333_o;
  /* ascal.vhd:1688:41  */
  assign n2341_o = avl_write_sr ? 1'b1 : 1'b0;
  /* ascal.vhd:1688:41  */
  assign n2342_o = avl_write_sr ? n2320_o : avl_rad_c;
  /* ascal.vhd:1687:33  */
  assign n2344_o = avl_state == 2'b00;
  /* ascal.vhd:1712:79  */
  assign n2345_o = ~avl_waitrequest;
  /* ascal.vhd:1712:60  */
  assign n2346_o = avl_write_i & n2345_o;
  /* ascal.vhd:1713:61  */
  assign n2347_o = {27'b0, avl_rad};  //  uext
  assign n2348_o = n2347_o[3:0];
  /* ascal.vhd:1713:61  */
  assign n2349_o = {28'b0, n2348_o};  //  uext
  /* ascal.vhd:1713:70  */
  assign n2351_o = n2349_o == 32'b00000000000000000000000000001111;
  /* ascal.vhd:1712:41  */
  assign n2353_o = n2357_o ? 2'b00 : avl_state;
  /* ascal.vhd:1713:49  */
  assign n2356_o = n2351_o ? 1'b0 : 1'b1;
  /* ascal.vhd:1712:41  */
  assign n2357_o = n2346_o & n2351_o;
  /* ascal.vhd:1712:41  */
  assign n2359_o = n2346_o ? n2356_o : 1'b1;
  /* ascal.vhd:1710:33  */
  assign n2362_o = avl_state == 2'b01;
  /* ascal.vhd:1720:53  */
  assign n2363_o = ~avl_rline;
  /* ascal.vhd:1721:66  */
  assign n2364_o = avl_radrs + avl_o_offset0;
  /* ascal.vhd:1723:66  */
  assign n2365_o = avl_radrs + avl_o_offset1;
  /* ascal.vhd:1720:41  */
  assign n2366_o = n2363_o ? n2364_o : n2365_o;
  /* ascal.vhd:1725:76  */
  assign n2367_o = n2366_o[31:4];
  /* ascal.vhd:1728:78  */
  assign n2368_o = ~avl_waitrequest;
  /* ascal.vhd:1728:59  */
  assign n2369_o = avl_read_i & n2368_o;
  /* ascal.vhd:1731:62  */
  assign n2370_o = ~avl_readack;
  /* ascal.vhd:1728:41  */
  assign n2372_o = n2369_o ? 2'b00 : avl_state;
  /* ascal.vhd:1728:41  */
  assign n2375_o = n2369_o ? 1'b0 : 1'b1;
  /* ascal.vhd:1728:41  */
  assign n2377_o = n2369_o ? n2370_o : avl_readack;
  /* ascal.vhd:1719:33  */
  assign n2379_o = avl_state == 2'b10;
  assign n2380_o = {n2379_o, n2362_o, n2344_o};
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2382_o <= n2367_o;
      3'b010: n2382_o <= n2503_q;
      3'b001: n2382_o <= n2334_o;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2384_o <= n2372_o;
      3'b010: n2384_o <= n2353_o;
      3'b001: n2384_o <= n2336_o;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2387_o <= 1'b0;
      3'b010: n2387_o <= n2359_o;
      3'b001: n2387_o <= 1'b0;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2391_o <= n2375_o;
      3'b010: n2391_o <= 1'b0;
      3'b001: n2391_o <= 1'b0;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2395_o <= 1'b0;
      3'b010: n2395_o <= 1'b0;
      3'b001: n2395_o <= n2338_o;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2399_o <= 1'b0;
      3'b010: n2399_o <= 1'b0;
      3'b001: n2399_o <= n2341_o;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2402_o <= avl_rad_c;
      3'b010: n2402_o <= avl_rad_c;
      3'b001: n2402_o <= n2342_o;
    endcase
  /* ascal.vhd:1686:25  */
  always @*
    case (n2380_o)
      3'b100: n2404_o <= n2377_o;
      3'b010: n2404_o <= avl_readack;
      3'b001: n2404_o <= avl_readack;
    endcase
  /* ascal.vhd:1740:50  */
  assign n2407_o = {27'b0, avl_wad};  //  uext
  /* ascal.vhd:1740:50  */
  assign n2409_o = n2407_o + 32'b00000000000000000000000000000001;
  assign n2410_o = n2409_o[4:0];
  /* ascal.vhd:1741:45  */
  assign n2412_o = {27'b0, avl_wad};  //  uext
  assign n2413_o = n2412_o[3:0];
  /* ascal.vhd:1741:45  */
  assign n2414_o = {28'b0, n2413_o};  //  uext
  /* ascal.vhd:1741:54  */
  assign n2416_o = n2414_o == 32'b00000000000000000000000000001110;
  /* ascal.vhd:1742:58  */
  assign n2417_o = ~avl_readdataack;
  /* ascal.vhd:1738:25  */
  assign n2419_o = avl_readdatavalid ? n2410_o : avl_wad;
  /* ascal.vhd:1738:25  */
  assign n2422_o = avl_readdatavalid ? 1'b1 : 1'b0;
  /* ascal.vhd:1738:25  */
  assign n2424_o = avl_readdatavalid & n2416_o;
  /* ascal.vhd:1746:41  */
  assign n2425_o = ~avl_o_vs_sync;
  /* ascal.vhd:1746:46  */
  assign n2426_o = n2425_o & avl_o_vs;
  /* ascal.vhd:1746:25  */
  assign n2428_o = n2426_o ? 5'b11111 : n2419_o;
  /* ascal.vhd:1623:9  */
  assign n2501_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2502_o = n2501_o ? n2382_o : n2503_q;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2503_q <= n2502_o;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk or posedge n2095_o)
    if (n2095_o)
      n2504_q <= 2'b00;
    else
      n2504_q <= n2384_o;
  /* ascal.vhd:1623:9  */
  assign n2505_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2506_o = n2505_o ? n2387_o : avl_write_i;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2507_q <= n2506_o;
  /* ascal.vhd:1623:9  */
  assign n2508_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2509_o = n2508_o ? i_write : avl_write_sync;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2510_q <= n2509_o;
  /* ascal.vhd:1623:9  */
  assign n2511_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2512_o = n2511_o ? avl_write_sync : avl_write_sync2;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2513_q <= n2512_o;
  /* ascal.vhd:1623:9  */
  assign n2514_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2515_o = n2514_o ? n2391_o : avl_read_i;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2516_q <= n2515_o;
  /* ascal.vhd:1623:9  */
  assign n2517_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2518_o = n2517_o ? o_read : avl_read_sync;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2519_q <= n2518_o;
  /* ascal.vhd:1623:9  */
  assign n2520_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2521_o = n2520_o ? avl_read_sync : avl_read_sync2;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2522_q <= n2521_o;
  /* ascal.vhd:1623:9  */
  assign n2523_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2524_o = n2523_o ? n2103_o : avl_read_pulse;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2525_q <= n2524_o;
  /* ascal.vhd:1623:9  */
  assign n2526_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2527_o = n2526_o ? n2097_o : avl_write_pulse;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2528_q <= n2527_o;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk or posedge n2095_o)
    if (n2095_o)
      n2529_q <= 1'b0;
    else
      n2529_q <= n2316_o;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk or posedge n2095_o)
    if (n2095_o)
      n2530_q <= 1'b0;
    else
      n2530_q <= n2313_o;
  /* ascal.vhd:1623:9  */
  assign n2531_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2532_o = n2531_o ? n2395_o : avl_read_clr;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2533_q <= n2532_o;
  /* ascal.vhd:1623:9  */
  assign n2534_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2535_o = n2534_o ? n2399_o : avl_write_clr;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2536_q <= n2535_o;
  /* ascal.vhd:1623:9  */
  assign n2537_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2538_o = n2537_o ? n2402_o : avl_rad;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2539_q <= n2538_o;
  /* ascal.vhd:1623:9  */
  assign n2540_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2541_o = n2540_o ? n2428_o : avl_wad;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2542_q <= n2541_o;
  /* ascal.vhd:1623:9  */
  assign n2543_o = ~n2095_o;
  /* ascal.vhd:1623:9  */
  assign n2544_o = avl_write_pulse & n2543_o;
  /* ascal.vhd:1633:17  */
  assign n2545_o = n2544_o ? i_walt : avl_walt;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2546_q <= n2545_o;
  /* ascal.vhd:1623:9  */
  assign n2547_o = ~n2095_o;
  /* ascal.vhd:1623:9  */
  assign n2548_o = avl_write_pulse & n2547_o;
  /* ascal.vhd:1633:17  */
  assign n2549_o = n2548_o ? i_wline : avl_wline;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2550_q <= n2549_o;
  /* ascal.vhd:1623:9  */
  assign n2551_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2552_o = n2551_o ? o_rline : avl_rline;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2553_q <= n2552_o;
  /* ascal.vhd:1623:9  */
  assign n2554_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2555_o = n2554_o ? n2310_o : avl_dw;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2556_q <= n2555_o;
  /* ascal.vhd:1623:9  */
  assign n2557_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2558_o = n2557_o ? n2422_o : avl_wr;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2559_q <= n2558_o;
  /* ascal.vhd:1633:17  */
  assign n2560_o = n2424_o ? n2417_o : avl_readdataack;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk or posedge n2095_o)
    if (n2095_o)
      n2561_q <= 1'b0;
    else
      n2561_q <= n2560_o;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk or posedge n2095_o)
    if (n2095_o)
      n2562_q <= 1'b0;
    else
      n2562_q <= n2404_o;
  /* ascal.vhd:1623:9  */
  assign n2563_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2564_o = n2563_o ? o_adrs : avl_radrs;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2565_q <= n2564_o;
  /* ascal.vhd:1623:9  */
  assign n2566_o = ~n2095_o;
  /* ascal.vhd:1623:9  */
  assign n2567_o = avl_write_pulse & n2566_o;
  /* ascal.vhd:1633:17  */
  assign n2568_o = n2567_o ? n2099_o : avl_wadrs;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2569_q <= n2568_o;
  /* ascal.vhd:1623:9  */
  assign n2570_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2571_o = n2570_o ? n2232_o : avl_i_offset0;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2572_q <= n2571_o;
  /* ascal.vhd:1623:9  */
  assign n2573_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2574_o = n2573_o ? n2192_o : avl_o_offset0;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2575_q <= n2574_o;
  /* ascal.vhd:1623:9  */
  assign n2576_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2577_o = n2576_o ? n2271_o : avl_i_offset1;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2578_q <= n2577_o;
  /* ascal.vhd:1623:9  */
  assign n2579_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2580_o = n2579_o ? n2193_o : avl_o_offset1;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2581_q <= n2580_o;
  /* ascal.vhd:1623:9  */
  assign n2582_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2583_o = n2582_o ? n2104_o : avl_o_vs_sync;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2584_q <= n2583_o;
  /* ascal.vhd:1623:9  */
  assign n2585_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2586_o = n2585_o ? avl_o_vs_sync : avl_o_vs;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2587_q <= n2586_o;
  /* ascal.vhd:1623:9  */
  assign n2588_o = ~n2095_o;
  /* ascal.vhd:1633:17  */
  assign n2589_o = n2588_o ? o_fb_ena : avl_fb_ena;
  /* ascal.vhd:1633:17  */
  always @(posedge avl_clk)
    n2590_q <= n2589_o;
  /* ascal.vhd:692:55  */
  assign n2600_o = avl_dr[127:120];
  /* ascal.vhd:692:55  */
  assign n2603_o = avl_dr[119:112];
  /* ascal.vhd:692:55  */
  assign n2605_o = avl_dr[111:104];
  /* ascal.vhd:692:55  */
  assign n2607_o = avl_dr[103:96];
  /* ascal.vhd:692:55  */
  assign n2609_o = avl_dr[95:88];
  /* ascal.vhd:692:55  */
  assign n2611_o = avl_dr[87:80];
  /* ascal.vhd:692:55  */
  assign n2613_o = avl_dr[79:72];
  /* ascal.vhd:692:55  */
  assign n2615_o = avl_dr[71:64];
  /* ascal.vhd:692:55  */
  assign n2617_o = avl_dr[63:56];
  /* ascal.vhd:692:55  */
  assign n2619_o = avl_dr[55:48];
  /* ascal.vhd:692:55  */
  assign n2621_o = avl_dr[47:40];
  /* ascal.vhd:692:55  */
  assign n2623_o = avl_dr[39:32];
  /* ascal.vhd:692:55  */
  assign n2625_o = avl_dr[31:24];
  /* ascal.vhd:692:55  */
  assign n2627_o = avl_dr[23:16];
  /* ascal.vhd:692:55  */
  assign n2629_o = avl_dr[15:8];
  /* ascal.vhd:692:55  */
  assign n2631_o = avl_dr[7:0];
  assign n2632_o = {n2631_o, n2629_o, n2627_o, n2625_o, n2623_o, n2621_o, n2619_o, n2617_o, n2615_o, n2613_o, n2611_o, n2609_o, n2607_o, n2605_o, n2603_o, n2600_o};
  /* ascal.vhd:1760:28  */
  assign n2635_o = {27'b0, avl_rad};  //  uext
  /* ascal.vhd:1760:28  */
  assign n2637_o = n2635_o + 32'b00000000000000000000000000000001;
  assign n2638_o = n2637_o[4:0];
  /* ascal.vhd:1761:81  */
  assign n2640_o = ~avl_waitrequest;
  /* ascal.vhd:1761:62  */
  assign n2641_o = avl_write_i & n2640_o;
  /* ascal.vhd:1761:41  */
  assign n2642_o = n2641_o ? n2638_o : avl_rad;
  /* ascal.vhd:1781:30  */
  assign n2662_o = ~o_reset_na;
  /* ascal.vhd:1786:47  */
  assign n2664_o = {20'b0, o_vsize};  //  uext
  /* ascal.vhd:1786:47  */
  assign n2666_o = 32'b00000000000000000000000000000010 * n2664_o; // smul
  /* ascal.vhd:1786:46  */
  assign n2667_o = n2666_o[30:0];  // trunc
  /* ascal.vhd:1786:34  */
  assign n2668_o = n2667_o[12:0];  // trunc
  /* ascal.vhd:1787:52  */
  assign n2669_o = {19'b0, o_vacc};  //  uext
  /* ascal.vhd:1787:52  */
  assign n2671_o = n2669_o * 32'b00000000000000000001000000000000; // smul
  /* ascal.vhd:1787:46  */
  assign n2672_o = n2671_o[30:0];  // trunc
  /* ascal.vhd:1787:34  */
  assign n2673_o = n2672_o[24:0];  // trunc
  /* ascal.vhd:1795:44  */
  assign n2674_o = {26'b0, o_divcpt};  //  uext
  /* ascal.vhd:1795:44  */
  assign n2676_o = n2674_o == 32'b00000000000000000000000000001100;
  /* ascal.vhd:1797:57  */
  assign n2677_o = o_vdivr[10:0];
  /* ascal.vhd:1797:84  */
  assign n2678_o = o_vdivr[24];
  /* ascal.vhd:1797:73  */
  assign n2679_o = ~n2678_o;
  /* ascal.vhd:1797:71  */
  assign n2680_o = {n2677_o, n2679_o};
  /* ascal.vhd:1799:59  */
  assign n2681_o = {26'b0, o_divcpt};  //  uext
  /* ascal.vhd:1799:59  */
  assign n2683_o = n2681_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1799:51  */
  assign n2684_o = n2683_o[5:0];  // trunc
  /* ascal.vhd:1795:33  */
  assign n2685_o = n2676_o ? o_divcpt : n2684_o;
  /* ascal.vhd:1793:25  */
  assign n2686_o = n2701_o ? n2680_o : o_vfrac;
  /* ascal.vhd:1793:25  */
  assign n2688_o = n2704_o ? 1'b0 : o_divrun;
  /* ascal.vhd:1802:43  */
  assign n2689_o = o_vdivr[24];
  /* ascal.vhd:1802:47  */
  assign n2690_o = ~n2689_o;
  /* ascal.vhd:1803:71  */
  assign n2691_o = o_vdivr[23:11];
  /* ascal.vhd:1803:86  */
  assign n2692_o = n2691_o - o_vdivi;
  /* ascal.vhd:1805:71  */
  assign n2693_o = o_vdivr[23:11];
  /* ascal.vhd:1805:86  */
  assign n2694_o = n2693_o + o_vdivi;
  /* ascal.vhd:1802:33  */
  assign n2695_o = n2690_o ? n2692_o : n2694_o;
  /* ascal.vhd:1807:62  */
  assign n2696_o = o_vdivr[10:0];
  /* ascal.vhd:1807:89  */
  assign n2697_o = o_vdivr[24];
  /* ascal.vhd:1807:78  */
  assign n2698_o = ~n2697_o;
  /* ascal.vhd:1807:76  */
  assign n2699_o = {n2696_o, n2698_o};
  /* ascal.vhd:1793:25  */
  assign n2700_o = o_divrun ? n2685_o : o_divcpt;
  /* ascal.vhd:1793:25  */
  assign n2701_o = o_divrun & n2676_o;
  assign n2702_o = {n2695_o, n2699_o};
  /* ascal.vhd:1793:25  */
  assign n2703_o = o_divrun ? n2702_o : n2673_o;
  /* ascal.vhd:1793:25  */
  assign n2704_o = o_divrun & n2676_o;
  /* ascal.vhd:1789:25  */
  assign n2706_o = o_divstart ? 6'b000000 : n2700_o;
  /* ascal.vhd:1789:25  */
  assign n2707_o = o_divstart ? o_vfrac : n2686_o;
  /* ascal.vhd:1789:25  */
  assign n2708_o = o_divstart ? n2673_o : n2703_o;
  /* ascal.vhd:1789:25  */
  assign n2710_o = o_divstart ? 1'b1 : n2688_o;
  /* ascal.vhd:1779:9  */
  assign n2722_o = ~n2662_o;
  /* ascal.vhd:1785:17  */
  assign n2723_o = n2722_o ? n2706_o : o_divcpt;
  /* ascal.vhd:1785:17  */
  always @(posedge o_clk)
    n2724_q <= n2723_o;
  /* ascal.vhd:1779:9  */
  assign n2725_o = ~n2662_o;
  /* ascal.vhd:1785:17  */
  assign n2726_o = n2725_o ? n2707_o : o_vfrac;
  /* ascal.vhd:1785:17  */
  always @(posedge o_clk)
    n2727_q <= n2726_o;
  /* ascal.vhd:1779:9  */
  assign n2728_o = ~n2662_o;
  /* ascal.vhd:1785:17  */
  assign n2729_o = n2728_o ? n2668_o : o_vdivi;
  /* ascal.vhd:1785:17  */
  always @(posedge o_clk)
    n2730_q <= n2729_o;
  /* ascal.vhd:1779:9  */
  assign n2731_o = ~n2662_o;
  /* ascal.vhd:1785:17  */
  assign n2732_o = n2731_o ? n2708_o : o_vdivr;
  /* ascal.vhd:1785:17  */
  always @(posedge o_clk)
    n2733_q <= n2732_o;
  /* ascal.vhd:1779:9  */
  assign n2734_o = ~n2662_o;
  /* ascal.vhd:1785:17  */
  assign n2735_o = n2734_o ? n2710_o : o_divrun;
  /* ascal.vhd:1785:17  */
  always @(posedge o_clk)
    n2736_q <= n2735_o;
  /* ascal.vhd:1816:26  */
  always @*
    scalaire_prim_v = n4864_q; // (isignal)
  initial
    scalaire_prim_v <= 1'bX;
  /* ascal.vhd:1816:33  */
  always @*
    scalaire_last_v = n4867_q; // (isignal)
  initial
    scalaire_last_v <= 1'bX;
  /* ascal.vhd:1816:40  */
  always @*
    scalaire_bib_v = n4870_q; // (isignal)
  initial
    scalaire_bib_v <= 1'bX;
  /* ascal.vhd:1821:26  */
  always @*
    scalaire_off_v = n4890_q; // (isignal)
  initial
    scalaire_off_v <= 4'b0000;
  /* ascal.vhd:1823:30  */
  assign n2749_o = ~o_reset_na;
  /* ascal.vhd:1834:43  */
  assign n2752_o = {4'b0001, format};
  /* ascal.vhd:1852:43  */
  assign n2753_o = {20'b0, o_hmax};  //  uext
  /* ascal.vhd:1852:43  */
  assign n2754_o = {20'b0, o_hmin};  //  uext
  /* ascal.vhd:1852:43  */
  assign n2755_o = n2753_o - n2754_o;
  /* ascal.vhd:1852:52  */
  assign n2757_o = n2755_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1852:36  */
  assign n2758_o = n2757_o[11:0];  // trunc
  /* ascal.vhd:1853:43  */
  assign n2759_o = {20'b0, o_vmax};  //  uext
  /* ascal.vhd:1853:43  */
  assign n2760_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:1853:43  */
  assign n2761_o = n2759_o - n2760_o;
  /* ascal.vhd:1853:52  */
  assign n2763_o = n2761_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:1853:36  */
  assign n2764_o = n2763_o[11:0];  // trunc
  /* ascal.vhd:1868:62  */
  assign n2765_o = ~o_iendframe02;
  /* ascal.vhd:1868:45  */
  assign n2766_o = o_iendframe0 & n2765_o;
  /* ascal.vhd:395:38  */
  assign n2772_o = {29'b0, o_ibuf0};  //  uext
  /* ascal.vhd:395:17  */
  assign n2775_o = o_freeze ? 1'b0 : 1'b1;
  /* ascal.vhd:395:17  */
  assign n2781_o = o_freeze ? n2772_o : 31'bX;
  /* ascal.vhd:396:22  */
  assign n2782_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:396:22  */
  assign n2784_o = n2782_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:30  */
  assign n2785_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:396:30  */
  assign n2787_o = n2785_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:25  */
  assign n2788_o = n2784_o & n2787_o;
  /* ascal.vhd:396:39  */
  assign n2789_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:396:39  */
  assign n2791_o = n2789_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:47  */
  assign n2792_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:396:47  */
  assign n2794_o = n2792_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:42  */
  assign n2795_o = n2791_o & n2794_o;
  /* ascal.vhd:396:34  */
  assign n2796_o = n2788_o | n2795_o;
  /* ascal.vhd:396:17  */
  assign n2799_o = n2806_o ? 1'b0 : n2775_o;
  /* ascal.vhd:396:17  */
  assign n2802_o = n2808_o ? 31'b0000000000000000000000000000010 : n2781_o;
  /* ascal.vhd:396:17  */
  assign n2803_o = n2796_o & n2775_o;
  /* ascal.vhd:396:17  */
  assign n2805_o = n2796_o & n2775_o;
  /* ascal.vhd:396:17  */
  assign n2806_o = n2775_o & n2803_o;
  /* ascal.vhd:396:17  */
  assign n2808_o = n2775_o & n2805_o;
  /* ascal.vhd:397:22  */
  assign n2809_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:397:22  */
  assign n2811_o = n2809_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:30  */
  assign n2812_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:397:30  */
  assign n2814_o = n2812_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:25  */
  assign n2815_o = n2811_o & n2814_o;
  /* ascal.vhd:397:39  */
  assign n2816_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:397:39  */
  assign n2818_o = n2816_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:47  */
  assign n2819_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:397:47  */
  assign n2821_o = n2819_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:42  */
  assign n2822_o = n2818_o & n2821_o;
  /* ascal.vhd:397:34  */
  assign n2823_o = n2815_o | n2822_o;
  /* ascal.vhd:397:17  */
  assign n2826_o = n2833_o ? 1'b0 : n2799_o;
  /* ascal.vhd:397:17  */
  assign n2829_o = n2835_o ? 31'b0000000000000000000000000000000 : n2802_o;
  /* ascal.vhd:397:17  */
  assign n2830_o = n2823_o & n2799_o;
  /* ascal.vhd:397:17  */
  assign n2832_o = n2823_o & n2799_o;
  /* ascal.vhd:397:17  */
  assign n2833_o = n2799_o & n2830_o;
  /* ascal.vhd:397:17  */
  assign n2835_o = n2799_o & n2832_o;
  /* ascal.vhd:398:17  */
  assign n2841_o = n2826_o ? 31'b0000000000000000000000000000001 : n2829_o;
  /* ascal.vhd:1869:42  */
  assign n2842_o = n2841_o[1:0];  // trunc
  /* ascal.vhd:1868:25  */
  assign n2845_o = n2766_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1868:25  */
  assign n2848_o = n2766_o ? 1'b1 : o_bufup0;
  /* ascal.vhd:1868:25  */
  assign n2849_o = n2766_o ? n2842_o : o_ibuf0;
  /* ascal.vhd:1875:62  */
  assign n2850_o = ~o_iendframe12;
  /* ascal.vhd:1875:45  */
  assign n2851_o = o_iendframe1 & n2850_o;
  /* ascal.vhd:395:38  */
  assign n2857_o = {29'b0, o_ibuf1};  //  uext
  /* ascal.vhd:395:17  */
  assign n2860_o = o_freeze ? 1'b0 : 1'b1;
  /* ascal.vhd:395:17  */
  assign n2866_o = o_freeze ? n2857_o : 31'bX;
  /* ascal.vhd:396:22  */
  assign n2867_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:396:22  */
  assign n2869_o = n2867_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:30  */
  assign n2870_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:396:30  */
  assign n2872_o = n2870_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:25  */
  assign n2873_o = n2869_o & n2872_o;
  /* ascal.vhd:396:39  */
  assign n2874_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:396:39  */
  assign n2876_o = n2874_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:47  */
  assign n2877_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:396:47  */
  assign n2879_o = n2877_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:42  */
  assign n2880_o = n2876_o & n2879_o;
  /* ascal.vhd:396:34  */
  assign n2881_o = n2873_o | n2880_o;
  /* ascal.vhd:396:17  */
  assign n2884_o = n2891_o ? 1'b0 : n2860_o;
  /* ascal.vhd:396:17  */
  assign n2887_o = n2893_o ? 31'b0000000000000000000000000000010 : n2866_o;
  /* ascal.vhd:396:17  */
  assign n2888_o = n2881_o & n2860_o;
  /* ascal.vhd:396:17  */
  assign n2890_o = n2881_o & n2860_o;
  /* ascal.vhd:396:17  */
  assign n2891_o = n2860_o & n2888_o;
  /* ascal.vhd:396:17  */
  assign n2893_o = n2860_o & n2890_o;
  /* ascal.vhd:397:22  */
  assign n2894_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:397:22  */
  assign n2896_o = n2894_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:30  */
  assign n2897_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:397:30  */
  assign n2899_o = n2897_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:25  */
  assign n2900_o = n2896_o & n2899_o;
  /* ascal.vhd:397:39  */
  assign n2901_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:397:39  */
  assign n2903_o = n2901_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:47  */
  assign n2904_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:397:47  */
  assign n2906_o = n2904_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:42  */
  assign n2907_o = n2903_o & n2906_o;
  /* ascal.vhd:397:34  */
  assign n2908_o = n2900_o | n2907_o;
  /* ascal.vhd:397:17  */
  assign n2911_o = n2918_o ? 1'b0 : n2884_o;
  /* ascal.vhd:397:17  */
  assign n2914_o = n2920_o ? 31'b0000000000000000000000000000000 : n2887_o;
  /* ascal.vhd:397:17  */
  assign n2915_o = n2908_o & n2884_o;
  /* ascal.vhd:397:17  */
  assign n2917_o = n2908_o & n2884_o;
  /* ascal.vhd:397:17  */
  assign n2918_o = n2884_o & n2915_o;
  /* ascal.vhd:397:17  */
  assign n2920_o = n2884_o & n2917_o;
  /* ascal.vhd:398:17  */
  assign n2926_o = n2911_o ? 31'b0000000000000000000000000000001 : n2914_o;
  /* ascal.vhd:1876:42  */
  assign n2927_o = n2926_o[1:0];  // trunc
  /* ascal.vhd:1875:25  */
  assign n2929_o = n2851_o ? 1'b1 : n2845_o;
  /* ascal.vhd:1875:25  */
  assign n2931_o = n2851_o ? 1'b1 : o_bufup1;
  /* ascal.vhd:1875:25  */
  assign n2932_o = n2851_o ? n2927_o : o_ibuf1;
  /* ascal.vhd:1882:33  */
  assign n2933_o = o_vsv[10];
  /* ascal.vhd:1882:50  */
  assign n2934_o = o_vsv[11];
  /* ascal.vhd:1882:53  */
  assign n2935_o = ~n2934_o;
  /* ascal.vhd:1882:41  */
  assign n2936_o = n2933_o & n2935_o;
  /* ascal.vhd:1882:58  */
  assign n2937_o = n2936_o & o_bufup0;
  /* ascal.vhd:395:38  */
  assign n2943_o = {29'b0, o_obuf0};  //  uext
  /* ascal.vhd:395:17  */
  assign n2946_o = o_freeze ? 1'b0 : 1'b1;
  /* ascal.vhd:395:17  */
  assign n2952_o = o_freeze ? n2943_o : 31'bX;
  /* ascal.vhd:396:22  */
  assign n2953_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:396:22  */
  assign n2955_o = n2953_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:30  */
  assign n2956_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:396:30  */
  assign n2958_o = n2956_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:25  */
  assign n2959_o = n2955_o & n2958_o;
  /* ascal.vhd:396:39  */
  assign n2960_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:396:39  */
  assign n2962_o = n2960_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:47  */
  assign n2963_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:396:47  */
  assign n2965_o = n2963_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:42  */
  assign n2966_o = n2962_o & n2965_o;
  /* ascal.vhd:396:34  */
  assign n2967_o = n2959_o | n2966_o;
  /* ascal.vhd:396:17  */
  assign n2970_o = n2977_o ? 1'b0 : n2946_o;
  /* ascal.vhd:396:17  */
  assign n2973_o = n2979_o ? 31'b0000000000000000000000000000010 : n2952_o;
  /* ascal.vhd:396:17  */
  assign n2974_o = n2967_o & n2946_o;
  /* ascal.vhd:396:17  */
  assign n2976_o = n2967_o & n2946_o;
  /* ascal.vhd:396:17  */
  assign n2977_o = n2946_o & n2974_o;
  /* ascal.vhd:396:17  */
  assign n2979_o = n2946_o & n2976_o;
  /* ascal.vhd:397:22  */
  assign n2980_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:397:22  */
  assign n2982_o = n2980_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:30  */
  assign n2983_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:397:30  */
  assign n2985_o = n2983_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:25  */
  assign n2986_o = n2982_o & n2985_o;
  /* ascal.vhd:397:39  */
  assign n2987_o = {30'b0, o_obuf0};  //  uext
  /* ascal.vhd:397:39  */
  assign n2989_o = n2987_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:47  */
  assign n2990_o = {30'b0, o_ibuf0};  //  uext
  /* ascal.vhd:397:47  */
  assign n2992_o = n2990_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:42  */
  assign n2993_o = n2989_o & n2992_o;
  /* ascal.vhd:397:34  */
  assign n2994_o = n2986_o | n2993_o;
  /* ascal.vhd:397:17  */
  assign n2997_o = n3004_o ? 1'b0 : n2970_o;
  /* ascal.vhd:397:17  */
  assign n3000_o = n3006_o ? 31'b0000000000000000000000000000000 : n2973_o;
  /* ascal.vhd:397:17  */
  assign n3001_o = n2994_o & n2970_o;
  /* ascal.vhd:397:17  */
  assign n3003_o = n2994_o & n2970_o;
  /* ascal.vhd:397:17  */
  assign n3004_o = n2970_o & n3001_o;
  /* ascal.vhd:397:17  */
  assign n3006_o = n2970_o & n3003_o;
  /* ascal.vhd:398:17  */
  assign n3012_o = n2997_o ? 31'b0000000000000000000000000000001 : n3000_o;
  /* ascal.vhd:1883:42  */
  assign n3013_o = n3012_o[1:0];  // trunc
  /* ascal.vhd:1882:25  */
  assign n3015_o = n2937_o ? 1'b0 : n2848_o;
  /* ascal.vhd:1882:25  */
  assign n3016_o = n2937_o ? n3013_o : o_obuf0;
  /* ascal.vhd:1886:33  */
  assign n3017_o = o_vsv[10];
  /* ascal.vhd:1886:50  */
  assign n3018_o = o_vsv[11];
  /* ascal.vhd:1886:53  */
  assign n3019_o = ~n3018_o;
  /* ascal.vhd:1886:41  */
  assign n3020_o = n3017_o & n3019_o;
  /* ascal.vhd:1886:58  */
  assign n3021_o = n3020_o & o_bufup1;
  /* ascal.vhd:395:38  */
  assign n3027_o = {29'b0, o_obuf1};  //  uext
  /* ascal.vhd:395:17  */
  assign n3030_o = o_freeze ? 1'b0 : 1'b1;
  /* ascal.vhd:395:17  */
  assign n3036_o = o_freeze ? n3027_o : 31'bX;
  /* ascal.vhd:396:22  */
  assign n3037_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:396:22  */
  assign n3039_o = n3037_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:30  */
  assign n3040_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:396:30  */
  assign n3042_o = n3040_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:25  */
  assign n3043_o = n3039_o & n3042_o;
  /* ascal.vhd:396:39  */
  assign n3044_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:396:39  */
  assign n3046_o = n3044_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:396:47  */
  assign n3047_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:396:47  */
  assign n3049_o = n3047_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:396:42  */
  assign n3050_o = n3046_o & n3049_o;
  /* ascal.vhd:396:34  */
  assign n3051_o = n3043_o | n3050_o;
  /* ascal.vhd:396:17  */
  assign n3054_o = n3061_o ? 1'b0 : n3030_o;
  /* ascal.vhd:396:17  */
  assign n3057_o = n3063_o ? 31'b0000000000000000000000000000010 : n3036_o;
  /* ascal.vhd:396:17  */
  assign n3058_o = n3051_o & n3030_o;
  /* ascal.vhd:396:17  */
  assign n3060_o = n3051_o & n3030_o;
  /* ascal.vhd:396:17  */
  assign n3061_o = n3030_o & n3058_o;
  /* ascal.vhd:396:17  */
  assign n3063_o = n3030_o & n3060_o;
  /* ascal.vhd:397:22  */
  assign n3064_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:397:22  */
  assign n3066_o = n3064_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:30  */
  assign n3067_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:397:30  */
  assign n3069_o = n3067_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:25  */
  assign n3070_o = n3066_o & n3069_o;
  /* ascal.vhd:397:39  */
  assign n3071_o = {30'b0, o_obuf1};  //  uext
  /* ascal.vhd:397:39  */
  assign n3073_o = n3071_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:397:47  */
  assign n3074_o = {30'b0, o_ibuf1};  //  uext
  /* ascal.vhd:397:47  */
  assign n3076_o = n3074_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:397:42  */
  assign n3077_o = n3073_o & n3076_o;
  /* ascal.vhd:397:34  */
  assign n3078_o = n3070_o | n3077_o;
  /* ascal.vhd:397:17  */
  assign n3081_o = n3088_o ? 1'b0 : n3054_o;
  /* ascal.vhd:397:17  */
  assign n3084_o = n3090_o ? 31'b0000000000000000000000000000000 : n3057_o;
  /* ascal.vhd:397:17  */
  assign n3085_o = n3078_o & n3054_o;
  /* ascal.vhd:397:17  */
  assign n3087_o = n3078_o & n3054_o;
  /* ascal.vhd:397:17  */
  assign n3088_o = n3054_o & n3085_o;
  /* ascal.vhd:397:17  */
  assign n3090_o = n3054_o & n3087_o;
  /* ascal.vhd:398:17  */
  assign n3096_o = n3081_o ? 31'b0000000000000000000000000000001 : n3084_o;
  /* ascal.vhd:1887:42  */
  assign n3097_o = n3096_o[1:0];  // trunc
  /* ascal.vhd:1886:25  */
  assign n3099_o = n3021_o ? 1'b0 : n2931_o;
  /* ascal.vhd:1886:25  */
  assign n3100_o = n3021_o ? n3097_o : o_obuf1;
  /* ascal.vhd:1886:25  */
  assign n3101_o = n3021_o ? i_hrsize : o_ihsize;
  /* ascal.vhd:1886:25  */
  assign n3102_o = n3021_o ? i_vrsize : o_ivsize;
  /* ascal.vhd:1886:25  */
  assign n3103_o = n3021_o ? i_hdown : o_hdown;
  /* ascal.vhd:1886:25  */
  assign n3104_o = n3021_o ? i_vdown : o_vdown;
  /* ascal.vhd:1896:33  */
  assign n3105_o = o_vsv[10];
  /* ascal.vhd:1896:50  */
  assign n3106_o = o_vsv[11];
  /* ascal.vhd:1896:53  */
  assign n3107_o = ~n3106_o;
  /* ascal.vhd:1896:41  */
  assign n3108_o = n3105_o & n3107_o;
  /* ascal.vhd:1896:58  */
  assign n3109_o = n3108_o & o_iendframe0;
  /* ascal.vhd:1897:67  */
  assign n3110_o = ~o_iendframe02;
  /* ascal.vhd:1897:50  */
  assign n3111_o = n3109_o & n3110_o;
  /* ascal.vhd:1896:25  */
  assign n3113_o = n3111_o ? 1'b0 : n3015_o;
  /* ascal.vhd:1896:25  */
  assign n3114_o = n3111_o ? o_ibuf0 : n3016_o;
  /* ascal.vhd:1901:33  */
  assign n3115_o = o_vsv[10];
  /* ascal.vhd:1901:50  */
  assign n3116_o = o_vsv[11];
  /* ascal.vhd:1901:53  */
  assign n3117_o = ~n3116_o;
  /* ascal.vhd:1901:41  */
  assign n3118_o = n3115_o & n3117_o;
  /* ascal.vhd:1901:58  */
  assign n3119_o = n3118_o & o_iendframe1;
  /* ascal.vhd:1902:67  */
  assign n3120_o = ~o_iendframe12;
  /* ascal.vhd:1902:50  */
  assign n3121_o = n3119_o & n3120_o;
  /* ascal.vhd:1901:25  */
  assign n3123_o = n3121_o ? 1'b0 : n3099_o;
  /* ascal.vhd:1901:25  */
  assign n3124_o = n3121_o ? o_ibuf1 : n3100_o;
  /* ascal.vhd:1908:35  */
  assign n3125_o = ~o_inter;
  /* ascal.vhd:1908:25  */
  assign n3126_o = n3125_o ? o_ibuf0 : n2932_o;
  /* ascal.vhd:1908:25  */
  assign n3127_o = n3125_o ? o_obuf0 : n3124_o;
  /* ascal.vhd:1914:34  */
  assign n3128_o = o_mode[3];
  /* ascal.vhd:1914:37  */
  assign n3129_o = ~n3128_o;
  /* ascal.vhd:1914:25  */
  assign n3131_o = n3129_o ? 2'b00 : n2849_o;
  /* ascal.vhd:1914:25  */
  assign n3133_o = n3129_o ? 2'b00 : n3126_o;
  /* ascal.vhd:1914:25  */
  assign n3135_o = n3129_o ? 2'b00 : n3114_o;
  /* ascal.vhd:1914:25  */
  assign n3137_o = n3129_o ? 2'b00 : n3127_o;
  /* ascal.vhd:1922:25  */
  assign n3138_o = o_fb_ena ? o_fb_format : n2752_o;
  /* ascal.vhd:1922:25  */
  assign n3139_o = o_fb_ena ? o_fb_hsize : n3101_o;
  /* ascal.vhd:1922:25  */
  assign n3140_o = o_fb_ena ? o_fb_vsize : n3102_o;
  /* ascal.vhd:1922:25  */
  assign n3142_o = o_fb_ena ? 1'b0 : n3103_o;
  /* ascal.vhd:1922:25  */
  assign n3144_o = o_fb_ena ? 1'b0 : n3104_o;
  /* ascal.vhd:1931:38  */
  assign n3145_o = o_format[2:0];
  /* ascal.vhd:1932:64  */
  assign n3146_o = {3'b0, o_ihsize};  //  uext
  /* ascal.vhd:1932:33  */
  assign n3148_o = n3145_o == 3'b011;
  /* ascal.vhd:1933:73  */
  assign n3149_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:1933:73  */
  assign n3151_o = n3149_o * 32'b00000000000000000000000000000010; // smul
  /* ascal.vhd:1933:64  */
  assign n3152_o = n3151_o[14:0];  // trunc
  /* ascal.vhd:1933:33  */
  assign n3154_o = n3145_o == 3'b100;
  /* ascal.vhd:1934:73  */
  assign n3155_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:1934:73  */
  assign n3157_o = n3155_o * 32'b00000000000000000000000000000100; // smul
  /* ascal.vhd:1934:64  */
  assign n3158_o = n3157_o[14:0];  // trunc
  /* ascal.vhd:1934:33  */
  assign n3160_o = n3145_o == 3'b110;
  /* ascal.vhd:1935:74  */
  assign n3161_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:1935:74  */
  assign n3163_o = n3161_o * 32'b00000000000000000000000000000011; // smul
  /* ascal.vhd:1935:65  */
  assign n3164_o = n3163_o[14:0];  // trunc
  assign n3165_o = {n3160_o, n3154_o, n3148_o};
  /* ascal.vhd:1931:25  */
  always @*
    case (n3165_o)
      3'b100: n3166_o <= n3158_o;
      3'b010: n3166_o <= n3152_o;
      3'b001: n3166_o <= n3146_o;
    endcase
  /* ascal.vhd:1938:58  */
  assign n3167_o = {17'b0, o_ihsize_temp};  //  uext
  /* ascal.vhd:1938:58  */
  assign n3169_o = n3167_o + 32'b00000000000000000000000100000000;
  /* ascal.vhd:1938:68  */
  assign n3171_o = n3169_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:1938:43  */
  assign n3172_o = n3171_o[14:0];  // trunc
  /* ascal.vhd:1939:52  */
  assign n3173_o = {17'b0, o_ihsize_temp2};  //  uext
  /* ascal.vhd:1939:52  */
  assign n3175_o = n3173_o / 32'b00000000000000000000000100000000; // sdiv
  /* ascal.vhd:1939:37  */
  assign n3176_o = n3175_o[4:0];  // trunc
  /* ascal.vhd:1941:57  */
  assign n3178_o = o_fb_stride != 14'b00000000000000;
  /* ascal.vhd:1941:41  */
  assign n3179_o = o_fb_ena & n3178_o;
  /* ascal.vhd:1944:43  */
  assign n3181_o = o_ihsize_temp2[13:0];  // trunc
  assign n3183_o = n3181_o[13:8];
  assign n3184_o = {n3183_o, 8'b00000000};
  /* ascal.vhd:1941:25  */
  assign n3185_o = n3179_o ? o_fb_stride : n3184_o;
  /* ascal.vhd:1949:40  */
  assign n3187_o = o_hdown & 1'b1;
  assign n3189_o = o_mode[2:0];
  /* ascal.vhd:1949:25  */
  assign n3190_o = n3187_o ? 3'b000 : n3189_o;
  assign n3191_o = o_mode[4:3];
  /* ascal.vhd:1955:40  */
  assign n3193_o = o_vdown & 1'b1;
  assign n3195_o = o_mode[2:0];
  /* ascal.vhd:1955:25  */
  assign n3196_o = n3193_o ? 3'b000 : n3195_o;
  assign n3197_o = o_mode[4:3];
  /* ascal.vhd:1964:51  */
  assign n3198_o = o_readack_sync ^ o_readack_sync2;
  /* ascal.vhd:1968:59  */
  assign n3199_o = o_readdataack_sync ^ o_readdataack_sync2;
  /* ascal.vhd:1978:33  */
  assign n3200_o = o_hsv[11];
  /* ascal.vhd:1978:50  */
  assign n3201_o = o_hsv[10];
  /* ascal.vhd:1978:53  */
  assign n3202_o = ~n3201_o;
  /* ascal.vhd:1978:41  */
  assign n3203_o = n3200_o & n3202_o;
  /* ascal.vhd:1979:47  */
  assign n3204_o = {20'b0, o_vcpt_pre3};  //  uext
  /* ascal.vhd:1979:47  */
  assign n3205_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:1979:47  */
  assign n3206_o = n3204_o == n3205_o;
  /* ascal.vhd:1978:25  */
  assign n3208_o = n3213_o ? 2'b10 : o_fload;
  /* ascal.vhd:1978:25  */
  assign n3210_o = n3214_o ? 1'b0 : o_bibu;
  /* ascal.vhd:1978:25  */
  assign n3212_o = n3203_o ? 1'b1 : o_hsp;
  /* ascal.vhd:1978:25  */
  assign n3213_o = n3203_o & n3206_o;
  /* ascal.vhd:1978:25  */
  assign n3214_o = n3203_o & n3206_o;
  /* ascal.vhd:1986:55  */
  assign n3216_o = {20'b0, o_vcpt_pre};  //  uext
  /* ascal.vhd:1986:55  */
  assign n3217_o = {20'b0, o_vmax};  //  uext
  /* ascal.vhd:1986:55  */
  assign n3218_o = $signed(n3216_o) < $signed(n3217_o);
  /* ascal.vhd:1986:77  */
  assign n3219_o = {20'b0, o_vcpt_pre};  //  uext
  /* ascal.vhd:1986:77  */
  assign n3220_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:1986:77  */
  assign n3221_o = $signed(n3219_o) >= $signed(n3220_o);
  /* ascal.vhd:1986:63  */
  assign n3222_o = n3218_o & n3221_o;
  /* ascal.vhd:285:17  */
  assign n3229_o = n3222_o ? 1'b1 : 1'b0;
  /* ascal.vhd:1991:46  */
  assign n3230_o = {20'b0, o_vsize};  //  uext
  /* ascal.vhd:1991:46  */
  assign n3231_o = {20'b0, o_ivsize};  //  uext
  /* ascal.vhd:1991:46  */
  assign n3232_o = n3230_o - n3231_o;
  /* ascal.vhd:1991:57  */
  assign n3234_o = n3232_o + 32'b00000000000000000010000000000000;
  assign n3235_o = n3234_o[12:0];
  /* ascal.vhd:1992:46  */
  assign n3237_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:1992:46  */
  assign n3238_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:1992:46  */
  assign n3239_o = n3237_o + n3238_o;
  /* ascal.vhd:1992:57  */
  assign n3241_o = n3239_o + 32'b00000000000000000010000000000000;
  assign n3242_o = n3241_o[12:0];
  /* ascal.vhd:2001:41  */
  assign n3245_o = o_hsp ? 2'b01 : o_state;
  /* ascal.vhd:2001:41  */
  assign n3247_o = o_hsp ? 1'b0 : n3212_o;
  /* ascal.vhd:2000:33  */
  assign n3249_o = o_state == 2'b00;
  /* ascal.vhd:2010:62  */
  assign n3250_o = {19'b0, o_vacc_next};  //  uext
  /* ascal.vhd:2010:65  */
  assign n3251_o = {20'b0, o_vsize};  //  uext
  /* ascal.vhd:2010:65  */
  assign n3253_o = 32'b00000000000000000000000000000010 * n3251_o; // smul
  /* ascal.vhd:2010:62  */
  assign n3254_o = n3250_o - n3253_o;
  /* ascal.vhd:2010:74  */
  assign n3256_o = n3254_o + 32'b00000000000000000100000000000000;
  assign n3257_o = n3256_o[13:0];
  /* ascal.vhd:2012:57  */
  assign n3259_o = {18'b0, n3257_o};  //  uext
  /* ascal.vhd:2012:57  */
  assign n3261_o = $signed(n3259_o) >= $signed(32'b00000000000000000010000000000000);
  /* ascal.vhd:2015:70  */
  assign n3262_o = n3257_o[12:0];  // trunc
  /* ascal.vhd:2012:49  */
  assign n3263_o = n3261_o ? o_vacc_next : n3262_o;
  /* ascal.vhd:2011:41  */
  assign n3264_o = o_prim ? n3263_o : o_vacc;
  /* ascal.vhd:2018:49  */
  assign n3265_o = {18'b0, n3257_o};  //  uext
  /* ascal.vhd:2018:49  */
  assign n3267_o = $signed(n3265_o) >= $signed(32'b00000000000000000010000000000000);
  /* ascal.vhd:2019:75  */
  assign n3268_o = {19'b0, o_vacc_next};  //  uext
  /* ascal.vhd:2019:78  */
  assign n3269_o = {20'b0, o_ivsize};  //  uext
  /* ascal.vhd:2019:78  */
  assign n3271_o = 32'b00000000000000000000000000000010 * n3269_o; // smul
  /* ascal.vhd:2019:75  */
  assign n3272_o = n3268_o + n3271_o;
  assign n3273_o = n3272_o[12:0];
  /* ascal.vhd:2022:62  */
  assign n3275_o = n3257_o[12:0];  // trunc
  /* ascal.vhd:2018:41  */
  assign n3276_o = n3267_o ? n3273_o : n3275_o;
  /* ascal.vhd:2018:41  */
  assign n3279_o = n3267_o ? 1'b0 : 1'b1;
  /* ascal.vhd:2026:55  */
  assign n3280_o = {20'b0, o_vcpt_pre2};  //  uext
  /* ascal.vhd:2026:55  */
  assign n3281_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:2026:55  */
  assign n3282_o = n3280_o == n3281_o;
  /* ascal.vhd:2028:73  */
  assign n3283_o = {19'b0, o_vacc_ini};  //  uext
  /* ascal.vhd:2028:76  */
  assign n3284_o = {20'b0, o_ivsize};  //  uext
  /* ascal.vhd:2028:76  */
  assign n3286_o = 32'b00000000000000000000000000000010 * n3284_o; // smul
  /* ascal.vhd:2028:73  */
  assign n3287_o = n3283_o + n3286_o;
  /* ascal.vhd:2028:62  */
  assign n3288_o = n3287_o[12:0];  // trunc
  /* ascal.vhd:2026:41  */
  assign n3289_o = n3282_o ? o_vacc_ini : n3264_o;
  /* ascal.vhd:2026:41  */
  assign n3290_o = n3282_o ? n3288_o : n3276_o;
  /* ascal.vhd:2026:41  */
  assign n3292_o = n3282_o ? 12'b000000000001 : o_vacpt;
  /* ascal.vhd:2026:41  */
  assign n3294_o = n3282_o ? 2'b01 : o_vacptl;
  /* ascal.vhd:2026:41  */
  assign n3296_o = n3282_o ? 1'b0 : n3279_o;
  /* ascal.vhd:2035:65  */
  assign n3298_o = o_vacpt + 12'b000000000001;
  /* ascal.vhd:2034:41  */
  assign n3299_o = n3296_o ? n3298_o : n3292_o;
  /* ascal.vhd:2037:53  */
  assign n3300_o = n3296_o & o_prim;
  /* ascal.vhd:2038:67  */
  assign n3302_o = o_vacptl + 2'b01;
  /* ascal.vhd:2037:41  */
  assign n3303_o = n3300_o ? n3302_o : n3294_o;
  /* ascal.vhd:2040:64  */
  assign n3304_o = o_vcarrym | n3296_o;
  /* ascal.vhd:2043:66  */
  assign n3306_o = ~n3296_o;
  /* ascal.vhd:285:17  */
  assign n3313_o = n3306_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2044:44  */
  assign n3314_o = ~n3296_o;
  /* ascal.vhd:2044:68  */
  assign n3315_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2044:68  */
  assign n3317_o = $signed(n3315_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:2044:58  */
  assign n3318_o = n3314_o | n3317_o;
  /* ascal.vhd:2045:63  */
  assign n3319_o = o_vpe & o_vcarrym;
  /* ascal.vhd:2045:88  */
  assign n3320_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2045:88  */
  assign n3322_o = $signed(n3320_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:2045:78  */
  assign n3323_o = n3319_o | n3322_o;
  /* ascal.vhd:2045:49  */
  assign n3326_o = n3323_o ? 2'b10 : 2'b00;
  /* ascal.vhd:2044:41  */
  assign n3327_o = n3318_o ? n3326_o : o_state;
  /* ascal.vhd:2009:33  */
  assign n3329_o = o_state == 2'b01;
  /* ascal.vhd:2054:53  */
  assign n3330_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2054:53  */
  assign n3332_o = $signed(n3330_o) < $signed(32'b00000000000000000000000000000010);
  /* ascal.vhd:2054:56  */
  assign n3333_o = n3332_o & o_adrsb;
  /* ascal.vhd:2056:61  */
  assign n3334_o = ~o_read_pre;
  /* ascal.vhd:2058:57  */
  assign n3335_o = ~o_bibu;
  /* ascal.vhd:2054:41  */
  assign n3337_o = n3333_o ? 2'b11 : o_state;
  /* ascal.vhd:2054:41  */
  assign n3338_o = n3333_o ? n3334_o : o_read_pre;
  /* ascal.vhd:2054:41  */
  assign n3339_o = n3333_o ? n3335_o : n3210_o;
  /* ascal.vhd:2054:41  */
  assign n3342_o = n3333_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2060:69  */
  assign n3344_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2060:69  */
  assign n3346_o = n3344_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:285:17  */
  assign n3353_o = n3346_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2061:69  */
  assign n3355_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2061:78  */
  assign n3356_o = {27'b0, o_hburst};  //  uext
  /* ascal.vhd:2061:78  */
  assign n3358_o = n3356_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2061:69  */
  assign n3359_o = n3355_o == n3358_o;
  /* ascal.vhd:285:17  */
  assign n3366_o = n3359_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2063:77  */
  assign n3368_o = o_fb_base[3:0];
  /* ascal.vhd:2063:66  */
  assign n3369_o = {28'b0, n3368_o};  //  uext
  /* ascal.vhd:2063:66  */
  assign n3370_o = o_adrs + n3369_o;
  /* ascal.vhd:677:28  */
  assign n3375_o = o_fb_format[2:0];
  /* ascal.vhd:679:55  */
  assign n3376_o = n3370_o[3:0];
  /* ascal.vhd:679:40  */
  assign n3377_o = {27'b0, n3376_o};  //  uext
  /* ascal.vhd:678:25  */
  assign n3379_o = n3375_o == 3'b011;
  /* ascal.vhd:681:55  */
  assign n3380_o = n3370_o[3:1];
  /* ascal.vhd:681:40  */
  assign n3381_o = {28'b0, n3380_o};  //  uext
  /* ascal.vhd:680:25  */
  assign n3383_o = n3375_o == 3'b100;
  /* ascal.vhd:683:55  */
  assign n3384_o = n3370_o[3:2];
  /* ascal.vhd:683:40  */
  assign n3385_o = {29'b0, n3384_o};  //  uext
  assign n3386_o = {n3383_o, n3379_o};
  /* ascal.vhd:677:17  */
  always @*
    case (n3386_o)
      2'b10: n3387_o <= n3381_o;
      2'b01: n3387_o <= n3377_o;
    endcase
  /* ascal.vhd:2063:41  */
  assign n3388_o = n3387_o[3:0];  // trunc
  /* ascal.vhd:2064:52  */
  assign n3389_o = ~o_fb_ena;
  /* ascal.vhd:2064:41  */
  assign n3391_o = n3389_o ? 4'b0000 : n3388_o;
  /* ascal.vhd:2052:33  */
  assign n3393_o = o_state == 2'b10;
  /* ascal.vhd:2071:65  */
  assign n3394_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2071:65  */
  assign n3396_o = n3394_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2071:58  */
  assign n3397_o = n3396_o[4:0];  // trunc
  /* ascal.vhd:2072:59  */
  assign n3398_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2072:68  */
  assign n3399_o = {27'b0, o_hburst};  //  uext
  /* ascal.vhd:2072:68  */
  assign n3401_o = n3399_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2072:59  */
  assign n3402_o = $signed(n3398_o) < $signed(n3401_o);
  /* ascal.vhd:2077:67  */
  assign n3403_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2077:67  */
  assign n3405_o = $signed(n3403_o) >= $signed(32'b00000000000000000000000000000001);
  /* ascal.vhd:2078:81  */
  assign n3406_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2078:81  */
  assign n3408_o = n3406_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2078:74  */
  assign n3409_o = n3408_o[1:0];  // trunc
  /* ascal.vhd:2077:57  */
  assign n3410_o = n3405_o ? n3409_o : n3208_o;
  /* ascal.vhd:2072:49  */
  assign n3413_o = n3402_o ? 2'b10 : 2'b00;
  /* ascal.vhd:2072:49  */
  assign n3414_o = n3402_o ? n3208_o : n3410_o;
  /* ascal.vhd:2070:41  */
  assign n3415_o = o_readack ? n3413_o : o_state;
  /* ascal.vhd:2070:41  */
  assign n3416_o = o_readack ? n3397_o : o_hbcpt;
  /* ascal.vhd:2070:41  */
  assign n3417_o = o_readack ? n3414_o : n3208_o;
  /* ascal.vhd:2069:33  */
  assign n3419_o = o_state == 2'b11;
  assign n3420_o = {n3419_o, n3393_o, n3329_o, n3249_o};
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3422_o <= n3415_o;
      4'b0100: n3422_o <= n3337_o;
      4'b0010: n3422_o <= n3327_o;
      4'b0001: n3422_o <= n3245_o;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3426_o <= 1'b0;
      4'b0100: n3426_o <= 1'b1;
      4'b0010: n3426_o <= 1'b0;
      4'b0001: n3426_o <= 1'b0;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3429_o <= o_vacc;
      4'b0100: n3429_o <= o_vacc;
      4'b0010: n3429_o <= n3289_o;
      4'b0001: n3429_o <= o_vacc;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3431_o <= o_vacc_next;
      4'b0100: n3431_o <= o_vacc_next;
      4'b0010: n3431_o <= n3290_o;
      4'b0001: n3431_o <= o_vacc_next;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3433_o <= n3212_o;
      4'b0100: n3433_o <= n3212_o;
      4'b0010: n3433_o <= n3212_o;
      4'b0001: n3433_o <= n3247_o;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3436_o <= o_vcarrym;
      4'b0100: n3436_o <= o_vcarrym;
      4'b0010: n3436_o <= n3304_o;
      4'b0001: n3436_o <= 1'b0;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3440_o <= o_prim;
      4'b0100: n3440_o <= o_prim;
      4'b0010: n3440_o <= 1'b0;
      4'b0001: n3440_o <= 1'b1;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3442_o <= o_read_pre;
      4'b0100: n3442_o <= n3338_o;
      4'b0010: n3442_o <= o_read_pre;
      4'b0001: n3442_o <= o_read_pre;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3445_o <= n3416_o;
      4'b0100: n3445_o <= o_hbcpt;
      4'b0010: n3445_o <= 5'b00000;
      4'b0001: n3445_o <= o_hbcpt;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3447_o <= n3417_o;
      4'b0100: n3447_o <= n3208_o;
      4'b0010: n3447_o <= n3208_o;
      4'b0001: n3447_o <= n3208_o;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3449_o <= n3210_o;
      4'b0100: n3449_o <= n3339_o;
      4'b0010: n3449_o <= n3210_o;
      4'b0001: n3449_o <= n3210_o;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3452_o <= 1'b0;
      4'b0100: n3452_o <= 1'b0;
      4'b0010: n3452_o <= n3313_o;
      4'b0001: n3452_o <= 1'b0;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3455_o <= o_vacpt;
      4'b0100: n3455_o <= o_vacpt;
      4'b0010: n3455_o <= n3299_o;
      4'b0001: n3455_o <= o_vacpt;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3457_o <= o_vacptl;
      4'b0100: n3457_o <= o_vacptl;
      4'b0010: n3457_o <= n3303_o;
      4'b0001: n3457_o <= o_vacptl;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3460_o <= 1'b0;
      4'b0100: n3460_o <= n3342_o;
      4'b0010: n3460_o <= 1'b0;
      4'b0001: n3460_o <= 1'b0;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3463_o <= scalaire_prim_v;
      4'b0100: n3463_o <= n3353_o;
      4'b0010: n3463_o <= scalaire_prim_v;
      4'b0001: n3463_o <= scalaire_prim_v;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3465_o <= scalaire_last_v;
      4'b0100: n3465_o <= n3366_o;
      4'b0010: n3465_o <= scalaire_last_v;
      4'b0001: n3465_o <= scalaire_last_v;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3467_o <= scalaire_bib_v;
      4'b0100: n3467_o <= o_bibu;
      4'b0010: n3467_o <= scalaire_bib_v;
      4'b0001: n3467_o <= scalaire_bib_v;
    endcase
  /* ascal.vhd:1998:25  */
  always @*
    case (n3420_o)
      4'b1000: n3473_o <= scalaire_off_v;
      4'b0100: n3473_o <= n3391_o;
      4'b0010: n3473_o <= scalaire_off_v;
      4'b0001: n3473_o <= scalaire_off_v;
    endcase
  /* ascal.vhd:2086:44  */
  assign n3474_o = o_read_pre & o_run;
  /* ascal.vhd:2087:41  */
  assign n3475_o = o_vacpt[0];
  /* ascal.vhd:2089:37  */
  assign n3476_o = {19'b0, o_vacpt};  //  uext
  /* ascal.vhd:2089:57  */
  assign n3477_o = {1'b0, n3476_o};  //  uext
  /* ascal.vhd:2089:59  */
  assign n3478_o = {17'b0, o_stride};  //  uext
  /* ascal.vhd:2089:57  */
  assign n3479_o = {1'b0, n3478_o};  //  uext
  /* ascal.vhd:2089:57  */
  assign n3480_o = n3477_o * n3479_o; // smul
  /* ascal.vhd:2089:37  */
  assign n3481_o = n3480_o[23:0];  // trunc
  /* ascal.vhd:2091:43  */
  assign n3482_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2091:43  */
  assign n3484_o = n3482_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:2092:69  */
  assign n3485_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2092:69  */
  assign n3487_o = n3485_o * 32'b00000000000000000000000100000000; // smul
  /* ascal.vhd:2092:61  */
  assign n3488_o = n3487_o[30:0];  // trunc
  /* ascal.vhd:2092:49  */
  assign n3489_o = {1'b0, n3488_o};  //  uext
  /* ascal.vhd:2094:46  */
  assign n3490_o = {30'b0, o_fload};  //  uext
  /* ascal.vhd:2094:46  */
  assign n3492_o = n3490_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:2095:69  */
  assign n3493_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2095:69  */
  assign n3495_o = n3493_o * 32'b00000000000000000000000100000000; // smul
  /* ascal.vhd:2095:61  */
  assign n3496_o = n3495_o[30:0];  // trunc
  /* ascal.vhd:2095:49  */
  assign n3497_o = {1'b0, n3496_o};  //  uext
  /* ascal.vhd:2095:83  */
  assign n3498_o = {18'b0, o_stride};  //  uext
  /* ascal.vhd:2095:83  */
  assign n3499_o = n3497_o + n3498_o;
  /* ascal.vhd:2098:72  */
  assign n3500_o = {8'b0, o_adrs_pre};  //  uext
  /* ascal.vhd:2098:83  */
  assign n3501_o = {27'b0, o_hbcpt};  //  uext
  /* ascal.vhd:2098:83  */
  assign n3503_o = n3501_o * 32'b00000000000000000000000100000000; // smul
  /* ascal.vhd:2098:72  */
  assign n3504_o = n3500_o + n3503_o;
  /* ascal.vhd:2098:61  */
  assign n3505_o = n3504_o[30:0];  // trunc
  /* ascal.vhd:2098:49  */
  assign n3506_o = {1'b0, n3505_o};  //  uext
  /* ascal.vhd:2099:62  */
  assign n3509_o = o_vacptl + 2'b01;
  /* ascal.vhd:704:25  */
  assign n3516_o = n3509_o == 2'b00;
  /* ascal.vhd:705:25  */
  assign n3519_o = n3509_o == 2'b01;
  /* ascal.vhd:706:25  */
  assign n3522_o = n3509_o == 2'b10;
  assign n3524_o = {n3522_o, n3519_o, n3516_o};
  /* ascal.vhd:703:17  */
  always @*
    case (n3524_o)
      3'b100: n3525_o <= 4'b0100;
      3'b010: n3525_o <= 4'b0010;
      3'b001: n3525_o <= 4'b0001;
    endcase
  /* ascal.vhd:2094:33  */
  assign n3526_o = n3492_o ? n3499_o : n3506_o;
  /* ascal.vhd:2094:33  */
  assign n3528_o = n3492_o ? 4'b0100 : n3525_o;
  /* ascal.vhd:2091:33  */
  assign n3529_o = n3484_o ? n3489_o : n3526_o;
  /* ascal.vhd:2091:33  */
  assign n3531_o = n3484_o ? 4'b1111 : n3528_o;
  /* ascal.vhd:2109:53  */
  assign n3535_o = {30'b0, o_copylev};  //  uext
  /* ascal.vhd:2109:53  */
  assign n3537_o = $signed(n3535_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:2109:67  */
  assign n3538_o = o_copyv[14];
  /* ascal.vhd:2109:70  */
  assign n3539_o = ~n3538_o;
  /* ascal.vhd:2109:56  */
  assign n3540_o = n3537_o & n3539_o;
  /* ascal.vhd:2111:57  */
  assign n3541_o = o_off[11:8];
  /* ascal.vhd:2111:60  */
  assign n3542_o = {28'b0, n3541_o};  //  uext
  /* ascal.vhd:2111:60  */
  assign n3544_o = $signed(n3542_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:2111:74  */
  assign n3545_o = o_primv[2];
  /* ascal.vhd:2111:63  */
  assign n3546_o = n3544_o & n3545_o;
  /* ascal.vhd:2111:49  */
  assign n3549_o = n3546_o ? 2'b01 : 2'b10;
  /* ascal.vhd:2109:41  */
  assign n3551_o = n3540_o ? n3549_o : o_copy;
  /* ascal.vhd:2109:41  */
  assign n3552_o = n3540_o ? o_alt : o_altx;
  /* ascal.vhd:2117:56  */
  assign n3553_o = o_off[11:8];
  /* ascal.vhd:2117:60  */
  assign n3554_o = {28'b0, n3553_o};  //  uext
  /* ascal.vhd:2117:60  */
  assign n3556_o = n3554_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2117:51  */
  assign n3557_o = n3556_o[3:0];  // trunc
  /* ascal.vhd:2118:51  */
  assign n3558_o = o_primv[2];
  /* ascal.vhd:2120:69  */
  assign n3559_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:2120:76  */
  assign n3560_o = o_off[11:8];
  /* ascal.vhd:2120:69  */
  assign n3561_o = {28'b0, n3560_o};  //  uext
  /* ascal.vhd:2120:69  */
  assign n3562_o = n3559_o + n3561_o;
  /* ascal.vhd:2120:80  */
  assign n3564_o = n3562_o - 32'b00000000000000000000000000000010;
  /* ascal.vhd:2120:60  */
  assign n3565_o = n3564_o[11:0];  // trunc
  /* ascal.vhd:2122:73  */
  assign n3566_o = {19'b0, o_hacc_ini};  //  uext
  /* ascal.vhd:2122:76  */
  assign n3567_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:2122:76  */
  assign n3569_o = 32'b00000000000000000000000000000010 * n3567_o; // smul
  /* ascal.vhd:2122:73  */
  assign n3570_o = n3566_o + n3569_o;
  /* ascal.vhd:2122:62  */
  assign n3571_o = n3570_o[12:0];  // trunc
  /* ascal.vhd:2118:41  */
  assign n3572_o = n3558_o ? n3565_o : o_ihsizem;
  /* ascal.vhd:2118:41  */
  assign n3573_o = n3558_o ? o_hacc_ini : o_hacc;
  /* ascal.vhd:2118:41  */
  assign n3574_o = n3558_o ? n3571_o : o_hacc_next;
  /* ascal.vhd:2118:41  */
  assign n3576_o = n3558_o ? 4'b0000 : o_acpt;
  /* ascal.vhd:2118:41  */
  assign n3578_o = n3558_o ? 2'b10 : o_dshi;
  /* ascal.vhd:2118:41  */
  assign n3580_o = n3558_o ? 1'b1 : o_first;
  /* ascal.vhd:2118:41  */
  assign n3582_o = n3558_o ? 1'b0 : o_last;
  /* ascal.vhd:2118:41  */
  assign n3584_o = n3558_o ? 12'b000000000000 : o_dcpt;
  /* ascal.vhd:2118:41  */
  assign n3586_o = n3558_o ? 12'b000000000000 : o_hacpt;
  /* ascal.vhd:2131:50  */
  assign n3587_o = o_bibv[2];
  /* ascal.vhd:2131:53  */
  assign n3588_o = ~n3587_o;
  /* ascal.vhd:2131:41  */
  assign n3591_o = n3588_o ? 5'b00000 : 5'b10000;
  /* ascal.vhd:2107:33  */
  assign n3593_o = o_copy == 2'b00;
  /* ascal.vhd:2138:57  */
  assign n3595_o = o_hacpt + 12'b000000000001;
  /* ascal.vhd:2140:56  */
  assign n3596_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:2140:56  */
  assign n3598_o = n3596_o + 32'b00000000000000000000000000000001;
  assign n3599_o = n3598_o[3:0];
  /* ascal.vhd:637:28  */
  assign n3606_o = o_format[2:0];
  /* ascal.vhd:639:58  */
  assign n3607_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:639:58  */
  assign n3609_o = n3607_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:639:50  */
  assign n3611_o = 1'b1 & n3609_o;
  /* ascal.vhd:639:62  */
  assign n3613_o = n3611_o | 1'b0;
  /* ascal.vhd:638:25  */
  assign n3615_o = n3606_o == 3'b011;
  /* ascal.vhd:642:61  */
  assign n3616_o = {28'b0, o_acpt};  //  uext
  assign n3617_o = n3616_o[2:0];
  /* ascal.vhd:642:61  */
  assign n3618_o = {29'b0, n3617_o};  //  uext
  /* ascal.vhd:642:67  */
  assign n3620_o = n3618_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:642:50  */
  assign n3622_o = 1'b1 & n3620_o;
  /* ascal.vhd:642:72  */
  assign n3624_o = n3622_o | 1'b0;
  /* ascal.vhd:641:25  */
  assign n3626_o = n3606_o == 3'b100;
  /* ascal.vhd:645:59  */
  assign n3627_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:59  */
  assign n3629_o = n3627_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:645:69  */
  assign n3630_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:69  */
  assign n3632_o = n3630_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:645:62  */
  assign n3633_o = n3629_o | n3632_o;
  /* ascal.vhd:645:79  */
  assign n3634_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:79  */
  assign n3636_o = n3634_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:645:72  */
  assign n3637_o = n3633_o | n3636_o;
  /* ascal.vhd:645:50  */
  assign n3639_o = 1'b1 & n3637_o;
  /* ascal.vhd:645:85  */
  assign n3641_o = n3639_o | 1'b0;
  /* ascal.vhd:644:25  */
  assign n3643_o = n3606_o == 3'b101;
  /* ascal.vhd:648:61  */
  assign n3644_o = {28'b0, o_acpt};  //  uext
  assign n3645_o = n3644_o[1:0];
  /* ascal.vhd:648:61  */
  assign n3646_o = {30'b0, n3645_o};  //  uext
  /* ascal.vhd:648:67  */
  assign n3648_o = n3646_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:648:50  */
  assign n3650_o = 1'b1 & n3648_o;
  /* ascal.vhd:648:72  */
  assign n3652_o = n3650_o | 1'b0;
  assign n3653_o = {n3643_o, n3626_o, n3615_o};
  /* ascal.vhd:637:17  */
  always @*
    case (n3653_o)
      3'b100: n3654_o <= n3641_o;
      3'b010: n3654_o <= n3624_o;
      3'b001: n3654_o <= n3613_o;
    endcase
  /* ascal.vhd:2142:60  */
  assign n3655_o = {27'b0, o_ad};  //  uext
  /* ascal.vhd:2142:60  */
  assign n3657_o = n3655_o + 32'b00000000000000000000000000000001;
  assign n3658_o = n3657_o[4:0];
  /* ascal.vhd:2141:41  */
  assign n3660_o = n3654_o ? n3658_o : o_ad;
  /* ascal.vhd:2144:59  */
  assign n3661_o = {28'b0, o_pshift};  //  uext
  /* ascal.vhd:2144:59  */
  assign n3663_o = n3661_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2144:51  */
  assign n3664_o = n3663_o[3:0];  // trunc
  /* ascal.vhd:2145:52  */
  assign n3665_o = {28'b0, o_pshift};  //  uext
  /* ascal.vhd:2145:52  */
  assign n3667_o = n3665_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:2145:41  */
  assign n3669_o = n3667_o ? 2'b10 : o_copy;
  /* ascal.vhd:2137:33  */
  assign n3671_o = o_copy == 2'b01;
  /* ascal.vhd:2151:50  */
  assign n3672_o = {30'b0, o_dshi};  //  uext
  /* ascal.vhd:2151:50  */
  assign n3674_o = n3672_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:2152:69  */
  assign n3675_o = {19'b0, o_hacc_next};  //  uext
  /* ascal.vhd:2152:72  */
  assign n3676_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2152:72  */
  assign n3678_o = 32'b00000000000000000000000000000010 * n3676_o; // smul
  /* ascal.vhd:2152:69  */
  assign n3679_o = n3675_o - n3678_o;
  /* ascal.vhd:2152:81  */
  assign n3681_o = n3679_o + 32'b00000000000000000100000000000000;
  assign n3682_o = n3681_o[13:0];
  /* ascal.vhd:2153:57  */
  assign n3684_o = {18'b0, n3682_o};  //  uext
  /* ascal.vhd:2153:57  */
  assign n3686_o = $signed(n3684_o) >= $signed(32'b00000000000000000010000000000000);
  /* ascal.vhd:2155:82  */
  assign n3687_o = {19'b0, o_hacc_next};  //  uext
  /* ascal.vhd:2155:85  */
  assign n3688_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:2155:85  */
  assign n3690_o = 32'b00000000000000000000000000000010 * n3688_o; // smul
  /* ascal.vhd:2155:82  */
  assign n3691_o = n3687_o + n3690_o;
  /* ascal.vhd:2155:70  */
  assign n3692_o = n3691_o[12:0];  // trunc
  /* ascal.vhd:2158:65  */
  assign n3693_o = n3682_o[12:0];  // trunc
  /* ascal.vhd:2159:77  */
  assign n3694_o = {18'b0, n3682_o};  //  uext
  /* ascal.vhd:2159:80  */
  assign n3695_o = {20'b0, o_ihsize};  //  uext
  /* ascal.vhd:2159:80  */
  assign n3697_o = 32'b00000000000000000000000000000010 * n3695_o; // smul
  /* ascal.vhd:2159:77  */
  assign n3698_o = n3694_o + n3697_o;
  /* ascal.vhd:2159:90  */
  assign n3700_o = n3698_o + 32'b00000000000000000010000000000000;
  assign n3701_o = n3700_o[12:0];
  /* ascal.vhd:2153:49  */
  assign n3703_o = n3686_o ? o_hacc_next : n3693_o;
  /* ascal.vhd:2153:49  */
  assign n3704_o = n3686_o ? n3692_o : n3701_o;
  /* ascal.vhd:2153:49  */
  assign n3707_o = n3686_o ? 1'b0 : 1'b1;
  /* ascal.vhd:2162:64  */
  assign n3708_o = {20'b0, o_dcpt};  //  uext
  /* ascal.vhd:2162:64  */
  assign n3710_o = n3708_o + 32'b00000000000000000000000000000001;
  assign n3711_o = n3710_o[11:0];
  /* ascal.vhd:2164:63  */
  assign n3713_o = {30'b0, o_dshi};  //  uext
  /* ascal.vhd:2164:63  */
  assign n3715_o = n3713_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2164:57  */
  assign n3716_o = n3715_o[1:0];  // trunc
  /* ascal.vhd:2151:41  */
  assign n3717_o = n3674_o ? n3703_o : o_hacc;
  /* ascal.vhd:2151:41  */
  assign n3718_o = n3674_o ? n3704_o : o_hacc_next;
  /* ascal.vhd:2151:41  */
  assign n3719_o = n3674_o ? o_dshi : n3716_o;
  /* ascal.vhd:2151:41  */
  assign n3720_o = n3674_o ? n3711_o : o_dcpt;
  /* ascal.vhd:2151:41  */
  assign n3722_o = n3674_o ? n3707_o : 1'b0;
  /* ascal.vhd:2167:50  */
  assign n3724_o = {30'b0, o_dshi};  //  uext
  /* ascal.vhd:2167:50  */
  assign n3726_o = $signed(n3724_o) <= $signed(32'b00000000000000000000000000000001);
  assign n3728_o = o_copyv[14];
  /* ascal.vhd:2167:41  */
  assign n3729_o = n3726_o ? 1'b1 : n3728_o;
  /* ascal.vhd:2171:65  */
  assign n3731_o = o_hacpt + 12'b000000000001;
  /* ascal.vhd:2172:78  */
  assign n3734_o = $unsigned(o_hacpt) >= $unsigned(o_ihsizem);
  /* ascal.vhd:285:17  */
  assign n3741_o = n3734_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2170:41  */
  assign n3742_o = n3722_o ? n3741_o : o_last;
  /* ascal.vhd:2170:41  */
  assign n3743_o = n3722_o ? n3731_o : o_hacpt;
  /* ascal.vhd:2175:62  */
  assign n3744_o = {30'b0, o_dshi};  //  uext
  /* ascal.vhd:2175:62  */
  assign n3746_o = $signed(n3744_o) > $signed(32'b00000000000000000000000000000000);
  /* ascal.vhd:2175:53  */
  assign n3747_o = n3722_o | n3746_o;
  /* ascal.vhd:2177:64  */
  assign n3748_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:2177:64  */
  assign n3750_o = n3748_o + 32'b00000000000000000000000000000001;
  assign n3751_o = n3750_o[3:0];
  /* ascal.vhd:637:28  */
  assign n3758_o = o_format[2:0];
  /* ascal.vhd:639:58  */
  assign n3759_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:639:58  */
  assign n3761_o = n3759_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:639:50  */
  assign n3763_o = 1'b1 & n3761_o;
  /* ascal.vhd:639:62  */
  assign n3765_o = n3763_o | 1'b0;
  /* ascal.vhd:638:25  */
  assign n3767_o = n3758_o == 3'b011;
  /* ascal.vhd:642:61  */
  assign n3768_o = {28'b0, o_acpt};  //  uext
  assign n3769_o = n3768_o[2:0];
  /* ascal.vhd:642:61  */
  assign n3770_o = {29'b0, n3769_o};  //  uext
  /* ascal.vhd:642:67  */
  assign n3772_o = n3770_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:642:50  */
  assign n3774_o = 1'b1 & n3772_o;
  /* ascal.vhd:642:72  */
  assign n3776_o = n3774_o | 1'b0;
  /* ascal.vhd:641:25  */
  assign n3778_o = n3758_o == 3'b100;
  /* ascal.vhd:645:59  */
  assign n3779_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:59  */
  assign n3781_o = n3779_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:645:69  */
  assign n3782_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:69  */
  assign n3784_o = n3782_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:645:62  */
  assign n3785_o = n3781_o | n3784_o;
  /* ascal.vhd:645:79  */
  assign n3786_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:645:79  */
  assign n3788_o = n3786_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:645:72  */
  assign n3789_o = n3785_o | n3788_o;
  /* ascal.vhd:645:50  */
  assign n3791_o = 1'b1 & n3789_o;
  /* ascal.vhd:645:85  */
  assign n3793_o = n3791_o | 1'b0;
  /* ascal.vhd:644:25  */
  assign n3795_o = n3758_o == 3'b101;
  /* ascal.vhd:648:61  */
  assign n3796_o = {28'b0, o_acpt};  //  uext
  assign n3797_o = n3796_o[1:0];
  /* ascal.vhd:648:61  */
  assign n3798_o = {30'b0, n3797_o};  //  uext
  /* ascal.vhd:648:67  */
  assign n3800_o = n3798_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:648:50  */
  assign n3802_o = 1'b1 & n3800_o;
  /* ascal.vhd:648:72  */
  assign n3804_o = n3802_o | 1'b0;
  assign n3805_o = {n3795_o, n3778_o, n3767_o};
  /* ascal.vhd:637:17  */
  always @*
    case (n3805_o)
      3'b100: n3806_o <= n3793_o;
      3'b010: n3806_o <= n3776_o;
      3'b001: n3806_o <= n3765_o;
    endcase
  /* ascal.vhd:2184:68  */
  assign n3807_o = {27'b0, o_ad};  //  uext
  /* ascal.vhd:2184:68  */
  assign n3809_o = n3807_o + 32'b00000000000000000000000000000001;
  assign n3810_o = n3809_o[4:0];
  /* ascal.vhd:2175:41  */
  assign n3812_o = n3896_o ? n3810_o : o_ad;
  /* ascal.vhd:2187:89  */
  assign n3814_o = {28'b0, o_acpt};  //  uext
  /* ascal.vhd:2187:89  */
  assign n3816_o = n3814_o + 32'b00000000000000000000000000000001;
  assign n3817_o = n3816_o[3:0];
  /* ascal.vhd:637:28  */
  assign n3823_o = o_format[2:0];
  /* ascal.vhd:639:58  */
  assign n3824_o = {28'b0, n3817_o};  //  uext
  /* ascal.vhd:639:58  */
  assign n3826_o = n3824_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:639:50  */
  assign n3828_o = 1'b1 & n3826_o;
  /* ascal.vhd:639:62  */
  assign n3830_o = n3828_o | 1'b0;
  /* ascal.vhd:638:25  */
  assign n3832_o = n3823_o == 3'b011;
  /* ascal.vhd:642:61  */
  assign n3833_o = {28'b0, n3817_o};  //  uext
  assign n3834_o = n3833_o[2:0];
  /* ascal.vhd:642:61  */
  assign n3835_o = {29'b0, n3834_o};  //  uext
  /* ascal.vhd:642:67  */
  assign n3837_o = n3835_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:642:50  */
  assign n3839_o = 1'b1 & n3837_o;
  /* ascal.vhd:642:72  */
  assign n3841_o = n3839_o | 1'b0;
  /* ascal.vhd:641:25  */
  assign n3843_o = n3823_o == 3'b100;
  /* ascal.vhd:645:59  */
  assign n3844_o = {28'b0, n3817_o};  //  uext
  /* ascal.vhd:645:59  */
  assign n3846_o = n3844_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:645:69  */
  assign n3847_o = {28'b0, n3817_o};  //  uext
  /* ascal.vhd:645:69  */
  assign n3849_o = n3847_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:645:62  */
  assign n3850_o = n3846_o | n3849_o;
  /* ascal.vhd:645:79  */
  assign n3851_o = {28'b0, n3817_o};  //  uext
  /* ascal.vhd:645:79  */
  assign n3853_o = n3851_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:645:72  */
  assign n3854_o = n3850_o | n3853_o;
  /* ascal.vhd:645:50  */
  assign n3856_o = 1'b1 & n3854_o;
  /* ascal.vhd:645:85  */
  assign n3858_o = n3856_o | 1'b0;
  /* ascal.vhd:644:25  */
  assign n3860_o = n3823_o == 3'b101;
  /* ascal.vhd:648:61  */
  assign n3861_o = {28'b0, n3817_o};  //  uext
  assign n3862_o = n3861_o[1:0];
  /* ascal.vhd:648:61  */
  assign n3863_o = {30'b0, n3862_o};  //  uext
  /* ascal.vhd:648:67  */
  assign n3865_o = n3863_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:648:50  */
  assign n3867_o = 1'b1 & n3865_o;
  /* ascal.vhd:648:72  */
  assign n3869_o = n3867_o | 1'b0;
  assign n3870_o = {n3860_o, n3843_o, n3832_o};
  /* ascal.vhd:637:17  */
  always @*
    case (n3870_o)
      3'b100: n3871_o <= n3858_o;
      3'b010: n3871_o <= n3841_o;
      3'b001: n3871_o <= n3830_o;
    endcase
  /* ascal.vhd:2187:65  */
  assign n3872_o = o_adturn & n3871_o;
  /* ascal.vhd:2188:65  */
  assign n3873_o = {27'b0, o_ad};  //  uext
  assign n3874_o = n3873_o[3:0];
  /* ascal.vhd:2188:65  */
  assign n3875_o = {28'b0, n3874_o};  //  uext
  /* ascal.vhd:2188:73  */
  assign n3877_o = n3875_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:2188:88  */
  assign n3878_o = o_lastv[2];
  /* ascal.vhd:2188:91  */
  assign n3879_o = ~n3878_o;
  /* ascal.vhd:2188:77  */
  assign n3880_o = n3877_o & n3879_o;
  /* ascal.vhd:2188:97  */
  assign n3881_o = n3880_o | o_last2;
  /* ascal.vhd:2187:111  */
  assign n3882_o = n3872_o & n3881_o;
  /* ascal.vhd:2175:41  */
  assign n3884_o = n3895_o ? 2'b00 : o_copy;
  /* ascal.vhd:2187:49  */
  assign n3887_o = n3882_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2193:57  */
  assign n3888_o = {27'b0, o_ad};  //  uext
  assign n3889_o = n3888_o[3:0];
  /* ascal.vhd:2193:57  */
  assign n3890_o = {28'b0, n3889_o};  //  uext
  /* ascal.vhd:2193:65  */
  assign n3892_o = n3890_o == 32'b00000000000000000000000000000100;
  /* ascal.vhd:2175:41  */
  assign n3894_o = n3897_o ? 1'b1 : o_adturn;
  /* ascal.vhd:2175:41  */
  assign n3895_o = n3747_o & n3882_o;
  /* ascal.vhd:2175:41  */
  assign n3896_o = n3747_o & n3806_o;
  /* ascal.vhd:2175:41  */
  assign n3897_o = n3747_o & n3892_o;
  /* ascal.vhd:2175:41  */
  assign n3900_o = n3747_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2175:41  */
  assign n3901_o = n3747_o ? n3751_o : o_acpt;
  /* ascal.vhd:2175:41  */
  assign n3902_o = n3747_o ? o_last : o_last1;
  /* ascal.vhd:2175:41  */
  assign n3903_o = n3747_o ? o_last1 : o_last2;
  /* ascal.vhd:2175:41  */
  assign n3905_o = n3747_o ? n3887_o : 1'b0;
  /* ascal.vhd:2149:33  */
  assign n3907_o = o_copy == 2'b10;
  assign n3908_o = {n3907_o, n3671_o, n3593_o};
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3910_o <= n3884_o;
      3'b010: n3910_o <= n3669_o;
      3'b001: n3910_o <= n3551_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3912_o <= o_pshift;
      3'b010: n3912_o <= n3664_o;
      3'b001: n3912_o <= n3557_o;
    endcase
  assign n3913_o = o_copyv[14];
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3915_o <= n3729_o;
      3'b010: n3915_o <= n3913_o;
      3'b001: n3915_o <= 1'b0;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3917_o <= n3812_o;
      3'b010: n3917_o <= n3660_o;
      3'b001: n3917_o <= n3591_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3920_o <= n3894_o;
      3'b010: n3920_o <= o_adturn;
      3'b001: n3920_o <= 1'b0;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3924_o <= n3900_o;
      3'b010: n3924_o <= 1'b1;
      3'b001: n3924_o <= 1'b0;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3927_o <= o_ihsizem;
      3'b010: n3927_o <= o_ihsizem;
      3'b001: n3927_o <= n3572_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3929_o <= n3717_o;
      3'b010: n3929_o <= o_hacc;
      3'b001: n3929_o <= n3573_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3931_o <= n3718_o;
      3'b010: n3931_o <= o_hacc_next;
      3'b001: n3931_o <= n3574_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3933_o <= n3901_o;
      3'b010: n3933_o <= n3599_o;
      3'b001: n3933_o <= n3576_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3935_o <= n3719_o;
      3'b010: n3935_o <= o_dshi;
      3'b001: n3935_o <= n3578_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3937_o <= o_first;
      3'b010: n3937_o <= o_first;
      3'b001: n3937_o <= n3580_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3939_o <= n3742_o;
      3'b010: n3939_o <= o_last;
      3'b001: n3939_o <= n3582_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3941_o <= n3902_o;
      3'b010: n3941_o <= o_last1;
      3'b001: n3941_o <= o_last1;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3943_o <= n3903_o;
      3'b010: n3943_o <= o_last2;
      3'b001: n3943_o <= o_last2;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3945_o <= o_altx;
      3'b010: n3945_o <= o_altx;
      3'b001: n3945_o <= n3552_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3947_o <= n3720_o;
      3'b010: n3947_o <= o_dcpt;
      3'b001: n3947_o <= n3584_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3949_o <= n3743_o;
      3'b010: n3949_o <= n3595_o;
      3'b001: n3949_o <= n3586_o;
    endcase
  /* ascal.vhd:2106:25  */
  always @*
    case (n3908_o)
      3'b100: n3952_o <= n3905_o;
      3'b010: n3952_o <= 1'b0;
      3'b001: n3952_o <= 1'b0;
    endcase
  /* ascal.vhd:587:28  */
  assign n3964_o = o_format[2:0];
  /* ascal.vhd:589:54  */
  assign n3965_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:589:54  */
  assign n3967_o = n3965_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:589:46  */
  assign n3969_o = 1'b1 & n3967_o;
  /* ascal.vhd:589:58  */
  assign n3971_o = n3969_o | 1'b0;
  /* ascal.vhd:590:57  */
  assign n3972_o = o_dr[15:0];
  /* ascal.vhd:590:53  */
  assign n3973_o = {o_dr, n3972_o};
  /* ascal.vhd:592:55  */
  assign n3974_o = o_shift[135:0];
  /* ascal.vhd:592:74  */
  assign n3975_o = o_dr[7:0];
  /* ascal.vhd:592:70  */
  assign n3976_o = {n3974_o, n3975_o};
  /* ascal.vhd:589:33  */
  assign n3977_o = n3971_o ? n3973_o : n3976_o;
  /* ascal.vhd:588:25  */
  assign n3979_o = n3964_o == 3'b011;
  /* ascal.vhd:596:56  */
  assign n3980_o = {28'b0, o_acpt4};  //  uext
  assign n3981_o = n3980_o[2:0];
  /* ascal.vhd:596:56  */
  assign n3982_o = {29'b0, n3981_o};  //  uext
  /* ascal.vhd:596:62  */
  assign n3984_o = n3982_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:596:46  */
  assign n3986_o = 1'b1 & n3984_o;
  /* ascal.vhd:596:66  */
  assign n3988_o = n3986_o | 1'b0;
  /* ascal.vhd:597:57  */
  assign n3989_o = o_dr[15:0];
  /* ascal.vhd:597:53  */
  assign n3990_o = {o_dr, n3989_o};
  /* ascal.vhd:599:55  */
  assign n3991_o = o_shift[127:0];
  /* ascal.vhd:599:75  */
  assign n3992_o = o_dr[15:0];
  /* ascal.vhd:599:71  */
  assign n3993_o = {n3991_o, n3992_o};
  /* ascal.vhd:596:33  */
  assign n3994_o = n3988_o ? n3990_o : n3993_o;
  /* ascal.vhd:595:25  */
  assign n3996_o = n3964_o == 3'b100;
  /* ascal.vhd:604:48  */
  assign n3997_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:604:48  */
  assign n3999_o = n3997_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:605:65  */
  assign n4000_o = o_dr[15:0];
  /* ascal.vhd:605:61  */
  assign n4001_o = {o_dr, n4000_o};
  /* ascal.vhd:606:51  */
  assign n4002_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:606:51  */
  assign n4004_o = n4002_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:607:63  */
  assign n4005_o = o_shift[119:112];
  /* ascal.vhd:607:74  */
  assign n4006_o = {n4005_o, o_dr};
  /* ascal.vhd:607:83  */
  assign n4007_o = o_dr[7:0];
  /* ascal.vhd:607:79  */
  assign n4008_o = {n4006_o, n4007_o};
  /* ascal.vhd:608:51  */
  assign n4009_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:608:51  */
  assign n4011_o = n4009_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:609:63  */
  assign n4012_o = o_shift[119:104];
  /* ascal.vhd:609:74  */
  assign n4013_o = {n4012_o, o_dr};
  /* ascal.vhd:611:63  */
  assign n4014_o = o_shift[119:0];
  /* ascal.vhd:611:83  */
  assign n4015_o = o_dr[23:0];
  /* ascal.vhd:611:79  */
  assign n4016_o = {n4014_o, n4015_o};
  /* ascal.vhd:608:41  */
  assign n4017_o = n4011_o ? n4013_o : n4016_o;
  /* ascal.vhd:606:41  */
  assign n4018_o = n4004_o ? n4008_o : n4017_o;
  /* ascal.vhd:604:41  */
  assign n4019_o = n3999_o ? n4001_o : n4018_o;
  /* ascal.vhd:602:25  */
  assign n4021_o = n3964_o == 3'b101;
  /* ascal.vhd:625:56  */
  assign n4022_o = {28'b0, o_acpt4};  //  uext
  assign n4023_o = n4022_o[1:0];
  /* ascal.vhd:625:56  */
  assign n4024_o = {30'b0, n4023_o};  //  uext
  /* ascal.vhd:625:62  */
  assign n4026_o = n4024_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:625:46  */
  assign n4028_o = 1'b1 & n4026_o;
  /* ascal.vhd:625:66  */
  assign n4030_o = n4028_o | 1'b0;
  /* ascal.vhd:626:57  */
  assign n4031_o = o_dr[15:0];
  /* ascal.vhd:626:53  */
  assign n4032_o = {o_dr, n4031_o};
  /* ascal.vhd:628:55  */
  assign n4033_o = o_shift[111:0];
  /* ascal.vhd:628:75  */
  assign n4034_o = o_dr[31:0];
  /* ascal.vhd:628:71  */
  assign n4035_o = {n4033_o, n4034_o};
  /* ascal.vhd:625:33  */
  assign n4036_o = n4030_o ? n4032_o : n4035_o;
  assign n4037_o = {n4021_o, n3996_o, n3979_o};
  /* ascal.vhd:587:17  */
  always @*
    case (n4037_o)
      3'b100: n4038_o <= n4019_o;
      3'b010: n4038_o <= n3994_o;
      3'b001: n4038_o <= n3977_o;
    endcase
  /* ascal.vhd:656:28  */
  assign n4045_o = o_format[3:0];
  /* ascal.vhd:658:49  */
  assign n4046_o = n4038_o[135:131];
  /* ascal.vhd:658:66  */
  assign n4047_o = n4038_o[135:133];
  /* ascal.vhd:658:59  */
  assign n4048_o = {n4046_o, n4047_o};
  /* ascal.vhd:659:59  */
  assign n4049_o = n4038_o[130:128];
  /* ascal.vhd:659:77  */
  assign n4050_o = n4038_o[143:141];
  /* ascal.vhd:659:70  */
  assign n4051_o = {n4049_o, n4050_o};
  /* ascal.vhd:659:93  */
  assign n4052_o = n4038_o[130:129];
  /* ascal.vhd:659:86  */
  assign n4053_o = {n4051_o, n4052_o};
  /* ascal.vhd:660:59  */
  assign n4054_o = n4038_o[140:136];
  /* ascal.vhd:660:75  */
  assign n4055_o = n4038_o[140:138];
  /* ascal.vhd:660:68  */
  assign n4056_o = {n4054_o, n4055_o};
  assign n4057_o = {n4048_o, n4053_o, n4056_o};
  /* ascal.vhd:657:25  */
  assign n4059_o = n4045_o == 4'b0100;
  /* ascal.vhd:662:49  */
  assign n4060_o = n4038_o[134:130];
  /* ascal.vhd:662:66  */
  assign n4061_o = n4038_o[134:132];
  /* ascal.vhd:662:59  */
  assign n4062_o = {n4060_o, n4061_o};
  /* ascal.vhd:663:59  */
  assign n4063_o = n4038_o[129:128];
  /* ascal.vhd:663:77  */
  assign n4064_o = n4038_o[143:141];
  /* ascal.vhd:663:70  */
  assign n4065_o = {n4063_o, n4064_o};
  /* ascal.vhd:663:93  */
  assign n4066_o = n4038_o[129:128];
  /* ascal.vhd:663:86  */
  assign n4067_o = {n4065_o, n4066_o};
  /* ascal.vhd:663:111  */
  assign n4068_o = n4038_o[143];
  /* ascal.vhd:663:104  */
  assign n4069_o = {n4067_o, n4068_o};
  /* ascal.vhd:664:59  */
  assign n4070_o = n4038_o[140:136];
  /* ascal.vhd:664:75  */
  assign n4071_o = n4038_o[140:138];
  /* ascal.vhd:664:68  */
  assign n4072_o = {n4070_o, n4071_o};
  assign n4073_o = {n4062_o, n4069_o, n4072_o};
  /* ascal.vhd:661:25  */
  assign n4075_o = n4045_o == 4'b1100;
  /* ascal.vhd:666:49  */
  assign n4076_o = n4038_o[143:136];
  /* ascal.vhd:666:66  */
  assign n4077_o = n4038_o[135:128];
  /* ascal.vhd:666:84  */
  assign n4078_o = n4038_o[127:120];
  assign n4079_o = {n4078_o, n4077_o, n4076_o};
  /* ascal.vhd:665:25  */
  assign n4081_o = n4045_o == 4'b0101;
  /* ascal.vhd:665:37  */
  assign n4083_o = n4045_o == 4'b0110;
  /* ascal.vhd:665:37  */
  assign n4084_o = n4081_o | n4083_o;
  /* ascal.vhd:669:49  */
  assign n4085_o = n4038_o[143:136];
  /* ascal.vhd:669:66  */
  assign n4086_o = n4038_o[135:128];
  /* ascal.vhd:669:84  */
  assign n4087_o = n4038_o[127:120];
  assign n4088_o = {n4087_o, n4086_o, n4085_o};
  assign n4089_o = {n4084_o, n4075_o, n4059_o};
  /* ascal.vhd:656:17  */
  always @*
    case (n4089_o)
      3'b100: n4090_o <= n4079_o;
      3'b010: n4090_o <= n4073_o;
      3'b001: n4090_o <= n4057_o;
    endcase
  /* ascal.vhd:2214:44  */
  assign n4094_o = o_format[4];
  /* ascal.vhd:2215:61  */
  assign n4095_o = o_hpixs[23:16];
  /* ascal.vhd:2215:74  */
  assign n4096_o = o_hpixs[15:8];
  /* ascal.vhd:2215:87  */
  assign n4097_o = o_hpixs[7:0];
  assign n4098_o = {n4097_o, n4096_o, n4095_o};
  /* ascal.vhd:2214:33  */
  assign n4099_o = n4094_o ? n4098_o : o_hpixs;
  /* ascal.vhd:2217:44  */
  assign n4100_o = o_format[2:0];
  /* ascal.vhd:2217:56  */
  assign n4102_o = n4100_o == 3'b011;
  /* ascal.vhd:2219:64  */
  assign n4103_o = o_fb_pal_dr[23:16];
  /* ascal.vhd:2219:93  */
  assign n4104_o = o_fb_pal_dr[15:8];
  /* ascal.vhd:2220:88  */
  assign n4105_o = o_fb_pal_dr[7:0];
  assign n4106_o = {n4105_o, n4104_o, n4103_o};
  /* ascal.vhd:2217:33  */
  assign n4107_o = n4102_o ? n4106_o : n4099_o;
  /* ascal.vhd:2212:25  */
  assign n4109_o = n4113_o ? 1'b0 : n3937_o;
  /* ascal.vhd:2227:33  */
  assign n4110_o = o_first ? n4107_o : o_hpix0;
  /* ascal.vhd:2227:33  */
  assign n4111_o = o_first ? n4107_o : o_hpix1;
  /* ascal.vhd:2233:33  */
  assign n4112_o = o_lastt4 ? o_hpix0 : n4107_o;
  /* ascal.vhd:2212:25  */
  assign n4113_o = o_sh4 & o_first;
  /* ascal.vhd:2243:37  */
  assign n4119_o = ~n3952_o;
  /* ascal.vhd:2243:42  */
  assign n4120_o = n4119_o & n3460_o;
  /* ascal.vhd:2244:53  */
  assign n4121_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2244:53  */
  assign n4123_o = n4121_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2244:44  */
  assign n4124_o = n4123_o[1:0];  // trunc
  /* ascal.vhd:2245:58  */
  assign n4125_o = ~n3460_o;
  /* ascal.vhd:2245:45  */
  assign n4126_o = n3952_o & n4125_o;
  /* ascal.vhd:2246:53  */
  assign n4127_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2246:53  */
  assign n4129_o = n4127_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2246:44  */
  assign n4130_o = n4129_o[1:0];  // trunc
  /* ascal.vhd:2245:25  */
  assign n4131_o = n4126_o ? n4130_o : o_readlev;
  /* ascal.vhd:2243:25  */
  assign n4132_o = n4120_o ? n4124_o : n4131_o;
  /* ascal.vhd:2250:59  */
  assign n4133_o = ~o_readdataack;
  /* ascal.vhd:2250:42  */
  assign n4134_o = n3952_o & n4133_o;
  /* ascal.vhd:2251:53  */
  assign n4135_o = {30'b0, o_copylev};  //  uext
  /* ascal.vhd:2251:53  */
  assign n4137_o = n4135_o - 32'b00000000000000000000000000000001;
  /* ascal.vhd:2251:44  */
  assign n4138_o = n4137_o[1:0];  // trunc
  /* ascal.vhd:2252:40  */
  assign n4139_o = ~n3952_o;
  /* ascal.vhd:2252:45  */
  assign n4140_o = n4139_o & o_readdataack;
  /* ascal.vhd:2253:53  */
  assign n4141_o = {30'b0, o_copylev};  //  uext
  /* ascal.vhd:2253:53  */
  assign n4143_o = n4141_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2253:44  */
  assign n4144_o = n4143_o[1:0];  // trunc
  /* ascal.vhd:2252:25  */
  assign n4145_o = n4140_o ? n4144_o : o_copylev;
  /* ascal.vhd:2250:25  */
  assign n4146_o = n4134_o ? n4138_o : n4145_o;
  /* ascal.vhd:2258:57  */
  assign n4147_o = o_primv[1:0];
  /* ascal.vhd:2259:57  */
  assign n4148_o = o_lastv[1:0];
  /* ascal.vhd:2260:57  */
  assign n4149_o = o_bibv[1:0];
  /* ascal.vhd:2261:57  */
  assign n4150_o = o_off[7:0];
  assign n4151_o = o_primv[2:1];
  /* ascal.vhd:2257:25  */
  assign n4152_o = n3952_o ? n4147_o : n4151_o;
  assign n4153_o = o_lastv[2:1];
  /* ascal.vhd:2257:25  */
  assign n4154_o = n3952_o ? n4148_o : n4153_o;
  assign n4155_o = o_bibv[2:1];
  /* ascal.vhd:2257:25  */
  assign n4156_o = n3952_o ? n4149_o : n4155_o;
  assign n4157_o = o_off[11:4];
  /* ascal.vhd:2257:25  */
  assign n4158_o = n3952_o ? n4150_o : n4157_o;
  /* ascal.vhd:2265:45  */
  assign n4159_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2265:45  */
  assign n4161_o = n4159_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:2265:61  */
  assign n4162_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2265:61  */
  assign n4164_o = n4162_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:2265:64  */
  assign n4165_o = n4164_o & n3952_o;
  /* ascal.vhd:2265:48  */
  assign n4166_o = n4161_o | n4165_o;
  /* ascal.vhd:2270:49  */
  assign n4167_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2270:49  */
  assign n4169_o = n4167_o == 32'b00000000000000000000000000000001;
  /* ascal.vhd:2270:65  */
  assign n4170_o = ~n3952_o;
  /* ascal.vhd:2270:52  */
  assign n4171_o = n4169_o & n4170_o;
  /* ascal.vhd:2271:67  */
  assign n4172_o = {30'b0, o_readlev};  //  uext
  /* ascal.vhd:2271:67  */
  assign n4174_o = n4172_o == 32'b00000000000000000000000000000010;
  /* ascal.vhd:2271:70  */
  assign n4175_o = n4174_o & n3952_o;
  /* ascal.vhd:2270:71  */
  assign n4176_o = n4171_o | n4175_o;
  assign n4177_o = o_primv[0];
  assign n4178_o = o_primv[1];
  /* ascal.vhd:2257:25  */
  assign n4179_o = n3952_o ? n4177_o : n4178_o;
  /* ascal.vhd:2270:33  */
  assign n4180_o = n4176_o ? n3463_o : n4179_o;
  assign n4181_o = o_lastv[0];
  assign n4182_o = o_lastv[1];
  /* ascal.vhd:2257:25  */
  assign n4183_o = n3952_o ? n4181_o : n4182_o;
  /* ascal.vhd:2270:33  */
  assign n4184_o = n4176_o ? n3465_o : n4183_o;
  assign n4185_o = o_bibv[0];
  assign n4186_o = o_bibv[1];
  /* ascal.vhd:2257:25  */
  assign n4187_o = n3952_o ? n4185_o : n4186_o;
  /* ascal.vhd:2270:33  */
  assign n4188_o = n4176_o ? n3467_o : n4187_o;
  assign n4189_o = o_off[3:0];
  assign n4190_o = o_off[7:4];
  /* ascal.vhd:2257:25  */
  assign n4191_o = n3952_o ? n4189_o : n4190_o;
  /* ascal.vhd:2270:33  */
  assign n4192_o = n4176_o ? n3473_o : n4191_o;
  assign n4193_o = o_primv[0];
  assign n4194_o = o_primv[1];
  /* ascal.vhd:2257:25  */
  assign n4195_o = n3952_o ? n4193_o : n4194_o;
  /* ascal.vhd:2265:33  */
  assign n4196_o = n4166_o ? n4195_o : n4180_o;
  assign n4197_o = o_primv[1];
  assign n4198_o = o_primv[2];
  /* ascal.vhd:2257:25  */
  assign n4199_o = n3952_o ? n4197_o : n4198_o;
  /* ascal.vhd:2265:33  */
  assign n4200_o = n4166_o ? n3463_o : n4199_o;
  assign n4201_o = o_lastv[0];
  assign n4202_o = o_lastv[1];
  /* ascal.vhd:2257:25  */
  assign n4203_o = n3952_o ? n4201_o : n4202_o;
  /* ascal.vhd:2265:33  */
  assign n4204_o = n4166_o ? n4203_o : n4184_o;
  assign n4205_o = o_lastv[1];
  assign n4206_o = o_lastv[2];
  /* ascal.vhd:2257:25  */
  assign n4207_o = n3952_o ? n4205_o : n4206_o;
  /* ascal.vhd:2265:33  */
  assign n4208_o = n4166_o ? n3465_o : n4207_o;
  assign n4209_o = o_bibv[0];
  assign n4210_o = o_bibv[1];
  /* ascal.vhd:2257:25  */
  assign n4211_o = n3952_o ? n4209_o : n4210_o;
  /* ascal.vhd:2265:33  */
  assign n4212_o = n4166_o ? n4211_o : n4188_o;
  assign n4213_o = o_bibv[1];
  assign n4214_o = o_bibv[2];
  /* ascal.vhd:2257:25  */
  assign n4215_o = n3952_o ? n4213_o : n4214_o;
  /* ascal.vhd:2265:33  */
  assign n4216_o = n4166_o ? n3467_o : n4215_o;
  assign n4217_o = o_off[3:0];
  assign n4218_o = o_off[7:4];
  /* ascal.vhd:2257:25  */
  assign n4219_o = n3952_o ? n4217_o : n4218_o;
  /* ascal.vhd:2265:33  */
  assign n4220_o = n4166_o ? n4219_o : n4192_o;
  assign n4221_o = o_off[7:4];
  assign n4222_o = o_off[11:8];
  /* ascal.vhd:2257:25  */
  assign n4223_o = n3952_o ? n4221_o : n4222_o;
  /* ascal.vhd:2265:33  */
  assign n4224_o = n4166_o ? n3473_o : n4223_o;
  assign n4225_o = {n4200_o, n4196_o, n3463_o};
  assign n4226_o = o_primv[0];
  assign n4227_o = {n4152_o, n4226_o};
  /* ascal.vhd:2264:25  */
  assign n4228_o = n3460_o ? n4225_o : n4227_o;
  assign n4229_o = {n4208_o, n4204_o, n3465_o};
  assign n4230_o = o_lastv[0];
  assign n4231_o = {n4154_o, n4230_o};
  /* ascal.vhd:2264:25  */
  assign n4232_o = n3460_o ? n4229_o : n4231_o;
  assign n4233_o = {n4216_o, n4212_o, n3467_o};
  assign n4234_o = o_bibv[0];
  assign n4235_o = {n4156_o, n4234_o};
  /* ascal.vhd:2264:25  */
  assign n4236_o = n3460_o ? n4233_o : n4235_o;
  assign n4237_o = {n4224_o, n4220_o, n3473_o};
  assign n4238_o = o_off[3:0];
  assign n4239_o = {n4158_o, n4238_o};
  /* ascal.vhd:2264:25  */
  assign n4240_o = n3460_o ? n4237_o : n4239_o;
  assign n4244_o = {n3191_o, n3190_o};
  assign n4246_o = {n3197_o, n3196_o};
  /* ascal.vhd:1814:9  */
  assign n4508_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4509_o = n4508_o ? run : o_run;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4510_q <= n4509_o;
  /* ascal.vhd:1814:9  */
  assign n4511_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4512_o = n4511_o ? freeze : o_freeze;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4513_q <= n4512_o;
  /* ascal.vhd:1814:9  */
  assign n4514_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4515_o = n4514_o ? mode : o_mode;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4516_q <= n4515_o;
  /* ascal.vhd:1814:9  */
  assign n4517_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4518_o = n4517_o ? n4244_o : o_hmode;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4519_q <= n4518_o;
  /* ascal.vhd:1814:9  */
  assign n4520_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4521_o = n4520_o ? n4246_o : o_vmode;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4522_q <= n4521_o;
  /* ascal.vhd:1814:9  */
  assign n4523_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4524_o = n4523_o ? n3138_o : o_format;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4525_q <= n4524_o;
  /* ascal.vhd:1814:9  */
  assign n4526_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4527_o = n4526_o ? htotal : o_htotal;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4528_q <= n4527_o;
  /* ascal.vhd:1814:9  */
  assign n4529_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4530_o = n4529_o ? hsstart : o_hsstart;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4531_q <= n4530_o;
  /* ascal.vhd:1814:9  */
  assign n4532_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4533_o = n4532_o ? hsend : o_hsend;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4534_q <= n4533_o;
  /* ascal.vhd:1814:9  */
  assign n4535_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4536_o = n4535_o ? hmin : o_hmin;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4537_q <= n4536_o;
  /* ascal.vhd:1814:9  */
  assign n4538_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4539_o = n4538_o ? hmax : o_hmax;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4540_q <= n4539_o;
  /* ascal.vhd:1814:9  */
  assign n4541_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4542_o = n4541_o ? hdisp : o_hdisp;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4543_q <= n4542_o;
  /* ascal.vhd:1814:9  */
  assign n4544_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4545_o = n4544_o ? n2758_o : o_hsize;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4546_q <= n4545_o;
  /* ascal.vhd:1814:9  */
  assign n4547_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4548_o = n4547_o ? n2764_o : o_vsize;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4549_q <= n4548_o;
  /* ascal.vhd:1814:9  */
  assign n4550_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4551_o = n4550_o ? vtotal : o_vtotal;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4552_q <= n4551_o;
  /* ascal.vhd:1814:9  */
  assign n4553_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4554_o = n4553_o ? vsstart : o_vsstart;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4555_q <= n4554_o;
  /* ascal.vhd:1814:9  */
  assign n4556_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4557_o = n4556_o ? vsend : o_vsend;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4558_q <= n4557_o;
  /* ascal.vhd:1814:9  */
  assign n4559_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4560_o = n4559_o ? vrr : o_vrr;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4561_q <= n4560_o;
  /* ascal.vhd:1814:9  */
  assign n4562_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4563_o = n4562_o ? n2929_o : o_isync;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4564_q <= n4563_o;
  /* ascal.vhd:1814:9  */
  assign n4565_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4566_o = n4565_o ? o_isync : o_isync2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4567_q <= n4566_o;
  /* ascal.vhd:1814:9  */
  assign n4568_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4569_o = n4568_o ? vrrmax : o_vrrmax;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4570_q <= n4569_o;
  /* ascal.vhd:1814:9  */
  assign n4571_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4572_o = n4571_o ? vmin : o_vmin;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4573_q <= n4572_o;
  /* ascal.vhd:1814:9  */
  assign n4574_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4575_o = n4574_o ? vmax : o_vmax;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4576_q <= n4575_o;
  /* ascal.vhd:1814:9  */
  assign n4577_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4578_o = n4577_o ? vdisp : o_vdisp;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4579_q <= n4578_o;
  /* ascal.vhd:1814:9  */
  assign n4580_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4581_o = n4580_o ? i_endframe0 : o_iendframe0;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4582_q <= n4581_o;
  /* ascal.vhd:1814:9  */
  assign n4583_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4584_o = n4583_o ? o_iendframe0 : o_iendframe02;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4585_q <= n4584_o;
  /* ascal.vhd:1814:9  */
  assign n4586_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4587_o = n4586_o ? i_endframe1 : o_iendframe1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4588_q <= n4587_o;
  /* ascal.vhd:1814:9  */
  assign n4589_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4590_o = n4589_o ? o_iendframe1 : o_iendframe12;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4591_q <= n4590_o;
  /* ascal.vhd:1814:9  */
  assign n4592_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4593_o = n4592_o ? n3113_o : o_bufup0;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4594_q <= n4593_o;
  /* ascal.vhd:1814:9  */
  assign n4595_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4596_o = n4595_o ? n3123_o : o_bufup1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4597_q <= n4596_o;
  /* ascal.vhd:1814:9  */
  assign n4598_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4599_o = n4598_o ? i_inter : o_inter;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4600_q <= n4599_o;
  /* ascal.vhd:1814:9  */
  assign n4601_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4602_o = n4601_o ? n3131_o : o_ibuf0;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4603_q <= n4602_o;
  /* ascal.vhd:1814:9  */
  assign n4604_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4605_o = n4604_o ? n3133_o : o_ibuf1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4606_q <= n4605_o;
  /* ascal.vhd:1814:9  */
  assign n4607_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4608_o = n4607_o ? n3135_o : o_obuf0;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4609_q <= n4608_o;
  /* ascal.vhd:1814:9  */
  assign n4610_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4611_o = n4610_o ? n3137_o : o_obuf1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4612_q <= n4611_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4613_q <= 2'b00;
    else
      n4613_q <= n3422_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4614_q <= 2'b00;
    else
      n4614_q <= n3910_o;
  /* ascal.vhd:1814:9  */
  assign n4615_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4616_o = n4615_o ? n3912_o : o_pshift;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4617_q <= n4616_o;
  /* ascal.vhd:1814:9  */
  assign n4618_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4619_o = n4618_o ? n3198_o : o_readack;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4620_q <= n4619_o;
  /* ascal.vhd:1814:9  */
  assign n4621_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4622_o = n4621_o ? avl_readack : o_readack_sync;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4623_q <= n4622_o;
  /* ascal.vhd:1814:9  */
  assign n4624_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4625_o = n4624_o ? o_readack_sync : o_readack_sync2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4626_q <= n4625_o;
  /* ascal.vhd:1814:9  */
  assign n4627_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4628_o = n4627_o ? n3199_o : o_readdataack;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4629_q <= n4628_o;
  /* ascal.vhd:1814:9  */
  assign n4630_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4631_o = n4630_o ? avl_readdataack : o_readdataack_sync;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4632_q <= n4631_o;
  /* ascal.vhd:1814:9  */
  assign n4633_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4634_o = n4633_o ? o_readdataack_sync : o_readdataack_sync2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4635_q <= n4634_o;
  /* ascal.vhd:1814:9  */
  assign n4636_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4637_o = o_copyv[14];
  /* ascal.vhd:1831:17  */
  assign n4638_o = n4636_o ? n3915_o : n4637_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4639_q <= n4638_o;
  /* ascal.vhd:1814:9  */
  assign n4640_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4641_o = o_adrsa & n4640_o;
  /* ascal.vhd:1831:17  */
  assign n4642_o = n4641_o ? n3529_o : o_adrs;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4643_q <= n4642_o;
  /* ascal.vhd:1814:9  */
  assign n4644_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4645_o = n4644_o ? n3481_o : o_adrs_pre;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4646_q <= n4645_o;
  /* ascal.vhd:1814:9  */
  assign n4647_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4648_o = n4647_o ? n3185_o : o_stride;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4649_q <= n4648_o;
  /* ascal.vhd:1814:9  */
  assign n4650_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4651_o = n4650_o ? n3426_o : o_adrsa;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4652_q <= n4651_o;
  /* ascal.vhd:1814:9  */
  assign n4653_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4654_o = n4653_o ? o_adrsa : o_adrsb;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4655_q <= n4654_o;
  /* ascal.vhd:1814:9  */
  assign n4656_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4657_o = n4656_o ? n3475_o : o_rline;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4658_q <= n4657_o;
  /* ascal.vhd:1814:9  */
  assign n4659_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4660_o = n4659_o ? n3917_o : o_ad;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4661_q <= n4660_o;
  /* ascal.vhd:1814:9  */
  assign n4662_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4663_o = n4662_o ? o_ad : o_ad1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4664_q <= n4663_o;
  /* ascal.vhd:1814:9  */
  assign n4665_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4666_o = n4665_o ? o_ad1 : o_ad2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4667_q <= n4666_o;
  /* ascal.vhd:1814:9  */
  assign n4668_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4669_o = n4668_o ? o_ad2 : o_ad3;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4670_q <= n4669_o;
  /* ascal.vhd:1814:9  */
  assign n4671_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4672_o = n4671_o ? n3920_o : o_adturn;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4673_q <= n4672_o;
  /* ascal.vhd:1814:9  */
  assign n4674_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4675_o = o_sh3 & n4674_o;
  /* ascal.vhd:1831:17  */
  assign n4676_o = n4675_o ? n4038_o : o_shift;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4677_q <= n4676_o;
  /* ascal.vhd:1814:9  */
  assign n4678_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4679_o = n4678_o ? n3924_o : o_sh;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4680_q <= n4679_o;
  /* ascal.vhd:1814:9  */
  assign n4681_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4682_o = n4681_o ? o_sh : o_sh1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4683_q <= n4682_o;
  /* ascal.vhd:1814:9  */
  assign n4684_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4685_o = n4684_o ? o_sh1 : o_sh2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4686_q <= n4685_o;
  /* ascal.vhd:1814:9  */
  assign n4687_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4688_o = n4687_o ? o_sh2 : o_sh3;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4689_q <= n4688_o;
  /* ascal.vhd:1814:9  */
  assign n4690_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4691_o = n4690_o ? o_sh3 : o_sh4;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4692_q <= n4691_o;
  /* ascal.vhd:1814:9  */
  assign n4693_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4694_o = n4693_o ? n3139_o : o_ihsize;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4695_q <= n4694_o;
  /* ascal.vhd:1814:9  */
  assign n4696_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4697_o = n4696_o ? n3927_o : o_ihsizem;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4698_q <= n4697_o;
  /* ascal.vhd:1814:9  */
  assign n4699_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4700_o = n4699_o ? n3140_o : o_ivsize;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4701_q <= n4700_o;
  /* ascal.vhd:1814:9  */
  assign n4702_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4703_o = n4702_o ? n3166_o : o_ihsize_temp;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4704_q <= n4703_o;
  /* ascal.vhd:1814:9  */
  assign n4705_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4706_o = n4705_o ? n3172_o : o_ihsize_temp2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4707_q <= n4706_o;
  /* ascal.vhd:1814:9  */
  assign n4708_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4709_o = n4708_o ? n3929_o : o_hacc;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4710_q <= n4709_o;
  /* ascal.vhd:1814:9  */
  assign n4711_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4712_o = n4711_o ? n3242_o : o_hacc_ini;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4713_q <= n4712_o;
  /* ascal.vhd:1814:9  */
  assign n4714_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4715_o = n4714_o ? n3931_o : o_hacc_next;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4716_q <= n4715_o;
  /* ascal.vhd:1814:9  */
  assign n4717_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4718_o = n4717_o ? n3429_o : o_vacc;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4719_q <= n4718_o;
  /* ascal.vhd:1814:9  */
  assign n4720_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4721_o = n4720_o ? n3431_o : o_vacc_next;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4722_q <= n4721_o;
  /* ascal.vhd:1814:9  */
  assign n4723_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4724_o = n4723_o ? n3235_o : o_vacc_ini;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4725_q <= n4724_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4726_q <= 1'b0;
    else
      n4726_q <= n3433_o;
  /* ascal.vhd:1814:9  */
  assign n4727_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4728_o = n4727_o ? n3436_o : o_vcarrym;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4729_q <= n4728_o;
  /* ascal.vhd:1814:9  */
  assign n4730_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4731_o = n4730_o ? n3440_o : o_prim;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4732_q <= n4731_o;
  /* ascal.vhd:1814:9  */
  assign n4733_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4734_o = n4733_o ? n3474_o : o_read;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4735_q <= n4734_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4736_q <= 1'b0;
    else
      n4736_q <= n3442_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4737_q <= 2'b00;
    else
      n4737_q <= n4132_o;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk or posedge n2749_o)
    if (n2749_o)
      n4738_q <= 2'b00;
    else
      n4738_q <= n4146_o;
  /* ascal.vhd:1814:9  */
  assign n4739_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4740_o = n4739_o ? n3176_o : o_hburst;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4741_q <= n4740_o;
  /* ascal.vhd:1814:9  */
  assign n4742_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4743_o = n4742_o ? n3445_o : o_hbcpt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4744_q <= n4743_o;
  /* ascal.vhd:1814:9  */
  assign n4745_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4746_o = n4745_o ? n3447_o : o_fload;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4747_q <= n4746_o;
  /* ascal.vhd:1814:9  */
  assign n4748_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4749_o = n4748_o ? n3933_o : o_acpt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4750_q <= n4749_o;
  /* ascal.vhd:1814:9  */
  assign n4751_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4752_o = n4751_o ? o_acpt : o_acpt1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4753_q <= n4752_o;
  /* ascal.vhd:1814:9  */
  assign n4754_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4755_o = n4754_o ? o_acpt1 : o_acpt2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4756_q <= n4755_o;
  /* ascal.vhd:1814:9  */
  assign n4757_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4758_o = n4757_o ? o_acpt2 : o_acpt3;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4759_q <= n4758_o;
  /* ascal.vhd:1814:9  */
  assign n4760_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4761_o = n4760_o ? o_acpt3 : o_acpt4;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4762_q <= n4761_o;
  /* ascal.vhd:1814:9  */
  assign n4763_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4764_o = n4763_o ? n3935_o : o_dshi;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4765_q <= n4764_o;
  /* ascal.vhd:1814:9  */
  assign n4766_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4767_o = n4766_o ? n4109_o : o_first;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4768_q <= n4767_o;
  /* ascal.vhd:1814:9  */
  assign n4769_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4770_o = n4769_o ? n3939_o : o_last;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4771_q <= n4770_o;
  /* ascal.vhd:1814:9  */
  assign n4772_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4773_o = n4772_o ? n3941_o : o_last1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4774_q <= n4773_o;
  /* ascal.vhd:1814:9  */
  assign n4775_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4776_o = n4775_o ? n3943_o : o_last2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4777_q <= n4776_o;
  /* ascal.vhd:1814:9  */
  assign n4778_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4779_o = n4778_o ? o_last : o_lastt1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4780_q <= n4779_o;
  /* ascal.vhd:1814:9  */
  assign n4781_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4782_o = n4781_o ? o_lastt1 : o_lastt2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4783_q <= n4782_o;
  /* ascal.vhd:1814:9  */
  assign n4784_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4785_o = n4784_o ? o_lastt2 : o_lastt3;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4786_q <= n4785_o;
  /* ascal.vhd:1814:9  */
  assign n4787_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4788_o = n4787_o ? o_lastt3 : o_lastt4;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4789_q <= n4788_o;
  /* ascal.vhd:1814:9  */
  assign n4790_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4791_o = o_adrsa & n4790_o;
  /* ascal.vhd:1831:17  */
  assign n4792_o = n4791_o ? n3531_o : o_alt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4793_q <= n4792_o;
  /* ascal.vhd:1814:9  */
  assign n4794_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4795_o = n4794_o ? n3945_o : o_altx;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4796_q <= n4795_o;
  /* ascal.vhd:1814:9  */
  assign n4797_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4798_o = n4797_o ? n3142_o : o_hdown;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4799_q <= n4798_o;
  /* ascal.vhd:1814:9  */
  assign n4800_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4801_o = n4800_o ? n3144_o : o_vdown;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4802_q <= n4801_o;
  /* ascal.vhd:1814:9  */
  assign n4803_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4804_o = n4803_o ? n4228_o : o_primv;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4805_q <= n4804_o;
  /* ascal.vhd:1814:9  */
  assign n4806_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4807_o = n4806_o ? n4232_o : o_lastv;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4808_q <= n4807_o;
  /* ascal.vhd:1814:9  */
  assign n4809_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4810_o = n4809_o ? n4236_o : o_bibv;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4811_q <= n4810_o;
  /* ascal.vhd:1814:9  */
  assign n4812_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4813_o = n4812_o ? n4240_o : o_off;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4814_q <= n4813_o;
  /* ascal.vhd:1814:9  */
  assign n4815_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4816_o = n4815_o ? n3449_o : o_bibu;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4817_q <= n4816_o;
  initial
    n4817_q <= 1'b0;
  /* ascal.vhd:1814:9  */
  assign n4818_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4819_o = n4818_o ? n3947_o : o_dcpt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4820_q <= n4819_o;
  /* ascal.vhd:1814:9  */
  assign n4821_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4822_o = o_sh3 & n4821_o;
  /* ascal.vhd:1831:17  */
  assign n4823_o = n4822_o ? n4090_o : o_hpixs;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4824_q <= n4823_o;
  /* ascal.vhd:1814:9  */
  assign n4825_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4826_o = o_sh4 & n4825_o;
  /* ascal.vhd:1831:17  */
  assign n4827_o = n4826_o ? n4112_o : o_hpix0;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4828_q <= n4827_o;
  /* ascal.vhd:1814:9  */
  assign n4829_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4830_o = o_sh4 & n4829_o;
  /* ascal.vhd:1831:17  */
  assign n4831_o = n4830_o ? n4110_o : o_hpix1;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4832_q <= n4831_o;
  /* ascal.vhd:1814:9  */
  assign n4833_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4834_o = o_sh4 & n4833_o;
  /* ascal.vhd:1831:17  */
  assign n4835_o = n4834_o ? n4111_o : o_hpix2;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4836_q <= n4835_o;
  /* ascal.vhd:1814:9  */
  assign n4837_o = ~n2749_o;
  /* ascal.vhd:1814:9  */
  assign n4838_o = o_sh4 & n4837_o;
  /* ascal.vhd:1831:17  */
  assign n4839_o = n4838_o ? o_hpix2 : o_hpix3;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4840_q <= n4839_o;
  /* ascal.vhd:1814:9  */
  assign n4841_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4842_o = n4841_o ? n3229_o : o_vpe;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4843_q <= n4842_o;
  /* ascal.vhd:1814:9  */
  assign n4844_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4845_o = n4844_o ? n3452_o : o_divstart;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4846_q <= n4845_o;
  /* ascal.vhd:1814:9  */
  assign n4847_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4848_o = n4847_o ? n3949_o : o_hacpt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4849_q <= n4848_o;
  /* ascal.vhd:1814:9  */
  assign n4850_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4851_o = n4850_o ? n3455_o : o_vacpt;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4852_q <= n4851_o;
  /* ascal.vhd:1814:9  */
  assign n4853_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4854_o = n4853_o ? n3457_o : o_vacptl;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4855_q <= n4854_o;
  /* ascal.vhd:1814:9  */
  assign n4862_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4863_o = n4862_o ? n3463_o : scalaire_prim_v;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4864_q <= n4863_o;
  initial
    n4864_q <= 1'bX;
  /* ascal.vhd:1814:9  */
  assign n4865_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4866_o = n4865_o ? n3465_o : scalaire_last_v;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4867_q <= n4866_o;
  initial
    n4867_q <= 1'bX;
  /* ascal.vhd:1814:9  */
  assign n4868_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4869_o = n4868_o ? n3467_o : scalaire_bib_v;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4870_q <= n4869_o;
  initial
    n4870_q <= 1'bX;
  /* ascal.vhd:1814:9  */
  assign n4888_o = ~n2749_o;
  /* ascal.vhd:1831:17  */
  assign n4889_o = n4888_o ? n3473_o : scalaire_off_v;
  /* ascal.vhd:1831:17  */
  always @(posedge o_clk)
    n4890_q <= n4889_o;
  initial
    n4890_q <= 4'b0000;
  /* ascal.vhd:2292:45  */
  assign n4895_o = o_hfrac[83:80];
  /* ascal.vhd:2293:41  */
  assign n4896_o = o_vfrac[11:8];
  /* ascal.vhd:2295:71  */
  assign n4898_o = o_vmode[2:0];
  /* ascal.vhd:2295:83  */
  assign n4900_o = n4898_o != 3'b000;
  /* ascal.vhd:2295:92  */
  assign n4901_o = n4900_o & o_v_poly_adaptive;
  /* ascal.vhd:285:17  */
  assign n4908_o = n4901_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2296:71  */
  assign n4910_o = o_hmode[2:0];
  /* ascal.vhd:2296:83  */
  assign n4912_o = n4910_o != 3'b000;
  /* ascal.vhd:2296:92  */
  assign n4913_o = n4912_o & o_h_poly_adaptive;
  /* ascal.vhd:285:17  */
  assign n4920_o = n4913_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2297:58  */
  assign n4921_o = o_vfrac[11:8];
  /* ascal.vhd:2300:35  */
  assign n4923_o = o_vmode[2:0];
  /* ascal.vhd:2300:47  */
  assign n4925_o = n4923_o != 3'b000;
  /* ascal.vhd:2301:75  */
  assign n4928_o = 4'b1111 - o_v_poly_addr;
  /* ascal.vhd:998:34  */
  assign n4936_o = n8389_o[39:30];
  /* ascal.vhd:999:34  */
  assign n4939_o = n8389_o[29:20];
  /* ascal.vhd:1000:34  */
  assign n4941_o = n8389_o[19:10];
  /* ascal.vhd:1001:34  */
  assign n4943_o = n8389_o[9:0];
  assign n4944_o = {n4943_o, n4941_o, n4939_o, n4936_o};
  /* ascal.vhd:1072:24  */
  assign n4951_o = n4896_o[3];
  /* ascal.vhd:1072:35  */
  assign n4952_o = ~n4951_o;
  /* ascal.vhd:1072:17  */
  assign n4955_o = n4952_o ? "0000000000000000000001000000000000000000" : "0000000000010000000000000000000000000000";
  /* ascal.vhd:2300:25  */
  assign n4957_o = n4925_o ? n4944_o : n4955_o;
  /* ascal.vhd:2306:35  */
  assign n4958_o = o_hmode[2:0];
  /* ascal.vhd:2306:47  */
  assign n4960_o = n4958_o != 3'b000;
  /* ascal.vhd:2307:75  */
  assign n4964_o = 4'b1111 - n4895_o;
  /* ascal.vhd:998:34  */
  assign n4972_o = n8415_o[39:30];
  /* ascal.vhd:999:34  */
  assign n4975_o = n8415_o[29:20];
  /* ascal.vhd:1000:34  */
  assign n4977_o = n8415_o[19:10];
  /* ascal.vhd:1001:34  */
  assign n4979_o = n8415_o[9:0];
  assign n4980_o = {n4979_o, n4977_o, n4975_o, n4972_o};
  /* ascal.vhd:1072:24  */
  assign n4987_o = n4895_o[3];
  /* ascal.vhd:1072:35  */
  assign n4988_o = ~n4987_o;
  /* ascal.vhd:1072:17  */
  assign n4991_o = n4988_o ? "0000000000000000000001000000000000000000" : "0000000000010000000000000000000000000000";
  /* ascal.vhd:2306:25  */
  assign n4993_o = n4960_o ? n4980_o : n4991_o;
  /* ascal.vhd:1094:22  */
  assign n5000_o = o_v_lum_pix[7:0];
  /* ascal.vhd:1094:28  */
  assign n5001_o = o_v_lum_pix[15:8];
  /* ascal.vhd:1094:24  */
  assign n5002_o = $unsigned(n5000_o) > $unsigned(n5001_o);
  /* ascal.vhd:1095:32  */
  assign n5003_o = o_v_lum_pix[7:0];
  /* ascal.vhd:1097:32  */
  assign n5004_o = o_v_lum_pix[15:8];
  /* ascal.vhd:1094:17  */
  assign n5005_o = n5002_o ? n5003_o : n5004_o;
  /* ascal.vhd:1100:22  */
  assign n5007_o = o_v_lum_pix[23:16];
  /* ascal.vhd:1100:24  */
  assign n5008_o = $unsigned(n5007_o) > $unsigned(n5005_o);
  /* ascal.vhd:1101:32  */
  assign n5009_o = o_v_lum_pix[23:16];
  /* ascal.vhd:1100:17  */
  assign n5010_o = n5008_o ? n5009_o : n5005_o;
  /* ascal.vhd:1094:22  */
  assign n5017_o = o_h_lum_pix[7:0];
  /* ascal.vhd:1094:28  */
  assign n5018_o = o_h_lum_pix[15:8];
  /* ascal.vhd:1094:24  */
  assign n5019_o = $unsigned(n5017_o) > $unsigned(n5018_o);
  /* ascal.vhd:1095:32  */
  assign n5020_o = o_h_lum_pix[7:0];
  /* ascal.vhd:1097:32  */
  assign n5021_o = o_h_lum_pix[15:8];
  /* ascal.vhd:1094:17  */
  assign n5022_o = n5019_o ? n5020_o : n5021_o;
  /* ascal.vhd:1100:22  */
  assign n5024_o = o_h_lum_pix[23:16];
  /* ascal.vhd:1100:24  */
  assign n5025_o = $unsigned(n5024_o) > $unsigned(n5022_o);
  /* ascal.vhd:1101:32  */
  assign n5026_o = o_h_lum_pix[23:16];
  /* ascal.vhd:1100:17  */
  assign n5027_o = n5025_o ? n5026_o : n5022_o;
  /* ascal.vhd:2315:25  */
  assign n5029_o = o_h_poly_use_adaptive ? n4895_o : o_a_poly_addr;
  /* ascal.vhd:2315:25  */
  assign n5030_o = o_h_poly_use_adaptive ? n5027_o : o_poly_lum;
  /* ascal.vhd:2312:25  */
  assign n5031_o = o_v_poly_use_adaptive ? o_v_poly_addr : n5029_o;
  /* ascal.vhd:2312:25  */
  assign n5032_o = o_v_poly_use_adaptive ? n5010_o : n5030_o;
  /* ascal.vhd:2321:65  */
  assign n5035_o = 4'b1111 - o_a_poly_addr;
  /* ascal.vhd:998:34  */
  assign n5043_o = n8441_o[39:30];
  /* ascal.vhd:999:34  */
  assign n5046_o = n8441_o[29:20];
  /* ascal.vhd:1000:34  */
  assign n5048_o = n8441_o[19:10];
  /* ascal.vhd:1001:34  */
  assign n5050_o = n8441_o[9:0];
  assign n5051_o = {n5050_o, n5048_o, n5046_o, n5043_o};
  /* ascal.vhd:2325:25  */
  assign n5052_o = o_h_poly_use_adaptive ? o_h_poly_phase_a : o_poly_phase_a;
  /* ascal.vhd:2323:25  */
  assign n5053_o = o_v_poly_use_adaptive ? o_v_poly_phase_a : n5052_o;
  /* ascal.vhd:2334:70  */
  assign n5054_o = {2'b0, o_poly_lum1};  //  uext
  /* ascal.vhd:2334:68  */
  assign n5056_o = 10'b0100000000 - n5054_o;
  /* ascal.vhd:2335:48  */
  assign n5057_o = {2'b0, o_poly_lum1};  //  uext
  /* ascal.vhd:1044:26  */
  assign n5068_o = o_poly_phase_a2[9:0];
  /* ascal.vhd:1044:29  */
  assign n5069_o = {{10{n5068_o[9]}}, n5068_o}; // sext
  /* ascal.vhd:1044:29  */
  assign n5070_o = {{10{o_poly_lerp_ta[9]}}, o_poly_lerp_ta}; // sext
  /* ascal.vhd:1044:29  */
  assign n5071_o = n5069_o * n5070_o; // smul
  /* ascal.vhd:1044:40  */
  assign n5072_o = o_poly_phase_b2[9:0];
  /* ascal.vhd:1044:43  */
  assign n5073_o = {{10{n5072_o[9]}}, n5072_o}; // sext
  /* ascal.vhd:1044:43  */
  assign n5074_o = {{10{o_poly_lerp_tb[9]}}, o_poly_lerp_tb}; // sext
  /* ascal.vhd:1044:43  */
  assign n5075_o = n5073_o * n5074_o; // smul
  /* ascal.vhd:1044:35  */
  assign n5076_o = n5071_o + n5075_o;
  /* ascal.vhd:1045:26  */
  assign n5078_o = o_poly_phase_a2[19:10];
  /* ascal.vhd:1045:29  */
  assign n5079_o = {{10{n5078_o[9]}}, n5078_o}; // sext
  /* ascal.vhd:1045:29  */
  assign n5080_o = {{10{o_poly_lerp_ta[9]}}, o_poly_lerp_ta}; // sext
  /* ascal.vhd:1045:29  */
  assign n5081_o = n5079_o * n5080_o; // smul
  /* ascal.vhd:1045:40  */
  assign n5082_o = o_poly_phase_b2[19:10];
  /* ascal.vhd:1045:43  */
  assign n5083_o = {{10{n5082_o[9]}}, n5082_o}; // sext
  /* ascal.vhd:1045:43  */
  assign n5084_o = {{10{o_poly_lerp_tb[9]}}, o_poly_lerp_tb}; // sext
  /* ascal.vhd:1045:43  */
  assign n5085_o = n5083_o * n5084_o; // smul
  /* ascal.vhd:1045:35  */
  assign n5086_o = n5081_o + n5085_o;
  /* ascal.vhd:1046:26  */
  assign n5088_o = o_poly_phase_a2[29:20];
  /* ascal.vhd:1046:29  */
  assign n5089_o = {{10{n5088_o[9]}}, n5088_o}; // sext
  /* ascal.vhd:1046:29  */
  assign n5090_o = {{10{o_poly_lerp_ta[9]}}, o_poly_lerp_ta}; // sext
  /* ascal.vhd:1046:29  */
  assign n5091_o = n5089_o * n5090_o; // smul
  /* ascal.vhd:1046:40  */
  assign n5092_o = o_poly_phase_b2[29:20];
  /* ascal.vhd:1046:43  */
  assign n5093_o = {{10{n5092_o[9]}}, n5092_o}; // sext
  /* ascal.vhd:1046:43  */
  assign n5094_o = {{10{o_poly_lerp_tb[9]}}, o_poly_lerp_tb}; // sext
  /* ascal.vhd:1046:43  */
  assign n5095_o = n5093_o * n5094_o; // smul
  /* ascal.vhd:1046:35  */
  assign n5096_o = n5091_o + n5095_o;
  /* ascal.vhd:1047:26  */
  assign n5098_o = o_poly_phase_a2[39:30];
  /* ascal.vhd:1047:29  */
  assign n5099_o = {{10{n5098_o[9]}}, n5098_o}; // sext
  /* ascal.vhd:1047:29  */
  assign n5100_o = {{10{o_poly_lerp_ta[9]}}, o_poly_lerp_ta}; // sext
  /* ascal.vhd:1047:29  */
  assign n5101_o = n5099_o * n5100_o; // smul
  /* ascal.vhd:1047:40  */
  assign n5102_o = o_poly_phase_b2[39:30];
  /* ascal.vhd:1047:43  */
  assign n5103_o = {{10{n5102_o[9]}}, n5102_o}; // sext
  /* ascal.vhd:1047:43  */
  assign n5104_o = {{10{o_poly_lerp_tb[9]}}, o_poly_lerp_tb}; // sext
  /* ascal.vhd:1047:43  */
  assign n5105_o = n5103_o * n5104_o; // smul
  /* ascal.vhd:1047:35  */
  assign n5106_o = n5101_o + n5105_o;
  /* ascal.vhd:1050:27  */
  assign n5108_o = n5076_o[18:1];
  /* ascal.vhd:1051:27  */
  assign n5111_o = n5086_o[18:1];
  /* ascal.vhd:1052:27  */
  assign n5113_o = n5096_o[18:1];
  /* ascal.vhd:1053:27  */
  assign n5115_o = n5106_o[18:1];
  assign n5116_o = {n5115_o, n5113_o, n5111_o, n5108_o};
  /* ascal.vhd:1061:42  */
  assign n5123_o = o_v_poly_phase_a5[9:0];
  /* ascal.vhd:1061:45  */
  assign n5125_o = {n5123_o, 7'b0000000};
  /* ascal.vhd:1061:25  */
  assign n5126_o = {{1{n5125_o[16]}}, n5125_o}; // sext
  /* ascal.vhd:1062:42  */
  assign n5129_o = o_v_poly_phase_a5[19:10];
  /* ascal.vhd:1062:45  */
  assign n5131_o = {n5129_o, 7'b0000000};
  /* ascal.vhd:1062:25  */
  assign n5132_o = {{1{n5131_o[16]}}, n5131_o}; // sext
  /* ascal.vhd:1063:42  */
  assign n5134_o = o_v_poly_phase_a5[29:20];
  /* ascal.vhd:1063:45  */
  assign n5136_o = {n5134_o, 7'b0000000};
  /* ascal.vhd:1063:25  */
  assign n5137_o = {{1{n5136_o[16]}}, n5136_o}; // sext
  /* ascal.vhd:1064:42  */
  assign n5139_o = o_v_poly_phase_a5[39:30];
  /* ascal.vhd:1064:45  */
  assign n5141_o = {n5139_o, 7'b0000000};
  /* ascal.vhd:1064:25  */
  assign n5142_o = {{1{n5141_o[16]}}, n5141_o}; // sext
  assign n5143_o = {n5142_o, n5137_o, n5132_o, n5126_o};
  /* ascal.vhd:1061:42  */
  assign n5150_o = o_h_poly_phase_a5[9:0];
  /* ascal.vhd:1061:45  */
  assign n5152_o = {n5150_o, 7'b0000000};
  /* ascal.vhd:1061:25  */
  assign n5153_o = {{1{n5152_o[16]}}, n5152_o}; // sext
  /* ascal.vhd:1062:42  */
  assign n5156_o = o_h_poly_phase_a5[19:10];
  /* ascal.vhd:1062:45  */
  assign n5158_o = {n5156_o, 7'b0000000};
  /* ascal.vhd:1062:25  */
  assign n5159_o = {{1{n5158_o[16]}}, n5158_o}; // sext
  /* ascal.vhd:1063:42  */
  assign n5161_o = o_h_poly_phase_a5[29:20];
  /* ascal.vhd:1063:45  */
  assign n5163_o = {n5161_o, 7'b0000000};
  /* ascal.vhd:1063:25  */
  assign n5164_o = {{1{n5163_o[16]}}, n5163_o}; // sext
  /* ascal.vhd:1064:42  */
  assign n5166_o = o_h_poly_phase_a5[39:30];
  /* ascal.vhd:1064:45  */
  assign n5168_o = {n5166_o, 7'b0000000};
  /* ascal.vhd:1064:25  */
  assign n5169_o = {{1{n5168_o[16]}}, n5168_o}; // sext
  assign n5170_o = {n5169_o, n5164_o, n5159_o, n5153_o};
  /* ascal.vhd:2359:25  */
  assign n5171_o = o_h_poly_use_adaptive ? o_poly_phase1 : n5170_o;
  /* ascal.vhd:2357:25  */
  assign n5172_o = o_v_poly_use_adaptive ? o_poly_phase1 : n5143_o;
  /* ascal.vhd:2357:25  */
  assign n5173_o = o_v_poly_use_adaptive ? n5170_o : n5171_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5203_q <= n5031_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5204_q <= n4921_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5205_q <= n4993_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5206_q <= o_h_poly_phase_a;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5207_q <= o_h_poly_phase_a2;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5208_q <= o_h_poly_phase_a3;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5209_q <= o_h_poly_phase_a4;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5210_q <= n4957_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5211_q <= o_v_poly_phase_a;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5212_q <= o_v_poly_phase_a2;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5213_q <= o_v_poly_phase_a3;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5214_q <= o_v_poly_phase_a4;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5215_q <= n5053_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5216_q <= o_poly_phase_a;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5217_q <= n5051_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5218_q <= o_poly_phase_b;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5219_q <= n5172_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5220_q <= n5173_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5221_q <= n5116_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5222_q <= o_poly_phase;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5223_q <= n5032_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5224_q <= o_poly_lum;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5225_q <= n5056_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5226_q <= n5057_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5227_q <= n4908_o;
  /* ascal.vhd:2291:17  */
  always @(posedge o_clk)
    n5228_q <= n4920_o;
  /* ascal.vhd:2371:25  */
  always @(posedge pal1_clk)
    n5245_q <= n8346_data;
  initial
    n5245_q <= 48'b000000000000000000000000000000000000000000000000;
  /* ascal.vhd:587:28  */
  assign n5253_o = o_format[2:0];
  /* ascal.vhd:589:54  */
  assign n5254_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:589:54  */
  assign n5256_o = n5254_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:589:46  */
  assign n5258_o = 1'b1 & n5256_o;
  /* ascal.vhd:589:58  */
  assign n5260_o = n5258_o | 1'b0;
  /* ascal.vhd:590:57  */
  assign n5261_o = o_dr[15:0];
  /* ascal.vhd:590:53  */
  assign n5262_o = {o_dr, n5261_o};
  /* ascal.vhd:592:55  */
  assign n5263_o = o_shift[135:0];
  /* ascal.vhd:592:74  */
  assign n5264_o = o_dr[7:0];
  /* ascal.vhd:592:70  */
  assign n5265_o = {n5263_o, n5264_o};
  /* ascal.vhd:589:33  */
  assign n5266_o = n5260_o ? n5262_o : n5265_o;
  /* ascal.vhd:588:25  */
  assign n5268_o = n5253_o == 3'b011;
  /* ascal.vhd:596:56  */
  assign n5269_o = {28'b0, o_acpt4};  //  uext
  assign n5270_o = n5269_o[2:0];
  /* ascal.vhd:596:56  */
  assign n5271_o = {29'b0, n5270_o};  //  uext
  /* ascal.vhd:596:62  */
  assign n5273_o = n5271_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:596:46  */
  assign n5275_o = 1'b1 & n5273_o;
  /* ascal.vhd:596:66  */
  assign n5277_o = n5275_o | 1'b0;
  /* ascal.vhd:597:57  */
  assign n5278_o = o_dr[15:0];
  /* ascal.vhd:597:53  */
  assign n5279_o = {o_dr, n5278_o};
  /* ascal.vhd:599:55  */
  assign n5280_o = o_shift[127:0];
  /* ascal.vhd:599:75  */
  assign n5281_o = o_dr[15:0];
  /* ascal.vhd:599:71  */
  assign n5282_o = {n5280_o, n5281_o};
  /* ascal.vhd:596:33  */
  assign n5283_o = n5277_o ? n5279_o : n5282_o;
  /* ascal.vhd:595:25  */
  assign n5285_o = n5253_o == 3'b100;
  /* ascal.vhd:604:48  */
  assign n5286_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:604:48  */
  assign n5288_o = n5286_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:605:65  */
  assign n5289_o = o_dr[15:0];
  /* ascal.vhd:605:61  */
  assign n5290_o = {o_dr, n5289_o};
  /* ascal.vhd:606:51  */
  assign n5291_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:606:51  */
  assign n5293_o = n5291_o == 32'b00000000000000000000000000000101;
  /* ascal.vhd:607:63  */
  assign n5294_o = o_shift[119:112];
  /* ascal.vhd:607:74  */
  assign n5295_o = {n5294_o, o_dr};
  /* ascal.vhd:607:83  */
  assign n5296_o = o_dr[7:0];
  /* ascal.vhd:607:79  */
  assign n5297_o = {n5295_o, n5296_o};
  /* ascal.vhd:608:51  */
  assign n5298_o = {28'b0, o_acpt4};  //  uext
  /* ascal.vhd:608:51  */
  assign n5300_o = n5298_o == 32'b00000000000000000000000000001010;
  /* ascal.vhd:609:63  */
  assign n5301_o = o_shift[119:104];
  /* ascal.vhd:609:74  */
  assign n5302_o = {n5301_o, o_dr};
  /* ascal.vhd:611:63  */
  assign n5303_o = o_shift[119:0];
  /* ascal.vhd:611:83  */
  assign n5304_o = o_dr[23:0];
  /* ascal.vhd:611:79  */
  assign n5305_o = {n5303_o, n5304_o};
  /* ascal.vhd:608:41  */
  assign n5306_o = n5300_o ? n5302_o : n5305_o;
  /* ascal.vhd:606:41  */
  assign n5307_o = n5293_o ? n5297_o : n5306_o;
  /* ascal.vhd:604:41  */
  assign n5308_o = n5288_o ? n5290_o : n5307_o;
  /* ascal.vhd:602:25  */
  assign n5310_o = n5253_o == 3'b101;
  /* ascal.vhd:625:56  */
  assign n5311_o = {28'b0, o_acpt4};  //  uext
  assign n5312_o = n5311_o[1:0];
  /* ascal.vhd:625:56  */
  assign n5313_o = {30'b0, n5312_o};  //  uext
  /* ascal.vhd:625:62  */
  assign n5315_o = n5313_o == 32'b00000000000000000000000000000000;
  /* ascal.vhd:625:46  */
  assign n5317_o = 1'b1 & n5315_o;
  /* ascal.vhd:625:66  */
  assign n5319_o = n5317_o | 1'b0;
  /* ascal.vhd:626:57  */
  assign n5320_o = o_dr[15:0];
  /* ascal.vhd:626:53  */
  assign n5321_o = {o_dr, n5320_o};
  /* ascal.vhd:628:55  */
  assign n5322_o = o_shift[111:0];
  /* ascal.vhd:628:75  */
  assign n5323_o = o_dr[31:0];
  /* ascal.vhd:628:71  */
  assign n5324_o = {n5322_o, n5323_o};
  /* ascal.vhd:625:33  */
  assign n5325_o = n5319_o ? n5321_o : n5324_o;
  assign n5326_o = {n5310_o, n5285_o, n5268_o};
  /* ascal.vhd:587:17  */
  always @*
    case (n5326_o)
      3'b100: n5327_o <= n5308_o;
      3'b010: n5327_o <= n5283_o;
      3'b001: n5327_o <= n5266_o;
    endcase
  /* ascal.vhd:2379:70  */
  assign n5329_o = n5327_o[143:136];
  /* ascal.vhd:2380:39  */
  assign n5330_o = pal_idx[0];
  /* ascal.vhd:2380:43  */
  always @(posedge o_clk)
    n5333_q <= n5330_o;
  /* ascal.vhd:2381:62  */
  assign n5334_o = pal_idx[7:1];
  /* ascal.vhd:2387:25  */
  always @(posedge pal2_clk)
    n5359_q <= n8350_data;
  initial
    n5359_q <= 24'b000000000000000000000000;
  /* ascal.vhd:2396:45  */
  assign n5369_o = pal_n ? o_fb_pal_dr2 : n5371_o;
  /* ascal.vhd:2396:81  */
  assign n5370_o = o_fb_pal_dr_x2[47:24];
  /* ascal.vhd:2396:62  */
  assign n5371_o = pal_idx_lsb ? n5370_o : n5372_o;
  /* ascal.vhd:2396:138  */
  assign n5372_o = o_fb_pal_dr_x2[23:0];
  /* ascal.vhd:2411:20  */
  assign n5374_o = 1'b0; // posedge
  /* ascal.vhd:2413:67  */
  assign n5375_o = poly_a[1:0];
  /* ascal.vhd:2413:41  */
  assign n5392_o = 2'b11 - n5375_o;
  /* ascal.vhd:2417:64  */
  assign n5396_o = poly_a[6];
  /* ascal.vhd:2417:54  */
  assign n5397_o = ~n5396_o;
  /* ascal.vhd:2417:50  */
  assign n5398_o = poly_wr & n5397_o;
  /* ascal.vhd:2418:60  */
  assign n5399_o = poly_a[6];
  /* ascal.vhd:2418:50  */
  assign n5400_o = poly_wr & n5399_o;
  /* ascal.vhd:2419:60  */
  assign n5401_o = poly_a[7];
  /* ascal.vhd:2419:50  */
  assign n5402_o = poly_wr & n5401_o;
  /* ascal.vhd:2419:69  */
  assign n5405_o = n5402_o & 1'b1;
  /* ascal.vhd:2420:40  */
  assign n5406_o = poly_a[5:2];
  /* ascal.vhd:2424:53  */
  assign n5409_o = 4'b1111 - poly_a2;
  /* ascal.vhd:2423:33  */
  assign n5413_o = poly_wr_mode == 3'b001;
  /* ascal.vhd:2427:53  */
  assign n5416_o = 4'b1111 - poly_a2;
  /* ascal.vhd:2426:33  */
  assign n5420_o = poly_wr_mode == 3'b010;
  /* ascal.vhd:2430:53  */
  assign n5423_o = 4'b1111 - poly_a2;
  /* ascal.vhd:2429:33  */
  assign n5427_o = poly_wr_mode == 3'b101;
  /* ascal.vhd:2433:53  */
  assign n5430_o = 4'b1111 - poly_a2;
  /* ascal.vhd:2432:33  */
  assign n5434_o = poly_wr_mode == 3'b110;
  assign n5435_o = {n5434_o, n5427_o, n5420_o, n5413_o};
  /* ascal.vhd:2422:25  */
  always @*
    case (n5435_o)
      4'b1000: n5436_o <= o_h_poly_mem;
      4'b0100: n5436_o <= o_h_poly_mem;
      4'b0010: n5436_o <= o_h_poly_mem;
      4'b0001: n5436_o <= n8531_o;
    endcase
  /* ascal.vhd:2422:25  */
  always @*
    case (n5435_o)
      4'b1000: n5437_o <= o_v_poly_mem;
      4'b0100: n5437_o <= o_v_poly_mem;
      4'b0010: n5437_o <= n8600_o;
      4'b0001: n5437_o <= o_v_poly_mem;
    endcase
  /* ascal.vhd:2422:25  */
  always @*
    case (n5435_o)
      4'b1000: n5438_o <= n8738_o;
      4'b0100: n5438_o <= n8669_o;
      4'b0010: n5438_o <= o_a_poly_mem;
      4'b0001: n5438_o <= o_a_poly_mem;
    endcase
  /* ascal.vhd:2422:25  */
  always @*
    case (n5435_o)
      4'b1000: n5441_o <= 1'b1;
      4'b0100: n5441_o <= o_v_poly_adaptive;
      4'b0010: n5441_o <= 1'b0;
      4'b0001: n5441_o <= o_v_poly_adaptive;
    endcase
  /* ascal.vhd:2422:25  */
  always @*
    case (n5435_o)
      4'b1000: n5444_o <= o_h_poly_adaptive;
      4'b0100: n5444_o <= 1'b1;
      4'b0010: n5444_o <= o_h_poly_adaptive;
      4'b0001: n5444_o <= 1'b0;
    endcase
  assign n5450_o = {n5405_o, n5400_o, n5398_o};
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5455_q <= n5436_o;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5456_q <= n5437_o;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5457_q <= n5438_o;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5458_q <= n5441_o;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5459_q <= n5444_o;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5460_q <= n5450_o;
  /* ascal.vhd:2412:25  */
  assign n5461_o = n5374_o & poly_wr;
  /* ascal.vhd:2411:17  */
  always @(posedge poly_clk)
    n5462_q <= n5406_o;
  /* ascal.vhd:2451:51  */
  assign n5467_o = {19'b0, o_hacc};  //  uext
  /* ascal.vhd:2451:51  */
  assign n5469_o = n5467_o * 32'b00000000000000000000000100000000; // smul
  /* ascal.vhd:2451:44  */
  assign n5470_o = n5469_o[30:0];  // trunc
  /* ascal.vhd:2451:32  */
  assign n5471_o = n5470_o[20:0];  // trunc
  /* ascal.vhd:2453:57  */
  assign n5472_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2453:57  */
  assign n5474_o = n5472_o * 32'b00000000000000000000000100000000; // smul
  /* ascal.vhd:2453:50  */
  assign n5475_o = n5474_o[30:0];  // trunc
  /* ascal.vhd:2453:38  */
  assign n5476_o = n5475_o[20:0];  // trunc
  /* ascal.vhd:2453:37  */
  assign n5477_o = n5471_o - n5476_o;
  /* ascal.vhd:2454:45  */
  assign n5478_o = n5477_o[20];
  /* ascal.vhd:2454:36  */
  assign n5479_o = ~n5478_o;
  /* ascal.vhd:2455:33  */
  assign n5482_o = n5477_o[20];
  /* ascal.vhd:2455:37  */
  assign n5483_o = ~n5482_o;
  /* ascal.vhd:2456:65  */
  assign n5484_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2456:65  */
  assign n5486_o = n5484_o * 32'b00000000000000000000000010000000; // smul
  /* ascal.vhd:2456:58  */
  assign n5487_o = n5486_o[30:0];  // trunc
  /* ascal.vhd:2456:46  */
  assign n5488_o = n5487_o[20:0];  // trunc
  /* ascal.vhd:2456:45  */
  assign n5489_o = n5477_o - n5488_o;
  /* ascal.vhd:2458:65  */
  assign n5490_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2458:65  */
  assign n5492_o = n5490_o * 32'b00000000000000000000000010000000; // smul
  /* ascal.vhd:2458:58  */
  assign n5493_o = n5492_o[30:0];  // trunc
  /* ascal.vhd:2458:46  */
  assign n5494_o = n5493_o[20:0];  // trunc
  /* ascal.vhd:2458:45  */
  assign n5495_o = n5477_o + n5494_o;
  /* ascal.vhd:2455:25  */
  assign n5496_o = n5483_o ? n5489_o : n5495_o;
  /* ascal.vhd:2460:45  */
  assign n5497_o = n5496_o[20];
  /* ascal.vhd:2460:36  */
  assign n5498_o = ~n5497_o;
  assign n5499_o = n5480_o[9:0];
  assign n5500_o = {n5479_o, n5498_o, n5499_o};
  /* ascal.vhd:2466:37  */
  assign n5501_o = o_div[62:42];
  /* ascal.vhd:2468:33  */
  assign n5503_o = n5501_o[20];
  /* ascal.vhd:2468:37  */
  assign n5504_o = ~n5503_o;
  /* ascal.vhd:2469:65  */
  assign n5505_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2469:65  */
  assign n5507_o = n5505_o * 32'b00000000000000000000000001000000; // smul
  /* ascal.vhd:2469:58  */
  assign n5508_o = n5507_o[30:0];  // trunc
  /* ascal.vhd:2469:46  */
  assign n5509_o = n5508_o[20:0];  // trunc
  /* ascal.vhd:2469:45  */
  assign n5510_o = n5501_o - n5509_o;
  /* ascal.vhd:2471:65  */
  assign n5511_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2471:65  */
  assign n5513_o = n5511_o * 32'b00000000000000000000000001000000; // smul
  /* ascal.vhd:2471:58  */
  assign n5514_o = n5513_o[30:0];  // trunc
  /* ascal.vhd:2471:46  */
  assign n5515_o = n5514_o[20:0];  // trunc
  /* ascal.vhd:2471:45  */
  assign n5516_o = n5501_o + n5515_o;
  /* ascal.vhd:2468:25  */
  assign n5517_o = n5504_o ? n5510_o : n5516_o;
  /* ascal.vhd:2473:45  */
  assign n5518_o = n5517_o[20];
  /* ascal.vhd:2473:36  */
  assign n5519_o = ~n5518_o;
  assign n5520_o = o_dir[35:34];
  /* ascal.vhd:2475:33  */
  assign n5522_o = n5517_o[20];
  /* ascal.vhd:2475:37  */
  assign n5523_o = ~n5522_o;
  /* ascal.vhd:2476:65  */
  assign n5524_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2476:65  */
  assign n5526_o = n5524_o * 32'b00000000000000000000000000100000; // smul
  /* ascal.vhd:2476:58  */
  assign n5527_o = n5526_o[30:0];  // trunc
  /* ascal.vhd:2476:46  */
  assign n5528_o = n5527_o[20:0];  // trunc
  /* ascal.vhd:2476:45  */
  assign n5529_o = n5517_o - n5528_o;
  /* ascal.vhd:2478:65  */
  assign n5530_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2478:65  */
  assign n5532_o = n5530_o * 32'b00000000000000000000000000100000; // smul
  /* ascal.vhd:2478:58  */
  assign n5533_o = n5532_o[30:0];  // trunc
  /* ascal.vhd:2478:46  */
  assign n5534_o = n5533_o[20:0];  // trunc
  /* ascal.vhd:2478:45  */
  assign n5535_o = n5517_o + n5534_o;
  /* ascal.vhd:2475:25  */
  assign n5536_o = n5523_o ? n5529_o : n5535_o;
  /* ascal.vhd:2480:45  */
  assign n5537_o = n5536_o[20];
  /* ascal.vhd:2480:36  */
  assign n5538_o = ~n5537_o;
  assign n5539_o = o_dir[31:24];
  assign n5540_o = {n5520_o, n5519_o, n5538_o, n5539_o};
  /* ascal.vhd:2486:37  */
  assign n5541_o = o_div[41:21];
  /* ascal.vhd:2487:37  */
  assign n5542_o = o_dir[23:12];
  /* ascal.vhd:2507:37  */
  assign n5544_o = o_dir[11:0];
  /* ascal.vhd:2526:51  */
  assign n5545_o = o_hfrac[107:12];
  /* ascal.vhd:2531:35  */
  assign n5547_o = o_dcptv[167:156];
  /* ascal.vhd:2531:38  */
  assign n5548_o = {20'b0, n5547_o};  //  uext
  /* ascal.vhd:2531:38  */
  assign n5549_o = {20'b0, o_hsize};  //  uext
  /* ascal.vhd:2531:38  */
  assign n5550_o = $signed(n5548_o) >= $signed(n5549_o);
  assign n5552_o = o_copyv[13];
  /* ascal.vhd:2531:25  */
  assign n5553_o = n5550_o ? 1'b0 : n5552_o;
  assign n5554_o = o_copyv[14];
  assign n5555_o = o_copyv[12:1];
  /* ascal.vhd:2534:44  */
  assign n5556_o = o_dcptv[167:156];
  /* ascal.vhd:2534:48  */
  assign n5557_o = {20'b0, n5556_o};  //  uext
  assign n5558_o = n5557_o[10:0];
  /* ascal.vhd:2534:37  */
  assign n5560_o = {1'b0, n5558_o};  //  uext
  /* ascal.vhd:2535:50  */
  assign n5561_o = o_dcptv[155:12];
  assign n5562_o = {o_hpix3, o_hpix2, o_hpix1, o_hpix0};
  /* ascal.vhd:2539:49  */
  assign n5563_o = o_hpixq[671:96];
  /* ascal.vhd:2543:55  */
  assign n5565_o = o_hfrac[47:36];
  /* ascal.vhd:806:21  */
  assign n5573_o = n5565_o[11];
  /* ascal.vhd:806:25  */
  assign n5574_o = ~n5573_o;
  /* ascal.vhd:807:29  */
  assign n5575_o = n5565_o[11:8];
  /* ascal.vhd:809:33  */
  assign n5576_o = n5565_o[11:8];
  /* ascal.vhd:809:28  */
  assign n5577_o = ~n5576_o;
  /* ascal.vhd:806:17  */
  assign n5578_o = n5574_o ? n5575_o : n5577_o;
  /* ascal.vhd:811:21  */
  assign n5580_o = {4'b0, n5578_o};  //  uext
  /* ascal.vhd:811:21  */
  assign n5581_o = {4'b0, n5578_o};  //  uext
  /* ascal.vhd:811:21  */
  assign n5582_o = n5580_o * n5581_o; // smul
  /* ascal.vhd:813:23  */
  assign n5586_o = n5582_o[6:3];
  assign n5587_o = {n5586_o, n5578_o};
  /* ascal.vhd:2547:35  */
  assign n5588_o = o_hmode[0];
  /* ascal.vhd:2549:71  */
  assign n5590_o = o_hfrac[35:24];
  /* ascal.vhd:741:25  */
  assign n5595_o = n5590_o[11:8];
  /* ascal.vhd:2553:73  */
  assign n5597_o = o_hfrac[35:24];
  /* ascal.vhd:821:22  */
  assign n5603_o = o_h_sbil_t[3:0];
  /* ascal.vhd:821:26  */
  assign n5604_o = o_h_sbil_t[7:4];
  /* ascal.vhd:821:23  */
  assign n5605_o = {4'b0, n5603_o};  //  uext
  /* ascal.vhd:821:23  */
  assign n5606_o = {4'b0, n5604_o};  //  uext
  /* ascal.vhd:821:23  */
  assign n5607_o = n5605_o * n5606_o; // smul
  /* ascal.vhd:822:21  */
  assign n5609_o = n5597_o[11];
  /* ascal.vhd:822:25  */
  assign n5610_o = ~n5609_o;
  /* ascal.vhd:823:33  */
  assign n5611_o = n5607_o[6:3];
  /* ascal.vhd:825:37  */
  assign n5612_o = n5607_o[6:3];
  /* ascal.vhd:825:32  */
  assign n5613_o = ~n5612_o;
  /* ascal.vhd:822:17  */
  assign n5614_o = n5610_o ? n5611_o : n5613_o;
  /* ascal.vhd:2547:25  */
  assign n5615_o = n5588_o ? n5595_o : n5614_o;
  /* ascal.vhd:2558:65  */
  assign n5618_o = o_hpixq[95:0];
  /* ascal.vhd:755:26  */
  assign n5628_o = {1'b0, o_h_bil_frac};
  /* ascal.vhd:755:39  */
  assign n5629_o = o_h_bil_frac[3];
  /* ascal.vhd:755:36  */
  assign n5631_o = {4'b0000, n5629_o};
  /* ascal.vhd:755:31  */
  assign n5632_o = n5628_o + n5631_o;
  /* ascal.vhd:756:31  */
  assign n5635_o = 5'b10000 - n5632_o;
  /* ascal.vhd:757:21  */
  assign n5637_o = n5618_o[47:24];
  /* ascal.vhd:757:25  */
  assign n5638_o = n5637_o[7:0];
  /* ascal.vhd:757:27  */
  assign n5639_o = {5'b0, n5638_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n5640_o = {8'b0, n5632_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n5641_o = n5639_o * n5640_o; // smul
  /* ascal.vhd:757:35  */
  assign n5642_o = n5618_o[71:48];
  /* ascal.vhd:757:39  */
  assign n5643_o = n5642_o[7:0];
  /* ascal.vhd:757:41  */
  assign n5644_o = {5'b0, n5643_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n5645_o = {8'b0, n5635_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n5646_o = n5644_o * n5645_o; // smul
  /* ascal.vhd:757:32  */
  assign n5647_o = n5641_o + n5646_o;
  /* ascal.vhd:759:21  */
  assign n5651_o = n5618_o[47:24];
  /* ascal.vhd:759:25  */
  assign n5652_o = n5651_o[15:8];
  /* ascal.vhd:759:27  */
  assign n5653_o = {5'b0, n5652_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n5654_o = {8'b0, n5632_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n5655_o = n5653_o * n5654_o; // smul
  /* ascal.vhd:759:35  */
  assign n5656_o = n5618_o[71:48];
  /* ascal.vhd:759:39  */
  assign n5657_o = n5656_o[15:8];
  /* ascal.vhd:759:41  */
  assign n5658_o = {5'b0, n5657_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n5659_o = {8'b0, n5635_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n5660_o = n5658_o * n5659_o; // smul
  /* ascal.vhd:759:32  */
  assign n5661_o = n5655_o + n5660_o;
  /* ascal.vhd:761:21  */
  assign n5663_o = n5618_o[47:24];
  /* ascal.vhd:761:25  */
  assign n5664_o = n5663_o[23:16];
  /* ascal.vhd:761:27  */
  assign n5665_o = {5'b0, n5664_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n5666_o = {8'b0, n5632_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n5667_o = n5665_o * n5666_o; // smul
  /* ascal.vhd:761:35  */
  assign n5668_o = n5618_o[71:48];
  /* ascal.vhd:761:39  */
  assign n5669_o = n5668_o[23:16];
  /* ascal.vhd:761:41  */
  assign n5670_o = {5'b0, n5669_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n5671_o = {8'b0, n5635_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n5672_o = n5670_o * n5671_o; // smul
  /* ascal.vhd:761:32  */
  assign n5673_o = n5667_o + n5672_o;
  assign n5674_o = {n5673_o, n5661_o, n5647_o};
  /* ascal.vhd:2561:56  */
  assign n5676_o = o_h_bil_t[12:0];
  /* ascal.vhd:715:21  */
  assign n5681_o = n5676_o[12];
  /* ascal.vhd:717:24  */
  assign n5683_o = n5676_o[12];
  /* ascal.vhd:717:41  */
  assign n5685_o = n5683_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n5687_o = n5676_o[11:4];
  /* ascal.vhd:717:17  */
  assign n5688_o = n5685_o ? 8'b11111111 : n5687_o;
  /* ascal.vhd:715:17  */
  assign n5689_o = n5681_o ? 8'b00000000 : n5688_o;
  /* ascal.vhd:2562:56  */
  assign n5691_o = o_h_bil_t[25:13];
  /* ascal.vhd:715:21  */
  assign n5696_o = n5691_o[12];
  /* ascal.vhd:717:24  */
  assign n5698_o = n5691_o[12];
  /* ascal.vhd:717:41  */
  assign n5700_o = n5698_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n5702_o = n5691_o[11:4];
  /* ascal.vhd:717:17  */
  assign n5703_o = n5700_o ? 8'b11111111 : n5702_o;
  /* ascal.vhd:715:17  */
  assign n5704_o = n5696_o ? 8'b00000000 : n5703_o;
  /* ascal.vhd:2563:56  */
  assign n5706_o = o_h_bil_t[38:26];
  /* ascal.vhd:715:21  */
  assign n5711_o = n5706_o[12];
  /* ascal.vhd:717:24  */
  assign n5713_o = n5706_o[12];
  /* ascal.vhd:717:41  */
  assign n5715_o = n5713_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n5717_o = n5706_o[11:4];
  /* ascal.vhd:717:17  */
  assign n5718_o = n5715_o ? 8'b11111111 : n5717_o;
  /* ascal.vhd:715:17  */
  assign n5719_o = n5711_o ? 8'b00000000 : n5718_o;
  /* ascal.vhd:2568:57  */
  assign n5721_o = o_hfrac[35:24];
  /* ascal.vhd:2568:68  */
  assign n5722_o = o_hpixq[287:192];
  /* ascal.vhd:876:60  */
  assign n5728_o = n5722_o[95:72];
  /* ascal.vhd:876:64  */
  assign n5729_o = n5728_o[7:0];
  /* ascal.vhd:876:67  */
  assign n5730_o = n5722_o[71:48];
  /* ascal.vhd:876:71  */
  assign n5731_o = n5730_o[7:0];
  /* ascal.vhd:876:74  */
  assign n5732_o = n5722_o[47:24];
  /* ascal.vhd:876:78  */
  assign n5733_o = n5732_o[7:0];
  /* ascal.vhd:876:81  */
  assign n5734_o = n5722_o[23:0];
  /* ascal.vhd:876:85  */
  assign n5735_o = n5734_o[7:0];
  /* ascal.vhd:862:37  */
  assign n5741_o = n5721_o[11:8];
  /* ascal.vhd:862:34  */
  assign n5743_o = {1'b0, n5741_o};
  /* ascal.vhd:863:47  */
  assign n5744_o = n5721_o[11:8];
  /* ascal.vhd:863:44  */
  assign n5746_o = {1'b0, n5744_o};
  /* ascal.vhd:862:58  */
  assign n5747_o = {{5{n5743_o[4]}}, n5743_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5748_o = {{5{n5746_o[4]}}, n5746_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5749_o = n5747_o * n5748_o; // smul
  /* ascal.vhd:866:40  */
  assign n5752_o = {1'b0, n5733_o};
  /* ascal.vhd:866:53  */
  assign n5754_o = {1'b0, n5729_o};
  /* ascal.vhd:866:46  */
  assign n5755_o = n5752_o - n5754_o;
  /* ascal.vhd:867:42  */
  assign n5757_o = {3'b000, n5729_o};
  /* ascal.vhd:867:47  */
  assign n5759_o = {n5757_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n5761_o = {2'b00, n5731_o};
  /* ascal.vhd:867:67  */
  assign n5763_o = {n5761_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n5764_o = n5759_o - n5763_o;
  /* ascal.vhd:867:85  */
  assign n5766_o = {4'b0000, n5731_o};
  /* ascal.vhd:867:75  */
  assign n5767_o = n5764_o - n5766_o;
  /* ascal.vhd:868:56  */
  assign n5769_o = {2'b00, n5733_o};
  /* ascal.vhd:868:61  */
  assign n5771_o = {n5769_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n5772_o = n5767_o + n5771_o;
  /* ascal.vhd:868:79  */
  assign n5774_o = {4'b0000, n5735_o};
  /* ascal.vhd:868:69  */
  assign n5775_o = n5772_o - n5774_o;
  /* ascal.vhd:869:41  */
  assign n5777_o = {2'b00, n5731_o};
  /* ascal.vhd:869:46  */
  assign n5779_o = {n5777_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n5781_o = {2'b00, n5733_o};
  /* ascal.vhd:869:66  */
  assign n5783_o = {n5781_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n5784_o = n5779_o - n5783_o;
  /* ascal.vhd:869:82  */
  assign n5786_o = {3'b000, n5733_o};
  /* ascal.vhd:869:73  */
  assign n5787_o = n5784_o - n5786_o;
  /* ascal.vhd:870:57  */
  assign n5789_o = {3'b000, n5731_o};
  /* ascal.vhd:869:88  */
  assign n5790_o = n5787_o + n5789_o;
  /* ascal.vhd:870:72  */
  assign n5792_o = {3'b000, n5735_o};
  /* ascal.vhd:870:63  */
  assign n5793_o = n5790_o + n5792_o;
  /* ascal.vhd:870:87  */
  assign n5795_o = {3'b000, n5729_o};
  /* ascal.vhd:870:78  */
  assign n5796_o = n5793_o - n5795_o;
  /* ascal.vhd:871:31  */
  assign n5797_o = n5749_o[8:0];
  assign n5798_o = {n5797_o, n5796_o, n5775_o, n5755_o};
  assign n5799_o = {n5798_o, n5731_o};
  /* ascal.vhd:877:105  */
  assign n5801_o = n5722_o[95:72];
  /* ascal.vhd:877:109  */
  assign n5802_o = n5801_o[15:8];
  /* ascal.vhd:877:112  */
  assign n5803_o = n5722_o[71:48];
  /* ascal.vhd:877:116  */
  assign n5804_o = n5803_o[15:8];
  /* ascal.vhd:877:119  */
  assign n5805_o = n5722_o[47:24];
  /* ascal.vhd:877:123  */
  assign n5806_o = n5805_o[15:8];
  /* ascal.vhd:877:126  */
  assign n5807_o = n5722_o[23:0];
  /* ascal.vhd:877:130  */
  assign n5808_o = n5807_o[15:8];
  /* ascal.vhd:862:37  */
  assign n5814_o = n5721_o[11:8];
  /* ascal.vhd:862:34  */
  assign n5816_o = {1'b0, n5814_o};
  /* ascal.vhd:863:47  */
  assign n5817_o = n5721_o[11:8];
  /* ascal.vhd:863:44  */
  assign n5819_o = {1'b0, n5817_o};
  /* ascal.vhd:862:58  */
  assign n5820_o = {{5{n5816_o[4]}}, n5816_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5821_o = {{5{n5819_o[4]}}, n5819_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5822_o = n5820_o * n5821_o; // smul
  /* ascal.vhd:866:40  */
  assign n5825_o = {1'b0, n5806_o};
  /* ascal.vhd:866:53  */
  assign n5827_o = {1'b0, n5802_o};
  /* ascal.vhd:866:46  */
  assign n5828_o = n5825_o - n5827_o;
  /* ascal.vhd:867:42  */
  assign n5830_o = {3'b000, n5802_o};
  /* ascal.vhd:867:47  */
  assign n5832_o = {n5830_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n5834_o = {2'b00, n5804_o};
  /* ascal.vhd:867:67  */
  assign n5836_o = {n5834_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n5837_o = n5832_o - n5836_o;
  /* ascal.vhd:867:85  */
  assign n5839_o = {4'b0000, n5804_o};
  /* ascal.vhd:867:75  */
  assign n5840_o = n5837_o - n5839_o;
  /* ascal.vhd:868:56  */
  assign n5842_o = {2'b00, n5806_o};
  /* ascal.vhd:868:61  */
  assign n5844_o = {n5842_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n5845_o = n5840_o + n5844_o;
  /* ascal.vhd:868:79  */
  assign n5847_o = {4'b0000, n5808_o};
  /* ascal.vhd:868:69  */
  assign n5848_o = n5845_o - n5847_o;
  /* ascal.vhd:869:41  */
  assign n5850_o = {2'b00, n5804_o};
  /* ascal.vhd:869:46  */
  assign n5852_o = {n5850_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n5854_o = {2'b00, n5806_o};
  /* ascal.vhd:869:66  */
  assign n5856_o = {n5854_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n5857_o = n5852_o - n5856_o;
  /* ascal.vhd:869:82  */
  assign n5859_o = {3'b000, n5806_o};
  /* ascal.vhd:869:73  */
  assign n5860_o = n5857_o - n5859_o;
  /* ascal.vhd:870:57  */
  assign n5862_o = {3'b000, n5804_o};
  /* ascal.vhd:869:88  */
  assign n5863_o = n5860_o + n5862_o;
  /* ascal.vhd:870:72  */
  assign n5865_o = {3'b000, n5808_o};
  /* ascal.vhd:870:63  */
  assign n5866_o = n5863_o + n5865_o;
  /* ascal.vhd:870:87  */
  assign n5868_o = {3'b000, n5802_o};
  /* ascal.vhd:870:78  */
  assign n5869_o = n5866_o - n5868_o;
  /* ascal.vhd:871:31  */
  assign n5870_o = n5822_o[8:0];
  assign n5871_o = {n5870_o, n5869_o, n5848_o, n5828_o};
  assign n5872_o = {n5871_o, n5804_o};
  /* ascal.vhd:878:105  */
  assign n5874_o = n5722_o[95:72];
  /* ascal.vhd:878:109  */
  assign n5875_o = n5874_o[23:16];
  /* ascal.vhd:878:112  */
  assign n5876_o = n5722_o[71:48];
  /* ascal.vhd:878:116  */
  assign n5877_o = n5876_o[23:16];
  /* ascal.vhd:878:119  */
  assign n5878_o = n5722_o[47:24];
  /* ascal.vhd:878:123  */
  assign n5879_o = n5878_o[23:16];
  /* ascal.vhd:878:126  */
  assign n5880_o = n5722_o[23:0];
  /* ascal.vhd:878:130  */
  assign n5881_o = n5880_o[23:16];
  /* ascal.vhd:862:37  */
  assign n5887_o = n5721_o[11:8];
  /* ascal.vhd:862:34  */
  assign n5889_o = {1'b0, n5887_o};
  /* ascal.vhd:863:47  */
  assign n5890_o = n5721_o[11:8];
  /* ascal.vhd:863:44  */
  assign n5892_o = {1'b0, n5890_o};
  /* ascal.vhd:862:58  */
  assign n5893_o = {{5{n5889_o[4]}}, n5889_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5894_o = {{5{n5892_o[4]}}, n5892_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5895_o = n5893_o * n5894_o; // smul
  /* ascal.vhd:866:40  */
  assign n5898_o = {1'b0, n5879_o};
  /* ascal.vhd:866:53  */
  assign n5900_o = {1'b0, n5875_o};
  /* ascal.vhd:866:46  */
  assign n5901_o = n5898_o - n5900_o;
  /* ascal.vhd:867:42  */
  assign n5903_o = {3'b000, n5875_o};
  /* ascal.vhd:867:47  */
  assign n5905_o = {n5903_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n5907_o = {2'b00, n5877_o};
  /* ascal.vhd:867:67  */
  assign n5909_o = {n5907_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n5910_o = n5905_o - n5909_o;
  /* ascal.vhd:867:85  */
  assign n5912_o = {4'b0000, n5877_o};
  /* ascal.vhd:867:75  */
  assign n5913_o = n5910_o - n5912_o;
  /* ascal.vhd:868:56  */
  assign n5915_o = {2'b00, n5879_o};
  /* ascal.vhd:868:61  */
  assign n5917_o = {n5915_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n5918_o = n5913_o + n5917_o;
  /* ascal.vhd:868:79  */
  assign n5920_o = {4'b0000, n5881_o};
  /* ascal.vhd:868:69  */
  assign n5921_o = n5918_o - n5920_o;
  /* ascal.vhd:869:41  */
  assign n5923_o = {2'b00, n5877_o};
  /* ascal.vhd:869:46  */
  assign n5925_o = {n5923_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n5927_o = {2'b00, n5879_o};
  /* ascal.vhd:869:66  */
  assign n5929_o = {n5927_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n5930_o = n5925_o - n5929_o;
  /* ascal.vhd:869:82  */
  assign n5932_o = {3'b000, n5879_o};
  /* ascal.vhd:869:73  */
  assign n5933_o = n5930_o - n5932_o;
  /* ascal.vhd:870:57  */
  assign n5935_o = {3'b000, n5877_o};
  /* ascal.vhd:869:88  */
  assign n5936_o = n5933_o + n5935_o;
  /* ascal.vhd:870:72  */
  assign n5938_o = {3'b000, n5881_o};
  /* ascal.vhd:870:63  */
  assign n5939_o = n5936_o + n5938_o;
  /* ascal.vhd:870:87  */
  assign n5941_o = {3'b000, n5875_o};
  /* ascal.vhd:870:78  */
  assign n5942_o = n5939_o - n5941_o;
  /* ascal.vhd:871:31  */
  assign n5943_o = n5895_o[8:0];
  assign n5944_o = {n5943_o, n5942_o, n5921_o, n5901_o};
  assign n5945_o = {n5944_o, n5877_o};
  assign n5946_o = {n5945_o, n5872_o, n5799_o};
  /* ascal.vhd:2569:55  */
  assign n5948_o = o_hfrac[35:24];
  /* ascal.vhd:2570:99  */
  assign n5950_o = o_hfrac[35:24];
  /* ascal.vhd:2570:110  */
  assign n5951_o = o_hpixq[287:192];
  /* ascal.vhd:876:60  */
  assign n5957_o = n5951_o[95:72];
  /* ascal.vhd:876:64  */
  assign n5958_o = n5957_o[7:0];
  /* ascal.vhd:876:67  */
  assign n5959_o = n5951_o[71:48];
  /* ascal.vhd:876:71  */
  assign n5960_o = n5959_o[7:0];
  /* ascal.vhd:876:74  */
  assign n5961_o = n5951_o[47:24];
  /* ascal.vhd:876:78  */
  assign n5962_o = n5961_o[7:0];
  /* ascal.vhd:876:81  */
  assign n5963_o = n5951_o[23:0];
  /* ascal.vhd:876:85  */
  assign n5964_o = n5963_o[7:0];
  /* ascal.vhd:862:37  */
  assign n5970_o = n5950_o[11:8];
  /* ascal.vhd:862:34  */
  assign n5972_o = {1'b0, n5970_o};
  /* ascal.vhd:863:47  */
  assign n5973_o = n5950_o[11:8];
  /* ascal.vhd:863:44  */
  assign n5975_o = {1'b0, n5973_o};
  /* ascal.vhd:862:58  */
  assign n5976_o = {{5{n5972_o[4]}}, n5972_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5977_o = {{5{n5975_o[4]}}, n5975_o}; // sext
  /* ascal.vhd:862:58  */
  assign n5978_o = n5976_o * n5977_o; // smul
  /* ascal.vhd:866:40  */
  assign n5981_o = {1'b0, n5962_o};
  /* ascal.vhd:866:53  */
  assign n5983_o = {1'b0, n5958_o};
  /* ascal.vhd:866:46  */
  assign n5984_o = n5981_o - n5983_o;
  /* ascal.vhd:867:42  */
  assign n5986_o = {3'b000, n5958_o};
  /* ascal.vhd:867:47  */
  assign n5988_o = {n5986_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n5990_o = {2'b00, n5960_o};
  /* ascal.vhd:867:67  */
  assign n5992_o = {n5990_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n5993_o = n5988_o - n5992_o;
  /* ascal.vhd:867:85  */
  assign n5995_o = {4'b0000, n5960_o};
  /* ascal.vhd:867:75  */
  assign n5996_o = n5993_o - n5995_o;
  /* ascal.vhd:868:56  */
  assign n5998_o = {2'b00, n5962_o};
  /* ascal.vhd:868:61  */
  assign n6000_o = {n5998_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n6001_o = n5996_o + n6000_o;
  /* ascal.vhd:868:79  */
  assign n6003_o = {4'b0000, n5964_o};
  /* ascal.vhd:868:69  */
  assign n6004_o = n6001_o - n6003_o;
  /* ascal.vhd:869:41  */
  assign n6006_o = {2'b00, n5960_o};
  /* ascal.vhd:869:46  */
  assign n6008_o = {n6006_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n6010_o = {2'b00, n5962_o};
  /* ascal.vhd:869:66  */
  assign n6012_o = {n6010_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n6013_o = n6008_o - n6012_o;
  /* ascal.vhd:869:82  */
  assign n6015_o = {3'b000, n5962_o};
  /* ascal.vhd:869:73  */
  assign n6016_o = n6013_o - n6015_o;
  /* ascal.vhd:870:57  */
  assign n6018_o = {3'b000, n5960_o};
  /* ascal.vhd:869:88  */
  assign n6019_o = n6016_o + n6018_o;
  /* ascal.vhd:870:72  */
  assign n6021_o = {3'b000, n5964_o};
  /* ascal.vhd:870:63  */
  assign n6022_o = n6019_o + n6021_o;
  /* ascal.vhd:870:87  */
  assign n6024_o = {3'b000, n5958_o};
  /* ascal.vhd:870:78  */
  assign n6025_o = n6022_o - n6024_o;
  /* ascal.vhd:871:31  */
  assign n6026_o = n5978_o[8:0];
  assign n6027_o = {n6026_o, n6025_o, n6004_o, n5984_o};
  assign n6028_o = {n6027_o, n5960_o};
  /* ascal.vhd:877:105  */
  assign n6030_o = n5951_o[95:72];
  /* ascal.vhd:877:109  */
  assign n6031_o = n6030_o[15:8];
  /* ascal.vhd:877:112  */
  assign n6032_o = n5951_o[71:48];
  /* ascal.vhd:877:116  */
  assign n6033_o = n6032_o[15:8];
  /* ascal.vhd:877:119  */
  assign n6034_o = n5951_o[47:24];
  /* ascal.vhd:877:123  */
  assign n6035_o = n6034_o[15:8];
  /* ascal.vhd:877:126  */
  assign n6036_o = n5951_o[23:0];
  /* ascal.vhd:877:130  */
  assign n6037_o = n6036_o[15:8];
  /* ascal.vhd:862:37  */
  assign n6043_o = n5950_o[11:8];
  /* ascal.vhd:862:34  */
  assign n6045_o = {1'b0, n6043_o};
  /* ascal.vhd:863:47  */
  assign n6046_o = n5950_o[11:8];
  /* ascal.vhd:863:44  */
  assign n6048_o = {1'b0, n6046_o};
  /* ascal.vhd:862:58  */
  assign n6049_o = {{5{n6045_o[4]}}, n6045_o}; // sext
  /* ascal.vhd:862:58  */
  assign n6050_o = {{5{n6048_o[4]}}, n6048_o}; // sext
  /* ascal.vhd:862:58  */
  assign n6051_o = n6049_o * n6050_o; // smul
  /* ascal.vhd:866:40  */
  assign n6054_o = {1'b0, n6035_o};
  /* ascal.vhd:866:53  */
  assign n6056_o = {1'b0, n6031_o};
  /* ascal.vhd:866:46  */
  assign n6057_o = n6054_o - n6056_o;
  /* ascal.vhd:867:42  */
  assign n6059_o = {3'b000, n6031_o};
  /* ascal.vhd:867:47  */
  assign n6061_o = {n6059_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n6063_o = {2'b00, n6033_o};
  /* ascal.vhd:867:67  */
  assign n6065_o = {n6063_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n6066_o = n6061_o - n6065_o;
  /* ascal.vhd:867:85  */
  assign n6068_o = {4'b0000, n6033_o};
  /* ascal.vhd:867:75  */
  assign n6069_o = n6066_o - n6068_o;
  /* ascal.vhd:868:56  */
  assign n6071_o = {2'b00, n6035_o};
  /* ascal.vhd:868:61  */
  assign n6073_o = {n6071_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n6074_o = n6069_o + n6073_o;
  /* ascal.vhd:868:79  */
  assign n6076_o = {4'b0000, n6037_o};
  /* ascal.vhd:868:69  */
  assign n6077_o = n6074_o - n6076_o;
  /* ascal.vhd:869:41  */
  assign n6079_o = {2'b00, n6033_o};
  /* ascal.vhd:869:46  */
  assign n6081_o = {n6079_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n6083_o = {2'b00, n6035_o};
  /* ascal.vhd:869:66  */
  assign n6085_o = {n6083_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n6086_o = n6081_o - n6085_o;
  /* ascal.vhd:869:82  */
  assign n6088_o = {3'b000, n6035_o};
  /* ascal.vhd:869:73  */
  assign n6089_o = n6086_o - n6088_o;
  /* ascal.vhd:870:57  */
  assign n6091_o = {3'b000, n6033_o};
  /* ascal.vhd:869:88  */
  assign n6092_o = n6089_o + n6091_o;
  /* ascal.vhd:870:72  */
  assign n6094_o = {3'b000, n6037_o};
  /* ascal.vhd:870:63  */
  assign n6095_o = n6092_o + n6094_o;
  /* ascal.vhd:870:87  */
  assign n6097_o = {3'b000, n6031_o};
  /* ascal.vhd:870:78  */
  assign n6098_o = n6095_o - n6097_o;
  /* ascal.vhd:871:31  */
  assign n6099_o = n6051_o[8:0];
  assign n6100_o = {n6099_o, n6098_o, n6077_o, n6057_o};
  assign n6101_o = {n6100_o, n6033_o};
  /* ascal.vhd:878:105  */
  assign n6103_o = n5951_o[95:72];
  /* ascal.vhd:878:109  */
  assign n6104_o = n6103_o[23:16];
  /* ascal.vhd:878:112  */
  assign n6105_o = n5951_o[71:48];
  /* ascal.vhd:878:116  */
  assign n6106_o = n6105_o[23:16];
  /* ascal.vhd:878:119  */
  assign n6107_o = n5951_o[47:24];
  /* ascal.vhd:878:123  */
  assign n6108_o = n6107_o[23:16];
  /* ascal.vhd:878:126  */
  assign n6109_o = n5951_o[23:0];
  /* ascal.vhd:878:130  */
  assign n6110_o = n6109_o[23:16];
  /* ascal.vhd:862:37  */
  assign n6116_o = n5950_o[11:8];
  /* ascal.vhd:862:34  */
  assign n6118_o = {1'b0, n6116_o};
  /* ascal.vhd:863:47  */
  assign n6119_o = n5950_o[11:8];
  /* ascal.vhd:863:44  */
  assign n6121_o = {1'b0, n6119_o};
  /* ascal.vhd:862:58  */
  assign n6122_o = {{5{n6118_o[4]}}, n6118_o}; // sext
  /* ascal.vhd:862:58  */
  assign n6123_o = {{5{n6121_o[4]}}, n6121_o}; // sext
  /* ascal.vhd:862:58  */
  assign n6124_o = n6122_o * n6123_o; // smul
  /* ascal.vhd:866:40  */
  assign n6127_o = {1'b0, n6108_o};
  /* ascal.vhd:866:53  */
  assign n6129_o = {1'b0, n6104_o};
  /* ascal.vhd:866:46  */
  assign n6130_o = n6127_o - n6129_o;
  /* ascal.vhd:867:42  */
  assign n6132_o = {3'b000, n6104_o};
  /* ascal.vhd:867:47  */
  assign n6134_o = {n6132_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n6136_o = {2'b00, n6106_o};
  /* ascal.vhd:867:67  */
  assign n6138_o = {n6136_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n6139_o = n6134_o - n6138_o;
  /* ascal.vhd:867:85  */
  assign n6141_o = {4'b0000, n6106_o};
  /* ascal.vhd:867:75  */
  assign n6142_o = n6139_o - n6141_o;
  /* ascal.vhd:868:56  */
  assign n6144_o = {2'b00, n6108_o};
  /* ascal.vhd:868:61  */
  assign n6146_o = {n6144_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n6147_o = n6142_o + n6146_o;
  /* ascal.vhd:868:79  */
  assign n6149_o = {4'b0000, n6110_o};
  /* ascal.vhd:868:69  */
  assign n6150_o = n6147_o - n6149_o;
  /* ascal.vhd:869:41  */
  assign n6152_o = {2'b00, n6106_o};
  /* ascal.vhd:869:46  */
  assign n6154_o = {n6152_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n6156_o = {2'b00, n6108_o};
  /* ascal.vhd:869:66  */
  assign n6158_o = {n6156_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n6159_o = n6154_o - n6158_o;
  /* ascal.vhd:869:82  */
  assign n6161_o = {3'b000, n6108_o};
  /* ascal.vhd:869:73  */
  assign n6162_o = n6159_o - n6161_o;
  /* ascal.vhd:870:57  */
  assign n6164_o = {3'b000, n6106_o};
  /* ascal.vhd:869:88  */
  assign n6165_o = n6162_o + n6164_o;
  /* ascal.vhd:870:72  */
  assign n6167_o = {3'b000, n6110_o};
  /* ascal.vhd:870:63  */
  assign n6168_o = n6165_o + n6167_o;
  /* ascal.vhd:870:87  */
  assign n6170_o = {3'b000, n6104_o};
  /* ascal.vhd:870:78  */
  assign n6171_o = n6168_o - n6170_o;
  /* ascal.vhd:871:31  */
  assign n6172_o = n6124_o[8:0];
  assign n6173_o = {n6172_o, n6171_o, n6150_o, n6130_o};
  assign n6174_o = {n6173_o, n6106_o};
  assign n6175_o = {n6174_o, n6101_o, n6028_o};
  /* ascal.vhd:890:28  */
  assign n6184_o = n6175_o[48:0];
  /* ascal.vhd:890:30  */
  assign n6185_o = n6184_o[16:8];
  /* ascal.vhd:890:48  */
  assign n6186_o = n5948_o[11:8];
  /* ascal.vhd:890:45  */
  assign n6188_o = {1'b0, n6186_o};
  /* ascal.vhd:890:32  */
  assign n6189_o = {{5{n6185_o[8]}}, n6185_o}; // sext
  /* ascal.vhd:890:32  */
  assign n6190_o = {{9{n6188_o[4]}}, n6188_o}; // sext
  /* ascal.vhd:890:32  */
  assign n6191_o = n6189_o * n6190_o; // smul
  /* ascal.vhd:891:27  */
  assign n6193_o = n6191_o[13:5];
  /* ascal.vhd:892:28  */
  assign n6196_o = n6175_o[48:0];
  /* ascal.vhd:892:30  */
  assign n6197_o = n6196_o[28:17];
  /* ascal.vhd:892:39  */
  assign n6198_o = n6175_o[48:0];
  /* ascal.vhd:892:41  */
  assign n6199_o = n6198_o[48:40];
  /* ascal.vhd:892:32  */
  assign n6200_o = {{9{n6197_o[11]}}, n6197_o}; // sext
  /* ascal.vhd:892:32  */
  assign n6201_o = {{12{n6199_o[8]}}, n6199_o}; // sext
  /* ascal.vhd:892:32  */
  assign n6202_o = n6200_o * n6201_o; // smul
  /* ascal.vhd:893:29  */
  assign n6204_o = n6202_o[19:8];
  /* ascal.vhd:894:28  */
  assign n6207_o = n6175_o[48:0];
  /* ascal.vhd:894:30  */
  assign n6208_o = n6207_o[39:29];
  /* ascal.vhd:894:39  */
  assign n6209_o = n6175_o[48:0];
  /* ascal.vhd:894:41  */
  assign n6210_o = n6209_o[48:40];
  /* ascal.vhd:894:32  */
  assign n6211_o = {{9{n6208_o[10]}}, n6208_o}; // sext
  /* ascal.vhd:894:32  */
  assign n6212_o = {{11{n6210_o[8]}}, n6210_o}; // sext
  /* ascal.vhd:894:32  */
  assign n6213_o = n6211_o * n6212_o; // smul
  /* ascal.vhd:895:29  */
  assign n6215_o = n6213_o[18:8];
  /* ascal.vhd:896:28  */
  assign n6218_o = n6175_o[97:49];
  /* ascal.vhd:896:30  */
  assign n6219_o = n6218_o[16:8];
  /* ascal.vhd:896:48  */
  assign n6220_o = n5948_o[11:8];
  /* ascal.vhd:896:45  */
  assign n6222_o = {1'b0, n6220_o};
  /* ascal.vhd:896:32  */
  assign n6223_o = {{5{n6219_o[8]}}, n6219_o}; // sext
  /* ascal.vhd:896:32  */
  assign n6224_o = {{9{n6222_o[4]}}, n6222_o}; // sext
  /* ascal.vhd:896:32  */
  assign n6225_o = n6223_o * n6224_o; // smul
  /* ascal.vhd:897:27  */
  assign n6226_o = n6225_o[13:5];
  /* ascal.vhd:898:28  */
  assign n6228_o = n6175_o[97:49];
  /* ascal.vhd:898:30  */
  assign n6229_o = n6228_o[28:17];
  /* ascal.vhd:898:39  */
  assign n6230_o = n6175_o[97:49];
  /* ascal.vhd:898:41  */
  assign n6231_o = n6230_o[48:40];
  /* ascal.vhd:898:32  */
  assign n6232_o = {{9{n6229_o[11]}}, n6229_o}; // sext
  /* ascal.vhd:898:32  */
  assign n6233_o = {{12{n6231_o[8]}}, n6231_o}; // sext
  /* ascal.vhd:898:32  */
  assign n6234_o = n6232_o * n6233_o; // smul
  /* ascal.vhd:899:29  */
  assign n6235_o = n6234_o[19:8];
  /* ascal.vhd:900:28  */
  assign n6237_o = n6175_o[97:49];
  /* ascal.vhd:900:30  */
  assign n6238_o = n6237_o[39:29];
  /* ascal.vhd:900:39  */
  assign n6239_o = n6175_o[97:49];
  /* ascal.vhd:900:41  */
  assign n6240_o = n6239_o[48:40];
  /* ascal.vhd:900:32  */
  assign n6241_o = {{9{n6238_o[10]}}, n6238_o}; // sext
  /* ascal.vhd:900:32  */
  assign n6242_o = {{11{n6240_o[8]}}, n6240_o}; // sext
  /* ascal.vhd:900:32  */
  assign n6243_o = n6241_o * n6242_o; // smul
  /* ascal.vhd:901:29  */
  assign n6244_o = n6243_o[18:8];
  /* ascal.vhd:902:28  */
  assign n6246_o = n6175_o[146:98];
  /* ascal.vhd:902:30  */
  assign n6247_o = n6246_o[16:8];
  /* ascal.vhd:902:48  */
  assign n6248_o = n5948_o[11:8];
  /* ascal.vhd:902:45  */
  assign n6250_o = {1'b0, n6248_o};
  /* ascal.vhd:902:32  */
  assign n6251_o = {{5{n6247_o[8]}}, n6247_o}; // sext
  /* ascal.vhd:902:32  */
  assign n6252_o = {{9{n6250_o[4]}}, n6250_o}; // sext
  /* ascal.vhd:902:32  */
  assign n6253_o = n6251_o * n6252_o; // smul
  /* ascal.vhd:903:27  */
  assign n6254_o = n6253_o[13:5];
  /* ascal.vhd:904:28  */
  assign n6255_o = n6175_o[146:98];
  /* ascal.vhd:904:30  */
  assign n6256_o = n6255_o[28:17];
  /* ascal.vhd:904:39  */
  assign n6257_o = n6175_o[146:98];
  /* ascal.vhd:904:41  */
  assign n6258_o = n6257_o[48:40];
  /* ascal.vhd:904:32  */
  assign n6259_o = {{9{n6256_o[11]}}, n6256_o}; // sext
  /* ascal.vhd:904:32  */
  assign n6260_o = {{12{n6258_o[8]}}, n6258_o}; // sext
  /* ascal.vhd:904:32  */
  assign n6261_o = n6259_o * n6260_o; // smul
  /* ascal.vhd:905:29  */
  assign n6262_o = n6261_o[19:8];
  /* ascal.vhd:906:28  */
  assign n6263_o = n6175_o[146:98];
  /* ascal.vhd:906:30  */
  assign n6264_o = n6263_o[39:29];
  /* ascal.vhd:906:39  */
  assign n6265_o = n6175_o[146:98];
  /* ascal.vhd:906:41  */
  assign n6266_o = n6265_o[48:40];
  /* ascal.vhd:906:32  */
  assign n6267_o = {{9{n6264_o[10]}}, n6264_o}; // sext
  /* ascal.vhd:906:32  */
  assign n6268_o = {{11{n6266_o[8]}}, n6266_o}; // sext
  /* ascal.vhd:906:32  */
  assign n6269_o = n6267_o * n6268_o; // smul
  /* ascal.vhd:907:29  */
  assign n6270_o = n6269_o[18:8];
  assign n6271_o = {n6270_o, n6244_o, n6215_o, n6262_o, n6235_o, n6204_o, n6254_o, n6226_o, n6193_o};
  /* ascal.vhd:2574:55  */
  assign n6273_o = o_hfrac[23:12];
  /* ascal.vhd:919:36  */
  assign n6280_o = o_h_bic_tt1[8];
  /* ascal.vhd:919:44  */
  assign n6281_o = o_h_bic_tt1[8:0];
  /* ascal.vhd:919:40  */
  assign n6282_o = {n6280_o, n6281_o};
  /* ascal.vhd:919:72  */
  assign n6283_o = o_h_bic_abcd1[48:0];
  /* ascal.vhd:919:74  */
  assign n6284_o = n6283_o[7:0];
  /* ascal.vhd:919:58  */
  assign n6286_o = {2'b00, n6284_o};
  /* ascal.vhd:919:50  */
  assign n6287_o = n6282_o + n6286_o;
  /* ascal.vhd:919:87  */
  assign n6288_o = o_h_bic_tt1[37:28];
  /* ascal.vhd:919:78  */
  assign n6289_o = n6287_o + n6288_o;
  /* ascal.vhd:920:36  */
  assign n6292_o = o_h_bic_tt1[17];
  /* ascal.vhd:920:44  */
  assign n6293_o = o_h_bic_tt1[17:9];
  /* ascal.vhd:920:40  */
  assign n6294_o = {n6292_o, n6293_o};
  /* ascal.vhd:920:72  */
  assign n6295_o = o_h_bic_abcd1[97:49];
  /* ascal.vhd:920:74  */
  assign n6296_o = n6295_o[7:0];
  /* ascal.vhd:920:58  */
  assign n6298_o = {2'b00, n6296_o};
  /* ascal.vhd:920:50  */
  assign n6299_o = n6294_o + n6298_o;
  /* ascal.vhd:920:87  */
  assign n6300_o = o_h_bic_tt1[49:40];
  /* ascal.vhd:920:78  */
  assign n6301_o = n6299_o + n6300_o;
  /* ascal.vhd:921:36  */
  assign n6303_o = o_h_bic_tt1[26];
  /* ascal.vhd:921:44  */
  assign n6304_o = o_h_bic_tt1[26:18];
  /* ascal.vhd:921:40  */
  assign n6305_o = {n6303_o, n6304_o};
  /* ascal.vhd:921:72  */
  assign n6306_o = o_h_bic_abcd1[146:98];
  /* ascal.vhd:921:74  */
  assign n6307_o = n6306_o[7:0];
  /* ascal.vhd:921:58  */
  assign n6309_o = {2'b00, n6307_o};
  /* ascal.vhd:921:50  */
  assign n6310_o = n6305_o + n6309_o;
  /* ascal.vhd:921:87  */
  assign n6311_o = o_h_bic_tt1[61:52];
  /* ascal.vhd:921:78  */
  assign n6312_o = n6310_o + n6311_o;
  /* ascal.vhd:923:22  */
  assign n6314_o = o_h_bic_tt1[73:63];
  /* ascal.vhd:923:45  */
  assign n6315_o = n6273_o[11:8];
  /* ascal.vhd:923:42  */
  assign n6317_o = {1'b0, n6315_o};
  /* ascal.vhd:923:28  */
  assign n6318_o = {{5{n6314_o[10]}}, n6314_o}; // sext
  /* ascal.vhd:923:28  */
  assign n6319_o = {{11{n6317_o[4]}}, n6317_o}; // sext
  /* ascal.vhd:923:28  */
  assign n6320_o = n6318_o * n6319_o; // smul
  /* ascal.vhd:924:28  */
  assign n6322_o = n6320_o[14:5];
  /* ascal.vhd:925:22  */
  assign n6324_o = o_h_bic_tt1[84:74];
  /* ascal.vhd:925:45  */
  assign n6325_o = n6273_o[11:8];
  /* ascal.vhd:925:42  */
  assign n6327_o = {1'b0, n6325_o};
  /* ascal.vhd:925:28  */
  assign n6328_o = {{5{n6324_o[10]}}, n6324_o}; // sext
  /* ascal.vhd:925:28  */
  assign n6329_o = {{11{n6327_o[4]}}, n6327_o}; // sext
  /* ascal.vhd:925:28  */
  assign n6330_o = n6328_o * n6329_o; // smul
  /* ascal.vhd:926:28  */
  assign n6331_o = n6330_o[14:5];
  /* ascal.vhd:927:22  */
  assign n6333_o = o_h_bic_tt1[95:85];
  /* ascal.vhd:927:45  */
  assign n6334_o = n6273_o[11:8];
  /* ascal.vhd:927:42  */
  assign n6336_o = {1'b0, n6334_o};
  /* ascal.vhd:927:28  */
  assign n6337_o = {{5{n6333_o[10]}}, n6333_o}; // sext
  /* ascal.vhd:927:28  */
  assign n6338_o = {{11{n6336_o[4]}}, n6336_o}; // sext
  /* ascal.vhd:927:28  */
  assign n6339_o = n6337_o * n6338_o; // smul
  /* ascal.vhd:928:28  */
  assign n6340_o = n6339_o[14:5];
  assign n6341_o = {n6340_o, n6331_o, n6322_o, n6312_o, n6301_o, n6289_o};
  /* ascal.vhd:940:22  */
  assign n6350_o = o_h_bic_tt2[9:0];
  /* ascal.vhd:940:35  */
  assign n6351_o = o_h_bic_tt2[39:30];
  /* ascal.vhd:940:31  */
  assign n6352_o = n6350_o + n6351_o;
  /* ascal.vhd:715:21  */
  assign n6359_o = n6352_o[9];
  /* ascal.vhd:717:24  */
  assign n6361_o = n6352_o[9:8];
  /* ascal.vhd:717:41  */
  assign n6363_o = n6361_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n6365_o = n6352_o[7:0];
  /* ascal.vhd:717:17  */
  assign n6366_o = n6363_o ? 8'b11111111 : n6365_o;
  /* ascal.vhd:715:17  */
  assign n6367_o = n6359_o ? 8'b00000000 : n6366_o;
  /* ascal.vhd:942:22  */
  assign n6370_o = o_h_bic_tt2[19:10];
  /* ascal.vhd:942:35  */
  assign n6371_o = o_h_bic_tt2[49:40];
  /* ascal.vhd:942:31  */
  assign n6372_o = n6370_o + n6371_o;
  /* ascal.vhd:715:21  */
  assign n6378_o = n6372_o[9];
  /* ascal.vhd:717:24  */
  assign n6380_o = n6372_o[9:8];
  /* ascal.vhd:717:41  */
  assign n6382_o = n6380_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n6384_o = n6372_o[7:0];
  /* ascal.vhd:717:17  */
  assign n6385_o = n6382_o ? 8'b11111111 : n6384_o;
  /* ascal.vhd:715:17  */
  assign n6386_o = n6378_o ? 8'b00000000 : n6385_o;
  /* ascal.vhd:944:22  */
  assign n6388_o = o_h_bic_tt2[29:20];
  /* ascal.vhd:944:35  */
  assign n6389_o = o_h_bic_tt2[59:50];
  /* ascal.vhd:944:31  */
  assign n6390_o = n6388_o + n6389_o;
  /* ascal.vhd:715:21  */
  assign n6396_o = n6390_o[9];
  /* ascal.vhd:717:24  */
  assign n6398_o = n6390_o[9:8];
  /* ascal.vhd:717:41  */
  assign n6400_o = n6398_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n6402_o = n6390_o[7:0];
  /* ascal.vhd:717:17  */
  assign n6403_o = n6400_o ? 8'b11111111 : n6402_o;
  /* ascal.vhd:715:17  */
  assign n6404_o = n6396_o ? 8'b00000000 : n6403_o;
  assign n6405_o = {n6404_o, n6386_o, n6367_o};
  /* ascal.vhd:2581:38  */
  assign n6406_o = o_hfrac[95];
  /* ascal.vhd:2581:55  */
  assign n6407_o = ~n6406_o;
  /* ascal.vhd:2581:25  */
  assign n6408_o = n6407_o ? o_hpix2 : o_hpix1;
  /* ascal.vhd:2590:69  */
  assign n6410_o = o_hpixq[95:0];
  /* ascal.vhd:1011:27  */
  assign n6416_o = o_h_poly_phase[17:0];
  /* ascal.vhd:1011:46  */
  assign n6417_o = n6410_o[95:72];
  /* ascal.vhd:1011:50  */
  assign n6418_o = n6417_o[7:0];
  /* ascal.vhd:1011:43  */
  assign n6420_o = {1'b0, n6418_o};
  /* ascal.vhd:1011:30  */
  assign n6421_o = {{9{n6416_o[17]}}, n6416_o}; // sext
  /* ascal.vhd:1011:30  */
  assign n6422_o = {{18{n6420_o[8]}}, n6420_o}; // sext
  /* ascal.vhd:1011:30  */
  assign n6423_o = n6421_o * n6422_o; // smul
  /* ascal.vhd:1012:45  */
  assign n6424_o = o_h_poly_phase[35:18];
  /* ascal.vhd:1012:64  */
  assign n6425_o = n6410_o[71:48];
  /* ascal.vhd:1012:68  */
  assign n6426_o = n6425_o[7:0];
  /* ascal.vhd:1012:61  */
  assign n6428_o = {1'b0, n6426_o};
  /* ascal.vhd:1012:48  */
  assign n6429_o = {{9{n6424_o[17]}}, n6424_o}; // sext
  /* ascal.vhd:1012:48  */
  assign n6430_o = {{18{n6428_o[8]}}, n6428_o}; // sext
  /* ascal.vhd:1012:48  */
  assign n6431_o = n6429_o * n6430_o; // smul
  /* ascal.vhd:1011:53  */
  assign n6432_o = n6423_o + n6431_o;
  /* ascal.vhd:1013:27  */
  assign n6435_o = o_h_poly_phase[53:36];
  /* ascal.vhd:1013:46  */
  assign n6436_o = n6410_o[47:24];
  /* ascal.vhd:1013:50  */
  assign n6437_o = n6436_o[7:0];
  /* ascal.vhd:1013:43  */
  assign n6439_o = {1'b0, n6437_o};
  /* ascal.vhd:1013:30  */
  assign n6440_o = {{9{n6435_o[17]}}, n6435_o}; // sext
  /* ascal.vhd:1013:30  */
  assign n6441_o = {{18{n6439_o[8]}}, n6439_o}; // sext
  /* ascal.vhd:1013:30  */
  assign n6442_o = n6440_o * n6441_o; // smul
  /* ascal.vhd:1014:45  */
  assign n6443_o = o_h_poly_phase[71:54];
  /* ascal.vhd:1014:64  */
  assign n6444_o = n6410_o[23:0];
  /* ascal.vhd:1014:68  */
  assign n6445_o = n6444_o[7:0];
  /* ascal.vhd:1014:61  */
  assign n6447_o = {1'b0, n6445_o};
  /* ascal.vhd:1014:48  */
  assign n6448_o = {{9{n6443_o[17]}}, n6443_o}; // sext
  /* ascal.vhd:1014:48  */
  assign n6449_o = {{18{n6447_o[8]}}, n6447_o}; // sext
  /* ascal.vhd:1014:48  */
  assign n6450_o = n6448_o * n6449_o; // smul
  /* ascal.vhd:1013:53  */
  assign n6451_o = n6442_o + n6450_o;
  /* ascal.vhd:1015:27  */
  assign n6453_o = o_h_poly_phase[17:0];
  /* ascal.vhd:1015:46  */
  assign n6454_o = n6410_o[95:72];
  /* ascal.vhd:1015:50  */
  assign n6455_o = n6454_o[15:8];
  /* ascal.vhd:1015:43  */
  assign n6457_o = {1'b0, n6455_o};
  /* ascal.vhd:1015:30  */
  assign n6458_o = {{9{n6453_o[17]}}, n6453_o}; // sext
  /* ascal.vhd:1015:30  */
  assign n6459_o = {{18{n6457_o[8]}}, n6457_o}; // sext
  /* ascal.vhd:1015:30  */
  assign n6460_o = n6458_o * n6459_o; // smul
  /* ascal.vhd:1016:45  */
  assign n6461_o = o_h_poly_phase[35:18];
  /* ascal.vhd:1016:64  */
  assign n6462_o = n6410_o[71:48];
  /* ascal.vhd:1016:68  */
  assign n6463_o = n6462_o[15:8];
  /* ascal.vhd:1016:61  */
  assign n6465_o = {1'b0, n6463_o};
  /* ascal.vhd:1016:48  */
  assign n6466_o = {{9{n6461_o[17]}}, n6461_o}; // sext
  /* ascal.vhd:1016:48  */
  assign n6467_o = {{18{n6465_o[8]}}, n6465_o}; // sext
  /* ascal.vhd:1016:48  */
  assign n6468_o = n6466_o * n6467_o; // smul
  /* ascal.vhd:1015:53  */
  assign n6469_o = n6460_o + n6468_o;
  /* ascal.vhd:1017:27  */
  assign n6472_o = o_h_poly_phase[53:36];
  /* ascal.vhd:1017:46  */
  assign n6473_o = n6410_o[47:24];
  /* ascal.vhd:1017:50  */
  assign n6474_o = n6473_o[15:8];
  /* ascal.vhd:1017:43  */
  assign n6476_o = {1'b0, n6474_o};
  /* ascal.vhd:1017:30  */
  assign n6477_o = {{9{n6472_o[17]}}, n6472_o}; // sext
  /* ascal.vhd:1017:30  */
  assign n6478_o = {{18{n6476_o[8]}}, n6476_o}; // sext
  /* ascal.vhd:1017:30  */
  assign n6479_o = n6477_o * n6478_o; // smul
  /* ascal.vhd:1018:45  */
  assign n6480_o = o_h_poly_phase[71:54];
  /* ascal.vhd:1018:64  */
  assign n6481_o = n6410_o[23:0];
  /* ascal.vhd:1018:68  */
  assign n6482_o = n6481_o[15:8];
  /* ascal.vhd:1018:61  */
  assign n6484_o = {1'b0, n6482_o};
  /* ascal.vhd:1018:48  */
  assign n6485_o = {{9{n6480_o[17]}}, n6480_o}; // sext
  /* ascal.vhd:1018:48  */
  assign n6486_o = {{18{n6484_o[8]}}, n6484_o}; // sext
  /* ascal.vhd:1018:48  */
  assign n6487_o = n6485_o * n6486_o; // smul
  /* ascal.vhd:1017:53  */
  assign n6488_o = n6479_o + n6487_o;
  /* ascal.vhd:1019:27  */
  assign n6489_o = o_h_poly_phase[17:0];
  /* ascal.vhd:1019:46  */
  assign n6490_o = n6410_o[95:72];
  /* ascal.vhd:1019:50  */
  assign n6491_o = n6490_o[23:16];
  /* ascal.vhd:1019:43  */
  assign n6493_o = {1'b0, n6491_o};
  /* ascal.vhd:1019:30  */
  assign n6494_o = {{9{n6489_o[17]}}, n6489_o}; // sext
  /* ascal.vhd:1019:30  */
  assign n6495_o = {{18{n6493_o[8]}}, n6493_o}; // sext
  /* ascal.vhd:1019:30  */
  assign n6496_o = n6494_o * n6495_o; // smul
  /* ascal.vhd:1020:45  */
  assign n6497_o = o_h_poly_phase[35:18];
  /* ascal.vhd:1020:64  */
  assign n6498_o = n6410_o[71:48];
  /* ascal.vhd:1020:68  */
  assign n6499_o = n6498_o[23:16];
  /* ascal.vhd:1020:61  */
  assign n6501_o = {1'b0, n6499_o};
  /* ascal.vhd:1020:48  */
  assign n6502_o = {{9{n6497_o[17]}}, n6497_o}; // sext
  /* ascal.vhd:1020:48  */
  assign n6503_o = {{18{n6501_o[8]}}, n6501_o}; // sext
  /* ascal.vhd:1020:48  */
  assign n6504_o = n6502_o * n6503_o; // smul
  /* ascal.vhd:1019:53  */
  assign n6505_o = n6496_o + n6504_o;
  /* ascal.vhd:1021:27  */
  assign n6507_o = o_h_poly_phase[53:36];
  /* ascal.vhd:1021:46  */
  assign n6508_o = n6410_o[47:24];
  /* ascal.vhd:1021:50  */
  assign n6509_o = n6508_o[23:16];
  /* ascal.vhd:1021:43  */
  assign n6511_o = {1'b0, n6509_o};
  /* ascal.vhd:1021:30  */
  assign n6512_o = {{9{n6507_o[17]}}, n6507_o}; // sext
  /* ascal.vhd:1021:30  */
  assign n6513_o = {{18{n6511_o[8]}}, n6511_o}; // sext
  /* ascal.vhd:1021:30  */
  assign n6514_o = n6512_o * n6513_o; // smul
  /* ascal.vhd:1022:45  */
  assign n6515_o = o_h_poly_phase[71:54];
  /* ascal.vhd:1022:64  */
  assign n6516_o = n6410_o[23:0];
  /* ascal.vhd:1022:68  */
  assign n6517_o = n6516_o[23:16];
  /* ascal.vhd:1022:61  */
  assign n6519_o = {1'b0, n6517_o};
  /* ascal.vhd:1022:48  */
  assign n6520_o = {{9{n6515_o[17]}}, n6515_o}; // sext
  /* ascal.vhd:1022:48  */
  assign n6521_o = {{18{n6519_o[8]}}, n6519_o}; // sext
  /* ascal.vhd:1022:48  */
  assign n6522_o = n6520_o * n6521_o; // smul
  /* ascal.vhd:1021:53  */
  assign n6523_o = n6514_o + n6522_o;
  assign n6524_o = {n6488_o, n6469_o, n6523_o, n6505_o, n6451_o, n6432_o};
  /* ascal.vhd:1029:41  */
  assign n6532_o = o_h_poly_t[26:8];
  /* ascal.vhd:1029:59  */
  assign n6533_o = o_h_poly_t[53:35];
  /* ascal.vhd:1029:54  */
  assign n6534_o = n6532_o + n6533_o;
  /* ascal.vhd:715:21  */
  assign n6539_o = n6534_o[18];
  /* ascal.vhd:717:24  */
  assign n6541_o = n6534_o[18:15];
  /* ascal.vhd:717:41  */
  assign n6543_o = n6541_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n6545_o = n6534_o[14:7];
  /* ascal.vhd:717:17  */
  assign n6546_o = n6543_o ? 8'b11111111 : n6545_o;
  /* ascal.vhd:715:17  */
  assign n6547_o = n6539_o ? 8'b00000000 : n6546_o;
  /* ascal.vhd:1030:41  */
  assign n6551_o = o_h_poly_t[134:116];
  /* ascal.vhd:1030:59  */
  assign n6552_o = o_h_poly_t[161:143];
  /* ascal.vhd:1030:54  */
  assign n6553_o = n6551_o + n6552_o;
  /* ascal.vhd:715:21  */
  assign n6558_o = n6553_o[18];
  /* ascal.vhd:717:24  */
  assign n6560_o = n6553_o[18:15];
  /* ascal.vhd:717:41  */
  assign n6562_o = n6560_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n6564_o = n6553_o[14:7];
  /* ascal.vhd:717:17  */
  assign n6565_o = n6562_o ? 8'b11111111 : n6564_o;
  /* ascal.vhd:715:17  */
  assign n6566_o = n6558_o ? 8'b00000000 : n6565_o;
  /* ascal.vhd:1031:41  */
  assign n6569_o = o_h_poly_t[80:62];
  /* ascal.vhd:1031:59  */
  assign n6570_o = o_h_poly_t[107:89];
  /* ascal.vhd:1031:54  */
  assign n6571_o = n6569_o + n6570_o;
  /* ascal.vhd:715:21  */
  assign n6576_o = n6571_o[18];
  /* ascal.vhd:717:24  */
  assign n6578_o = n6571_o[18:15];
  /* ascal.vhd:717:41  */
  assign n6580_o = n6578_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n6582_o = n6571_o[14:7];
  /* ascal.vhd:717:17  */
  assign n6583_o = n6580_o ? 8'b11111111 : n6582_o;
  /* ascal.vhd:715:17  */
  assign n6584_o = n6576_o ? 8'b00000000 : n6583_o;
  assign n6585_o = {n6584_o, n6566_o, n6547_o};
  /* ascal.vhd:2596:40  */
  assign n6586_o = o_dcptv[11:0];
  /* ascal.vhd:2596:33  */
  assign n6587_o = n6586_o[10:0];  // trunc
  /* ascal.vhd:2597:50  */
  assign n6588_o = o_copyv[0];
  /* ascal.vhd:2597:64  */
  assign n6589_o = o_copyv[0];
  /* ascal.vhd:2597:55  */
  assign n6590_o = {n6588_o, n6589_o};
  /* ascal.vhd:2597:78  */
  assign n6591_o = o_copyv[0];
  /* ascal.vhd:2597:69  */
  assign n6592_o = {n6590_o, n6591_o};
  /* ascal.vhd:2597:92  */
  assign n6593_o = o_copyv[0];
  /* ascal.vhd:2597:83  */
  assign n6594_o = {n6592_o, n6593_o};
  /* ascal.vhd:2597:38  */
  assign n6595_o = o_altx & n6594_o;
  /* ascal.vhd:2600:37  */
  assign n6596_o = o_hmode[2:0];
  /* ascal.vhd:2601:33  */
  assign n6598_o = n6596_o == 3'b000;
  /* ascal.vhd:2605:33  */
  assign n6600_o = n6596_o == 3'b001;
  /* ascal.vhd:2605:44  */
  assign n6602_o = n6596_o == 3'b010;
  /* ascal.vhd:2605:44  */
  assign n6603_o = n6600_o | n6602_o;
  /* ascal.vhd:2610:33  */
  assign n6605_o = n6596_o == 3'b011;
  assign n6606_o = {n6605_o, n6603_o, n6598_o};
  /* ascal.vhd:2600:25  */
  always @*
    case (n6606_o)
      3'b100: n6607_o <= o_h_bic_pix;
      3'b010: n6607_o <= o_h_bil_pix;
      3'b001: n6607_o <= o_h_poly_pix;
    endcase
  assign n6609_o = {n5554_o, n5553_o, n5555_o};
  assign n6615_o = {n5544_o, n5545_o};
  assign n6618_o = {o_dcpt, n5560_o, n5561_o};
  assign n6620_o = {n5562_o, n5563_o};
  assign n6622_o = {n5496_o, n5536_o, n5541_o};
  assign n6624_o = {n5500_o, n5540_o, n5542_o};
  assign n6627_o = {n5719_o, n5704_o, n5689_o};
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6642_q <= n6609_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6643_q <= n6587_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6644_q <= n6607_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6645_q <= n6595_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6646_q <= n6615_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6647_q <= n6618_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6648_q <= n6620_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6649_q <= n6622_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6650_q <= n6624_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6651_q <= n5615_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6652_q <= n6627_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6653_q <= n5674_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6654_q <= n5587_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6655_q <= n6405_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6656_q <= n5946_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6658_q <= n6271_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6659_q <= n6341_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6660_q <= n6585_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6661_q <= n6408_o;
  /* ascal.vhd:2446:17  */
  always @(posedge o_clk)
    n6662_q <= n6524_o;
  /* ascal.vhd:2629:32  */
  assign n6665_o = o_wr[0];
  /* ascal.vhd:2630:32  */
  assign n6671_o = o_wr[1];
  /* ascal.vhd:2631:32  */
  assign n6677_o = o_wr[2];
  /* ascal.vhd:2632:32  */
  assign n6683_o = o_wr[3];
  /* ascal.vhd:2650:42  */
  assign n6724_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2650:42  */
  assign n6726_o = n6724_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2650:44  */
  assign n6727_o = {20'b0, o_htotal};  //  uext
  /* ascal.vhd:2650:44  */
  assign n6728_o = $signed(n6726_o) < $signed(n6727_o);
  /* ascal.vhd:2651:56  */
  assign n6729_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2651:56  */
  assign n6731_o = n6729_o + 32'b00000000000000000000000000000001;
  assign n6732_o = n6731_o[11:0];
  /* ascal.vhd:2655:56  */
  assign n6734_o = {20'b0, o_vcpt_sync};  //  uext
  /* ascal.vhd:2655:56  */
  assign n6736_o = n6734_o != 32'b00000000000000000000111111111111;
  /* ascal.vhd:2656:75  */
  assign n6737_o = {20'b0, o_vcpt_sync};  //  uext
  /* ascal.vhd:2656:75  */
  assign n6739_o = n6737_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2656:64  */
  assign n6740_o = n6739_o[11:0];  // trunc
  /* ascal.vhd:2655:41  */
  assign n6741_o = n6736_o ? n6740_o : o_vcpt_sync;
  /* ascal.vhd:2659:55  */
  assign n6742_o = {20'b0, o_vcpt_pre3};  //  uext
  /* ascal.vhd:2659:55  */
  assign n6744_o = n6742_o + 32'b00000000000000000000000000000001;
  /* ascal.vhd:2659:57  */
  assign n6745_o = {20'b0, o_vtotal};  //  uext
  /* ascal.vhd:2659:57  */
  assign n6746_o = $signed(n6744_o) >= $signed(n6745_o);
  /* ascal.vhd:2665:74  */
  assign n6747_o = {20'b0, o_vcpt_pre3};  //  uext
  /* ascal.vhd:2665:74  */
  assign n6749_o = n6747_o + 32'b00000000000000000000000000000001;
  assign n6750_o = n6749_o[11:0];
  /* ascal.vhd:2661:41  */
  assign n6753_o = o_vrr_sync2 ? 1'b0 : o_sync;
  /* ascal.vhd:2661:41  */
  assign n6754_o = o_vrr_sync2 ? o_vsstart : n6750_o;
  /* ascal.vhd:2659:41  */
  assign n6755_o = n6746_o ? o_sync : n6753_o;
  /* ascal.vhd:2659:41  */
  assign n6757_o = n6746_o ? 12'b000000000000 : n6754_o;
  /* ascal.vhd:2650:33  */
  assign n6758_o = n6728_o ? o_vcpt_sync : n6741_o;
  /* ascal.vhd:2650:33  */
  assign n6759_o = n6728_o ? o_sync : n6755_o;
  /* ascal.vhd:2650:33  */
  assign n6761_o = n6728_o ? n6732_o : 12'b000000000000;
  /* ascal.vhd:2650:33  */
  assign n6762_o = n6728_o ? o_vcpt : o_vcpt_pre;
  /* ascal.vhd:2650:33  */
  assign n6763_o = n6728_o ? o_vcpt_pre : o_vcpt_pre2;
  /* ascal.vhd:2650:33  */
  assign n6764_o = n6728_o ? o_vcpt_pre2 : o_vcpt_pre3;
  /* ascal.vhd:2650:33  */
  assign n6765_o = n6728_o ? o_vcpt_pre3 : n6757_o;
  /* ascal.vhd:2673:62  */
  assign n6767_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2673:62  */
  assign n6768_o = {20'b0, o_vdisp};  //  uext
  /* ascal.vhd:2673:62  */
  assign n6769_o = $signed(n6767_o) >= $signed(n6768_o);
  /* ascal.vhd:285:17  */
  assign n6776_o = n6769_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2674:62  */
  assign n6778_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2674:62  */
  assign n6779_o = {20'b0, o_hdisp};  //  uext
  /* ascal.vhd:2674:62  */
  assign n6780_o = $signed(n6778_o) < $signed(n6779_o);
  /* ascal.vhd:2674:81  */
  assign n6781_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2674:81  */
  assign n6782_o = {20'b0, o_vdisp};  //  uext
  /* ascal.vhd:2674:81  */
  assign n6783_o = $signed(n6781_o) < $signed(n6782_o);
  /* ascal.vhd:2674:71  */
  assign n6784_o = n6780_o & n6783_o;
  /* ascal.vhd:285:17  */
  assign n6791_o = n6784_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2675:62  */
  assign n6793_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2675:62  */
  assign n6794_o = {20'b0, o_hmin};  //  uext
  /* ascal.vhd:2675:62  */
  assign n6795_o = $signed(n6793_o) >= $signed(n6794_o);
  /* ascal.vhd:2675:81  */
  assign n6796_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2675:81  */
  assign n6797_o = {20'b0, o_hmax};  //  uext
  /* ascal.vhd:2675:81  */
  assign n6798_o = $signed(n6796_o) <= $signed(n6797_o);
  /* ascal.vhd:2675:71  */
  assign n6799_o = n6795_o & n6798_o;
  /* ascal.vhd:2676:97  */
  assign n6800_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2676:97  */
  assign n6801_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:2676:97  */
  assign n6802_o = $signed(n6800_o) >= $signed(n6801_o);
  /* ascal.vhd:2675:90  */
  assign n6803_o = n6799_o & n6802_o;
  /* ascal.vhd:2676:116  */
  assign n6804_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2676:116  */
  assign n6805_o = {20'b0, o_vmax};  //  uext
  /* ascal.vhd:2676:116  */
  assign n6806_o = $signed(n6804_o) <= $signed(n6805_o);
  /* ascal.vhd:2676:106  */
  assign n6807_o = n6803_o & n6806_o;
  /* ascal.vhd:285:17  */
  assign n6814_o = n6807_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2677:62  */
  assign n6816_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2677:62  */
  assign n6817_o = {20'b0, o_hsstart};  //  uext
  /* ascal.vhd:2677:62  */
  assign n6818_o = $signed(n6816_o) >= $signed(n6817_o);
  /* ascal.vhd:2677:84  */
  assign n6819_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2677:84  */
  assign n6820_o = {20'b0, o_hsend};  //  uext
  /* ascal.vhd:2677:84  */
  assign n6821_o = $signed(n6819_o) < $signed(n6820_o);
  /* ascal.vhd:2677:74  */
  assign n6822_o = n6818_o & n6821_o;
  /* ascal.vhd:285:17  */
  assign n6829_o = n6822_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2678:63  */
  assign n6831_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2678:63  */
  assign n6832_o = {20'b0, o_vsstart};  //  uext
  /* ascal.vhd:2678:63  */
  assign n6833_o = n6831_o == n6832_o;
  /* ascal.vhd:2678:84  */
  assign n6834_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2678:84  */
  assign n6835_o = {20'b0, o_hsstart};  //  uext
  /* ascal.vhd:2678:84  */
  assign n6836_o = $signed(n6834_o) >= $signed(n6835_o);
  /* ascal.vhd:2678:74  */
  assign n6837_o = n6833_o & n6836_o;
  /* ascal.vhd:2679:98  */
  assign n6838_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2679:98  */
  assign n6839_o = {20'b0, o_vsstart};  //  uext
  /* ascal.vhd:2679:98  */
  assign n6840_o = $signed(n6838_o) > $signed(n6839_o);
  /* ascal.vhd:2679:119  */
  assign n6841_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2679:119  */
  assign n6842_o = {20'b0, o_vsend};  //  uext
  /* ascal.vhd:2679:119  */
  assign n6843_o = $signed(n6841_o) < $signed(n6842_o);
  /* ascal.vhd:2679:109  */
  assign n6844_o = n6840_o & n6843_o;
  /* ascal.vhd:2678:97  */
  assign n6845_o = n6837_o | n6844_o;
  /* ascal.vhd:2680:98  */
  assign n6846_o = {20'b0, o_vcpt};  //  uext
  /* ascal.vhd:2680:98  */
  assign n6847_o = {20'b0, o_vsend};  //  uext
  /* ascal.vhd:2680:98  */
  assign n6848_o = n6846_o == n6847_o;
  /* ascal.vhd:2680:119  */
  assign n6849_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2680:119  */
  assign n6850_o = {20'b0, o_hsstart};  //  uext
  /* ascal.vhd:2680:119  */
  assign n6851_o = $signed(n6849_o) < $signed(n6850_o);
  /* ascal.vhd:2680:109  */
  assign n6852_o = n6848_o & n6851_o;
  /* ascal.vhd:2679:129  */
  assign n6853_o = n6845_o | n6852_o;
  /* ascal.vhd:285:17  */
  assign n6860_o = n6853_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2682:64  */
  assign n6862_o = {20'b0, o_vcpt_pre2};  //  uext
  /* ascal.vhd:2682:64  */
  assign n6863_o = {20'b0, o_vmin};  //  uext
  /* ascal.vhd:2682:64  */
  assign n6864_o = $signed(n6862_o) >= $signed(n6863_o);
  /* ascal.vhd:2682:88  */
  assign n6865_o = {20'b0, o_vcpt_pre2};  //  uext
  /* ascal.vhd:2682:88  */
  assign n6866_o = {20'b0, o_vmax};  //  uext
  /* ascal.vhd:2682:88  */
  assign n6867_o = $signed(n6865_o) <= $signed(n6866_o);
  /* ascal.vhd:2682:73  */
  assign n6868_o = n6864_o & n6867_o;
  /* ascal.vhd:285:17  */
  assign n6875_o = n6868_o ? 1'b1 : 1'b0;
  /* ascal.vhd:2689:41  */
  assign n6881_o = ~o_run;
  assign n6887_o = o_hsv[10];
  /* ascal.vhd:2689:33  */
  assign n6888_o = n6881_o ? 1'b0 : n6887_o;
  assign n6889_o = o_hsv[11];
  assign n6890_o = o_hsv[9:1];
  assign n6891_o = o_vsv[10];
  /* ascal.vhd:2689:33  */
  assign n6892_o = n6881_o ? 1'b0 : n6891_o;
  assign n6893_o = o_vsv[11];
  assign n6894_o = o_vsv[9:1];
  assign n6895_o = o_dev[10];
  /* ascal.vhd:2689:33  */
  assign n6896_o = n6881_o ? 1'b0 : n6895_o;
  assign n6897_o = o_dev[11];
  assign n6898_o = o_dev[9:1];
  assign n6899_o = o_pev[10];
  /* ascal.vhd:2689:33  */
  assign n6900_o = n6881_o ? 1'b0 : n6899_o;
  assign n6901_o = o_pev[11];
  assign n6902_o = o_pev[9:1];
  assign n6903_o = o_end[10];
  /* ascal.vhd:2689:33  */
  assign n6904_o = n6881_o ? 1'b0 : n6903_o;
  assign n6905_o = o_end[11];
  assign n6906_o = o_end[9:1];
  /* ascal.vhd:2648:25  */
  assign n6907_o = o_ce ? n6758_o : o_vcpt_sync;
  /* ascal.vhd:2648:25  */
  assign n6908_o = o_ce ? n6759_o : o_sync;
  assign n6914_o = {n6829_o, n6889_o, n6888_o, n6890_o};
  assign n6916_o = {n6860_o, n6893_o, n6892_o, n6894_o};
  assign n6918_o = {n6791_o, n6897_o, n6896_o, n6898_o};
  assign n6920_o = {n6814_o, n6901_o, n6900_o, n6902_o};
  assign n6922_o = {n6776_o, n6905_o, n6904_o, n6906_o};
  /* ascal.vhd:2699:49  */
  assign n6925_o = {20'b0, o_vcpt_sync2};  //  uext
  /* ascal.vhd:2699:49  */
  assign n6926_o = {20'b0, o_vtotal};  //  uext
  /* ascal.vhd:2699:49  */
  assign n6927_o = $signed(n6925_o) < $signed(n6926_o);
  /* ascal.vhd:2701:49  */
  assign n6928_o = {20'b0, o_vcpt_sync2};  //  uext
  /* ascal.vhd:2701:49  */
  assign n6929_o = {20'b0, o_vrrmax};  //  uext
  /* ascal.vhd:2701:49  */
  assign n6930_o = $signed(n6928_o) < $signed(n6929_o);
  /* ascal.vhd:2704:25  */
  assign n6932_o = n6935_o ? 1'b1 : n6908_o;
  /* ascal.vhd:2704:25  */
  assign n6934_o = o_isync2 ? 12'b000000000000 : n6907_o;
  /* ascal.vhd:2704:25  */
  assign n6935_o = o_isync2 & o_vrr_min2;
  /* ascal.vhd:2713:60  */
  assign n6937_o = o_sync | o_sync_max;
  /* ascal.vhd:2713:48  */
  assign n6938_o = o_vrr & n6937_o;
  /* ascal.vhd:2713:86  */
  assign n6939_o = {20'b0, o_vcpt2};  //  uext
  /* ascal.vhd:2713:86  */
  assign n6940_o = {20'b0, o_vdisp};  //  uext
  /* ascal.vhd:2713:86  */
  assign n6941_o = $signed(n6939_o) >= $signed(n6940_o);
  /* ascal.vhd:2713:75  */
  assign n6942_o = n6938_o & n6941_o;
  /* ascal.vhd:2713:107  */
  assign n6943_o = {20'b0, o_vcpt2};  //  uext
  /* ascal.vhd:2713:107  */
  assign n6944_o = {20'b0, o_vsstart};  //  uext
  /* ascal.vhd:2713:107  */
  assign n6945_o = $signed(n6943_o) < $signed(n6944_o);
  /* ascal.vhd:2713:96  */
  assign n6946_o = n6942_o & n6945_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6970_q <= n6946_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6971_q <= o_vrr_sync;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6972_q <= n6927_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6973_q <= o_vrr_min;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6974_q <= n6930_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6975_q <= o_vrr_max;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6976_q <= n6934_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6977_q <= o_vcpt_sync;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6978_q <= n6932_o;
  /* ascal.vhd:2646:17  */
  assign n6979_o = o_isync2 ? o_vrr_max2 : o_sync_max;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6980_q <= n6979_o;
  /* ascal.vhd:2646:17  */
  assign n6981_o = o_ce ? n6761_o : o_hcpt;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6982_q <= n6981_o;
  /* ascal.vhd:2646:17  */
  assign n6983_o = o_ce ? n6762_o : o_vcpt;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6984_q <= n6983_o;
  /* ascal.vhd:2646:17  */
  assign n6985_o = o_ce ? n6763_o : o_vcpt_pre;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6986_q <= n6985_o;
  /* ascal.vhd:2646:17  */
  assign n6987_o = o_ce ? n6764_o : o_vcpt_pre2;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6988_q <= n6987_o;
  /* ascal.vhd:2646:17  */
  assign n6989_o = o_ce ? n6765_o : o_vcpt_pre3;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6990_q <= n6989_o;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6991_q <= o_vcpt_pre3;
  /* ascal.vhd:2646:17  */
  assign n6992_o = o_ce ? n6914_o : o_hsv;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6993_q <= n6992_o;
  /* ascal.vhd:2646:17  */
  assign n6994_o = o_ce ? n6916_o : o_vsv;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6995_q <= n6994_o;
  /* ascal.vhd:2646:17  */
  assign n6996_o = o_ce ? n6918_o : o_dev;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6997_q <= n6996_o;
  /* ascal.vhd:2646:17  */
  assign n6998_o = o_ce ? n6920_o : o_pev;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n6999_q <= n6998_o;
  /* ascal.vhd:2646:17  */
  assign n7000_o = o_ce ? n6922_o : o_end;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n7001_q <= n7000_o;
  /* ascal.vhd:2646:17  */
  assign n7002_o = o_ce ? n6875_o : o_vss;
  /* ascal.vhd:2646:17  */
  always @(posedge o_clk)
    n7003_q <= n7002_o;
  /* ascal.vhd:2729:54  */
  assign n7011_o = {20'b0, o_hmin};  //  uext
  /* ascal.vhd:2729:54  */
  assign n7013_o = n7011_o + 32'b00000000000000000000000000000101;
  /* ascal.vhd:2729:47  */
  assign n7014_o = n7013_o[11:0];  // trunc
  /* ascal.vhd:2731:52  */
  assign n7015_o = o_vfrac[11];
  /* ascal.vhd:2732:49  */
  assign n7016_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2732:49  */
  assign n7017_o = {20'b0, o_v_hmin_adj};  //  uext
  /* ascal.vhd:2732:49  */
  assign n7018_o = n7016_o - n7017_o;
  /* ascal.vhd:2732:64  */
  assign n7020_o = n7018_o + 32'b00000000000000000000100000000000;
  assign n7021_o = n7020_o[10:0];
  /* ascal.vhd:2733:49  */
  assign n7023_o = {20'b0, o_hcpt};  //  uext
  /* ascal.vhd:2733:49  */
  assign n7024_o = {20'b0, o_hmin};  //  uext
  /* ascal.vhd:2733:49  */
  assign n7025_o = n7023_o - n7024_o;
  /* ascal.vhd:2733:58  */
  assign n7027_o = n7025_o + 32'b00000000000000000000100000000000;
  assign n7028_o = n7027_o[10:0];
  /* ascal.vhd:2742:45  */
  assign n7030_o = ~n7015_o;
  /* ascal.vhd:2744:49  */
  assign n7032_o = o_vacptl == 2'b10;
  /* ascal.vhd:2745:49  */
  assign n7034_o = o_vacptl == 2'b11;
  /* ascal.vhd:2746:49  */
  assign n7036_o = o_vacptl == 2'b00;
  assign n7037_o = {n7036_o, n7034_o, n7032_o};
  /* ascal.vhd:2743:41  */
  always @*
    case (n7037_o)
      3'b100: n7038_o <= n7021_o;
      3'b010: n7038_o <= n7021_o;
      3'b001: n7038_o <= n7021_o;
    endcase
  /* ascal.vhd:2743:41  */
  always @*
    case (n7037_o)
      3'b100: n7039_o <= n7021_o;
      3'b010: n7039_o <= n7021_o;
      3'b001: n7039_o <= n7028_o;
    endcase
  /* ascal.vhd:2743:41  */
  always @*
    case (n7037_o)
      3'b100: n7040_o <= n7021_o;
      3'b010: n7040_o <= n7028_o;
      3'b001: n7040_o <= n7021_o;
    endcase
  /* ascal.vhd:2743:41  */
  always @*
    case (n7037_o)
      3'b100: n7041_o <= n7028_o;
      3'b010: n7041_o <= n7021_o;
      3'b001: n7041_o <= n7021_o;
    endcase
  /* ascal.vhd:2751:49  */
  assign n7043_o = o_vacptl == 2'b10;
  /* ascal.vhd:2752:49  */
  assign n7045_o = o_vacptl == 2'b11;
  /* ascal.vhd:2753:49  */
  assign n7047_o = o_vacptl == 2'b00;
  assign n7048_o = {n7047_o, n7045_o, n7043_o};
  /* ascal.vhd:2750:41  */
  always @*
    case (n7048_o)
      3'b100: n7049_o <= n7028_o;
      3'b010: n7049_o <= n7021_o;
      3'b001: n7049_o <= n7021_o;
    endcase
  /* ascal.vhd:2750:41  */
  always @*
    case (n7048_o)
      3'b100: n7050_o <= n7021_o;
      3'b010: n7050_o <= n7021_o;
      3'b001: n7050_o <= n7021_o;
    endcase
  /* ascal.vhd:2750:41  */
  always @*
    case (n7048_o)
      3'b100: n7051_o <= n7021_o;
      3'b010: n7051_o <= n7021_o;
      3'b001: n7051_o <= n7028_o;
    endcase
  /* ascal.vhd:2750:41  */
  always @*
    case (n7048_o)
      3'b100: n7052_o <= n7021_o;
      3'b010: n7052_o <= n7028_o;
      3'b001: n7052_o <= n7021_o;
    endcase
  /* ascal.vhd:2742:33  */
  assign n7053_o = n7030_o ? n7038_o : n7049_o;
  /* ascal.vhd:2742:33  */
  assign n7054_o = n7030_o ? n7039_o : n7050_o;
  /* ascal.vhd:2742:33  */
  assign n7055_o = n7030_o ? n7040_o : n7051_o;
  /* ascal.vhd:2742:33  */
  assign n7056_o = n7030_o ? n7041_o : n7052_o;
  assign n7057_o = {o_ldr0, o_ldr1, o_ldr2, o_ldr3};
  /* ascal.vhd:2761:41  */
  assign n7059_o = o_vacptl == 2'b10;
  assign n7060_o = {o_ldr1, o_ldr2, o_ldr3, o_ldr0};
  /* ascal.vhd:2762:41  */
  assign n7062_o = o_vacptl == 2'b11;
  assign n7063_o = {o_ldr2, o_ldr3, o_ldr0, o_ldr1};
  /* ascal.vhd:2763:41  */
  assign n7065_o = o_vacptl == 2'b00;
  assign n7066_o = {o_ldr3, o_ldr0, o_ldr1, o_ldr2};
  assign n7067_o = {n7065_o, n7062_o, n7059_o};
  /* ascal.vhd:2760:33  */
  always @*
    case (n7067_o)
      3'b100: n7068_o <= n7063_o;
      3'b010: n7068_o <= n7060_o;
      3'b001: n7068_o <= n7057_o;
    endcase
  /* ascal.vhd:2767:45  */
  assign n7069_o = ~n7015_o;
  /* ascal.vhd:2768:62  */
  assign n7070_o = n7068_o[95:72];
  /* ascal.vhd:2768:73  */
  assign n7071_o = n7068_o[47:24];
  /* ascal.vhd:2768:84  */
  assign n7072_o = n7068_o[23:0];
  assign n7073_o = {n7070_o, n7071_o, n7072_o};
  /* ascal.vhd:2769:64  */
  assign n7074_o = n7068_o[71:48];
  /* ascal.vhd:2771:62  */
  assign n7075_o = n7068_o[95:72];
  /* ascal.vhd:2771:73  */
  assign n7076_o = n7068_o[71:48];
  /* ascal.vhd:2771:84  */
  assign n7077_o = n7068_o[23:0];
  assign n7078_o = {n7075_o, n7076_o, n7077_o};
  /* ascal.vhd:2772:64  */
  assign n7079_o = n7068_o[47:24];
  /* ascal.vhd:2767:33  */
  assign n7080_o = n7069_o ? n7073_o : n7078_o;
  /* ascal.vhd:2767:33  */
  assign n7081_o = n7069_o ? n7074_o : n7079_o;
  /* ascal.vhd:2776:67  */
  assign n7082_o = o_vpix_inner[167:48];
  /* ascal.vhd:2779:36  */
  assign n7083_o = {19'b0, o_vacpt};  //  uext
  /* ascal.vhd:2779:55  */
  assign n7084_o = {1'b0, n7083_o};  //  uext
  /* ascal.vhd:2779:55  */
  assign n7085_o = {20'b0, o_ivsize};  //  uext
  /* ascal.vhd:2779:55  */
  assign n7086_o = $signed(n7084_o) > $signed(n7085_o);
  /* ascal.vhd:2780:53  */
  assign n7087_o = ~n7015_o;
  /* ascal.vhd:2781:75  */
  assign n7088_o = o_vpix_outer[71:48];
  /* ascal.vhd:2781:92  */
  assign n7089_o = o_vpix_inner[47:24];
  /* ascal.vhd:2781:109  */
  assign n7090_o = o_vpix_inner[47:24];
  /* ascal.vhd:2781:126  */
  assign n7091_o = o_vpix_inner[47:24];
  assign n7092_o = {n7088_o, n7089_o, n7090_o, n7091_o};
  /* ascal.vhd:2783:75  */
  assign n7093_o = o_vpix_outer[71:48];
  /* ascal.vhd:2783:92  */
  assign n7094_o = o_vpix_outer[47:24];
  /* ascal.vhd:2783:109  */
  assign n7095_o = o_vpix_outer[47:24];
  /* ascal.vhd:2783:126  */
  assign n7096_o = o_vpix_outer[47:24];
  assign n7097_o = {n7093_o, n7094_o, n7095_o, n7096_o};
  /* ascal.vhd:2780:41  */
  assign n7098_o = n7087_o ? n7092_o : n7097_o;
  /* ascal.vhd:2785:39  */
  assign n7099_o = {19'b0, o_vacpt};  //  uext
  /* ascal.vhd:2785:58  */
  assign n7100_o = {1'b0, n7099_o};  //  uext
  /* ascal.vhd:2785:58  */
  assign n7101_o = {20'b0, o_ivsize};  //  uext
  /* ascal.vhd:2785:58  */
  assign n7102_o = n7100_o == n7101_o;
  /* ascal.vhd:2786:53  */
  assign n7103_o = ~n7015_o;
  /* ascal.vhd:2787:75  */
  assign n7104_o = o_vpix_outer[71:48];
  /* ascal.vhd:2787:92  */
  assign n7105_o = o_vpix_inner[47:24];
  /* ascal.vhd:2787:109  */
  assign n7106_o = o_vpix_outer[47:24];
  /* ascal.vhd:2787:126  */
  assign n7107_o = o_vpix_outer[47:24];
  assign n7108_o = {n7104_o, n7105_o, n7106_o, n7107_o};
  /* ascal.vhd:2789:75  */
  assign n7109_o = o_vpix_outer[71:48];
  /* ascal.vhd:2789:92  */
  assign n7110_o = o_vpix_outer[47:24];
  /* ascal.vhd:2789:109  */
  assign n7111_o = o_vpix_inner[47:24];
  /* ascal.vhd:2789:126  */
  assign n7112_o = o_vpix_inner[47:24];
  assign n7113_o = {n7109_o, n7110_o, n7111_o, n7112_o};
  /* ascal.vhd:2786:41  */
  assign n7114_o = n7103_o ? n7108_o : n7113_o;
  /* ascal.vhd:2792:53  */
  assign n7115_o = ~n7015_o;
  /* ascal.vhd:2793:75  */
  assign n7116_o = o_vpix_outer[71:48];
  /* ascal.vhd:2793:92  */
  assign n7117_o = o_vpix_inner[47:24];
  /* ascal.vhd:2793:109  */
  assign n7118_o = o_vpix_outer[47:24];
  /* ascal.vhd:2793:126  */
  assign n7119_o = o_vpix_outer[23:0];
  assign n7120_o = {n7116_o, n7117_o, n7118_o, n7119_o};
  /* ascal.vhd:2795:75  */
  assign n7121_o = o_vpix_outer[71:48];
  /* ascal.vhd:2795:92  */
  assign n7122_o = o_vpix_outer[47:24];
  /* ascal.vhd:2795:109  */
  assign n7123_o = o_vpix_inner[47:24];
  /* ascal.vhd:2795:126  */
  assign n7124_o = o_vpix_outer[23:0];
  assign n7125_o = {n7121_o, n7122_o, n7123_o, n7124_o};
  /* ascal.vhd:2792:41  */
  assign n7126_o = n7115_o ? n7120_o : n7125_o;
  /* ascal.vhd:2785:33  */
  assign n7127_o = n7102_o ? n7114_o : n7126_o;
  /* ascal.vhd:2779:33  */
  assign n7128_o = n7086_o ? n7098_o : n7127_o;
  /* ascal.vhd:806:21  */
  assign n7137_o = o_vfrac[11];
  /* ascal.vhd:806:25  */
  assign n7138_o = ~n7137_o;
  /* ascal.vhd:807:29  */
  assign n7139_o = o_vfrac[11:8];
  /* ascal.vhd:809:33  */
  assign n7140_o = o_vfrac[11:8];
  /* ascal.vhd:809:28  */
  assign n7141_o = ~n7140_o;
  /* ascal.vhd:806:17  */
  assign n7142_o = n7138_o ? n7139_o : n7141_o;
  /* ascal.vhd:811:21  */
  assign n7144_o = {4'b0, n7142_o};  //  uext
  /* ascal.vhd:811:21  */
  assign n7145_o = {4'b0, n7142_o};  //  uext
  /* ascal.vhd:811:21  */
  assign n7146_o = n7144_o * n7145_o; // smul
  /* ascal.vhd:813:23  */
  assign n7150_o = n7146_o[6:3];
  assign n7151_o = {n7150_o, n7142_o};
  /* ascal.vhd:2808:43  */
  assign n7152_o = o_vmode[0];
  /* ascal.vhd:741:25  */
  assign n7158_o = o_vfrac[11:8];
  /* ascal.vhd:821:22  */
  assign n7165_o = o_v_sbil_t[3:0];
  /* ascal.vhd:821:26  */
  assign n7166_o = o_v_sbil_t[7:4];
  /* ascal.vhd:821:23  */
  assign n7167_o = {4'b0, n7165_o};  //  uext
  /* ascal.vhd:821:23  */
  assign n7168_o = {4'b0, n7166_o};  //  uext
  /* ascal.vhd:821:23  */
  assign n7169_o = n7167_o * n7168_o; // smul
  /* ascal.vhd:822:21  */
  assign n7171_o = o_vfrac[11];
  /* ascal.vhd:822:25  */
  assign n7172_o = ~n7171_o;
  /* ascal.vhd:823:33  */
  assign n7173_o = n7169_o[6:3];
  /* ascal.vhd:825:37  */
  assign n7174_o = n7169_o[6:3];
  /* ascal.vhd:825:32  */
  assign n7175_o = ~n7174_o;
  /* ascal.vhd:822:17  */
  assign n7176_o = n7172_o ? n7173_o : n7175_o;
  /* ascal.vhd:2808:33  */
  assign n7177_o = n7152_o ? n7158_o : n7176_o;
  /* ascal.vhd:755:26  */
  assign n7189_o = {1'b0, o_v_bil_frac};
  /* ascal.vhd:755:39  */
  assign n7190_o = o_v_bil_frac[3];
  /* ascal.vhd:755:36  */
  assign n7192_o = {4'b0000, n7190_o};
  /* ascal.vhd:755:31  */
  assign n7193_o = n7189_o + n7192_o;
  /* ascal.vhd:756:31  */
  assign n7196_o = 5'b10000 - n7193_o;
  /* ascal.vhd:757:21  */
  assign n7198_o = o_vpixq[47:24];
  /* ascal.vhd:757:25  */
  assign n7199_o = n7198_o[7:0];
  /* ascal.vhd:757:27  */
  assign n7200_o = {5'b0, n7199_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n7201_o = {8'b0, n7193_o};  //  uext
  /* ascal.vhd:757:27  */
  assign n7202_o = n7200_o * n7201_o; // smul
  /* ascal.vhd:757:35  */
  assign n7203_o = o_vpixq[71:48];
  /* ascal.vhd:757:39  */
  assign n7204_o = n7203_o[7:0];
  /* ascal.vhd:757:41  */
  assign n7205_o = {5'b0, n7204_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n7206_o = {8'b0, n7196_o};  //  uext
  /* ascal.vhd:757:41  */
  assign n7207_o = n7205_o * n7206_o; // smul
  /* ascal.vhd:757:32  */
  assign n7208_o = n7202_o + n7207_o;
  /* ascal.vhd:759:21  */
  assign n7212_o = o_vpixq[47:24];
  /* ascal.vhd:759:25  */
  assign n7213_o = n7212_o[15:8];
  /* ascal.vhd:759:27  */
  assign n7214_o = {5'b0, n7213_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n7215_o = {8'b0, n7193_o};  //  uext
  /* ascal.vhd:759:27  */
  assign n7216_o = n7214_o * n7215_o; // smul
  /* ascal.vhd:759:35  */
  assign n7217_o = o_vpixq[71:48];
  /* ascal.vhd:759:39  */
  assign n7218_o = n7217_o[15:8];
  /* ascal.vhd:759:41  */
  assign n7219_o = {5'b0, n7218_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n7220_o = {8'b0, n7196_o};  //  uext
  /* ascal.vhd:759:41  */
  assign n7221_o = n7219_o * n7220_o; // smul
  /* ascal.vhd:759:32  */
  assign n7222_o = n7216_o + n7221_o;
  /* ascal.vhd:761:21  */
  assign n7224_o = o_vpixq[47:24];
  /* ascal.vhd:761:25  */
  assign n7225_o = n7224_o[23:16];
  /* ascal.vhd:761:27  */
  assign n7226_o = {5'b0, n7225_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n7227_o = {8'b0, n7193_o};  //  uext
  /* ascal.vhd:761:27  */
  assign n7228_o = n7226_o * n7227_o; // smul
  /* ascal.vhd:761:35  */
  assign n7229_o = o_vpixq[71:48];
  /* ascal.vhd:761:39  */
  assign n7230_o = n7229_o[23:16];
  /* ascal.vhd:761:41  */
  assign n7231_o = {5'b0, n7230_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n7232_o = {8'b0, n7196_o};  //  uext
  /* ascal.vhd:761:41  */
  assign n7233_o = n7231_o * n7232_o; // smul
  /* ascal.vhd:761:32  */
  assign n7234_o = n7228_o + n7233_o;
  assign n7235_o = {n7234_o, n7222_o, n7208_o};
  /* ascal.vhd:2822:64  */
  assign n7237_o = o_v_bil_t[12:0];
  /* ascal.vhd:715:21  */
  assign n7242_o = n7237_o[12];
  /* ascal.vhd:717:24  */
  assign n7244_o = n7237_o[12];
  /* ascal.vhd:717:41  */
  assign n7246_o = n7244_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n7248_o = n7237_o[11:4];
  /* ascal.vhd:717:17  */
  assign n7249_o = n7246_o ? 8'b11111111 : n7248_o;
  /* ascal.vhd:715:17  */
  assign n7250_o = n7242_o ? 8'b00000000 : n7249_o;
  /* ascal.vhd:2823:64  */
  assign n7252_o = o_v_bil_t[25:13];
  /* ascal.vhd:715:21  */
  assign n7257_o = n7252_o[12];
  /* ascal.vhd:717:24  */
  assign n7259_o = n7252_o[12];
  /* ascal.vhd:717:41  */
  assign n7261_o = n7259_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n7263_o = n7252_o[11:4];
  /* ascal.vhd:717:17  */
  assign n7264_o = n7261_o ? 8'b11111111 : n7263_o;
  /* ascal.vhd:715:17  */
  assign n7265_o = n7257_o ? 8'b00000000 : n7264_o;
  /* ascal.vhd:2824:64  */
  assign n7267_o = o_v_bil_t[38:26];
  /* ascal.vhd:715:21  */
  assign n7272_o = n7267_o[12];
  /* ascal.vhd:717:24  */
  assign n7274_o = n7267_o[12];
  /* ascal.vhd:717:41  */
  assign n7276_o = n7274_o != 1'b0;
  /* ascal.vhd:720:33  */
  assign n7278_o = n7267_o[11:4];
  /* ascal.vhd:717:17  */
  assign n7279_o = n7276_o ? 8'b11111111 : n7278_o;
  /* ascal.vhd:715:17  */
  assign n7280_o = n7272_o ? 8'b00000000 : n7279_o;
  /* ascal.vhd:876:60  */
  assign n7287_o = o_vpixq[95:72];
  /* ascal.vhd:876:64  */
  assign n7288_o = n7287_o[7:0];
  /* ascal.vhd:876:67  */
  assign n7289_o = o_vpixq[71:48];
  /* ascal.vhd:876:71  */
  assign n7290_o = n7289_o[7:0];
  /* ascal.vhd:876:74  */
  assign n7291_o = o_vpixq[47:24];
  /* ascal.vhd:876:78  */
  assign n7292_o = n7291_o[7:0];
  /* ascal.vhd:876:81  */
  assign n7293_o = o_vpixq[23:0];
  /* ascal.vhd:876:85  */
  assign n7294_o = n7293_o[7:0];
  /* ascal.vhd:862:37  */
  assign n7300_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7302_o = {1'b0, n7300_o};
  /* ascal.vhd:863:47  */
  assign n7303_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7305_o = {1'b0, n7303_o};
  /* ascal.vhd:862:58  */
  assign n7306_o = {{5{n7302_o[4]}}, n7302_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7307_o = {{5{n7305_o[4]}}, n7305_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7308_o = n7306_o * n7307_o; // smul
  /* ascal.vhd:866:40  */
  assign n7311_o = {1'b0, n7292_o};
  /* ascal.vhd:866:53  */
  assign n7313_o = {1'b0, n7288_o};
  /* ascal.vhd:866:46  */
  assign n7314_o = n7311_o - n7313_o;
  /* ascal.vhd:867:42  */
  assign n7316_o = {3'b000, n7288_o};
  /* ascal.vhd:867:47  */
  assign n7318_o = {n7316_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7320_o = {2'b00, n7290_o};
  /* ascal.vhd:867:67  */
  assign n7322_o = {n7320_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7323_o = n7318_o - n7322_o;
  /* ascal.vhd:867:85  */
  assign n7325_o = {4'b0000, n7290_o};
  /* ascal.vhd:867:75  */
  assign n7326_o = n7323_o - n7325_o;
  /* ascal.vhd:868:56  */
  assign n7328_o = {2'b00, n7292_o};
  /* ascal.vhd:868:61  */
  assign n7330_o = {n7328_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7331_o = n7326_o + n7330_o;
  /* ascal.vhd:868:79  */
  assign n7333_o = {4'b0000, n7294_o};
  /* ascal.vhd:868:69  */
  assign n7334_o = n7331_o - n7333_o;
  /* ascal.vhd:869:41  */
  assign n7336_o = {2'b00, n7290_o};
  /* ascal.vhd:869:46  */
  assign n7338_o = {n7336_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7340_o = {2'b00, n7292_o};
  /* ascal.vhd:869:66  */
  assign n7342_o = {n7340_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7343_o = n7338_o - n7342_o;
  /* ascal.vhd:869:82  */
  assign n7345_o = {3'b000, n7292_o};
  /* ascal.vhd:869:73  */
  assign n7346_o = n7343_o - n7345_o;
  /* ascal.vhd:870:57  */
  assign n7348_o = {3'b000, n7290_o};
  /* ascal.vhd:869:88  */
  assign n7349_o = n7346_o + n7348_o;
  /* ascal.vhd:870:72  */
  assign n7351_o = {3'b000, n7294_o};
  /* ascal.vhd:870:63  */
  assign n7352_o = n7349_o + n7351_o;
  /* ascal.vhd:870:87  */
  assign n7354_o = {3'b000, n7288_o};
  /* ascal.vhd:870:78  */
  assign n7355_o = n7352_o - n7354_o;
  /* ascal.vhd:871:31  */
  assign n7356_o = n7308_o[8:0];
  assign n7357_o = {n7356_o, n7355_o, n7334_o, n7314_o};
  assign n7358_o = {n7357_o, n7290_o};
  /* ascal.vhd:877:105  */
  assign n7360_o = o_vpixq[95:72];
  /* ascal.vhd:877:109  */
  assign n7361_o = n7360_o[15:8];
  /* ascal.vhd:877:112  */
  assign n7362_o = o_vpixq[71:48];
  /* ascal.vhd:877:116  */
  assign n7363_o = n7362_o[15:8];
  /* ascal.vhd:877:119  */
  assign n7364_o = o_vpixq[47:24];
  /* ascal.vhd:877:123  */
  assign n7365_o = n7364_o[15:8];
  /* ascal.vhd:877:126  */
  assign n7366_o = o_vpixq[23:0];
  /* ascal.vhd:877:130  */
  assign n7367_o = n7366_o[15:8];
  /* ascal.vhd:862:37  */
  assign n7373_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7375_o = {1'b0, n7373_o};
  /* ascal.vhd:863:47  */
  assign n7376_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7378_o = {1'b0, n7376_o};
  /* ascal.vhd:862:58  */
  assign n7379_o = {{5{n7375_o[4]}}, n7375_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7380_o = {{5{n7378_o[4]}}, n7378_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7381_o = n7379_o * n7380_o; // smul
  /* ascal.vhd:866:40  */
  assign n7384_o = {1'b0, n7365_o};
  /* ascal.vhd:866:53  */
  assign n7386_o = {1'b0, n7361_o};
  /* ascal.vhd:866:46  */
  assign n7387_o = n7384_o - n7386_o;
  /* ascal.vhd:867:42  */
  assign n7389_o = {3'b000, n7361_o};
  /* ascal.vhd:867:47  */
  assign n7391_o = {n7389_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7393_o = {2'b00, n7363_o};
  /* ascal.vhd:867:67  */
  assign n7395_o = {n7393_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7396_o = n7391_o - n7395_o;
  /* ascal.vhd:867:85  */
  assign n7398_o = {4'b0000, n7363_o};
  /* ascal.vhd:867:75  */
  assign n7399_o = n7396_o - n7398_o;
  /* ascal.vhd:868:56  */
  assign n7401_o = {2'b00, n7365_o};
  /* ascal.vhd:868:61  */
  assign n7403_o = {n7401_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7404_o = n7399_o + n7403_o;
  /* ascal.vhd:868:79  */
  assign n7406_o = {4'b0000, n7367_o};
  /* ascal.vhd:868:69  */
  assign n7407_o = n7404_o - n7406_o;
  /* ascal.vhd:869:41  */
  assign n7409_o = {2'b00, n7363_o};
  /* ascal.vhd:869:46  */
  assign n7411_o = {n7409_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7413_o = {2'b00, n7365_o};
  /* ascal.vhd:869:66  */
  assign n7415_o = {n7413_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7416_o = n7411_o - n7415_o;
  /* ascal.vhd:869:82  */
  assign n7418_o = {3'b000, n7365_o};
  /* ascal.vhd:869:73  */
  assign n7419_o = n7416_o - n7418_o;
  /* ascal.vhd:870:57  */
  assign n7421_o = {3'b000, n7363_o};
  /* ascal.vhd:869:88  */
  assign n7422_o = n7419_o + n7421_o;
  /* ascal.vhd:870:72  */
  assign n7424_o = {3'b000, n7367_o};
  /* ascal.vhd:870:63  */
  assign n7425_o = n7422_o + n7424_o;
  /* ascal.vhd:870:87  */
  assign n7427_o = {3'b000, n7361_o};
  /* ascal.vhd:870:78  */
  assign n7428_o = n7425_o - n7427_o;
  /* ascal.vhd:871:31  */
  assign n7429_o = n7381_o[8:0];
  assign n7430_o = {n7429_o, n7428_o, n7407_o, n7387_o};
  assign n7431_o = {n7430_o, n7363_o};
  /* ascal.vhd:878:105  */
  assign n7433_o = o_vpixq[95:72];
  /* ascal.vhd:878:109  */
  assign n7434_o = n7433_o[23:16];
  /* ascal.vhd:878:112  */
  assign n7435_o = o_vpixq[71:48];
  /* ascal.vhd:878:116  */
  assign n7436_o = n7435_o[23:16];
  /* ascal.vhd:878:119  */
  assign n7437_o = o_vpixq[47:24];
  /* ascal.vhd:878:123  */
  assign n7438_o = n7437_o[23:16];
  /* ascal.vhd:878:126  */
  assign n7439_o = o_vpixq[23:0];
  /* ascal.vhd:878:130  */
  assign n7440_o = n7439_o[23:16];
  /* ascal.vhd:862:37  */
  assign n7446_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7448_o = {1'b0, n7446_o};
  /* ascal.vhd:863:47  */
  assign n7449_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7451_o = {1'b0, n7449_o};
  /* ascal.vhd:862:58  */
  assign n7452_o = {{5{n7448_o[4]}}, n7448_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7453_o = {{5{n7451_o[4]}}, n7451_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7454_o = n7452_o * n7453_o; // smul
  /* ascal.vhd:866:40  */
  assign n7457_o = {1'b0, n7438_o};
  /* ascal.vhd:866:53  */
  assign n7459_o = {1'b0, n7434_o};
  /* ascal.vhd:866:46  */
  assign n7460_o = n7457_o - n7459_o;
  /* ascal.vhd:867:42  */
  assign n7462_o = {3'b000, n7434_o};
  /* ascal.vhd:867:47  */
  assign n7464_o = {n7462_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7466_o = {2'b00, n7436_o};
  /* ascal.vhd:867:67  */
  assign n7468_o = {n7466_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7469_o = n7464_o - n7468_o;
  /* ascal.vhd:867:85  */
  assign n7471_o = {4'b0000, n7436_o};
  /* ascal.vhd:867:75  */
  assign n7472_o = n7469_o - n7471_o;
  /* ascal.vhd:868:56  */
  assign n7474_o = {2'b00, n7438_o};
  /* ascal.vhd:868:61  */
  assign n7476_o = {n7474_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7477_o = n7472_o + n7476_o;
  /* ascal.vhd:868:79  */
  assign n7479_o = {4'b0000, n7440_o};
  /* ascal.vhd:868:69  */
  assign n7480_o = n7477_o - n7479_o;
  /* ascal.vhd:869:41  */
  assign n7482_o = {2'b00, n7436_o};
  /* ascal.vhd:869:46  */
  assign n7484_o = {n7482_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7486_o = {2'b00, n7438_o};
  /* ascal.vhd:869:66  */
  assign n7488_o = {n7486_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7489_o = n7484_o - n7488_o;
  /* ascal.vhd:869:82  */
  assign n7491_o = {3'b000, n7438_o};
  /* ascal.vhd:869:73  */
  assign n7492_o = n7489_o - n7491_o;
  /* ascal.vhd:870:57  */
  assign n7494_o = {3'b000, n7436_o};
  /* ascal.vhd:869:88  */
  assign n7495_o = n7492_o + n7494_o;
  /* ascal.vhd:870:72  */
  assign n7497_o = {3'b000, n7440_o};
  /* ascal.vhd:870:63  */
  assign n7498_o = n7495_o + n7497_o;
  /* ascal.vhd:870:87  */
  assign n7500_o = {3'b000, n7434_o};
  /* ascal.vhd:870:78  */
  assign n7501_o = n7498_o - n7500_o;
  /* ascal.vhd:871:31  */
  assign n7502_o = n7454_o[8:0];
  assign n7503_o = {n7502_o, n7501_o, n7480_o, n7460_o};
  assign n7504_o = {n7503_o, n7436_o};
  assign n7505_o = {n7504_o, n7431_o, n7358_o};
  /* ascal.vhd:876:60  */
  assign n7513_o = o_vpixq[95:72];
  /* ascal.vhd:876:64  */
  assign n7514_o = n7513_o[7:0];
  /* ascal.vhd:876:67  */
  assign n7515_o = o_vpixq[71:48];
  /* ascal.vhd:876:71  */
  assign n7516_o = n7515_o[7:0];
  /* ascal.vhd:876:74  */
  assign n7517_o = o_vpixq[47:24];
  /* ascal.vhd:876:78  */
  assign n7518_o = n7517_o[7:0];
  /* ascal.vhd:876:81  */
  assign n7519_o = o_vpixq[23:0];
  /* ascal.vhd:876:85  */
  assign n7520_o = n7519_o[7:0];
  /* ascal.vhd:862:37  */
  assign n7526_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7528_o = {1'b0, n7526_o};
  /* ascal.vhd:863:47  */
  assign n7529_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7531_o = {1'b0, n7529_o};
  /* ascal.vhd:862:58  */
  assign n7532_o = {{5{n7528_o[4]}}, n7528_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7533_o = {{5{n7531_o[4]}}, n7531_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7534_o = n7532_o * n7533_o; // smul
  /* ascal.vhd:866:40  */
  assign n7537_o = {1'b0, n7518_o};
  /* ascal.vhd:866:53  */
  assign n7539_o = {1'b0, n7514_o};
  /* ascal.vhd:866:46  */
  assign n7540_o = n7537_o - n7539_o;
  /* ascal.vhd:867:42  */
  assign n7542_o = {3'b000, n7514_o};
  /* ascal.vhd:867:47  */
  assign n7544_o = {n7542_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7546_o = {2'b00, n7516_o};
  /* ascal.vhd:867:67  */
  assign n7548_o = {n7546_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7549_o = n7544_o - n7548_o;
  /* ascal.vhd:867:85  */
  assign n7551_o = {4'b0000, n7516_o};
  /* ascal.vhd:867:75  */
  assign n7552_o = n7549_o - n7551_o;
  /* ascal.vhd:868:56  */
  assign n7554_o = {2'b00, n7518_o};
  /* ascal.vhd:868:61  */
  assign n7556_o = {n7554_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7557_o = n7552_o + n7556_o;
  /* ascal.vhd:868:79  */
  assign n7559_o = {4'b0000, n7520_o};
  /* ascal.vhd:868:69  */
  assign n7560_o = n7557_o - n7559_o;
  /* ascal.vhd:869:41  */
  assign n7562_o = {2'b00, n7516_o};
  /* ascal.vhd:869:46  */
  assign n7564_o = {n7562_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7566_o = {2'b00, n7518_o};
  /* ascal.vhd:869:66  */
  assign n7568_o = {n7566_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7569_o = n7564_o - n7568_o;
  /* ascal.vhd:869:82  */
  assign n7571_o = {3'b000, n7518_o};
  /* ascal.vhd:869:73  */
  assign n7572_o = n7569_o - n7571_o;
  /* ascal.vhd:870:57  */
  assign n7574_o = {3'b000, n7516_o};
  /* ascal.vhd:869:88  */
  assign n7575_o = n7572_o + n7574_o;
  /* ascal.vhd:870:72  */
  assign n7577_o = {3'b000, n7520_o};
  /* ascal.vhd:870:63  */
  assign n7578_o = n7575_o + n7577_o;
  /* ascal.vhd:870:87  */
  assign n7580_o = {3'b000, n7514_o};
  /* ascal.vhd:870:78  */
  assign n7581_o = n7578_o - n7580_o;
  /* ascal.vhd:871:31  */
  assign n7582_o = n7534_o[8:0];
  assign n7583_o = {n7582_o, n7581_o, n7560_o, n7540_o};
  assign n7584_o = {n7583_o, n7516_o};
  /* ascal.vhd:877:105  */
  assign n7586_o = o_vpixq[95:72];
  /* ascal.vhd:877:109  */
  assign n7587_o = n7586_o[15:8];
  /* ascal.vhd:877:112  */
  assign n7588_o = o_vpixq[71:48];
  /* ascal.vhd:877:116  */
  assign n7589_o = n7588_o[15:8];
  /* ascal.vhd:877:119  */
  assign n7590_o = o_vpixq[47:24];
  /* ascal.vhd:877:123  */
  assign n7591_o = n7590_o[15:8];
  /* ascal.vhd:877:126  */
  assign n7592_o = o_vpixq[23:0];
  /* ascal.vhd:877:130  */
  assign n7593_o = n7592_o[15:8];
  /* ascal.vhd:862:37  */
  assign n7599_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7601_o = {1'b0, n7599_o};
  /* ascal.vhd:863:47  */
  assign n7602_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7604_o = {1'b0, n7602_o};
  /* ascal.vhd:862:58  */
  assign n7605_o = {{5{n7601_o[4]}}, n7601_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7606_o = {{5{n7604_o[4]}}, n7604_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7607_o = n7605_o * n7606_o; // smul
  /* ascal.vhd:866:40  */
  assign n7610_o = {1'b0, n7591_o};
  /* ascal.vhd:866:53  */
  assign n7612_o = {1'b0, n7587_o};
  /* ascal.vhd:866:46  */
  assign n7613_o = n7610_o - n7612_o;
  /* ascal.vhd:867:42  */
  assign n7615_o = {3'b000, n7587_o};
  /* ascal.vhd:867:47  */
  assign n7617_o = {n7615_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7619_o = {2'b00, n7589_o};
  /* ascal.vhd:867:67  */
  assign n7621_o = {n7619_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7622_o = n7617_o - n7621_o;
  /* ascal.vhd:867:85  */
  assign n7624_o = {4'b0000, n7589_o};
  /* ascal.vhd:867:75  */
  assign n7625_o = n7622_o - n7624_o;
  /* ascal.vhd:868:56  */
  assign n7627_o = {2'b00, n7591_o};
  /* ascal.vhd:868:61  */
  assign n7629_o = {n7627_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7630_o = n7625_o + n7629_o;
  /* ascal.vhd:868:79  */
  assign n7632_o = {4'b0000, n7593_o};
  /* ascal.vhd:868:69  */
  assign n7633_o = n7630_o - n7632_o;
  /* ascal.vhd:869:41  */
  assign n7635_o = {2'b00, n7589_o};
  /* ascal.vhd:869:46  */
  assign n7637_o = {n7635_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7639_o = {2'b00, n7591_o};
  /* ascal.vhd:869:66  */
  assign n7641_o = {n7639_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7642_o = n7637_o - n7641_o;
  /* ascal.vhd:869:82  */
  assign n7644_o = {3'b000, n7591_o};
  /* ascal.vhd:869:73  */
  assign n7645_o = n7642_o - n7644_o;
  /* ascal.vhd:870:57  */
  assign n7647_o = {3'b000, n7589_o};
  /* ascal.vhd:869:88  */
  assign n7648_o = n7645_o + n7647_o;
  /* ascal.vhd:870:72  */
  assign n7650_o = {3'b000, n7593_o};
  /* ascal.vhd:870:63  */
  assign n7651_o = n7648_o + n7650_o;
  /* ascal.vhd:870:87  */
  assign n7653_o = {3'b000, n7587_o};
  /* ascal.vhd:870:78  */
  assign n7654_o = n7651_o - n7653_o;
  /* ascal.vhd:871:31  */
  assign n7655_o = n7607_o[8:0];
  assign n7656_o = {n7655_o, n7654_o, n7633_o, n7613_o};
  assign n7657_o = {n7656_o, n7589_o};
  /* ascal.vhd:878:105  */
  assign n7659_o = o_vpixq[95:72];
  /* ascal.vhd:878:109  */
  assign n7660_o = n7659_o[23:16];
  /* ascal.vhd:878:112  */
  assign n7661_o = o_vpixq[71:48];
  /* ascal.vhd:878:116  */
  assign n7662_o = n7661_o[23:16];
  /* ascal.vhd:878:119  */
  assign n7663_o = o_vpixq[47:24];
  /* ascal.vhd:878:123  */
  assign n7664_o = n7663_o[23:16];
  /* ascal.vhd:878:126  */
  assign n7665_o = o_vpixq[23:0];
  /* ascal.vhd:878:130  */
  assign n7666_o = n7665_o[23:16];
  /* ascal.vhd:862:37  */
  assign n7672_o = o_vfrac[11:8];
  /* ascal.vhd:862:34  */
  assign n7674_o = {1'b0, n7672_o};
  /* ascal.vhd:863:47  */
  assign n7675_o = o_vfrac[11:8];
  /* ascal.vhd:863:44  */
  assign n7677_o = {1'b0, n7675_o};
  /* ascal.vhd:862:58  */
  assign n7678_o = {{5{n7674_o[4]}}, n7674_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7679_o = {{5{n7677_o[4]}}, n7677_o}; // sext
  /* ascal.vhd:862:58  */
  assign n7680_o = n7678_o * n7679_o; // smul
  /* ascal.vhd:866:40  */
  assign n7683_o = {1'b0, n7664_o};
  /* ascal.vhd:866:53  */
  assign n7685_o = {1'b0, n7660_o};
  /* ascal.vhd:866:46  */
  assign n7686_o = n7683_o - n7685_o;
  /* ascal.vhd:867:42  */
  assign n7688_o = {3'b000, n7660_o};
  /* ascal.vhd:867:47  */
  assign n7690_o = {n7688_o, 1'b0};
  /* ascal.vhd:867:62  */
  assign n7692_o = {2'b00, n7662_o};
  /* ascal.vhd:867:67  */
  assign n7694_o = {n7692_o, 2'b00};
  /* ascal.vhd:867:54  */
  assign n7695_o = n7690_o - n7694_o;
  /* ascal.vhd:867:85  */
  assign n7697_o = {4'b0000, n7662_o};
  /* ascal.vhd:867:75  */
  assign n7698_o = n7695_o - n7697_o;
  /* ascal.vhd:868:56  */
  assign n7700_o = {2'b00, n7664_o};
  /* ascal.vhd:868:61  */
  assign n7702_o = {n7700_o, 2'b00};
  /* ascal.vhd:867:91  */
  assign n7703_o = n7698_o + n7702_o;
  /* ascal.vhd:868:79  */
  assign n7705_o = {4'b0000, n7666_o};
  /* ascal.vhd:868:69  */
  assign n7706_o = n7703_o - n7705_o;
  /* ascal.vhd:869:41  */
  assign n7708_o = {2'b00, n7662_o};
  /* ascal.vhd:869:46  */
  assign n7710_o = {n7708_o, 1'b0};
  /* ascal.vhd:869:61  */
  assign n7712_o = {2'b00, n7664_o};
  /* ascal.vhd:869:66  */
  assign n7714_o = {n7712_o, 1'b0};
  /* ascal.vhd:869:53  */
  assign n7715_o = n7710_o - n7714_o;
  /* ascal.vhd:869:82  */
  assign n7717_o = {3'b000, n7664_o};
  /* ascal.vhd:869:73  */
  assign n7718_o = n7715_o - n7717_o;
  /* ascal.vhd:870:57  */
  assign n7720_o = {3'b000, n7662_o};
  /* ascal.vhd:869:88  */
  assign n7721_o = n7718_o + n7720_o;
  /* ascal.vhd:870:72  */
  assign n7723_o = {3'b000, n7666_o};
  /* ascal.vhd:870:63  */
  assign n7724_o = n7721_o + n7723_o;
  /* ascal.vhd:870:87  */
  assign n7726_o = {3'b000, n7660_o};
  /* ascal.vhd:870:78  */
  assign n7727_o = n7724_o - n7726_o;
  /* ascal.vhd:871:31  */
  assign n7728_o = n7680_o[8:0];
  assign n7729_o = {n7728_o, n7727_o, n7706_o, n7686_o};
  assign n7730_o = {n7729_o, n7662_o};
  assign n7731_o = {n7730_o, n7657_o, n7584_o};
  /* ascal.vhd:890:28  */
  assign n7740_o = n7731_o[48:0];
  /* ascal.vhd:890:30  */
  assign n7741_o = n7740_o[16:8];
  /* ascal.vhd:890:48  */
  assign n7742_o = o_vfrac[11:8];
  /* ascal.vhd:890:45  */
  assign n7744_o = {1'b0, n7742_o};
  /* ascal.vhd:890:32  */
  assign n7745_o = {{5{n7741_o[8]}}, n7741_o}; // sext
  /* ascal.vhd:890:32  */
  assign n7746_o = {{9{n7744_o[4]}}, n7744_o}; // sext
  /* ascal.vhd:890:32  */
  assign n7747_o = n7745_o * n7746_o; // smul
  /* ascal.vhd:891:27  */
  assign n7749_o = n7747_o[13:5];
  /* ascal.vhd:892:28  */
  assign n7752_o = n7731_o[48:0];
  /* ascal.vhd:892:30  */
  assign n7753_o = n7752_o[28:17];
  /* ascal.vhd:892:39  */
  assign n7754_o = n7731_o[48:0];
  /* ascal.vhd:892:41  */
  assign n7755_o = n7754_o[48:40];
  /* ascal.vhd:892:32  */
  assign n7756_o = {{9{n7753_o[11]}}, n7753_o}; // sext
  /* ascal.vhd:892:32  */
  assign n7757_o = {{12{n7755_o[8]}}, n7755_o}; // sext
  /* ascal.vhd:892:32  */
  assign n7758_o = n7756_o * n7757_o; // smul
  /* ascal.vhd:893:29  */
  assign n7760_o = n7758_o[19:8];
  /* ascal.vhd:894:28  */
  assign n7763_o = n7731_o[48:0];
  /* ascal.vhd:894:30  */
  assign n7764_o = n7763_o[39:29];
  /* ascal.vhd:894:39  */
  assign n7765_o = n7731_o[48:0];
  /* ascal.vhd:894:41  */
  assign n7766_o = n7765_o[48:40];
  /* ascal.vhd:894:32  */
  assign n7767_o = {{9{n7764_o[10]}}, n7764_o}; // sext
  /* ascal.vhd:894:32  */
  assign n7768_o = {{11{n7766_o[8]}}, n7766_o}; // sext
  /* ascal.vhd:894:32  */
  assign n7769_o = n7767_o * n7768_o; // smul
  /* ascal.vhd:895:29  */
  assign n7771_o = n7769_o[18:8];
  /* ascal.vhd:896:28  */
  assign n7774_o = n7731_o[97:49];
  /* ascal.vhd:896:30  */
  assign n7775_o = n7774_o[16:8];
  /* ascal.vhd:896:48  */
  assign n7776_o = o_vfrac[11:8];
  /* ascal.vhd:896:45  */
  assign n7778_o = {1'b0, n7776_o};
  /* ascal.vhd:896:32  */
  assign n7779_o = {{5{n7775_o[8]}}, n7775_o}; // sext
  /* ascal.vhd:896:32  */
  assign n7780_o = {{9{n7778_o[4]}}, n7778_o}; // sext
  /* ascal.vhd:896:32  */
  assign n7781_o = n7779_o * n7780_o; // smul
  /* ascal.vhd:897:27  */
  assign n7782_o = n7781_o[13:5];
  /* ascal.vhd:898:28  */
  assign n7784_o = n7731_o[97:49];
  /* ascal.vhd:898:30  */
  assign n7785_o = n7784_o[28:17];
  /* ascal.vhd:898:39  */
  assign n7786_o = n7731_o[97:49];
  /* ascal.vhd:898:41  */
  assign n7787_o = n7786_o[48:40];
  /* ascal.vhd:898:32  */
  assign n7788_o = {{9{n7785_o[11]}}, n7785_o}; // sext
  /* ascal.vhd:898:32  */
  assign n7789_o = {{12{n7787_o[8]}}, n7787_o}; // sext
  /* ascal.vhd:898:32  */
  assign n7790_o = n7788_o * n7789_o; // smul
  /* ascal.vhd:899:29  */
  assign n7791_o = n7790_o[19:8];
  /* ascal.vhd:900:28  */
  assign n7793_o = n7731_o[97:49];
  /* ascal.vhd:900:30  */
  assign n7794_o = n7793_o[39:29];
  /* ascal.vhd:900:39  */
  assign n7795_o = n7731_o[97:49];
  /* ascal.vhd:900:41  */
  assign n7796_o = n7795_o[48:40];
  /* ascal.vhd:900:32  */
  assign n7797_o = {{9{n7794_o[10]}}, n7794_o}; // sext
  /* ascal.vhd:900:32  */
  assign n7798_o = {{11{n7796_o[8]}}, n7796_o}; // sext
  /* ascal.vhd:900:32  */
  assign n7799_o = n7797_o * n7798_o; // smul
  /* ascal.vhd:901:29  */
  assign n7800_o = n7799_o[18:8];
  /* ascal.vhd:902:28  */
  assign n7802_o = n7731_o[146:98];
  /* ascal.vhd:902:30  */
  assign n7803_o = n7802_o[16:8];
  /* ascal.vhd:902:48  */
  assign n7804_o = o_vfrac[11:8];
  /* ascal.vhd:902:45  */
  assign n7806_o = {1'b0, n7804_o};
  /* ascal.vhd:902:32  */
  assign n7807_o = {{5{n7803_o[8]}}, n7803_o}; // sext
  /* ascal.vhd:902:32  */
  assign n7808_o = {{9{n7806_o[4]}}, n7806_o}; // sext
  /* ascal.vhd:902:32  */
  assign n7809_o = n7807_o * n7808_o; // smul
  /* ascal.vhd:903:27  */
  assign n7810_o = n7809_o[13:5];
  /* ascal.vhd:904:28  */
  assign n7811_o = n7731_o[146:98];
  /* ascal.vhd:904:30  */
  assign n7812_o = n7811_o[28:17];
  /* ascal.vhd:904:39  */
  assign n7813_o = n7731_o[146:98];
  /* ascal.vhd:904:41  */
  assign n7814_o = n7813_o[48:40];
  /* ascal.vhd:904:32  */
  assign n7815_o = {{9{n7812_o[11]}}, n7812_o}; // sext
  /* ascal.vhd:904:32  */
  assign n7816_o = {{12{n7814_o[8]}}, n7814_o}; // sext
  /* ascal.vhd:904:32  */
  assign n7817_o = n7815_o * n7816_o; // smul
  /* ascal.vhd:905:29  */
  assign n7818_o = n7817_o[19:8];
  /* ascal.vhd:906:28  */
  assign n7819_o = n7731_o[146:98];
  /* ascal.vhd:906:30  */
  assign n7820_o = n7819_o[39:29];
  /* ascal.vhd:906:39  */
  assign n7821_o = n7731_o[146:98];
  /* ascal.vhd:906:41  */
  assign n7822_o = n7821_o[48:40];
  /* ascal.vhd:906:32  */
  assign n7823_o = {{9{n7820_o[10]}}, n7820_o}; // sext
  /* ascal.vhd:906:32  */
  assign n7824_o = {{11{n7822_o[8]}}, n7822_o}; // sext
  /* ascal.vhd:906:32  */
  assign n7825_o = n7823_o * n7824_o; // smul
  /* ascal.vhd:907:29  */
  assign n7826_o = n7825_o[18:8];
  assign n7827_o = {n7826_o, n7800_o, n7771_o, n7818_o, n7791_o, n7760_o, n7810_o, n7782_o, n7749_o};
  /* ascal.vhd:919:36  */
  assign n7835_o = o_v_bic_tt1[8];
  /* ascal.vhd:919:44  */
  assign n7836_o = o_v_bic_tt1[8:0];
  /* ascal.vhd:919:40  */
  assign n7837_o = {n7835_o, n7836_o};
  /* ascal.vhd:919:72  */
  assign n7838_o = o_v_bic_abcd1[48:0];
  /* ascal.vhd:919:74  */
  assign n7839_o = n7838_o[7:0];
  /* ascal.vhd:919:58  */
  assign n7841_o = {2'b00, n7839_o};
  /* ascal.vhd:919:50  */
  assign n7842_o = n7837_o + n7841_o;
  /* ascal.vhd:919:87  */
  assign n7843_o = o_v_bic_tt1[37:28];
  /* ascal.vhd:919:78  */
  assign n7844_o = n7842_o + n7843_o;
  /* ascal.vhd:920:36  */
  assign n7847_o = o_v_bic_tt1[17];
  /* ascal.vhd:920:44  */
  assign n7848_o = o_v_bic_tt1[17:9];
  /* ascal.vhd:920:40  */
  assign n7849_o = {n7847_o, n7848_o};
  /* ascal.vhd:920:72  */
  assign n7850_o = o_v_bic_abcd1[97:49];
  /* ascal.vhd:920:74  */
  assign n7851_o = n7850_o[7:0];
  /* ascal.vhd:920:58  */
  assign n7853_o = {2'b00, n7851_o};
  /* ascal.vhd:920:50  */
  assign n7854_o = n7849_o + n7853_o;
  /* ascal.vhd:920:87  */
  assign n7855_o = o_v_bic_tt1[49:40];
  /* ascal.vhd:920:78  */
  assign n7856_o = n7854_o + n7855_o;
  /* ascal.vhd:921:36  */
  assign n7858_o = o_v_bic_tt1[26];
  /* ascal.vhd:921:44  */
  assign n7859_o = o_v_bic_tt1[26:18];
  /* ascal.vhd:921:40  */
  assign n7860_o = {n7858_o, n7859_o};
  /* ascal.vhd:921:72  */
  assign n7861_o = o_v_bic_abcd1[146:98];
  /* ascal.vhd:921:74  */
  assign n7862_o = n7861_o[7:0];
  /* ascal.vhd:921:58  */
  assign n7864_o = {2'b00, n7862_o};
  /* ascal.vhd:921:50  */
  assign n7865_o = n7860_o + n7864_o;
  /* ascal.vhd:921:87  */
  assign n7866_o = o_v_bic_tt1[61:52];
  /* ascal.vhd:921:78  */
  assign n7867_o = n7865_o + n7866_o;
  /* ascal.vhd:923:22  */
  assign n7869_o = o_v_bic_tt1[73:63];
  /* ascal.vhd:923:45  */
  assign n7870_o = o_vfrac[11:8];
  /* ascal.vhd:923:42  */
  assign n7872_o = {1'b0, n7870_o};
  /* ascal.vhd:923:28  */
  assign n7873_o = {{5{n7869_o[10]}}, n7869_o}; // sext
  /* ascal.vhd:923:28  */
  assign n7874_o = {{11{n7872_o[4]}}, n7872_o}; // sext
  /* ascal.vhd:923:28  */
  assign n7875_o = n7873_o * n7874_o; // smul
  /* ascal.vhd:924:28  */
  assign n7877_o = n7875_o[14:5];
  /* ascal.vhd:925:22  */
  assign n7879_o = o_v_bic_tt1[84:74];
  /* ascal.vhd:925:45  */
  assign n7880_o = o_vfrac[11:8];
  /* ascal.vhd:925:42  */
  assign n7882_o = {1'b0, n7880_o};
  /* ascal.vhd:925:28  */
  assign n7883_o = {{5{n7879_o[10]}}, n7879_o}; // sext
  /* ascal.vhd:925:28  */
  assign n7884_o = {{11{n7882_o[4]}}, n7882_o}; // sext
  /* ascal.vhd:925:28  */
  assign n7885_o = n7883_o * n7884_o; // smul
  /* ascal.vhd:926:28  */
  assign n7886_o = n7885_o[14:5];
  /* ascal.vhd:927:22  */
  assign n7888_o = o_v_bic_tt1[95:85];
  /* ascal.vhd:927:45  */
  assign n7889_o = o_vfrac[11:8];
  /* ascal.vhd:927:42  */
  assign n7891_o = {1'b0, n7889_o};
  /* ascal.vhd:927:28  */
  assign n7892_o = {{5{n7888_o[10]}}, n7888_o}; // sext
  /* ascal.vhd:927:28  */
  assign n7893_o = {{11{n7891_o[4]}}, n7891_o}; // sext
  /* ascal.vhd:927:28  */
  assign n7894_o = n7892_o * n7893_o; // smul
  /* ascal.vhd:928:28  */
  assign n7895_o = n7894_o[14:5];
  assign n7896_o = {n7895_o, n7886_o, n7877_o, n7867_o, n7856_o, n7844_o};
  /* ascal.vhd:940:22  */
  assign n7904_o = o_v_bic_tt2[9:0];
  /* ascal.vhd:940:35  */
  assign n7905_o = o_v_bic_tt2[39:30];
  /* ascal.vhd:940:31  */
  assign n7906_o = n7904_o + n7905_o;
  /* ascal.vhd:715:21  */
  assign n7913_o = n7906_o[9];
  /* ascal.vhd:717:24  */
  assign n7915_o = n7906_o[9:8];
  /* ascal.vhd:717:41  */
  assign n7917_o = n7915_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n7919_o = n7906_o[7:0];
  /* ascal.vhd:717:17  */
  assign n7920_o = n7917_o ? 8'b11111111 : n7919_o;
  /* ascal.vhd:715:17  */
  assign n7921_o = n7913_o ? 8'b00000000 : n7920_o;
  /* ascal.vhd:942:22  */
  assign n7924_o = o_v_bic_tt2[19:10];
  /* ascal.vhd:942:35  */
  assign n7925_o = o_v_bic_tt2[49:40];
  /* ascal.vhd:942:31  */
  assign n7926_o = n7924_o + n7925_o;
  /* ascal.vhd:715:21  */
  assign n7932_o = n7926_o[9];
  /* ascal.vhd:717:24  */
  assign n7934_o = n7926_o[9:8];
  /* ascal.vhd:717:41  */
  assign n7936_o = n7934_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n7938_o = n7926_o[7:0];
  /* ascal.vhd:717:17  */
  assign n7939_o = n7936_o ? 8'b11111111 : n7938_o;
  /* ascal.vhd:715:17  */
  assign n7940_o = n7932_o ? 8'b00000000 : n7939_o;
  /* ascal.vhd:944:22  */
  assign n7942_o = o_v_bic_tt2[29:20];
  /* ascal.vhd:944:35  */
  assign n7943_o = o_v_bic_tt2[59:50];
  /* ascal.vhd:944:31  */
  assign n7944_o = n7942_o + n7943_o;
  /* ascal.vhd:715:21  */
  assign n7950_o = n7944_o[9];
  /* ascal.vhd:717:24  */
  assign n7952_o = n7944_o[9:8];
  /* ascal.vhd:717:41  */
  assign n7954_o = n7952_o != 2'b00;
  /* ascal.vhd:720:33  */
  assign n7956_o = n7944_o[7:0];
  /* ascal.vhd:717:17  */
  assign n7957_o = n7954_o ? 8'b11111111 : n7956_o;
  /* ascal.vhd:715:17  */
  assign n7958_o = n7950_o ? 8'b00000000 : n7957_o;
  assign n7959_o = {n7958_o, n7940_o, n7921_o};
  /* ascal.vhd:2841:58  */
  assign n7960_o = o_vpix_inner[167:144];
  /* ascal.vhd:1011:27  */
  assign n7967_o = o_v_poly_phase[17:0];
  /* ascal.vhd:1011:46  */
  assign n7968_o = o_vpixq[95:72];
  /* ascal.vhd:1011:50  */
  assign n7969_o = n7968_o[7:0];
  /* ascal.vhd:1011:43  */
  assign n7971_o = {1'b0, n7969_o};
  /* ascal.vhd:1011:30  */
  assign n7972_o = {{9{n7967_o[17]}}, n7967_o}; // sext
  /* ascal.vhd:1011:30  */
  assign n7973_o = {{18{n7971_o[8]}}, n7971_o}; // sext
  /* ascal.vhd:1011:30  */
  assign n7974_o = n7972_o * n7973_o; // smul
  /* ascal.vhd:1012:45  */
  assign n7975_o = o_v_poly_phase[35:18];
  /* ascal.vhd:1012:64  */
  assign n7976_o = o_vpixq[71:48];
  /* ascal.vhd:1012:68  */
  assign n7977_o = n7976_o[7:0];
  /* ascal.vhd:1012:61  */
  assign n7979_o = {1'b0, n7977_o};
  /* ascal.vhd:1012:48  */
  assign n7980_o = {{9{n7975_o[17]}}, n7975_o}; // sext
  /* ascal.vhd:1012:48  */
  assign n7981_o = {{18{n7979_o[8]}}, n7979_o}; // sext
  /* ascal.vhd:1012:48  */
  assign n7982_o = n7980_o * n7981_o; // smul
  /* ascal.vhd:1011:53  */
  assign n7983_o = n7974_o + n7982_o;
  /* ascal.vhd:1013:27  */
  assign n7986_o = o_v_poly_phase[53:36];
  /* ascal.vhd:1013:46  */
  assign n7987_o = o_vpixq[47:24];
  /* ascal.vhd:1013:50  */
  assign n7988_o = n7987_o[7:0];
  /* ascal.vhd:1013:43  */
  assign n7990_o = {1'b0, n7988_o};
  /* ascal.vhd:1013:30  */
  assign n7991_o = {{9{n7986_o[17]}}, n7986_o}; // sext
  /* ascal.vhd:1013:30  */
  assign n7992_o = {{18{n7990_o[8]}}, n7990_o}; // sext
  /* ascal.vhd:1013:30  */
  assign n7993_o = n7991_o * n7992_o; // smul
  /* ascal.vhd:1014:45  */
  assign n7994_o = o_v_poly_phase[71:54];
  /* ascal.vhd:1014:64  */
  assign n7995_o = o_vpixq[23:0];
  /* ascal.vhd:1014:68  */
  assign n7996_o = n7995_o[7:0];
  /* ascal.vhd:1014:61  */
  assign n7998_o = {1'b0, n7996_o};
  /* ascal.vhd:1014:48  */
  assign n7999_o = {{9{n7994_o[17]}}, n7994_o}; // sext
  /* ascal.vhd:1014:48  */
  assign n8000_o = {{18{n7998_o[8]}}, n7998_o}; // sext
  /* ascal.vhd:1014:48  */
  assign n8001_o = n7999_o * n8000_o; // smul
  /* ascal.vhd:1013:53  */
  assign n8002_o = n7993_o + n8001_o;
  /* ascal.vhd:1015:27  */
  assign n8004_o = o_v_poly_phase[17:0];
  /* ascal.vhd:1015:46  */
  assign n8005_o = o_vpixq[95:72];
  /* ascal.vhd:1015:50  */
  assign n8006_o = n8005_o[15:8];
  /* ascal.vhd:1015:43  */
  assign n8008_o = {1'b0, n8006_o};
  /* ascal.vhd:1015:30  */
  assign n8009_o = {{9{n8004_o[17]}}, n8004_o}; // sext
  /* ascal.vhd:1015:30  */
  assign n8010_o = {{18{n8008_o[8]}}, n8008_o}; // sext
  /* ascal.vhd:1015:30  */
  assign n8011_o = n8009_o * n8010_o; // smul
  /* ascal.vhd:1016:45  */
  assign n8012_o = o_v_poly_phase[35:18];
  /* ascal.vhd:1016:64  */
  assign n8013_o = o_vpixq[71:48];
  /* ascal.vhd:1016:68  */
  assign n8014_o = n8013_o[15:8];
  /* ascal.vhd:1016:61  */
  assign n8016_o = {1'b0, n8014_o};
  /* ascal.vhd:1016:48  */
  assign n8017_o = {{9{n8012_o[17]}}, n8012_o}; // sext
  /* ascal.vhd:1016:48  */
  assign n8018_o = {{18{n8016_o[8]}}, n8016_o}; // sext
  /* ascal.vhd:1016:48  */
  assign n8019_o = n8017_o * n8018_o; // smul
  /* ascal.vhd:1015:53  */
  assign n8020_o = n8011_o + n8019_o;
  /* ascal.vhd:1017:27  */
  assign n8023_o = o_v_poly_phase[53:36];
  /* ascal.vhd:1017:46  */
  assign n8024_o = o_vpixq[47:24];
  /* ascal.vhd:1017:50  */
  assign n8025_o = n8024_o[15:8];
  /* ascal.vhd:1017:43  */
  assign n8027_o = {1'b0, n8025_o};
  /* ascal.vhd:1017:30  */
  assign n8028_o = {{9{n8023_o[17]}}, n8023_o}; // sext
  /* ascal.vhd:1017:30  */
  assign n8029_o = {{18{n8027_o[8]}}, n8027_o}; // sext
  /* ascal.vhd:1017:30  */
  assign n8030_o = n8028_o * n8029_o; // smul
  /* ascal.vhd:1018:45  */
  assign n8031_o = o_v_poly_phase[71:54];
  /* ascal.vhd:1018:64  */
  assign n8032_o = o_vpixq[23:0];
  /* ascal.vhd:1018:68  */
  assign n8033_o = n8032_o[15:8];
  /* ascal.vhd:1018:61  */
  assign n8035_o = {1'b0, n8033_o};
  /* ascal.vhd:1018:48  */
  assign n8036_o = {{9{n8031_o[17]}}, n8031_o}; // sext
  /* ascal.vhd:1018:48  */
  assign n8037_o = {{18{n8035_o[8]}}, n8035_o}; // sext
  /* ascal.vhd:1018:48  */
  assign n8038_o = n8036_o * n8037_o; // smul
  /* ascal.vhd:1017:53  */
  assign n8039_o = n8030_o + n8038_o;
  /* ascal.vhd:1019:27  */
  assign n8040_o = o_v_poly_phase[17:0];
  /* ascal.vhd:1019:46  */
  assign n8041_o = o_vpixq[95:72];
  /* ascal.vhd:1019:50  */
  assign n8042_o = n8041_o[23:16];
  /* ascal.vhd:1019:43  */
  assign n8044_o = {1'b0, n8042_o};
  /* ascal.vhd:1019:30  */
  assign n8045_o = {{9{n8040_o[17]}}, n8040_o}; // sext
  /* ascal.vhd:1019:30  */
  assign n8046_o = {{18{n8044_o[8]}}, n8044_o}; // sext
  /* ascal.vhd:1019:30  */
  assign n8047_o = n8045_o * n8046_o; // smul
  /* ascal.vhd:1020:45  */
  assign n8048_o = o_v_poly_phase[35:18];
  /* ascal.vhd:1020:64  */
  assign n8049_o = o_vpixq[71:48];
  /* ascal.vhd:1020:68  */
  assign n8050_o = n8049_o[23:16];
  /* ascal.vhd:1020:61  */
  assign n8052_o = {1'b0, n8050_o};
  /* ascal.vhd:1020:48  */
  assign n8053_o = {{9{n8048_o[17]}}, n8048_o}; // sext
  /* ascal.vhd:1020:48  */
  assign n8054_o = {{18{n8052_o[8]}}, n8052_o}; // sext
  /* ascal.vhd:1020:48  */
  assign n8055_o = n8053_o * n8054_o; // smul
  /* ascal.vhd:1019:53  */
  assign n8056_o = n8047_o + n8055_o;
  /* ascal.vhd:1021:27  */
  assign n8058_o = o_v_poly_phase[53:36];
  /* ascal.vhd:1021:46  */
  assign n8059_o = o_vpixq[47:24];
  /* ascal.vhd:1021:50  */
  assign n8060_o = n8059_o[23:16];
  /* ascal.vhd:1021:43  */
  assign n8062_o = {1'b0, n8060_o};
  /* ascal.vhd:1021:30  */
  assign n8063_o = {{9{n8058_o[17]}}, n8058_o}; // sext
  /* ascal.vhd:1021:30  */
  assign n8064_o = {{18{n8062_o[8]}}, n8062_o}; // sext
  /* ascal.vhd:1021:30  */
  assign n8065_o = n8063_o * n8064_o; // smul
  /* ascal.vhd:1022:45  */
  assign n8066_o = o_v_poly_phase[71:54];
  /* ascal.vhd:1022:64  */
  assign n8067_o = o_vpixq[23:0];
  /* ascal.vhd:1022:68  */
  assign n8068_o = n8067_o[23:16];
  /* ascal.vhd:1022:61  */
  assign n8070_o = {1'b0, n8068_o};
  /* ascal.vhd:1022:48  */
  assign n8071_o = {{9{n8066_o[17]}}, n8066_o}; // sext
  /* ascal.vhd:1022:48  */
  assign n8072_o = {{18{n8070_o[8]}}, n8070_o}; // sext
  /* ascal.vhd:1022:48  */
  assign n8073_o = n8071_o * n8072_o; // smul
  /* ascal.vhd:1021:53  */
  assign n8074_o = n8065_o + n8073_o;
  assign n8075_o = {n8039_o, n8020_o, n8074_o, n8056_o, n8002_o, n7983_o};
  /* ascal.vhd:1029:41  */
  assign n8083_o = o_v_poly_t[26:8];
  /* ascal.vhd:1029:59  */
  assign n8084_o = o_v_poly_t[53:35];
  /* ascal.vhd:1029:54  */
  assign n8085_o = n8083_o + n8084_o;
  /* ascal.vhd:715:21  */
  assign n8090_o = n8085_o[18];
  /* ascal.vhd:717:24  */
  assign n8092_o = n8085_o[18:15];
  /* ascal.vhd:717:41  */
  assign n8094_o = n8092_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n8096_o = n8085_o[14:7];
  /* ascal.vhd:717:17  */
  assign n8097_o = n8094_o ? 8'b11111111 : n8096_o;
  /* ascal.vhd:715:17  */
  assign n8098_o = n8090_o ? 8'b00000000 : n8097_o;
  /* ascal.vhd:1030:41  */
  assign n8102_o = o_v_poly_t[134:116];
  /* ascal.vhd:1030:59  */
  assign n8103_o = o_v_poly_t[161:143];
  /* ascal.vhd:1030:54  */
  assign n8104_o = n8102_o + n8103_o;
  /* ascal.vhd:715:21  */
  assign n8109_o = n8104_o[18];
  /* ascal.vhd:717:24  */
  assign n8111_o = n8104_o[18:15];
  /* ascal.vhd:717:41  */
  assign n8113_o = n8111_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n8115_o = n8104_o[14:7];
  /* ascal.vhd:717:17  */
  assign n8116_o = n8113_o ? 8'b11111111 : n8115_o;
  /* ascal.vhd:715:17  */
  assign n8117_o = n8109_o ? 8'b00000000 : n8116_o;
  /* ascal.vhd:1031:41  */
  assign n8120_o = o_v_poly_t[80:62];
  /* ascal.vhd:1031:59  */
  assign n8121_o = o_v_poly_t[107:89];
  /* ascal.vhd:1031:54  */
  assign n8122_o = n8120_o + n8121_o;
  /* ascal.vhd:715:21  */
  assign n8127_o = n8122_o[18];
  /* ascal.vhd:717:24  */
  assign n8129_o = n8122_o[18:15];
  /* ascal.vhd:717:41  */
  assign n8131_o = n8129_o != 4'b0000;
  /* ascal.vhd:720:33  */
  assign n8133_o = n8122_o[14:7];
  /* ascal.vhd:717:17  */
  assign n8134_o = n8131_o ? 8'b11111111 : n8133_o;
  /* ascal.vhd:715:17  */
  assign n8135_o = n8127_o ? 8'b00000000 : n8134_o;
  assign n8136_o = {n8135_o, n8117_o, n8098_o};
  /* ascal.vhd:2852:44  */
  assign n8137_o = o_hsv[0];
  /* ascal.vhd:2853:44  */
  assign n8138_o = o_vsv[0];
  /* ascal.vhd:2854:44  */
  assign n8139_o = o_dev[0];
  /* ascal.vhd:2855:45  */
  assign n8140_o = o_end[0];
  /* ascal.vhd:2859:50  */
  assign n8141_o = o_pev[0];
  /* ascal.vhd:2859:41  */
  assign n8142_o = ~n8141_o;
  /* ascal.vhd:2861:45  */
  assign n8143_o = o_vmode[2:0];
  /* ascal.vhd:2864:75  */
  assign n8144_o = o_v_poly_pix[7:0];
  /* ascal.vhd:2865:75  */
  assign n8145_o = o_v_poly_pix[15:8];
  /* ascal.vhd:2866:75  */
  assign n8146_o = o_v_poly_pix[23:16];
  /* ascal.vhd:2862:41  */
  assign n8148_o = n8143_o == 3'b000;
  /* ascal.vhd:2871:74  */
  assign n8149_o = o_v_bil_pix[7:0];
  /* ascal.vhd:2872:74  */
  assign n8150_o = o_v_bil_pix[15:8];
  /* ascal.vhd:2873:74  */
  assign n8151_o = o_v_bil_pix[23:16];
  /* ascal.vhd:2868:41  */
  assign n8153_o = n8143_o == 3'b001;
  /* ascal.vhd:2868:52  */
  assign n8155_o = n8143_o == 3'b010;
  /* ascal.vhd:2868:52  */
  assign n8156_o = n8153_o | n8155_o;
  /* ascal.vhd:2877:74  */
  assign n8157_o = o_v_bic_pix[7:0];
  /* ascal.vhd:2878:74  */
  assign n8158_o = o_v_bic_pix[15:8];
  /* ascal.vhd:2879:74  */
  assign n8159_o = o_v_bic_pix[23:16];
  /* ascal.vhd:2875:41  */
  assign n8161_o = n8143_o == 3'b011;
  /* ascal.vhd:2884:75  */
  assign n8162_o = o_v_poly_pix[7:0];
  /* ascal.vhd:2885:75  */
  assign n8163_o = o_v_poly_pix[15:8];
  /* ascal.vhd:2886:75  */
  assign n8164_o = o_v_poly_pix[23:16];
  assign n8165_o = {n8161_o, n8156_o, n8148_o};
  /* ascal.vhd:2861:33  */
  always @*
    case (n8165_o)
      3'b100: n8166_o <= n8157_o;
      3'b010: n8166_o <= n8149_o;
      3'b001: n8166_o <= n8144_o;
    endcase
  /* ascal.vhd:2861:33  */
  always @*
    case (n8165_o)
      3'b100: n8168_o <= n8158_o;
      3'b010: n8168_o <= n8150_o;
      3'b001: n8168_o <= n8145_o;
    endcase
  /* ascal.vhd:2861:33  */
  always @*
    case (n8165_o)
      3'b100: n8170_o <= n8159_o;
      3'b010: n8170_o <= n8151_o;
      3'b001: n8170_o <= n8146_o;
    endcase
  /* ascal.vhd:2890:41  */
  assign n8172_o = o_pev[0];
  /* ascal.vhd:2890:45  */
  assign n8173_o = ~n8172_o;
  /* ascal.vhd:2891:54  */
  assign n8174_o = o_border[23:16];
  /* ascal.vhd:2892:54  */
  assign n8175_o = o_border[15:8];
  /* ascal.vhd:2893:54  */
  assign n8176_o = o_border[7:0];
  /* ascal.vhd:2890:33  */
  assign n8177_o = n8173_o ? n8174_o : n8166_o;
  /* ascal.vhd:2890:33  */
  assign n8178_o = n8173_o ? n8175_o : n8168_o;
  /* ascal.vhd:2890:33  */
  assign n8179_o = n8173_o ? n8176_o : n8170_o;
  assign n8196_o = {n7081_o, n7082_o};
  assign n8200_o = {n7280_o, n7265_o, n7250_o};
  /* ascal.vhd:2727:17  */
  assign n8251_o = o_ce ? n8177_o : n8252_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8252_q <= n8251_o;
  /* ascal.vhd:2727:17  */
  assign n8253_o = o_ce ? n8178_o : n8254_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8254_q <= n8253_o;
  /* ascal.vhd:2727:17  */
  assign n8255_o = o_ce ? n8179_o : n8256_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8256_q <= n8255_o;
  /* ascal.vhd:2727:17  */
  assign n8257_o = o_ce ? n8137_o : n8258_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8258_q <= n8257_o;
  /* ascal.vhd:2727:17  */
  assign n8259_o = o_ce ? n8138_o : n8260_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8260_q <= n8259_o;
  /* ascal.vhd:2727:17  */
  assign n8261_o = o_ce ? n8139_o : n8262_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8262_q <= n8261_o;
  /* ascal.vhd:2727:17  */
  assign n8263_o = o_ce ? n8140_o : n8264_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8264_q <= n8263_o;
  /* ascal.vhd:2727:17  */
  assign n8265_o = o_ce ? n8142_o : n8266_q;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8266_q <= n8265_o;
  /* ascal.vhd:2727:17  */
  assign n8267_o = o_ce ? n7014_o : o_v_hmin_adj;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8268_q <= n8267_o;
  /* ascal.vhd:2727:17  */
  assign n8269_o = o_ce ? n7053_o : o_radl0;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8270_q <= n8269_o;
  /* ascal.vhd:2727:17  */
  assign n8271_o = o_ce ? n7054_o : o_radl1;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8272_q <= n8271_o;
  /* ascal.vhd:2727:17  */
  assign n8273_o = o_ce ? n7055_o : o_radl2;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8274_q <= n8273_o;
  /* ascal.vhd:2727:17  */
  assign n8275_o = o_ce ? n7056_o : o_radl3;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8276_q <= n8275_o;
  /* ascal.vhd:2727:17  */
  assign n8277_o = o_ce ? o_vpixq_pre : o_vpixq;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8278_q <= n8277_o;
  /* ascal.vhd:2727:17  */
  assign n8279_o = o_ce ? n7128_o : o_vpixq_pre;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8280_q <= n8279_o;
  /* ascal.vhd:2727:17  */
  assign n8281_o = o_ce ? n7080_o : o_vpix_outer;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8282_q <= n8281_o;
  /* ascal.vhd:2727:17  */
  assign n8283_o = o_vpix_inner[167:24];
  /* ascal.vhd:2727:17  */
  assign n8284_o = o_ce ? n8196_o : n8283_o;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8285_q <= n8284_o;
  /* ascal.vhd:2727:17  */
  assign n8286_o = o_ce ? n7177_o : o_v_bil_frac;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8287_q <= n8286_o;
  /* ascal.vhd:2727:17  */
  assign n8288_o = o_ce ? n8200_o : o_v_bil_pix;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8289_q <= n8288_o;
  /* ascal.vhd:2727:17  */
  assign n8290_o = o_ce ? n7235_o : o_v_bil_t;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8291_q <= n8290_o;
  /* ascal.vhd:2727:17  */
  assign n8292_o = o_ce ? n7151_o : o_v_sbil_t;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8293_q <= n8292_o;
  /* ascal.vhd:2727:17  */
  assign n8294_o = o_ce ? n7959_o : o_v_bic_pix;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8295_q <= n8294_o;
  /* ascal.vhd:2727:17  */
  assign n8296_o = o_ce ? n7505_o : o_v_bic_abcd1;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8297_q <= n8296_o;
  /* ascal.vhd:2727:17  */
  assign n8300_o = o_ce ? n7827_o : o_v_bic_tt1;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8301_q <= n8300_o;
  /* ascal.vhd:2727:17  */
  assign n8302_o = o_ce ? n7896_o : o_v_bic_tt2;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8303_q <= n8302_o;
  /* ascal.vhd:2727:17  */
  assign n8304_o = o_ce ? n8136_o : o_v_poly_pix;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8305_q <= n8304_o;
  /* ascal.vhd:2727:17  */
  assign n8306_o = o_ce ? n7960_o : o_v_lum_pix;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8307_q <= n8306_o;
  /* ascal.vhd:2727:17  */
  assign n8308_o = o_ce ? n8075_o : o_v_poly_t;
  /* ascal.vhd:2727:17  */
  always @(posedge o_clk)
    n8309_q <= n8308_o;
  assign n8318_o = {1'b0, 1'b0, 1'b0, 1'b0};
  assign n8319_o = {1'b0, 1'b0, 1'b0, 1'b0};
  assign n8320_o = {o_clk, i_clk, i_pce, o_vss};
  assign n8321_o = {i_flm, i_inter, i_pde, i_vss};
  assign n8322_o = {n8318_o, n8319_o, n8320_o, n8321_o};
  assign n8323_o = {n4639_q, n6642_q};
  assign n8325_o = {12'bZ, n6646_q};
  assign n8327_o = {n8285_q, 24'bZ};
  /* ascal.vhd:1599:40  */
  reg [127:0] i_dpram[31:0] ; // memory
  always @(posedge avl_clk)
    if (1'b1)
      n8337_data <= i_dpram[avl_rad_c];
  always @(posedge i_clk)
    if (i_wr)
      i_dpram[i_wad] <= i_dw;
  /* ascal.vhd:1599:40  */
  /* ascal.vhd:1599:41  */
  /* ascal.vhd:1612:46  */
  reg [23:0] i_mem[2047:0] ; // memory
  always @(posedge i_clk)
    if (i_pce)
      n8339_data <= i_mem[n2080_o];
  always @(posedge i_clk)
    if (i_lwr)
      i_mem[n2072_o] <= i_ldw;
  /* ascal.vhd:1610:25  */
  /* ascal.vhd:1612:54  */
  /* ascal.vhd:1769:40  */
  reg [127:0] o_dpram[31:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8342_data <= o_dpram[o_ad3];
  always @(posedge avl_clk)
    if (avl_wr)
      o_dpram[avl_wad] <= avl_dw;
  /* ascal.vhd:1769:40  */
  /* ascal.vhd:1769:41  */
  /* ascal.vhd:2373:49  */
  reg [47:0] pal1_mem[127:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8345_data <= pal1_mem[n5334_o];
  assign n8346_data = pal1_mem[pal1_a];
  always @(posedge pal1_clk)
    if (pal1_wr)
      pal1_mem[pal1_a] <= pal1_dw;
  /* ascal.vhd:2373:49  */
  /* ascal.vhd:2375:51  */
  /* ascal.vhd:2373:50  */
  /* ascal.vhd:2389:49  */
  reg [23:0] pal2_mem[255:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8349_data <= pal2_mem[pal_idx];
  assign n8350_data = pal2_mem[pal2_a];
  always @(posedge pal2_clk)
    if (pal2_wr)
      pal2_mem[pal2_a] <= pal2_dw;
  /* ascal.vhd:2389:49  */
  /* ascal.vhd:2391:51  */
  /* ascal.vhd:2389:50  */
  /* ascal.vhd:2629:52  */
  reg [23:0] o_line0[2047:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8353_data <= o_line0[o_radl0];
  always @(posedge o_clk)
    if (n6665_o)
      o_line0[o_wadl] <= o_ldw;
  /* ascal.vhd:2629:52  */
  /* ascal.vhd:2629:53  */
  /* ascal.vhd:2630:52  */
  reg [23:0] o_line1[2047:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8356_data <= o_line1[o_radl1];
  always @(posedge o_clk)
    if (n6671_o)
      o_line1[o_wadl] <= o_ldw;
  /* ascal.vhd:2630:52  */
  /* ascal.vhd:2630:53  */
  /* ascal.vhd:2631:52  */
  reg [23:0] o_line2[2047:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8359_data <= o_line2[o_radl2];
  always @(posedge o_clk)
    if (n6677_o)
      o_line2[o_wadl] <= o_ldw;
  /* ascal.vhd:2631:52  */
  /* ascal.vhd:2631:53  */
  /* ascal.vhd:2632:52  */
  reg [23:0] o_line3[2047:0] ; // memory
  always @(posedge o_clk)
    if (1'b1)
      n8362_data <= o_line3[o_radl3];
  always @(posedge o_clk)
    if (n6683_o)
      o_line3[o_wadl] <= o_ldw;
  /* ascal.vhd:2632:52  */
  /* ascal.vhd:2632:53  */
  /* ascal.vhd:2632:25  */
  assign n8364_o = o_v_poly_mem[39:0];
  /* ascal.vhd:2631:25  */
  assign n8365_o = o_v_poly_mem[79:40];
  /* ascal.vhd:2630:25  */
  assign n8366_o = o_v_poly_mem[119:80];
  /* ascal.vhd:2629:25  */
  assign n8367_o = o_v_poly_mem[159:120];
  /* ascal.vhd:2388:33  */
  assign n8368_o = o_v_poly_mem[199:160];
  /* ascal.vhd:2372:33  */
  assign n8369_o = o_v_poly_mem[239:200];
  /* ascal.vhd:1768:25  */
  assign n8370_o = o_v_poly_mem[279:240];
  /* ascal.vhd:1611:33  */
  assign n8371_o = o_v_poly_mem[319:280];
  /* ascal.vhd:1598:25  */
  assign n8372_o = o_v_poly_mem[359:320];
  /* ascal.vhd:459:40  */
  assign n8373_o = o_v_poly_mem[399:360];
  /* ascal.vhd:2632:25  */
  assign n8374_o = o_v_poly_mem[439:400];
  /* ascal.vhd:2638:40  */
  assign n8375_o = o_v_poly_mem[479:440];
  /* ascal.vhd:2627:17  */
  assign n8376_o = o_v_poly_mem[519:480];
  /* ascal.vhd:2638:40  */
  assign n8377_o = o_v_poly_mem[559:520];
  /* ascal.vhd:2638:40  */
  assign n8378_o = o_v_poly_mem[599:560];
  /* ascal.vhd:459:32  */
  assign n8379_o = o_v_poly_mem[639:600];
  /* ascal.vhd:2301:75  */
  assign n8380_o = n4928_o[1:0];
  /* ascal.vhd:2301:75  */
  always @*
    case (n8380_o)
      2'b00: n8381_o <= n8364_o;
      2'b01: n8381_o <= n8365_o;
      2'b10: n8381_o <= n8366_o;
      2'b11: n8381_o <= n8367_o;
    endcase
  /* ascal.vhd:2301:75  */
  assign n8382_o = n4928_o[1:0];
  /* ascal.vhd:2301:75  */
  always @*
    case (n8382_o)
      2'b00: n8383_o <= n8368_o;
      2'b01: n8383_o <= n8369_o;
      2'b10: n8383_o <= n8370_o;
      2'b11: n8383_o <= n8371_o;
    endcase
  /* ascal.vhd:2301:75  */
  assign n8384_o = n4928_o[1:0];
  /* ascal.vhd:2301:75  */
  always @*
    case (n8384_o)
      2'b00: n8385_o <= n8372_o;
      2'b01: n8385_o <= n8373_o;
      2'b10: n8385_o <= n8374_o;
      2'b11: n8385_o <= n8375_o;
    endcase
  /* ascal.vhd:2301:75  */
  assign n8386_o = n4928_o[1:0];
  /* ascal.vhd:2301:75  */
  always @*
    case (n8386_o)
      2'b00: n8387_o <= n8376_o;
      2'b01: n8387_o <= n8377_o;
      2'b10: n8387_o <= n8378_o;
      2'b11: n8387_o <= n8379_o;
    endcase
  /* ascal.vhd:2301:75  */
  assign n8388_o = n4928_o[3:2];
  /* ascal.vhd:2301:75  */
  always @*
    case (n8388_o)
      2'b00: n8389_o <= n8381_o;
      2'b01: n8389_o <= n8383_o;
      2'b10: n8389_o <= n8385_o;
      2'b11: n8389_o <= n8387_o;
    endcase
  /* ascal.vhd:2301:76  */
  assign n8390_o = o_h_poly_mem[39:0];
  /* ascal.vhd:2301:75  */
  assign n8391_o = o_h_poly_mem[79:40];
  /* ascal.vhd:2636:40  */
  assign n8392_o = o_h_poly_mem[119:80];
  /* ascal.vhd:459:16  */
  assign n8393_o = o_h_poly_mem[159:120];
  /* ascal.vhd:2629:25  */
  assign n8394_o = o_h_poly_mem[199:160];
  /* ascal.vhd:2635:40  */
  assign n8395_o = o_h_poly_mem[239:200];
  /* ascal.vhd:2627:17  */
  assign n8396_o = o_h_poly_mem[279:240];
  /* ascal.vhd:2635:40  */
  assign n8397_o = o_h_poly_mem[319:280];
  /* ascal.vhd:2635:40  */
  assign n8398_o = o_h_poly_mem[359:320];
  /* ascal.vhd:421:16  */
  assign n8399_o = o_h_poly_mem[399:360];
  /* ascal.vhd:2388:33  */
  assign n8400_o = o_h_poly_mem[439:400];
  /* ascal.vhd:2391:50  */
  assign n8401_o = o_h_poly_mem[479:440];
  /* ascal.vhd:2395:41  */
  assign n8402_o = o_h_poly_mem[519:480];
  /* ascal.vhd:2395:75  */
  assign n8403_o = o_h_poly_mem[559:520];
  /* ascal.vhd:2391:50  */
  assign n8404_o = o_h_poly_mem[599:560];
  /* ascal.vhd:2391:50  */
  assign n8405_o = o_h_poly_mem[639:600];
  /* ascal.vhd:2307:75  */
  assign n8406_o = n4964_o[1:0];
  /* ascal.vhd:2307:75  */
  always @*
    case (n8406_o)
      2'b00: n8407_o <= n8390_o;
      2'b01: n8407_o <= n8391_o;
      2'b10: n8407_o <= n8392_o;
      2'b11: n8407_o <= n8393_o;
    endcase
  /* ascal.vhd:2307:75  */
  assign n8408_o = n4964_o[1:0];
  /* ascal.vhd:2307:75  */
  always @*
    case (n8408_o)
      2'b00: n8409_o <= n8394_o;
      2'b01: n8409_o <= n8395_o;
      2'b10: n8409_o <= n8396_o;
      2'b11: n8409_o <= n8397_o;
    endcase
  /* ascal.vhd:2307:75  */
  assign n8410_o = n4964_o[1:0];
  /* ascal.vhd:2307:75  */
  always @*
    case (n8410_o)
      2'b00: n8411_o <= n8398_o;
      2'b01: n8411_o <= n8399_o;
      2'b10: n8411_o <= n8400_o;
      2'b11: n8411_o <= n8401_o;
    endcase
  /* ascal.vhd:2307:75  */
  assign n8412_o = n4964_o[1:0];
  /* ascal.vhd:2307:75  */
  always @*
    case (n8412_o)
      2'b00: n8413_o <= n8402_o;
      2'b01: n8413_o <= n8403_o;
      2'b10: n8413_o <= n8404_o;
      2'b11: n8413_o <= n8405_o;
    endcase
  /* ascal.vhd:2307:75  */
  assign n8414_o = n4964_o[3:2];
  /* ascal.vhd:2307:75  */
  always @*
    case (n8414_o)
      2'b00: n8415_o <= n8407_o;
      2'b01: n8415_o <= n8409_o;
      2'b10: n8415_o <= n8411_o;
      2'b11: n8415_o <= n8413_o;
    endcase
  /* ascal.vhd:2307:76  */
  assign n8416_o = o_a_poly_mem[39:0];
  /* ascal.vhd:2307:75  */
  assign n8417_o = o_a_poly_mem[79:40];
  /* ascal.vhd:2381:43  */
  assign n8418_o = o_a_poly_mem[119:80];
  /* ascal.vhd:457:16  */
  assign n8419_o = o_a_poly_mem[159:120];
  /* ascal.vhd:1768:25  */
  assign n8420_o = o_a_poly_mem[199:160];
  /* ascal.vhd:1774:22  */
  assign n8421_o = o_a_poly_mem[239:200];
  /* ascal.vhd:1774:30  */
  assign n8422_o = o_a_poly_mem[279:240];
  /* ascal.vhd:1774:22  */
  assign n8423_o = o_a_poly_mem[319:280];
  /* ascal.vhd:1774:22  */
  assign n8424_o = o_a_poly_mem[359:320];
  /* ascal.vhd:354:16  */
  assign n8425_o = o_a_poly_mem[399:360];
  /* ascal.vhd:1611:33  */
  assign n8426_o = o_a_poly_mem[439:400];
  /* ascal.vhd:1615:54  */
  assign n8427_o = o_a_poly_mem[479:440];
  /* ascal.vhd:1610:25  */
  assign n8428_o = o_a_poly_mem[519:480];
  /* ascal.vhd:1615:62  */
  assign n8429_o = o_a_poly_mem[559:520];
  /* ascal.vhd:1612:46  */
  assign n8430_o = o_a_poly_mem[599:560];
  /* ascal.vhd:1615:54  */
  assign n8431_o = o_a_poly_mem[639:600];
  /* ascal.vhd:2321:65  */
  assign n8432_o = n5035_o[1:0];
  /* ascal.vhd:2321:65  */
  always @*
    case (n8432_o)
      2'b00: n8433_o <= n8416_o;
      2'b01: n8433_o <= n8417_o;
      2'b10: n8433_o <= n8418_o;
      2'b11: n8433_o <= n8419_o;
    endcase
  /* ascal.vhd:2321:65  */
  assign n8434_o = n5035_o[1:0];
  /* ascal.vhd:2321:65  */
  always @*
    case (n8434_o)
      2'b00: n8435_o <= n8420_o;
      2'b01: n8435_o <= n8421_o;
      2'b10: n8435_o <= n8422_o;
      2'b11: n8435_o <= n8423_o;
    endcase
  /* ascal.vhd:2321:65  */
  assign n8436_o = n5035_o[1:0];
  /* ascal.vhd:2321:65  */
  always @*
    case (n8436_o)
      2'b00: n8437_o <= n8424_o;
      2'b01: n8437_o <= n8425_o;
      2'b10: n8437_o <= n8426_o;
      2'b11: n8437_o <= n8427_o;
    endcase
  /* ascal.vhd:2321:65  */
  assign n8438_o = n5035_o[1:0];
  /* ascal.vhd:2321:65  */
  always @*
    case (n8438_o)
      2'b00: n8439_o <= n8428_o;
      2'b01: n8439_o <= n8429_o;
      2'b10: n8439_o <= n8430_o;
      2'b11: n8439_o <= n8431_o;
    endcase
  /* ascal.vhd:2321:65  */
  assign n8440_o = n5035_o[3:2];
  /* ascal.vhd:2321:65  */
  always @*
    case (n8440_o)
      2'b00: n8441_o <= n8433_o;
      2'b01: n8441_o <= n8435_o;
      2'b10: n8441_o <= n8437_o;
      2'b11: n8441_o <= n8439_o;
    endcase
  /* ascal.vhd:2412:25  */
  assign n8442_o = n5392_o[1];
  /* ascal.vhd:2412:25  */
  assign n8443_o = ~n8442_o;
  /* ascal.vhd:2412:25  */
  assign n8444_o = n5392_o[0];
  /* ascal.vhd:2412:25  */
  assign n8445_o = ~n8444_o;
  /* ascal.vhd:2412:25  */
  assign n8446_o = n8443_o & n8445_o;
  /* ascal.vhd:2412:25  */
  assign n8447_o = n8443_o & n8444_o;
  /* ascal.vhd:2412:25  */
  assign n8448_o = n8442_o & n8445_o;
  /* ascal.vhd:2412:25  */
  assign n8449_o = n8442_o & n8444_o;
  /* ascal.vhd:183:17  */
  assign n8450_o = poly_tdw[9:0];
  /* ascal.vhd:2412:25  */
  assign n8451_o = n8446_o & n5461_o;
  /* ascal.vhd:2412:25  */
  assign n8452_o = n8451_o ? poly_dw : n8450_o;
  /* ascal.vhd:155:17  */
  assign n8453_o = poly_tdw[19:10];
  /* ascal.vhd:2412:25  */
  assign n8454_o = n8447_o & n5461_o;
  /* ascal.vhd:2412:25  */
  assign n8455_o = n8454_o ? poly_dw : n8453_o;
  /* ascal.vhd:152:17  */
  assign n8456_o = poly_tdw[29:20];
  /* ascal.vhd:2412:25  */
  assign n8457_o = n8448_o & n5461_o;
  /* ascal.vhd:2412:25  */
  assign n8458_o = n8457_o ? poly_dw : n8456_o;
  /* ascal.vhd:149:17  */
  assign n8459_o = poly_tdw[39:30];
  /* ascal.vhd:2412:25  */
  assign n8460_o = n8449_o & n5461_o;
  /* ascal.vhd:2412:25  */
  assign n8461_o = n8460_o ? poly_dw : n8459_o;
  assign n8462_o = {n8461_o, n8458_o, n8455_o, n8452_o};
  /* ascal.vhd:2424:41  */
  assign n8463_o = n5409_o[3];
  /* ascal.vhd:2424:41  */
  assign n8464_o = ~n8463_o;
  /* ascal.vhd:2424:41  */
  assign n8465_o = n5409_o[2];
  /* ascal.vhd:2424:41  */
  assign n8466_o = ~n8465_o;
  /* ascal.vhd:2424:41  */
  assign n8467_o = n8464_o & n8466_o;
  /* ascal.vhd:2424:41  */
  assign n8468_o = n8464_o & n8465_o;
  /* ascal.vhd:2424:41  */
  assign n8469_o = n8463_o & n8466_o;
  /* ascal.vhd:2424:41  */
  assign n8470_o = n8463_o & n8465_o;
  /* ascal.vhd:2424:41  */
  assign n8471_o = n5409_o[1];
  /* ascal.vhd:2424:41  */
  assign n8472_o = ~n8471_o;
  /* ascal.vhd:2424:41  */
  assign n8473_o = n8467_o & n8472_o;
  /* ascal.vhd:2424:41  */
  assign n8474_o = n8467_o & n8471_o;
  /* ascal.vhd:2424:41  */
  assign n8475_o = n8468_o & n8472_o;
  /* ascal.vhd:2424:41  */
  assign n8476_o = n8468_o & n8471_o;
  /* ascal.vhd:2424:41  */
  assign n8477_o = n8469_o & n8472_o;
  /* ascal.vhd:2424:41  */
  assign n8478_o = n8469_o & n8471_o;
  /* ascal.vhd:2424:41  */
  assign n8479_o = n8470_o & n8472_o;
  /* ascal.vhd:2424:41  */
  assign n8480_o = n8470_o & n8471_o;
  /* ascal.vhd:2424:41  */
  assign n8481_o = n5409_o[0];
  /* ascal.vhd:2424:41  */
  assign n8482_o = ~n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8483_o = n8473_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8484_o = n8473_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8485_o = n8474_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8486_o = n8474_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8487_o = n8475_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8488_o = n8475_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8489_o = n8476_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8490_o = n8476_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8491_o = n8477_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8492_o = n8477_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8493_o = n8478_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8494_o = n8478_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8495_o = n8479_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8496_o = n8479_o & n8481_o;
  /* ascal.vhd:2424:41  */
  assign n8497_o = n8480_o & n8482_o;
  /* ascal.vhd:2424:41  */
  assign n8498_o = n8480_o & n8481_o;
  /* ascal.vhd:2727:17  */
  assign n8499_o = o_h_poly_mem[39:0];
  /* ascal.vhd:2424:41  */
  assign n8500_o = n8483_o ? poly_tdw : n8499_o;
  /* ascal.vhd:2727:17  */
  assign n8501_o = o_h_poly_mem[79:40];
  /* ascal.vhd:2424:41  */
  assign n8502_o = n8484_o ? poly_tdw : n8501_o;
  /* ascal.vhd:2727:17  */
  assign n8503_o = o_h_poly_mem[119:80];
  /* ascal.vhd:2424:41  */
  assign n8504_o = n8485_o ? poly_tdw : n8503_o;
  /* ascal.vhd:2727:17  */
  assign n8505_o = o_h_poly_mem[159:120];
  /* ascal.vhd:2424:41  */
  assign n8506_o = n8486_o ? poly_tdw : n8505_o;
  /* ascal.vhd:2727:17  */
  assign n8507_o = o_h_poly_mem[199:160];
  /* ascal.vhd:2424:41  */
  assign n8508_o = n8487_o ? poly_tdw : n8507_o;
  /* ascal.vhd:2727:17  */
  assign n8509_o = o_h_poly_mem[239:200];
  /* ascal.vhd:2424:41  */
  assign n8510_o = n8488_o ? poly_tdw : n8509_o;
  assign n8511_o = o_h_poly_mem[279:240];
  /* ascal.vhd:2424:41  */
  assign n8512_o = n8489_o ? poly_tdw : n8511_o;
  assign n8513_o = o_h_poly_mem[319:280];
  /* ascal.vhd:2424:41  */
  assign n8514_o = n8490_o ? poly_tdw : n8513_o;
  /* ascal.vhd:712:18  */
  assign n8515_o = o_h_poly_mem[359:320];
  /* ascal.vhd:2424:41  */
  assign n8516_o = n8491_o ? poly_tdw : n8515_o;
  assign n8517_o = o_h_poly_mem[399:360];
  /* ascal.vhd:2424:41  */
  assign n8518_o = n8492_o ? poly_tdw : n8517_o;
  assign n8519_o = o_h_poly_mem[439:400];
  /* ascal.vhd:2424:41  */
  assign n8520_o = n8493_o ? poly_tdw : n8519_o;
  /* ascal.vhd:712:18  */
  assign n8521_o = o_h_poly_mem[479:440];
  /* ascal.vhd:2424:41  */
  assign n8522_o = n8494_o ? poly_tdw : n8521_o;
  /* ascal.vhd:712:18  */
  assign n8523_o = o_h_poly_mem[519:480];
  /* ascal.vhd:2424:41  */
  assign n8524_o = n8495_o ? poly_tdw : n8523_o;
  assign n8525_o = o_h_poly_mem[559:520];
  /* ascal.vhd:2424:41  */
  assign n8526_o = n8496_o ? poly_tdw : n8525_o;
  /* ascal.vhd:712:18  */
  assign n8527_o = o_h_poly_mem[599:560];
  /* ascal.vhd:2424:41  */
  assign n8528_o = n8497_o ? poly_tdw : n8527_o;
  /* ascal.vhd:712:18  */
  assign n8529_o = o_h_poly_mem[639:600];
  /* ascal.vhd:2424:41  */
  assign n8530_o = n8498_o ? poly_tdw : n8529_o;
  assign n8531_o = {n8530_o, n8528_o, n8526_o, n8524_o, n8522_o, n8520_o, n8518_o, n8516_o, n8514_o, n8512_o, n8510_o, n8508_o, n8506_o, n8504_o, n8502_o, n8500_o};
  /* ascal.vhd:2427:41  */
  assign n8532_o = n5416_o[3];
  /* ascal.vhd:2427:41  */
  assign n8533_o = ~n8532_o;
  /* ascal.vhd:2427:41  */
  assign n8534_o = n5416_o[2];
  /* ascal.vhd:2427:41  */
  assign n8535_o = ~n8534_o;
  /* ascal.vhd:2427:41  */
  assign n8536_o = n8533_o & n8535_o;
  /* ascal.vhd:2427:41  */
  assign n8537_o = n8533_o & n8534_o;
  /* ascal.vhd:2427:41  */
  assign n8538_o = n8532_o & n8535_o;
  /* ascal.vhd:2427:41  */
  assign n8539_o = n8532_o & n8534_o;
  /* ascal.vhd:2427:41  */
  assign n8540_o = n5416_o[1];
  /* ascal.vhd:2427:41  */
  assign n8541_o = ~n8540_o;
  /* ascal.vhd:2427:41  */
  assign n8542_o = n8536_o & n8541_o;
  /* ascal.vhd:2427:41  */
  assign n8543_o = n8536_o & n8540_o;
  /* ascal.vhd:2427:41  */
  assign n8544_o = n8537_o & n8541_o;
  /* ascal.vhd:2427:41  */
  assign n8545_o = n8537_o & n8540_o;
  /* ascal.vhd:2427:41  */
  assign n8546_o = n8538_o & n8541_o;
  /* ascal.vhd:2427:41  */
  assign n8547_o = n8538_o & n8540_o;
  /* ascal.vhd:2427:41  */
  assign n8548_o = n8539_o & n8541_o;
  /* ascal.vhd:2427:41  */
  assign n8549_o = n8539_o & n8540_o;
  /* ascal.vhd:2427:41  */
  assign n8550_o = n5416_o[0];
  /* ascal.vhd:2427:41  */
  assign n8551_o = ~n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8552_o = n8542_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8553_o = n8542_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8554_o = n8543_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8555_o = n8543_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8556_o = n8544_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8557_o = n8544_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8558_o = n8545_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8559_o = n8545_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8560_o = n8546_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8561_o = n8546_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8562_o = n8547_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8563_o = n8547_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8564_o = n8548_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8565_o = n8548_o & n8550_o;
  /* ascal.vhd:2427:41  */
  assign n8566_o = n8549_o & n8551_o;
  /* ascal.vhd:2427:41  */
  assign n8567_o = n8549_o & n8550_o;
  /* ascal.vhd:937:26  */
  assign n8568_o = o_v_poly_mem[39:0];
  /* ascal.vhd:2427:41  */
  assign n8569_o = n8552_o ? poly_tdw : n8568_o;
  /* ascal.vhd:934:18  */
  assign n8570_o = o_v_poly_mem[79:40];
  /* ascal.vhd:2427:41  */
  assign n8571_o = n8553_o ? poly_tdw : n8570_o;
  assign n8572_o = o_v_poly_mem[119:80];
  /* ascal.vhd:2427:41  */
  assign n8573_o = n8554_o ? poly_tdw : n8572_o;
  assign n8574_o = o_v_poly_mem[159:120];
  /* ascal.vhd:2427:41  */
  assign n8575_o = n8555_o ? poly_tdw : n8574_o;
  assign n8576_o = o_v_poly_mem[199:160];
  /* ascal.vhd:2427:41  */
  assign n8577_o = n8556_o ? poly_tdw : n8576_o;
  assign n8578_o = o_v_poly_mem[239:200];
  /* ascal.vhd:2427:41  */
  assign n8579_o = n8557_o ? poly_tdw : n8578_o;
  assign n8580_o = o_v_poly_mem[279:240];
  /* ascal.vhd:2427:41  */
  assign n8581_o = n8558_o ? poly_tdw : n8580_o;
  assign n8582_o = o_v_poly_mem[319:280];
  /* ascal.vhd:2427:41  */
  assign n8583_o = n8559_o ? poly_tdw : n8582_o;
  assign n8584_o = o_v_poly_mem[359:320];
  /* ascal.vhd:2427:41  */
  assign n8585_o = n8560_o ? poly_tdw : n8584_o;
  /* ascal.vhd:913:18  */
  assign n8586_o = o_v_poly_mem[399:360];
  /* ascal.vhd:2427:41  */
  assign n8587_o = n8561_o ? poly_tdw : n8586_o;
  /* ascal.vhd:913:18  */
  assign n8588_o = o_v_poly_mem[439:400];
  /* ascal.vhd:2427:41  */
  assign n8589_o = n8562_o ? poly_tdw : n8588_o;
  assign n8590_o = o_v_poly_mem[479:440];
  /* ascal.vhd:2427:41  */
  assign n8591_o = n8563_o ? poly_tdw : n8590_o;
  assign n8592_o = o_v_poly_mem[519:480];
  /* ascal.vhd:2427:41  */
  assign n8593_o = n8564_o ? poly_tdw : n8592_o;
  assign n8594_o = o_v_poly_mem[559:520];
  /* ascal.vhd:2427:41  */
  assign n8595_o = n8565_o ? poly_tdw : n8594_o;
  assign n8596_o = o_v_poly_mem[599:560];
  /* ascal.vhd:2427:41  */
  assign n8597_o = n8566_o ? poly_tdw : n8596_o;
  assign n8598_o = o_v_poly_mem[639:600];
  /* ascal.vhd:2427:41  */
  assign n8599_o = n8567_o ? poly_tdw : n8598_o;
  assign n8600_o = {n8599_o, n8597_o, n8595_o, n8593_o, n8591_o, n8589_o, n8587_o, n8585_o, n8583_o, n8581_o, n8579_o, n8577_o, n8575_o, n8573_o, n8571_o, n8569_o};
  /* ascal.vhd:2430:41  */
  assign n8601_o = n5423_o[3];
  /* ascal.vhd:2430:41  */
  assign n8602_o = ~n8601_o;
  /* ascal.vhd:2430:41  */
  assign n8603_o = n5423_o[2];
  /* ascal.vhd:2430:41  */
  assign n8604_o = ~n8603_o;
  /* ascal.vhd:2430:41  */
  assign n8605_o = n8602_o & n8604_o;
  /* ascal.vhd:2430:41  */
  assign n8606_o = n8602_o & n8603_o;
  /* ascal.vhd:2430:41  */
  assign n8607_o = n8601_o & n8604_o;
  /* ascal.vhd:2430:41  */
  assign n8608_o = n8601_o & n8603_o;
  /* ascal.vhd:2430:41  */
  assign n8609_o = n5423_o[1];
  /* ascal.vhd:2430:41  */
  assign n8610_o = ~n8609_o;
  /* ascal.vhd:2430:41  */
  assign n8611_o = n8605_o & n8610_o;
  /* ascal.vhd:2430:41  */
  assign n8612_o = n8605_o & n8609_o;
  /* ascal.vhd:2430:41  */
  assign n8613_o = n8606_o & n8610_o;
  /* ascal.vhd:2430:41  */
  assign n8614_o = n8606_o & n8609_o;
  /* ascal.vhd:2430:41  */
  assign n8615_o = n8607_o & n8610_o;
  /* ascal.vhd:2430:41  */
  assign n8616_o = n8607_o & n8609_o;
  /* ascal.vhd:2430:41  */
  assign n8617_o = n8608_o & n8610_o;
  /* ascal.vhd:2430:41  */
  assign n8618_o = n8608_o & n8609_o;
  /* ascal.vhd:2430:41  */
  assign n8619_o = n5423_o[0];
  /* ascal.vhd:2430:41  */
  assign n8620_o = ~n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8621_o = n8611_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8622_o = n8611_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8623_o = n8612_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8624_o = n8612_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8625_o = n8613_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8626_o = n8613_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8627_o = n8614_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8628_o = n8614_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8629_o = n8615_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8630_o = n8615_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8631_o = n8616_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8632_o = n8616_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8633_o = n8617_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8634_o = n8617_o & n8619_o;
  /* ascal.vhd:2430:41  */
  assign n8635_o = n8618_o & n8620_o;
  /* ascal.vhd:2430:41  */
  assign n8636_o = n8618_o & n8619_o;
  /* ascal.vhd:873:18  */
  assign n8637_o = o_a_poly_mem[39:0];
  /* ascal.vhd:2430:41  */
  assign n8638_o = n8621_o ? poly_tdw : n8637_o;
  /* ascal.vhd:873:18  */
  assign n8639_o = o_a_poly_mem[79:40];
  /* ascal.vhd:2430:41  */
  assign n8640_o = n8622_o ? poly_tdw : n8639_o;
  /* ascal.vhd:860:26  */
  assign n8641_o = o_a_poly_mem[119:80];
  /* ascal.vhd:2430:41  */
  assign n8642_o = n8623_o ? poly_tdw : n8641_o;
  /* ascal.vhd:858:18  */
  assign n8643_o = o_a_poly_mem[159:120];
  /* ascal.vhd:2430:41  */
  assign n8644_o = n8624_o ? poly_tdw : n8643_o;
  assign n8645_o = o_a_poly_mem[199:160];
  /* ascal.vhd:2430:41  */
  assign n8646_o = n8625_o ? poly_tdw : n8645_o;
  assign n8647_o = o_a_poly_mem[239:200];
  /* ascal.vhd:2430:41  */
  assign n8648_o = n8626_o ? poly_tdw : n8647_o;
  assign n8649_o = o_a_poly_mem[279:240];
  /* ascal.vhd:2430:41  */
  assign n8650_o = n8627_o ? poly_tdw : n8649_o;
  /* ascal.vhd:858:18  */
  assign n8651_o = o_a_poly_mem[319:280];
  /* ascal.vhd:2430:41  */
  assign n8652_o = n8628_o ? poly_tdw : n8651_o;
  /* ascal.vhd:858:18  */
  assign n8653_o = o_a_poly_mem[359:320];
  /* ascal.vhd:2430:41  */
  assign n8654_o = n8629_o ? poly_tdw : n8653_o;
  /* ascal.vhd:860:26  */
  assign n8655_o = o_a_poly_mem[399:360];
  /* ascal.vhd:2430:41  */
  assign n8656_o = n8630_o ? poly_tdw : n8655_o;
  /* ascal.vhd:858:18  */
  assign n8657_o = o_a_poly_mem[439:400];
  /* ascal.vhd:2430:41  */
  assign n8658_o = n8631_o ? poly_tdw : n8657_o;
  assign n8659_o = o_a_poly_mem[479:440];
  /* ascal.vhd:2430:41  */
  assign n8660_o = n8632_o ? poly_tdw : n8659_o;
  /* ascal.vhd:873:18  */
  assign n8661_o = o_a_poly_mem[519:480];
  /* ascal.vhd:2430:41  */
  assign n8662_o = n8633_o ? poly_tdw : n8661_o;
  assign n8663_o = o_a_poly_mem[559:520];
  /* ascal.vhd:2430:41  */
  assign n8664_o = n8634_o ? poly_tdw : n8663_o;
  /* ascal.vhd:712:18  */
  assign n8665_o = o_a_poly_mem[599:560];
  /* ascal.vhd:2430:41  */
  assign n8666_o = n8635_o ? poly_tdw : n8665_o;
  assign n8667_o = o_a_poly_mem[639:600];
  /* ascal.vhd:2430:41  */
  assign n8668_o = n8636_o ? poly_tdw : n8667_o;
  /* ascal.vhd:712:18  */
  assign n8669_o = {n8668_o, n8666_o, n8664_o, n8662_o, n8660_o, n8658_o, n8656_o, n8654_o, n8652_o, n8650_o, n8648_o, n8646_o, n8644_o, n8642_o, n8640_o, n8638_o};
  /* ascal.vhd:2433:41  */
  assign n8670_o = n5430_o[3];
  /* ascal.vhd:2433:41  */
  assign n8671_o = ~n8670_o;
  /* ascal.vhd:2433:41  */
  assign n8672_o = n5430_o[2];
  /* ascal.vhd:2433:41  */
  assign n8673_o = ~n8672_o;
  /* ascal.vhd:2433:41  */
  assign n8674_o = n8671_o & n8673_o;
  /* ascal.vhd:2433:41  */
  assign n8675_o = n8671_o & n8672_o;
  /* ascal.vhd:2433:41  */
  assign n8676_o = n8670_o & n8673_o;
  /* ascal.vhd:2433:41  */
  assign n8677_o = n8670_o & n8672_o;
  /* ascal.vhd:2433:41  */
  assign n8678_o = n5430_o[1];
  /* ascal.vhd:2433:41  */
  assign n8679_o = ~n8678_o;
  /* ascal.vhd:2433:41  */
  assign n8680_o = n8674_o & n8679_o;
  /* ascal.vhd:2433:41  */
  assign n8681_o = n8674_o & n8678_o;
  /* ascal.vhd:2433:41  */
  assign n8682_o = n8675_o & n8679_o;
  /* ascal.vhd:2433:41  */
  assign n8683_o = n8675_o & n8678_o;
  /* ascal.vhd:2433:41  */
  assign n8684_o = n8676_o & n8679_o;
  /* ascal.vhd:2433:41  */
  assign n8685_o = n8676_o & n8678_o;
  /* ascal.vhd:2433:41  */
  assign n8686_o = n8677_o & n8679_o;
  /* ascal.vhd:2433:41  */
  assign n8687_o = n8677_o & n8678_o;
  /* ascal.vhd:2433:41  */
  assign n8688_o = n5430_o[0];
  /* ascal.vhd:2433:41  */
  assign n8689_o = ~n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8690_o = n8680_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8691_o = n8680_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8692_o = n8681_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8693_o = n8681_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8694_o = n8682_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8695_o = n8682_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8696_o = n8683_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8697_o = n8683_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8698_o = n8684_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8699_o = n8684_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8700_o = n8685_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8701_o = n8685_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8702_o = n8686_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8703_o = n8686_o & n8688_o;
  /* ascal.vhd:2433:41  */
  assign n8704_o = n8687_o & n8689_o;
  /* ascal.vhd:2433:41  */
  assign n8705_o = n8687_o & n8688_o;
  /* ascal.vhd:739:18  */
  assign n8706_o = o_a_poly_mem[39:0];
  /* ascal.vhd:2433:41  */
  assign n8707_o = n8690_o ? poly_tdw : n8706_o;
  /* ascal.vhd:739:18  */
  assign n8708_o = o_a_poly_mem[79:40];
  /* ascal.vhd:2433:41  */
  assign n8709_o = n8691_o ? poly_tdw : n8708_o;
  assign n8710_o = o_a_poly_mem[119:80];
  /* ascal.vhd:2433:41  */
  assign n8711_o = n8692_o ? poly_tdw : n8710_o;
  assign n8712_o = o_a_poly_mem[159:120];
  /* ascal.vhd:2433:41  */
  assign n8713_o = n8693_o ? poly_tdw : n8712_o;
  assign n8714_o = o_a_poly_mem[199:160];
  /* ascal.vhd:2433:41  */
  assign n8715_o = n8694_o ? poly_tdw : n8714_o;
  assign n8716_o = o_a_poly_mem[239:200];
  /* ascal.vhd:2433:41  */
  assign n8717_o = n8695_o ? poly_tdw : n8716_o;
  assign n8718_o = o_a_poly_mem[279:240];
  /* ascal.vhd:2433:41  */
  assign n8719_o = n8696_o ? poly_tdw : n8718_o;
  /* ascal.vhd:801:18  */
  assign n8720_o = o_a_poly_mem[319:280];
  /* ascal.vhd:2433:41  */
  assign n8721_o = n8697_o ? poly_tdw : n8720_o;
  /* ascal.vhd:801:18  */
  assign n8722_o = o_a_poly_mem[359:320];
  /* ascal.vhd:2433:41  */
  assign n8723_o = n8698_o ? poly_tdw : n8722_o;
  /* ascal.vhd:2732:73  */
  assign n8724_o = o_a_poly_mem[399:360];
  /* ascal.vhd:2433:41  */
  assign n8725_o = n8699_o ? poly_tdw : n8724_o;
  /* ascal.vhd:2725:26  */
  assign n8726_o = o_a_poly_mem[439:400];
  /* ascal.vhd:2433:41  */
  assign n8727_o = n8700_o ? poly_tdw : n8726_o;
  /* ascal.vhd:2724:32  */
  assign n8728_o = o_a_poly_mem[479:440];
  /* ascal.vhd:2433:41  */
  assign n8729_o = n8701_o ? poly_tdw : n8728_o;
  /* ascal.vhd:2724:26  */
  assign n8730_o = o_a_poly_mem[519:480];
  /* ascal.vhd:2433:41  */
  assign n8731_o = n8702_o ? poly_tdw : n8730_o;
  /* ascal.vhd:2723:26  */
  assign n8732_o = o_a_poly_mem[559:520];
  /* ascal.vhd:2433:41  */
  assign n8733_o = n8703_o ? poly_tdw : n8732_o;
  /* ascal.vhd:2722:26  */
  assign n8734_o = o_a_poly_mem[599:560];
  /* ascal.vhd:2433:41  */
  assign n8735_o = n8704_o ? poly_tdw : n8734_o;
  assign n8736_o = o_a_poly_mem[639:600];
  /* ascal.vhd:2433:41  */
  assign n8737_o = n8705_o ? poly_tdw : n8736_o;
  /* ascal.vhd:2646:17  */
  assign n8738_o = {n8737_o, n8735_o, n8733_o, n8731_o, n8729_o, n8727_o, n8725_o, n8723_o, n8721_o, n8719_o, n8717_o, n8715_o, n8713_o, n8711_o, n8709_o, n8707_o};
endmodule

