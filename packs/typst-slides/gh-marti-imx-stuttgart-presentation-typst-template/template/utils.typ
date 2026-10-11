#import "@preview/polylux:0.4.0": toolbox, slide
#import "colors.typ": *


#let slide-title-header(title) = {
  //show: toolbox.full-width-block.with(fill: PUIblue, inset: 1em, outset: 1em)
  set align(horizon)
  set text(fill: luma(100%), size: 11pt, font: "CMU Sans Serif")
  pad(x: -.65cm, top: 3mm, 
    block(
    width: 100%,
    fill: PUIblue,
    height: 1cm,
    outset: (x: 1cm),
      grid(
        columns: (auto, auto),
        align: horizon,
        column-gutter: 1fr,
        title
      )
    )
  )
}

#let start-new-section(title) = {
  toolbox.register-section(title)
  heading(title)
  slide[
    #set page(header: slide-title-header("Outline"))
    #toolbox.all-sections( (sections, current) => {
    set align(horizon)
    block(
      height: 55%,
      width: 100%,
      //fill: green,
      {
      set text(fill: rgb("#cfd3d4ff"), size: 11pt, font: "CMU Sans Serif")
      grid(
        row-gutter: 1fr,
        ..sections.map(s => if s == current {
          set text(fill: Thealgray, size: 11pt)
          strong(s)
        } else {s})
      )
    }
    )
})
  ]
}

#let reduced-footer = pad(x: -1cm,
  {
    set text(size: 6pt, font: "New Computer Modern Sans")
    set align(bottom)
    block(
    //fill: black,
    width: 100%,
    height: 100%,
    {   align(right, pad(toolbox.slide-number, right: .3cm))
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

#let showTitle(title, subtitle, presentation-date, author, institute) = slide[
  #set page(header: none, footer: none)
  #align(center, grid(
    columns: 3,
    column-gutter: .4cm,
    //image("../figures/cai_logo_light.pdf", height: .7cm),
    //image("../figures/ellis_logo.png", height: .6cm),
    //image("../figures/USTUTT_logo.pdf", height: .7cm)
  ))

  #v(1fr)

  #set par(leading: 10pt)
  #text(font: "CMU Sans Serif",size: 14.4pt,weight: 700, title)

  #subtitle

  #pad(bottom: 4mm, top: 2mm, line(length: 100%, stroke: 2pt + CAIlightblue))

  #set par(leading: 9pt)
  #set text(size: 10pt)
  #author \
  #presentation-date

  #set text(size: 8pt)
  #set par(leading: .25cm)
  #institute

]