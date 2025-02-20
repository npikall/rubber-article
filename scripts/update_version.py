import re
import sys
from pathlib import Path

FILES_TO_UPDATE =  [
    "typst.toml",
    "README.md",
    "template/main.typ",
    "docs/docs.typ"
]


def update_version(old:str, new:str, file:str | Path):
    # Read the file
    with open(file, "r") as f:
        content = f.read()
    
    # Replace the version
    updated_content = re.sub(rf"{re.escape(old)}", new, content)

    # Write the file
    with open(file, "w") as f:
        f.write(updated_content)
    print(f"Updated {file} from {old} to {new}")


def main():
    if len(sys.argv) != 3:
        print("Usage: update_version.py <old_version> <new_version>")
        sys.exit(1)
        
    root = Path.cwd()
    old_version = sys.argv[1]
    new_version = sys.argv[2]

    for file in FILES_TO_UPDATE:
        update_version(old_version, new_version, root / file)

if __name__ == "__main__":
    main()