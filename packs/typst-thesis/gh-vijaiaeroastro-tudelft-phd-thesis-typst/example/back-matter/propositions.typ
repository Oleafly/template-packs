#import "../../src/tudelft-phd-thesis.typ": delft-blue

#set page(numbering: none, header: none, footer: none)

#let proposition(number, body) = {
  grid(
    columns: (1.45em, 1fr),
    column-gutter: 0.45em,
    align: (right, top),
    [#number.],
    body,
  )
  v(1.2em)
}

#align(center)[
  #text(size: 24pt, weight: "bold", fill: delft-blue)[Propositions]
  #v(1mm)
  accompanying the dissertation
  #v(2.5mm)
  #text(size: 18pt, weight: "bold", fill: delft-blue)[Studies in Radioactivity and Measurement]
  #v(1mm)
  by
  #v(1mm)
  #text(size: 14pt, weight: "bold")[Marie S. CURIE]
]

#v(3mm)
#align(center)[#text(weight: "bold")[The following propositions pertain to this dissertation]]
#v(1mm)

#proposition(1)[
  Reliable measurement of weak radioactive signals requires an explicit estimate of background counts before sample observations can be interpreted. (Chapter 3) \
  This proposition pertains to this dissertation.
]

#proposition(2)[
  A calibration relationship is useful only when its range, uncertainty, and assumptions are reported together with the resulting measurement. (Chapter 3) \
  This proposition pertains to this dissertation.
]

#proposition(3)[
  Reproducible experiments require the measurement chain, exposure duration, and data-reduction procedure to be documented as carefully as the final result. (Chapter 4) \
  This proposition pertains to this dissertation.
]

#proposition(4)[
  A scientific conclusion is stronger when the conditions under which it may fail are stated explicitly. (Chapter 4) \
  This proposition pertains to this dissertation.
]

#pagebreak()
#align(center)[#text(weight: "bold")[The following propositions do not pertain to this dissertation]]

#proposition(5)[
  A clear illustration can reduce a reader's effort more effectively than an additional paragraph of explanation. \
  This proposition does not pertain to this dissertation.
]

#proposition(6)[
  The most useful software abstractions are often the ones that make misuse difficult rather than merely making correct use convenient. \
  This proposition does not pertain to this dissertation.
]

#proposition(7)[
  Automation without transparent checks moves mistakes faster; it does not remove them. \
  This proposition does not pertain to this dissertation.
]

#proposition(8)[
  A benchmark should reward reported limitations and failure analysis as much as favourable results. \
  This proposition does not pertain to this dissertation.
]

#proposition(9)[
  Good typography is not decoration in technical writing; it is part of making an argument inspectable. \
  This proposition does not pertain to this dissertation.
]

#proposition(10)[
  The longevity of scientific work depends on whether others can understand, reproduce, and extend it. \
  This proposition does not pertain to this dissertation.
]

#v(1fr)
#align(center)[
  #text(size: 10pt)[
    These propositions are regarded as opposable and defendable, and have been approved as such by the promotors Prof. dr. H. A. Lorentz and Prof. dr. E. Noether.
  ]
]
