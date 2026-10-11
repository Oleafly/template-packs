// Abbreviations List
#import "../lib.typ": content_marker, font_serif_jp, font_sans_jp, custom-print-gloss
#import "@preview/glossarium:0.5.9": print-glossary
#import "abbreviations.typ": abbreviation-list

#pagebreak()
#block([
  #content_marker()
  #set text(font: font_serif_jp, weight: "bold", size: 20pt)
  略語一覧
])
#v(0.3em)
#line(length: 100%, stroke: 0.4pt)
#v(10mm)

#block[
  #set text(font: font_sans_jp)
  #set par(leading: 0.8em, spacing: 0.8em)
  #print-glossary(
    abbreviation-list, 
    show-all: false, 
    disable-back-references: false,
    user-print-gloss: custom-print-gloss
  )
]
