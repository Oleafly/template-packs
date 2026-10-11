#let chinese-numbers = (
  "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
  "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八",
  "十九", "二十",
)

#let heading-numbering(..nums) = {
  let values = nums.pos()
  if values.len() == 1 {
    [第#chinese-numbers.at(values.at(0) - 1)章]
  } else {
    values.map(str).join(".")
  }
}

#let mainbody(config, body) = {
  set page(
    numbering: "1",
    header: align(center, text(size: config.header-fontsize)[#config.project-title]),
    footer: context align(center, text(size: config.pagenum-fontsize)[#counter(page).display()]),
  )
  counter(page).update(1)

  set heading(numbering: heading-numbering)
  set figure(placement: config.float-figure)
  show figure: set block(above: 15pt, below: 15pt)
  set figure.caption(separator: [ ], position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(size: config.caption-fontsize)
  set math.equation(numbering: "(1)")

  show heading: set block(above: 18pt, below: 12pt)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    align(center, text(
      font: (config.en-heading-font.at(0), config.ch-heading-font.at(0)),
      size: 16pt,
      weight: "bold",
      it,
    ))
  }
  show heading.where(level: 2): it => {
    text(
      font: (config.en-heading-font.at(1), config.ch-heading-font.at(1)),
      size: 14pt,
      weight: "bold",
      it,
    )
  }
  show heading.where(level: 3): it => {
    text(
      font: (config.en-heading-font.at(2), config.ch-heading-font.at(2)),
      size: 12pt,
      weight: "bold",
      it,
    )
  }
  show heading.where(level: 4): it => {
    text(
      font: (config.en-heading-font.at(3), config.ch-heading-font.at(3)),
      size: 12pt,
      weight: "bold",
      it,
    )
  }

  body
  pagebreak()
}
