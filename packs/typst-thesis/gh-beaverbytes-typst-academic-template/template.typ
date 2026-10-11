// template.typ

/*
 * ============================================================
 * GRUNDEINSTELLUNGEN UND DOKUMENTLAYOUT
 * ============================================================
 */

// Globale Stilkonstanten — hier zentral anpassen, wirkt im gesamten Dokument.
#let default-font = "Arial"                  // Schriftart Fließtext und Überschriften
#let body-size = 11pt                        // Schriftgröße Fließtext
#let caption-size = 10pt                     // Schriftgröße Captions, Quellen, Hinweise
#let hinweis-quelle-standardabstand = 2pt    // Vertikaler Abstand zwischen Hinweis und Quelle

#let arbeit(body) = [
  #set page(
    paper: "a4",          // Papierformat, z. B. "a4", "us-letter"
    margin: (             // Seitenränder
      top: 2cm,
      bottom: 2cm,
      left: 2cm,
      right: 2cm,
    ),
  )

  #set text(
    font: default-font,
    size: body-size,
    lang: "de",           // Sprachcode, beeinflusst Silbentrennung und Anführungszeichen
    fill: black,          // Textfarbe
    hyphenate: true,
    top-edge: 0.8em,
    bottom-edge: -0.2em        
  )


  #set par(
    justify: true,            // true = Blocksatz, false = Linksbündig
    leading: 0.5em,           // Zeilenabstand innerhalb eines Absatzes
    first-line-indent: 0pt,   // Erstzeileneinzug
    spacing: 6pt,             // Abstand zwischen Absätzen
  )

  #set heading(numbering: "1.1")   // Nummerierungsschema: "1.1" -> 1, 1.1, 1.1.1; "I" -> röm.

  // @-Verweise auf Anhänge/Tabellen/Abbildungen rendern nur die Nummer
  // (z. B. "A1", "5") als klickbarer Link. Aktiv über `label:`-Parameter
  // der jeweiligen Funktion.
  #show ref: it => {
    let el = it.element
    if el != none and el.func() == figure and el.kind in ("anhang", "tabelle", "abbildung") {
      link(it.target, el.supplement)
    } else {
      it
    }
  }

  // Überschriftengrößen pro Ebene — hier anpassen, um die Hierarchie zu skalieren.
#show heading: it => {
  let level = it.level

  let heading-size = 12pt

  let spacing-above = if level == 1 {
    12pt
  } else {
    6pt
  }

  block(
    above: spacing-above,
    below: 6pt,
  )[
    #text(font: default-font, size: heading-size, weight: "bold")[
      #if it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
        h(0.6em)
      }
      #it.body
    ]
  ]
}

  #body
]

/*
 * ============================================================
 * GEMEINSAME HILFSFUNKTIONEN
 * ============================================================
 */

// Punktlinie für Verzeichniseinträge (Titel ........ Seite).
#let punktlinie() = box(width: 1fr, repeat[.])

// Einheitliche Ausgabe von optionalem Hinweis und Quellenangabe unter Tabellen/Abbildungen.
#let quelle-und-hinweis(
  hinweis: none,
  quelle: "Eigene Darstellung",
  abstand: hinweis-quelle-standardabstand,
) = [
  #set text(
    font: default-font,
    size: caption-size,
  )

  #set par(
    justify: true,
    leading: 2pt,
    spacing: 0pt,
    first-line-indent: 0pt,
  )

  #set align(left)

  #if hinweis != none [
    #block(below: abstand)[
      #hinweis
    ]
  ]

  #block[
    Quelle: #quelle
  ]
]

/*
 * ============================================================
 * ANHANGSSTRUKTUR UND ANHANGSVERZEICHNIS
 * ============================================================
 */

// Zähler für Hauptanhänge (A, B, …) und Anhangteile (A1, A2, …).
#let anhang-counter = counter("anhang")
#let anhangteil-counter = counter("anhangteil")

// Lokale Zähler für Anhangs-Tabellen/-Abbildungen. Werden pro Anhang(teil) auf
// 0 zurückgesetzt — Nur EINE Abbildung/Tabelle je Anhangteil.
#let tab-anhang-counter = counter("tabelle-im-anhang")
#let abb-anhang-counter = counter("abbildung-im-anhang")

