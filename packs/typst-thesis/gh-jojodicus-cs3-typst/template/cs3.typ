#import "thesis-type.typ": *
#import "page-declaration.typ": *
#import "page-detail.typ": *
#import "page-contents.typ": *
#import "page-title.typ": *

#import "@preview/datify:1.0.0": custom-date-format

#let cs3-thesis(
  author: "Namus Namerich",
  author-birthday: datetime(year: 1970, month: 1, day: 1),
  author-birthplace: "Erlangen",
  title: [Scalable, Fault-Tolerant AI Architectures for Edge-Driven Inference],
  thesis-type: "master",
  program: "Informatik",
  start-date: datetime(year: 2000, month: 1, day: 1),
  submit-date: datetime.today(),
  supervisor: "Dipl.-Inf. Marc Reichenbach",
  professor: "Prof. Dr.-Ing. Dietmar Fey",
  location: "Erlangen",
  abstract: none,
  bib: none,
  appendix: none,
  body
) = {
  set document(title: title, author: author, date: submit-date)

  title-page(author, title, thesis-type, program, start-date, submit-date)

  detail-page(
    author, author-birthday, author-birthplace,
    title, thesis-type, program, start-date, submit-date,
    supervisor, professor
  )

  declaration-page(author, submit-date, location)

  // formatting for the rest of the document
  set page("a4", margin: (x: 20%, y: 15%))
  set text(font: ("Noto Serif", "DejaVu Serif"), fallback: false, size: 10pt, weight: "regular")
  show heading: set block(spacing: 2em)
  show heading.where(depth: 1): it => {
    pagebreak(weak: true)
    line(start: (-5%, 0%), length: 110%, stroke: 0.5pt)
    it
    line(start: (-5%, 0%), length: 110%, stroke: 0.5pt)
    set block(spacing: 1.5em)
  }
  set par(
    first-line-indent: 2em,
    spacing: 0.65em,
    justify: true,
  )

  if (abstract != none) {
    heading(depth: 2, outlined: false)[Abstract]

    if (type(abstract) == str) {
      include abstract
    } else {
      abstract
    }
  }

  set table(
    stroke: (x, y) => (
      left: if x == 0 { none } else { 0.4pt },
      right: none,
      top: if y == 0 { none } else { 0.4pt },
      bottom: none,
    )
  )

  set figure(gap: 1em)
  show figure: set block(spacing: 2em)
  show figure.caption: it => [
    *#it.supplement
    #context it.counter.display(it.numbering)* -
    #it.body
  ]
  set math.equation(numbering: "(1)", supplement: none)
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.target)[(#it)]
    } else {
      it
    }
  }


  set outline.entry(fill: repeat([.], gap: 0.5em))
  show outline.entry: set block(above: 1em)
  contents-page()

  // number heading from here on out
  set heading(numbering: "1.")
  set page(numbering: none, footer: context {
    let chapter-on-page = query(heading.where(level: 1)).any(h => h.location().page() == here().page())
    if chapter-on-page {
      align(center, counter(page).display("1"))
    }
  }, header: context {
    let nextheadings = query(selector(heading.where(level: 1)).after(here()))
    if nextheadings.len() == 0 { return }
    let onpage = nextheadings.first().location().page()

    if here().page() == onpage {
      return
    }

    let select = selector(heading.where(level: 1)).before(here())
    let level = counter(select)
    let headings = query(select)

    if headings.len() == 0 {
      return
    }

    let heading = headings.last()

    [
      #level.display().
      #heading.body
      #h(1fr)
      #counter(page).display("1")
      #line(length: 100%, stroke: 0.5pt)
    ]
  })
  counter(page).update(1)

  // the thesis
  body

  set heading(numbering: none)

  set page(header: none, footer: align(center, context counter(page).display("1")))
  context {
    let imagefigures = figure.where(kind: image)
    if query(imagefigures).len() > 0 {
      heading(level: 1, "List of Figures")
      outline(target: imagefigures, title: none)
    }

    let tablefigures = figure.where(kind: table)
    if query(tablefigures).len() > 0 {
      heading(level: 1, "List of Tables")
      outline(target: tablefigures, title: none)
    }
  }

  if bib != none {
    bibliography(bib)
  }

  if appendix != none {
    heading[Appendix]
    counter(heading).update(1)
    set heading(numbering: "A.1")
    include appendix
  }
}
