find "$(dirname "$(dirname "$0")")" -regextype posix-extended \
    -regex '.*\.(aux|log|out|thm|toc|bbl|blg|fdb_latexmk|fls)' \
    -delete
