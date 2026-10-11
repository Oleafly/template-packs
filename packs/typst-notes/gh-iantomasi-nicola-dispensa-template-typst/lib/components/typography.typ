#import "../theme.typ": *

#let typography(lang: "it", body) = {
  set text(font: f-serif, lang: lang, size: 7pt, fill: c-ink, hyphenate: true)
  set par(justify: true, leading: 2.7pt, spacing: 5pt)
  body
}
