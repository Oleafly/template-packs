#import "../styles/font-settings.typ": *

#let csu-outline() = [
  #set page(margin: (top: 113pt))

  #show outline.entry.where(level: 1): it => {
    set text(font: font.Times + font.黑体)
    v(2pt)
    it
    v(2.5pt)
  }
  #show outline.entry.where(level: 2): it => {
    v(2pt)
    it
    v(1pt)
  }

  #outline(
    title: [
      #set text(font: font.Times + font.黑体, size: font-size.三号)
      #h(1fr)目#"    "录#h(1fr)
      #v(35pt)
    ],
    indent: 1em
  )
]