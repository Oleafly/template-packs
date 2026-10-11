// ============================================================
// Inoffizielles Typst-Template – UMIT TIROL
// Medizinische Informatik
// basierend auf Vorlage_Masterarbeit_MMI_2026.docx
// André Schomakers
// ============================================================


// ============================================================
// --------------- Page & Font Setup ---------------
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() >= 1 {
      align(right, text(size: 9pt, style: "italic")[Kurztitel der Arbeit])
      line(length: 100%)
    }
  },
  footer: context {
    let p = counter(page).get().first()
    if p >= 1 {
      // Page number centred as per formal requirements
      align(center, text(size: 9pt)[#p])
    }
  },
  numbering: "1",
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "de",
)
#show heading: set block(above: 1.4em, below: 1em)


// Line spacing: 0.75 == 1.5 word
#set par(
  justify: true,
  leading: 0.75em,
)

// Headings are NOT numbered globally; numbering is activated
// just before "1 Einleitung" so that pre-content headings
// (Zusammenfassung, Abstract, …) remain unnumbered.
#set heading(numbering: none)

// Headings styling
#show heading.where(level: 1): it => {
  v(1.5em)
  text(size: 14pt, weight: "bold")[#it]
  v(0.5em)
}
#show heading.where(level: 2): it => {
  v(1em)
  text(size: 12pt, weight: "bold")[#it]
  v(0.3em)
}
#show heading.where(level: 3): it => {
  v(0.8em)
  text(size: 11pt, weight: "bold")[#it]
  v(0.2em)
}

// Table captions above the table body
#show figure.where(kind: table): it => {
  align(center)[
    #it.caption
    #v(0.4em)
    #it.body
  ]
}

// ============================================================


// ============================================================
// DECKBLATT (Cover Page)
// ============================================================
#page(
  numbering: none,
  header: none,
  footer: none,
)[
  #v(3cm)
  #align(center)[
    #text(size: 18pt, weight: "bold")[Titel der Musterarbeit]

    #v(3em)
    Abschlussarbeit \
    zur Erlangung des akademischen Titels

    #v(0.8em)
    Master of Science (M.Sc.) \
    Medizinische Informatik

    #v(3em)
    im Rahmen des

    #v(0.5em)
    *Master-Studiums* \
    *Medizinische Informatik*

    #v(3em)
    vorgelegt von:

    #v(0.5em)
    *\(Titel\) Vorname Nachname \(Titel\)*

    #v(3em)
    betreut von: \
    (Titel) Vorname Nachname (Titel)

    #v(1.5em)
    an der \
    UMIT TIROL – Privatuniversität für Gesundheitswissenschaften \
    und -technologie

    #v(4em)
    Hall in Tirol, im \<Monat Jahr\>
  ]
]

// ============================================================
// BETREUUNGSBESTÄTIGUNG
// ============================================================
#page(numbering: none, header: none, footer: none)[
#v(2cm)  
#heading(outlined: false)[Betreuungsbestätigung]


  Ich befürworte die Abgabe der vorliegenden Abschlussarbeit, welche von mir betreut und
  insgesamt positiv bewertet wurde.

  #v(3em)
  ........................................................................

  Datum und Unterschrift des/der Betreuer/in

  #v(14em)
  *Annahme durch das Studienmanagement*

  #v(1em)
  am: ...................................................

  von: ..................................................
]

// ============================================================
// ZUSAMMENFASSUNG (Deutsch)
// ============================================================
#page(numbering: none, header: none, footer: none)[
#heading(outlined: false)[Zusammenfassung] 

  *Einleitung:*

  #v(0.5em)
  *Fragestellung:* #h(1fr) #text(style: "italic", size: 9pt)[(alternativ: Zielsetzung)]

  #v(0.5em)
  *Methodik:*

  #v(0.5em)
  *Ergebnisse:*

  #v(0.5em)
  *Diskussion:*

  #v(0.5em)
  *Ausblick:*

  #v(2em)
  #text(style: "italic", size: 11pt)[
    Die Zusammenfassung ist auf Deutsch und Englisch einzufügen. Sie ist in Anlehnung an
    die Kapitelgliederung der Arbeit sichtbar zu untergliedern. Die Länge sollte jeweils
    eine Seite nicht überschreiten. In der Zusammenfassung werden keine Referenzen verwendet.
  ]
]

// ============================================================
// ABSTRACT (English)
// ============================================================
#page(numbering: none, header: none, footer: none)[
#heading(outlined: false)[Abstract]

  *Background:*

  #v(0.5em)
  *Research question:* #h(1fr) #text(style: "italic", size: 9pt)[(alternativ: Objective)]

  #v(0.5em)
  *Methods:*

  #v(0.5em)
  *Results:*

  #v(0.5em)
  *Discussion:*

  #v(0.5em)
  *Conclusion:*
]

// ============================================================
// DANKSAGUNG (optional)
// ============================================================
#page(numbering: none, header: none, footer: none)[
#heading(outlined: false)[Danksagung]

  // Persönlicher Dank an Betreuer/innen, Familie, Freunde, Kooperationspartner.
  // Ggf. Dank an drittmittelgebende Institutionen.
  // Schreibstil darf hier persönlich gehalten werden.
]