#let anhangsverzeichnis() = context {
  let eintraege = query(<anhang-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none, outlined: true)[Anhangsverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()
      // Anhangteile werden eingerückt und normal gewichtet, Hauptanhänge fett.
      let einzug = if daten.ebene == 1 { 0pt } else { 1em }
      let gewicht = if daten.ebene == 1 { "bold" } else { "regular" }

      link(eintrag.location())[
        #h(einzug)
        #text(weight: gewicht)[Anhang #daten.nr: #daten.titel]
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

// Hauptanhang. `label:` ermöglicht im Text einen klickbaren Verweis via @label.
#let anhang(titel, body, label: none) = [
  #anhang-counter.step()
  #anhangteil-counter.update(0)
  #tab-anhang-counter.update(0)
  #abb-anhang-counter.update(0)

  #context {
    let nr = numbering("A", anhang-counter.get().at(0))

    // Eintrag fürs Anhangsverzeichnis
    [
      #metadata((
        ebene: 1, 
        nr: nr, 
        titel: titel
        )) <anhang-eintrag>
    ]

align(center)[
  #heading(numbering: none, outlined: true)[
    Anhang #nr:
    #titel
  ]
]
    // Unsichtbarer Anker für @label-Verweise.
    if label != none {
      [
        #figure(
          kind: "anhang", 
          supplement: nr, 
          numbering: "1",
          caption: none,
          outlined: false, 
          []
          )#label
      ]
    }
  }

  #body
]

// Anhangteil (A1, A2, …). `label:` analog zu `anhang(...)`.
#let anhangteil(titel, body, label: none) = [
  #anhangteil-counter.step()
  #tab-anhang-counter.update(0)
  #abb-anhang-counter.update(0)

  #context {
    let haupt = numbering("A", anhang-counter.get().at(0))
    let teil = anhangteil-counter.get().at(0)
    let nr = str(haupt) + str(teil)

    [
      #metadata((
        ebene: 2, 
        nr: nr, 
        titel: titel
        )) <anhang-eintrag>
    ]
    
    align(center)[
      #text(size: 12pt, weight: "bold")[Anhang #nr: #titel]
    ]

    if label != none {
      [
        #figure(
          kind: "anhang", 
          supplement: nr, 
          numbering: "1",
          caption: none, 
          outlined: false, 
          []
          )#label
      ]
    }
  }


  #body
]

/*
 * ============================================================
 * ABBILDUNGEN UND ABBILDUNGSVERZEICHNIS
 * ============================================================
 */

#let abb-counter = counter("abbildung")

#let abbildungsverzeichnis() = context {
  let eintraege = query(<abb-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none)[Abbildungsverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()

      link(eintrag.location())[
        Abb. #daten.nr #daten.titel
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

// Abbildung mit Caption und Quellenangabe.
//
// Parameter:
//   pfad      -> Bilddatei (z. B. "/assets/foo.png")
//   titel     -> Bildunterschrift; im Anhang ungenutzt (s. im-anhang)
//   hinweis   -> optionaler Hinweistext über der Quelle
//   quelle    -> Quellenangabe (Standard: "Eigene Darstellung.")
//   breite    -> Bildbreite, z. B. 100%, 8cm, 0.5fr
//   im-anhang -> false: normale Haupttext-Abbildung mit Nummer und Eintrag im
//                       Abbildungsverzeichnis.
//                true:  Abbildung steht in einem Anhang(teil). Keine eigene
//                       Caption (Anhang-Titel = Bildtitel nach APA-Konvention),
//                       kein Eintrag im Verzeichnis, max. 1 Bild pro Anhangteil.
//   label     -> ermöglicht `Abb. @label`-Verweis im Text. Nur außerhalb von Anhängen.
#let abbildung(
  pfad,
  titel,
  hinweis: none,
  quelle: "Eigene Darstellung.",
  breite: 100%,
  hinweis-quelle-abstand: hinweis-quelle-standardabstand,
  im-anhang: false,
  label: none,
) = [
  #if im-anhang {
    abb-anhang-counter.step()
  } else {
    abb-counter.step()
  }

  #context {
    // max. eine Anhangs-Abbildung pro Bereich.
    if im-anhang {
      let lokal = abb-anhang-counter.get().at(0)
      assert(
        lokal <= 1,
        message: "Pro Anhang bzw. Anhangteil ist nur eine Abbildung mit "
          + "`im-anhang: true` erlaubt. Für mehrere Abbildungen je Bereich "
          + "legen Sie bitte zusätzliche `anhangteil(...)`-Abschnitte an.",
      )
    }

    let nr = if im-anhang { none } else { str(abb-counter.get().at(0)) }

    block(
      above: 12pt,           // Abstand vor der Abbildung
      below: 6pt,           // Abstand nach der Abbildung
      breakable: false,      // verhindert Seitenumbruch innerhalb des Blocks
    )[
      // Eintrag fürs Abbildungsverzeichnis nur außerhalb von Anhängen.
      #if not im-anhang [
        #metadata((
          nr: nr, 
          titel: titel
          )) <abb-eintrag>
      ]

      #grid(
        columns: (1fr, breite, 1fr),   // zentriert das Bild horizontal
        gutter: 0pt,

        [],
        [
          #set par(
            justify: false, 
            first-line-indent: 0pt
          )

          #if not im-anhang [
            #text(size: caption-size)[Abb. #nr #titel]

            // Anker für @label-Verweise (nur außerhalb von Anhängen sinnvoll).
            #if label != none [
              #figure(
                kind: "abbildung", 
                supplement: nr, 
                numbering: "1",
                caption: none, 
                outlined: false, 
                []
                )#label
            ]

            #v(6pt)
          ]

          #image(pfad, width: 100%)
          #v(3pt)               // Abstand zwischen Bild und Quelle/Hinweis

          #quelle-und-hinweis(
            hinweis: hinweis,
            quelle: quelle,
            abstand: hinweis-quelle-abstand,
          )
        ],
        [],
      )
    ]
  }
]

