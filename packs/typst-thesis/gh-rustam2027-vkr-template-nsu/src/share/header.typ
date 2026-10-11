#import "title-page.typ": title-page

// Document-wide styling, built on top of the "modern-g7-32" package, which
// implements Russian state standard GOST 7.32-2017 formatting. Its built-in
// title page is meant for research reports, not university theses, so it is
// switched off (`hide-title: true`) in favor of the NSU-specific title page
// in `title-page.typ`.
#let template(meta, it) = {
  import "@preview/modern-g7-32:0.2.0": gost, enum-numbering

  show: gost.with(
    hide-title: true,
  )
  set par(spacing: 1.5em, leading: 1.5em)
  show raw.where(block: true): it => {
    set text(size: 12pt)
    set par(spacing: 0.8em, leading: 0.8em)
    it
  }

  set enum(numbering: enum-numbering, spacing: 1.5em)
  set list(spacing: 1.5em)
  set bibliography(style: "gost-r-705-2008-numeric")

  set text(font: "New Computer Modern", lang: "ru", hyphenate: false)

  show figure: it => place(auto, float: true)[#it]

  show table.cell.where(y: 0): it => align(horizon + center)[*#it*]
  show table.cell: it => align(horizon + center)[#it]
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center } else { left }
    ),
  )

  title-page(meta)
  it
}
