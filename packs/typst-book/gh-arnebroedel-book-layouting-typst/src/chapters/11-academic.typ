// chapters/11-academic.typ — Akademisches Publizieren und Mathematik

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Akademisches Publizieren und Mathematik],
  lead: [
    Typst bietet von Haus aus exzellente Unterstützung für Mathematik und Literaturverzeichnisse. Dennoch können bestimmte akademische Workflows — wie spezifische mathematische Notationen oder komplexe Glossare — durch Community-Pakete deutlich vereinfacht und spezialisiert werden.
  ],
)

// ════════════════════════════════════════════════════════════════
== Mathematische Kurzschreibweisen mit Physica

#import "@preview/physica:0.9.8": *

Die Eingabe komplexer mathematischer Formeln kann zeitaufwändig sein. Physica#index[Physica] bietet hunderte von Kurzschreibweisen, um den Schreibfluss zu beschleunigen und den Quellcode lesbarer zu machen.

#comparison-layout(
  [
    *Ohne Physica*
    ```typ
    $ frac(partial f, partial x) $
    $ arrow(u) $
    $ grad f $
    ```
    #figure(
      box(stroke: 1pt + luma(200), inset: 8pt, radius: 4pt, width: 100%)[
        $ frac(partial f, partial x) $
        $ arrow(u) $
        $ grad f $
      ],
      numbering: none,
      alt: "Drei Formeln in nativer Typst-Notation: partielle Ableitung von f nach x, Vektor u und Gradient von f.",
    )
  ],
  [
    *Mit Physica*
    ```typ
    $ pdv(f, x) $
    $ vu(u) $
    $ grad f, quad div va(v), quad curl va(v) $
    ```
    #figure(
      box(stroke: 1pt + palette.primary, inset: 8pt, radius: 4pt, width: 100%)[
        $ pdv(f, x) $
        $ vu(u) $
        $ grad f, quad div va(v), quad curl va(v) $
      ],
      numbering: none,
      alt: "Dieselben Formeln in Physica-Kurzschreibweise: partielle Ableitung, Einheitsvektor, Gradient, Divergenz und Rotation.",
    )
  ]
)

Ebenso erleichtert das Paket die Eingabe von Matrizen, Vektoren und anderen Operatoren. Eine einfache Matrix lässt sich mit `mat` anstatt Typsts nativer `mat(...)` Syntax schreiben, falls man die Notation aus LaTeX bevorzugt.

#callout(tone: "info")[
  Physica bietet hunderte solcher Kurzschreibweisen, die stark an die gleichnamige LaTeX-Bibliothek angelehnt sind. Die vollständige Referenz finden Sie in der Dokumentation des Pakets.
]

// ════════════════════════════════════════════════════════════════
== Intelligente Abkürzungsverwaltung mit Glossarium

#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, gls, glspl

#show: make-glossary

// Define a small glossary dictionary
#let dict = (
  (
    key: "EKG",
    short: "EKG",
    long: "Elektrokardiogramm",
  ),
  (
    key: "MRT",
    short: "MRT",
    long: "Magnetresonanztomographie",
  ),
  (
    key: "SpO2",
    short: "SpO2",
    long: "periphere kapillare Sauerstoffsättigung",
  ),
)

#{
  // Register dictionary (local scope to avoid leaking)
  import "@preview/glossarium:0.5.10": register-glossary
  register-glossary(dict)
}

Glossarium#index[Glossarium] ermöglicht eine automatisierte Verwaltung von Abkürzungen. Beim ersten Aufruf im Text wird die vollständige Definition ausgegeben, bei jedem weiteren Aufruf lediglich die Kurzform.

- *Erste Verwendung:* Der Patient erhielt ein #gls("EKG")#index[Elektrokardiogramm].
- *Zweite Verwendung:* Das #gls("EKG") war unauffällig.
- *Weitere Begriffe:* Zur weiteren Diagnostik wurde ein #gls("MRT")#index[Magnetresonanztomographie] angeordnet. Die #gls("SpO2") lag bei 98%.

