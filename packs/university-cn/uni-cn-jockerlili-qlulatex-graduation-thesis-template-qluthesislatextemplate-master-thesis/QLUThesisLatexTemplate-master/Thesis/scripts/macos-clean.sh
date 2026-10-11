#!/bin/sh
PARENT_DIR="$(dirname "$(dirname "$0")")"
find -E "$PARENT_DIR" -regex ".*\.(aux|log|out|thm|toc|bbl|blg|fdb_latexmk|fls|gz)" -delete
