// chapters/15-book-patterns.typ — Buch-Layout-Architekturen
// Teil V, Phase 1: Wonderous-Book, TiefFiction, Decision Table

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid
#import "../components/tables.typ": styled-table
#import "../components/layouts.typ": comparison-layout
#import "@preview/in-dexter:0.7.2": index

// ════════════════════════════════════════════════════════════════
// CHAPTER OPENER
// ════════════════════════════════════════════════════════════════
#chapter-opener(
  title: [Buch-Layout-Architekturen],
  lead: [
    Professionelle Buchtemplates sind keine Blackboxes — sie bestehen
    aus wiederverwendbaren Architekturmustern. Dieses Kapitel eröffnet
    Teil~V, in dem wir vier Kernmuster identifizieren und an konkreten
    Templates demonstrieren: vom dynamischen Kolumnentitel bis zur
    klassischen Initiale.
  ],
)

// ════════════════════════════════════════════════════════════════
== Die vier Architekturmuster

Aus der Analyse der besten Typst Universe Templates kristallisieren sich
vier wiederverwendbare Architekturmuster#index[Architekturmuster] heraus — das konzeptuelle Fundament
dieses Buchteils. Jede Template-Sektion ist mit dem Muster markiert,
das sie hauptsächlich demonstriert.

#feature-grid(
  column-count: 2,
  (
    (
      icon: sym.arrow.r.double,
      title: [Dynamic Content Extraction],
      body: [Inhalte aus dem kompilierten Dokument abfragen und in
        Kopfzeilen, Verzeichnisse oder Marker einfügen.
        #linebreak() _Wonderous-Book (hier), `styles/page.typ` (dieses Buch)_],
    ),
    (
      icon: sym.square.filled,
      title: [Margin Architectures],
      body: [Randnotizen durch `measure()` und `place()` kollisionsfrei
        im Seitenrand positionieren.
        #linebreak() _Toffee-Tufte (Kapitel 16)_],
    ),
    (
      icon: sym.diamond.filled,
      title: [Thematic Overrides],
      body: [Globale `set`/`show`-Regeln in einer
        `template.with()`-Funktion bündeln.
        #linebreak() _Aspirationally (Kap. 17), Ilm (Kap. 14)_],
    ),
    (
      icon: sym.circle.filled,
      title: [Data Separation],
      body: [Inhalte (YAML, TOML) strikt von der Darstellung trennen —
        Template konsumiert nur Daten.
        #linebreak() _Brilliant-CV (Kap. 14), Kap. 09_],
    ),
  ),
)

#side-note(title: [Querverweise])[ Die Muster _Thematic Overrides_ und
  _Data Separation_ wurden bereits in Kapitel~14 am Beispiel von Ilm
  und Brilliant-CV vorgestellt. Dieses und die folgenden Kapitel
  konzentrieren sich auf _Dynamic Content Extraction_ und
  _Margin Architectures_.
]

// ════════════════════════════════════════════════════════════════
== Entscheidungstabelle — Welches Template für welchen Zweck?

Bevor wir in die Mechanik eintauchen, hilft eine Übersicht: Welches
Template empfiehlt sich für welchen Dokumenttyp? Die folgende Tabelle
fasst die Empfehlungen aus dem Template-Report zusammen.

#styled-table(
  columns: (2fr, 2fr, auto, 2.5fr),
  table.header(
    [*Zweck*],
    [*Empfohlenes Template*],
    [*Typ*],
    [*Kernstärke*],
  ),
  [Folien \& Präsentationen],
  [Touying + calmly-touying],
  [Paket],
  [Stateful Animationen → Kap. 14],

  [Datengetriebene CVs],
  [Brilliant-CV],
  [Template],
  [YAML-Datentrennung → Kap. 14],

  [Sachbuch / Akademisch],
  [Ilm],
  [Template],
  [Systemisches Design → Kap. 14],

  [Belletristik],
  [TiefFiction],
  [Template],
  [Initialen, Kapitelumbrüche → unten],

  [Berichte mit Randnotizen],
  [Toffee-Tufte],
  [Template],
  [Margin-Engine → Kap. 16],

  [API-Dokumentation],
  [Mantys],
  [Template],
  [Meta-Scaffolding → Kap. 16],

  [Marketing / Menü],
  [Caidan],
  [Template],
  [Grid-loses Poster-Design → Kap. 17],

  [Glossar-Automatisierung],
  [Glossarium],
  [Paket],
  [Akronym-Tracking → Kap. 11],
)

#callout(title: [Template vs. Paket vs. Hybrid], tone: "info")[
  *Template*: Ein Projektgerüst, gestartet mit
  `typst init \@preview/name`. \
  *Paket*: Eine Bibliothek, importiert mit
  `\#import "\@preview/name:version"`. \
  *Hybrid*: Viele Templates können _auch_ als Pakete in ein bestehendes
  Dokument importiert werden: `\#show: template.with(...)`.
]

