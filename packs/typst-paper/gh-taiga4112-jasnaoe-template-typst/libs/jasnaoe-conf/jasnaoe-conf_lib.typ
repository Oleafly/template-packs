// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let mincho = ("TeX Gyre Termes", "IPAMincho")
#let gothic = ("TeX Gyre Termes", "IPAGothic")
// #let mincho = ("Times New Roman", "IPAMincho")
// #let gothic = ("Times New Roman", "IPAGothic")
// #let mincho = ("Times New Roman", "MS Mincho", "IPAMincho")
// #let gothic = ("Times New Roman", "MS Gothic", "IPAGothic")

#let jasnaoe-conf(
  title: none,
  authors: none,
  abstract: none,
  bibliography: none,
  body
) = {

  // Configure the page.
  set page(
    paper: "a4",
    columns: 2,
    margin: (top: 25mm, bottom: 22mm, x: 17mm)
  )

  let max_width = 86.0mm // 2 columns(86.4mm - margin(0.4mm))

  set text(
    size: 9pt,
    font: mincho,
  )
  set par(
    leading: 1.00em,
    first-line-indent: (
      amount: 1.00em,
      all: true,
    ),
    justify: true,
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: numbering.with("(1)"), supplement: [Eq.])
  show math.equation: set block(above: 18pt, below: 18pt)

  // Configure lists.
  set enum(indent: 9pt, body-indent: 9pt)
  set list(indent: 9pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "1.")
  show heading: it => context{
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(here())
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }
    if it.level == 1 [
      // First-level headings are centered smallcaps.
      // We don't want to number of the acknowledgment section.
      #v(9pt)
      #set par(first-line-indent: 0pt)
      #let is-ack = it.body in ([謝辞], [謝　辞], [謝　　辞], [Acknowledgement], [Acknowledgements])
      #set align(center)
      #set text(size: 10pt, font: gothic, weight: "bold")
      // #v(9pt, weak: true)
      #if it.numbering != none and not is-ack {
        numbering("1.", ..levels)
        h(8pt, weak: true)
      }
      #it.body
      #v(9pt)
    ] else [
      // The other level headings are run-ins.
      #v(9pt)
      #set par(first-line-indent: 0pt)
      #set text(size: 9pt, font: gothic, weight: "bold")
      #if it.numbering != none {
        numbering("1.1", ..levels)
        h(8pt, weak: true)
      }
      #it.body
    ]
  }

  show figure.where(kind: table): set figure(placement: top, supplement: [Table])
  show figure.where(kind: table): set figure.caption(position: top, separator: [ ])
  show figure.where(kind: image): set figure(placement: top, supplement: [Fig.])
  show figure.where(kind: image): set figure.caption(position: bottom, separator: [ ])

  show figure.caption: it => context {
    let label = it.supplement + " " + str(it.counter.display(it.numbering))
    
    let full_text = label + it.body
    if measure(full_text).width <= max_width [
      #align(box(align(it, left)), center)
    ] else [
    // Output in 2-column layout
      #grid(
        columns: (auto, 1fr),
        gutter: 0.5em,
        [
          #label
        ],
        [
          #box(align(it.body, left))
        ]
      )
    ]
  }

  // Convert full-width Japanese punctuation marks to their Western-style equivalents
  // to comply with academic writing conventions and publisher formatting requirements.
  show "。": "．"
  show "、": "，"

  // Display the paper's contents.
  body
}
