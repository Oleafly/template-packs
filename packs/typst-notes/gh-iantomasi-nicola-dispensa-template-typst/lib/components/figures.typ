#import "../theme.typ": *
#import "../i18n.typ": t

#let figure-style(lang: "it", body) = {
  show image: it => box(radius: 6pt, clip: true, it)

  set figure(gap: 5pt, supplement: t("figure-supplement", lang: lang))
  set figure.caption(separator: [: ])
  show figure.caption: set text(
    font: f-mono,
    size: 5pt,
    fill: c-gray,
    tracking: 0.02em,
  )

  body
}
