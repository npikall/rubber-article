"""Bump the version of the Typst package in various files."""  # noqa: INP001

import logging
import re
import sys
from pathlib import Path

FILES_TO_UPDATE = ["typst.toml", "README.md", "template/main.typ", "docs/docs.typ"]
logger = logging.getLogger(__name__)
logger.basicConfig(level=logging.INFO, format="%(message)s")


def update_version(old: str, new: str, file: Path) -> None:
    """Update the version of the Typst package in the specified file."""
    with file.open("r") as f:
        content = f.read()

    updated_content = re.sub(rf"{re.escape(old)}", new, content)

    with file.open("w") as f:
        f.write(updated_content)

    msg: str = f"  {old} -> {new}: {file}"
    logger.info(msg)


def main() -> None:
    """Handle command line arguments and update versions."""
    max_args = 3
    if len(sys.argv) != max_args:
        logger.error("Usage: python bump.py <old_version> <new_version>")
        sys.exit(1)

    root = Path.cwd()
    old_version = sys.argv[1]
    new_version = sys.argv[2]

    for file in FILES_TO_UPDATE:
        update_version(old_version, new_version, root / file)


if __name__ == "__main__":
    main()
