#import "template.typ": template

#show: template.with(
  title: [Ataskaitos pavadinimas],
  subtitle: [XXX Praktikos ataskaita],
  year: [2025],
  authors: (
    (
      [Vardaitis Pavardaitis],
      "vardaitis.pavardaitis@mif.stud.vu.lt",
    ),
  ),
  institution: [Norfos mažmena, UAB],
  supervisor: [vyr. programuotojas Vardaitis Pavardaitis],
  university_supervisor: [Dr. Vardaitis Pavardaitis],
)

= Įvadas

= Analitinė dalis

Bazel surinkimo sistema yra ... #cite(<example-article>)

= Metodinė dalis

= Įgyvendinimo dalis

= Išvados

#bibliography("bibliography.bib", title: "Literatūra")
