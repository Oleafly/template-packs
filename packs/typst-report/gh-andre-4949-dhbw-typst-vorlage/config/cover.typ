#import "functions.typ": *
#set page(
  margin: (top: 2cm, bottom: 4cm, left: 2.5cm, right: 2.5cm)
)
// Header with logos
#insertCompanyImage

#v(1cm)

#insertCoverText

#v(1fr)

// Bottom table with additional information
#set par(leading: 1.2em)

// Bottom table
#if document_type == "T3_3100" {
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 2,
    gutter: 6pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [], [#period],
    [*Matrikelnummer, Kurs*], [], [#matriculation_number, #course],
  )
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 1,
    gutter: 6pt,
    align: (left, left),
    [*Betreuer der DHBW #location_university*], [], [#evaluator],
  )
} else if document_type == "T3_3300" {
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 5,
    gutter: 6pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [], [#period],
    [*Matrikelnummer, Kurs*], [], [#matriculation_number, #course],
    [*Dualer Partner*], [], [#company_name, #company_location],
    [*Betreuer des Dualen Partners*], [], [#tutor],
    [*Gutachter der DHBW #location_university*], [], [#evaluator],
  )
} else {
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 4,
    gutter: 6pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [], [#period],
    [*Matrikelnummer, Kurs*], [], [#matriculation_number, #course],
    [*Dualer Partner*], [], [#company_name, #company_location],
    [*Betreuer des Dualen Partners*], [], [#tutor],
  )
}
