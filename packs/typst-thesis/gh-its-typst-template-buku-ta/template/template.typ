// ============================================================
// AUTO — Page setup, tipografi, dan show rules heading. Jangan diubah.
// ============================================================

#import "lib.typ": *

#let template(body) = {
  // Page setup
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 2cm, top: 3cm, bottom: 2.5cm),
    footer: context {
      let fmt = here().page-numbering()
      if fmt != none {
        let pnum = counter(page).display(fmt)
        if calc.odd(here().page()) { align(right, pnum) }
        else { align(left, pnum) }
      }
    },
  )

  // Typography
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "id",
    hyphenate: false,
  )

  set par(
    justify: true,
    leading: 0.65em,
    spacing: 1.5em,
    linebreaks: "optimized",
  )

  // List & enum
  set enum(indent: 0.8cm, body-indent: 0.6em)
  set list(indent: 1.25cm, body-indent: 0.6em)

  // Figure numbering: Gambar 1.1 per bab
  set figure(
    numbering: (..n) => {
      let h = counter(heading).get()
      let bab = if h.len() > 0 { h.at(0) } else { 0 }
      numbering("1.1", bab, n.pos().at(0))
    },
    gap: 0.65em,
  )
  show figure.caption: set text(size: 9pt, style: "italic")
  show figure.where(kind: table): set figure.caption(position: top)

  // Table styling
  show table: set text(size: 11pt)
  show table: set par(justify: true, first-line-indent: 0pt)
  set table(stroke: 0.5pt, inset: 6pt)

  // Heading setup + figure counter reset per bab
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { "BAB " + str(n.first()) }
    else { numbering("1.1.1.", ..n) }
  })

  show heading.where(level: 1): it => {
    // Reset counter gambar/tabel/kode setiap bab baru
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: "kode")).update(0)

    // Bab bernomor: mulai di halaman ganjil (cetak bolak-balik).
    pagebreak(weak: true)

    align(center)[
      #block(above: 0pt, below: 0pt,
        text(size: 14pt, weight: "bold")[
          #if it.numbering != none [
            BAB #counter(heading).display("1") \
          ]
          #upper(it.body)
        ]
      )
    ]
    v(0.8cm)
  }

  show heading.where(level: 2): it => {
    block(above: 1.2em, below: 0.6em,
      text(size: 13pt, weight: "bold")[
        #counter(heading).display("1.1") #h(0.4em) #it.body
      ]
    )
  }

  show heading.where(level: 3): it => {
    block(above: 1.2em, below: 0.6em,
      text(size: 12pt, weight: "bold")[
        #counter(heading).display("1.1.1") #h(0.4em) #it.body
      ]
    )
  }

  show heading.where(level: 4): it => {
    block(above: 1.2em, below: 0.6em,
      text(size: 12pt, weight: "regular")[
        #counter(heading).display("1.1.1.1") #h(0.4em) #it.body
      ]
    )
  }

  // Outline (TOC) entries — spacing antar entri
  show outline.entry: set block(above: 0.5em)

  // Body
  body
}
