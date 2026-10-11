#let icon-solid-font = "Font Awesome 7 Free Solid"
#let icon-brand-font = "Font Awesome 7 Brands"
#let fa-solid(glyph) = text(font: icon-solid-font, glyph)
#let fa-brand(glyph) = text(font: icon-brand-font, glyph)

#let icons = (
  phone: fa-solid("\u{f095}"),
  mail: fa-solid("\u{f0e0}"),
  linkedin: fa-brand("\u{f08c}"),
  github: fa-brand("\u{f09b}"),
)
