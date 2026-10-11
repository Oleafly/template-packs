// TU Delft PhD Thesis Template for Typst
// Public helpers only. Keep university-specific details in the document metadata.

#let delft-blue = rgb("#00A6D6")
#let delft-navy = rgb("#0C2340")
#let page-width = 170mm
#let page-height = 240mm
#let page-margins = (top: 25mm, bottom: 20mm, inside: 25mm, outside: 20mm)

#let current-chapter = state("tudelft-current-chapter", "")
#let current-section = state("tudelft-current-section", "")
#let chapter-start-page = state("tudelft-chapter-start-page", 0)
#let pending-chapter-title = state("tudelft-pending-chapter-title", none)
#let bibliography-settings = state("tudelft-bibliography", none)

#let front-matter-heading = it => align(right)[
  #text(size: 27pt, weight: "bold", fill: delft-blue)[#it.body]
]

#let front-heading = front-matter-heading

#let chapter-heading = it => {
  let short = pending-chapter-title.get()
  let title = if short == none { it.body } else { short }
  current-chapter.update(title)
  current-section.update("")
  chapter-start-page.update(counter(page).get().at(0))
  pending-chapter-title.update(none)
  align(right)[#text(size: 96pt, fill: delft-blue)[#counter(heading).get().at(0)]]
  v(-29mm)
  align(right)[#text(size: 22pt, weight: "bold", fill: delft-blue, hyphenate: false)[#it.body]]
  v(5mm)
}

#let section-heading = it => {
  current-section.update(it.body)
  text(fill: delft-blue)[#smallcaps(it)]
}

#let running-header = context {
  let chapter = current-chapter.get()
  let section = current-section.get()
  let page-number = counter(page).get().at(0)
  let first-page = chapter-start-page.get()
  if chapter != "" and page-number != first-page {
    let is-even = calc.even(page-number)
    let page-label = str(page-number)
    let left = if is-even { page-label } else if section == "" { chapter } else { section }
    let right-content = if is-even { chapter } else { page-label }
    set text(size: 9pt, fill: delft-blue)
    grid(columns: (1fr, 1fr), [#left], align(right)[#right-content])
    line(length: 100%, stroke: 0.4pt + delft-blue)
    v(2mm)
  }
}

#let running-footer = context {
  let page-number = counter(page).get().at(0)
  if current-chapter.get() == "" or page-number == chapter-start-page.get() {
    align(center)[#text(size: 9pt)[#str(page-number)]]
  }
}

#let thesis(
  title: "Thesis title",
  author: "Author name",
  bibliography: none,
  body,
) = {
  set document(title: title, author: author)
  bibliography-settings.update(bibliography)
  set page(
    width: page-width,
    height: page-height,
    margin: page-margins,
    header-ascent: 0pt,
    footer-descent: 0pt,
  )
  set text(font: "Libertinus Serif", size: 10.5pt)
  set par(leading: 0.65em, justify: true)
  set heading(numbering: "1.")
  set figure(numbering: "1", supplement: "Figure")
  show link: set text(fill: delft-blue)
  show cite: set text(fill: delft-blue)
  show heading.where(level: 1): chapter-heading
  show heading.where(level: 2): section-heading
  body
}

#let front-matter(body) = {
  set page(numbering: "i", header: none, footer: none)
  counter(page).update(1)
  body
}

#let main-matter(body) = {
  pagebreak()
  set page(numbering: none, header: running-header, footer: running-footer)
  counter(page).update(1)
  counter(heading).update(0)
  body
}

#let back-matter(body) = {
  current-chapter.update("")
  current-section.update("")
  set page(header: none, footer: none)
  show heading.where(level: 1): front-matter-heading
  body
}

#let blank-page() = page(header: none, footer: none, numbering: none)[]

#let chapter(title: none, body: none, short-title: none, first: false) = {
  if not first { pagebreak() }
  pending-chapter-title.update(short-title)
  heading(level: 1)[#title]
  body
}

#let appendix-matter(body) = {
  pagebreak()
  current-chapter.update("")
  current-section.update("")
  counter(heading).update(0)
  set heading(numbering: "A.1.")
  show heading.where(level: 1): it => {
    let appendix-number = counter(heading).get().at(0)
    let letters = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
    current-chapter.update(it.body)
    current-section.update("")
    chapter-start-page.update(counter(page).get().at(0))
    align(right)[#text(size: 16pt, fill: delft-blue)[Appendix]]
    align(right)[#text(size: 96pt, fill: delft-blue)[#letters.at(appendix-number - 1)]]
    v(-29mm)
    align(right)[#text(size: 22pt, weight: "bold", fill: delft-blue, hyphenate: false)[#it.body]]
    v(5mm)
  }
  body
}

#let appendix(title: none, body: none, short-title: none) = {
  pagebreak()
  pending-chapter-title.update(short-title)
  heading(level: 1)[#title]
  body
}

#let title-page(
  title: none,
  author: none,
  defence-date: none,
  rector: "Prof.dr.ir. H. Bijl",
  degree: "doctor",
) = {
  set page(numbering: none, header: none, footer: none)
  align(center)[
    #v(18mm)
    #par(justify: false)[#text(size: 22pt, weight: "bold", hyphenate: false)[#title]]
    #v(48mm)
    #text(size: 16pt, weight: "bold")[Dissertation]
    #v(10mm)
    for the purpose of obtaining the degree of #degree \
    at Delft University of Technology \
    by the authority of the Rector Magnificus, #rector, \
    chair of the Board for Doctorates \
    to be defended publicly on \
    #defence-date
    #v(16mm)
    by
    #v(7mm)
    #text(size: 18pt, weight: "bold")[#author]
  ]
}

#let committee-table(rows, left-width: 0.43, gap: 12pt) = grid(
  columns: (left-width * 1fr, (1 - left-width) * 1fr),
  column-gutter: gap,
  row-gutter: 6pt,
  ..rows.flatten(),
)

