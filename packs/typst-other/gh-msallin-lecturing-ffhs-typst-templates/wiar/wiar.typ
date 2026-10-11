// Typst-Umsetzung der FFHS-Formatvorlage "Wissenschaftliches Arbeiten" (wiAr).
//
// Enthaelt Seiten-, Schrift- und Absatzeinstellungen, das Deckblatt sowie
// Hilfsfunktionen fuer die Verzeichnisse und die Selbstaendigkeitserklaerung.
// Alle Masse stammen aus der Word-Vorlage (wiAr_FORMATVORLAGE.docx); die dort
// verwendeten Twips sind hier in cm bzw. pt umgerechnet (1 cm = 567 Twips,
// 1 pt = 20 Twips).
//
// Verwendung siehe main.typ.

// --- Grundmasse aus der Word-Vorlage ----------------------------------------

#let schriftfamilie = "Arial"

#let groesse-text = 11pt // Word "Standard": sz 22 Halbpunkt
#let groesse-klein = 10pt // Word "Textkoerper" / "Fusszeile": sz 20

// Arial-Metriken, Einheiten pro em = 2048: Ascender 1854, Descender 434,
// Zeilenzwischenraum 67. Words einfache Zeilenhoehe ist deren Summe. Der
// Zwischenraum gehoert dabei nach oben, nicht nach unten -- daher arial-oben.
#let arial-faktor = 1.15 // (1854 + 434 + 67) / 2048
#let arial-oben = 0.938em // (1854 + 67) / 2048
#let arial-zeile = arial-faktor * 1em

// Words Zeilenbox als Typst-Textrahmen.
//
// Bei mehrfachem Zeilenabstand streckt Word die Zeilenbox und legt den
// Zusatzabstand *unter* die Grundlinie; der Text bleibt oben in der Box.
// Typsts Rahmen endet dagegen standardmaessig auf der Grundlinie, wodurch der
// Abstand nach einem Absatz -- besonders nach einer Ueberschrift -- deutlich zu
// klein ausfaellt. Mit expliziten Kanten stimmt die Box mit Word ueberein und
// "Abstand vor/nach" laesst sich unveraendert als Blockabstand uebernehmen.
//
// Beispiel: faktor 1.5 bei 11 pt -> Box 1.725em = 18.98 pt, davon 10.32 pt
// ueber und 8.66 pt unter der Grundlinie (Word gemessen: 18.96 pt).
#let zeilenbox(faktor) = (
  top-edge: arial-oben,
  bottom-edge: arial-oben - faktor * arial-zeile,
)

// Zeilenabstaende der Vorlage: Standard 1.5, alle uebrigen Stile einfach.
#let zeilenbox-standard = zeilenbox(1.5)
#let zeilenbox-einfach = zeilenbox(1.0)

// Einfache Zeilenhoehe des Grundtexts, absolut statt in em -- fuer Leerzeilen
// und fuer die Kopfzeilenhoehe, die ausserhalb des Textflusses gebraucht wird.
#let grundzeile = arial-faktor * groesse-text

// Word gibt den Abstand von der Seitenkante zur Kopfzeile an, Typst den
// Abstand vom oberen Textrand zur *Unterkante* der Kopfzeile.
#let kopfzeilen-abstand(rand-oben, word-abstand, zeilen) = (
  rand-oben - word-abstand - zeilen * grundzeile
)

// Word setzt "Abstand davor" auch am Anfang einer Seite, Typst unterdrueckt
// Blockabstaende dort. Ein Platzhalter ohne Hoehe stellt das Verhalten her:
// der Folgeblock ist dann nicht mehr der erste und behaelt seinen Abstand.
#let abstand-am-seitenanfang = block(height: 0pt, above: 0pt, below: 0pt)[]

// Word: ind left=720, hanging=720 bei Ueberschrift 1/2 -- die Nummer steht am
// linken Rand, der Text beginnt 1.27 cm weiter rechts.
#let nummernbreite = 1.27cm

#let seitenrand = (top: 3cm, bottom: 2.5cm, left: 3cm, right: 2.5cm)
#let seitenrand-deckblatt = (..seitenrand, top: 6cm)

// Abstand der Kopfzeile von der Seitenkante; auf dem Deckblatt doppelt so gross.
#let kopfzeile-oben = 1.5cm
#let deckblatt-kopfzeile = 3cm

