#import "cover.typ": show-title-page
#import "functions.typ": *

// Dependend Counters
#import "@preview/headcount:0.1.0": *

// Current chapter/section name in headers
#import "@preview/hydra:0.6.2": hydra

// Enables backrefs for bibliography entries // currently broken in 0.14
//#import "@preview/retrofit:0.1.2": backrefs

// For algorithm display
#import "@preview/algorithmic:1.0.6"


#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl, get-entry-back-references, reset-counts
#let thesis(
  title: "Is Oil the Future?",
  author: "Martin Nagel",
  course-of-study: "Medieninformatik",
  examiner: "Prof. Dr. Andreas Bulling",
  supervisor: "Anna Penzkofer, M. Sc.",
  commenced: datetime(day: 4, month: 11, year: 2025),
  completed: datetime(day: 4, month: 5, year: 2026),
  institute: (name: "Institute for Visualization and Interactive Systems", address: "Universitätsstraße 38", city: "70569 Stuttgart"),
  document-type: "Bachelorarbeit",
  abstract: (en: lorem(150)),
  acronyms: entries-from-yaml(yaml("../acronyms.yaml")),
  literature: "../literature.bib",
  fonts: (serif: "Tex Gyre Termes", sans: "TeX Gyre Heros", writer: "Inconsolata", math: "Tex Gyre Termes Math"),
  last-followed-links-date: datetime(day: 30, month: 4, year: 2026).display("[month repr:long] [day padding:none], [year]"),
  ai-usage: [No AI tools were used for generating any significant parts of this work.],
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-list-of-algorithms: true,
  doc
) = {

set document(title: title, author: author)

show-title-page(
  title: title, name: author, course-of-study: course-of-study, examiner: examiner, supervisor: supervisor, commenced: commenced, completed: completed, institute: institute, document-type: document-type
)

show math.equation: set text(font: fonts.math)

set text(font: fonts.serif, size: 11pt, ligatures: true)
show heading: set text(font: fonts.sans)

set par(
  justify: true, 
  spacing: 12.8pt, 
  leading: 6.2pt,
  justification-limits: ( spacing: (min: 66.67% + 0pt, max: 150% + 0pt), tracking: (min: -0.01em, max: 0.01em), )
)

set page(
  footer: context {
      set text(font: fonts.sans, size: 10pt)
      let page = counter(page).get().first()
      set align(top)
      //rect(height: 1fr, width: 100%, )
      align(if calc.odd(page) { right } else { left })[#page]
  },
  header: context {
    let chapter-pages = query(selector(heading.where(level: 1))).map(it => {it.location().page()})
    let current-page = here().page()

    if current-page in chapter-pages  {
      none
    } else {
      set text(font: fonts.sans, size: 10pt)
      set par(spacing: 0.6em)
      if calc.odd(here().page()) {
        align(right, hydra(2))
      } else {
        align(left, hydra(1))
      }
      line(length: 100%, stroke: .14mm)
    }
  },
  margin: (bottom: 2.6cm + 7.266pt + 16pt, top: 3.75cm, inside: 3cm, outside: 3cm),
  footer-descent: 16pt,
  header-ascent: 17pt
)

// Acronyms and List of Figures/Tables/Listings/Algorithms should not appear in Table of Contents
set heading(outlined: false)

let abstact_titles = (
  en: "Abstract",
  de: "Zusammenfassung"
)
// Abstract
for (lang, abstract_text) in abstract {
  page(footer: none, header: none, none)
  page(header: none)[
  #block(below: 0.324in, text(font: "TeX Gyre Heros", weight: "bold", size: 13.5pt)[#abstact_titles.at(lang)])
  #abstract_text
]
}


show heading.where(level: 1): reset-counter(counter(figure.where(kind: image)))

show heading.where(level: 1): it => {
  {
    set page(header: none, footer: none)
    pagebreak(to: "odd")
  }
  context reset-counts()
  set text(size: 19.5pt)
  set block(inset: (top: 2.08cm), below: .5in)
  it
}


show heading.where(level: 2): it => {
  set block(below: 24.2pt, above: 1.1cm)
  it
}

show heading.where(level: 3): it => {
  set block(below: 20.2pt, above: .8cm)
  it
}

// Figure Styling

show figure.where(kind: image): set figure(
  numbering: dependent-numbering("1.1"),
)

show figure.where(kind: table): set figure(
  numbering: dependent-numbering("1.1"),
)

let fig-selector = figure.where(
  kind: image
).or(figure.where(
  kind: table)
)

set table(
  stroke: (x, y) => (
    top: if y == 0 {black + 1pt} else if y == 1 {black + 0.7pt} else { 0pt },
    bottom: black + 1pt,
  ),
)

show fig-selector: fig => {
  show figure.caption: cap => context {
    grid(
      columns: 2,
      column-gutter: .25em,
      align: left,
      strong[#cap.supplement #cap.counter.display(cap.numbering):],
      if cap.body != none {cap.body.children.join(" ")} else []
    )
  }
  set place(clearance: 2.1em)
  fig
}

// Outline Styling

show outline.entry.where(level: 1): set outline.entry(fill: none)
show outline.entry.where(level: 1): it => {
  set block(above: 16.7pt, below: .75em)
  set text(font: fonts.sans, weight: "bold")
  it
}

show outline.entry.where(level: 2): set outline.entry(fill: box(inset: (left: 2mm, right: 5mm), repeat([.], gap: 0.5em)))

// Main outline
outline(
  title: "Contents",
  depth: 2
)

// Figure outline
show outline.entry.where(level: 1): it => {
  if it.element.func() == heading {
    block(above: 1em)
  } else {
    //it.element.location()
    outline.entry(2, it.element)
  }
}

show outline.entry.where(level: 2): it => {
  let prefix = it.prefix().children.last()
   let caption = if it.element.caption == none {
    []
  }else {
    let caption_array = it.element.caption.body.fields().values().first()

    if type(caption_array) == str {
    caption_array
    } else {
    caption_array.first()
    }
  }
  
  link(
    it.element.location(),
    it.indented(
      gap: 1em,
      prefix, 
      //box(grid(
      //  columns: 2,
      //  align: bottom,
        [
        #caption
         #box(inset: (left: 2mm, right: 3mm), width: 1fr, repeat(".", gap: 0.5em, justify: true))
         #it.page()
        ],
         
      )
    
  )
}
if show-list-of-figures {
  outline(
    title: "List of Figures",
    target: figure.where(kind: image).or(heading.where(level: 1)),
  )
}

if show-list-of-tables {
  outline(
    title: "List of Tables",
    target: figure.where(kind: table).or(heading.where(level: 1)),
  )
}

// List of Listings und algorithms
if show-list-of-algorithms {
  outline(
    title: "List of Algorithms",
    target: figure.where(kind: "algorithm").or(heading.where(level: 1)),
  )
}


// Acronyms

// Glossarium Init
show: make-glossary

register-glossary(acronyms)

// Show acronyms
heading("Acronyms")
print-glossary(
  acronyms,
  user-print-title: entry => {
    let short = text(font: fonts.sans, weight: "semibold", entry.short)
    let long = text(font: fonts.serif, weight: "regular", entry.long)
    return [#short #h(.2em) #long.]
  },
  deduplicate-back-references: true,
  //show-all: true
  shorthands: ("plural", "capitalize", "capitalize-plural", "short", "long", "longplural"),
)

set heading(outlined: true, numbering: "1.1 ")
//set cite(style: "ieee-university-of-stuttgart.csl")

show bibliography: it => {show link: set text(fill: rgb("000080ff"), font: fonts.writer, size: 10pt); it}

doc

[
#bibliography("../literature.bib", style: "ieee-university-of-stuttgart.csl")
\
All links were last followed on #last-followed-links-date.
]

// Abstract
page(header: none)[
  #block(below: 0.324in, text(font: "TeX Gyre Heros", weight: "bold", size: 13.5pt)[Use of AI Tools])
  #ai-usage
]

include "declaration.typ"
}
