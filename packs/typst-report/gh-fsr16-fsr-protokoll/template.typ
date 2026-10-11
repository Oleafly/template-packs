#let anwesenheitsliste(anwesende) = [
  *Anwesende:* #anwesende
  #v(0.5em)
]

#let fsr-protokoll(
  datum: none,
  anwesende: "",
  oeffnung: datetime(hour: 16, minute: 15, second: 00),
  schliessung: none,
  geste: none,
  logo: "fsr-logo.png",
  body,
) = {
  set document(title: [Protokoll der FSR-Sitzung vom #datum.display("[day].[month].[year]")])
  set page(paper: "a4", margin: 2.5cm, numbering: "1")
  set text(font: ("Liberation Sans", "Arial", "Helvetica",), fallback: true, size: 12pt, lang: "de")
  set par(justify: false)

  show heading.where(level: 1): set heading(numbering: "TOP 1:")

  align(center)[
    #image(logo, width: 100%)
    #v(0.3em)
    #text(size: 1.5em, weight: "bold")[Protokoll der FSR-Sitzung]
    #v(0.2em)
    #text(size: 1em)[#datum.display("[day].[month].[year]")]
  ]
  v(1em)

  [*Öffnung der Sitzung:* #oeffnung.display("[hour]:[minute]") ]
  v(0.8em)

  anwesenheitsliste(anwesende)

  if geste != none {
    [*Geste des Tages:* #geste]
    v(0.5em)
  }

  body

  if schliessung != none {
    v(1em)
    [*Schließung der Sitzung:* #schliessung.display("[hour]:[minute]")]
  }
}

#let beschlussfaehigkeit(beschlussfaehig: true) = [
  = Feststellung der Beschlussfähigkeit
  - Beschlussfähigkeit #if beschlussfaehig [festgestellt] else [nicht festgestellt]
]

#let tagesordnung(genehmigt: true) = [
  = Genehmigung der Tagesordnung
  #if genehmigt [- Genehmigt]
]

#let protokoll(datum, genehmigt: true, vorbehalt: false) = [
  = Genehmigung des Protokolls vom #datum.display("[day].[month].[year]")
  #if genehmigt [
    - #if vorbehalt [Unter Vorbehalt Genehmigt] else [Genehmigt]
  ] else [
    - Nicht Genehmigt
  ]
]

#let naechstertermin(datum) = [
  = Nächster Sitzungstermin
  - Nächster Sitzungstermin am #datum.display("[day].[month].[year]")
]

#let pausierung(uhrzeit, fortsetzungszeitpunkt: none) = {
  v(1em)
  [Die Sitzung wurde um #uhrzeit.display("[hour]:[minute]") Uhr pausiert#if fortsetzungszeitpunkt != none [ und wird am #fortsetzungszeitpunkt.display("[day].[month].[year]") fortgesetzt].]

  if fortsetzungszeitpunkt != none {
    pagebreak()
    [*Wiedereröffnung der Sitzung:* #fortsetzungszeitpunkt.display("[day].[month].[year] [hour]:[minute]") Uhr]
    v(1em)
  }
}
