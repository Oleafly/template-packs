#import "template.typ": thesis, title-page, front-section, running-header, notation, appendix-mode, chapter-break
#import "thesis-info.typ": info
#import "front-matter/notation.typ": groups

// Add or reorder chapters here; this order determines their numbering.
#let chapters = (
  "background",
  "estimation",
)

#let mode = sys.inputs.at("mode", default: "full")
#let layout = sys.inputs.at("layout", default: "print")
#let sides = sys.inputs.at("two-sided", default: "true")
#let chapter = sys.inputs.at("chapter", default: chapters.last())
#let selected-chapter = chapters.enumerate().find(entry =>
  (entry.last(), str(entry.first() + 1)).contains(chapter))
#assert(("full", "abstract", "chapter").contains(mode), message: "mode must be full, abstract, or chapter")
#assert(("print", "online").contains(layout), message: "layout must be print or online")
#assert(("true", "false").contains(sides), message: "two-sided must be true or false")
#assert(selected-chapter != none, message: "chapter must be a name from chapters or its position in that list")
#let two-sided = sides == "true" and mode == "full"

#show: thesis.with(info, print: layout == "print", two-sided: two-sided,
  font: sys.inputs.at("font", default: "XCharter"))

#if mode != "chapter" {
  title-page(info)
  if mode == "full" {
    chapter-break(two-sided: two-sided)
    v(40mm)
    align(center, include "front-matter/dedication.typ")
  }
  front-section([Declaration], two-sided: two-sided)[
    #include "front-matter/declaration.typ"
    #v(1em)
    #align(right)[#info.author \ #info.date]
  ]
  if mode == "full" {
    front-section([Acknowledgements], two-sided: two-sided)[
      #include "front-matter/acknowledgements.typ"
    ]
    front-section([Abstract], two-sided: two-sided)[
      #include "front-matter/abstract.typ"
    ]
  } else {
    front-section(info.title, two-sided: false)[
      #align(center, info.author)
      #v(1em)
      #include "front-matter/abstract.typ"
    ]
  }
}

#if mode == "full" {
  set page(header: running-header(two-sided: two-sided))
  heading(level: 1, numbering: none, outlined: false)[Table of contents]
  outline(title: none, depth: 3, indent: auto)
  heading(level: 1, numbering: none)[List of figures]
  outline(title: none, target: figure.where(kind: image))
  heading(level: 1, numbering: none)[List of tables]
  outline(title: none, target: figure.where(kind: table))
  notation(groups)
}

#if mode != "abstract" {
  chapter-break(two-sided: two-sided)
  set page(numbering: "1", header: running-header(two-sided: two-sided))
  counter(page).update(1)
  if mode == "full" {
    for name in chapters {
      include "chapters/" + name + ".typ"
    }
  } else {
    counter(heading).update(selected-chapter.first())
    include "chapters/" + selected-chapter.last() + ".typ"
  }

  heading(level: 1, numbering: none)[References]
  {
    set text(size: 11pt)
    set par(leading: 0.35em, spacing: 0.7em, first-line-indent: 0pt)
    bibliography("bibliography/references.bib", title: none, style: "bibliography/numbered.csl")
  }

  if mode == "full" {
    appendix-mode.update(true)
    counter(heading).update(0)
    set heading(numbering: "A.1.1", supplement: [Section])
    show heading.where(level: 1): set heading(supplement: [Appendix])
    include "appendices/sample-mean.typ"
  }
}
