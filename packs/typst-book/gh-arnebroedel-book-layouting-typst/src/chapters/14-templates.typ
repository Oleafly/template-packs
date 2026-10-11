// chapters/14-templates.typ — Vorlagen, Präsentationen und Enterprise

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table
#import "@preview/fontawesome:0.6.1": *
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Vorlagen, Präsentationen und Enterprise],
  lead: [
    Das Typst-Ökosystem bietet vollständige, meinungsstarke Designsysteme — von Präsentationsfolien bis hin zu Corporate-Document-Shells. Dieses Kapitel beleuchtet, wie diese Vorlagen architektonisch aufgebaut sind, auch wenn sie nicht direkt innerhalb dieses Buches ausgeführt werden können.
  ],
)

// ════════════════════════════════════════════════════════════════
== Touying — Präsentations-Framework

Touying#index[Touying] ist das mächtigste Präsentations-Framework#index[Präsentation] in Typst und unterstützt komplexe Animationen, globale Themes und einen eigenen Compiler-State für Folienübergänge.

```typ
#import "@preview/touying:0.7.4": *
#import themes.simple: *

#show: simple-theme.with(aspect-ratio: "16-9")

= Präsentationstitel

== Erste Folie

Hier ist Inhalt, der sofort sichtbar ist.
#pause
Hier ist Inhalt, der nach dem ersten Klick erscheint.
```

#callout(tone: "warning", title: [Warum keine Live-Demo?])[
  Touying überschreibt die globale `page`-Funktion, um das 16:9-Seitenverhältnis und folienspezifische Margen festzulegen. Ein Aufruf innerhalb dieses A4-Buches würde das gesamte Layout der umliegenden Seiten zerstören.
]

#card()[
  *Kernkonzepte von Touying:*
  - `#pause`: Setzt Animationsmarker für schrittweises Einblenden.
  - `#meanwhile`: Erlaubt parallelen Inhalt in verschiedenen Spalten.
  - *Context:* Touying nutzt Typsts `context` extrem intensiv, um das aktuelle Theme und den Animationsstatus dokumentenweit synchron zu halten.
]

#side-note(title: [Referenz])[
  Touying wird in Kapitel 08 in der Schnellreferenz erwähnt — dieses Kapitel erklärt die Architektur hinter dem Framework.
]

// ════════════════════════════════════════════════════════════════
== Ilm — Organisatorische Design-Shell

Ilm#index[Ilm] bietet eine "One-Liner"-API, um komplexe Dokumente sofort in einem sauberen, wissenschaftlichen Stil zu formatieren.

```typ
#import "@preview/ilm:2.1.1": *

#show: ilm.with(
  title: [Medizinischer Bericht],
  authors: [Dr. Max Mustermann], // ilm 2.1.x: `author` entfernt → `authors`
  date: datetime(year: 2026, month: 2, day: 28),
  table-of-contents: true
)

= Einleitung
Der Bericht beginnt hier...
```

#fa-version("6")
#feature-grid(
  (
    (icon: fa-table-cells(fill: palette.primary), title: [Seitenlayout], body: [Setzt Margen, Kopf- und Fußzeilen automatisch.]),
    (icon: fa-font(fill: palette.accent-dark), title: [Typografie], body: [Konfiguriert Fonts und Größen konsistent.]),
    (icon: fa-list(fill: palette.info), title: [Verzeichnisse], body: [Generiert Inhalts- und Abbildungsverzeichnisse.]),
    (icon: fa-circle-info(fill: palette.success), title: [Metadaten], body: [Befüllt die PDF-Metadaten passend zum Titel.]),
  )
)

#callout(tone: "info")[
  Im Gegensatz zu diesem Showcase, das aus modularen Komponenten (`styles/` und `components/`) besteht, ist Ilm eine _opinionierte, in sich geschlossene Shell_. Nutzer schreiben keine eigene Layout-Logik.
]

#side-note(title: [Konflikte vermeiden])[
  Ebenso wie Touying würde Ilm die `setup-typography`- und `setup-pages`-Regeln dieses Buches überschreiben, weshalb es hier als Code-Beispiel gezeigt wird.
]

// ════════════════════════════════════════════════════════════════
== Brilliant-CV — Datengetriebene Vorlagen

Brilliant-CV#index[Brilliant-CV] zeigt einen völlig anderen Ansatz: Die Trennung von Daten (YAML/TOML) und Ansicht (Typst).

#comparison-layout(
  [
    *Kapitel 09 — Rohdaten → individuelles Rendering* 
    Der Entwickler liest die CSV/JSON-Daten ein und schreibt eine explizite `for`-Schleife, um jedes Element mit Typst-Befehlen zu rendern.
  ],
  [
    *Brilliant-CV — Strukturierte YAML → opinionierte Vorlage* 
    Der Nutzer befüllt nur eine `metadata.toml` oder `.yaml`. Die Vorlage verarbeitet die Struktur automatisch und rendert das vordefinierte Layout.
  ]
)

```typ
// Beispielhafter Aufruf von Brilliant-CV (klassisches Root-Metadata-Muster).
// Hinweis: brilliant-cv 4.x nutzt ein profilbasiertes Modell
// (profile_<name>/metadata.toml, Auswahl via --input profile=<name>).
#import "@preview/brilliant-cv:2.1.0": cv
#let metadata = toml("metadata.toml")
#show: cv.with(metadata)
```

#key-concept(term: [Separation of Concerns])[
  Die Layout-Logik des Lebenslaufs ist vollständig vom Inhalt getrennt. Dies ermöglicht es Nutzern, Vorlagen auszutauschen, ohne ihre Datenstruktur anpassen zu müssen.
]

// ════════════════════════════════════════════════════════════════
== Enterprise-Muster

#callout(tone: "info", title: [Ressourcenlimitierung mit layout-ltd])[
  In Multi-Tenant- oder CI-Umgebungen besteht die Gefahr, dass fehlerhafte Vorlagen in Endlosschleifen geraten. Das Paket `@preview/layout-ltd:0.1.0` setzt harte Limits auf Layout-Iterationen, um übermäßige CPU-Nutzung zu verhindern. Der visuelle Output bleibt identisch — es ist eine reine Backend-Sicherheitsmaßnahme, die hervorragend zu den in Kapitel 10 besprochenen Enterprise-Mustern passt.
]
