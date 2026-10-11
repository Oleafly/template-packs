#let default-toc-title = "Table of Contents"
#let default-toc-depth = 2
#let default-toc-title-level = 1
#let default-toc-gap = 0.8em

#let report-toc(
  title: default-toc-title,
  depth: default-toc-depth,
  title-level: default-toc-title-level,
  gap: default-toc-gap,
) = {
  heading(level: title-level, numbering: none)[#title]
  v(gap)
  outline(title: none, depth: depth)
}
