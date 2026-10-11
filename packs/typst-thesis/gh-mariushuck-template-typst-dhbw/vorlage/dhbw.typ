// =====================================================================
// dhbw.typ — Layout und Formatvorlagen einer DHBW-Arbeit
//
// Umsetzung der Formvorgaben aus:
//   "Hinweise zur Anfertigung von Projekt- und Bachelorarbeiten" (DHBW
//   Karlsruhe, Fakultät Wirtschaft) und den Vorgaben der wissenschaftlichen
//   Betreuung. Diese Dokumente sind die Quelle der Wahrheit; die Fassung
//   ändert sich von Jahrgang zu Jahrgang. Vor dem Schreiben einmal
//   gegenlesen, ob die unten kommentierten Werte noch gelten.
//
// Jede Vorgabe ist an der Stelle kommentiert, an der sie umgesetzt wird.
// Was sich in Typst NICHT umsetzen lässt, steht in ../README.md im
// Abschnitt "Was Typst nicht prüfen kann".
//
// In den Kapiteldateien wird NIE formatiert — kein `#text(...)`, kein
// `#set par(...)`, kein `#pagebreak()`. Alles Formale gehört hierher.
// =====================================================================

// ---------------------------------------------------------------------
// Zentrale Stellschrauben
// ---------------------------------------------------------------------

// Arial ist von der DHBW ausdrücklich zugelassen. Helvetica ist metrisch
// praktisch gleich und auf jedem Mac vorhanden.
//
// Die Liste enthält bewusst NUR Schriften, die lokal installiert sind —
// Typst warnt bei jedem Kompilierlauf über jede unbekannte Familie. Für
// einen Build auf einem Linux-Rechner (CI, Server) sind "Liberation Sans"
// und "Arimo" die metrischen Arial-Klone; dann hier ergänzen und die
// Warnungen auf dem Mac in Kauf nehmen.
//
// ACHTUNG: ZEILENABSTAND unten ist auf Arials Versalhöhe gerechnet. Eine
// andere Schrift verschiebt den Grundlinienabstand.
#let SCHRIFT = ("Arial", "Helvetica")

#let GROESSE_FLIESSTEXT = 12pt
#let GROESSE_BESCHRIFTUNG = 11pt // "eine Stufe kleiner als der Fließtext"
#let GROESSE_QUELLENZEILE = 10pt // Quelle unter Abbildung/Tabelle

// Zeilenabstand. Typst rechnet nicht in "Zeilen", sondern im
// Grundlinienabstand = leading + Versalhöhe. Deshalb muss man Words
// Zeilenbegriff einmal ausrechnen und danach immer diese Konstanten
// verwenden, nie eigene Punktwerte.
//
//   Arial, 12 pt:  1-zeilig  = 1,15 * 12 pt = 13,80 pt Grundlinienabstand
//                  1,5-zeilig                = 20,70 pt
//                  Versalhöhe = 0,716 em     =  8,59 pt
//
// Bei einer anderen Schrift als Arial ändern sich beide Faktoren.
#let ZEILENHOEHE_EINFACH = 1.15 * GROESSE_FLIESSTEXT // 13,80 pt
#let VERSALHOEHE = 0.716 * GROESSE_FLIESSTEXT //  8,59 pt

// leading für 1,5-zeiligen Abstand — der Normalfall im Fließtext
#let ZEILENABSTAND = 1.5 * ZEILENHOEHE_EINFACH - VERSALHOEHE // 12,11 pt

// leading für 1-zeiligen Abstand. Gebraucht innerhalb mehrzeiliger
// Überschriften und Verzeichniseinträge: "Umfasst eine Überschrift mehrere
// Zeilen, wird innerhalb der Überschrift ein 1-zeiliger Abstand gewählt."
#let ZEILENABSTAND_EINFACH = ZEILENHOEHE_EINFACH - VERSALHOEHE //  5,21 pt

// Dasselbe schriftgrößenunabhängig, für Überschriften und Beschriftungen:
// (1,15 - 0,716) em = 0,434 em. Bei 12 pt sind das dieselben 5,21 pt.
#let LEADING_EINZEILIG = 0.434em

// Absatzabstand. Vorgabe DHBW: "Abstand vor Absätzen: 6 Punkte",
// Abstand nach dem Absatz: 0.
//
// ACHTUNG, Unterschied zu Word: Word addiert die 6 pt auf den
// Zeilenabstand. Typsts `par.spacing` ERSETZT ihn dagegen. Mit 6 pt
// stünden zwei Absätze enger zusammen als zwei Zeilen desselben Absatzes,
// und die Absatzgrenzen wären nicht mehr zu erkennen. Der Wert muss
// deshalb Zeilenabstand + 6 pt sein.
#let ABSATZABSTAND = ZEILENABSTAND + 6pt

