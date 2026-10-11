#import "../../template.typ": doc

// ##################################################
// Titelseite -- ohne Kopfzeile (numbering global "none")
// ##################################################
// Die Titelseite nutzt die globalen Seiteneinstellungen: numbering ist global
// "none", daher blendet header-content die Kopfzeile automatisch aus.
#let title-page = {
  // HFU-Logo oben rechts, Hoehe 3cm
  align(right, image("../pictures/hfu.jpg", height: 3cm))

  // Titel
  align(center)[
    #set par(leading: 0.65em)
    #text(size: 18pt)[#doc.artDerArbeit] \
    #v(5mm)
    #text(size: 18pt)[im Studiengang] \
    #v(5mm)
    #text(size: 18pt)[#doc.studiengang] \
    #v(1cm)
    #set par(leading: 1em)
    #text(size: 22pt, weight: "bold")[#doc.title] \
    #v(5mm)
    #set par(leading: 0.65em)
    #text(size: 18pt)[#doc.untertitel] \
    #v(5mm)
  ]

  // Zusatzinformationen unten
  v(1fr)
  align(center)[
    #set par(leading: 0.65em)
    // Grosser Abstand zwischen den beschrifteten Zeilen,
    // enger Abstand fuer die Folgezeilen unter "Vorgelegt von".
    #grid(
      columns: (auto, auto, auto),
      column-gutter: 0.6em,
      row-gutter: (1.6em, 1.6em, 1.6em, 0.5em, 0.5em, 0.5em),
      align: (left, center, left),
      [Referent:in],  [:], [#doc.ersterReferent],
      [Korreferent:in], [:], [#doc.korreferent],
      [Vorgelegt am], [:], [#doc.abgabedatum],
      [Vorgelegt von], [:], [#doc.vorname #doc.nachname],
      [], [], [Matrikelnummer: #doc.matrikelnummer],
      [], [], [#doc.strasse, #doc.plz #doc.ort],
      [], [], [#doc.email],
    )
  ]
}
