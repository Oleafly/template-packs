// Packages
#import "@preview/abbr:0.2.3"

// Preamble configs
#set page(
  margin: 1.5in,
  paper: "a4",
)
#set text(size: 12pt)
#set par(
  first-line-indent: 0.25in,
  justify: true,
)
#let frontmatter(title, content) = [
  #pagebreak()
  = #title
  #v(0.25in)
  #content
]

#show heading.where(level: 1): set text(size: 24pt, weight: "black")
#show outline.entry: set block(spacing: 0.25in)

// Content
#include("config.typ")
#include("chapters/title.typ")

#set page(numbering: "i")

#for chapter in ("abstract", "acknowledgments") [
  #pagebreak()
  #include("chapters/" + chapter + ".typ")
]

#frontmatter("Table of Contents", outline(title: none))
#frontmatter("List of Tables", outline(title: none, target: figure.where(kind: table)))
#frontmatter("List of Figures", outline(title: none, target: figure.where(kind: image)))

#pagebreak()
#abbr.list(title: "Nomenclature")

#set page(numbering: "1")
#set heading(numbering: "1.")

#for chapter in ("introduction", "background", "methodology", "results", "discussions", "conclusion") [
  #pagebreak()
  #include("chapters/" + chapter + ".typ")
]

#set heading(numbering: none)
#frontmatter("List of References", bibliography("ref.bib", title: none, style: "ieee"))