/*
 * ============================================================
 * TABELLEN UND TABELLENVERZEICHNIS
 * ============================================================
 */

#let tab-counter = counter("tabelle")

#let tabellenverzeichnis() = context {
  let eintraege = query(<tab-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none)[Tabellenverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()

      link(eintrag.location())[
        Tab. #daten.nr #daten.titel
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

// Tabelle mit Caption und Quellenangabe.
//
// Parameter:
//   titel     -> Tabellenüberschrift; im Anhang ungenutzt (s. im-anhang)
//   hinweis   -> optionaler Hinweistext über der Quelle
//   quelle    -> Quellenangabe (Standard: "Eigene Darstellung.")
//   breite    -> auto: so breit wie Inhalt, zentriert
//                100%, 12cm, 0.5fr: feste/relative Breite
//                (bei expliziter Breite in #table flexible Spalten verwenden,
//                z. B. columns: (1fr, 1fr))
//   stil      -> "voll":       komplettes Linienraster (Standard)
//                "horizontal": nur waagrechte Trennlinien, keine Außenrahmen
//   im-anhang -> false: normale Haupttext-Tabelle mit Nummer und Eintrag im
//                       Tabellenverzeichnis.
//                true:  Tabelle steht in einem Anhang(teil). Keine eigene
//                       Caption (Anhang-Titel = Tabellentitel, APA-Konvention),
//                       kein Eintrag im Verzeichnis, max. 1 Tabelle pro Anhangteil.
//   label     -> ermöglicht `Tab. @label`-Verweis im Text. Nur außerhalb von Anhängen.
#let tabelle(
  titel,
  body,
  hinweis: none,
  quelle: "Eigene Darstellung.",
  hinweis-quelle-abstand: hinweis-quelle-standardabstand,
  breite: auto,
  stil: "voll",
  im-anhang: false,
  label: none,
) = [
  #if im-anhang {
    tab-anhang-counter.step()
  } else {
    tab-counter.step()
  }

  #context {
    // max. eine Anhangs-Tabelle pro Bereich.
    if im-anhang {
      let lokal = tab-anhang-counter.get().at(0)
      assert(
        lokal <= 1,
        message: "Pro Anhang bzw. Anhangteil ist nur eine Tabelle mit "
          + "`im-anhang: true` erlaubt. Für mehrere Tabellen je Bereich legen "
          + "Sie bitte zusätzliche `anhangteil(...)`-Abschnitte an.",
      )
    }

    let nr = if im-anhang { none } else { str(tab-counter.get().at(0)) }

    // Bei `breite: auto` natürliche Tabellenbreite messen, damit Titel/Quelle
    // linksbündig zur (zentrierten) Tabelle ausgerichtet sind.
    let tab-breite = if breite == auto {
      measure(body).width
    } else {
      breite
    }

    // Stil "horizontal": nur Trennlinien zwischen Zeilen, keine Außenrahmen,
    // keine vertikalen Linien.
    let body-styled = if stil == "horizontal" {
      [
        #show table: set table(
          stroke: (x, y) => (
            top: if y == 0 { none } else { 0.5pt + black },
            bottom: none,
            left: none,
            right: none,
          ),
        )
        #body
      ]
    } else {
      body
    }

    block(
      above: 12pt,            // Abstand vor der Tabelle
      below: 12pt,            // Abstand nach der Tabelle
      breakable: true,       // erlaubt Seitenumbruch innerhalb der Tabelle
      width: 100%,
    )[
      // Eintrag fürs Tabellenverzeichnis nur außerhalb von Anhängen.
      #if not im-anhang [
        #metadata((nr: nr, titel: titel)) <tab-eintrag>
        ]

      #align(center, block(width: tab-breite)[
        #set par(justify: false, first-line-indent: 0pt)
        #set align(left)

        #if not im-anhang [
          #text(size: caption-size)[Tab. #nr #titel]

          // Anker für @label-Verweise (nur außerhalb von Anhängen sinnvoll).
          #if label != none [
            #figure(kind: "tabelle", supplement: nr, numbering: "1",
                    caption: none, outlined: false, [])#label
          ]

          #v(6pt)
        ]

        #body-styled
        #v(6pt)               // Abstand zwischen Tabelle und Quelle/Hinweis

        #quelle-und-hinweis(
          hinweis: hinweis,
          quelle: quelle,
          abstand: hinweis-quelle-abstand,
        )
      ])
    ]
  }
]

