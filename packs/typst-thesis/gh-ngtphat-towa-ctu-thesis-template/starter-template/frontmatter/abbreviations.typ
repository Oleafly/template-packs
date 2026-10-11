#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#heading(level: 1, numbering: none, outlined: true)[#term(lang, "abbreviations_title")]
#v(1cm)
#set align(left)
#set par(first-line-indent: 0cm)

#table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  inset: (x: 8pt, y: 12pt),
  [*#term(lang, "abbreviations_term")*], [*#term(lang, "abbreviations_desc")*],
  ..data.abbreviations.flatten()
)
#pagebreak()
