#import "../metadata.typ": body-font, sans-font

#let titlepage(
  title: "",
  supervisor1: "",
  supervisor2: "",
  author: "",
  startDate: none,
  submissionDate: none,
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: body-font,
    size: 12pt,
    lang: "en"
  )

  set par(leading: 1em)

  // --- Title Page ---
  align(center, image("../figures/logos/logo-short.png", width: 26%))

  v(5mm)
  align(center, text(font: sans-font, 2em, weight: 700, "Technische Universität Berlin"))

  align(center, text(font: sans-font, 1em, weight: 100, "Fakultät I - Geistes- und Bildungswissenschaften"))

  align(center, text(font: sans-font, 1em, weight: 100, "Institut für Sprache und Kommunikation"))

  align(center, text(font: sans-font, 1em, weight: 100, "Fachgebiet Audiokommunikation"))

  v(10mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, "Master’s Thesis in Audiokommunikation und -technologie"))

  v(10mm)

  align(center, text(font: sans-font, 2em, weight: 700, title))

  v(10mm)

  // The grid sizes itself to the longest entry, so names never wrap.
  pad(
    top: 3em,
    align(center, grid(
      columns: 2,
      row-gutter: 1em,
      column-gutter: 8mm,
      align: left,
      strong("Author:"),          author,
      strong("1. Supervisor:"),   supervisor1,
      strong("2. Supervisor:"),   supervisor2,
      strong("Start Date:"),      startDate,
      strong("Submission Date:"), submissionDate,
    ))
  )

  pagebreak()
}
