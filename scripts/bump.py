# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///

"""Bump the version of the Typst package in various files."""

import logging
import sys
from enum import IntEnum
from pathlib import Path

FILES_TO_UPDATE = ["README.md", "template/main.typ", "docs/docs.typ"]
log = logging.getLogger(__name__)
logging.basicConfig(
    format="{asctime} {levelname} {message}",
    style="{",
    datefmt="%Y/%m/%d %H:%M",
    level=logging.INFO,
)


class ExitCode(IntEnum):
    OK = 0
    ERROR = 1


def update_file(old: str, new: str, file: Path) -> None:
    """Replace 'old' with a 'new' string in the file."""
    content: str = file.read_text()
    updated_content: str = content.replace(old, new)
    file.write_text(data=updated_content)
    log.info("%s -> %s: %s", old, new, file.relative_to(Path.cwd()))


def update_all_files(files: list[str], old: str, new: str, root: Path) -> None:
    for file in files:
        path = root / file
        update_file(old=old, new=new, file=path)


def main() -> int:
    """Handle command line arguments and update versions."""
    max_args = 3
    if len(sys.argv) != max_args:
        log.error("Usage: ./bump.py <old_version> <new_version>")
        return ExitCode.ERROR
    root: Path = Path.cwd()
    update_all_files(files=FILES_TO_UPDATE, old=sys.argv[1], new=sys.argv[2], root=root)
    return ExitCode.OK


if __name__ == "__main__":
    raise SystemExit(main())
