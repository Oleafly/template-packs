#import "../theme.typ": *

#let page-frame(cdl: none, class: none, university: none, body) = {
  set page(
    fill: bg-color,
    margin: (top: 10mm, bottom: 10mm, left: 6mm, right: 6mm),
    columns: 2,
    header: context {
      set text(font: f-mono, size: 6pt, tracking: 0.08em, fill: c-ink)
      grid(
        columns: (1fr, 1fr),
        align(left)[#text(fill: c-gray)[#cdl]],
        align(right)[#text(fill: c-gray)[#class]],
      )
      v(1pt)
      line(length: 100%, stroke: 0.5pt + c-ink)
    },
    footer: context {
      line(length: 100%, stroke: 0.4pt + c-line)
      v(.5em)
      set text(font: f-mono, size: 6pt, tracking: 0.03em, fill: c-gray)
      let num = counter(page).display("1 / 1", both: true)
      if calc.even(counter(page).get().first()) {
        grid(columns: (1fr, 1fr), align(left)[#num], align(right)[#university])
      } else {
        grid(columns: (1fr, 1fr), align(left)[#university], align(right)[#num])
      }
    },
  )
  set columns(gutter: 5mm)
  body
}
