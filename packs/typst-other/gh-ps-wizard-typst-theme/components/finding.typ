#import "../tokens.typ": *

#let cite-pill(cite) = {
  let sep = cite.position(": ")
  let path = if sep != none { cite.slice(0, sep) } else { cite }
  let lines = if sep != none { cite.slice(sep + 2) } else { "" }
  box(stroke: none)[
    #box(
      fill: surface,
      inset: (x: 7pt, y: 3.5pt),
      radius: 0pt,
      stroke: 0.5pt + border,
    )[
      #text(font: font-mono, size: 7.75pt, weight: "regular")[
        #text(fill: ink-faint)[#file-icon#h(0.4em)]
        #text(fill: ink-muted)[#path#if lines != "" [:]]
      ]
    ]
    #if lines != "" [
      #h(-0.5pt)
      #box(
        fill: surface-dim,
        inset: (x: 5.5pt, y: 3.5pt),
        radius: 0pt,
      )[
        #text(
          font: font-mono,
          size: 7.5pt,
          fill: ink-faint,
        )[#lines]
      ]
    ]
  ]
}

#let bullet-item(body) = {
  grid(
    columns: (1.35em, 1fr),
    column-gutter: 0.15em,
    align: (top + center, top + left),
    text(size: 11pt, fill: ink-faint)[•],
    block(spacing: 0.9em)[
      #text(size: 9.5pt, weight: 400, fill: ink-muted)[#body]
    ],
  )
  v(0.55em)
}

#let finding(title, cite, ..details) = {
  let items = details.pos()
  block(
    width: 100%,
    breakable: true,
    spacing: 0.55em,
  )[
    #text(size: 10.5pt, weight: 600, tracking: -0.015em, fill: ink)[#title]
    #cite-pill(cite)
    #if items.len() > 0 {
      v(0.35em)
      for item in items {
        bullet-item(item)
      }
    }
  ]
  v(1.35em)
}
