# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///

"""Bump the version of the Typst package in various files."""  # noqa: INP001

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
    SUCCESS = 0
    ERROR = 1


def update_file(old: str, new: str, file: Path) -> None:
    """Replace 'old' with a 'new' string in the file."""
    content: str = file.read_text()
    updated_content: str = content.replace(old, new)
    file.write_text(data=updated_content)
    log.info("%s -> %s: %s", old, new, file.relative_to(Path.cwd()))


def main() -> int:
    """Handle command line arguments and update versions."""
    max_args = 3
    if len(sys.argv) != max_args:
        log.error("Usage: ./bump.py <old_version> <new_version>")
        return ExitCode.ERROR
    root: Path = Path.cwd()
    old_version: str = sys.argv[1]
    new_version: str = sys.argv[2]
    for file in FILES_TO_UPDATE:
        update_file(old=old_version, new=new_version, file=root / file)
    return ExitCode.SUCCESS


if __name__ == "__main__":
    sys.exit(main())
