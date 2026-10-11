#import "meta.typ": meta

#let cover() = {
  set page(numbering: none)
  v(1cm)
  align(center, image("images/htw_logo.svg", width: 40%))

  v(5mm)
  align(center, text(1.5em, weight: 700, meta.degree))

  v(15mm)


  align(center, text(2em, weight: 700, meta.title))

  v(30mm)
  align(center)[
    #align(left, table(
      stroke: none,
      columns: (1fr, 1fr),
      inset: 10pt,
      "Vorgelegt von:", meta.author,
      "Studienbereich:", meta.faculty,
      "Vorgelegt am:", meta.submissionDate.display("[day].[month].[year]"),
      "Ort:", meta.City,
      "Matrikelnummer:", meta.MatrikelNumber,
      "Erstgutachter:", meta.supervisor,
      "Zweitgutachter:", meta.advisors,
    ))
  ]
}
