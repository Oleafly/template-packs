
#let under-construction(label) = [...]


#let code-figure(body, caption: none) = figure(
  box(
    width: 100%,
    fill: luma(245),
    radius: 4pt,
    inset: 10pt,
  )[
    #place(top + right, dx: 2pt, dy: -2pt)[
      
        #text(size: 10pt, fill: rgb("0288D1"), weight: "medium")[#lower(body.lang)]
      
    ]
    #align(left, body)
  ],
  caption: caption,
  kind: image,
  supplement: auto,
)
