// chapters/17-visual-hierarchy.typ — Visuelle Hierarchie und Typst-Grenzen
// Teil V, Phase 3: Caidan, Aspirationally, Exkurs (Soviet-Matrix, Badformer), Lernpfad

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/tables.typ": styled-table
#import "../components/layouts.typ": comparison-layout
#import "@preview/in-dexter:0.7.2": index

// ════════════════════════════════════════════════════════════════
// CHAPTER OPENER
// ════════════════════════════════════════════════════════════════
#chapter-opener(
  title: [Visuelle Hierarchie und Typst-Grenzen],
  lead: [
    Nicht jedes Typst-Dokument ist ein Fachbuch oder technischer
    Bericht. Dieses Kapitel erkundet Templates für einseitiges
    Grafikdesign und formale Korrespondenz — und wirft
    abschließend einen Blick auf die äußersten Grenzen von Typst
    als Turing-vollständige Sprache.
  ],
)

// ════════════════════════════════════════════════════════════════
== Caidan — Die Seite als Leinwand

Das Template _Caidan_#index[Caidan] (`\@preview/caidan:0.1.0`) demonstriert
einen radikal anderen Ansatz als die bisherigen Kapitel:
Statt langen Textfluss zu strukturieren, wird die Seite als
*Leinwand* behandelt — mit frei positionierten Elementen,
kontextuellem Font-Wechsel und dekorativen Linien.

=== Poster-Stil statt Absatz-Stil

Während Bücher und Berichte den Inhalt als sequenziellen Strom
von Absätzen behandeln, baut Caidan ein visuelles Poster-Layout#index[Poster-Layout] aus
absolut positionierten Blöcken:

#code-block(title: [Poster-Design in Typst — Caidan-Muster])[
  ```typst
  #set page(width: 148mm, height: 210mm, margin: 0pt)

  // Hintergrund
  place(bottom + left,
    rect(width: 100%, height: 40%, fill: rgb("#1a1a2e")))

  // Dekorative Linie
  place(center + horizon,
    line(length: 80%, stroke: 2pt + gold))

  // Titel — eigene Schriftfamilie
  place(top + center, dy: 3cm,
    text(font: "Playfair Display", size: 36pt,
         fill: rgb("#1a1a2e"), [Speisekarte]))

  // Inhalt — andere Schriftfamilie
  place(center, dy: 1cm,
    text(font: "Lato", size: 11pt, fill: white)[
      Vorspeisen · Hauptgänge · Desserts
    ])
  ```
]

#callout(title: [place() statt grid()], tone: "info")[
  In Caidan wird `place()` zum Hauptwerkzeug: Jedes Element erhält
  exakte Koordinaten durch `dx`/`dy`-Offsets relativ zu einem Anker
  (`top`, `center`, `bottom`). Das ergibt maximale Freiheit — aber
  auf Kosten der automatischen Umbruchlogik. Dieses Muster eignet
  sich für Einseiter (Menüs, Poster, Flyer), nicht für Fließtext.
]

=== Kontextueller Schriftwechsel

Ein Schlüsselmerkmal von Caidans Design ist der flüssige Schriftwechsel#index[Schriftwechsel]
zwischen verschiedenen Schriftfamilien — _ohne_ die globale
Dokumentschrift zu ändern:

#code-block(title: [Scoped Font-Wechsel])[
  ```typst
  // Global bleibt die Dokumentschrift unverändert
  #set text(font: "Libertinus Serif")

  // Lokal: Dekorative Schrift für den Titel
  #block({
    set text(font: "Playfair Display", size: 28pt)
    [Mittags-Menü]
  })

  // Lokal: Sans-Serif für Preise
  #block({
    set text(font: "Lato", size: 10pt)
    [Hauptgericht · 18,50 €]
  })
  ```
]

#side-note(title: [Typografisches Prinzip])[
  Der scoped `set text(font: ...)` innerhalb eines `block()` ist
  das zentrale Werkzeug für Multi-Font-Designs. Die Regel gilt nur
  für den umgebenden Block — danach greift automatisch die
  Dokumentschrift. Siehe `templates/caidan/` für die
  vollständige Vorlage.
]

// ════════════════════════════════════════════════════════════════
== Aspirationally — Formale Eleganz #tag("Thematic Overrides")