// ---------------------------------------------------------------------
// Hilfsfunktion: "31.08.2026" -> datetime
//
// Das Abgabedatum steht in `angaben` als Zeichenkette, weil es auf dem
// Titelblatt und in der Erklärung genau so erscheinen soll. Für die
// PDF-Metadaten braucht Typst ein `datetime` — damit beides aus derselben
// Quelle kommt, wird die Zeichenkette hier umgewandelt.
// ---------------------------------------------------------------------
#let _datum(s) = {
  let teile = s.split(".")
  assert(teile.len() == 3, message: "abgabedatum muss die Form TT.MM.JJJJ haben, ist: " + s)
  datetime(year: int(teile.at(2)), month: int(teile.at(1)), day: int(teile.at(0)))
}

// ---------------------------------------------------------------------
// Hauptfunktion — wird in main.typ als show-Regel angewandt:
//   #show: arbeit.with(angaben)
// ---------------------------------------------------------------------

#let arbeit(angaben, inhalt) = {
  // --- PDF-Metadaten -----------------------------------------------
  // Vorgabe zur Abgabe: Dateiname KURS_Nachname_Vorname_Art.pdf.
  // Titel und Autor gehören zusätzlich in die PDF-Eigenschaften.
  set document(
    title: angaben.titel,
    author: angaben.verfasser,
    date: _datum(angaben.abgabedatum),
  )

  // --- Seite -------------------------------------------------------
  // DIN A4, einseitig. Ränder oben 2,5 / unten 2,0 / links 3,5 / rechts 2,5 cm.
  // Kopf- und Fußzeile 1,25 cm vom Blattrand:
  //   header-ascent  = 2,5 cm - 1,25 cm = 1,25 cm
  //   footer-descent = 2,0 cm - 1,25 cm = 0,75 cm
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.0cm, left: 3.5cm, right: 2.5cm),
    header-ascent: 1.25cm,
    footer-descent: 0.75cm,
    numbering: none,
    header: none,
    footer: none,
  )

  // --- Fließtext ---------------------------------------------------
  set text(
    font: SCHRIFT,
    size: GROESSE_FLIESSTEXT,
    lang: "de",
    region: "DE",
    // Automatische Silbentrennung. Die Vorgabe nennt zusätzlich eine
    // "Silbentrennzone 0,3 cm – 0,5 cm" und "nicht mehr als drei
    // aufeinander folgende Trennstriche". Typst kennt beides nicht: es
    // trennt nach dem Wörterbuch für de-DE, ohne einstellbare Zone und
    // ohne Begrenzung der Trennfolge. Beides steht deshalb als nicht
    // umsetzbar in ../README.md und ist am fertigen PDF nachzusehen.
    hyphenate: true,
    // Absatzkontrolle: "Zur Vermeidung von 'Witwen' und 'Waisen' wird die
    // Absatzkontrolle im Dokument aktiviert." Typsts Entsprechung sind die
    // Kosten für Einzelzeilen am Seitenanfang bzw. -ende. 100 % ist die
    // Voreinstellung und verhindert sie nicht; ein hoher Wert tut es.
    costs: (widow: 500%, orphan: 500%, runt: 200%),
  )

  set par(
    justify: true, // Blocksatz
    leading: ZEILENABSTAND,
    spacing: ABSATZABSTAND,
    first-line-indent: 0pt, // keine Einrückung, Absätze trennt der Abstand
  )

  // Aufzählungen linksbündig (Vorgabe), nicht im Blocksatz
  show list: set par(justify: false)
  show enum: set par(justify: false)
  set list(indent: 0.5cm, spacing: ABSATZABSTAND)
  set enum(indent: 0.5cm, spacing: ABSATZABSTAND)

  // --- Überschriften ----------------------------------------------
  // Automatische Dezimalgliederung. NIE manuell nummerieren.
  set heading(numbering: "1.1")

  // Abstände um Überschriften. Die Vorgabe nennt einen Bereich:
  // "ein Abstand vor dem Absatz von 12-24 Punkten (außer am Seitenbeginn)
  // und nach dem Absatz von 9-18 Punkten" (Empfehlung). Hier ist bewusst
  // das OBERE Ende gewählt. Wer Seiten sparen muss, geht bis 12 pt bzw.
  // 9 pt herunter — darunter wird es vorgabenwidrig. Kostenpunkt der
  // großzügigen Variante: rund eine halbe Seite je zehn Unterkapitel.
  //
  // ZWINGEND dabei einzuhalten ("soll"): "Der Abstand zum zugehörigen Text
  // soll erkennbar, jedoch kleiner als zum vorhergehenden Text sein." Der
  // Wert unter der Überschrift muss also stets kleiner bleiben als der
  // darüber — hier 18 < 24 und 14 < 20.
  //
  // Kapitel: 16 pt fett, immer auf neuer Seite. `above` ist dort ohne
  // Wirkung, weil die Überschrift oben am Satzspiegel steht. Damit ist die
  // Vorgabe "Umbruch nur am Kapitelende" strukturell erfüllt — manuelle
  // Seitenumbrüche sind nicht nötig und auch nicht erlaubt.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "bold")
    // mehrzeilige Überschriften 1-zeilig (Vorgabe)
    set par(justify: false, leading: LEADING_EINZEILIG)
    // "Bei mehrzeiligen Überschriften ist auf die Silbentrennung zu
    // verzichten und die Überschrift manuell in logisch zusammenhängende
    // Teile aufzuteilen" (Pflicht). Die Trennung ist hier abgeschaltet;
    // die logische Teilung ist Handarbeit — dafür in der Überschrift ein
    // `\` an der gewünschten Stelle setzen.
    set text(hyphenate: false)
    block(above: 0pt, below: 18pt, it)
  }

  // Unterkapitel: 14 pt fett, Abstand vor 24 / nach 18 pt.
  // `sticky: true` ist zwingend: "Eine Überschrift ohne Teile des
  // dazugehörigen Textes steht nie alleine am Ende einer Seite." Ohne das
  // ginge die Klebrigkeit verloren, die Typst Überschriften von sich aus
  // mitgibt — der umgebende `block` würde sie überschreiben.
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    set par(justify: false, leading: LEADING_EINZEILIG)
    set text(hyphenate: false)
    block(above: 24pt, below: 18pt, sticky: true, it)
  }

  // Dritte Ebene: 12 pt fett, Abstand vor 20 / nach 14 pt
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    set par(justify: false, leading: LEADING_EINZEILIG)
    set text(hyphenate: false)
    block(above: 20pt, below: 14pt, sticky: true, it)
  }

  // --- Abbildungen und Tabellen -----------------------------------
  // Durchlaufende Nummerierung über die ganze Arbeit (Abb. 1 … Abb. n),
  // NICHT kapitelweise.
  set figure(numbering: "1", gap: 0.8em)

  // Abbildungen: Unterschrift (Typst-Standard), Bezeichnung "Abb."
  show figure.where(kind: image): set figure(supplement: [Abb.])

  // Tabellen: Überschrift, Bezeichnung "Tab."
  show figure.where(kind: table): set figure(supplement: [Tab.])
  show figure.where(kind: table): set figure.caption(position: top)

  // Beschriftung 11 pt, aufrecht, schwarz — nicht 9 pt kursiv blau wie in
  // der Word-Standardvorlage.
  show figure.caption: set text(size: GROESSE_BESCHRIFTUNG, style: "normal", fill: black)
  show figure.caption: set par(justify: false, leading: LEADING_EINZEILIG)
  show figure: set block(above: 16pt, below: 16pt)

  // Tabellen schlicht und ohne Farbe. `breakable: true`, damit lange
  // Datentabellen im Anhang über mehrere Seiten laufen können, statt eine
  // halbe Leerseite zu erzeugen.
  set table(
    stroke: 0.5pt + black,
    inset: 5pt,
  )
  show figure.where(kind: table): set block(breakable: true)

  // --- Fußnoten ----------------------------------------------------
  // Fußnoten sind in dieser Vorlage nicht vorgesehen; Quellenangaben stehen
  // im Text. Falls die Betreuung sie doch zulässt oder versehentlich eine
  // entsteht, greift hier das Auffangnetz: 10 pt, einzeilig (DHBW-Vorgabe
  // für den Fall, dass Fußnoten verwendet werden).
  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(leading: LEADING_EINZEILIG, justify: true)

  // --- Verweise ----------------------------------------------------
  // `@etikett` auf eine Überschrift ergibt "Kapitel 3" bzw.
  // "Abschnitt 3.1"; ein Verweis auf Abbildung oder Tabelle behält
  // "Abb." / "Tab." aus der figure-Einstellung oben.
  set ref(supplement: it => {
    if it.func() == heading {
      if it.level == 1 { [Kapitel] } else { [Abschnitt] }
    } else {
      it.supplement
    }
  })

  inhalt
}

