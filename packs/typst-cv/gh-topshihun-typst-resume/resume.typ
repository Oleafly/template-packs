#let resume(
  name: [],
  contact_information: (),
  doc,
) = {

  // global setting
  set page(
    paper: "a4",
    margin: (x: 28pt, y: 28pt),
  )
  
  set text(
    font: "Sarasa Term SC Nerd", // https://github.com/laishulu/Sarasa-Term-SC-Nerd
    weight: "regular",
    size: 12pt,
  )

  set par(
    leading: 0.5em,
    spacing: 0.5em,
  )

  // 1 head
  show heading.where(level: 1): title => stack(
    v(-0.75em),
    text(
      size: 14pt,
      weight: "semibold",
      title,
    ),
    v(0.2em),
    line(length: 100%, stroke: 0.03em),
    v(-0.15em)
  )

  show heading.where(level: 2): title => stack(
    v(-0.75em),
    text(
      size: 12pt,
      weight: "semibold",
      title,
    ),
    v(-0.15em)
  )

  // add underline for linker
  show link: underline

  // footnote
  show footnote.entry: set align(left)
  set footnote.entry(separator: line(length: 100%, stroke: 0.03em))

  // name
  set align(center)
  text(
    size: 18pt,
    weight: "semibold",
    name,
  )

  // contact information
  stack(
    dir: ltr,
    for i in contact_information {
      text(size: 10pt, i)
      if i != contact_information.last() {
        text(size: 10pt)[ | ]
      }
    },
  )

  set align(left)
  doc
}

#let title(
  title,
) = {
  stack(
    v(0.3em),
    text(
      size: 14pt,
      weight: "semibold",
      title,
    ),
    v(0.3em),
    line(length: 100%, stroke: 0.03em),
  )
}

#let subtitle(
  main_title: [],
  sub_title: (),
  description: [],
) = {
  stack(
    dir: ltr,
    text(weight: "semibold", main_title),
    for i in sub_title {
      if i == sub_title.first() {
        text(" | ")
      }
      i
      if i != sub_title.last() {
        text[, ]
      }
    },
    align(right, description),
  )
}