// chapters/16-margin-patterns.typ — Komplexe Randnotizen und API-Dokus
// Teil V, Phase 2: Toffee-Tufte, Mantys

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
  title: [Komplexe Randnotizen und API-Dokus],
  lead: [
    Technische Berichte und API-Handbücher benötigen Strukturen
    jenseits des einfachen Textflusses: breite Ränder für
    Annotationen, parallele Code- und Ausgabeblöcke sowie
    automatische Überlappungsvermeidung. Dieses Kapitel seziert
    zwei Templates, die genau diese Probleme lösen.
  ],
)

// ════════════════════════════════════════════════════════════════
== Toffee-Tufte — Die Randnotiz-Architektur #tag("Margin Architectures")

Das Template _Toffee-Tufte_#index[Toffee-Tufte] (`\@preview/toffee-tufte:0.1.1`)
implementiert den berühmten Tufte-Layoutstil#index[Tufte-Layout]: eine schmale
Haupttextspalte und ein breiter Rand für Notizen, Zitate und
kleine Abbildungen — benannt nach dem Informationsdesigner
Edward Tufte.

=== Die drei Bausteine

Das Tufte-Layout basiert auf drei Typst-Primitiven, die
zusammen eine leistungsfähige Randnotiz-Engine ergeben:

#feature-grid(
  column-count: 3,
  (
    (
      icon: sym.arrow.r,
      title: [`measure()`],
      body: [Berechnet die physische Höhe eines Inhaltsblocks
        _bevor_ er platziert wird.],
    ),
    (
      icon: sym.circle.filled,
      title: [`place()`],
      body: [Positioniert einen Block an absoluten Koordinaten,
        ohne den Textfluss zu unterbrechen.],
    ),
    (
      icon: sym.bar.h,
      title: [`state()`],
      body: [Verfolgt die Y-Position der letzten Randnotiz,
        um Überlappungen zu verhindern.],
    ),
  ),
)

=== Der Mechanismus im Detail

Die Kernherausforderung: Wenn mehrere Randnotizen#index[Randnotiz] auf derselben
Seite erscheinen, dürfen sie sich nicht überlappen. Toffee-Tufte
löst dies durch einen vertikalen Positionszähler:

#code-block(title: [Randnotiz-Platzierung (vereinfacht)])[
  ```typst
  // Zustand: Y-Position der nächsten freien Stelle im Rand
  #let margin-y = state("margin-y", 0pt)

  #let margin-note(content) = {
    // 1. Höhe der Note messen
    let note-height = measure(
      block(width: 4cm, content)
    ).height

    // 2. Aktuelle Y-Position lesen (context nötig)
    context {
      let y = margin-y.get()

      // 3. In den Rand platzieren
      place(
        right,
        dx: 5cm,    // Versatz in den rechten Rand
        dy: y,      // Vertikale Position
        block(width: 4cm, content),
      )

      // 4. Positionszähler für nächste Note aktualisieren
      margin-y.update(y + note-height + 8pt)
    }
  }
  ```
]

#key-concept(term: [Kollisionsvermeidung])[
  Das schwierigste Problem bei Randnotizen ist die
  *Überlappungsvermeidung*. Toffee-Tufte löst es durch einen
  `state()`-basierten Y-Zähler: Jede neue Note liest die
  Position der vorherigen, addiert deren Höhe plus einen
  Abstandswert, und platziert sich darunter. So entsteht ein
  kollisionsfreier vertikaler Stapel im Seitenrand.
]

=== Scoped Demo: Randnotizen im Miniaturformat

Die folgende Demonstration zeigt das Prinzip — innerhalb eines
begrenzten Blocks, ohne die Seitenränder#index[Seitenrand] dieses Buchs zu
verändern:

#{
  // Helper for a styled margin note block
  let note-block(note-text, color: palette.info) = {
    block(
      width: 100%,
      inset: space.sm,
      fill: color.lighten(90%),
      stroke: (left: 2pt + color),
      radius: (right: 3pt),
      text(size: type-scale.small, fill: color.darken(20%), note-text),
    )
  }

  figure(
    block(
      width: 100%,
      inset: space.md,
      fill: white,
      stroke: 0.5pt + palette.border-light,
      radius: 4pt,
      {
        grid(
          columns: (3fr, 2fr),
          column-gutter: space.md,
          // Left: main text column
          {
            text(size: type-scale.body)[
              Die Differentialdiagnose der akuten Dyspnoe erfordert eine
              systematische Evaluation kardialer, pulmonaler und
              metabolischer Ursachen. Die initiale Abklärung umfasst
              Anamnese, körperliche Untersuchung und gezielte
              Basisdiagnostik.
            ]
            v(space.md)
            text(size: type-scale.body)[
              Besondere Aufmerksamkeit verdient die Abgrenzung zwischen
              akutem Koronarsyndrom und Lungenembolie, da beide
              Krankheitsbilder eine sofortige Intervention erfordern.
            ]
            v(space.md)
            text(size: type-scale.body)[
              Die Bestimmung von D-Dimeren, BNP und Troponin bildet
              die laborchemische Trias der Notfalldiagnostik.
            ]
          },
          // Right: stacked margin notes
          {
            note-block([Kardiale Ursachen: ACS, Herzinsuffizienz,
              Perikardtamponade], color: palette.info)
            v(space.sm)
            note-block([Cave: Wells-Score zur Einschätzung
              der Vortestwahrscheinlichkeit für Lungenembolie],
              color: palette.warning)
            v(space.sm)
            note-block([D-Dimere: hohe Sensitivität,
              geringe Spezifität — Ausschlussdiagnostik],
              color: palette.success)
          },
        )
      },
    ),
    caption: [Randnotiz-Architektur im Miniaturformat — drei kollisionsfreie Annotationen im simulierten Seitenrand.],
  )
}