// ---------------------------------------------------------------------
// Seitennummerierung — drei Abschnitte
// ---------------------------------------------------------------------

// Fußzeile: Seitenzahl rechtsbündig, darüber ein durchgezogener Strich
// ("Die Fußzeile wird durch einen durchgezogenen Strich vom Haupttext
// getrennt.").
#let fusszeile = context {
  line(length: 100%, stroke: 0.5pt + black)
  v(-0.4em)
  set text(size: GROESSE_FLIESSTEXT)
  align(right, counter(page).display())
}

// Die drei Abschnitte (Vorspann ohne Zahl, Verzeichnisteil römisch,
// Textteil arabisch) werden in main.typ direkt mit `set page(...)`
// umgeschaltet. Eine Hilfsfunktion ginge NICHT: `set`-Regeln im Rumpf
// einer Funktion wirken nur auf den Inhalt, den diese Funktion selbst
// zurückgibt — nicht auf den Rest des Dokuments. Genau daran fehlen sonst
// alle Seitenzahlen.

// ---------------------------------------------------------------------
// Bausteine
// ---------------------------------------------------------------------

// Überschrift eines Verzeichnisses: wie Überschrift 1 (16 pt fett,
// neue Seite), aber ohne Gliederungsnummer.
// `im-inhaltsverzeichnis: false` für das Inhaltsverzeichnis selbst,
// damit es sich nicht selbst listet.
#let verzeichnis-titel(titel, im-inhaltsverzeichnis: true) = heading(
  level: 1,
  numbering: none,
  outlined: im-inhaltsverzeichnis,
  titel,
)

