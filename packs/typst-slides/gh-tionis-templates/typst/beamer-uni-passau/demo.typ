#import "unipassau.typ": unipassau, up-block, up-caption

#let meta = (
  title: [Title of the Presentation],
  subtitle: [Subtitle],
  author: [Author],
  institute: [Fakultät#linebreak()Universität Passau],
  date: [Date],
  short-title: [Short Title],
)

#let standard = unipassau(
  title: meta.title,
  subtitle: meta.subtitle,
  author: meta.author,
  institute: meta.institute,
  date: meta.date,
  short-title: meta.short-title,
  style: "std",
)

#let minimal = unipassau(
  title: meta.title,
  subtitle: meta.subtitle,
  author: meta.author,
  institute: meta.institute,
  date: meta.date,
  short-title: meta.short-title,
  style: "min",
)

#show: standard.setup

#(standard.title-slide)()

#(standard.slide)(title: [Standard Variant])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 12mm,
    [
      #up-block(title: [Definition])[
        This is a definition.
      ]

      - Element 1
      - Element 2

      + Element 1
      + Element 2
    ],
    [
      #align(center)[
        #image("assets/up.jpg", width: 50mm)
        #up-caption(kind: [Figure])[Universität Passau]
      ]
    ],
  )
]

#(minimal.slide)(title: [Minimal Variant])[
  #align(center)[
    #box(stroke: 0.4pt + rgb("#7d7d7d"), inset: 0pt)[
      #table(
        columns: (auto, auto, auto, auto),
        align: (left, center, center, center),
        stroke: none,
        inset: (x: 5pt, y: 1.2pt),
        [Name], [Mat. Nr.], [Semester], [Degree Course],
        table.hline(stroke: 0.4pt + rgb("#7d7d7d")),
        [Example 1], [1234], [10], [M.Sc. BA],
        [Example 2], [4567], [8], [M.Sc. CS],
        [Example 3], [7890], [5], [B.A. ES],
        [Example 4], [9012], [4], [B.Sc. IC],
      )
    ]

    #v(2mm)
    #up-caption(kind: [Table])[Students]
  ]
]