// --- Bausteine ---------------------------------------------------------------

/// Unnummerierte Ueberschrift im Stil "Titel_Verzeichnisse" bzw. "Titel_ZF".
///
/// - titel: Beschriftung der Ueberschrift.
/// - im-inhaltsverzeichnis: true entspricht "Titel_Verzeichnisse" (erscheint im
///   Inhaltsverzeichnis, z. B. Abkuerzungen, Anhang), false entspricht
///   "Titel_ZF" (Abstract, Inhaltsverzeichnis selbst).
/// - umbruch: erzwingt einen Seitenumbruch davor, wie in der Word-Vorlage.
#let verzeichnis(titel, im-inhaltsverzeichnis: true, umbruch: true) = {
  if umbruch {
    pagebreak(weak: true)
    abstand-am-seitenanfang
  }
  heading(level: 1, numbering: none, outlined: im-inhaltsverzeichnis, titel)
}

/// Abkuerzungsverzeichnis als randlose zweispaltige Tabelle.
///
/// - eintraege: Liste von (Abkuerzung, Bedeutung)-Paaren.
#let abkuerzungsverzeichnis(eintraege) = {
  // Word: Spalte 2050 Twips, Zellenrand seitlich 70 Twips und oben/unten keiner
  // -- die Zeilen bleiben dadurch im Zeilenraster des Fliesstexts.
  table(
    columns: (3.6cm, 1fr),
    stroke: none,
    inset: (x: 3.5pt, y: 0pt),
    align: left,
    // Das Zerlegen ist kein Leerlauf: es erzwingt die Tupellaenge. Mit blossem
    // flatten() rutscht ein zu langer Eintrag stumm in die Nachbarspalte.
    ..eintraege.map(((abkuerzung, bedeutung)) => (abkuerzung, bedeutung)).flatten(),
  )
}

/// Hilfsmittelverzeichnis als dreispaltige Tabelle mit Rahmen.
///
/// - eintraege: Liste von (Hilfsmittel, Zweck, Betroffene Stellen)-Tripeln.
#let hilfsmittelverzeichnis(eintraege) = {
  // Word holt den seitlichen Abstand nicht aus dem Zellenrand, sondern aus der
  // Absatzeinrueckung ind left=107 Twips = 5.35 pt. Die Zeilenhoehe von
  // mindestens 270 Twips = 13.5 pt erreicht eine einzeilige Zelle bei 229 Twips
  // exaktem Zeilenabstand genau mit 1 pt senkrechtem Innenabstand.
  set text(size: groesse-klein, ..zeilenbox-einfach)
  set par(justify: false, spacing: 0pt)
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: 0.5pt,
    inset: (x: 5.35pt, y: 1pt),
    align: left,
    table.header(
      // Word markiert die Zeile nicht als Kopfzeile (kein tblHeader), sie wird
      // beim Seitenumbruch also nicht wiederholt.
      repeat: false,
      strong[Welches Hilfsmittel wurde eingesetzt?],
      strong[Wozu wurde das Hilfsmittel eingesetzt?],
      strong[Betroffene Stellen],
    ),
    ..eintraege.flatten(),
  )
}

