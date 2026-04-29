#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

import re

from pathlib import Path


_VERILOG_IDENTIFIER = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")


def write_hps_stub(filename, module_name="cyclonev_hps_litex", h2f_lw_prefix="h2f_lw", scratch_addr=0xff201000):
    """Write a Quartus synthesis stub for CI/smoke builds without Platform Designer IP."""
    _check_identifier(module_name)
    _check_identifier(h2f_lw_prefix)
    scratch_addr = int(scratch_addr, 0) if isinstance(scratch_addr, str) else int(scratch_addr)
    if not 0 <= scratch_addr <= 0xffffffff:
        raise ValueError(f"Scratch address outside 32-bit AXI address range: {scratch_addr:#x}")

    filename = Path(filename)
    filename.parent.mkdir(parents=True, exist_ok=True)
    filename.write_text(_stub_verilog(module_name, h2f_lw_prefix, scratch_addr), encoding="utf-8")
    return filename


def _check_identifier(identifier):
    if not isinstance(identifier, str) or not _VERILOG_IDENTIFIER.match(identifier):
        raise ValueError(f"Invalid Verilog identifier: {identifier}")


def _stub_verilog(module_name, p, scratch_addr):
    return f"""\
// Auto-generated Cyclone V HPS synthesis stub for LiteX smoke builds.
// This is not a hardware HPS replacement. Use --hps-ip with a generated
// Platform Designer wrapper for real DE10-Nano HPS/Linux operation.

module {module_name} (
    output wire        h2f_rst_n,
    output wire        h2f_user0_clk,
    input  wire        f2h_cold_rst_req_n,
    input  wire        f2h_warm_rst_req_n,
    input  wire        f2h_dbg_rst_req_n,
    input  wire        f2h_pending_rst_ack,
    input  wire [63:0] f2h_irq,

    input  wire        {p}_aclk,
    input  wire        {p}_areset_n,

    output wire        {p}_awvalid,
    input  wire        {p}_awready,
    output wire [11:0] {p}_awid,
    output wire [31:0] {p}_awaddr,
    output wire [3:0]  {p}_awlen,
    output wire [2:0]  {p}_awsize,
    output wire [1:0]  {p}_awburst,
    output wire [1:0]  {p}_awlock,
    output wire [3:0]  {p}_awcache,
    output wire [2:0]  {p}_awprot,
    output wire [3:0]  {p}_awqos,

    output wire        {p}_wvalid,
    input  wire        {p}_wready,
    output wire [11:0] {p}_wid,
    output wire [31:0] {p}_wdata,
    output wire [3:0]  {p}_wstrb,
    output wire        {p}_wlast,

    input  wire        {p}_bvalid,
    output wire        {p}_bready,
    input  wire [11:0] {p}_bid,
    input  wire [1:0]  {p}_bresp,

    output wire        {p}_arvalid,
    input  wire        {p}_arready,
    output wire [11:0] {p}_arid,
    output wire [31:0] {p}_araddr,
    output wire [3:0]  {p}_arlen,
    output wire [2:0]  {p}_arsize,
    output wire [1:0]  {p}_arburst,
    output wire [1:0]  {p}_arlock,
    output wire [3:0]  {p}_arcache,
    output wire [2:0]  {p}_arprot,
    output wire [3:0]  {p}_arqos,

    input  wire        {p}_rvalid,
    output wire        {p}_rready,
    input  wire [11:0] {p}_rid,
    input  wire [31:0] {p}_rdata,
    input  wire [1:0]  {p}_rresp,
    input  wire        {p}_rlast
);

assign h2f_rst_n      = {p}_areset_n;
assign h2f_user0_clk  = {p}_aclk;

reg        awvalid = 1'b0;
reg        wvalid  = 1'b0;
reg        pending = 1'b0;
reg [23:0] delay   = 24'd0;
reg [31:0] counter = 32'd0;

always @(posedge {p}_aclk or negedge {p}_areset_n) begin
    if (!{p}_areset_n) begin
        awvalid <= 1'b0;
        wvalid  <= 1'b0;
        pending <= 1'b0;
        delay   <= 24'd0;
        counter <= 32'd0;
    end else begin
        if ((delay != 24'd0) && !pending)
            delay <= delay - 1'b1;

        if (!pending && !awvalid && !wvalid && (delay == 24'd0)) begin
            awvalid <= 1'b1;
            wvalid  <= 1'b1;
            pending <= 1'b1;
        end

        if (awvalid && {p}_awready)
            awvalid <= 1'b0;

        if (wvalid && {p}_wready)
            wvalid <= 1'b0;

        if (pending && {p}_bvalid) begin
            counter <= counter + 1'b1;
            pending <= 1'b0;
            delay   <= 24'h100000;
        end
    end
end

assign {p}_awvalid = awvalid;
assign {p}_awid    = 12'd0;
assign {p}_awaddr  = 32'h{scratch_addr:08x};
assign {p}_awlen   = 4'd0;
assign {p}_awsize  = 3'd2;
assign {p}_awburst = 2'd1;
assign {p}_awlock  = 2'd0;
assign {p}_awcache = 4'd0;
assign {p}_awprot  = 3'd0;
assign {p}_awqos   = 4'd0;

assign {p}_wvalid = wvalid;
assign {p}_wid    = 12'd0;
assign {p}_wdata  = counter;
assign {p}_wstrb  = 4'hf;
assign {p}_wlast  = 1'b1;

assign {p}_bready = 1'b1;

assign {p}_arvalid = 1'b0;
assign {p}_arid    = 12'd0;
assign {p}_araddr  = 32'd0;
assign {p}_arlen   = 4'd0;
assign {p}_arsize  = 3'd0;
assign {p}_arburst = 2'd0;
assign {p}_arlock  = 2'd0;
assign {p}_arcache = 4'd0;
assign {p}_arprot  = 3'd0;
assign {p}_arqos   = 4'd0;

assign {p}_rready = 1'b1;

endmodule
"""
