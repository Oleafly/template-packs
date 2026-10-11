#let cover(
  title: "",
  degree: "",
  program: "",
  author: "",
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )
  
  set par(leading: 1em)

  
  // --- Cover ---
  v(1cm)
  align(center, image("../figures/logo.png", width: 30%))

  v(5mm)
  align(center, text(font: sans-font, 2em, weight: 700, "Hochschule für Technik, Wirtschaft und Kultur"))

  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 100, "Fakultät für Digitale Transformation"))
  v(15mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, degree))
  v(15mm)
  

  align(center, text(font: sans-font, 2em, weight: 700, title))
  
  v(10mm)
  align(center, text(font: sans-font, 2em, weight: 500, author))
  
  pagebreak()
}