#let title(content) = {
    set text(
        size: 20pt,
        weight: "bold"
    )
    [
        #figure(
            placement: top,
            scope: "parent",
            kind: "title",
            supplement: none,
            [#align(center)[#content]],
        )
    ]
}
#let entitle(content) = {
    set text(
        size: 17pt,
        weight: "semibold"
    )
    [
        #figure(
            placement: top,
            scope: "parent",
            kind: "title",
            supplement: none,
            [#align(center)[#content]],
        )
    ]
}

#let author(content) = {
    set text(
        size: 14pt,
        weight: "semibold"
    )
    [
      #figure(
        placement: top,
        scope: "parent",
        kind: "title",
        supplement: none,
        [#align(center)[#content]],
      )
    ]
}



#let template(
  header: [header],
  doc
  ) = {
  set text(
    font: (
      "Liberation Sans",
      "Times New Roman",
      "Bitstream Vera Sans",
      "Yu Gothic",
    ),
    size: 11pt
  )

  set page(
    columns: 2,
    header: header,
    paper: "a4",
    margin: (
      bottom: 1.75cm, top: 2.5cm,
      left: 2cm, right: 2cm
    ),
  )

  set par(leading: 0.85em, spacing:0.85em, first-line-indent: 1em, justify: true)

  show link: underline
  show link: set text(fill: rgb("#125ee0"))

  set enum(indent:1em)
  set list(indent:1em)

  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  show math.equation: set text(
    font:(
      "New Computer Modern Math",
      "DejaVu Sans",
      "Yu Gothic",
    )
  )

  show figure.where(
    kind:table
  ): set figure(supplement: "表")
  show figure.where(
    kind:image
  ): set figure(supplement: "図")
  set math.equation(numbering: numbering.with("(1.1)"), supplement: "式")


  set heading(numbering: "1.1.1.1")

  show heading.where(level: 1): set text(
    weight: "bold",
    size: 13pt
  )

  show heading.where(level: 2): set text(
    weight: "semibold",
    size: 12pt
  )

  show heading.where(level: 3): set text(
    weight: "semibold",
    size: 11pt
  )

  show heading.where(level: 4): set text(
    weight: "semibold",
    size: 11pt
  )

  show heading: it => {
    it
    par(text(size: 0pt, ""))
    v(-0.5em)
  }
  set page(numbering: "1 / 1")

  doc

}