// ════════════════════════════════════════════════════════════════
== Wonderous-Book — Dynamische Kolumnentitel #tag("Dynamic Content Extraction")

Das Template _Wonderous-Book_#index[Wonderous-Book] (`\@preview/wonderous-book:0.1.2`) löst
ein zentrales Problem professioneller Bücher: Kolumnentitel#index[Kolumnentitel]
(Running Headers), die automatisch den aktuellen Kapitel- oder
Abschnittsnamen anzeigen — ohne manuelles Eingreifen.

=== Der Mechanismus

Die Kernlogik besteht aus drei Typst-Primitiven:

#code-block(title: [Dynamischer Kolumnentitel — Wonderous-Book-Muster])[
  ```typst
  #set page(header: context {
    // 1. Alle Level-1-Überschriften VOR der aktuellen Seite abfragen
    let headings = query(heading.where(level: 1).before(here()))

    // 2. Wenn keine Überschrift gefunden: leere Kopfzeile
    if headings.len() == 0 { return }

    // 3. Die letzte (= aktuellste) Überschrift anzeigen
    let chapter = headings.last().body
    emph(chapter)
    h(1fr)
    counter(page).display()
  })
  ```
]

#key-concept(term: [Context \& Query])[
  `query()` durchsucht das _vollständig kompilierte_ Dokument nach
  Elementen eines bestimmten Typs. `context` stellt sicher, dass der
  Code mit dem aktuellen Seitenkontext ausgewertet wird. Zusammen
  ermöglichen sie Kopfzeilen, Fußzeilen und Querverweise, die sich
  dynamisch an den Dokumentfluss anpassen.
]

=== Dieses Buch verwendet dasselbe Muster

Die Kolumnentitel, die Sie _auf dieser Seite_ sehen, werden durch
exakt dieselbe Technik erzeugt. Hier der Vergleich:

#comparison-layout(
  left-title: [Wonderous-Book],
  right-title: [Dieses Buch (`styles/page.typ`)],
  code-block(title: none)[
    ```typst
    // Vereinfacht aus wonderous-book
    #set page(header: context {
      let hs = query(
        heading.where(level: 1)
          .before(here())
      )
      if hs.len() == 0 { return }
      emph(hs.last().body)
      h(1fr)
      counter(page).display()
    })
    ```
  ],
  code-block(title: none)[
    ```typst
    // Aus styles/page.typ, Zeilen 20–45
    header: context {
      let current-page = here().page()
      let chapter-starts = query(
        heading.where(level: 1)
      )
      let on-chapter-start =
        chapter-starts.any(h =>
          h.location().page()
            == current-page)
      if on-chapter-start { return }
      let headings = query(
        heading.where(level: 1)
          .before(here()))
      if headings.len() == 0 { return }
      let chapter-title =
        headings.last().body
      // ... even/odd Positionierung
    }
    ```
  ],
)

#callout(title: [Meta-Moment], tone: "success")[
  Der Code in der rechten Spalte erzeugt die Kopfzeile, die Sie
  _genau jetzt_ lesen. Dieses Buch dokumentiert sich selbst.
]

#side-note(title: [Erweiterung])[
  Die Variante dieses Buchs unterdrückt Kolumnentitel auf
  Kapitelstartseiten (`on-chapter-start`) und unterscheidet
  gerade/ungerade Seiten für die Textausrichtung — zwei Details,
  die Wonderous-Book in ähnlicher Form ebenfalls implementiert.
  Siehe `templates/wonderous-book/` für die vollständige Vorlage.
]

