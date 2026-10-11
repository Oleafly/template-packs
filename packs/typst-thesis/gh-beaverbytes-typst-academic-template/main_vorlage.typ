// main.typ

#import "template.typ": arbeit, deckblatt, abbildungsverzeichnis, tabellenverzeichnis, anhangsverzeichnis, abbildung, tabelle, anhang, anhangteil, literaturverzeichnis

/*
* ============================================================================
* KURZANLEITUNG
* ============================================================================
*
* Überschriften:      = Kapitel | == Unterkapitel | === Abschnitt
* Zitat (BibTeX):     @schluessel[S. 15]           -> "(Muster, 2020, S. 15)"
* Seitenumbruch:      #pagebreak()
* Zeilenumbruch:      #linebreak()
*
* Abkürzungsverzeichnis: einfach eine neue Zeile in der #table(...)-Liste
*                        unten ergänzen, z. B.  [API], [Application ...],
*
* Quellen pflegen: in references.bib eintragen, im Text mit @key zitieren.
*
* ----------------------------------------------------------------------------
* ABBILDUNG
* ----------------------------------------------------------------------------
* #abbildung(
*   "assets/datei.png",
*   "Titel der Abbildung",
*   hinweis: "Optionaler Hinweis.",       // optional
*   quelle:  "Eigene Darstellung.",       // Standard
*   breite:  10cm,                        // 100%, 8cm, 0.5fr, ...
*   im-anhang: false,                     // true -> innerhalb von #anhang(...)
*   label:     none,                      // <mein-label> -> "Abb. @mein-label"
* )
*
* ----------------------------------------------------------------------------
* TABELLE
* ----------------------------------------------------------------------------
* #tabelle(
*   "Titel der Tabelle",
*   hinweis: [Optionaler Hinweis.],
*   quelle:  "Eigene Darstellung.",
*   breite:  auto,                        // auto | 100% | 12cm
*   stil:    "voll",                      // "voll" | "horizontal"
*   im-anhang: false,
*   label:     none,
* )[
*   #table(
*     columns: 3,
*     inset: 6pt,
*     [Spalte A], [Spalte B], [Spalte C],
*     [Wert 1],   [Wert 2],   [Wert 3],
*   )
* ]
*
* Hinweise:
*   - breite: 100% benötigt flexible Spalten, z. B. columns: (1fr, 1fr, 1fr).
*   - stil "horizontal": nur waagrechte Trennlinien zwischen Zeilen.
*
* ----------------------------------------------------------------------------
* ABBILDUNG/TABELLE IM ANHANG (APA-Konvention)
* ----------------------------------------------------------------------------
*   - im-anhang: true ausschließlich innerhalb von #anhang(...) bzw. #anhangteil(...).
*   - Max. eine Abbildung UND eine Tabelle pro Anhang(teil).
*   - Keine eigene Caption (Anhangtitel = Titel), kein Verzeichniseintrag.
*   - Im Text verweisen über den Anhang: "siehe Anhang A1".
*
* ----------------------------------------------------------------------------
* ANHANG
* ----------------------------------------------------------------------------
* #anhang("Titel des Hauptanhangs")[
*   #anhangteil("Titel des Unteranhangs")[
*     Inhalt.
*   ]
* ]
*
* Optionales Label für klickbare Verweise:
*   #anhangteil("Funktionale Anforderungen", label: <func-req>)[ ... ]
*   Im Text:  "siehe Anhang @func-req"     -> "siehe Anhang A1"
*
* ----------------------------------------------------------------------------
* @-VERWEISE
* ----------------------------------------------------------------------------
* Mit dem `label:`-Parameter bei #abbildung, #tabelle, #anhang, #anhangteil
* lassen sich klickbare Verweise erzeugen, die nur die Nummer rendern:
*   "Abb. @foo" -> "Abb. 3"     | "Tab. @bar" -> "Tab. 5"
*   "Anhang @baz" -> "Anhang A1"
*/

/*
* ============================================================================
* DOKUMENTEINSTELLUNGEN
* ============================================================================
*/

#show: arbeit       // Template auf das gesamte Dokument anwenden

// Römische Seitenzahlen für Deckblatt und Verzeichnisse.
#set page(
  numbering: "I",         // Format: "I" röm., "1" arab., "i" klein-röm.
  number-align: center,   // left | center | right
)

/*
* ============================================================================
* DECKBLATT
* ============================================================================
*/

#deckblatt(
  logo: "/assets/beaverbytes-logo.svg",
  arbeitstyp: "Hausarbeit",
  modul: "Modul",
  institution: "Universität",
  studiengang: "Studium B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "XYZ123",
  betreuung: "Prof. Dr.  Musterfrau",
  // abgabedatum: datetime(year: 2025, month: 3, day: 31),   // Standard: heute
)

/*
* ============================================================================
* VERZEICHNISSE VOR DEM HAUPTTEIL
* ============================================================================
*/

