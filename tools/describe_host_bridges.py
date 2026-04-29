#!/usr/bin/env python3

import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from gateware.host_bridge import iter_host_bridge_profiles


def main():
    for profile in iter_host_bridge_profiles():
        print(f"{profile.name} ({profile.family})")
        print(f"  control:   {profile.control_plane}")
        print(f"  bulk:      {profile.bulk_plane}")
        print(f"  irq:       {profile.interrupts}")
        print(f"  clk/rst:   {profile.clock_reset}")
        print(f"  upstream:  {profile.upstream_status}")
        print(f"  milestone: {profile.first_milestone}")
        print()


if __name__ == "__main__":
    main()
