#!/usr/bin/env python3

#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

import argparse
import csv
import mmap
import os
import struct
import time
from pathlib import Path


DEFAULT_SCRATCH = 0xff201000
DEFAULT_STATUS  = 0xff201004


def int_arg(value):
    return int(value, 0)


def load_csr_registers(filename):
    registers = {}
    with Path(filename).open("r", encoding="utf-8") as f:
        for row in csv.reader(line for line in f if not line.startswith("#")):
            if len(row) < 3 or row[0] != "csr_register":
                continue
            registers[row[1]] = int(row[2], 0)
    return registers


class DevMem:
    def __init__(self, device, address, span, writable=True):
        self.device  = device
        self.address = address
        self.span    = span
        self.page    = mmap.PAGESIZE
        self.base    = address & ~(self.page - 1)
        self.offset  = address - self.base
        prot = mmap.PROT_READ | (mmap.PROT_WRITE if writable else 0)
        self.fd = os.open(device, os.O_RDWR if writable else os.O_RDONLY)
        self.mem = mmap.mmap(self.fd, self.offset + span, mmap.MAP_SHARED, prot, offset=self.base)

    def close(self):
        self.mem.close()
        os.close(self.fd)

    def read32(self, address):
        offset = self.offset + (address - self.address)
        return struct.unpack_from("<I", self.mem, offset)[0]

    def write32(self, address, value):
        offset = self.offset + (address - self.address)
        struct.pack_into("<I", self.mem, offset, value & 0xffffffff)


def resolve_addresses(args):
    registers = load_csr_registers(args.csr_csv) if args.csr_csv else {}
    scratch = args.scratch_addr
    status  = args.status_addr
    if registers:
        scratch = registers.get(args.scratch_name, scratch)
        status  = registers.get(args.status_name, status)
    return registers, scratch, status


def main():
    parser = argparse.ArgumentParser(description="Probe LiteX Cyclone V HPS CSRs from Linux through /dev/mem.")
    parser.add_argument("--csr-csv", type=Path, help="LiteX CSR CSV generated with --soc-csv.")
    parser.add_argument("--scratch-name", default="main_hps_scratch", help="CSR register name to write/read.")
    parser.add_argument("--status-name",  default="main_hps_status",  help="CSR register name expected to mirror scratch.")
    parser.add_argument("--scratch-addr", default=DEFAULT_SCRATCH, type=int_arg, help="Scratch CSR byte address fallback.")
    parser.add_argument("--status-addr",  default=DEFAULT_STATUS,  type=int_arg, help="Status CSR byte address fallback.")
    parser.add_argument("--value", default=None, type=int_arg, help="32-bit value to write. Defaults to a timestamp pattern.")
    parser.add_argument("--device", default="/dev/mem", help="Memory device.")
    parser.add_argument("--read-only", action="store_true", help="Only read registers; do not write scratch.")
    parser.add_argument("--dry-run", action="store_true", help="Print the resolved addresses without touching /dev/mem.")
    parser.add_argument("--list", action="store_true", help="List CSR registers from --csr-csv and exit.")
    parser.add_argument("--poll", default=0.0, type=float, help="Poll scratch/status for this many seconds after the write.")
    parser.add_argument("--interval", default=0.25, type=float, help="Poll interval in seconds.")
    args = parser.parse_args()

    registers, scratch, status = resolve_addresses(args)

    if args.list:
        for name, address in sorted(registers.items(), key=lambda item: item[1]):
            print(f"0x{address:08x} {name}")
        return

    print(f"scratch: 0x{scratch:08x} ({args.scratch_name})")
    print(f"status:  0x{status:08x} ({args.status_name})")
    if args.dry_run:
        return

    start = min(scratch, status)
    end   = max(scratch, status) + 4
    mem = DevMem(args.device, start, end - start, writable=not args.read_only)
    try:
        scratch_before = mem.read32(scratch)
        status_before  = mem.read32(status)
        print(f"before: scratch=0x{scratch_before:08x} status=0x{status_before:08x}")

        if not args.read_only:
            value = args.value
            if value is None:
                value = 0x5ca60000 | (int(time.time()) & 0xffff)
            mem.write32(scratch, value)
            scratch_after = mem.read32(scratch)
            status_after  = mem.read32(status)
            print(f"write:  scratch=0x{value & 0xffffffff:08x}")
            print(f"after:  scratch=0x{scratch_after:08x} status=0x{status_after:08x}")
            if status_after != scratch_after:
                print("WARN: status does not mirror scratch; check CSR map, bridge enablement, or target wiring.")

        if args.poll > 0:
            deadline = time.monotonic() + args.poll
            while time.monotonic() < deadline:
                print(f"poll:   scratch=0x{mem.read32(scratch):08x} status=0x{mem.read32(status):08x}")
                time.sleep(args.interval)
    finally:
        mem.close()


if __name__ == "__main__":
    main()
