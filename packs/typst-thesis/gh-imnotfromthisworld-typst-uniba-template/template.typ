#import "@preview/hydra:0.6.0": hydra, selectors

// pagebreak
#let pg() = {
  set page(
    footer: none,
    header: none,
  )
  pagebreak(to: "odd", weak: false)
}

// double pagebreak
#let dpg() = {
  pagebreak()
  set page(
    footer: none,
    header: none,
  )
  pagebreak()
}

#let my_footer = context {
  let is-start-chapter = query(heading.where(level: 1)).map(it => it.location().page()).contains(here().page())
  h(1fr)
  if is-start-chapter {
    align(center, counter(page).display())
  } else {
    none
  }
}

#let sect = selectors.custom(heading.where(level: 1))

#let my_header(supplement: [], number: true) = context {
  let is-start-chapter = query(heading.where(level: 1)).map(it => it.location().page()).contains(here().page())
  if not is-start-chapter {
    if calc.odd(here().page()) {
      hydra(
        sect,
        book: true,
        display: (_, it) => {
          emph(smallcaps(lower(hydra(2))))
          h(1fr)
          counter(page).display()
        },
      )
    } else {
      hydra(
        sect,
        book: true,
        display: (_, it) => {
          counter(page).display()
          h(1fr)
          emph(
            smallcaps(
              lower(
                [#supplement ]
                  + if number {
                    numbering("1.", ..counter(heading).at(it.location()))
                  } else {
                    []
                  }
                  + [ ]
                  + it.body,
              ),
            ),
          )
        },
      )
    }
  }
}

#let leading = 1.5em
#let leading = leading - 0.75em // "Normalization"

