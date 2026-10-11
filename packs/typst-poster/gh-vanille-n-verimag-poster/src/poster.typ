// This is the main file that gets compiled into your poster.

// CetZ is the standard tool to draw graphs in Typst,
// like TikZ is for LaTeX, but more ergonomic.
#import "@preview/cetz:0.4.2"

// Tiaoma draw QR-codes
#import "@preview/tiaoma:0.3.0"

// We import the auxiliary files that define the poster template.
//
// `palette` is an array of colors, e.g. `palette.red.dk` for dark red,
// `palette.purple.xlt` for extra-light purple, etc.
// You can see all the available colors by running `make palette`
// and seeing the output in `build/palettes.pdf`.
//
// `build-page` is the main function that configures the template parameters,
// see how it is used below.
#import "template/verimag.typ": palette, build-page
// These define elements that are useful for a poster.
// Currently only customizable boxes are provided.
#import "template/elems.typ"

// Footer to link to your website in the poster.
// See how this is used below in `footnote`.
#let url-and-qr(title, url, short: auto) = {
  set text(fill: palette.blue.xdk, size: 50pt)
  box[
    #box(baseline: 50%)[
      #title \
      #{if short == auto { raw(url) } else { short }}
    ]
    #h(1cm)
    #box(baseline: 50%)[#tiaoma.qrcode(url, options: (fg-color: palette.blue.xdk, bg-color: palette.blue.mid, scale: 5.0))]
  ]
}

// Decide how to display the authors
#let author = elems.author.with(
  // Makes last name uppercase
  capitalize-last: false,
  groups: (
    // Add one entry for each different style of author that you want
    primary: (
      color: palette.gray.lt,
      size: 150%,
    ),
    default: (
      color: palette.gray.mid,
      size: 120%,
    ),
  )
)

// This is where the page layout gets customized.
#let veri-page = build-page(
  // Font face and size
  font: (
    family: "Inria Sans",
    size: (
      base: 100pt,
      // The rest should be expressed as fractions of `base`
      title: 140%,
      authors: 40%,
      body: 50%,
    ),
  ),
  // Header of the poster
  title: [*My poster*],
  authors: (
    author(first: [Primary], last: [Author], group: "primary"),
    author(first: [Secondary], last: [Author]),
    author(first: [Ext], last: [Collaborator], note: [(Univ.) ])
  ),
  // Footer of the poster
  footnote: url-and-qr([Our publications], "https://example.com"),
  // Page size
  dimensions: (
    orientation: "portrait", // Either "portrait" or "landscape"
    footer: 9%, // As a fraction of total height
    header: 12%, // As a fraction of total height
    margin: 2cm, // Absolute value of the margin on the sides
  ),
  // Choose the colors of the header, footer, background.
  // It is recommended to express them as a function of the palette,
  // not as absolute RGB values.
  palette: (
    // Backgrounds
    header: gradient.linear(palette.blue.dk, palette.blue.dk, palette.blue.xdk, angle: 50deg),
    body: palette.blue.xlt,
    footer: palette.blue.mid,
    // Foregrounds
    title: palette.red.dk,
    authors: palette.gray.lt,
    border: palette.blue.xdk,
  ),
)

#let boxes = elems.make-boxes(
  // Boîtes customisables
  boxes: (
    normal: (
      style: "boxed",
      palette: (
        title: palette.brown.mid,
        body: palette.yellow.xlt,
      ),
    ),
    info: (
      style: "boxed",
      palette: (
        title: palette.green.dk,
        body: palette.green.xlt,
      )
    ),
    highlight: (
      style: "boxed",
      title-align: (x: right),
      palette: (
        title: palette.red.dk,
        body: palette.gray.xlt,
      )
    ),
  ),
)

// This is where the magic occurs, and all the styling options defined
// by `build-page` get applied.
#show: veri-page

// This is optional. You can also have more fine-grained control by
// manually placing `grid`s.
#show: columns.with(2)

// This is how you use the boxes defined by `elems.typ`:
#boxes.info.with[Definition][
  #lorem(25)
]()

#boxes.normal.with[Example][
  #lorem(50)
]()

#boxes.normal.with[Illustration][
  #show: align.with(center)
  #include "drawing.typ"
]()

#boxes.highlight.with[Theorem][
  For all $n in NN$,
  $ sum_(i = 0)^n i = n(n+1)/2 $
]()

#boxes.normal.with[Illustration][
  #align(center)[
    #image("/assets/images/triangular-numbers.png", width: 30cm)
  ]
  #align(right)[
    (Illustration from #link("https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF")[Wikipedia])
  ]
]()

#boxes.info.with[Implementation][
  ```py
  def triangular_sum(n):
      total = 0
      while n > 0:
          total += n
          n -= 1
      return total
  ```
]()

#boxes.normal.with[Experimental results][
  #table(
    columns: (1fr, 1fr),
    inset: 5mm,
    align: center,
    table.header([*Input*], [*Output*]),
    ..range(1, 11).map(i => (i, i * (i+1) / 2)).flatten().map(i => [#i])
  )
]()


