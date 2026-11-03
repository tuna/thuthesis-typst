root := justfile_dir()

export TYPST_ROOT := root

# list all available recipes
[private]
default:
  @just --list --unsorted

# update thumbnail
thumbnail:
  @typst c -f png --pages 3 template/thesis.typ thumbnail.png

# build pdf
build:
  @typst c template/thesis.typ

# export profile
profile:
  @typst c template/thesis.typ --timings record.json

# format typst files
format:
  @typstyle -i --line-width 120 --indent-width 2 --no-reorder-import-items src template
