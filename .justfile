# list all available recipes
[private]
default:
  @just --list --unsorted

# build pdf (optionally `just build en`)
build lang="":
  @typst c --root . {{ if lang == "" { "" } else { "--input lang=" + lang } }} template/thesis.typ

# update thumbnail
thumbnail:
  @typst c -f png --pages 3 --root . template/thesis.typ thumbnail.png

# export profile
profile:
  @typst c --root . template/thesis.typ --timings record.json
