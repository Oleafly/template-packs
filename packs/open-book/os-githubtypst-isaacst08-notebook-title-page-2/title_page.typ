
#let title-page(
  main-title,
  sub-title,
  author,
  date-started,
  accent-color,
) = [
  #set align(center + horizon)
  #set page(numbering: none, margin: 0pt)

  // Triangle Background
  #set page(background: place(
    bottom + left,
    polygon(
      fill: accent-color,
      (0%, 0%),
      (50%, 0%),
      (0%, -100%),
    ),
  ))

  #place(
    horizon + right,
    dy: -13%,
    dx: -4%,
    align(right, box(
      width: 76%,
      [
        #text(size: 32pt, weight: 600, main-title)
        #if (sub-title != none) [
          #v(-22pt)
          #text(size: 21pt, style: "italic", sub-title) #h(6pt)
        ]
      ],
    )),
  )

  #v(4cm)

  #place(
    center + bottom,
    dy: -8%,
    dx: 22%,
    {
      set align(left)
      stack(
        dir: ttb,
        spacing: 0.6em,
        ..(
          ("Author", author),
          ("Date Started", date-started.display()),
          ("Date Updated", datetime.today().display()),
        )
          .enumerate()
          .map(((i, (a, b))) => [#h(0.45em * i) *#a:* #b]),
      )
    },
  )
  // #place(
  //   center + bottom,
  //   dy: -8%,
  //   dx: 22%,
  //   grid(
  //     columns: (1fr, 1fr),
  //     column-gutter: 8pt,
  //     row-gutter: 8pt,
  //     align: (right, left),
  //     ..(
  //       ("Author", author),
  //       ("Date Started", date-started.display()),
  //       ("Date Updated", datetime.today().display()),
  //     )
  //       .map(((a, b)) => (text(weight: "bold", [#a:]), [#b]))
  //       .flatten()
  //   ),
  // )

  #pagebreak()
]
