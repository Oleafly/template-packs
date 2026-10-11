#import "template.typ": *
#show: slide_template

#slide(
  ratios: (0pt, 1fr, 0pt),
  is_counted: false,
  [], {
    set align(center)
    stack(
      1fr,
      dir: ttb,
      spacing: 0pt,
      rect(
        inset: 60pt,
        fill: accent_color,
        radius: 60pt,
        [
          #set text(white, 2em)
          Il titolo della
          #linebreak()
          mia Presentazione
        ]
      ),
      2em,
      [
        #set text(1.5em)
        Alessio Marchetti
      ],
      2fr
    )
  }, []
)

#slide_common(
  "Hello World",
  full_rect(color: accent_color)
)

#slide_common_double(
  "Goodbye Moon",
  full_rect(color: accent_color),
  full_rect(color: accent_color),
)

#slide_common(
  "Hello World",
  [
    - #lorem(30)

    - #lorem(30)

    - #lorem(30)
  ]
)
