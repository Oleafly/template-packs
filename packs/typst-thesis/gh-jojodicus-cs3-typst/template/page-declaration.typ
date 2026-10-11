#import "@preview/datify:1.0.0": custom-date-format

#let declaration-page(
  author,
  submit-date,
  location
) = {
  set page("a4", margin: 20%)
  set text(font: ("Noto Serif", "DejaVu Serif"), fallback: false, size: 9.5pt, weight: "regular")
  set par(justify: true)
  show heading: set block(spacing: 2em)

  [
    #heading(depth: 2, outlined: false)[Erklärung]

    Ich versichere, dass ich die Arbeit ohne fremde Hilfe und ohne Benutzung anderer
    als der angegebenen Quellen angefertigt habe und dass die Arbeit in gleicher oder
    ähnlicher Form noch keiner anderen Prüfungsbehörde vorgelegen hat und von dieser
    als Teil einer Prüfungsleistung angenommen wurde.\
    Alle Ausführungen, die wörtlich oder sinngemäß übernommen wurden, sind als
    solche gekennzeichnet.

    #heading(depth: 2, outlined: false)[Declaration]

    I declare that the work is entirely my own and was produced with no assistance
    from third parties.\
    I certify that the work has not been submitted in the same or any similar form for
    assessment to any other examining body and all references, direct and indirect, are
    indicated as such and have been cited accordingly.
  ]

  set align(horizon)

  [
    (#author)\
    #location, #custom-date-format(submit-date, pattern: "dd. MMMM yyyy", lang: "de")
  ]
}