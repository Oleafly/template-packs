#let titlepage(
  title: "",
  degree: "",
  studiengang: "",
  author: "",
  matrikel_nummer: "",
  kurs: "",
  dhbw: "Duale Hochschule Baden-Württemberg",
  startDate: datetime,
  submissionDate: datetime,
  firmen_logo_path: "",
  dualer_partner: "",
  dualer_supervisor: "",
  dhbw_supervisor: "",
) = {
  let delta_time = submissionDate - startDate
  set page(
    margin: (left: 20mm, right: 20mm, bottom: 20mm, top: 15mm),
    numbering: none,
    number-align: center,
  )
  set text(
    size: 12pt,
    lang: "en",
  )
  set par(leading: .5em)

  //Title Page


  grid(
    columns: (auto, auto),
    rows:(70pt),
    align: (left, right),
    column-gutter: 2fr,
    if firmen_logo_path != "" {
      image(firmen_logo_path)
    } else {
      []
    },
    image("/assets/dhbw_logo.svg"),
  )
  v(10mm)
  align(center, text(2em, weight: 700, title))
  v(10mm)
  align(center, text(1.5em, weight: 100, degree))

  v(10mm)
  align(
    center,
    text(
      1.5em,
      weight: 100,
      [des Studiengangs ] + studiengang + linebreak() + [ an der ] + dhbw,
    ),
  )
  v(15mm)
  align(center, text(1.5em, weight: 100, [von]))
  // v(0mm)
  align(center, text(1.6em, weight: 600, author))
  v(10mm)
  align(
    center,
    text(1.5em, weight: 100, submissionDate.display("[day].[month].[year]")),
  )

  let content = (
    [Bearbeitungszeitraum],
    [ #calc.floor(delta_time.weeks()) Wochen],
    [Matrikelnummer, Kurs],
    [#matrikel_nummer, #kurs],
    [Dualer Partner],
    [#dualer_partner],
  )

  // Conditionally append a row if dualer_supervisor is provided and not empty
  if dualer_supervisor != "" {
    content.push([Betreuer*In des Dualen Partners])
    content.push([ #dualer_supervisor])
  }
  if dhbw_supervisor != "" {
    content.push([Betreuer*In der DHBW])
    content.push([#dhbw_supervisor])
  }

  align(
    bottom,
    table(
      stroke: none,
      columns: (auto, auto),
      column-gutter: 10em,
      ..content,
    ),
  )
}