// ════════════════════════════════════════════════════════════════
== TiefFiction — Traditioneller Buchsatz #tag("Thematic Overrides")

Während Wonderous-Book auf dynamische Kopfzeilen fokussiert, widmet
sich _TiefFiction_#index[TiefFiction] (`\@preview/tieffiction:0.2.0`) dem klassischen
Buchsatz#index[Buchsatz]: Schmuckinitialen#index[Schmuckinitiale] (Drop Caps), erzwungene Recto-Seiten
und traditionelle typografische Konventionen.

=== Initialen (Drop Caps)

Die Schmuckinitiale — ein vergrößerter Anfangsbuchstabe über zwei
oder mehr Zeilen — ist eines der ältesten typografischen Stilmittel.
TiefFiction implementiert sie als wiederverwendbare Funktion.

#code-block(title: [Vereinfachte Dropcap-Logik (aus TiefFiction)])[
  ```typst
  #let dropcap(size: 3em, body) = {
    let first-letter = body.text.first()
    let rest = body.text.slice(1)

    // Den Anfangsbuchstaben vergrößern und „floaten"
    box(
      height: 0pt,  // Kein vertikaler Platz im Textfluss
      text(size: size, weight: "bold", fill: palette.primary,
        baseline: -0.2em, first-letter),
    )
    h(0.1em)        // Abstand zum Fließtext
    rest
  }
  ```
]

// Scoped live demo of a drop cap using grid layout
#{
  let demo-text = "ie Differentialdiagnose der akuten Brustschmerzen umfasst kardiale, pulmonale und muskuloskelettale Ursachen. Eine systematische Anamnese ist der Schlüssel zur frühzeitigen Eingrenzung."

  figure(
    block(
      width: 100%,
      inset: space.md,
      fill: palette.bg-subtle,
      radius: 4pt,
      {
        grid(
          columns: (auto, 1fr),
          column-gutter: 4pt,
          // Large drop cap letter in left column
          align(top, text(
            size: 48pt,
            weight: "bold",
            fill: palette.primary,
            font: fonts.serif,
            "D",
          )),
          // Remaining text in right column, wrapping naturally
          align(horizon, text(size: type-scale.body, demo-text)),
        )
      },
    ),
    caption: [Schmuckinitiale — vereinfachte Demonstration des TiefFiction-Musters.],
  )
}

#callout(title: [Warum keine native CSS-Lösung?], tone: "info")[
  Typst bietet kein `float: left`-Äquivalent für Inline-Elemente.
  Drop Caps erfordern daher manuelle Manipulation von `box`,
  `text(size: ...)` und Baseline-Offsets. TiefFiction abstrahiert
  diese Komplexität in einer einzigen Funktion.
]

=== Kapitelumbrüche auf die rechte Seite

In der Buchgestaltung beginnen Kapitel traditionell auf der rechten
Seite (Recto#index[Recto-Seite]). Typst unterstützt dies nativ:

#code-block(title: [Recto-Kapitelstart])[
  ```typst
  // Kapitel beginnt immer rechts (ungerade Seitenzahl)
  #pagebreak(to: "odd")
  = Neues Kapitel
  ```
]

#side-note(title: [Dieses Buch])[
  Der `chapter-opener()` dieses Buchs verwendet `pagebreak(weak: true)`
  — er erzwingt keine Recto-Seite, da bei einem Showcase die
  Seitenzahl wichtiger ist als die Buchhaptik. TiefFiction dagegen
  setzt `pagebreak(to: "odd")` konsequent ein.
  Siehe `templates/tieffiction/` für die vollständige Vorlage.
]

#v(space.lg)

#pull-quote(
  attribution: [— Grundsatz der Buchtypografie],
)[
  Jedes typografische Detail — vom Kolumnentitel bis zur
  Schmuckinitiale — dient einem Ziel: dem Leser die Orientierung
  im Text zu erleichtern, ohne ihn vom Inhalt abzulenken.
]
