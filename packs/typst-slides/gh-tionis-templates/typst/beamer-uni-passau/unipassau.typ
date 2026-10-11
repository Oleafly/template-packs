// Inofficial Universitat Passau Typst beamer-style template.
// Ported from the LaTeX beamer theme by Philipp Jovanovic.

#let up-orange = rgb("#f29400")
#let up-grey = rgb("#999f9e")
#let up-jura = rgb("#e53138")
#let up-phil = rgb("#bc2a33")
#let up-wiwi = rgb("#006039")
#let up-fim = rgb("#005aa1")
#let ui-dark-grey = rgb("#7d7d7d")
#let ui-black = rgb("#000000")

#let colors = (
  orange: up-orange,
  grey: up-grey,
  jura: up-jura,
  phil: up-phil,
  wiwi: up-wiwi,
  fim: up-fim,
  dark-grey: ui-dark-grey,
  black: ui-black,
)

#let _content(value) = if value == none { [] } else { value }

#let _footer-numbering() = context counter(page).display("1 / 1", both: true)

#let up-block(title: none, body) = {
  if title != none {
    text(fill: up-orange)[#title]
    linebreak()
  }
  body
}

#let up-caption(kind: [Figure], body) = {
  align(center)[
    #text(size: 9pt, fill: up-orange)[#kind:] #text(size: 9pt)[#body]
  ]
}

#let unipassau(
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  short-title: none,
  style: "std",
  logo: image("assets/logo.pdf", width: 30mm),
) = {
  let is-std = style == "std" or style == "standard"
  let is-min = style == "min" or style == "minimal"
  assert(is-std or is-min, message: "style must be \"std\" or \"min\"")

  let footer-title = if short-title == none { title } else { short-title }
  let title-style = if is-std { "italic" } else { "normal" }
  let logo-top = if is-std { 5.5mm } else { 2.5mm }

  let place-logo() = {
    place(top + right, dx: -4.5mm, dy: logo-top, logo)
  }

  let footer() = {
    if is-std {
      place(bottom + left, dx: 4mm, dy: -5.8mm)[
        #line(length: 119.7mm, stroke: 0.25pt + ui-dark-grey)
      ]
    }

    place(bottom + left, dx: 12.5mm, dy: -1.6mm)[
      #box(width: 103mm)[
        #grid(
          columns: (1fr, 1fr, 1fr),
          column-gutter: 0pt,
          align(left)[#text(size: 7pt, fill: ui-dark-grey)[#_content(footer-title)]],
          align(center)[#text(size: 7pt, fill: ui-dark-grey)[#_content(author)]],
          align(right)[#text(size: 7pt, fill: ui-dark-grey)[#_footer-numbering()]],
        )
      ]
    ]
  }

  let frame-title(frame-title, frame-subtitle) = {
    place(top + left, dx: 5mm, dy: 4.4mm)[
      #text(size: 14pt, fill: ui-dark-grey, style: title-style)[#_content(frame-title)]
    ]

    if frame-subtitle != none {
      place(top + left, dx: 5mm, dy: 11.8mm)[
        #text(size: 8pt, fill: ui-dark-grey)[#frame-subtitle]
      ]
    }

    if is-std {
      place(top + left, dx: 4mm, dy: 12.2mm)[
        #line(length: 83mm, stroke: 0.25pt + ui-dark-grey)
      ]
    }
  }

  let setup(body) = {
    set page(width: 128mm, height: 96mm, margin: 0pt)
    set text(font: "Latin Modern Sans", size: 11pt, fill: ui-black)
    set par(leading: 0.55em)
    set list(marker: text(fill: up-orange)[▶], spacing: 0.35em)
    set enum(numbering: (..nums) => text(fill: up-orange)[#numbering("1.", ..nums)], spacing: 0.35em)
    show link: set text(fill: up-orange)

    body
  }

  let title-slide() = {
    pagebreak(weak: true)
    place-logo()

    v(28mm)
    align(center)[
      #text(size: 14pt, fill: up-orange)[#_content(title)]

      #if subtitle != none {
        v(2.6mm)
        text(size: 10pt, fill: ui-dark-grey)[#subtitle]
      }

      #if author != none {
        v(9mm)
        text(size: 10pt, fill: ui-dark-grey)[#author]
      }

      #if institute != none {
        v(6.2mm)
        text(size: 8.2pt, fill: ui-dark-grey)[#institute]
      }

      #if date != none {
        v(7.2mm)
        text(size: 11pt, fill: ui-dark-grey)[#date]
      }
    ]
  }

  let slide(title: none, subtitle: none, body) = {
    pagebreak(weak: true)
    place-logo()
    frame-title(title, subtitle)
    footer()

    v(30mm)
    pad(left: 10mm, right: 9mm)[#body]
  }

  (
    setup: setup,
    title-slide: title-slide,
    slide: slide,
  )
}
