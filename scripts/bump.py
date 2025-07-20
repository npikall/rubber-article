"""Bump the version of the Typst package in various files."""  # noqa: INP001

import re
import sys
from pathlib import Path

FILES_TO_UPDATE = ["typst.toml", "README.md", "template/main.typ", "docs/docs.typ"]


def update_version(old: str, new: str, file: Path) -> None:
    with file.open("r") as f:
        content = f.read()

    updated_content = re.sub(rf"{re.escape(old)}", new, content)

    with file.open("w") as f:
        f.write(updated_content)
    print(f"Bumped the package in {file} from {old} to {new}")


def main() -> None:
    max_args = 3
    if len(sys.argv) != max_args:
        print("Usage: python bump.py <old_version> <new_version>")
        sys.exit(1)

    root = Path.cwd()
    old_version = sys.argv[1]
    new_version = sys.argv[2]

    for file in FILES_TO_UPDATE:
        update_version(old_version, new_version, root / file)


if __name__ == "__main__":
    main()
