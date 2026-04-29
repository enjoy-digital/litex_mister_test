#!/usr/bin/env python3

#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

import argparse
import re
import sys
from pathlib import Path


def required_ports(prefix):
    ports = [
        "h2f_rst_n",
        "h2f_user0_clk",
        "f2h_cold_rst_req_n",
        "f2h_warm_rst_req_n",
        "f2h_dbg_rst_req_n",
        "f2h_pending_rst_ack",
        "f2h_irq",
        f"{prefix}_aclk",
        f"{prefix}_areset_n",
    ]
    for channel, names in {
        "aw": ["valid", "ready", "id", "addr", "len", "size", "burst", "lock", "cache", "prot", "qos"],
        "w":  ["valid", "ready", "id", "data", "strb", "last"],
        "b":  ["valid", "ready", "id", "resp"],
        "ar": ["valid", "ready", "id", "addr", "len", "size", "burst", "lock", "cache", "prot", "qos"],
        "r":  ["valid", "ready", "id", "data", "resp", "last"],
    }.items():
        ports += [f"{prefix}_{channel}{name}" for name in names]
    return ports


def strip_comments(text):
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    return re.sub(r"//.*", "", text)


def extract_verilog_candidates(path):
    path = Path(path)
    if path.suffix.lower() not in (".qip", ".sip", ".qsys"):
        return [path]

    text = path.read_text(encoding="utf-8", errors="ignore")
    candidates = []
    for match in re.finditer(r"[\w./$:{}()\\-]+\.(?:sv|v)", text):
        token = match.group(0).strip("{}")
        if "$::quartus(qip_path)" in token:
            token = token.replace("$::quartus(qip_path)", str(path.parent))
        token = token.replace("\\", "/")
        candidate = Path(token)
        if not candidate.is_absolute():
            candidate = path.parent / candidate
        if candidate.exists() and candidate not in candidates:
            candidates.append(candidate)

    return candidates or [path]


def find_module_text(paths, module_name):
    module_re = re.compile(
        rf"\bmodule\s+{re.escape(module_name)}\b(?:\s*#\s*\(.*?\))?\s*\(.*?\)\s*;",
        flags=re.S,
    )
    for path in paths:
        text = strip_comments(path.read_text(encoding="utf-8", errors="ignore"))
        match = module_re.search(text)
        if match:
            return path, text
    return None, ""


def check_wrapper(paths, module_name, h2f_lw_prefix):
    candidate_paths = []
    for path in paths:
        candidate_paths += extract_verilog_candidates(path)

    found_path, text = find_module_text(candidate_paths, module_name)
    if found_path is None:
        searched = "\n  ".join(str(path) for path in candidate_paths)
        raise ValueError(f"Module '{module_name}' was not found. Searched:\n  {searched}")

    missing = []
    for port in required_ports(h2f_lw_prefix):
        if re.search(rf"\b{re.escape(port)}\b", text) is None:
            missing.append(port)

    return found_path, missing


def main():
    parser = argparse.ArgumentParser(description="Validate the Cyclone V HPS wrapper ABI expected by LiteX.")
    parser.add_argument("paths", nargs="+", type=Path, help="Generated HPS wrapper Verilog/SystemVerilog or QIP/SIP/QSYS files.")
    parser.add_argument("--module-name", default="cyclonev_hps_litex", help="Expected generated HPS wrapper module name.")
    parser.add_argument("--hps-lw-prefix", default="h2f_lw", help="Expected lightweight HPS-to-FPGA AXI port prefix.")
    args = parser.parse_args()

    try:
        found_path, missing = check_wrapper(args.paths, args.module_name, args.hps_lw_prefix)
    except Exception as e:
        raise SystemExit(f"ERROR: {e}") from e

    if missing:
        print(f"{found_path}: module {args.module_name} is missing {len(missing)} required port(s):")
        for port in missing:
            print(f"  - {port}")
        return 1

    print(f"{found_path}: module {args.module_name} matches the expected Cyclone V HPS lightweight AXI ABI.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