// Hilfskonstruktion für abb() und tab().
//
// Die Quellenangabe steht NICHT in der Beschriftung, sondern als eigene
// Zeile darunter. Sonst tauchte sie im Abbildungs- und
// Tabellenverzeichnis mit auf, weil Typst dort die ganze Beschriftung
// listet.
//
// Das Etikett (`<abb-...>`) muss deshalb als Argument übergeben werden und
// darf NICHT hinter den Aufruf geschrieben werden — dort würde es am
// umgebenden Block hängen und wäre nicht referenzierbar.
#let _mit-quelle(f, quelle, etikett) = {
  let inhalt = if etikett != none { [#f#etikett] } else { f }
  block(breakable: false)[
    #inhalt
    #if quelle != none [
      #v(-0.7em)
      // linksbündig wie die Beschriftung darüber
      #text(size: GROESSE_QUELLENZEILE)[Quelle: #quelle]
    ]
  ]
}

// Abbildung: Unterschrift "Abb. n: Titel", darunter die Quelle.
//
// Erstes Argument ist entweder ein Pfad zu einer Bilddatei oder beliebiger
// Inhalt (z. B. ein in Typst gezeichnetes Schema). Bei Inhalt wird
// `kind: image` ausdrücklich gesetzt, sonst landete die Abbildung nicht im
// Abbildungsverzeichnis.
//
// ACHTUNG BEIM PFAD: Der `image()`-Aufruf steht in DIESER Datei, deshalb
// löst Typst den Pfad relativ zu `vorlage/` auf — eine Datei in
// `abbildungen/` heißt also "../abbildungen/name.png", unabhängig davon,
// aus welcher Kapiteldatei der Aufruf kommt.
//
// Verwendung:
//   #abb("../abbildungen/residuen.png", [Residuen gegen Prognosewerte],
//        quelle: [eigene Darstellung], breite: 12cm, etikett: <abb-residuen>)
// Im Text: "... wie @abb-residuen zeigt"  ->  "wie Abb. 3 zeigt"
//
// AUSRICHTUNG: Abbildung, Beschriftung und Quellenzeile stehen zusammen in
// einem Absatz (nur so sitzt die Quelle dicht unter der Abbildung). Eine
// Abbildung, die schmaler als der Satzspiegel ist, steht deshalb
// linksbündig. Wer sie mittig will, übergibt sie in einem Block über die
// volle Breite — `align(center, …)` allein genügt nicht:
//   #abb(block(width: 100%, align(center, image("../abbildungen/x.png", width: 12cm))), …)
#let abb(inhalt, titel, quelle: none, breite: 100%, etikett: none) = _mit-quelle(
  figure(
    if type(inhalt) == str { image(inhalt, width: breite) } else { inhalt },
    kind: image,
    caption: titel,
  ),
  quelle,
  etikett,
)

