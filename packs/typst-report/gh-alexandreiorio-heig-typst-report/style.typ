#let font_color = rgb(50, 50, 50)
#let header_and_footer_color = rgb("#afafaf")
#let font = "Segoe UI"
#let raw_font = "Consolas"
#let font_size = 9pt
#let bold_value = "semibold"
#let emphasis_color = rgb("#e0e0e0")
#let raw_inline_color = rgb("#823af5")
#let quote_font_size = 20pt
#let quote_char = text(size: font_size + quote_font_size)[\u{201C}]
#let second_quote_char = text(size: font_size + quote_font_size)[\u{201D}]

#let apply_style(contenu) = {
  set text(font: font, size: font_size, fill: font_color)
  set par(justify: true)
  set quote(block: true)

  show quote: it => [
    #set quote(block: true)
    #block(breakable: false)[
      #align(left)[
        #set text(font: font, fill: rgb("#6d6c6c"), style: "italic")
        #set table(
          stroke: (x, y) => if y == 0 {
            (bottom: 0.7pt + black)
          },
        )
        #table(
          columns: (1.5fr, 16fr, 1fr),
          stroke: (none, (left: 1.8pt + rgb("#6d6c6c")), none),
          align: (left, left, bottom),
          [#quote_char], [#it], [#place(bottom, dy: 1.5em)[#second_quote_char]],
        )
      ]
    ]
  ]

  show raw: it => [
    #let block_width = auto
    #let inset = 0.0em
    #let outset = 0.3em
    #let margin = 0.1em
    #if (it.block) {
      block_width = 100%
      inset = 1em
    }
    #box(
      radius: 0.5em,
      fill: rgb("#e6e6e6"),
      inset: inset,
      outset: outset,
      width: block_width,
    )[
      #set text(font: raw_font)
      #if (it.block and it.lang != none) {
        place(right + top, dy: -1.9em, dx: -1em)[
          #box(
            text(it.lang, size: 6pt, weight: bold_value),
            inset: 0.4em,
            stroke: rgb("#d1d9e0"),
            radius: 0.3em,
            fill: rgb("#ffffff"),
          )
        ]
        it
      } else if (it.lang != none){
        it
      } else {
        text(it, weight: bold_value, fill: raw_inline_color)
      }
    ]
  ]

  set heading(numbering: "1.1.1.1.")

  show heading.where(level: 1): it => [
    #set text(font: font, size: 18pt, weight: bold_value, fill: font_color)
    #it
    #v(1em)
  ]

  show heading.where(level: 2): it => [
    #v(1em)
    #set text(font: font, size: 12pt, weight: bold_value, fill: font_color)
    #it
    #v(0.5em)
  ]

  show heading.where(level: 3): it => [
    #v(1em)
    #set text(font: font, size: 10pt, weight: bold_value, fill: font_color)
    #it
    #v(0.5em)
  ]

  show heading.where(level: 4): it => [
    #v(1em)
    #set text(font: font, size: font_size, weight: bold_value, fill: font_color)
    #it
    #v(0.5em)
  ]

  show strong: it => [
    #set text(font: font)
    #it
  ]

  contenu
}


