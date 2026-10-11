#let abstractDE(title: "Zusammenfassung", layoutConfig: none) = {
  show: layoutConfig

  heading(numbering: none, outlined: false, bookmarked: true, title)

  v(1em)

  text()[
    Kurze Zusammenfassung des Inhaltes in deutscher Sprache von ca. einer Seite länge. Dabei sollte vor allem auf die folgenden Punkte eingegangen werden: \
    \
    - Motivation: Wieso ist diese Arbeit entstanden? Warum ist das Thema der Arbeit (für die Allgemeinheit) interessant? Dabei sollte die Motivation von der konkreten Aufgabenstellung, z.B. durch eine Firma, weitestgehend abstrahiert werden. 
    - Inhalt: Was ist Inhalt der Arbeit? Was genau wird in der Arbeit behandelt? Hier sollte kurz auf Methodik und Arbeitsweise eingegangen werden.
    - Ergebnisse: Was sind die Ergebnisse der Arbeit? Ein kurzer Überblick über die wichtigsten Ergebnisse als Teaser, um die Arbeit vollständig zu lesen. \
    \
    BTW: A great guide by Kent Beck how to write good abstracts can be found here:
  ]

  align(center, [
    https://plg.uwaterloo.ca/~migod/research/beckOOPSLA.html]
  )
}
