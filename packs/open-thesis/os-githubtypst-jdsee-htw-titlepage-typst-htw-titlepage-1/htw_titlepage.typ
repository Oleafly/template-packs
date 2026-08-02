#let titlepage(
  title: "",
  subtitle: "Bachelorarbeit",
  subject: (
    name: "",
    area: 0 
  ),
  author: "",
  examiners: (
    first: "",
    second: ""
  ),
  body
) = {
  align(center, image(height: 10%, "images/htw_logo.jpg"))

  line(length: 100%, stroke: 0.5pt)
  v(10mm, weak: true)

  align(center, text(18pt, weight: "bold", fill: rgb("#76B900"), title))

  v(10mm, weak: true)
  line(length: 100%, stroke: 0.5pt)

  align(center, text(16pt, subtitle))

  v(50pt)

  align(center, text(12pt, "Name des Studiengangs"))
  align(center, text(18pt, subject.name))
  align(center, text(18pt,
    weight: "bold",
    fill: rgb("#76B900"),
    [Fachbereich #str(subject.area)]))
  align(center, text(12pt, "vorgelegt von"))
  align(center, text(18pt, author))

  v(50pt)

  align(center, text(12pt, "Datum:"))
  align(
    center,
    text(14pt, [Berlin, #datetime.today().display("[day].[month].[year repr:last_two]")])
  )

  v(25pt)

  align(center, text(18pt, examiners.first))
  align(center, text(18pt, examiners.second))

  pagebreak()

  body
}
