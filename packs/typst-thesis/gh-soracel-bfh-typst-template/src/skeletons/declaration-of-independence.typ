#let DeclarationOfIndependence(
  doc,
  datePlace: image,
  signature: image,
) = [
  = Selbstständigkeitserklärung
  Hiermit erkläre ich, dass ich die vorliegende Arbeit selbstständig und ohne fremde Hilfe verfasst und keine anderen
  Hilfsmittel als die angegebenen verwendet habe.

  Insbesondere versichere ich, dass ich alle wörtlichen und sinngemässen Übernahmen aus anderen Werken als solche
  kenntlich gemacht habe.

  #v(1cm)
  #box(
    width: 35%,
    datePlace
  )
  #v(-0.5cm)
  #grid(
    columns: 2,
    line(length: 6cm), [#v(-0.25cm) #h(0.75cm) (Ort, Datum)],
  )

  #v(1cm)
  #box(
    width: 35%,
    signature
  )
  #v(-0.5cm)
  #grid(
    columns: 2,
    line(length: 6cm), [#v(-0.25cm) #h(0.75cm) (Unterschrift)],
  )
]