// Tabelle: Überschrift "Tab. n: Titel", darunter die Tabelle, darunter
// die Quelle.
// Verwendung:
//   #tab(
//     table(columns: 2, table.header([Maß], [Wert]), [MAE], [4,21]),
//     [Fehlermaße im Prüfzeitraum],
//     quelle: [eigene Berechnung],
//     etikett: <tab-fehlermasse>,
//   )
#let tab(inhalt, titel, quelle: none, etikett: none) = _mit-quelle(
  figure(inhalt, kind: table, caption: titel),
  quelle,
  etikett,
)

// Formel, mittig, durchlaufend nummeriert.
//   #formel($ y_i = beta_0 + beta_1 x_i + epsilon_i $)
#let formel(inhalt) = math.equation(block: true, numbering: "(1)", inhalt)

// ---------------------------------------------------------------------
// Verzeichnisse
// ---------------------------------------------------------------------

// Gemeinsame Satzregeln für alle Verzeichnisse.
//
// Vorgabe: "Die Überschriften aus dem Textteil werden in 1,5-zeiligem
// Abstand geschrieben. Ein größerer Abstand sollte zwischen den
// Hauptüberschriften des Textteils sowie den Überschriften der
// Verzeichnisse und denen des Textteils eingehalten werden. Umfasst eine
// Überschrift mehrere Zeilen, wird innerhalb der Überschrift ein
// 1-zeiliger Abstand gewählt."
//
// ACHTUNG, eine Falle: Typst setzt Verzeichniseinträge nicht über
// `par.spacing` auseinander, sondern über `par.leading`. Ein
// `set par(spacing: …)` bleibt hier also wirkungslos — die Einträge stehen
// dann mit 16,4 pt statt der vorgeschriebenen 20,7 pt, also enger als
// vorgeschrieben. Der Abstand ZWISCHEN Einträgen muss über den umgebenden
// Block gesetzt werden; `leading` regelt danach nur noch den Umbruch
// INNERHALB eines langen Eintrags.
#let _verzeichnis-satz(inhalt) = {
  set par(leading: ZEILENABSTAND_EINFACH) // 1-zeilig innerhalb eines Eintrags
  set text(hyphenate: false) // Verzeichniseinträge nicht trennen
  // 1,5-zeilig zwischen Einträgen, vor Hauptkapiteln zusätzlich Luft.
  // Der Zuschlag ist eine Empfehlung ohne Zahlenwert ("Ein größerer Abstand
  // sollte zwischen den Hauptüberschriften … eingehalten werden").
  //
  // ACHTUNG, das Inhaltsverzeichnis steht schnell an der Seitengrenze. Mit
  // 8 pt Zuschlag läuft es leicht um eine Zeile über, auf der dann nur noch
  // ein Verzeichnistitel steht; mit 2 pt passt eine übliche Gliederung samt
  // Abbildungs- und Tabellenverzeichnis auf eine Seite.
  //
  // Wird es trotzdem zweiseitig — etwa mit Überschriften der dritten Ebene —
  // ist das zulässig, die Vorgabe verlangt keine Einseitigkeit. Dann diesen
  // Wert wieder erhöhen, statt am Zeilenabstand zu sparen: der ist mit
  // 1,5-zeilig zwingend vorgegeben.
  show outline.entry: it => block(
    above: if it.level == 1 { ZEILENABSTAND + 2pt } else { ZEILENABSTAND },
    below: 0pt,
    it,
  )
  inhalt
}

#let inhaltsverzeichnis() = {
  verzeichnis-titel(im-inhaltsverzeichnis: false)[Inhaltsverzeichnis]
  _verzeichnis-satz(outline(title: none, depth: 3, indent: auto))
}

// Abbildungs- bzw. Tabellenverzeichnis.
// Beide sind laut DHBW optional und werden nur ausgegeben, wenn es
// überhaupt Abbildungen bzw. Tabellen gibt — sonst entstünden leere
// Verzeichnisseiten. Es ist also nichts zu tun, wenn eine Arbeit ohne
// Abbildungen auskommt: das Verzeichnis erscheint mit der ersten
// Abbildung von selbst.
#let figurenverzeichnis(titel, art) = context {
  if query(figure.where(kind: art)).len() > 0 {
    verzeichnis-titel(titel)
    _verzeichnis-satz(outline(title: none, target: figure.where(kind: art)))
  }
}
