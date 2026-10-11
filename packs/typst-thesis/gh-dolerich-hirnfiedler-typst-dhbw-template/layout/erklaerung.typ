#let erklaerung(project_type: "", title: "") = {
  box(stroke: black, inset: 10pt)[#align(center, [*Erklärung*])
    #align(
      left,
      [Ich versichere hiermit, dass ich meine #project_type;aarbeit mit dem Thema: #title selbstständig verfasst und kein anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt],
    )
    #v(5em)
    #table(
      columns: (auto, auto, 1fr, auto),
      stroke: none,
      [#line(length: 4cm)], [#line(length: 3cm)], [], [#line(length: 7cm)],
      [#align(center, [Ort])],
      [#align(center, [Datum])],
      [],
      [#align(center, [Unterschrift])],
    )
  ]
}
