#!/usr/bin/env python3

#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

import argparse
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from gateware.mister_manifest import list_core_names


def main():
    parser = argparse.ArgumentParser(description="Run no-compile LiteX elaboration smoke checks.")
    parser.add_argument("cores", nargs="*", help="Core names. Defaults to all manifests.")
    parser.add_argument("--output-root", default="/tmp/litex_mister_smoke", help="Smoke output directory root.")
    args = parser.parse_args()

    cores = args.cores or list_core_names()
    for core in cores:
        output_dir = Path(args.output_root) / core
        cmd = [
            sys.executable,
            str(REPO_ROOT / "sim.py"),
            "--core", core,
            "--cpu-type=None",
            "--no-compile",
            "--output-dir", str(output_dir),
        ]
        print(" ".join(cmd))
        subprocess.run(cmd, cwd=REPO_ROOT, check=True)


if __name__ == "__main__":
    main()
