#import "meta.typ": meta
#import "@preview/hydra:0.6.2": hydra
#let layout(body) = {
  set document(title: meta.title, author: meta.author)
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 2cm),
    numbering: "I",
    number-align: right,
    header: context {
      hydra(1)
      line(length: 100%, stroke: 0.5pt + black)
    },
  )
  // --- Typografie ---
  let body-font = "Times New Roman"
  set text(font: body-font, size: 12pt, lang: "de")
  set par(justify: true, leading: 1em, linebreaks: "optimized")
  show math.equation: set text(weight: 400)



  // Überschriften im Verzeichnis
  show outline.entry.where(level: 1): it => {
    v(1em, weak: true) 
    strong(it)
  }

  // --- Überschriften (Headings) ---
  set heading(numbering: "1.1", supplement: [Kapitel])
  show heading.where(level: 1): set block(below:24pt)
  show heading.where(level: 2): set block(below:12pt)
  show heading.where(level: 3): set block(below:12pt)
  show heading.where(level: 4): set block(below:12pt)
  show heading.where(level: 5): set block(below:12pt)

  show heading.where(level: 1): tit =>{
    pagebreak(weak:true)
    set text(size:16pt,weight: "semibold")
    tit
  }
  show heading.where(level:2):set text(size:14pt,weight:"semibold")
  show heading.where(level:3):set text(size:12pt,weight:"semibold")
  show heading.where(level:4):set text(size:12pt,weight:"regular", style: "italic")



  // Fette  Referenzen
  show ref: it => {
    let label-str = str(it.target)

    if (
      label-str.starts-with("fig:")
        or label-str.starts-with("tab:")
        or label-str.starts-with("appendix:")
        or label-str.starts-with("kap:")
    ) {
      strong(it)
    } else {
      it
    }
  }

  // Zeile Abstand unter bildern
  show figure: set block(above: 2em, below: 2em)

  // ein Rahmen darum
  show figure.where(kind: image): fittich => {
    set figure(gap: 0pt)
    block[
      #rect(stroke: 1pt, inset: 1pt)[#fittich.body]
      #v(-1em)
      #fittich.caption
    ]
  }


  // Tabellen
    set table(
      fill: (x, y) => if y == 0 { rgb("BDC1D0") },
      inset: (right: 1.5em),
    )

    show table.cell: it => {
      if it.y == 0 {
        set text(black)
        strong(it)
      } else if it.body == [] {
        pad(..it.inset)[_N/A_]
      } else {
        it
      }
    }


  body
}
