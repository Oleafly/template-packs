#let four-space = sym.space.en + sym.space.en + sym.space.en + sym.space.en

#let cover-first-heading(outlined: false, body) = {
  block(
    width: 100%,
    above: 18pt,
    below: 18pt,
  )[
    #align(center)[
      #text(size: 16pt, weight: "bold")[
        #heading(
          level: 1,
          numbering: none,
          outlined: outlined,
          bookmarked: true,
        )[#body]
      ]]
  ]
}

#let body-first-heading(body) = {
  heading(
    level: 1,
    outlined: true,
    bookmarked: true,
  )[#body]
}

#let running-header(report-title, thesis-title, chapter-title) = context {
  let page-num = counter(page).get().first()
  let odd-page = calc.rem(page-num, 2) == 1
  block(
    width: 100%,
    stroke: (bottom: 0.5pt),
    inset: (bottom: 4.5pt),
  )[
    #text(size: 9pt)[
      #if odd-page [
        #report-title
        #h(1fr)
        #thesis-title
      ] else [
        #chapter-title.get()
        #h(1fr)
        #report-title
      ]
    ]
  ]
}

#let centered-footer() = context {
  let page-num = counter(page).get().first()
  block(width: 100%)[
    #align(
      if calc.rem(page-num, 2) == 1 { right } else { left },
      text(size: 9pt)[#counter(page).display()],
    )
  ]
}

#let render-keywords(label, items) = {
  if items.len() > 0 [
    #par(first-line-indent: 0pt)[
      #text(weight: "bold")[#label]
      #items.join("；")
    ]
  ]
}

#let render-term-list(items) = {
  for item in items [
    #par(first-line-indent: 0pt, hanging-indent: 8em)[
      #text(font: "DejaVu Sans Mono")[#item.term]
      #h(1.2em)
      #item.desc
    ]
  ]
}
