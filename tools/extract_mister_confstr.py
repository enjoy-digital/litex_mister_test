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

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from gateware.mister_manifest import load_core_manifest


def find_confstr_file(manifest):
    suffixes = {".sv", ".v", ".vh"}
    for path in sorted(manifest.source_root_path.rglob("*")):
        if path.suffix.lower() not in suffixes:
            continue
        text = path.read_text(encoding="utf-8", errors="ignore")
        if "CONF_STR" in text and "localparam" in text:
            return path
    raise FileNotFoundError(f"No localparam CONF_STR found under {manifest.source_root_path}")


def extract_assignment(text, name="CONF_STR"):
    match = re.search(rf"\blocalparam\b[^;=]*\b{name}\b\s*=", text)
    if not match:
        raise ValueError(f"No localparam {name} assignment found.")

    start = match.end()
    depth = 0
    in_string = False
    escaped = False
    saw_content = False
    for index in range(start, len(text)):
        char = text[index]
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == "\"":
                in_string = False
            continue

        if char == "\"":
            in_string = True
            saw_content = True
        elif char == "{":
            depth += 1
            saw_content = True
        elif char == "}":
            depth -= 1
        elif char == ";" and saw_content and depth <= 0:
            return text[start:index]

    raise ValueError(f"Could not find the end of localparam {name}.")


def quoted_fragments(assignment):
    fragments = []
    for match in re.finditer(r'"((?:\\.|[^"\\])*)"', assignment, flags=re.S):
        fragments.append(bytes(match.group(1), "utf-8").decode("unicode_escape"))
    return fragments


def parse_status_fields(confstr):
    seen = set()
    fields = []
    for entry in (part.strip() for part in confstr.split(";")):
        if not entry:
            continue
        first = entry.split(",", 1)[0]
        match = re.search(r"(?P<kind>[OTR])\[(?P<bits>\d+(?::\d+)?)\]", first)
        if not match:
            continue

        bit_text = match.group("bits")
        if ":" in bit_text:
            high, low = [int(value) for value in bit_text.split(":", 1)]
            bit = min(high, low)
            width = abs(high - low) + 1
        else:
            bit = int(bit_text)
            width = 1

        label = entry.split(",", 2)[1] if "," in entry else match.group("kind")
        key = (bit, width)
        if key in seen:
            continue
        seen.add(key)
        fields.append({
            "name": sanitize_name(label),
            "bit": bit,
            "width": width,
            "description": label.strip(),
            "kind": match.group("kind"),
            "raw": entry,
        })
    return sorted(fields, key=lambda field: (field["bit"], field["width"], field["name"]))


def sanitize_name(label):
    name = re.sub(r"[^A-Za-z0-9]+", "_", label.strip().lower()).strip("_")
    if not name:
        name = "control"
    if name[0].isdigit():
        name = f"control_{name}"
    return name


def print_yaml(fields):
    print("status_controls:")
    for field in fields:
        print(f"  - name: {field['name']}")
        print(f"    bit: {field['bit']}")
        print(f"    width: {field['width']}")
        print(f"    description: {field['description']}.")


def print_table(fields):
    print("bit width kind name description")
    for field in fields:
        print(f"{field['bit']:3d} {field['width']:5d} {field['kind']:>4s} {field['name']:<24s} {field['description']}")


def check_manifest(manifest, fields, strict=False):
    suggested = {(field["bit"], field["width"]) for field in fields}
    declared  = {
        (int(control["bit"]), int(control.get("width", 1)))
        for control in manifest.status_controls
    }
    missing = sorted(suggested - declared)
    extra   = sorted(declared - suggested)
    if missing:
        print("Manifest does not declare these CONF_STR-controlled bit ranges:")
        for bit, width in missing:
            print(f"  bit={bit} width={width}")
    if extra:
        print("Manifest declares bit ranges not found in CONF_STR:")
        for bit, width in extra:
            print(f"  bit={bit} width={width}")
    if strict and (missing or extra):
        raise SystemExit(1)


def main():
    parser = argparse.ArgumentParser(description="Extract MiSTer CONF_STR status fields and suggest manifest controls.")
    parser.add_argument("core", help="Core manifest name or path.")
    parser.add_argument("--format", choices=("table", "yaml"), default="table")
    parser.add_argument("--check-manifest", action="store_true", help="Compare extracted bit ranges with manifest status_controls.")
    parser.add_argument("--strict", action="store_true", help="Return failure when --check-manifest finds a mismatch.")
    args = parser.parse_args()

    manifest = load_core_manifest(args.core)
    confstr_file = find_confstr_file(manifest)
    assignment = extract_assignment(confstr_file.read_text(encoding="utf-8", errors="ignore"))
    confstr = "".join(quoted_fragments(assignment))
    fields = parse_status_fields(confstr)

    print(f"# {manifest.name}: {confstr_file.relative_to(REPO_ROOT)}")
    if args.format == "yaml":
        print_yaml(fields)
    else:
        print_table(fields)

    if args.check_manifest:
        check_manifest(manifest, fields, strict=args.strict)


if __name__ == "__main__":
    main()
