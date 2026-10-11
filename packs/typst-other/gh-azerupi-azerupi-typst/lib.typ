#let project_empty(body) = {
  set text(font: "Roboto", size: 10pt)

  body
}

#let project_long(cover: none, body) = {
  cover
  pagebreak(weak: true)

  set page(margin: (x: 30mm, top: 35mm, bottom: 50mm))

  /****************************************************************************
   *                                Headings
   *
   ****************************************************************************/
  show heading: set text(font: "Roboto")
  set heading(numbering: "1.1")

  show heading: set block(below: 10mm, above: 15mm)

  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)
  show heading.where(level: 4): set text(size: 12pt)

  show heading.where(level: 5): set text(size: 11pt)
  show heading.where(level: 5): set heading(numbering: none)

  show heading.where(level: 6): set text(size: 9pt)
  show heading.where(level: 6): set heading(numbering: none)


  /****************************************************************************
   *                                Chapters
   *
   * Chapters start with a huge number, flushed to the right, followed by the
   * chapter title on the next line.
   ****************************************************************************/
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set align(right)

    v(20mm)
    if it.numbering != none {
      set heading(supplement: "Chapter")
      set text(weight: "thin", size: 96pt)
      block(below: 0mm, context { counter(heading).display("1") })
    }

    set text(size: 24pt, weight: "bold")
    block(below: 25mm, it.body)
  }

  /****************************************************************************
   *                                Paragraphs
   *
   * Paragraphs have text that is slightly lighter than pure black.
   ****************************************************************************/
  show par: set text(font: "libertinus serif", fill: luma(15%))
  set par(justify: true)

  show list: set text(font: "libertinus serif", fill: luma(15%))
  show enum: set text(font: "libertinus serif", fill: luma(15%))

  /****************************************************************************
   *                                Lists
   *
   ****************************************************************************/
  set enum(numbering: "1.1", full: true)

  /****************************************************************************
   *                                Outline
   *
   ****************************************************************************/
  show outline.entry.where(level: 1): it => {
    set text(font: "Roboto", weight: "bold")

    let inner = {
      it.body()
      h(1fr)
      it.page()
    }

    block(
      above: 5mm,
      link(
        it.element.location(),
        it.indented(it.prefix(), inner),
      ),
    )
  }

  body
}

#let project_short(body) = {
  show: project_empty.with()

  body
}
