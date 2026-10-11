#import "../src/lib.typ": bibliography_section, project

#let cite_display = (
  "gnd01": "GND01",
  "typst_docs": "Typst",
  "claude_ai": "Claude",
)

#show: project.with(
  last_name: "Mustermann",
  first_name: "Max",
  assignment_code: "B-XXXX-XXXXX-XX",
  street: "Musterstraße 1",
  zip_city: "12345 Musterstadt",
  student_id: "900123456",
  course_id: "XXXXXXX",
  assignment_title: "Grundlagen der Informatik",
  b_exam_name: "Name der B-Aufgabe",
  edition: "XXXXXXX",
  cite_display: cite_display,
)

#include "tasks/task1.typ"
#include "tasks/task2.typ"
#pagebreak()
#include "tasks/task3.typ"

#bibliography_section(
  bibliography(
    "references.bib",
    style: "wbh-numeric.csl",
    title: "Literaturverzeichnis",
    full: true,
  ),
  cite_display: cite_display,
)

#v(2em)
#text(size: 0.9em, style: "italic")[
  *Hinweis zum Einsatz von KI-Hilfsmitteln:* Bei der Erstellung dieser Arbeit wurde das KI-Sprachmodell @claude_ai zur Unterstützung bei der Formulierung eingesetzt. Verwendete Prompts waren z. B. "Verbessere Rechtschreibung und Grammatik in diesem Textabschnitt".
]