#key-concept(term: [Introspection])[
  Glossarium nutzt Typsts `query()` und `state()` Mechanismen, um die erstmalige Verwendung von Begriffen über das gesamte Dokument hinweg zu verfolgen. Es speichert den Status jedes Begriffs und passt die Ausgabe bei späteren Aufrufen automatisch an.
]

#side-note(title: [Scoping])[
  Glossariums Show-Rules gelten für das gesamte Dokument. Für komplexere Projekte empfiehlt es sich, die Initialisierung zentral in der Dokumentvorlage vorzunehmen.
]

#print-glossary(dict)

// ════════════════════════════════════════════════════════════════
== Mehrere Literaturverzeichnisse — nativ seit Typst 0.15

Bis Typst 0.14 unterstützte der Compiler nur ein einziges `bibliography`-Element pro Dokument. Seit *Typst 0.15* ist diese Einschränkung aufgehoben: Mehrere `bibliography`-Elemente sind nativ erlaubt — ganz ohne Zusatzpaket. Jede Zitation bindet automatisch an das *nächste folgende* Verzeichnis, und jedes Verzeichnis nummeriert unabhängig. Für feinere Kontrolle steuern die Parameter `target` und `group` die Zuordnung explizit.

Das folgende Beispiel rendert zwei getrennte, real kompilierte Verzeichnisse — eines für klinische, eines für Grundlagenquellen:

#heading(level: 3, outlined: false, numbering: none)[Klinische Literatur]
Die Notaufnahme-Praxis @smith2024 illustriert den klinischen Quellentyp.
#bibliography("../data/klinisch.bib", title: none)

#heading(level: 3, outlined: false, numbering: none)[Grundlagenliteratur]
Die kardiovaskuläre Anatomie @jones2023 steht für den Grundlagentyp.
#bibliography("../data/grundlagen.bib", title: none)

#callout(tone: "info")[
  Die Zitation `@smith2024` bindet an das unmittelbar folgende klinische Verzeichnis, `@jones2023` an das Grundlagenverzeichnis. Die Nummerierung ist pro Verzeichnis unabhängig — beide beginnen bei `[1]`.
]

=== Alternative vor 0.15: Präfixe mit Alexandria

Vor Typst 0.15 löste das Paket *Alexandria*#index[Alexandria] dieselbe Aufgabe über ein Präfix-System (Show-Rule-Interception): `@klinisch:smith2024` und `@grundlagen:jones2023` sortieren in getrennte Verzeichnisse. Für Projekte auf älteren Compilern bleibt dies eine valide Lösung.

```typ
#import "@preview/alexandria:0.2.2": bibliography
#bibliography("klinisch.bib", prefix: "klinisch:")
#bibliography("grundlagen.bib", prefix: "grundlagen:")
```

// ════════════════════════════════════════════════════════════════
== Bibliografie-Styling in Typst mit Pergamon

Während Typst CSL (Citation Style Language) für das Styling von Bibliografien nutzt, gibt es Fälle, in denen man die Formatierung direkt mit Typst-Regeln kontrollieren möchte. Pergamon#index[Pergamon] ermöglicht genau dies: Typst-natives Bibliografie#index[Bibliografie]-Styling.

#comparison-layout(
  [
    *Standard Typst (CSL)*
    ```typ
    #bibliography("pergamon.bib", style: "apa")
    ```
    _Nutzt eine externe .csl-Datei zur Bestimmung des Layouts._
  ],
  [
    *Mit Pergamon*
    ```typ
    #import "@preview/pergamon:0.8.0": *
    #add-bib-resource(read("pergamon.bib"))
    #refsection(style: numeric-style())[
      // ... zitierter Text ...
      #print-bibliography()
    ]
    ```
    _Erlaubt das Überschreiben des Layouts mit Typst-Funktionen._
  ]
)

#side-note(title: [Refsections])[
  Neben dem Styling ermöglicht Pergamon auch sogenannte "Refsections" — kapitelweise Literaturverzeichnisse — und benutzerdefiniertes Filtern nach Schlüsselwörtern. Diese Funktionen sind mit reinem CSL nicht umsetzbar.
]
