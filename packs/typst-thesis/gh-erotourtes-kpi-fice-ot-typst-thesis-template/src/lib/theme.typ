#import "lib.typ": body_par_indent, body_par_leading, body_text_size, font_main

#let bibliography_title = [Список використаних джерел]
#let bibliography_style = "gost-r-705-2008-numeric"

#let document_text_rules(body) = {
  set text(font: font_main, body_text_size)
  set par(
    justify: true,
    leading: body_par_leading,
    first-line-indent: (
      amount: body_par_indent,
      all: true,
    ),
  )
  set table(align: top + center)
  set list(spacing: 0pt)
  set enum(spacing: 0pt)
  show table.cell: it => {
    set par(justify: false)
    it
  }
  body
}

#let figure_caption_rules(body) = {
  set figure.caption(separator: [ --- ])

  show figure.where(kind: image): set figure(
    supplement: [Рисунок],
    gap: 14pt,
  )
  show figure.where(kind: image): set block(breakable: false)

  show figure.where(kind: table): set figure(
    supplement: [Таблиця],
  )
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    set block(breakable: true)
    it
  }
  show figure.caption.where(kind: table): it => block(
    sticky: true,
    width: 100%,
    inset: (left: body_par_indent),
  )[
    #align(left)[
      #it
    ]
  ]
  body
}

#let document_theme_rules(body) = {
  figure_caption_rules(document_text_rules(body))
}

#let bibliography_section(
  sources,
  title: bibliography_title,
  style: bibliography_style,
  full: false,
) = [
  #heading(numbering: none)[#title]
  #bibliography(
    sources,
    title: none,
    style: style,
    full: full,
  )
]

#let code(it, stroke: 0.6pt + rgb("#d0d0d0"), inset: (x: 8pt, y: 6pt)) = block(
  stroke: stroke,
  inset: inset,
  radius: 3pt,
)[
  #set text(
    font: (
      "Hack Nerd Font Mono",
      "JetBrainsMono NFM",
    ),
    size: 11pt,
  )
  #set par(leading: 0.9em)
  #it
]
