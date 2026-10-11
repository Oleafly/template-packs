#import "/common.typ": *
#import "@preview/droplet:0.3.1": dropcap

#let sans_font = (
  "TeX Gyre Heros",
  "Nimbus Sans L",
  "Helvetica Neue",
  "Helvetica",
  "Arial",
)
#let serif_font = (
  "TeX Gyre Pagella",
  "URW Palladio L",
  "Palatino",
  "Palatino Linotype",
)

#let durham_cs_dissertation(
  title: none,
  student: none,
  supervisor: none,
  degree: [
    Submitted as part of the requirement for the degree of BSc Computer Science
    to the Board of Examiners in the Department of Computer Science, Durham
    University
  ],
  abstract: none,
  keywords: (),
  paper-size: "us-letter",
  bibliography: none,
  body,
) = {
  set document(title: title, author: student)
  set text(font: serif_font, size: 9.5pt)

  set columns(gutter: 12pt)
  set page(
    paper: paper-size,
    columns: 2,
    margin: (x: 0.75in, top: 0.75in, bottom: 0.625in),
    numbering: none,
    footer: none,
    header: context {
      set text(font: sans_font, size: 8pt)
      grid(
        columns: (1fr, auto),
        align: (left, right),
        upper[Durham University, Department of Computer Science],
        counter(page).display("1"),
      )
    },
  )

  set figure(scope: "parent", placement: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)

  show figure.caption: it => {
    set text(size: 8pt)
    if it.kind == table {
      set align(center)
      set text(font: sans_font, weight: "bold")
      it.supplement
      [ ]
      context it.counter.display("I")
      linebreak()
      set text(weight: "regular")
      it.body
    } else {
      set align(left)
      it.supplement
      [ ]
      context it.counter.display("1")
      [. ]
      it.body
    }
  }

  show figure.where(kind: image): set figure(supplement: [Fig.])
  show figure.where(kind: table): set figure(supplement: [TABLE])
  show figure.where(kind: table): set text(size: 8pt)

  set heading(numbering: "1.1.1")
  show heading: it => {
    let level = counter(heading).get()

    let is_special = (
      it.body
        in (
          [Acknowledgment],
          [Acknowledgement],
          [Acknowledgments],
          [Acknowledgements],
          [References],
        )
    )

    if it.level == 1 {
      set align(left)
      set text(font: sans_font, size: 10pt, weight: "bold")
      show: block.with(above: 20pt, below: 12pt, sticky: true)

      if it.numbering != none and not is_special {
        counter(heading).display("1")
        h(14pt, weak: true)
      }

      smallcaps(it.body)
    } else if it.level == 2 {
      set align(left)
      set text(font: sans_font, size: 10pt, weight: "bold")
      show: block.with(above: 14pt, below: 8pt, sticky: true)

      if it.numbering != none {
        counter(heading).display("1.1")
        h(10pt, weak: true)
      }

      it.body
    } else if it.level == 3 {
      set align(left)
      set text(font: sans_font, size: 10pt, weight: "regular", style: "italic")
      show: block.with(above: 12pt, below: 6pt, sticky: true)

      if it.numbering != none {
        counter(heading).display("1.1.1")
        h(7pt, weak: true)
      }

      it.body
    } else {
      set align(left)
      set text(font: sans_font, size: 9.5pt, style: "italic")
      show: block.with(above: 8pt, below: 4pt, sticky: true)
      it.body
    }
  }

  // Override common bibliography config with Durham-specific styling
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(
    title: text(
      font: sans_font,
      size: 10pt,
      weight: "bold",
    )[#smallcaps[References]],
    style: "ieee",
  )

  show: common-style

  place(
    top,
    float: true,
    scope: "parent",
    clearance: 14pt,
    {
      set align(center)
      set par(leading: 6pt, spacing: 8pt)

      {
        set text(font: sans_font, size: 24pt, weight: "light")
        title
      }

      v(8pt)

      {
        set text(font: sans_font, size: 10pt)
        [Student Name: #student]
        linebreak()
        [Supervisor Name: #supervisor]
        if degree != none {
          linebreak()
          degree
        }
      }

      v(12pt)

      if abstract != none {
        set align(left)
        set text(font: sans_font)
        set par(justify: true, first-line-indent: 1em)
        block(width: 100%, {
          [*Abstract* -- ]
          abstract
        })
      }

      if keywords != () {
        v(6pt)
        set align(left)
        set text(font: sans_font)
        block(width: 100%, {
          [*Index Terms* -- ]
          keywords.join(", ")
        })
      }

      v(6pt)

      align(center, block(width: 100%, {
        v(2pt)
        grid(
          columns: (1fr, auto, 1fr),
          align: (right + horizon, center + horizon, left + horizon),
          line(length: 60%, stroke: 0.4pt),
          h(6pt) + text(sym.diamond.filled, size: 1.5em) + h(6pt) + v(0.325em),
          line(length: 60%, stroke: 0.4pt),
        )
        v(2pt)
      }))
    },
  )

  set par(
    justify: true,
    first-line-indent: (amount: 1.5em, all: false),
    spacing: 0.7em,
    leading: 0.5em,
  )

  body

  bibliography
}

#let ieee_par_start(first, rest, body) = {
  dropcap(
    height: 2,
    gap: 3pt,
    overhang: 0pt,
    font: serif_font,
    weight: "bold",
    {
      text(weight: "bold")[#upper(first)]
    },
    {
      text(weight: "bold", size: 7pt)[#upper(rest)]
      body
    },
  )
}
