#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": (leipzig-footer, leipzig-header, list-marker)
#import "slides.typ": *

// The Leipzig corporate-design Touying theme.
//
// Usage:
// ```typst
// #import "leipzig-typst.typ": *
// #show: leipzig-theme.with(
//   config-info(title: [...], subtitle: [...], author: [...], ...),
// )
// ```
#let leipzig-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 2.4em, bottom: 2em, x: 2em),
      header: leipzig-header,
      footer: leipzig-footer,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: intermission,
      // The SPEC wants body text black; keep bold text black instead of
      // routing it through the (red) alert colour.
      show-strong-with-alert: false,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(
          font: font-family,
          size: body-size,
          fill: LeipzigSchwarz,
          lang: "de",
        )
        set par(leading: line-leading)
        set list(marker: list-marker)
        // Aufzählung ab 2. Ebene: 16pt (nested lists are rendered smaller).
        show list: it => {
          show list: set text(size: nested-list-size)
          it
        }
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      neutral: LeipzigBasalt,
      neutral-light: LeipzigHellgrau,
      neutral-lightest: LeipzigWeiss,
      neutral-darkest: LeipzigSchwarz,
      primary: LeipzigGranat,
      primary-light: LeipzigKarneol,
      secondary: LeipzigAquamarin,
      tertiary: LeipzigOrange,
    ),
    config-store(),
    ..args,
  )

  body
}
