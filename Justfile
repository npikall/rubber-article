root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
	@just --list --unsorted

# generate manual
doc:
	typst compile docs/docs.typ docs/docs.pdf

# generate the thumbnail
thumbnail:
  typst compile docs/thumbnail.typ thumbnail.png

# compile the template
template:
  typst compile template/main.typ --package-path ~/.local/share/typst/packages

# run test suite
test *args:
  tt run {{ args }}

# update test cases
update *args:
  tt update {{ args }}

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run typst package checker
check:
  typst-package-check check

# run ci suite (test, doc, thumbnail)
ci: test doc thumbnail

# update the package version
bump old new:
  python ./scripts/bump.py "{{old}}" "{{new}}"
