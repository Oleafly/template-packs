#import "@preview/touying:0.7.3": *
#import "config.typ": *
#import "theme.typ": *
#import "components.typ": *

#show: deck-theme

#set text(
  font: deck-fonts,
  size: 19pt,
  fill: brand-ink,
  lang: "ja",
)

#set par(justify: false, leading: 0.72em)
#set heading(numbering: none)

#include "content.typ"
