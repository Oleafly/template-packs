#import "../common/_colors.typ": *
#import "../common/_utils.typ": *

#let title-page(config-titre) = {

  let logo-height = 4.08cm
  let decx = 1.5cm
  let decy = -1.45cm
  if config-titre.composante != "cnam" {
    logo-height = 10cm
    decx = 1.5cm
    decy = -2cm
  }

  let box-width = 119%
  let box-height = 111%
  if config-titre.alignement == "center" {
    box-width = 107%
    box-height = 95%
    decx = 0.8cm
  }

  let tbox = box(fill: primary.light-blue.lighten(60%), width: box-width, height: box-height)[
    #set text(font: "Raleway", fill: primary.dark-blue)

    #config-titre.titre
  ]

  place(dx: -0.5cm, tbox)

  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    [#place(top+left, dx: -0.85cm, dy: -1.45cm, over-title(title: config-titre.surtitre, size: 20pt, color: primary.dark-blue))], [#place(right, dx: decx, dy: decy, image("../resources/logo/" + config-titre.composante + ".png", width: logo-height))]
  )

  if config-titre.alignement == "center" {
    if config-titre.logo != none {
      set image(height: 1.75cm)
      if type(config-titre.logo) == content {
        place(bottom + right, dy: 1.5cm, config-titre.logo)
      } else {
        let im-grid = {
          grid(
            columns: config-titre.logo.len(),
            column-gutter: 1cm,
            align: right+ horizon,
            ..config-titre.logo.map((logos) => logos)
          )
        }

        place(bottom + right, dy: 1.5cm, im-grid)
      }
    }
  }

  pagebreak()
}

// #let create_dict(default-dict, user-dict) = {
//   let new-dict = default-dict
//     for (key, value) in user-dict {
//       if key in default-dict.keys() {
//         new-dict.insert(key, value)
//       }
//     }

//   return new-dict
// }