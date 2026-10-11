#let lang = "es" // es | en

#let document(body) = [
  #show heading: it => {
    set text(weight: "medium")
    smallcaps(it)
  }

  #show link: underline

  #set page(margin: (x: 1.28cm, y: 1.3cm))
  #set par(justify: false)
  #set list(marker: [-])
  #set text(font: "calibri", size: 11pt) // Use a font installed in your SO

  #body
]
