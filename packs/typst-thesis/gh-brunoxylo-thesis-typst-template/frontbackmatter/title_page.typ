#import "../thesis_typ/main_layout_config.typ": body-font, sans-font

#let titlePage(
  title: "",
  degree: "",
  faculty: "",
  university: "",
  myProf: "",
  myOtherProf: "",
  author: "",
  id: "",
  location: "",
  submissionDate: none,
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 40mm),
    number-align: center,
  )

  // Overwrite page number with empty string
  set page(footer: "")

  set text(
    font: body-font,
    size: 12pt,
    lang: "en"
  )

  set par(leading: 1em)

  // Set a dummy headline for a entry in the pdf's table of contents
  hide(heading(numbering: none, outlined: false, bookmarked: true, "Titelblatt"))

  // --- Title Page ---
  align(center, image("../figures/logo_h-da.svg", width: 52%))


  v(5mm)

  align(center, text(font: sans-font, 2em, weight: 700, university))

  align(center, text(font: sans-font, 1.5em, weight: 100, "- " + faculty + " -"))

  v(10mm)

  align(center, text(font: sans-font, 1.5em, weight: 700, title))

  v(15mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, "Abschlussarbeit zur Erlangung des akademischen Grades \n" + degree))

  v(20mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, "vorgelegt von"))
  align(center, text(font: sans-font, 1.3em, weight: 700, author))
  align(center, text(font: sans-font, 1em, weight: 100, "Matrikelnummer: " + id))

  v(20mm)

  grid(
    columns: (1.7fr, 1.1fr, 0fr, 4fr),
    row-gutter: (10pt),
    column-gutter: (15pt),
    "", align(left, strong("Referent")), ":", text(myProf),
    "", align(left, strong("Korreferent")), ":", text(myOtherProf)
  )
  pagebreak()
}
