#import "@preview/mmdr:0.2.2": mermaid

#let blue = oklab(50%, -0.014, -0.08)
#let light_grey = rgb("#8a8a8a")
#let dark_grey = rgb("#585858")

// Adjust this to change code block Japanese text weight
// Options: "regular", "medium", "semibold", "bold"
#let code-jp-weight = "medium"


#let main-style(body) = {
  // ── Figures ───────────────────────────────────────────────────────────────
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(size: 10pt, style: "italic")

  // ── Links ─────────────────────────────────────────────────────────────────
  show link: set text(fill: blue)

  // ── Tables ────────────────────────────────────────────────────────────────
  set table(
    inset: 11pt,
    stroke: 0.5pt + luma(200),
    fill: (x, y) => if y == 0 { luma(245) } else { white },
    align: horizon,
  )
  show table: set par(justify: false)
  show table: it => block(
    radius: 8pt,
    stroke: 1pt + blue.lighten(60%).desaturate(40%),
    clip: true,
    it,
  )


  // ── Raw blocks ────────────────────────────────────────────────────────────────
  // Quick and dirty mermaid compiler. Avoid using since it's kinda not good
  show raw.where(lang: "mermaid"): it => mermaid(it.text)

  // custom highlighter for folder structure codes, see example
  show raw.where(lang: "folder", block: true): it => {
    show regex("#.*"): set text(fill: light_grey)
    show regex("/"): set text(fill: dark_grey)
    show regex("[├─│└]"): set text(fill: dark_grey.lighten(50%))
    set par(leading: 1.5em)
    it
  }

  show raw.where(block: false): it => box(
    fill: oklab(97.52%, -0.001, -0.003),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 3pt,
    stroke: 0.5pt + luma(240),
    text(fill: oklab(20%, -0.000, -0.100), it, font: ("Fira Code Retina", "Yu Gothic"), weight: code-jp-weight),
  )

  show raw.where(block: true): it => {
    if it.lang == "mermaid" {
      return box(width: 100%, align(center, it))
    }
    box(
      fill: oklab(97.52%, -0.001, -0.003),
      stroke: 0.5pt + luma(240),
      inset: 8pt,
      radius: 6pt,
      width: 100%,
      text(it, font: ("Fira Code Retina", "IPAexGothic"), weight: code-jp-weight),
    )
  }

  // ── Heading reference ─────────────────────────────────────────────────────
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      let num = numbering(el.numbering, ..counter(heading).at(el.location()))
      let clean-num = if num.ends-with(".") { num.slice(0, -1) } else { num }
      link(it.target, [#el.supplement #clean-num])
    } else {
      it
    }
  }

  // ── Base text ─────────────────────────────────────────────────────────────
  set text(
    font: ("Times New Roman", "IPAexGothic", "Khmer OS Siemreap"),
    size: 12pt,
    hyphenate: false,
  )
  set par(
    justify: true,
    first-line-indent: (amount: 0.5in, all: true),
    leading: 1em,
  )
  set enum(indent: 0.5in, body-indent: 1em)
  set list(indent: 0.5in, body-indent: 1em)
  show list: it => {
    set list(indent: 0.25in, marker: [◦])
    it
  }

  show cite: it => text(fill: blue, it)
  show ref: it => text(fill: blue, it)

body }