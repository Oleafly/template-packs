// Shared academic article layout and style.
// Content lives in src/; this file should stay presentation-only.

#let article(
  title: none,
  authors: (),
  date: none,
  // Override the automatic font resolution when needed.
  // Default: Times New Roman → Liberation Serif.
  // Strict final builds: --input strict-fonts=1
  // Explicit face: --input body-font=Liberation Serif
  body-font: auto,
  body-size: 11pt,
  doc,
) = {
  let strict = sys.inputs.at("strict-fonts", default: "0") == "1"
  let input-font = sys.inputs.at("body-font", default: "")
  let resolved-font = if body-font != auto {
    body-font
  } else if strict {
    ("Times New Roman",)
  } else if input-font != "" {
    (input-font,)
  } else {
    ("Times New Roman", "Liberation Serif")
  }

  set document(
    title: if title != none { title } else { "" },
    author: authors.map(a => if type(a) == dictionary { a.name } else { a }),
  )

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1",
  )

  set text(
    font: resolved-font,
    size: body-size,
    lang: "en",
  )

  set par(
    justify: true,
    leading: 0.65em,
    spacing: 1.1em,
    first-line-indent: 1.2em,
  )

  set heading(numbering: "1.1")
  show heading: it => {
    set text(weight: "bold")
    set par(first-line-indent: 0pt)
    block(above: 1.4em, below: 0.8em, it)
  }

  set bibliography(style: "ieee")

  if title != none {
    set align(center)
    set par(first-line-indent: 0pt)
    text(size: 16pt, weight: "bold", title)
    v(0.8em)

    if authors.len() > 0 {
      let names = authors.map(a => if type(a) == dictionary { a.name } else {
        a
      })
      text(size: 11pt, names.join(", ", last: ", and "))
      v(0.4em)
    }

    if date != none {
      text(size: 10pt, date)
      v(1.2em)
    } else {
      v(0.8em)
    }
  }

  set align(left)
  doc
}
