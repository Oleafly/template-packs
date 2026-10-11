// #import "@preview/bookly:1.0.0": *
#import "@preview/bookly:1.1.2": *

// #show: chapter.with(title: "Second chapter")

= Second chapter
#minitoc
#pagebreak()

== Goals
#lorem(100)

$
arrow(V)(M slash R_0) = lr((d arrow(O M))/(d t)|)_(R_0) + theta
$ <eq:vmr-equation>

La Figure @b2 présente la carte du Cnam @Jon22.


#subfigure(
figure(image("../images/typst-logo.svg"), caption: []),
figure(image("../images/typst-logo.svg"), caption: []), <b2>,
columns: (1fr, 1fr),
caption: [(a) Left image and (b) Right image],
label: <fig:subfig2>,
)


and a meduni wien box

#align(center)[
  #box(fill: gray.transparentize(50%), width: 50%, inset: 5mm, radius: (top-left: 5mm, bottom-right: 15%))[
    hello
  ]
]