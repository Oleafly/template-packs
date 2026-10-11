// Plotting library
#import "@preview/cetz:0.5.2"
// Colourful boxes
#import "@preview/showybox:2.0.4": showybox


#let preamble(doc) = {
  set page(
    paper: "a4",
    width: 170mm,
    height: 257mm,
    margin: (x: 2cm, y: 2cm),
  )
  set text(
    font: "New Computer Modern",
    lang: "ru",
    size: 12pt,
  )
  set par(
    justify: true,
    leading: 0.52em,
  )
  set heading(
    numbering: "1.1",
  )
  show heading: set block(height: 0.9em)

  //  LaTeX-like Содержание
  show outline.entry.where(level: 1): it => {
    show repeat: none
    strong(it)
  }

  doc
}

// Операторы в math-окружении
#let sign = math.op("sign")
#let sigmoid = math.op("sigmoid")
#let argmax = math.op("argmax", limits: true)


// Красивые боксы. Как в tcolorbox из мира LaTeX

// Бокс "Attention!"
#let box-attention(..body) = {
  let color = rgb("bf2626")
  showybox(
    frame: (
      title-color: color,
      border-color: color,
      body-color: color.lighten(90%),
      radius: 4pt,
      title-inset: (x: 1em, y: 0.35em),
    ),
    title: "ATTENTION!",
    ..body,
  )
}
// Бокс "TIP!"
#let box-tip(..body) = {
  let color = rgb("208c3a")
  showybox(
    frame: (
      title-color: color,
      border-color: color,
      body-color: color.lighten(90%),
      radius: 4pt,
      title-inset: (x: 1em, y: 0.35em),
    ),
    title: "TIP!",
    ..body,
  )
}
// Бокс "WARNING!"
#let box-warning(..body) = {
  let color = rgb("df7600")
  showybox(
    frame: (
      title-color: color,
      border-color: color,
      body-color: color.lighten(90%),
      radius: 4pt,
      title-inset: (x: 1em, y: 0.35em),
    ),
    title: "WARNING!",
    ..body,
  )
}