_Aspirationally_#index[Aspirationally] (`\@preview/aspirationally:0.1.1`) ist ein
Fallbeispiel für minimalistisches, formales Layoutdesign. Das
Template demonstriert, wie eine einzige `show`-Regel ein
vollständiges Brieflayout#index[Brieflayout] erzeugt.

=== Die `letter.with()`-API

Das gesamte Layout wird durch strukturierte Funktionsargumente
gesteuert — der Nutzer schreibt keine Positionierungslogik:

#code-block(title: [Aspirationally — Komplettes Brieflayout in einer Zeile])[
  ```typst
  #import "@preview/aspirationally:0.1.1": *

  #show: letter.with(
    sender: [
      Dr. Anna Schmidt \
      Universitätsklinikum \
      Medizinische Fakultät
    ],
    recipient: [
      Dekan Prof. Dr. Müller \
      Fakultät für Medizin \
      Universität Heidelberg
    ],
    date: [28. Februar 2026],
    subject: [Bewerbung — Professur Innere Medizin],
  )

  Sehr geehrter Herr Professor Müller, ...
  ```
]

=== Der Mechanismus: Metadaten → Positionen

Hinter `letter.with(...)` verbirgt sich eine Funktion, die
strukturierte Metadaten auf konkrete Seitenpositionen abbildet:

#code-block(title: [Vereinfachte Interna des letter()-Templates])[
  ```typst
  #let letter(
    sender: none,
    recipient: none,
    date: none,
    subject: none,
    body,
  ) = {
    set page(margin: (top: 5cm, left: 2.5cm, right: 2cm))

    // Absender: oben rechts
    place(top + right, dy: 1.5cm, sender)

    // Empfänger: links, unter dem Absender
    place(top + left, dy: 4cm, recipient)

    // Datum: rechtsbündig
    align(right, date)
    v(1cm)

    // Betreff: fett
    text(weight: "bold", subject)
    v(0.5cm)

    // Briefkörper
    body
  }
  ```
]

#comparison-layout(
  left-title: [Manuelles Layout (30+ Zeilen)],
  right-title: [Aspirationally (1 Zeile)],
  code-block(title: none)[
    ```typst
    #set page(margin: (...))
    #place(top + right,
      dy: 1.5cm, [Absender])
    #place(top + left,
      dy: 4cm, [Empfänger])
    #align(right, [Datum])
    #v(1cm)
    #text(weight: "bold",
      [Betreff])
    #v(0.5cm)
    Brieftext...
    ```
  ],
  code-block(title: none)[
    ```typst
    #show: letter.with(
      sender: [...],
      recipient: [...],
      date: [...],
      subject: [...],
    )

    Brieftext...

    // Fertig. Kein Layout-Code
    // nötig.
    ```
  ],
)

#callout(title: [Vergleich: Funktionsargumente vs. YAML], tone: "info")[
  In Kapitel~14 haben wir gesehen, wie Brilliant-CV externe
  YAML-Daten nutzt, um Inhalte strikt vom Layout zu trennen.
  Aspirationally erreicht dasselbe Ziel über
  Typst-Funktionsargumente — beide implementieren das Muster
  _Data Separation_, nur mit unterschiedlichen Datenquellen.
]

#side-note(title: [Wann welcher Ansatz?])[
  *Funktionsargumente* (wie Aspirationally): Ideal für einfache,
  wenige Metadaten — keine externen Dateien nötig. \
  *YAML/TOML* (wie Brilliant-CV): Ideal für komplexe,
  wiederverwendbare Datensätze — mehrere Templates konsumieren
  dieselbe Datenquelle.
  Siehe `templates/aspirationally/` für die vollständige Vorlage.
]

// ════════════════════════════════════════════════════════════════
== Exkurs: Typst als Turing-Maschine

Zum Abschluss von Teil~V ein Blick über den Tellerrand: Was
passiert, wenn man Typst nicht für Dokumente nutzt, sondern als
reine Berechnungsmaschine? Zwei Templates aus dem Typst Universe#index[Typst Universe]
treiben die Sprache an ihre Grenzen.

#card(title: [Soviet-Matrix — Tetris im Compiler], accent: palette.danger)[
  `\@preview/soviet-matrix:0.2.1` implementiert ein vollständiges
  Tetris-Spiel *ausschließlich durch Typst-Kompilierung*. Da
  Typst-Variablen unveränderlich sind, wird der Spielzustand
  rekursiv durch Funktionen weitergereicht — jeder „Frame" ist
  eine reine Funktion des vorherigen Zustands.
]

