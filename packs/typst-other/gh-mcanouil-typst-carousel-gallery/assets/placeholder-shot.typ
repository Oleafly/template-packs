// The stand-in screenshot the `screenshot` family frames.
//
// It is drawn rather than captured, so the repository ships no picture of any
// real application, and the result stays legible when a deck scales it down.
// Deliberately neutral: greys and one blue, so it does not fight the palette of
// whichever template frames it.
//
// Rebuild with:
//
//   typst compile --root . --font-path fonts --ignore-system-fonts \
//     --ignore-embedded-fonts --format svg \
//     assets/placeholder-shot.typ assets/placeholder-shot.svg

#set page(width: 16cm, height: 10cm, margin: 0cm, fill: rgb("#ffffff"))
#set text(font: "Inter", size: 8pt, fill: rgb("#3d444d"))

#let chrome = rgb("#eef1f4")
#let rule = rgb("#dfe4ea")
#let dim = rgb("#c8cfd7")
#let accent = rgb("#2f6fd0")

// Title bar
#place(top + left, rect(width: 16cm, height: 0.9cm, fill: chrome, stroke: none))
#place(top + left, dy: 0.9cm, line(end: (16cm, 0cm), stroke: 0.6pt + rule))
#place(top + left, dx: 0.4cm, dy: 0.32cm, stack(
  dir: ltr,
  spacing: 0.18cm,
  ..(rgb("#f0645c"), rgb("#f3bd4c"), rgb("#63c363")).map(dot => circle(radius: 0.13cm, fill: dot))
))
#place(top + center, dy: 0.3cm, text(size: 8.5pt, fill: rgb("#77808a"))[Placeholder])

// Sidebar
#place(top + left, dy: 0.9cm, rect(width: 4.2cm, height: 9.1cm, fill: rgb("#f7f9fb"), stroke: none))
#place(top + left, dx: 4.2cm, dy: 0.9cm, line(end: (0cm, 9.1cm), stroke: 0.6pt + rule))
#for index in range(5) {
  let selected = index == 1
  place(top + left, dx: 0.3cm, dy: 1.4cm + index * 0.85cm, block(
    width: 3.6cm,
    height: 0.62cm,
    fill: if selected { accent.lighten(88%) } else { none },
    radius: 3pt,
  ))
  place(
    top + left,
    dx: 0.5cm,
    dy: 1.58cm + index * 0.85cm,
    rect(width: 0.26cm, height: 0.26cm, fill: if selected { accent } else { dim }, radius: 1pt),
  )
  place(
    top + left,
    dx: 0.95cm,
    dy: 1.62cm + index * 0.85cm,
    rect(
      width: 1.5cm + calc.rem(index * 7, 5) * 0.28cm,
      height: 0.18cm,
      fill: if selected { accent } else { dim },
      radius: 1pt,
    ),
  )
}

// Content heading
#place(top + left, dx: 4.8cm, dy: 1.4cm, rect(
  width: 5.4cm,
  height: 0.34cm,
  fill: rgb("#9aa3ad"),
  radius: 2pt,
))
#place(top + left, dx: 4.8cm, dy: 2cm, rect(width: 8.2cm, height: 0.16cm, fill: dim, radius: 1pt))
#place(top + left, dx: 4.8cm, dy: 2.35cm, rect(width: 6.4cm, height: 0.16cm, fill: dim, radius: 1pt))

// A small bar chart, so the shot has one thing in it that reads as data
#place(top + left, dx: 4.8cm, dy: 3.1cm, block(
  width: 10.6cm,
  height: 3.4cm,
  fill: rgb("#fbfcfd"),
  stroke: 0.6pt + rule,
  radius: 3pt,
)[
  #for index in range(9) {
    let heights = (1.3, 1.9, 1.5, 2.4, 2.0, 2.7, 2.2, 2.9, 2.5)
    place(
      left + bottom,
      dx: 0.45cm + index * 1.1cm,
      dy: -0.4cm,
      rect(
        width: 0.6cm,
        height: heights.at(index) * 0.9cm,
        fill: if index == 7 { accent } else { accent.lighten(65%) },
        radius: (top: 2pt),
      ),
    )
  }
])

// Footer rows
#for index in range(3) {
  place(
    top + left,
    dx: 4.8cm,
    dy: 6.9cm + index * 0.62cm,
    rect(width: 0.9cm, height: 0.16cm, fill: accent.lighten(45%), radius: 1pt),
  )
  place(
    top + left,
    dx: 6cm,
    dy: 6.9cm + index * 0.62cm,
    rect(width: 6.6cm - index * 0.9cm, height: 0.16cm, fill: dim, radius: 1pt),
  )
}
