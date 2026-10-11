#let currentH(level: 1) = context {
  let current-page = here().page()

  let headings-on-page = query(
    selector(heading.where(level: level))
  ).filter(
    heading => heading.location().page() == current-page
  )

  if headings-on-page.len() > 0 {
    headings-on-page.first().body
  } else {
    let previous-headings = query(
      selector(heading.where(level: level)).before(here())
    )

    if previous-headings.len() > 0 {
      previous-headings.last().body
    } else {
      none
    }
  }
}

#let setup-layout(body) = {
  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
    ),

    numbering: none,

    header: context {
      set text(
        font: "Arial",
        size: 9pt,
      )

      grid(
        columns: (1fr, auto),
        column-gutter: 1cm,

        currentH(level: 1),

        counter(page).display("1"),
      )

      v(3pt)

      line(
        length: 100%,
        stroke: 0.5pt,
      )
    },
  )

  set text(
    font: "Arial",
    size: 11pt,
    lang: "de",
  )

  set par(
    justify: true,
    leading: 1em,
  )

  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    set block(
      above: 1.4em,
      below: 1.2em,
    )
    it
  }

  show heading.where(level: 2): it => {
    set block(
      above: 1.2em,
      below: 1em,
    )
    it
  }

  show heading.where(level: 3): it => {
    set block(
      above: 1em,
      below: 0.8em,
    )
    it
  }

  set cite(
    style: "styles/ieee.csl",
  )

  show figure.caption: set text(
    size: 8pt,
    weight: "bold",
  )

  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(94%),
    inset: 12pt,
    radius: 4pt,
  )
  
  body
}