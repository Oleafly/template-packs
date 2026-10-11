#let declaration(meta) = {
  set text(font: "Arial")
  heading(level: 1, numbering: none)[Selbstständigkeitserklärung]
  [
  #v(1em)
  Ich versicher hiermit, dass ich die vorliegende Arbeit mit dem Thema:\
  #v(0.5em)
  ]
  align(center)[
      #text(11pt, weight: "bold")["#meta.title"]
  ]
  [
  selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.\
  \
  Verwendete Hillfsmittel: Tools und verwendete KI Hilfen nennen.
  #v(4em)
  ]
  grid(
  columns: (1fr, 1fr),
  [
    #text(11pt, weight: "bold")[--------------------------------------\
    Ort, Datum
    ]
  ],

  align(left)[
    #text(11pt, weight: "bold")[--------------------------------------\
    Unterschrift]
  ],
  )
}