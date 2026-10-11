// report theme
#let title_color = rgb("#1E3778")
#let body_color = rgb("#111111")
#let soft_color = rgb("#666666")

#let body_font = "Times New Roman"
#let mono_font = "Consolas"

// code block helper
#let codeblock(lines) = block(
  width: 100%,
  fill: rgb("#F7F7F7"),
  stroke: 0.6pt + rgb("#D6D6D6"),
  inset: 10pt,
  radius: 4pt,
)[
  #set text(font: mono_font, size: 9.5pt)
  #set par(justify: false, first-line-indent: 0em)

  #for (i, line) in lines.enumerate() [
    #grid(
      columns: (2em, 1fr),
      gutter: 0.8em,
      [
        #align(right)[
          #text(fill: soft_color)[#(i + 1)]
        ]
      ],
      [#line],
    )
  ]
]
