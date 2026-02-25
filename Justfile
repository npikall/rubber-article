root := justfile_directory()
export TYPST_ROOT := root

[default]
_default:
    @just --list --unsorted

alias i := install
alias u := uninstall
alias ip := install-preview
alias up := uninstall-preview

# display the system/project information
[group("chore")]
info:
    @echo "{{ CYAN }}Arch{{ NORMAL }}: {{ arch() }}"
    @echo "{{ CYAN }}OS{{ NORMAL }}: {{ os_family() }}, {{ os() }}"
    @echo "{{ CYAN }}Num CPU's{{ NORMAL }}: {{ num_cpus() }}"
    @echo "{{ CYAN }}Project{{ NORMAL }}: `gotpm bump --show-current`"

# install the pre-commit hooks
[group("chore")]
hooks:
    uvx prek install


# generate manual
[group("typst")]
docs:
    typst compile docs/docs.typ docs/docs.pdf

# generate the thumbnail
[group("typst")]
thumbnail:
    typst compile docs/thumbnail.typ thumbnail.png

# compile the template
[group("typst")]
template:
    typst compile template/main.typ --package-path ~/.local/share/typst/packages

# run test suite
[group("test")]
test *args:
    tt run {{ args }}

# update test cases
[group("test")]
update *args:
    tt update {{ args }}

# install the library with the "@local" prefix
[group("chore")]
install:
    gotpm install

# install the library with the "@preview" prefix (for pre-release testing)
[group("chore")]
install-preview:
    gotpm install -n preview

# uninstalls the library from the "@local" prefix
[group("chore")]
uninstall:
    gotpm uninstall

# uninstalls the library from the "@preview" prefix (for pre-release testing)
[group("chore")]
uninstall-preview:
    gotpm uninstall -n preview

# package the library into the specified destination folder
[group("chore")]
package target:
    TYPST_PACKAGE_PATH="{{ target }}" gotpm install

# run typst package checker
[group("test")]
check:
    typst-package-check check

# run ci suite (test, doc, thumbnail)
[group("test")]
ci: test docs thumbnail

# update the package version
[group("chore")]
bump incr="patch":
    uv run ./scripts/bump.py `gotpm bump --show-current` `gotpm bump {{ incr }} --show-next`
    gotpm bump {{ incr }} --indent


_ensure_clean:
    @git diff --quiet
    @git diff --cached --quiet

# write the changelog from commit messages (gh:pawamoy/git-changelog)
[group("chore")]
changelog version=`gotpm bump -c`:
    git-changelog -Tio CHANGELOG.md -B="{{ version }}" -c conventional

_commit_and_tag version=`gotpm bump --show-current`:
    git add typst.toml README.md template/main.typ docs/docs.typ CHANGELOG.md
    git commit -m "chore(release): bumped version to {{ version }}"
    git tag -a "v{{ version }}"

# make a new release [target:<major|minor|patch> or semver]
[group("chore")]
release target: test
    @just _ensure_clean
    @just bump {{ target }}
    @just changelog
    @just _commit_and_tag
    @echo "{{ GREEN }}Release complete. Run 'git push && git push --tags'.{{ NORMAL }}"
