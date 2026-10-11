#import "@preview/polylux:0.4.0": *
//#import "utils/pdfpcgit.typ": speaker-note
#import "utils.typ": *

#let presentation-template(
  title: "Presentation",
  subtitle: "Bachelor Forschungprojekt Präsentation",
  author: "Martin Nagel",
  date: "2. Juni 2026",
  institution: "VISUS, University of Stuttgart",
  last-slide: [
    Thank you!
    
    Questions?
  ],
  doc
) = {
let the-footer = pad(x: -1cm,
  {
    set text(size: 6pt, font: "New Computer Modern Sans")
    set align(bottom)
    block(
    //fill: black,
    width: 100%,
    height: 100%,
    {  grid(
        columns: (1cm, 1fr, 1cm),
        align: (left, center, right),
        inset: (0cm, 0cm, (right: .3cm)),
        none, [Bachelor Forschungsprojekt --- #title], toolbox.slide-number
        )
        toolbox.progress-ratio(ratio => {
          stack(
            dir: ltr,
            rect(stroke: none, fill: CAIlightblue, width: ratio       * page.width, height: 2pt),
            rect(stroke: none, fill: PUIgray, width: (1 - ratio) * page.width, height: 2pt),
          )
        })
    }
    )
  }
)

  
  set page(
    height: 96mm,
    width: 170mm,
    //paper: "presentation-4-3",
    //fill: white.darken(2%),
    margin: (top: 1cm, bottom: 7.7mm, x: 10mm),
    header: slide-title-header(toolbox.current-section),
    footer: the-footer
  )
  
  show heading.where(level: 1): _ => none
  
  show heading.where(level: 2): it => {
    set text(font: "New Computer Modern Sans", size: 12pt, fill: Thealgray, weight: 500)
    set par(leading: .6em)
    set block(below: 1em, above: 0cm)
    it
  }
  
  show bibliography: set text(size: 6pt)
  
  show cite: set text(size: 6pt)
  set grid(
    align: top
  )
  
  show figure.caption: set text(size: 10pt)
  set figure(
    supplement: none
  )
  
  set text(
    size: 12pt,
    fill: Thealgray,
    font: "New Computer Modern Sans",
    weight: 400
  )
  
  set list(marker: (sym.dot, sym.triangle.r.filled), indent: (.25em), spacing: .8em)
  
  show list: it => {
    set text(size: 11pt)
    set par(leading: .5em)
    //item-by-item(it)
    it
  }


  showTitle(title, subtitle, date, author, institution)
  

  doc


  slide[
  #set text(
    fill: white,
    size: 14pt,
    weight: 700,
    font: "CMU Sans Serif"
  )
  #set page(
    fill: PUIblue,
    header: none
  )

  #align(center + horizon, last-slide)
]

slide[
  #set page(header: slide-title-header("References"))
  #set align(horizon)
  #bibliography("../literature.bib", full: true, title: "References", style: "ieee")
]
}

#let pad-slide(content) = slide[
  #pad(top: 5mm, content)
]