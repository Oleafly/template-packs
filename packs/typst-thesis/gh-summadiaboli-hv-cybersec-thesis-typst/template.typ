#let project(
  title: "",
  subtitle: "",
  authors: (),
  date: none,
  body
) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1",
    number-align: center,
  )
  
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: "en",
  )

  set par(justify: true)

  // IEEE-style figure and table captions
  show figure.where(kind: image): set figure(supplement: [Fig.])
  show figure.where(kind: table): set figure(supplement: [TABLE], numbering: "I")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): it => {
    show figure.caption: cap => [*#cap.supplement #cap.counter.display(cap.numbering)*#cap.separator #cap.body]
    it
  }

  // Chapter heading style: Centered, Huge, Bold, with Vertical Rule
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 24pt, weight: "bold")
    block(width: 100%, inset: (top: 2em, bottom: 2em))[
      #align(center)[
        #if it.numbering != none {
          grid(
            columns: (auto, auto, auto),
            column-gutter: 0.5em,
            align: horizon,
            counter(heading).display(),
            box(height: 1.1em, stroke: (left: 2pt + black)),
            it.body
          )
        } else {
          it.body
        }
      ]
    ]
  }

  // Section styling
  show heading.where(level: 2): set text(size: 16pt, weight: "bold")
  show heading.where(level: 3): set text(size: 14pt, weight: "bold")

  body
}

#let hrule = line(length: 100%, stroke: 0.5mm + black)
