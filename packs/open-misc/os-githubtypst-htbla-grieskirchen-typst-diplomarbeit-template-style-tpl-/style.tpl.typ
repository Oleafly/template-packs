#let base-style(doc) = context {
  set page(paper: "a4", margin: (
    top: 2.5cm,
    left: 3.5cm,
    right: 2.5cm,
    bottom: 2cm,
  ))

  set text(
    font: "Calibri",
    lang: "de",
    size: 11pt,
  )

  doc
}

#let format-table(it) = [
  #set block(spacing: 1.5em)
  #it
]

#let main-style(doc) = context {
  let current-top-heading = state("da-cth", none)
  let header = context [
    #align(right, {
      let cur-heading = current-top-heading.at(query(selector(<footer>).after(here())).first().location())
      let cur-heading-body = if cur-heading != none {
        cur-heading.body
      } else {
        "Placeholder"
      }
      let render-content = {
        set text(size: 10pt, weight: "bold")
        underline(underline(cur-heading-body), offset: 0.3em)
      }
      if cur-heading != none {
        render-content
      } else {
        hide(render-content)
      }
    })
    #line(length: 100%)
    #v(0.5em)
  ]
  let footer = context [
    #set text(size: 10pt)
    #set par(leading: 0pt, spacing: 0pt)
    #v(1em)
    #line(length: 100%) <footer>

    #document.title
    #h(1fr)
    Seite #counter(page).display()
  ]
  set page(header: header, header-ascent: 0cm)
  set page(footer: footer, footer-descent: 0cm)
  let target-margin = page.margin
  set page(margin: (
    ..target-margin,
    top: target-margin.top + measure(header).height,
    bottom: target-margin.bottom + measure(footer).height,
  ))

  set heading(numbering: "1.1")
  show heading: it => context block[
    #box(width: 1.75cm, clip: true, counter(heading).display())
    #it.body
  ]
  show heading.where(level: 1): it => {
    colbreak(weak: true)
    current-top-heading.update(it)
    it
  }
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set text(size: 12pt)
  show heading.where(level: 4): set text(size: 11pt)

  show emph: it => text(weight: "bold", style: "italic", it.body)
  show strong: it => text(weight: "bold", it.body)

  show par: set text(top-edge: 1em, bottom-edge: 0em)
  set par(
    leading: 0.5em,
    spacing: 1em,
    justify: true,
  )

  set table(fill: (x, y) => if y == 0 { gray })
  show table.cell.where(y: 0): strong
  show table.cell.where(y: 0): set text(size: 12pt)
  show table: format-table

  doc
}

#let additional-sections-style(doc) = context {
  let current-top-heading = state("da-cth", none)
  set heading(numbering: none)
  show heading: it => align(right)[#it.body]
  show heading.where(level: 1): it => {
    colbreak(weak: true)
    current-top-heading.update(it)
    it
  }

  doc
}