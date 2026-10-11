#let title_page(
  content,
  title: "",
  region: "",
  subject: "",
  location: "",
  author: "",
  first_corrector: "",
  second_corrector: "",
  matr_nr: "",
  place_date: "",
  institution: "",
  thesis_kind: "",
) = {
  set document(
    title: title,
    author: author,
  )
  set heading(numbering: "1.1.1")
  set page(
    paper: "a4",
  )
  v(6em)
  align(center, text(24pt)[#institution])
  v(1em)
  align(center, text(12pt)[#region])
  v(-0.5em)
  align(center, text(12pt)[#subject])
  v(2em)
  align(center, text(24pt)[#title])
  v(8em)
  align(center, text(16pt)[#thesis_kind])
  v(0.1em)
  align(center, text(12pt)[von])
  v(0.1em)
  align(center, text(16pt)[#author])
  v(8em)
  grid(
    columns: (1fr, 1fr, 2fr, 1fr),
    align: (left, left),
    inset: 6pt,
    [],
    [Erstprüfer:],
    [#first_corrector],
    [],
    [],
    [Zweitprüfer:],
    [#second_corrector],
    [],
    [],
    [Matrikelnummer:],
    [#matr_nr],
    [],
  )
  v(4em)
  align(center, text(12pt)[#place_date])
  pagebreak()
  set page(
    paper: "a4",
    numbering: "1",
    number-align: right,
    margin: (x: 3.6cm, y: 5cm),
  )
  set par(
    justify: true,
    leading: 0.52em,
  )
  content
}

#let abstract(body) = {
  align(center, text(1em, weight: 600, [Abstract]))
  align(
    center,
    text[
      #body
    ],
  )
  v(1em)
}
