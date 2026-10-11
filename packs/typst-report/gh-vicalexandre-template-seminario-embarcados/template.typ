#let presentation(title: "", authors: (), logo: none, body) = {
  import "@preview/touying:0.6.1": *
  import themes.simple: *

  if logo == none {
    logo = "assets/image2.png"
  }

  let light-blue = rgb("#45A8C0")
  let dark-text = rgb("#2B406F")

  let bottom-left-image = "assets/image1.png"
  let bottom-right-image = "assets/image2.png"
  let footer = grid(columns: (3fr, auto, 3fr),
                    align(left, image(bottom-left-image, height: 150%)),
                    [],
                    align(right, image(bottom-right-image, height: 128%)),)

  show: simple-theme.with(
    aspect-ratio: "16-9",
    background: light-blue,
    footer: self => {
      context {    
        if utils.slide-counter.display() != "1" {
          place(scope: "column", dy: -10pt, float: true, bottom, footer)
        }
      }
    },
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(font: body-font, lang: "en", size: 22pt, fill: dark-text)
  show heading: set text(font: sans-font)

  slide(
    [
      #align(center + horizon)[
        #v(1fr)

        #image(logo, width: 42%)
        #v(4.5fr)

        #text(font: sans-font, 2.5em, weight: 720, title)
        #v(2.5fr)

        #grid(
          columns: (auto,) * calc.min(3, authors.len()),
          gutter: 1.5em,
          ..authors.map(author => align(center)[
            *#author.name* \
            #author.email
          ])
        )

        #v(2.5fr)
      ]
    ]
  )
  body
}
