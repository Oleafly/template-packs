#import "../theme.typ": *
#import "../i18n.typ": t

#let outline-style(body) = {
  show outline.entry.where(level: 1): it => {
    v(1em)
    text(font: f-sans-bold, size: 1.2em, fill: c-ink, it)
  }
  body
}

#let index-page(lang: "it") = outline(
  indent: 1.2em,
  title: box(width: 1fr)[#align(right)[#text(
    font: f-sans-bold,
    size: 1.1em,
    fill: c-ink,
  )[#t("index", lang: lang)]]],
  depth: 3,
)
