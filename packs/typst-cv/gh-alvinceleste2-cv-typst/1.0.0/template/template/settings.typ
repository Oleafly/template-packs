#let primary-color = orange // Used for headings and bullets
#let url-color = blue // Used for links and urls inside the document. Should be used with #color-link()

#let settings(cfg, body) = {
  set document(
    title: cfg.author + " ~ CV",
    author: cfg.author,
    date: auto,
  )

  set page(
    paper: "a4",
    margin: (x: 2cm, top: 2cm, bottom: 2cm),
    numbering: "1",
  )

  set par(
    justify: true,
    leading: 0.6em,
    spacing: 0.6em,
  )

  set text(
    lang: cfg.lang,
    font: "Source Sans Pro",
    size: 10.5pt,
  )

  show heading: it => {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: bottom,
      text(size: 0.85em, weight: "bold", fill: primary-color)[#smallcaps(
        it.body,
      )],
      line(length: 100%, stroke: primary-color),
    )
  }
  show heading: set block(below: 0.6em, above: 0.6em)

  set list(marker: [#text(fill: primary-color)[•]])
  show list.item: set text(size: 0.95em)

  show par: it => {
    pad(left: 1em, right: 0.3em)[#it.body]
  }

  body
}
