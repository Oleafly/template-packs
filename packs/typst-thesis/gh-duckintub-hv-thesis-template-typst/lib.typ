#let heading-color = rgb("#1f497d")

#let create_meta_info_box(names, values) = {
  set text(font: "Roboto", size: 9pt)
  align(bottom, rect(table(
      columns: (auto, 1fr), 
      align: top,
      stroke: none,
      inset: 0.25em,
      ..names.zip(values).map(((name, val)) => {
        if name in ("Nyckelord", "Keywords") {
          ([\ *#name:*], [\ #val], [\ ], [\ ])
        } else {
          ([*#name:*], [#val])
        }
      }).flatten()
  )))
}

#let get-appendix-footer() = [
  #let letter = context counter(heading).display("A")
  #let number = context counter(page).display("1")
  #grid(
    columns: (1fr, auto, 1fr),
    [Appendix],
    align(center)[#letter:#number],
    align(right)[],
  )
]


#let image-counter = counter("images")
#let table-counter = counter("tables")

#let custom-caption(it) = {
  let chapter-num = context counter(heading).get().first()
  let figure-num

  if it.kind == image {
    figure-num = context image-counter.display("1")
    image-counter.step()
  } else if it.kind == table {
    figure-num = context table-counter.display("1")
    table-counter.step()
  }

  [#it.supplement #chapter-num\.#figure-num\: #it.body]
}

#let custom-heading(it) = {
  image-counter.update(0)
  table-counter.update(0)
  it
}

#let custom-ref(it) = {
  let element = it.element // The element being referenced (e.g., a figure)

  if element == none or element.func() != figure {
    return it
  }
  
  let chapter-num = counter(heading).at(element.location()).first()
  let current-label; let current-num

  if element.kind == image {
    current-label = "Figure"
    current-num = image-counter.at(element.location()).first() + 1
  } else if element.kind == table {
    current-label = "Table"
    current-num = table-counter.at(element.location()).first() + 1
  } 
  
  link(it.target)[#current-label #chapter-num.#current-num]
}


#let hv-template(
  title: none,
  front-figure: none,
  se-title: none,
  authors: (),
  examiner: [],
  advisor: [],
  programme: [Computer Engineering – programming and network technology 180 hp \
  (or Bachelor year in network technology, 60 hp)],
  se-programme: [],
  field: [Computer Engineering],
  se-field: [],
  education-level: [First cycle],
  se-education-level: [],
  course-code: [EHD500, 15 HE credits],
  se-course-code: [],
  keywords: [],
  se-keywords: [],
  publisher: [Department of Engineering Science, University West \
    SE-461 86 Trollhättan, Sweden],
  se-publisher: [],
  bib-file: none,
  abstract: [],
  se-abstract: [],
  preface: [],
  list-of-figures: false,
  list-of-tables: false,
  list-of-abbreviations: false,
  chapter-numbering: false,
  appendix: (),
  content
) = {
  set text(font: "EB Garamond", size: 12pt) // Free garamond
  show heading: set text(font: "PT Serif") // Best I got as replacment for cambria
  show heading: set text(heading-color) 
  show raw: set text(font: "Liberation Mono", size: 9pt) // Alternative to Courier 
  set enum(indent: 1.25em)
  set list(indent: 1.25em)
  set terms(indent: 1.25em)

  // Insert the title page
  grid(
    columns: (1fr, 1fr),
    align(left)[
      #image("/logo.png")
    ],
    align(right)[
      *#datetime.today().display()*
    ]
  )
  
  v(8em)
  
  heading(outlined: false, text(size: 24pt, heading-color)[#title])
  
  v(3em)
  
  for author in authors {
    text(size: 14pt)[*#author*]
    h(2em) // Horizontal space
  }
  
  v(2em)

  front-figure
  
  align(bottom)[*
    DEGREE PROJECT \
    Computer Engineering \
    Bachelor level G2E, 15 hec \
    \
    Department of Engineering Science, University West, Sweden
  *]
  pagebreak()
  
  // Insert the abstracts
  counter(page).update(1)
  set page(numbering: "i")
  
  text(lang: "se", page(
    header: align(center)[#text(size: 14pt)[_*EXAMENSARBETE*_]],
  )[
    #align(center, heading(outlined: false, text(size: 18pt, heading-color)[#se-title]))
    #line(length: 100%, stroke: blue)
    #heading(outlined: false)[Sammanfattning]
    #se-abstract
    #create_meta_info_box(
      (
        "Datum",
        "Författare",
        "Examinator",
        "Handledare",
        "Program",
        "Huvudområde",
        "Utbildningsnivå",
        "Kurskod",
        "Nyckelord",
        "Utgivare",
      ),
      (datetime.today().display(), authors.join(", "), examiner, advisor, se-programme, se-field, se-education-level, se-course-code, se-keywords, se-publisher)
    )
    
  ])
  text(lang: "en", page(
    header: align(center)[#text(size: 14pt)[_*DEGREE PROJECT*_]],
  )[
    #align(center, heading(outlined: false, text(size: 18pt, heading-color)[#title]))
    #line(length: 100%, stroke: blue)
    #heading(outlined: false)[Abstract]
    #abstract
    #create_meta_info_box(
      (
        "Date",
        "Author",
        "Examiner",
        "Advisor",
        "Programme",
        "Main field of study",
        "Education level",
        "Course code",
        "Keywords",
        "Publisher",
      ),
      (datetime.today().display("[month repr:long] [day], [year]"), authors.join(", "), examiner, advisor, programme, field, education-level, course-code, keywords, publisher)
    )
  ])
  
  set page(margin: (top: 4cm, bottom: 2cm, x: 3cm), header: align(center, [
    #text(size: 12pt, style: "italic", title)
    #line(length: 100%)
  ]))

  // Preface
  heading(outlined: false, [Preface])
  preface
  v(2em)
  [
    Trollhättan #sym.dash #datetime.today().display("[month repr:long] [day], [year]") \
    *#authors.join(", ")*
  ]
  pagebreak()
  
  // Table of contents
  outline(
    title: [Table of contents],
    target: heading.where(numbering: "1.1.1")
  )
  
  {
    show outline.entry: it => link(
      it.element.location(),
      it.indented(it.prefix(), it.body())
    )
  
    outline(
      title: [Appendices],
      target: heading.where(numbering: "A")
    )
  }

  if list-of-figures {
    pagebreak()
    outline(
      title: [List of Figures],
      target: figure.where(kind: image)
    )
  }

  if list-of-tables {
    pagebreak()
    outline(
      title: [List of Tables],
      target: figure.where(kind: table)
    )
  }

  if list-of-abbreviations not in (none, false, []) {
    pagebreak()
    heading(outlined: false)[List of Abbreviations]
    list-of-abbreviations
  }
  
  pagebreak()
  

  // Start actual content
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => {pagebreak(weak: true); it}
  set page(numbering: "1")
  counter(page).update(1)
  show figure.caption: set text(weight: "bold")
  
  if chapter-numbering {
    show heading: custom-heading
    show figure.caption: custom-caption
    show ref: custom-ref
      
    content
  } else {
    content
  }
  bib-file

  pagebreak()
  set heading(numbering: "A")
  counter(heading).update(0)
  counter(page).update(0)
  show figure.caption: it => it.body
  for apx in appendix {
    pagebreak(weak: true)
    set page(footer: get-appendix-footer())
    counter(page).update(1)
    apx
  }
}