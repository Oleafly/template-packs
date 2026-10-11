//---------------------------------------------------------------------------------------

#let title = "Univerity Course - Formulas"
#let subtitle = "by Max Mustermann"

//---------------------------------------------------------------------------------------


#set page(
  paper: "a4",
  margin: (top: 0.5cm,bottom: 0.5cm,right: 0.5cm,left: 0.5cm),
  columns: 3,
)

#set text(size: 7pt, font: "New Computer Modern") 
#set heading(numbering: "1.1", depth: 2)

#let grey_box(content) = block(
  fill: luma(230),
  inset: 3pt,
  radius: 3pt,
  width: 100%,  
  text(content)
)

#show heading: it => [
  #if it.level == 1 {
    line(length: 100%, stroke: 0.5pt)
  }
  #it
]

#set document(title: [#title])


//---------------------------------------------------------------------------------------


#align(center, [
  *#title* \
  #subtitle
])


= Chapter One
#lorem(100)

= Chapter Two

This is Einsteins relativistic energy:

#grey_box([
$ E &= (m c^2)/sqrt(1-(v^2)/(c^2)) overbrace(=, v=0 text("")) m c^2 $
])

