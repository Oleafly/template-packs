#import "common.typ": font_name

// Custom Staples banner PDF.
// Final trim size: 23.75 in wide x 6.5 in high.
// The title is kept inside a 0.25 in safe margin.

#set page(width: 23.75in, height: 6.5in, margin: 0in)
#set text(font: font_name)

// light inside cut/safe guide
#place(top + left, dx: 0.25in, dy: 0.25in)[
  #box(width: 23.25in, height: 6in, stroke: 0.5pt + black, inset: 0pt)[]
]

// corner cut marks
#let m = 0.15in
#let l = 0.35in
#place(top + left, dx: m, dy: m)[#line(length: l, stroke: 0.75pt + black)]
#place(top + left, dx: m, dy: m)[#rotate(90deg)[#line(length: l, stroke: 0.75pt + black)]]
#place(top + right, dx: -m - l, dy: m)[#line(length: l, stroke: 0.75pt + black)]
#place(top + right, dx: -m, dy: m)[#rotate(90deg)[#line(length: l, stroke: 0.75pt + black)]]
#place(bottom + left, dx: m, dy: -m)[#line(length: l, stroke: 0.75pt + black)]
#place(bottom + left, dx: m, dy: -m - l)[#rotate(90deg)[#line(length: l, stroke: 0.75pt + black)]]
#place(bottom + right, dx: -m - l, dy: -m)[#line(length: l, stroke: 0.75pt + black)]
#place(bottom + right, dx: -m, dy: -m - l)[#rotate(90deg)[#line(length: l, stroke: 0.75pt + black)]]

#place(top + left, dx: 0.25in, dy: 0.25in)[
  #box(width: 23.25in, height: 6in, inset: 0.1in)[
    #align(center + horizon)[
      #text(size: 46pt, weight: "bold")[Tesla Coils and Faraday Cages]
    ]
  ]
]
