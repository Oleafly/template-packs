#let transparent = rgb("ffffff00")
#let separator() = { line(length: 100%,stroke: 0.3em + gradient.linear(transparent, blue, navy, blue, transparent)) }
#let header(
  title: none,
  subtitle: none,
  logo: none,
  firstAuthor: none,
  reference: none,
  otherAuthors: (),
  affiliation: none
) = {
  set par(leading: 0.8em, spacing: 1.5em)
  block(
    height: 9%,
    outset: 0pt,
    inset: 0pt,
    grid(
      columns: (0.7fr, 0.2fr, 0.1fr),
      gutter: 2%,
      align: (right + horizon, left + horizon, left + horizon),
      par(leading: 1em, text(fill: rgb("003b81"), size: 2.5em, weight: "bold", font: "Yanone Kaffeesatz", title)),
      par(leading: 0.5em, text(fill: rgb("252525"), size: 1.3em, weight: "regular", font: "oswald", subtitle)),
      logo,
    )
    + v(-1.5em) + box(fill: rgb("003b81"), radius: 1pt, inset: 0.5em, text(fill: white, size: 1.2em, font: "oswald", reference)) + h(1fr) + if affiliation != none { text(fill: rgb("252525"), size: 1.2em, weight: "bold", font: "Barlow", affiliation) + h(1fr)} + text(fill: rgb("36454F"), size: 1.2em, weight: "medium", font: "Oswald", upper(firstAuthor)) + [, ] + text(fill: rgb("36454F"), size: 1.2em, font: "oswald", weight: "regular", otherAuthors.join(", "))
  )
}

#let row(
  boxes: (),
  ratios: (),
) = {
  grid(
    columns: ratios,
    gutter: 1em,
    ..boxes
  )
}

#let chunk(
  title: none,
  layout: (),
  widths: (),
  ..content
) = {
  align(center, heading(title))
  let rows = ()
  for (i, r) in layout.enumerate() {
    let cols = ()
    for c in r {
      cols.push(content.at(c - 1))
    }
    if cols.len() == 1 and cols.at(0).func() == image {
      rows.push(grid(columns: widths.at(i), gutter: 0.8em, align: center + horizon, ..cols))
    } else {
      rows.push(grid(columns: widths.at(i), gutter: 0.8em, align: left + horizon, ..cols))
    }
  }
  grid(rows: auto, gutter: 1.5em, align: horizon, ..rows)
}
