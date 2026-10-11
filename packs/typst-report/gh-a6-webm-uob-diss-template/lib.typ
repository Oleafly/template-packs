#import "@preview/nth:1.0.1": *

#let uob(
  author: "John Doe",
  degree: "BSc",
  title: [Paper Title],
  unit: "COMS30045",
  subtitle: [And even a fancy subtitle],

  body
) = {
  let degree_long_names = (
    BSc: [Bachelor of Science],
    MEng:[Master of Engineering],
    MSci:[Master of Science],
    MSc: [Master of Science],
    PhD: [Doctor of Philosophy],
  )

  let unit_cp = (
    COMS30044: [20CP],
    COMS30045: [40CP],
    COMSM0052: [40CP],
    COMSM0142: [40CP],
  )

  // Set document metadata.
  set document(title: title, author: author)

  // Set the body font.
  set text(font: "New Computer Modern", size: 10pt)

  // Enums numbering
  set enum(numbering: "1.1.1") // TODO test if Figures come out as 1.3

  // Tables & figures
  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set text(size: 8pt)
  show figure.where(kind: table): set figure(numbering: "I")
  // show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  show figure.caption: set text(size: 8pt)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set align(center)

  // Adapt supplement in caption independently from supplement used for
  // references.
  show figure: fig => {
    let prefix = (
      if fig.kind == table [TABLE]
      else if fig.kind == image [Fig.]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    show figure.caption: it => [#prefix~#numbers: #it.body]
    show figure.caption.where(kind: table): smallcaps
    fig
  }

  // Code blocks
  show raw: set text(
    font: "TeX Gyre Cursor",
    ligatures: false,
    size: 1em / 0.8,
    spacing: 100%,
  )

  set page(
    paper: "a4",
    margin: 2.5cm,
  )

  // Configure equation numbering and spacing. // TODO unchecked
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references // TODO unchecked
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure lists. // TODO unchecked
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings. // TODO unchecked
  // set heading(numbering: "I.A.a)")
  // show heading: it => {
  //   // Find out the final number of the heading counter.
  //   let levels = counter(heading).get()
  //   let deepest = if levels != () {
  //     levels.last()
  //   } else {
  //     1
  //   }

  //   set text(10pt, weight: 400)
  //   if it.level == 1 {
  //     // First-level headings are centered smallcaps.
  //     // We don't want to number the acknowledgment section.
  //     let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [Acknowledgments], [Acknowledgements])
  //     set align(center)
  //     set text(if is-ack { 10pt } else { 11pt })
  //     show: block.with(above: 15pt, below: 13.75pt, sticky: true)
  //     show: smallcaps
  //     if it.numbering != none and not is-ack {
  //       numbering("I.", deepest)
  //       h(7pt, weak: true)
  //     }
  //     it.body
  //   } else if it.level == 2 {
  //     // Second-level headings are run-ins.
  //     set par(first-line-indent: 0pt)
  //     set text(style: "italic")
  //     show: block.with(spacing: 10pt, sticky: true)
  //     if it.numbering != none {
  //       numbering("A.", deepest)
  //       h(7pt, weak: true)
  //     }
  //     it.body
  //   } else [
  //     // Third level headings are run-ins too, but different.
  //     #if it.level == 3 {
  //       numbering("a)", deepest)
  //       [ ]
  //     }
  //     _#(it.body):_
  //   ]
  // }

  // Style bibliography.// TODO unchecked
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], style: "ieee")

  show heading.where(level: 1): it => {
    set text(25pt)
    set align(left)
    pagebreak()
    it
  } 

  set quote(block: true)

  // Title section
  align(center)[
    #image(width: 55%, "logo/UoB_CMYK_24.svg")
    #v(1cm)
    SCHOOL OF COMPUTER SCIENCE
    #v(2cm)
    #text(17pt)[
      #title
    ]
    #v(1cm)
    #text(14pt)[
      #subtitle
      #v(1cm)
      #author
    ]
    #v(1cm)
    #line(length: 50%)
    #v(1cm)
    A dissertation submitted to the University of Bristol in accordance with the
    requirements of the degree of
    #degree_long_names.at(degree)
    in the Faculty of Engineering *worth*
    *#unit_cp.at(unit)*
    .
    #v(1cm)
    #line(length: 50%)
    #v(1cm)
    #datetime.today().display("[weekday]")
    #nths(datetime.today().display("[day]"))
    #datetime.today().display("[month repr:long], [year]")
  ]

  set page(
    header: [
      #line(length: 100%)
    ],
    footer: context [
      #line(length: 100%)
      #v(1pt)
      #align(center)[
        #counter(page).display("i")
      ]
    ],
  )
  counter(page).update(1)

  // TODO unchecked
  // Configure paragraph properties.
  set par(spacing: 0.45em, justify: true, first-line-indent: 1em, leading: 0.45em)

  // Display the paper's contents.
  set par(leading: 0.5em) // TODO unchecked
  body

  // Display bibliography.
  // bibliography
}
