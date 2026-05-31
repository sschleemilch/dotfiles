#!/usr/bin/env python3
from pathlib import Path
import configparser
import json
import sys
from dataclasses import dataclass

HOME = Path.home()

DIRS: list[Path] = [
    Path("/usr/share/applications"),
    Path("/usr/local/share/applications"),
    HOME / ".local/share/applications",
]

CACHE = HOME / ".cache/sschleemilch/apps.json"


@dataclass
class App:
    name: str
    exec: str


def _dirs_mtime(search_dirs: list[Path]) -> float:
    mtimes = [d.stat().st_mtime for d in search_dirs if d.exists()]
    return max(mtimes) if mtimes else 0.0


def _load_cache(search_dirs: list[Path]) -> str | None:
    if not CACHE.exists():
        return None

    data = json.loads(CACHE.read_text())
    if data.get("mtime") == _dirs_mtime(search_dirs):
        return data["output"]

    return None


def _save_cache(search_dirs: list[Path], output: str) -> None:
    CACHE.parent.mkdir(exist_ok=True, parents=True)
    CACHE.write_text(json.dumps({"mtime": _dirs_mtime(search_dirs), "output": output}))


def fetch(search_dirs: list[Path] = DIRS) -> None:
    cached = _load_cache(search_dirs)
    if cached is not None:
        sys.stdout.write(cached)
        return

    apps: list[App] = []
    ini = configparser.ConfigParser(interpolation=None)

    for d in search_dirs:
        if not d.exists():
            continue

        for file in d.glob("**/*.desktop"):
            ini.clear()
            ini.read(file)

            if "Desktop Entry" not in ini.sections():
                continue

            entry = ini["Desktop Entry"]

            if entry.get("type", "").lower() != "application":
                continue

            if entry.get("nodisplay", "").lower() == "true":
                continue

            if "exec" not in entry:
                continue

            exec_raw = entry["exec"]
            exec_cmd = " ".join(
                x for x in exec_raw.split() if "@" not in x and "%" not in x
            )

            apps.append(App(name=entry["name"], exec=exec_cmd))

    output = "".join(f"{app.name}\t{app.exec}\n" for app in apps)
    _save_cache(search_dirs, output)
    sys.stdout.write(output)


if __name__ == "__main__":
    fetch()
