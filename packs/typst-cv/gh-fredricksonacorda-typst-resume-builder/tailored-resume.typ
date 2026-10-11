#let gold = rgb("#d8a64a")
#let ink = rgb("#222222")
#let modern-accent = rgb("#2f6f8f")
#let minimal-accent = rgb("#4b4b4b")
#let creative-accent = rgb("#b85c38")
#let academic-accent = rgb("#365c8a")

#let style-config(style) = {
  if style == "modern" {
    (
      accent: modern-accent,
      header-size: 13.8pt,
      role-size: 9.3pt,
      divider-width: 1.2pt,
      section-gap: 0.26em,
      list-indent: 0.75em,
      list-body-indent: 0.38em,
      list-spacing: 0.22em,
      header-fill: rgb("#f5f7f9"),
      header-radius: 3pt,
      header-inset: 6pt,
    )
  } else if style == "minimal" {
    (
      accent: minimal-accent,
      header-size: 13pt,
      role-size: 8.8pt,
      divider-width: 0.8pt,
      section-gap: 0.18em,
      list-indent: 0.6em,
      list-body-indent: 0.28em,
      list-spacing: 0.18em,
      header-fill: white,
      header-radius: 0pt,
      header-inset: 0pt,
    )
  } else if style == "creative" {
    (
      accent: creative-accent,
      header-size: 15pt,
      role-size: 9.2pt,
      divider-width: 1.2pt,
      section-gap: 0.3em,
      list-indent: 0.8em,
      list-body-indent: 0.42em,
      list-spacing: 0.24em,
      header-fill: rgb("#fff7f2"),
      header-radius: 4pt,
      header-inset: 8pt,
    )
  } else if style == "academic" {
    (
      accent: academic-accent,
      header-size: 13.5pt,
      role-size: 8.8pt,
      divider-width: 0.9pt,
      section-gap: 0.24em,
      list-indent: 0.7em,
      list-body-indent: 0.35em,
      list-spacing: 0.2em,
      header-fill: rgb("#f5f8fc"),
      header-radius: 2pt,
      header-inset: 6pt,
    )
  } else {
    (
      accent: gold,
      header-size: 14pt,
      role-size: 10pt,
      divider-width: 1.4pt,
      section-gap: 0.34em,
      list-indent: 0.85em,
      list-body-indent: 0.45em,
      list-spacing: 0.25em,
      header-fill: white,
      header-radius: 0pt,
      header-inset: 0pt,
    )
  }
}

#let resume(
  name: "",
  role: "",
  contact: [],
  style: "classic",
  body,
) = {
  let cfg = style-config(style)

  set document(
    title: name + " Resume",
    author: name,
  )
  set page(
    paper: "a4",
    margin: (x: 0.34in, y: 0.34in),
  )
  set text(
    font: ("Arial", "Helvetica", "Liberation Sans"),
    size: 8.6pt,
    fill: ink,
  )
  set par(
    leading: 0.2em,
    justify: true,
  )
  set list(
    indent: cfg.list-indent,
    body-indent: cfg.list-body-indent,
    spacing: cfg.list-spacing,
  )

  if style == "modern" {
    block(
      fill: cfg.header-fill,
      inset: cfg.header-inset,
      radius: cfg.header-radius,
      width: 100%,
    )[
      #text(size: cfg.header-size, weight: "bold", fill: cfg.accent)[#name]
      #v(0.2em)
      #text(size: cfg.role-size, weight: "bold", fill: ink)[#upper(role)]
      #v(0.16em)
      #text[#contact]
    ]
    v(0.16em)
    line(length: 100%, stroke: cfg.divider-width + cfg.accent)
  } else if style == "minimal" {
    text(size: cfg.header-size, weight: "bold", fill: cfg.accent)[#name]
    v(0.12em)
    text(size: cfg.role-size, weight: "bold", fill: ink)[#upper(role)]
    v(0.08em)
    text[#contact]
    v(0.1em)
    line(length: 100%, stroke: 0.5pt + cfg.accent)
  } else if style == "creative" {
    block(
      fill: cfg.header-fill,
      inset: cfg.header-inset,
      radius: cfg.header-radius,
      width: 100%,
    )[
      #text(size: cfg.header-size, weight: "bold", fill: cfg.accent)[#name]
      #v(0.08em)
      #text(size: cfg.role-size, weight: "bold", fill: ink)[#upper(role)]
      #v(0.08em)
      #text[#contact]
    ]
    v(0.16em)
    line(length: 100%, stroke: 1.2pt + cfg.accent)
  } else if style == "academic" {
    block(
      fill: cfg.header-fill,
      inset: cfg.header-inset,
      radius: cfg.header-radius,
      width: 100%,
    )[
      #text(size: cfg.header-size, weight: "bold", fill: cfg.accent)[#name]
      #v(0.06em)
      #text(size: cfg.role-size, weight: "bold", fill: ink)[#upper(role)]
      #v(0.06em)
      #text[#contact]
    ]
    v(0.12em)
    line(length: 100%, stroke: 0.8pt + cfg.accent)
  } else {
    text(size: cfg.header-size, weight: "bold", tracking: 0.6pt)[#name]
    v(0em)
    text(size: cfg.role-size, weight: "bold", tracking: 0.35pt)[#upper(role)]
    v(0.02em)
    text[#contact]
    v(0.12em)
    line(length: 100%, stroke: cfg.divider-width + cfg.accent)
  }

  body
}

#let section(title, body) = [
  #v(0.34em)
  #text(size: 10.3pt, weight: "bold")[#upper(title)]
  #v(-0.42em)
  #line(length: 100%, stroke: 0.55pt + gold)
  #v(0.12em)
  #body
]

#let cv-entry(title: "", date: "", body) = [
  #text(weight: "bold")[#title]
  #if date != "" [
    #linebreak()
    #date
  ]
  #v(0.08em)
  #body
  #v(0.12em)
]

#let detail-entry(title: "", subtitle: none, date: "", body) = [
  #text(weight: "bold")[#title]
  #if subtitle != none or date != "" [
    #linebreak()
    #if subtitle != none [
      #emph[#subtitle]
    ]
    #if subtitle != none and date != "" [
      #text[ | ]
    ]
    #if date != "" [
      #date
    ]
  ]
  #v(0.08em)
  #body
  #v(0.12em)
]
