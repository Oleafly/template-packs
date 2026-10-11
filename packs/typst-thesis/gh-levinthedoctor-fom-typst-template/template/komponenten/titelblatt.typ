// =============================================================================
// FOM-Template: Titelblatt (Leitfaden 2.1, Muster in Anhang 3 und 4)
// =============================================================================
// Zwei Varianten:
//   - Abschlussarbeit (Bachelor-/Master-Thesis) nach Anhang 4 – zentriert.
//     Hinweis des Leitfadens: Das offizielle Titelblatt für Abschlussarbeiten
//     wird von der FOM im Online-Campus bereitgestellt und kann dieses
//     Titelblatt ersetzen.
//   - Seminararbeit nach Anhang 3 – linksbündig, von Studierenden selbst
//     zu erstellen.
//
// Das FOM-Logo (abbildungen/fom-logo.svg) ist markenrechtlich geschützt und
// nur für Arbeiten an der FOM bestimmt. Über den Parameter `logo` kann eine
// beliebige Bilddatei eingebunden werden,
// z. B. logo: image("abbildungen/fom-logo.svg", width: 2.2cm).

#let _datum-formatieren(datum) = {
  if type(datum) == datetime {
    datum.display("[day].[month].[year]")
  } else {
    datum
  }
}

// `wortanzahl: auto` liest die Metadaten-Marke <word-count>, die main.typ im
// Textteil setzt (wordometer: #metadata(total.words) <word-count>). Muss
// innerhalb von context aufgerufen werden. Ohne Marke bleibt die Zeile leer.
#let _wortanzahl-aufloesen(wortanzahl) = {
  if wortanzahl != auto {
    return wortanzahl
  }
  let treffer = query(<word-count>)
  if treffer.len() > 0 { treffer.first().value }
}

// Mittelteil beider Titelblätter (Anhang 3 wie Anhang 4): optionaler Grad,
// "über das Thema" mit Titel sowie "von" mit Verfasserangabe.
#let _thema-und-verfasser(grad: none, titel: none, autor: none) = {
  if grad != none {
    v(3em)
    [zur Erlangung des Grades eines]
    linebreak()
    text(size: 13pt)[#grad]
  }

  v(3em)
  [über das Thema]
  v(1em)
  block(text(size: 14pt, weight: "bold")[#titel])
  [von]
  block[#autor]
}

// Titelblatt für Abschlussarbeiten (Anhang 4).
#let titelblatt-abschlussarbeit(
  hochschule: "FOM Hochschule für Oekonomie & Management",
  typ: "Bachelor-Thesis",
  studiengang: none,
  grad: none,
  titel: none,
  autor: none,
  erstgutachter: none,
  matrikelnummer: none,
  abgabedatum: none,
  logo: none,
) = {
  set align(center)
  set par(justify: false)

  // Optische Zentrierung auf die Blattmitte: Der Satzspiegel ist wegen des
  // Bundstegs asymmetrisch (links 4 cm, rechts 2 cm, Leitfaden 1.2 Nr. 2),
  // seine Mittelachse liegt also 1 cm rechts der Papiermitte. pad(right: 2cm)
  // verschmälert den zentrierten Bereich, sodass Logo, Hochschule, Titel usw.
  // papiermittig stehen. Der Block unten (Erstgutachter …) bleibt bewusst am
  // linken Textrand (Anhang 4).
  pad(right: 2cm)[
    #if logo != none {
      logo
      v(1em)
    }
    #text(size: 14pt, weight: "bold")[#hochschule]

    #v(3.5em)
    #text(weight: "bold")[#typ]
    #if studiengang != none {
      linebreak()
      [im Studiengang #studiengang]
    }

    #_thema-und-verfasser(grad: grad, titel: titel, autor: autor)
  ]

  v(1fr)
  align(left)[
    #grid(
      columns: (auto, auto),
      column-gutter: 2.5em,
      row-gutter: 1em,
      [Erstgutachter:], [#erstgutachter],
      [Matrikelnummer:], [#matrikelnummer],
      [Abgabedatum:], [#_datum-formatieren(abgabedatum)],
    )
  ]
  pagebreak()
}

// Titelblatt für Seminararbeiten (Anhang 3).
#let titelblatt-seminararbeit(
  hochschule: "FOM Hochschule für Oekonomie & Management",
  studienzentrum: none,
  typ: "Seminararbeit",
  studiengang: none,
  grad: none,
  modul: none,
  titel: none,
  autor: none,
  betreuer: none,
  matrikelnummer: none,
  abgabedatum: none,
  wortanzahl: auto, // auto = aus der Marke <word-count> lesen, none = ohne Zeile
  logo: none,
) = {
  set align(left)
  set par(justify: false)

  // Optische Zentrierung auf die Blattmitte wie beim Abschluss-Titelblatt
  // (siehe Kommentar dort); der Datenblock unten bleibt am linken Textrand.
  pad(right: 2cm)[
    #if logo != none {
      logo
      v(1em)
    }
    #text(size: 14pt, weight: "bold")[#hochschule]
    #if studienzentrum != none {
      linebreak()
      [#studienzentrum]
    }

    #v(3.5em)
    #text(weight: "bold")[#typ]
    #if modul != none {
      linebreak()
      [in #modul]
    }
    #if studiengang != none {
      linebreak()
      [im Studiengang #studiengang]
    }

    #_thema-und-verfasser(grad: grad, titel: titel, autor: autor)
  ]

  v(1fr)
  v(1fr)
  align(left)[
    // Der Grid steht im context, damit die Zeile "Wortanzahl" ganz entfällt,
    // wenn keine Zahl gesetzt bzw. keine Marke <word-count> vorhanden ist.
    #context {
      let zeilen = (
        [Betreuer(in):],
        [#betreuer],
        [Matrikelnummer:],
        [#matrikelnummer],
        [Abgabedatum:],
        [#_datum-formatieren(abgabedatum)],
      )
      let anzahl = _wortanzahl-aufloesen(wortanzahl)
      if anzahl != none {
        zeilen += ([Wortanzahl:], [#anzahl])
      }
      grid(
        columns: (auto, auto),
        column-gutter: 2.5em,
        row-gutter: 1em,
        ..zeilen,
      )
    }
  ]
  pagebreak()
}