/// Selbstaendigkeitserklaerung mit dem festen Wortlaut der FFHS.
#let selbstaendigkeitserklaerung() = {
  verzeichnis("Selbständigkeitserklärung")
  // Der Stil "Textkoerper" sieht 10 pt vor, der Absatz in der Vorlage
  // ueberschreibt das direkt auf 11 pt -- gerendert wird also 11 pt.
  // Die Listenabsaetze tragen ebenso uneinheitliche Direktformatierung
  // (Zeilenabstand 1.1375 / 1.15 / 1.158, Abstand davor 5 bis 42 Twips) --
  // Reste aus der Bearbeitungshistorie. Uebernommen wird der einheitliche
  // Faktor 1.15, der die tatsaechliche Wirkung in Word auf 0.1 pt trifft.
  set text(size: groesse-text, ..zeilenbox-einfach)
  set par(justify: false, spacing: 0pt)

  [Hiermit erkläre ich,]

  set text(..zeilenbox(1.15))
  set list(marker: [•], indent: 0.48cm, body-indent: 0.28cm, spacing: 0pt)
  list(
    [dass ich die vorliegende Arbeit selbstständig verfasst habe,],
    [dass alle sinngemäss und wörtlich übernommenen Textstellen aus fremden
      Quellen kenntlich gemacht wurden,],
    [dass alle mit Hilfsmitteln erbrachten Teile der Arbeit präzise deklariert
      wurden,],
    [dass keine anderen als die im Hilfsmittelverzeichnis aufgeführten
      Hilfsmittel verwendet wurden,],
    [dass das Thema, die Arbeit oder Teile davon nicht bereits Gegenstand eines
      Leistungsnachweises eines anderen Moduls waren, sofern dies nicht
      ausdrücklich mit der Referentin oder dem Referenten im Voraus vereinbart
      wurde,],
    [dass ich mir bewusst bin, dass meine Arbeit elektronisch auf Plagiate und
      auf Drittautorschaft menschlichen oder technischen Ursprungs überprüft
      werden kann und ich hiermit der FFHS das Nutzungsrecht so weit einräume,
      wie es für diese Verwaltungshandlungen notwendig ist.],
  )

  // Vier Leerzeilen im Format "Standard", wie in der Vorlage.
  v(4 * 1.5 * grundzeile)
  set text(..zeilenbox-einfach)
  [Ort, Datum, Unterschrift]
}

/// Schaltet auf den Hauptteil um: arabische Seitenzahlen, neu bei 1 beginnend.
///
/// Muss im Dokument auf oberster Ebene aufgerufen werden, damit die
/// set-Regel fuer die folgenden Seiten gilt:  #show: hauptteil
#let hauptteil(body) = {
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "1")
  abstand-am-seitenanfang
  body
}

// --- Vorlage -----------------------------------------------------------------

