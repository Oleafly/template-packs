// Pieces shared by the brochure and the slide templates.
#import "colors.typ": tub-rgb, tub-cmyk, resolve-theme

// The slant of every diagonal edge, as a fraction of the page height.
#let slant = 4%

#let config = state("tubci-config", (
  palette: tub-rgb,
  theme: "blue-green",
  lang: "de",
  format: none,
  footer: none,
  sublogo: none,
))

/// The TU Berlin logo. `kind` is "long" (with wordmark) or "short".
#let tub-logo(kind: "long", width: auto) = {
  let defaults = (long: 50mm, short: 22.4mm)
  let width = if width == auto { defaults.at(kind) } else { width }
  image("../assets/logo-" + kind + ".svg", width: width, alt: "Technische Universität Berlin")
}

// The fill for `theme`, falling back to the document theme on `auto`.
#let theme-fill(cfg, theme) = resolve-theme(if theme == auto { cfg.theme } else { theme }, cfg.palette)

// A page-wide band from `y0` down to `y1` (measured at the right edge).
// Slanted edges sit `rise` lower on the left, so they climb to the right.
#let band(fill, y0, y1, slant-top: false, slant-bottom: false) = context {
  let rise = slant * page.height
  place(top + left, dy: y0, polygon(
    fill: fill,
    (0pt, if slant-top { rise } else { 0pt }),
    (page.width, 0pt),
    (page.width, y1 - y0),
    (0pt, y1 - y0 + if slant-bottom { rise } else { 0pt }),
  ))
}

// Fits `picture` (usually an `image(..)`) into a box, cropping the overflow.
#let cover(picture, width, height) = block(width: width, height: height, clip: true, {
  set image(width: 100%, height: 100%, fit: "cover")
  picture
})
