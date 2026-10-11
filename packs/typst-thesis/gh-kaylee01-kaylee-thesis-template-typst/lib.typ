// Kaylee thesis template
// Typst 0.15+

#import "@preview/acrostiche:0.7.0" as acrostiche

// Keep acronym index links visually consistent with surrounding body text.
#let acr(..args) = {
  show link: set text(fill: black)
  acrostiche.acr(..args)
}

#let _heading-text(it) = {
  if it.numbering != none {
    context counter(heading).display(it.numbering)
    h(0.75em)
  }
  it.body
}

#let _running-header() = context {
  let current-page = here().page()
  let chapters = query(selector(heading.where(level: 1)).before(here()))
  let current = if chapters.len() > 0 { chapters.last() } else { none }
  let is-opening-page = query(heading.where(level: 1))
    .any(chapter => chapter.location().page() == current-page)

  block(width: 100%)[
    #grid(
      columns: (1fr, auto),
      rows: (auto, auto),
      row-gutter: 5pt,
      align: (left, right),
      [#if current != none and not is-opening-page {
        numbering(
          current.numbering,
          ..counter(heading).at(current.location()),
        )
        h(0.6em)
        upper(current.body)
      }],
      [#counter(page).display("1")],
      grid.cell(
        colspan: 2,
        line(length: 100%, stroke: 0.4pt),
      ),
    )
  ]
}

#let thesis(
  body,
  paper: "a4",
  margin: 2.5cm,
  font: "New Computer Modern",
  text-size: 12pt,
  line-leading: 0.75em,
  paragraph-spacing: 1.5em,
  heading-numbering: "1.1",
) = {
  set page(paper: paper, margin: margin)
  set text(
    font: font,
    size: text-size,
    lang: "en",
    region: "AU",
  )
  set par(
    justify: true,
    first-line-indent: 0pt,
    leading: line-leading,
    spacing: paragraph-spacing,
  )
  set heading(numbering: heading-numbering)
  set list(spacing: 1em)
  set enum(numbering: "1.a.i.", spacing: 0.35em)
  set table(
    inset: (x: 0.7em, y: 0.5em),
    stroke: (x: none, y: 0.5pt + luma(180)),
    align: left,
  )

  show link: set text(fill: blue)
  show bibliography: set heading(numbering: none, outlined: true)

  show heading: it => block(
    above: 2em,
    below: 1.5em,
  )[
    #_heading-text(it)
  ]

  body
}

#let title-page(
  title: [Your title],
  author: [Name, BSc],
  school: [School of Physics, Mathematics and Computing],
  university: [University of Western Australia],
  degree: [Master of Physics (Medical Physics)],
  supervisors: (),
  date: datetime.today(),
  logo: none,
) = page(
  paper: "a4",
  margin: 2.5cm,
  numbering: none,
  header: none,
  footer: none,
)[
  #align(center)[
    #v(0.8cm)
    #if logo != none {
      logo
      v(0.75cm)
    }

    #text(size: 16pt, weight: "bold")[#title]
    #v(0.5cm)

    #text(size: 12pt)[A thesis by] \
    #text(size: 12pt, weight: "bold")[#author]

    #v(1cm)
    *Submitted to the* \
    #school \
    #university \
    _for the degree of_ \
    #degree

    #v(1cm)
    *Supervised by* \
    #for supervisor in supervisors {
      supervisor
      linebreak()
    }

    #v(1.5cm)
    #date.display("[day] [month repr:long] [year]")
  ]
]

#let front-matter(body) = {
  set page(
    paper: "a4",
    margin: 2.5cm,
    numbering: "i",
    number-align: center + bottom,
    header: none,
  )
  counter(page).update(1)
  body
}

#let front-section(title, body) = {
  heading(level: 1, numbering: none, outlined: false, title)
  body
  pagebreak()
}

#let signature-row(name, role) = [
  #grid(
    columns: (1fr, 3.8cm),
    gutter: 1.2cm,
    [
      #line(length: 100%, stroke: 0.7pt)
      #v(-0.5em)
      #name \
      #role
    ],
    [#line(length: 100%, stroke: 0.7pt)],
  )
]

#let main-matter(body) = {
  set page(
    paper: "a4",
    margin: 2.5cm,
    numbering: none,
    header: _running-header(),
    header-ascent: 20%,
  )
  counter(page).update(1)
  body
}

#let appendices(body, title: [Appendices]) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true, title)
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}

#let sci(coefficient, exponent) = $ #coefficient times 10^#exponent $
#let unit(value) = [#h(0.15em)#value]
#let isotope(mass, element) = [#super(mass)#element]
#let code(value) = raw(value)
