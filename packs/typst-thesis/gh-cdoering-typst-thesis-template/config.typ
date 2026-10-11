// =============================================================================
// KONFIGURATION — die einzige Datei, die angepasst werden muss.
//
// Alle Werte wirken auf Titelblatt, Kopf-/Fussbereiche, Verzeichnisse und
// Formatierung. Layout-Code steht in lib/ und muss nicht angefasst werden.
// =============================================================================

// Vordefinierte Hochschullogos, siehe logos.typ.
#import "logos.typ": logo

#let cfg = (
  // --- Sprache -------------------------------------------------------------
  // "de" oder "en". Steuert alle vom Template erzeugten Texte (Verzeichnis-
  // ueberschriften, Titelblatt, Erklaerungen) sowie Silbentrennung und die
  // Beschriftungen von Abbildungen und Tabellen.
  lang: "de",

  // --- Arbeit --------------------------------------------------------------
  title: "Titel der Arbeit",
  subtitle: none,                       // none oder "Untertitel"
  author: "Vorname Nachname",
  matr_nr: "0000000",
  keywords: ("Schlagwort 1", "Schlagwort 2"),

  // z. B. "Masterarbeit", "Bachelorarbeit", "Diplomarbeit", "Seminararbeit"
  thesis_type: "Art der Arbeit",
  // z. B. "Master of Science (M.Sc.)", "Bachelor of Arts (B.A.)"
  degree: "Akademischer Grad",
  program: "Studiengang",
  faculty: "Fachbereich",
  university: "Hochschule",

  submission_date: "Monat JJJJ",
  place: "Ort",

  // Datum unter der eidesstattlichen Erklaerung.
  // auto  = Datum der Kompilierung -- praktisch beim Schreiben, wandert aber
  //         bei jedem Lauf. Fuer die Abgabefassung ein festes Datum setzen,
  //         z. B. "15.05.2027". Die Erklaerung ist eine rechtsverbindliche
  //         Versicherung; ihr Datum sollte nicht mitlaufen.
  declaration_date: auto,

  // Beliebig viele Zeilen, jeweils (Bezeichnung, Name).
  advisors: (
    ("Referent:", "N. N."),
    ("Korreferent:", "N. N."),
  ),

  // --- Bilder --------------------------------------------------------------
  // Zwei Wege:
  //
  //   1. Preset aus logos.typ:  logo("platzhalter")
  //      Eigene Logos werden dort registriert; mitgeliefert ist nur ein
  //      neutraler Platzhalter. Hochschul- und Unternehmenslogos sind
  //      geschuetzt und daher nicht Teil dieser Vorlage.
  //
  //   2. Direkt:  image("assets/eigenes-logo.png", width: 60%)
  //
  // In beiden Faellen steht hier fertiger Bild-Content, kein Pfad. Grund:
  // Typst loest Pfade relativ zu der Datei auf, in der der Aufruf steht.
  // Da image() hier beziehungsweise in logos.typ notiert wird, gelten Pfade
  // relativ zum Wurzelverzeichnis -- unabhaengig davon, wo im Template das
  // Bild spaeter gesetzt wird.
  //
  // none = kein Logo.
  university_logo: logo("platzhalter"),
  company_logo: none,
  signature: none,

  // --- Satzspiegel ---------------------------------------------------------
  // Hinweis: Viele Pruefungsordnungen verlangen eine Bindekorrektur von
  // 3-4 cm am linken Rand und 1,5-zeiligen Satz. Pruefungsordnung pruefen.
  font: ("New Computer Modern", "Libertinus Serif"),
  font_size: 12pt,
  margins: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  line_spacing: 1em,                    // Zeilenabstand innerhalb eines Absatzes
  heading_depth: 3,                     // ab Ebene 4: unnummeriert und fett
  chapter_pagebreak: true,              // jedes Kapitel auf neuer Seite

  // --- Formeln -------------------------------------------------------------
  // Nummerierung abgesetzter Formeln: "(1)" durchlaufend, "(1.1)" je Kapitel,
  // none ohne Nummer. Nur nummerierte Formeln lassen sich mit @label
  // referenzieren -- viele Pruefungsordnungen verlangen das.
  equation_numbering: "(1)",

  // --- Tabellen ------------------------------------------------------------
  table_stroke: 0.5pt,
  table_inset: 6pt,
  table_font_size: 10pt,                // Tabellen meist kleiner als Fliesstext
  breakable_tables: true,               // lange Tabellen ueber Seiten umbrechen

  // --- Verzeichnisse -------------------------------------------------------
  toc_depth: 3,
  toc_spacing: 0.65em,                  // vertikaler Abstand je Eintrag

  sections: (
    confidentiality: false,             // Sperrvermerk (Arbeiten im Unternehmen)
    abstract: true,
    acknowledgements: false,            // Danksagung
    toc: true,
    acronyms: true,
    symbols: true,
    figures: true,
    tables: true,
    listings: false,                    // Quelltextverzeichnis
    ai_disclosure: true,                // Erklaerung zur Nutzung generativer KI
    declaration: true,                  // Eidesstattliche Erklaerung
  ),

  // --- Literatur -----------------------------------------------------------
  // Eingebauter Typst-Stil ("ieee", "apa", "chicago-author-date", ...) oder
  // Pfad zu einer eigenen CSL-Datei, z. B. "misc/hochschule.csl".
  // Eigene Stile: https://github.com/citation-style-language/styles
  bib_style: "ieee",
)
