#
# This file is part of LiteX-MiSTeR-Test
#
# Copyright (c) 2026 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from pathlib import Path

from litex.build.altera  import AlteraPlatform
from litex.build.sim     import SimPlatform
from litex.build.xilinx  import XilinxPlatform
from litex.build.lattice import LatticePlatform

try:
    import yaml
except ImportError as e:
    yaml = None
    _yaml_import_error = e


REPO_ROOT = Path(__file__).resolve().parents[1]
CORES_DIR = REPO_ROOT / "cores"


class CoreManifest:
    def __init__(self, path, data):
        self.path               = Path(path)
        self.data               = data
        self.name               = data.get("name", self.path.stem)
        self.display_name       = data.get("display_name", self.name)
        self.description        = data.get("description", "")
        self.top                = data.get("top", "emu")
        self.source_root        = Path(data["source_root"])
        self.hps_bus_width      = int(data.get("hps_bus_width", 49))
        self.video_aspect_width = int(data.get("video_aspect_width", 13))
        self.interfaces         = data.get("interfaces", {})
        self.status_controls    = data.get("status_controls", [])
        self.porting            = data.get("porting", {})

    @property
    def source_root_path(self):
        root = self.source_root
        if not root.is_absolute():
            manifest_relative = self.path.parent / root
            repo_relative     = REPO_ROOT / root
            root = manifest_relative if manifest_relative.exists() else repo_relative
        return root

    def resolve_source(self, source):
        source = Path(source)
        if source.is_absolute():
            return source
        return self.source_root_path / source

    def source_dir_entries(self, platform):
        yield from _source_entries(self.data.get("source_dirs", []))
        platform_dirs = self.data.get("platform_source_dirs", {})
        yield from _source_entries(platform_dirs.get(platform_family(platform), []))

    def copy_source_entries(self):
        yield from _source_entries(self.data.get("copy_sources", []), recursive_default=False)

    def validate(self):
        _require_path(self.source_root_path, "source_root")
        for include_dir in self.data.get("include_dirs", []):
            _require_path(self.resolve_source(include_dir), "include_dir")
        for entry in self.source_dir_entries(platform=None):
            _require_path(self.resolve_source(entry["path"]), "source_dir")
        for platform_name in self.data.get("platform_source_dirs", {}):
            for entry in _source_entries(self.data["platform_source_dirs"][platform_name]):
                _require_path(self.resolve_source(entry["path"]), "platform_source_dir")
        for entry in self.copy_source_entries():
            _require_path(self.resolve_source(entry["path"]), "copy_source")
        _validate_status_controls(self.status_controls)


def list_core_names():
    if not CORES_DIR.exists():
        return []
    return sorted(path.stem for path in CORES_DIR.glob("*.yaml"))


def load_core_manifest(core):
    path = Path(core)
    if path.suffix not in (".yaml", ".yml"):
        path = CORES_DIR / f"{core}.yaml"
    if not path.is_absolute():
        path = Path.cwd() / path

    if yaml is None:
        raise ImportError("PyYAML is required to load MiSTer core manifests.") from _yaml_import_error
    if not path.exists():
        available = ", ".join(list_core_names()) or "<none>"
        raise FileNotFoundError(f"Unknown MiSTer core manifest '{core}'. Available cores: {available}")

    with path.open("r", encoding="utf-8") as f:
        data = yaml.safe_load(f) or {}

    manifest = CoreManifest(path=path, data=data)
    manifest.validate()
    return manifest


def platform_family(platform):
    if isinstance(platform, SimPlatform) or platform is None:
        return "sim"
    if isinstance(platform, AlteraPlatform):
        return "altera"
    if isinstance(platform, XilinxPlatform):
        return "xilinx"
    if isinstance(platform, LatticePlatform):
        return "lattice"
    return "generic"


def add_manifest_sources(platform, manifest):
    for include_dir in manifest.data.get("include_dirs", []):
        platform.add_verilog_include_path(str(manifest.resolve_source(include_dir)))

    for entry in manifest.source_dir_entries(platform):
        platform.add_source_dir(
            str(manifest.resolve_source(entry["path"])),
            recursive=entry["recursive"],
        )

    for entry in manifest.copy_source_entries():
        platform.add_source(str(manifest.resolve_source(entry["path"])), copy=True)


def _source_entries(entries, recursive_default=True):
    for entry in entries or []:
        if isinstance(entry, str):
            yield {"path": entry, "recursive": recursive_default}
        else:
            yield {
                "path": entry["path"],
                "recursive": bool(entry.get("recursive", recursive_default)),
            }


def _require_path(path, field):
    if not Path(path).exists():
        raise FileNotFoundError(f"MiSTer core manifest {field} path does not exist: {path}")


def _validate_status_controls(status_controls):
    used_bits = set()
    for control in status_controls:
        name  = control["name"]
        bit   = int(control["bit"])
        width = int(control.get("width", 1))
        if bit < 0 or width <= 0 or bit + width > 128:
            raise ValueError(f"Invalid status control '{name}': bit={bit}, width={width}")
        for status_bit in range(bit, bit + width):
            if status_bit in used_bits:
                raise ValueError(f"Status bit {status_bit} is assigned more than once.")
            used_bits.add(status_bit)
