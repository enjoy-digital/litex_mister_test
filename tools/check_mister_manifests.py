#!/usr/bin/env python3

#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

import argparse
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from gateware.mister_manifest import list_core_names, load_core_manifest


def main():
    parser = argparse.ArgumentParser(description="Validate LiteX-MiSTer core manifests.")
    parser.add_argument("cores", nargs="*", help="Core names or manifest paths. Defaults to all cores.")
    args = parser.parse_args()

    cores = args.cores or list_core_names()
    if not cores:
        raise SystemExit("No core manifests found.")

    for core in cores:
        manifest = load_core_manifest(core)
        print(f"{manifest.name}: {manifest.display_name}")
        print(f"  top={manifest.top} source_root={manifest.source_root_path}")
        print(f"  hps_bus_width={manifest.hps_bus_width} video_aspect_width={manifest.video_aspect_width}")
        print(f"  status_controls={len(manifest.status_controls)} interfaces={','.join(sorted(manifest.interfaces))}")


if __name__ == "__main__":
    main()
