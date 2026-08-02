#let _callout-col = (
  note:    rgb("#2563eb"),
  tip:     rgb("#16a34a"),
  warning: rgb("#ca8a04"),
  danger:  rgb("#dc2626"),
)

/// Admonition block for inline notes, tips, warnings, and danger notices.
#let callout(body, type: "note") = {
  let col = _callout-col.at(type)
  block(
    width: 100%,
    fill: col.lighten(92%),
    stroke: (left: 3.5pt + col),
    inset: (left: 1.2em, top: 0.9em, right: 1.2em, bottom: 0.9em),
    radius: (right: 2pt),
    breakable: false,
  )[
    #text(size: 0.65em, weight: "bold", fill: col, tracking: 1.25pt)[#upper(type)]
    #v(0.35em)
    #text(size: 0.9em)[#body]
  ]
}