/// Haupt-Template. Setzt Seite, Schrift, Absaetze, Ueberschriften und gibt das
/// Deckblatt aus.
///
/// - titel: Titel der Arbeit (Deckblatt).
/// - untertitel: Untertitel oder Zusatz unter dem Titel; none blendet ihn aus.
/// - art: Bezeichnung der Arbeit, z. B. "Semesterarbeit: Wissenschaftliches Arbeiten".
/// - autor: Vorname und Name der verfassenden Person.
/// - ort-datum: Ortsangabe und Datum am Fuss des Deckblatts.
/// - studiengang: Zeile unter dem Logo in der Kopfzeile des Deckblatts.
/// - hochschule: erste Zeile in der Kopfzeile des Deckblatts.
/// - logo: Pfad zum Logo oder none.
/// - kopfzeile: optionaler Text in der Kopfzeile der Inhaltsseiten; none laesst
///   sie leer (die Word-Vorlage sieht dort "Evtl. Kopfzeile" vor).
#let wiar-arbeit(
  titel: "Titel",
  untertitel: "(evt. Untertitel, Foto usw.)",
  art: "Semesterarbeit: Wissenschaftliches Arbeiten",
  autor: "Vorname und Name des/r Studenten/in",
  ort-datum: "Wohnort, Datum",
  studiengang: "Studiengang XY",
  hochschule: "Fernfachhochschule Schweiz",
  logo: "assets/ffhs-logo.png",
  kopfzeile: none,
  body,
) = {
  set document(title: titel, author: autor)
  set text(font: schriftfamilie, size: groesse-text, lang: "de", region: "CH", ..zeilenbox-standard)
  // Die Zeilenhoehe steckt in der Zeilenbox, nicht im Durchschuss; "Standard"
  // hat in Word weder Abstand davor noch danach.
  set par(justify: true, leading: 0pt, spacing: 0pt)

  // Vorspann (Abstract, Verzeichnisse) traegt kleine roemische Seitenzahlen,
  // rechtsbuendig in der Fusszeile -- wie footer1..3 der Word-Vorlage.
  set page(
    paper: "a4",
    margin: seitenrand,
    header-ascent: kopfzeilen-abstand(seitenrand.top, kopfzeile-oben, 1),
    footer-descent: 1.25cm,
    numbering: "i",
    header: {
      set text(..zeilenbox-einfach)
      if kopfzeile != none { align(right, kopfzeile) }
    },
    footer: context align(
      right,
      text(size: groesse-klein, ..zeilenbox-einfach, counter(page).display()),
    ),
  )

  set heading(numbering: "1.1.1.1")
  show heading: it => {
    set text(weight: "bold")
    set par(justify: false)

    // Word unterscheidet Verzeichnistitel und Kapitelueberschrift am Stilnamen.
    // Typst kennt keine Stilnamen, hier dient die fehlende Nummer als Merkmal --
    // eine unnummerierte Ueberschrift wird deshalb auf jeder Ebene 16 pt gross
    // und gehoert immer ueber verzeichnis() gesetzt.
    if it.numbering == none {
      set text(size: 16pt, ..zeilenbox-einfach)
      block(above: 6pt, below: 12pt, sticky: true, it.body)
    } else {
      let groessen = (16pt, 14pt, 13pt, groesse-text)
      set text(size: groessen.at(it.level - 1, default: groesse-text))
      block(above: 12pt, below: 3pt, sticky: true, {
        set par(hanging-indent: nummernbreite)
        box(width: nummernbreite, counter(heading).display(it.numbering))
        it.body
      })
    }
  }

  show figure.caption: set text(size: groesse-klein)
  show figure: set block(above: 12pt, below: 12pt)

  page(
    margin: seitenrand-deckblatt,
    header-ascent: kopfzeilen-abstand(seitenrand-deckblatt.top, deckblatt-kopfzeile, 2),
    header: {
      set text(..zeilenbox-einfach)
      align(right, [#hochschule \ #studiengang])
    },
    // Das Logo ist in Word frei positioniert und zaehlt nicht zur Kopfzeilenhoehe;
    // als Seitenhintergrund gilt dasselbe. Word verankert es am Kopfzeilenanfang
    // und versetzt es von dort 5.77 mm nach links und 8.91 mm nach oben.
    background: if logo != none {
      place(
        top + left,
        dx: seitenrand.left - 5.77mm,
        dy: deckblatt-kopfzeile - 8.91mm,
        image(logo, width: 31.15mm),
      )
    },
    footer: none,
    numbering: none,
    {
      // Die Deckblattstile haben in Word einfachen Zeilenabstand. Titel und
      // Untertitel tragen zudem Direktformatierung, die die Stilwerte
      // ueberschreibt (Abstand davor 24 statt 42 pt, danach 120 statt 174 pt);
      // massgebend ist, was die Vorlage tatsaechlich setzt.
      set text(..zeilenbox-einfach)
      set par(justify: false)
      set align(center)

      abstand-am-seitenanfang

      block(above: 24pt, below: 24pt, text(size: 36pt, weight: "bold", titel))

      if untertitel != none {
        block(below: 120pt, text(size: 18pt, untertitel))
      } else {
        v(120pt)
      }

      let deckblatt-text1 = t => block(above: 18pt, below: 18pt, text(size: 16pt, weight: "bold", t))
      deckblatt-text1(art)
      deckblatt-text1[von]
      deckblatt-text1(autor)

      // Leerer Absatz im Format "Standard": eine Zeilenbox mit Faktor 1.5.
      block(height: 1.5 * grundzeile, below: 0pt)[]

      block(above: 36pt, text(size: 12pt, weight: "bold", ort-datum))
    },
  )

  body
}

/// Inhaltsverzeichnis im Stil der Word-Vorlage: Ebene 1 fett, Ebenen 2 und 3
/// eingerueckt (Word: 0.63 cm bzw. 1.90 cm).
///
/// - tiefe: tiefste aufgenommene Ueberschriftenebene; die Vorlage nimmt 1 bis 3.
#let inhaltsverzeichnis(tiefe: 3) = {
  verzeichnis("Inhaltsverzeichnis", im-inhaltsverzeichnis: false)
  show outline.entry.where(level: 1): set text(weight: "bold")
  // Word setzt nur "Verzeichnis1" bis "Verzeichnis3"; tiefere Ebenen behalten
  // deshalb den Einzug der dritten statt zu scheitern.
  let einzuege = (0cm, 0.63cm, 1.9cm)
  outline(title: none, depth: tiefe, indent: n => einzuege.at(n, default: einzuege.last()))
}

/// Abbildungs- bzw. Tabellenverzeichnis aus den figure-Elementen des Dokuments.
#let abbildungsverzeichnis() = {
  verzeichnis("Abbildungsverzeichnis")
  outline(title: none, target: figure.where(kind: image))
}

#let tabellenverzeichnis() = {
  verzeichnis("Tabellenverzeichnis")
  outline(title: none, target: figure.where(kind: table))
}
