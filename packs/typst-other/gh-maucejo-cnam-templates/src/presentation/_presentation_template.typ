#import "../common/_deps.typ": *
#import "_slides.typ": *
#import "../common/_colors.typ": *

#let cnam-presentation(
  composante: "cnam",
  color-set: theme-red,
  ..args,
  body
) = {
  show: touying-slides.with(
    config-info(
      title: none,
      subtitle: none,
      author: none,
      over-title: none,
      facade: "image"
    ),

    config-page(
      paper: "presentation-16-9",
      header-ascent: 30%,
      footer-descent: 30%,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),

    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),

    config-methods(
      init: (self: none, body) => {
        let colors = theme-red + color-set
        set text(fill: colors.blue, font: "Raleway", size: 20pt, lang: "fr", ligatures: false)
        set par(justify: true)

        body
      }
    ),

    config-store(
      align: align,
      colors: theme-red + color-set,
      color-theme-name: color-set.name,
      composante: composante,
      title-logo-height: 8%,
      logo: image("../resources/logo/" + composante + ".png"),
    ),
    ..args,
  )

  set heading(numbering: "1.")

  body
}