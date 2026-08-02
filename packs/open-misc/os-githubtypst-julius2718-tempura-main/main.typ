
#let sans(it, font: ("Hiragino Sans", "BIZ UDPGothic", "Noto Sans JP",)) = {
  text(font: font)[
    #it
  ]
}

#let gtheading(
  it, font: ("Helvetica", "Noto Sans JP", "BIZ UDPGothic", "Hiragino Sans"),
) = {
  text(sans(font: font)[#h(-1em) *#it* #h(1em)])
}

#let signature(title: "", date: "", author: "", titlefont: "Noto Sans JP") = {
  align(
    center, text(
      1.5em, font: (titlefont, "Hiragino Sans", "BIZ UDPGothic"), weight: "semibold",
    )[
      #title
    ],
  )
  v(0.25em)
  align(center, text(1em)[
    #date
    #v(0.3em)
    #author
  ])
  v(0.3em)
}

#let itm_label(name) = place[#figure(supplement: [])[]#label(name)]

#let jpdoc(
  doc, textfont: "Noto Serif JP", mathfont: "STIX Two Math", headfont: "Noto Sans JP",
) = {
  set text(
    font: (textfont, "Hiragino Mincho ProN", "BIZ UDPMincho",), size: 10.5pt,
  )
  show math.equation: set text(font: (mathfont, "STIX Two Math"))
  show raw: set text(font: "Osaka", size: 1.4em)
  show figure.where(kind: table): set figure.caption(position: top)

  set heading(numbering: "1.")

  set page(margin: 1in, numbering: "1")
  set par(first-line-indent: 1em, justify: true, leading: 0.88em)
  set block(spacing: 1em)

  show heading: it => {
    // v(0.6em)
    // sans[#it]
    set text(font: headfont, weight: "semibold")
    block(it)
    par(text(size: 0.3em, ""))
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      let n = numbering(el.numbering, ..counter(heading).at(el.location()))
      if el.level == 1 {
        [#n 章]
      } else {
        [#n 節]
      }
    } else {
      it
    }
  }

  show heading.where(level: 1): it => {
    // v(0.6em)
    // set align(center)
    set text(size: 14pt)
    block(it)
    // block(smallcaps(it.body))
    par(text(size: 0.3em, ""))
  }

  [#doc]
}

#let jpsdoc(
  doc, textfont: "Noto Serif JP", mathfont: "STIX Two Math", headfont: "Noto Sans JP",
) = {
  set text(
    font: (textfont, "Hiragino Mincho ProN", "BIZ UDPMincho",), size: 10.5pt,
  )
  show math.equation: set text(font: (mathfont, "STIX Two Math"))
  show raw: set text(font: "Osaka", size: 1.4em)

  set page(margin: 1in, numbering: "1")
  set par(first-line-indent: 1em, justify: true, leading: 0.88em)
  set block(spacing: 1em)

  show heading: it => {
    // v(0.6em)
    // sans[#it]
    set text(font: headfont, weight: "semibold")
    block(it)
    par(text(size: 0.3em, ""))
  }

  show heading.where(level: 1): it => {
    // v(0.6em)
    // set align(center)
    set text(size: 14pt)
    block(it)
    // block(smallcaps(it.body))
    par(text(size: 0.3em, ""))
  }
  show figure.where(kind: table): set figure.caption(position: top)
  [#doc]
}

#let jpprez(doc) = {
  import "@preview/polylux:0.3.1": *

  set page(paper: "presentation-16-9", footer: [
    #set align(right)
    #set text(size: 10pt)
    #counter(page).display("1")
  ])
  set text(font: ("Roboto", "BIZ UDPGothic", "Hiragino Sans"), size: 25pt)
  set par(leading: 1em)

  show math.equation: set text(font: "STIX Two Math")
  show raw: set text(font: "Osaka", size: 1.4em)

  show heading: it => {
    it
    v(0.6em)
  }

  [#doc]
}
