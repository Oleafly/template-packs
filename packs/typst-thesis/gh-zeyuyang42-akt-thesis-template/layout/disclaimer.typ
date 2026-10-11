#import "../metadata.typ": body-font, sans-font

// Statutory declaration required by TU Berlin. Do not change the wording.
#let disclaimer() = {

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "I",
    number-align: center,
  )

  set text(
    font: body-font,
    size: 12pt,
    lang: "en"
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- Disclaimer ---
  align(left, text(font: sans-font, 2em, weight: 700, "Eidesstattliche Erklärung"))
  v(10mm)
  text([
    Hiermit erkläre ich an Eides statt gegenüber der Fakultät I der Technischen Universität Berlin, dass die vorliegende, dieser Erklärung angefügte Arbeit selbstständig und nur unter Zuhilfenahme der im Literaturverzeichnis genannten Quellen und Hilfsmittel angefertigt wurde. Alle Stellen der Arbeit, die anderen Werken dem Wortlaut oder dem Sinn nach entnommen wurden, sind kenntlich gemacht. Ich reiche die Arbeit erstmals als Prüfungsleistung ein. Ich versichere, dass diese Arbeit oder wesentliche Teile dieser Arbeit nicht bereits dem Leistungserwerb in einer anderen Lehrveranstaltung zugrunde lagen
  ])

  v(5mm)
  text([
    Mit meiner Unterschrift bestätige ich, dass ich über fachübliche Zitierregeln unterrichtet worden bin und verstanden habe. Die im betroffenen Fachgebiet üblichen Zitiervorschriften sind eingehalten worden.
  ])

  v(5mm)
  text("Eine Überprüfung der Arbeit auf Plagiate mithilfe elektronischer Hilfsmittel darf vorgenommen werden.")

  v(5cm)
  grid(
    columns: 3,
    gutter: 5mm,
    text("____________"), h(55mm), "____________",
    text("Ort, Datum"),   h(55mm), "Unterschrift",
  )
}