#key-concept(term: [Functional State Loop])[
  In imperativen Sprachen wird der Zustand _mutiert_:
  `board[y][x] = piece`. In Typst wird er _transformiert_:
  `let new-board = place-piece(board, piece, x, y)`. Jeder
  Schritt erzeugt eine neue, unveränderliche Datenstruktur.
  Dieses Muster ist die Grundlage funktionaler Programmierung.
]

#code-block(title: [Vereinfachte Zeilenlöschung (Soviet-Matrix-Stil)])[
  ```typst
  // Spielfeld: 2D-Array aus 0 (leer) und 1 (belegt)
  #let clear-full-rows(board) = {
    // Nur Zeilen behalten, die nicht komplett gefüllt sind
    let remaining = board.filter(row =>
      row.any(cell => cell == 0)
    )
    // Oben mit leeren Zeilen auffüllen
    let cleared = board.len() - remaining.len()
    let empty-rows = range(cleared).map(_ =>
      (0,) * board.first().len()
    )
    empty-rows + remaining
  }
  ```
]

#card(title: [Badformer — Pseudo-3D im Compiler], accent: palette.accent)[
  `\@preview/badformer:0.1.0` geht einen Schritt weiter:
  Es kombiniert `polygon()`, `path()` und mathematische
  Projektionsformeln, um eine 3D-Plattformer-Perspektive
  _rein durch Typst-Scripting_ zu erzeugen. Die Szene wird
  Pixel für Pixel aus berechneten Koordinaten aufgebaut.
]

#callout(title: [Grenzen der Berechnung], tone: "warning")[
  Soviet-Matrix und Badformer sind keine praktischen
  Dokumentvorlagen — sie stressen den Compiler mit hunderten
  rekursiven Aufrufen und demonstrieren seine absoluten Grenzen.
  Aber sie sind unschätzbare Lernwerkzeuge: Wer die
  Array-Manipulation, Dictionary-Logik und mathematischen
  Funktionen von Typst beherrscht, kann _jedes_
  Dokumentproblem lösen.
  Siehe `templates/soviet-matrix/` und `templates/badformer/`.
]

// ════════════════════════════════════════════════════════════════
== Der Lernpfad zum Document Engineer

Die Templates dieses Buchteils repräsentieren vier
Kompetenzebenen auf dem Weg zur visuellen Hierarchie#index[Visuelle Hierarchie]. Folgen Sie diesem Pfad, um sich vom
Typst-Einsteiger zum Document Engineer zu entwickeln:

#feature-grid(
  column-count: 2,
  (
    (
      icon: [1],
      title: [Folien-Track],
      body: [Starten Sie mit #badge[Touying] (Kapitel 14).
        Lernen Sie `state()` und seitenübergreifende
        Zustandsverwaltung.],
    ),
    (
      icon: [2],
      title: [Daten-Track],
      body: [Initialisieren Sie #badge[Brilliant-CV] (Kapitel 14).
        Lernen Sie YAML/TOML → Layout-Mapping und strikte
        Datentrennung.],
    ),
    (
      icon: [3],
      title: [Buch-Track],
      body: [Kombinieren Sie die Typografie von #badge[Ilm]
        (Kapitel 14) mit den dynamischen `context`-Headern von
        #badge[Wonderous-Book] (Kapitel 15).],
    ),
    (
      icon: [4],
      title: [Meta-Track],
      body: [Analysieren Sie #badge[Soviet-Matrix] (oben).
        Meistern Sie Typst-Scripting, indem Sie die Sprache an
        ihre Grenzen treiben.],
    ),
  ),
)

#v(space.lg)

#gallery-grid(
  (
    [*Dynamic Content Extraction* \
      `query()` + `context` \
      Kap. 15],
    [*Margin Architectures* \
      `measure()` + `place()` \
      Kap. 16],
    [*Thematic Overrides* \
      `template.with()` \
      Kap. 14, 17],
    [*Data Separation* \
      YAML / TOML / JSON \
      Kap. 9, 14],
  ),
  column-count: 4,
)

#v(space.lg)

#pull-quote(
  attribution: [— Synthese aus Teil V],
)[
  Templates sind keine Blackboxes — sie sind Architekturen.
  Wer die vier Grundmuster beherrscht, kann jedes Dokumentdesign
  selbst entwerfen, statt fremde Vorlagen anzupassen.
]