// Inhaltsverzeichnis. Zusätzlicher Vertikalabstand pro Eintrag für Lesbarkeit.
#[
  #show outline.entry.where(level: 1): it => [
    #strong(it)                          // Ebene 1 fett
    #v(6pt)
  ]

  #show outline.entry.where(level: 2): it => [
    #it
    #v(6pt)
  ]

  #show outline.entry.where(level: 3): it => [
    #it
    #v(6pt)
  ]

  #outline(
    title: "Inhaltsverzeichnis",
    depth: 3,                            // Anzahl der angezeigten Ebenen
  )
]

#pagebreak()

// Abbildungs- und Tabellenverzeichnis wird nur eingefügt, wenn auch tatsächlich
// Abbildungen bzw. Tabellen im Haupttext vorhanden sind (Anhang ausgeschlossen).
#context {
  if query(<abb-eintrag>).len() > 0 [
    #abbildungsverzeichnis()
    #pagebreak()
  ]

  if query(<tab-eintrag>).len() > 0 [
    #tabellenverzeichnis()
    #pagebreak()
  ]
}

/*
* ============================================================================
* ABKÜRZUNGSVERZEICHNIS
* ============================================================================
*/

#heading(numbering: none)[Abkürzungsverzeichnis]

#table(
  columns: (auto, 1fr),     // 1. Spalte automatisch breit, 2. Spalte füllt Rest
  stroke: none,             // keine Linien
  inset: 4pt,               // Innenabstand der Zellen

  // Neue Abkürzung: einfach eine Zeile [Kürzel], [Bedeutung], ergänzen.
  [bzw.], [beziehungsweise],
  [z.B.], [zum Beispiel],
)

#pagebreak()

/*
* ============================================================================
* HAUPTTEIL
* ============================================================================
*/

// Ab hier arabische Seitenzählung, beginnend bei 1.
#counter(page).update(1)

#set page(
  numbering: "1",
  number-align: center,
)

= Kapitel

#lorem(50)
Dies ist ein indirektes Beispielzitat nach @einstein1905[S. 15].

== Unterkapitel

#lorem(80) @wikipedia_typst[Beispielartikel].

#linebreak()

=== Beispiel für eine Tabelle

#lorem(55)@homer_odyssee.
#lorem(15)

#linebreak()

#tabelle(
  "Testtabelle",
  hinweis: "Hier kann ein Hinweis zur Tabelle stehen.",
  quelle: "Eigene Darstellung.",
  breite: 100%
)[
  #table(
    columns: (1fr, 1fr, 1fr),
    inset: 5pt,

    [Spalte A], [Spalte B], [Spalte C],
    [Wert 1], [Wert 2], [Wert 3],
    [Wert 4], [Wert 5], [Wert 6],
    [Wert 7], [Wert 8], [Wert 9],
  )
]

#abbildung(
  "/assets/beaverbytes-logo.svg",
  "Weitere Beispielabbildung",
  quelle: "Eigene Darstellung.",
  breite: 7cm,
)

#linebreak()

=== Unterunterkapitel

#lorem(170)

== Noch ein Beispiel für eine Tabelle

#tabelle(
  "Demo Tabelle",
  quelle: "Eigene Darstellung.",
  breite: 100%,
  stil: "horizontal",
)[
  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    inset: 6pt,

    [Spalte A], [Spalte B], [Spalte C], [Spalte D], [Spalte E],
    [Wert 1], [Wert 2], [Wert 3], [Wert 4], [Wert 5],
    [Wert 6], [Wert 7], [Wert 8], [Wert 9], [Wert 10],
    [Wert 11], [Wert 12], [Wert 13], [Wert 14], [Wert 15],
    [Wert 16], [Wert 17], [Wert 18], [Wert 19], [Wert 20],
  )
]

#pagebreak()

/*
* ============================================================================
* LITERATURVERZEICHNIS
* ============================================================================
*/

#literaturverzeichnis()

// Seitenumbruch nur, wenn auch zitiert wurde (sonst leere Seite vermeiden).
#context {
  if query(cite).len() > 0 [
    #pagebreak()
  ]
}

/*
* ============================================================================
* ANHANGSVERZEICHNIS
* ============================================================================
*/

// Wird nur eingefügt, wenn auch Anhänge vorhanden sind.
#context {
  if query(<anhang-eintrag>).len() > 0 [
    #anhangsverzeichnis()
    #pagebreak()
  ]
}

/*
* ============================================================================
* ANHANG
* ============================================================================
*/

#anhang("Testanhang")[
  #anhangteil("Testanhang Teil 1")[
    Inhalt zu Testanhang 1.
  ]

  #pagebreak()

  #anhangteil("Testanhang Teil 2")[
    Inhalt zu Testanhang 2.
  ]
]

#pagebreak()

#anhang("Demo Anhang")[
  #anhangteil("1. Demo Anhang")[
    Inhalt zum 1. Demo Anhang.
  ]
]
