#import "font-settings.typ": *

#let main-text-heading(it) = {
  if it.level == 1 {
    set align(center)
    set text(
      size: font-size.三号, 
      font: font.Times + font.黑体
    )
    pagebreak(weak: true)
    v(4pt)
    it
    v(3.5pt)
  } else if it.level == 2{
    set text(
      size: font-size.四号, 
      weight: "thin", 
      font: global-font,
    )
    v(2.5pt)
    it
    v(-0.5pt)
  } else {
    set text(weight: "thin")
    it
  }
  par()[#text(size: 0em)[#h(0.0em)]]
}

#let back-page-heading(it) = {
  if it.level == 1 {
    set align(center)
    set text(
      size: font-size.三号, 
      font: font.Times + font.黑体
    )
    pagebreak()
    v(22pt)
    it
    v(23pt)
  } else if it.level == 2{
    set text(
      size: font-size.四号, 
      weight: "thin", 
      font: global-font,
    )
    v(2.5pt)
    it
  } else {
    it
  }
  par()[#text(size: 0em)[#h(0.0em)]]
}