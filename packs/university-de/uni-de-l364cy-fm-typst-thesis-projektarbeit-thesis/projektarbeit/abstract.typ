#let abstract() = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "Source Sans Pro"
  let sans-font = "Source Sans Pro"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )
  
  align(left, text(font: sans-font, 2em, weight: 700, "Abstract"))
  
  text[
    #lorem(150)
  ]
}
