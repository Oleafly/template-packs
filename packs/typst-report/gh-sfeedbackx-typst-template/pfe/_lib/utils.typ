// ======================================================
// UTILITY FUNCTIONS
// ------------------------------------------------------
// Cross-references, definition blocks, note blocks,
// title boxes, and chapter outline generation.
// ======================================================

// Reference a section heading by label
#let titleref(label) = context {
  let target = query(label).first()
  let num = counter(heading).at(target.location())
  link(label)[#text(fill: blue, [Section #num.map(str).join(".")])]
}

// Reference a figure (image) by label
#let figureref(label) = context {
  let target = query(label).first()
  let num = counter(figure.where(kind: image)).at(target.location())
  link(label)[#text(fill: blue, [Figure #num.map(str).join(".")])]
}

// Reference a figure without the "Figure" prefix
#let figurerefnocap(label) = context {
  let target = query(label).first()
  let num = counter(figure.where(kind: image)).at(target.location())
  link(label)[#text(fill: blue, [figure #num.map(str).join(".")])]
}

// Reference a table by label, with a custom prefix (e.g. "Table")
#let tableref(label, w) = context {
  let target = query(label).first()
  let num = counter(figure.where(kind: table)).at(target.location())
  link(label)[#text(fill: blue, w + " " + num.map(str).join("."))]
}

// Styled note block with blue left border
#let note(body) = block(
  width: 100%,
  inset: (left: 12pt, top: 6pt, bottom: 6pt, right: 8pt),
  stroke: (left: 3pt + blue),
  fill: blue.lighten(90%),
  radius: (right: 4pt),
)[#text(weight: "bold", fill: blue)[Note: ]#body]

// Styled definition block with green left border
#let definition(body) = block(
  width: 100%,
  inset: (left: 12pt, top: 6pt, bottom: 6pt, right: 8pt),
  stroke: (left: 3pt + green),
  fill: green.lighten(90%),
  radius: (right: 4pt),
)[#text(weight: "bold", fill: green, hyphenate: false)[Definition: ]#body]

// Chapter title box with border
#let title_box_chapter(content) = {
  align(center, block(
    width: 100%,
    stroke: (y: 1pt + black),
    inset: 80pt,
    text(size: 18pt, weight: "bold", content),
  ))
}

// Inline title with horizontal lines on both sides
#let inline_title(content) = {
  grid(
    columns: (1fr, auto, 1fr),
    gutter: 1em,
    align: horizon,
    line(length: 100%, stroke: 4pt),
    text(weight: "bold", content),
    line(length: 100%, stroke: 4pt),
  )
}

// Generate a chapter outline from level-2 headings
#let chapter_outline() = context {
  let before = query(heading.where(level: 1).before(here()))
  if before.len() == 0 { return }
  let current_chap = before.last()

  let after = query(heading.where(level: 1).after(here()))
  let all_h2 = query(heading.where(level: 2).after(current_chap.location()))

  let chapter_h2 = if after.len() > 0 {
    let next_loc = after.first().location()
    all_h2.filter(h => {
      let h_page = counter(page).at(h.location()).first()
      let next_page = counter(page).at(next_loc).first()
      h_page < next_page
    })
  } else {
    all_h2
  }

  for h in chapter_h2 {
    let page_num = counter(page).at(h.location()).first()
    let h_num = counter(heading).at(h.location())

    box(width: 100%)[
      #text()[#h_num.at(1)]
      #box(width: 10pt)
      #link(h.location())[#h.body]
      #box(width: 1fr, repeat[.])
      #box(width: 2pt)
      #link(h.location())[#page_num]
    ]
    v(0.5em)
  }
}

// Cover page title box with double border
#let title_box(content) = {
  align(center, block(
    width: 100%,
    stroke: (y: 2pt + blue.darken(20%)),
    inset: 3pt,
    block(
      width: 100%,
      stroke: (paint: black, thickness: 0.5pt),
      inset: (y: 20pt),
      text(size: 18pt, weight: "bold", content),
    ),
  ))
}