#let funding-mark(name, subtitle: none, accent: delft-blue) = block(
  width: 52mm,
  inset: (x: 4pt, y: 4pt),
  stroke: (bottom: 1pt + accent),
)[
  #align(center)[
    #text(size: 13pt, weight: "bold", fill: accent)[#name]
    #if subtitle != none { linebreak(); text(size: 6.5pt, fill: luma(95))[#subtitle] }
  ]
]

#let committee-page(
  promotors: (),
  members: (),
  sponsors: none,
  funding: none,
  keywords: none,
  printer: none,
  isbn: none,
  copyright: none,
  repository-url: none,
) = {
  pagebreak()
  set page(numbering: none, header: none, footer: none)
  [
    This dissertation has been approved by the promotors.
    #v(7pt)
    *Composition of the doctoral committee:*
    #v(4pt)
    #committee-table(promotors)
    #v(7pt)
    *Independent members:*
    #v(3pt)
    #committee-table(members)
    #if sponsors != none { v(10pt); sponsors }
    #if funding != none { v(12pt); funding }
    #if keywords != none {
      v(12pt)
      grid(columns: (0.2fr, 0.8fr), column-gutter: 10pt, text(style: "italic")[Keywords:], keywords)
    }
    #if printer != none {
      v(7pt)
      grid(columns: (0.2fr, 0.8fr), column-gutter: 10pt, text(style: "italic")[Printed by:], printer)
    }
    #if isbn != none {
      v(5pt)
      grid(columns: (0.2fr, 0.8fr), column-gutter: 10pt, text(style: "italic")[ISBN:], isbn)
    }
    #if copyright != none { v(10pt); copyright }
    #if repository-url != none {
      v(6pt)
      [An electronic copy of this dissertation is available at \
      #link(repository-url)[#repository-url]]
    }
  ]
}

#let table-of-contents(depth: 3) = {
  show heading.where(level: 1): front-matter-heading
  heading(level: 1, numbering: none)[Contents]
  v(8mm)
  show outline.entry: it => text(fill: delft-blue)[#it]
  outline(title: none, depth: depth)
}

#let list-of(kind, title) = {
  show heading.where(level: 1): front-matter-heading
  heading(level: 1, numbering: none)[#title]
  v(8mm)
  show outline.entry: it => text(fill: delft-blue)[#it]
  outline(title: none, target: figure.where(kind: kind), indent: auto)
}

#let list-of-figures() = list-of(image, "List of Figures")
#let list-of-tables() = list-of(table, "List of Tables")
#let list-of-algorithms() = list-of("algorithm", "List of Algorithms")
#let list-of-listings() = list-of("listing", "List of Code Listings")

#let algorithm(title: none, input: none, output: none, caption: none, body) = {
  let content = block(width: 100%, inset: 10pt, fill: luma(252), stroke: 0.7pt + luma(185), radius: 3pt)[
    #if title != none { text(weight: "bold", fill: delft-blue)[#title]; v(5pt) }
    #if input != none { [*Input:* #input]; v(2pt) }
    #if output != none { [*Output:* #output]; v(5pt) }
    #body
  ]
  if caption == none { content } else { figure(content, caption: caption, kind: "algorithm", supplement: "Algorithm") }
}

#let listing(caption: none, language: none, body) = {
  let content = block(width: 100%, inset: 8pt, fill: luma(250), stroke: 0.7pt + luma(185), radius: 3pt)[#body]
  if caption == none { content } else { figure(content, caption: caption, kind: "listing", supplement: "Code listing") }
}

#let styled-table(columns: (), header: (), ..cells) = table(
  columns: columns,
  inset: (x: 0.8em, y: 0.6em),
  stroke: none,
  fill: (x, y) => if y == 0 { delft-blue.lighten(85%) } else if calc.odd(y) { luma(250) },
  table.hline(y: 0, stroke: 1.3pt + delft-blue),
  ..header.map(item => text(weight: "bold", fill: delft-blue)[#item]),
  table.hline(stroke: 0.8pt + delft-blue),
  ..cells.pos(),
  table.hline(stroke: 1.3pt + delft-blue),
)

#let bibliography-section() = context {
  let source = bibliography-settings.get()
  if source != none {
    pagebreak()
    current-chapter.update("")
    current-section.update("")
    show heading.where(level: 1): front-matter-heading
    heading(level: 1, numbering: none)[References]
    bibliography(source, title: none)
  }
}
