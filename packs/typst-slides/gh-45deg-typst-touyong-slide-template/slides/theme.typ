#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "config.typ": *

#let deck-theme = simple-theme.with(
  aspect-ratio: "16-9",
  footer: deck-footer,
  primary: brand-primary,
)

#let deck-fonts = ("BIZ UDPGothic", "Hiragino Sans", "Arial Unicode MS")
