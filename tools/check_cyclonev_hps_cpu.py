#!/usr/bin/env python3

import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from litex.soc.cores.cpu import CPUS


def main():
    cpu_cls = CPUS.get("cyclonev_hps")
    if cpu_cls is None:
        available = ", ".join(sorted(str(name) for name in CPUS))
        raise SystemExit(f"cyclonev_hps CPU was not discovered. Available CPUs: {available}")

    cpu = cpu_cls(None, "standard")

    print(f"cyclonev_hps: {cpu_cls.human_name}")
    print(f"  category={cpu_cls.category} family={cpu_cls.family} data_width={cpu_cls.data_width}")
    print(f"  csr=0x{cpu.mem_map['csr']:08x}")


if __name__ == "__main__":
    main()
