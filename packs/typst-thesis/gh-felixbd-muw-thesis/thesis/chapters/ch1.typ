// #import "@preview/bookly:1.0.0": *
#import "@preview/bookly:1.1.2": *

#import "./../preamble.typ": *
// #show: document => my-config(document)
#show: doc => my-config(
  // is-draft: false,
  doc
)

// #show: chapter.with(title: "First chapter")

= First chapter

#lorem(100)
#minitoc
#pagebreak()

== Goals
#lorem(100)

Equations @eq:1 et @eq:2 are very important.
$
integral_0^1 f(x) dif x = F(1) - F(0) "et voilà"
$ <eq:1>

$
integral_0^1 f(x) dif x = F(1) - F(0) "et voilà"
$ <eq:2>

test

#math.equation(
  $ tau \ pi $,
  block: true,
  alt: "hello"
)

$ tau \ pi $

#lorem(20)
== Code

Figure @fig:1 is a beautiful typst logo.

#figure(
image("../images/typst-logo.svg", width: 75%),
caption: [#ls-caption([#lorem(10)], [#lorem(2)])],
) <fig:1>

Figure @fig:subfig the Typst logo. Figure @b is a Typst logo @Smi21.

#subfigure(
figure(image("../images/typst-logo.svg"), caption: []),
figure(image("../images/typst-logo.svg"), caption: []), <b>,
columns: (1fr, 1fr),
caption: [(a) Left image and (b) Right image],
label: <fig:subfig>,
)

#figure(
  table(
    columns: 3,
    table.header(
      [Substance],
      [Subcritical °C],
      [Supercritical °C],
    ),
    [Hydrochloric Acid],
    [12.0], [92.1],
    [Sodium Myreth Sulfate],
    [16.6], [104],
    [Potassium Hydroxide],
    table.cell(colspan: 2)[24.7],
  ), caption: [#lorem(4)]
)

== Boxes

#lorem(10)

=== Informations

#info-box[
  #lorem(10)
]

#tip-box[
  #lorem(10)
]

#warning-box[
  #lorem(10)
]

#important-box[
  #lorem(10)
]

#pagebreak(weak: true)

#proof-box[
  #lorem(10)
]

#question-box[
  #lorem(10)
]

#lorem(1000)#footnote("This is a footnote")


#theorem(name: "Some theorem")[
  Theorem content goes here.
]<thm>

#proof[
  Complicated proof.
  
  (same number as the theorem above ...)
]<proof>

@proof and @thm[theorem]



#lemma()[
  this is a lemma
]

#corollary()[
  this is a corollary
]

#remark()[
  this is a remark
]

#proposition()[
  this is a proposition
]

#example()[
  here an example
]




#pagebreak()

#[
  // #import "@local/meander:0.4.2"
  #import "@preview/meander:0.4.2"

  #meander.reflow({
    import meander: *

    placed(
      center + horizon,
      boundary:
        // Override the default margin
        contour.margin(1cm) +
        // Then redraw the shape as a grid
        contour.grid(
          // 25 vertical and horizontal subdivisions.
          // Just pick a number that looks good.
          // A good rule of thumb is to start with obstacles
          // about as high as one line of text.
          div: 25,
          // Equation for a circle of center (0.5, 0.5) and radius 0.5
          (x, y) => calc.pow(2 * x - 1, 2) + calc.pow(2 * y - 1, 2) <= 1
        ),
      // Underlying object
      circle(radius: 3cm, fill: yellow),
    )

    container(width: 48%)
    container(align: right, width: 48%)
    content[
      #set par(justify: true)
      #lorem(570)
    ]
  })
]