/*
 * ============================================================
 * LITERATURVERZEICHNIS
 * ============================================================
 */

// Erzeugt das Literaturverzeichnis aus der BibTeX-Datei.
//   datei -> Pfad zur .bib-Datei
//   stil  -> Zitierstil, z. B. "apa", "ieee", "chicago-author-date"
//            (siehe Typst-Doku: https://typst.app/docs/reference/model/bibliography/)
#let literaturverzeichnis(
  datei: "references.bib",
  stil: "apa",
) = context {
  let zitate = query(cite)

  if zitate.len() > 0 [
    #heading(numbering: none, outlined: true)[Literaturverzeichnis]

    #[
      // Linksbündig mit hängendem Einzug.
      #set par(
        justify: false,
        leading: 0.5em,           // Zeilenabstand innerhalb eines Eintrags
        hanging-indent: 1.27cm,   // Einzug ab der zweiten Zeile
      )

      #bibliography(datei, style: stil, title: none)
    ]
  ] else [
    #bibliography(datei, style: stil, title: none)
  ]
}

/*
 * ============================================================
 * DECKBLATT
 * ============================================================
 */

// Alle Parameter werden auf dem Deckblatt zentriert angeordnet. Abstände und
// Schriftgrößen können bei Bedarf direkt unten im Body angepasst werden.
#let deckblatt(
  logo: "assets/beaverbytes-logo.svg",
  arbeitstyp: "Arbeitstyp",
  modul: "Modulname",
  institution: "Universität",
  studiengang: "Studium B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "XYZ123",
  betreuung: "Prof. Dr. Musterfrau",
  abgabedatum: datetime.today(),
) = [
  #set page(numbering: none)

  #align(center)[
    #image(logo, width: 6cm)        // Logo-Breite
    #v(2.6cm)                       // Abstand unter dem Logo

    #text(size: 14pt)[#arbeitstyp]
    #v(0.5cm)

    #text(size: 13pt)[#modul]
    #v(1.6cm)

    #text(size: 13pt)[#institution]
    #v(0.45cm)

    #text(size: 13pt)[#studiengang]
    #v(2.1cm)

    #text(size: 15pt, weight: "bold")[#titel]
    #v(2cm)

    #text(size: 13pt)[#autorin]
    #v(0.45cm)

    #text(size: 13pt)[Matrikelnummer: #matrikelnummer]
    #v(2cm)

    #text(size: 13pt)[Betreuende Person/ Tutor:in: #betreuung]
    #v(0.55cm)

    #text(size: 13pt)[
      Abgabedatum: #abgabedatum.display("[day padding:zero].[month padding:zero].[year]")
    ]
  ]

  #pagebreak()
]
