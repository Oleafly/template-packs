#import "../styles/font-settings.typ": font, font-size, global-font
#import "../content/notation-explain.typ" as body

#let notation-explain-page() = [
  #set page(margin: (top: 114pt))
  #align(center)[#text(font: font.黑体, size: font-size.三号, "符号说明", weight: "bold")]
  #v(25pt)
  #body
]
