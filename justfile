root := justfile_directory()
export TYPST_ROOT := root
project_name := "rubber-article"
current_version := `gotpm bump -c`

[default]
_default:
    @just --list --unsorted

alias i := install
alias u := uninstall
alias ip := install-preview
alias up := uninstall-preview

# display the system/project information
info:
    @echo "{{ CYAN }}Arch{{ NORMAL }}: {{ arch() }}"
    @echo "{{ CYAN }}OS{{ NORMAL }}: {{ os_family() }}, {{ os() }}"
    @echo "{{ CYAN }}Num CPU's{{ NORMAL }}: {{ num_cpus() }}"
    @echo "{{ CYAN }}Project{{ NORMAL }}: {{ project_name }} {{ current_version }}"

# install the pre-commit hooks
hooks:
    uvx prek install

# generate manual
docs:
    typst compile docs/docs.typ docs/docs.pdf

# generate the thumbnail
thumbnail:
    typst compile --creation-timestamp=0 docs/thumbnail.typ thumbnail.png

# compile the template
template:
    typst compile template/main.typ

# run test suite
test *args:
    tt run {{ args }}

# update test cases
update *args:
    tt update {{ args }}

# install the library with the "@local" prefix
install:
    gotpm install

# install the library with the "@preview" prefix (for pre-release testing)
install-preview:
    gotpm install -n preview

# uninstalls the library from the "@local" prefix
uninstall:
    gotpm uninstall

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview:
    gotpm uninstall -n preview

# package the library into the specified destination folder
package target:
    TYPST_PACKAGE_PATH="{{ target }}" gotpm install

# run typst package checker
check:
    just package out
    -cd out/local/{{ project_name }}/{{ current_version }} && typst-package-check check
    rm -rf out/

# run ci suite (test, doc, thumbnail)
ci: test docs thumbnail check

# update the package version
bump incr="patch":
    uv run ./scripts/bump.py `gotpm bump --show-current` `gotpm bump {{ incr }} --show-next`
    gotpm bump {{ incr }} --indent


_ensure_clean:
    @test -z "$(jj diff --summary)" || (echo "{{ RED }}Working copy is not clean.{{ NORMAL }}" && exit 1)

# write the changelog from commit messages (gh:pawamoy/git-changelog)
changelog version=`gotpm bump -c`:
    git-changelog -Tio CHANGELOG.md -B="{{ version }}" -c conventional

_commit_and_tag version=`gotpm bump --show-current`:
    jj commit -m "chore(release): bumped version to {{ version }}"
    jj tag set "v{{ version }}" -r @-

# make a new release [target:<major|minor|patch> or semver]
release target: test check
    @just _ensure_clean
    @just bump {{ target }}
    @just changelog
    @just _commit_and_tag
    @echo "{{ GREEN }}Release committed and tagged. Move the main bookmark to @-, then push it and the tag.{{ NORMAL }}"