// ============================================================
// INHALTSVERZEICHNIS
// ============================================================
#page(numbering: none, header: none, footer: none)[
  #outline(
    title: [Inhaltsverzeichnis],
    indent: auto,
    depth: 3,
  )
]

// ============================================================
// HAUPTTEIL
// Seitennummerierung beginnt bei "1 Einleitung" mit Seite 1.
// Heading-Nummerierung wird hier aktiviert; Counter auf 0
// gesetzt, damit das erste Kapitel die Nummer 1 erhält.
// ============================================================
#counter(page).update(1)
#set heading(numbering: "1.")
#counter(heading).update(0)

// ============================================================
// 1 EINLEITUNG
// ============================================================
= Einleitung

Hier zitiere ich #cite(<ammenwerth2017>).


// Leitfragen:
// - Gegenstand der Arbeit
// - Bedeutung des Themas
// - Wissenschaftliche / praktische Problematik
// - Idee der Arbeit
//
// Zentrale Fachbegriffe definieren (mit Literaturangabe).
// Alle zentralen Aussagen mit Literaturquellen belegen.

// ============================================================
// 2 GRUNDLAGEN UND STAND DER FORSCHUNG
// ============================================================
= Grundlagen und Stand der Forschung
// (alternativ: „Stand der Technik")

// - Wesentliche Fachbegriffe definieren
// - Literatur zur eingeführten Problematik
// - Verfügbare Methoden/Werkzeuge und ihre Limitationen
// - Forschungslücken identifizieren
// - Ziele / Fragestellungen der Masterarbeit (nummeriert, SMART)

== Zentrale Fachbegriffe

== Stand der Forschung

== Fragestellung
// Nummerierte Fragestellungen / Ziele:
// F1: ...
// F2: ...

// ============================================================
// 3 METHODEN
// ============================================================
= Methoden

#lorem(50)

// ============================================================
// 4 ERGEBNISSE
// ============================================================
= Ergebnisse

// - Klare Darstellung mit Bezug zu den Fragestellungen
// - Textuelle Darstellung + Abbildungen, Tabellen, Grafiken
// - Roter Faden; keine Diskussion / Interpretation hier

// Beispielabbildung:
#figure(
  rect(width: 8cm, height: 4cm, stroke: 0.5pt)[
    #align(center + horizon)[Platzhalter Abbildung]
  ],
  caption: [Titel der Abbildung. Quelle: Eigene Darstellung.],
) <fig-beispiel>

// Im Text referenzieren: @fig-beispiel zeigt ...

#lorem(80)

#figure(
  table(
    columns: (auto, auto),
    align: left,
    table.header([*Erscheinungsjahr*], [*Anzahl der Veröffentlichungen*]),
    [2018], [7],
    [2017], [7],
    [2016], [1],
  ),
  caption: [Anzahl der wissenschaftlichen Veröffentlichungen zum Universitätslehrgang „Health Information Management". Quelle: Eigene Darstellung.],
  kind: table,
) <tab-beispiel>

// Im Text referenzieren: @tab-beispiel zeigt ...

== Unterüberschrift

=== Unterüberschrift



// ============================================================
// 5 DISKUSSION
// ============================================================
= Diskussion

#lorem(50)

// ============================================================
// 6 AUSBLICK
// ============================================================
= Ausblick

// - Kurze Zusammenfassung der Erkenntnisse
// - Möglichkeiten zur Weiterbearbeitung des Themas

// ============================================================
// 7 LITERATURVERZEICHNIS
// APA-Stil; mind. 10 internationale wissenschaftliche Quellen.
// ============================================================
= Literaturverzeichnis

// Automatische Bibliographie aus Hayagriva-Datei (empfohlen):
#bibliography("references.yaml", style: "ieee", title: none)



#set par(hanging-indent: 0em)

// ============================================================
// 8 ANHÄNGE
// ============================================================
= Anhänge

== Abkürzungsverzeichnis

// Alphabetisch sortierte Liste aller Abkürzungen.
// Format: Abkürzung – Bedeutung

== Abbildungsverzeichnis

#outline(
  title: none,
  target: figure.where(kind: image),
)

== Tabellenverzeichnis

#outline(
  title: none,
  target: figure.where(kind: table),
)


// ============================================================
// EIDESSTATTLICHE ERKLÄRUNG (unnumbered)
// ============================================================
#heading(numbering: none)[Eidesstattliche Erklärung]

Ich erkläre hiermit an Eides statt, dass ich die vorliegende Arbeit selbständig (mit Ausnahme der erklärten Teile), ohne unzulässige Hilfe Dritter und ohne Benutzung anderer als der angegebenen Hilfsmittel angefertigt habe. Die aus fremden Quellen wörtlich oder sinngemäß übernommenen Stellen und Gedanken sind als solche nach den Regeln der guten wissenschaftlichen Praxis kenntlich gemacht. Die Arbeit wurde bisher in gleicher oder ähnlicher Form keiner anderen Prüfungsbehörde vorgelegt.

#v(3em)
Datum #h(5cm) Unterschrift
