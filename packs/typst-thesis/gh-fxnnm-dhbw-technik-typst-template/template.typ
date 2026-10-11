// ============================================================
//  DHBW Stuttgart – Kern-Template
// ============================================================

#import "config.typ": document-language
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// ── Größen ───────────────────────────────────────────────────
#let font-size = 12pt

// ── Farben ───────────────────────────────────────────────────
#let dhbw-red = rgb("#E2001A")

// ── Haupt-Show-Regel ─────────────────────────────────────────
// Verwendung in main.typ:  #show: dhbw-document
#let dhbw-document(body) = {

  // Seite
  set page(
    paper:        "a4",
    margin:       2.5cm,
    numbering:    "I",
    number-align: center,
    footer: context {
      if counter(page).get().first() > 0 {
        align(center, text(size: 10pt, counter(page).display()))
      }
    },
  )

  // Schrift
  set text(
    font:     ("libertinus serif"),
    size:     font-size,
    lang:     document-language,
    hyphenate: true,
  )

  // Absatz (Zeilenabstand ca. 1.3×)
  set par(
    justify: true,
    leading: 1.1em,
    spacing: 1.2em,
  )

  // ── Überschriften (DIN 1421) ──────────────────────────────
  set heading(numbering: "1.1.")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.2em)
    block(
      text(size: 16pt, weight: "bold")[
        #if it.numbering != none [
          #counter(heading).display(it.numbering)#h(0.6em)
        ]
        #it.body
      ]
    )
    v(0.6em)
  }

  show heading.where(level: 2): it => {
    v(0.9em)
    block(
      text(size: 14pt, weight: "bold")[
        #if it.numbering != none [
          #counter(heading).display(it.numbering)#h(0.6em)
        ]
        #it.body
      ]
    )
    v(0.4em)
  }

  show heading.where(level: 3): it => {
    v(0.7em)
    block(
      text(size: 12pt, weight: "bold")[
        #if it.numbering != none [
          #counter(heading).display(it.numbering)#h(0.6em)
        ]
        #it.body
      ]
    )
    v(0.3em)
  }

  // ── Abbildungen ───────────────────────────────────────────
  show figure.where(kind: image): it => {
    v(0.3em)
    align(center, it.body)
    v(0.3em)
    align(center,
      text(size: 10pt)[
        *Abbildung #it.counter.display():* #it.caption.body
      ]
    )
    v(0.5em)
  }

  // ── Tabellen ──────────────────────────────────────────────
  show figure.where(kind: table): it => {
    v(0.3em)
    align(center,
      text(size: 10pt)[
        *Tabelle #it.counter.display():* #it.caption.body
      ]
    )
    v(0.3em)
    align(center, it.body)
    v(0.5em)
  }

  set figure(numbering: "1", gap: 0.6em)
  set figure.caption(separator: [: ])

  set table(
    stroke: 0.5pt + black,
    inset: (x: 6pt, y: 5pt),
  )

  // ── Formel-Abbildungen ────────────────────────────────────
  show figure.where(kind: "formel"): it => {
    v(0.3em)
    align(center, it.body)
    v(0.3em)
    align(center,
      text(size: 10pt)[
        *Formel #it.counter.display():* #it.caption.body
      ]
    )
    v(0.5em)
  }

  // ── Skript-Abbildungen ────────────────────────────────────
  show figure.where(kind: "skript"): it => {
    v(0.3em)
    it.body
    v(0.3em)
    align(center,
      text(size: 10pt)[
        *Skript #it.counter.display():* #it.caption.body
      ]
    )
    v(0.5em)
  }

  // ── Codeblöcke mit Zeilennummern (codly) ─────────────────
  show: codly-init.with()
  codly(zebra-fill: none, languages: codly-languages)

  body
}

// ── Formel-Hilfsfunktion ─────────────────────────────────────
// Wrapper für Gleichungen mit eigenem "Formel"-Zähler.
#let formel(body, caption: []) = figure(
  body,
  kind:       "formel",
  supplement: [Formel],
  caption:    caption,
)

// ── Skript-Hilfsfunktion ──────────────────────────────────────
// Wrapper für Code-Abbildungen mit eigenem "Skript"-Zähler.
#let skript(body, caption: []) = figure(
  body,
  kind:       "skript",
  supplement: [Skript],
  caption:    caption,
)

