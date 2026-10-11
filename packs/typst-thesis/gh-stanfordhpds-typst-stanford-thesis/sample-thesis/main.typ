#import "../stanford-thesis.typ": thesis, part

#show: thesis.with(
  title: "Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit Sed Do Eiusmod Tempor",
  author: "Jane A. Smith",
  department: "Lorem Ipsum",
  degree: "Doctor of Philosophy",
  submission-month: "June",
  submission-year: "2026",
  abstract: [
    #lorem(120)
  ],
  acknowledgments: [
    #lorem(60)
  ],
  dedication: [
    _#lorem(8)_
  ],
)

// Unnumbered introduction chapter
#heading(level: 1, numbering: none)[Introduction]

#lorem(500)

#lorem(50) @einstein1905 #lorem(30) @abbott2016.

== Consectetur Adipiscing Elit

#lorem(400)

== Sed Do Eiusmod Tempor

#lorem(400)

// Part I
#part("Dolor Sit Amet")

= Methods

#lorem(500)

== Analytical Framework

#lorem(50) @misner1973.

#lorem(400)

== Numerical Simulations

#lorem(300)

#figure(
  table(
    columns: 4,
    table.header([Simulation], [Grid Size], [Time Steps], [Runtime (hrs)]),
    [Run A], [256³], [10,000], [48],
    [Run B], [512³], [20,000], [192],
    [Run C], [1024³], [40,000], [768],
  ),
  caption: [#lorem(10)],
) <tab-simulations>

#lorem(300)

// Part II
#part("Tempor Incididunt")

= Results

#lorem(200)

#figure({
  let w = 280
  let h = 200
  let pad = 30
  let pts = (
    (12,18), (15,25), (20,22), (25,35), (28,30), (32,42), (35,38),
    (40,50), (42,45), (48,55), (50,60), (55,58), (58,65), (62,70),
    (65,62), (68,75), (72,72), (75,80), (78,78), (82,85), (88,90), (92,88),
  )
  let to-x(v) = (pad + v / 100 * (w - pad * 2)) * 1pt
  let to-y(v) = (h - pad - v / 100 * (h - pad * 2)) * 1pt

  block(width: w * 1pt, height: h * 1pt)[
    #place(line(start: (pad * 1pt, (h - pad) * 1pt), end: ((w - pad) * 1pt, (h - pad) * 1pt), stroke: 0.6pt))
    #place(line(start: (pad * 1pt, pad * 1pt), end: (pad * 1pt, (h - pad) * 1pt), stroke: 0.6pt))
    #place(dx: (w / 2 - 3) * 1pt, dy: (h - pad + 10) * 1pt, text(size: 0.8em)[_x_])
    #place(dx: (pad - 20) * 1pt, dy: (h / 2) * 1pt, rotate(-90deg, text(size: 0.8em)[_y_]))
    #for pt in pts {
      place(dx: to-x(pt.at(0)) - 2pt, dy: to-y(pt.at(1)) - 2pt,
        circle(radius: 2.5pt, fill: black)
      )
    }
  ]
}, caption: [#lorem(12)]) <fig-results>

#lorem(200)

#lorem(50) @tab-simulations #lorem(20) @fig-results #lorem(30).

#lorem(400)

= Conclusion

#lorem(400)

#bibliography("../sample-references.bib")
