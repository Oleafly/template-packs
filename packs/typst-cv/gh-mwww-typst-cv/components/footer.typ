#import "../theme.typ": *

// Usage (in page setup):
//   #set page(footer: cv-footer(name: "Jane Doe", title: "CV"))
#let cv-footer(name: "", title: "CV") = context {
  let current = counter(page).get().first()
  let total   = counter(page).final().first()

  grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    column-gutter: 0.8em,
    text(font: font-mono, size: size-footer, fill: color-footer)[#name — #title],
    line(length: 100%, stroke: stroke-light),
    text(font: font-mono, size: size-footer, fill: color-footer)[#current / #total],
  )
}