#let thesis(
  lang: "en",
  thesis: [Bachelor Thesis],
  title: none,
  author: none,
  place: none,
  university: none,
  faculty: none,
  study_programme: none,
  field: none,
  department: none,
  supervisor: none,
  date: none,
  abstract: none,
  acknowledgement: none,
  intro: none,
  conclusion: none,
  chapter: (),
  appendix: (),
  body,
) = {
  /// ================================================
  /// Language

  let name_study_prog = [Study Programme]
  let name_field = [Field of Study]
  let name_department = [Department]
  let name_supervisor = [Supervisor]
  let name_acknowledgement = [Acknowledgements]
  let name_chapter = [Chapter]
  if lang == "sk" {
    thesis = [Bakalárska Práca]
    university = [Univerzita Komenského v Bratislave]
    faculty = [Fakulta matematiky, fyziky a informatiky]
    name_study_prog = [Študijný program]
    name_field = [Študijný odbor]
    name_department = [Školiace pracovisko]
    name_supervisor = [Školiteľ]
    name_acknowledgement = [Poďakovanie]
    name_chapter = [Kapitola]
  }

  set page(
    paper: "a4",
    margin: (bottom: 2.5cm, top: 2.5cm, inside: 3.5cm, outside: 2cm),
    numbering: (..numbers) => {
      if numbers.pos().at(0) > 5 {
        numbering("i", numbers.pos().at(0))
      }
    },
    header: my_header(supplement: none, number: false),
    footer: my_footer,
  )

  set block(spacing: leading)

  set par(leading: leading, spacing: leading, first-line-indent: 1.8em, justify: true)
  set text(font: "New Computer Modern", size: 12pt)
  show raw: box
  show raw: set text(size: 10pt, spacing: 0.5em)
  show heading: set block(above: 3em, below: 1.5em)

  show figure.where(kind: image): set block(inset: (top: 0.5em, bottom: 0.5em))
  show figure.where(kind: image): f => {
    v(0.5em, weak: false)
    f
  }

  show figure.where(kind: raw): set figure(gap: 1.5em)
  show figure.where(kind: raw): f => {
    v(1em, weak: false)
    f
    v(1em, weak: false)
  }

  set enum(indent: 1.5em, spacing: 1.5em)
  show enum: l => {
    v(1.5em, weak: true)
    l
    v(1.5em, weak: true)
  }
  show list: l => {
    v(1.5em, weak: true)
    l
    v(1.5em, weak: true)
  }
  set list(spacing: 1.5em, indent: 1.5em)
  set terms(spacing: 1em)
  show terms: l => {
    v(1.5em, weak: true)
    l
  }

  /// ================================================
  /// Title Page

  align(
    center,
    smallcaps(
      text(14.4pt)[
        #university \
        #faculty
        #v(1fr)

        #text(20.74pt)[ #title ]

        #v(1fr)
        #align(left)[
          #par(first-line-indent: 0em)[
            #date \
            #author
          ]
        ]
      ],
    ),
  )

  dpg()

  /// ================================================
  /// First Page

  counter(page).update(1)
  align(
    center,
    smallcaps(
      text(14.4pt)[
        #university \
        #faculty
      ],
    ),
  )

  v(1fr)

  align(
    center,
    smallcaps(
      text(20.74pt)[
        #title
      ],
    ),
  )

  align(
    center,
    smallcaps(thesis),
  )

  v(1fr)

  align(horizon)[#table(
      columns: 2,
      stroke: none,
      align: (col, row) => (left, left).at(col),
      [#name_study_prog:], study_programme,
      [#name_field:], field,
      [#name_department:], department,
      [#name_supervisor:], supervisor,
    )]

  v(1fr)

  par(first-line-indent: 0em)[
    #if place != none {
      [#place, ]
    }
    #date \
    #author
  ]

  dpg()

  /// ================================================
  /// Thesis Assignment

  page(
    paper: "a4",
    margin: (bottom: 0cm, top: 0cm, left: 0cm, right: 0cm),
  )[
    #set align(center)
    #image("assets/zadanie.pdf", format: "pdf")
    #image("assets/zadanie-en.pdf", format: "pdf")
  ]

  /// ================================================
  /// Acknowledgement

  if not none == acknowledgement {
    v(1fr)
    show "%name_supervisor": supervisor

    [*#name_acknowledgement:* #acknowledgement()]
  }


  /// ================================================
  /// Abstract

  pagebreak()
  [ #heading(outlined: false)[Abstrakt] #abstract.at(0)() ]
  pagebreak()
  [ #heading(outlined: false)[Abstract] #abstract.at(1)() ]

  pg()

  /// ================================================
  /// Table of Contents

  set heading(numbering: "1.1", supplement: name_chapter)
  set outline.entry(fill: none)
  [
    #show heading.where(level: 1): it => {
      text(size: 24pt, block(below: 3cm) + block(below: 2cm, above: 1.5cm, it.body))
    }
    #show outline.entry.where(level: 1): set block(above: 2em)
    #show outline.entry.where(level: 1): it => link(
      it.element.location(),
      strong(it.indented(it.prefix(), it.inner(), gap: 0.8em)),
    )
    #show selector.or(..(2, 3).map(level => outline.entry.where(level: level))): set block(above: 1em)
    #outline(depth: 3)
  ]

  /// ================================================
  /// List of Figures, Charts, Code Listings

  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()))

  show figure.caption: it => {
    let pattern = "^[^:]+" + sym.space.nobreak + "[\d.]+"
    it
  }
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: "chart")).update(0)
    it
  }

  /// ================================================
  /// Can add custom ones by setting `kind` to specific value
  [
    #show outline: it => if query(it.target) != () { it }
    #show selector.or(..(1, 2, 3).map(level => outline.entry.where(level: level))): set block(above: 1em)
    #show heading.where(level: 1): it => {
      text(size: 24pt, block(below: 0.5cm) + block(below: 1cm, above: 1.5cm, it.body))
    }
    #dpg()

    // Figures
    #outline(
      title: [List of Figures],
      target: figure.where(kind: image),
    )

    // Code Listings
    #outline(
      title: [List of Code Listings],
      target: figure.where(kind: raw),
    )

    // Charts
    #outline(
      title: [List of Charts],
      target: figure.where(kind: "chart"),
    )
  ]

  show heading.where(level: 1): it => {
    text(size: 24pt, block(below: 3cm) + block(below: 2cm, above: 1.5cm, it.body))
  }

  /// ================================================
  /// Introduction

  dpg()
  pg()
  counter(page).update(1)
  set page(
    numbering: "1",
    header: my_header(supplement: name_chapter),
    footer: my_footer,
  )

  [
    #set page(header: my_header(number: false))
    #set heading(numbering: none)

    #intro()
  ]
  dpg()

  show heading.where(level: 1): it => {
    text(
      size: 24pt,
      block(below: 3cm)
        + it.supplement
        + [ ]
        + counter(heading).display("1")
        + block(below: 2cm, above: 1.5cm, it.body),
    )
  }

  /// ================================================
  /// Chapters

  for c in chapter {
    c()
    pg()
  }

  show heading.where(level: 1): it => {
    text(size: 24pt, block(below: 3cm) + block(below: 2cm, above: 1.5cm, it.body))
  }

  [
    #set page(header: my_header(number: false))
    #set heading(numbering: none)

    #conclusion()
    #dpg()
  ]


  /// ================================================
  /// Bibliography

  [
    #set par(spacing: 2em)
    #set heading(outlined: false)
    #set page(header: my_header(number: false))
    #bibliography("lit.bib", style: "ieee")
  ]


  /// ================================================
  /// Appendices

  if not none == appendix {
    pg()
    set heading(numbering: "A", supplement: [Appendix])
    show heading.where(level: 1): it => {
      text(
        size: 24pt,
        block(below: 3cm) + [Appendix ] + counter(heading).display("A") + block(below: 2cm, above: 1.5cm, it.body),
      )
    }
    set page(header: my_header(supplement: [Appendix]))
    counter(heading).update(0)
    let a_len = appendix.len()
    for (i, a) in appendix.enumerate() {
      a()
      if i < a_len - 1 {
        pg()
      }
    }
  }
}

/// ================================================
/// Helper for structuring exploration of problem, possible solutions, and
/// final decision

#let problem(
  problem: content,
  exploration: content,
  solution: content,
  sol_text: none,
) = {
  set par(first-line-indent: (amount: 1.8em, all: true))
  set heading(outlined: false)

  show heading.where(level: 4): it => text(
    size: 12pt,
    weight: "bold",
    v(2em, weak: true) + context h(-1.8em) + it.body + [:],
  )

  show heading.where(level: 3): it => {
    let x = context it.numbering
    text(
      size: 12pt,
      weight: "bold",
      v(2em, weak: true) + context h(-1.8em) + it.body + [:],
    )
  }
  if not problem == none {
    [
      ==== Problem
      #problem
    ]
  }
  [
    #exploration
  ]
  [
    ==== #if sol_text == none { [Design decision] } else { [#sol_text] }
    #solution
  ]
}


