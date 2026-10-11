// Typst template that approximates `bukai-template.docx`.

#let bukai-blue-1 = rgb("#365F91")
#let bukai-blue-2 = rgb("#4F81BD")
#let bukai-title-top = rgb("#1F497D")
#let bukai-title-bottom = rgb("#00B050")
#let bukai-title-text = rgb("#243F60")
#let bukai-body-indent = state("bukai-body-indent", 1em)

#let horizontal_rule(weight, color) = rect(
  width: 100%,
  height: weight,
  fill: color,
  stroke: none,
)

#let heading_style_1(it) = block(
  width: 100%,
  above: 1.4em,
  below: 0.8em,
)[
  #stack(
    dir: ttb,
    spacing: 0.3em,
    [
      #set par(first-line-indent: 0em)
      #set text(
        size: 12pt,
        weight: "bold",
        fill: bukai-blue-1,
      )
      #it.body
    ],
    horizontal_rule(1.5pt, bukai-blue-1),
  )
  #bukai-body-indent.update(0em)
]

#let heading_style_2(it) = block(
  width: 100%,
  above: 1.4em,
  below: 0.9em,
  inset: (left: 1em),
)[
  #stack(
    dir: ttb,
    spacing: 0.3em,
    [
      #set par(first-line-indent: 0em)
      #set text(
        size: 11.5pt,
        weight: "bold",
        fill: bukai-blue-1,
      )
      #it.body
    ],
    horizontal_rule(1.0pt, bukai-blue-2),
  )
  #bukai-body-indent.update(1em)
]

#let heading_style_3(it) = block(
  width: 100%,
  above: 0.7em,
  below: 0.7em,
  inset: (left: 2em),
)[
  #stack(
    dir: ttb,
    spacing: 0.3em,
    [
      #set par(first-line-indent: 0em)
      #set text(
        size: 11pt,
        weight: "bold",
        fill: bukai-blue-1,
      )
      #it.body
    ],
    horizontal_rule(0.6pt, bukai-blue-1),
  )
  #bukai-body-indent.update(2em)
]

#let body_par_style(it) = context {
  let left = bukai-body-indent.get()
  block(
    width: 100%,
    inset: (left: left),
  )[
    #h(1em)
    #it.body
  ]
}

#let bukai_setup(
  body,
  font-stack: (
    "Meiryo",
    "Hiragino Sans",
    "Yu Gothic",
    "Noto Sans CJK JP",
    "Noto Sans JP",
    "MS Gothic",
  ),
  text-size: 11pt,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 25.4mm,
      right: 19.05mm,
      bottom: 25.4mm,
      left: 19.05mm,
    ),
    header-ascent: 15.0mm,
    footer-descent: 17.5mm,
  )

  set text(
    lang: "ja",
    font: font-stack,
    size: text-size,
  )

  set par(justify: true, leading: 0.75em)

  set heading(numbering: none)
  show heading.where(level: 1): heading_style_1
  show heading.where(level: 2): heading_style_2
  show heading.where(level: 3): heading_style_3
  show par: body_par_style

  body
}

#let title_block(title) = block(
  width: 100%,
  below: 0.8em,
  inset: (top: 10pt, bottom: 15pt),
  stroke: (
    top: 1.0pt + bukai-title-top,
    bottom: 3.0pt + bukai-title-bottom,
  ),
)[
  #set par(first-line-indent: 0em)
  #align(center)[
    #set text(
      size: 26pt,
      fill: bukai-title-text,
    )
    #v(0.3em)
    #title
    #v(0.3em)
  ]
]

#let signature_line(affiliation: "", name: "") = align(right)[
  #set par(first-line-indent: 0em)
  #set text(size: 11pt)
  #if affiliation != "" and name != "" [
    #affiliation　#name
  ] else if affiliation != "" [
    #affiliation
  ] else [
    #name
  ]
]