#side-note(title: [Tufte vs. Side-Note])[ Die `side-note()`-Komponente
  dieses Buchs ist ein _Inline_-Element innerhalb der Textspalte.
  Toffee-Tuftes Architektur dagegen ist eine _Seitenlayout_-Entscheidung:
  Die gesamte Dokumentgeometrie wird so umgebaut, dass 30–40% der
  Seitenbreite als Randbereich zur Verfügung stehen.
  Siehe `templates/toffee-tufte/` für die vollständige Vorlage.
]

#callout(title: [Ausblick: Native Randnotizen], tone: "warning")[
  Die Typst-Entwickler haben native Margin-Note-Unterstützung als
  Feature-Request aufgenommen. Bis dahin bleiben `measure()` +
  `place()` + `state()` die bewährten Workarounds.
]

// ════════════════════════════════════════════════════════════════
== Mantys — Meta-Scaffolding für Dokumentation #tag("Thematic Overrides")

_Mantys_#index[Mantys] (`\@preview/mantys:1.0.2`) ist ein Template, das speziell
für die Dokumentation von Typst-Paketen entwickelt wurde. Es zeigt
ein mächtiges Muster: _Documentation as Code_#index[Documentation as Code] — API-Referenzen
werden nicht manuell geschrieben, sondern aus strukturierten
Beschreibungsfunktionen generiert.

=== Das Muster: Beschreibungsfunktionen

Statt Funktions-APIs in Prosa zu beschreiben, definiert Mantys
spezialisierte Typst-Funktionen, die technische Spezifikationen#index[API-Dokumentation]
konsistent formatieren:

#code-block(title: [Mantys-Stil: API-Dokumentation als Funktionsaufrufe])[
  ```typst
  // Mantys definiert Hilfsfunktionen für API-Docs:
  #command("callout",
    arg("body", type: "content"),
    arg("title", type: "string", default: "none"),
    arg("tone", type: "string", default: "\"info\""),
    sarg("icon", type: "symbol"),
  )[
    Erzeugt einen semantischen Hinweiskasten mit farbiger
    Akzentleiste und optionalem Icon.
  ]
  ```
]

=== Meta-Rekursion: Dieses Buch dokumentiert sich selbst

Als Demonstration verwenden wir das Mantys-Muster, um die
`callout()`-Funktion _dieses Buchs_ zu dokumentieren — das Buch
dokumentiert seine eigenen Komponenten:

#card(title: [API-Referenz: `callout()`], accent: palette.info)[
  #styled-table(
    columns: (1.5fr, 1fr, 1fr, 3fr),
    table.header(
      [*Parameter*],
      [*Typ*],
      [*Standard*],
      [*Beschreibung*],
    ),
    [`body`],
    [`content`],
    [—],
    [Der Inhalt des Hinweiskastens],

    [`title`],
    [`content`],
    [`none`],
    [Optionaler Titel in Fettschrift],

    [`tone`],
    [`string`],
    [`"info"`],
    [Farbschema: `"info"` · `"success"` · `"warning"` · `"danger"`],

    [`icon`],
    [`symbol`],
    [`none`],
    [Optionales Symbol vor dem Titel],
  )
]

#comparison-layout(
  left-title: [Unstrukturierte Prosa],
  right-title: [Mantys-Stil: Funktionsaufruf],
  block(
    inset: space.md,
    text(size: type-scale.small)[
      Die Funktion `callout` akzeptiert einen Body als Content,
      einen optionalen Titel als String, einen Tone-Parameter
      der "info", "success", "warning" oder "danger" sein kann,
      und ein optionales Icon-Symbol.
    ],
  ),
  code-block(title: none)[
    ```typst
    #command("callout",
      arg("body", type: "content"),
      arg("title",
        type: "string",
        default: "none"),
      arg("tone",
        type: "string",
        default: "\"info\""),
    )[Semantischer Hinweiskasten.]
    ```
  ],
)

#callout(title: [Warum funktioniert dieses Muster?], tone: "info")[
  Mantys' Stärke liegt in _Thematic Overrides_: Es definiert
  `\#command()`, `\#arg()` und weitere Hilfsfunktionen, die
  technische Spezifikationen in ein konsistentes visuelles Format
  übersetzen. Änderungen am Design propagieren automatisch durch
  alle dokumentierten Funktionen.
]

#side-note(title: [Verwandtes Template])[
  Das Paket _Tidy_ (`\@preview/tidy`, vorgestellt in Kapitel~13)
  verfolgt einen komplementären Ansatz: Statt manueller
  `\#command()`-Aufrufe parst Tidy Docstrings direkt aus dem
  Quellcode. Mantys eignet sich für handgeschriebene Referenzen,
  Tidy für automatisch generierte.
  Siehe `templates/mantys/` für die vollständige Vorlage.
]

#v(space.lg)

#pull-quote(
  attribution: [— Prinzip der technischen Dokumentation],
)[
  Die beste Dokumentation beschreibt nicht nur, _was_ eine Funktion
  tut — sie demonstriert _wie_ sie implementiert ist und _warum_
  die Designentscheidungen so getroffen wurden.
]
