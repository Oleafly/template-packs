#let _col1 = rgb(json("theme.json").colors.sections.at(0))

// Colored bold text — defaults to the first section color from theme.json.
#let accent-text(content, color: _col1) = text(fill: color, weight: "bold")[#content]

// Centered rounded box with a light colored fill.
#let box-text(content, color: _col1, width: auto) = align(center, box(
  width: width,
  fill: color.lighten(90%),
  stroke: 3pt + color.lighten(60%),
  inset: 16pt,
  radius: 10pt,
)[#content])

// Inline citation with a compact footnote showing author and year.
#let cite-footnote(key) = context [
  #super([#std.cite(key)])
  #footnote(numbering: _ => [])[
    #std.cite(key, form: "normal")
    #h(0.1em)
    #std.cite(key, form: "author"),
    #std.cite(key, form: "year").
  ]
  #counter(footnote).update(n => n - 1)
]
