#let titlepage(
  title: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: none,
  submissionDate: none,
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 25mm, right: 25mm, top: 20mm, bottom: 20mm),
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

  set par(leading: 1em)

  
  // --- Title Page ---
  v(1cm)
  align(center, image("../figures/logo.png", width: 80%))

  v(8mm)
  align(center, text(font: sans-font, 2em, weight: 600, "Bachelorarbeit"))

  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 400, "zur Erlangung des akademischen Grades"))

  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 400, degree))
  
  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 400, "im Studiengang Telekommunikationsinformatik \n der Fakultät Digitale Transformation \n der Hochschule für Technik, Wirtschaft und Kultur Leipzig"))
  
  v(15mm)

  align(center, text(font: sans-font, 2em, weight: 700, title))

  pad(
    top: 3em,
    right: 15%,
    left: 15%,
    if advisors.len() > 0 {
    grid(
      columns: 2,
      gutter: 1em,
      strong("Autor: "), author,
      strong("Erstgutachter: "), supervisor,
      strong("Zweitgutachter: "), advisors.join(", "),
      strong("Abgabedatum: "), submissionDate,
    )
    } else {
      grid(
      columns: 2,
      gutter: 1em,
      strong("Autor: "), author,
      strong("Erstgutachter: "), supervisor,
      strong("Abgabedatum: "), submissionDate,
      )
    }
  )

  pagebreak()
}
