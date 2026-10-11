// =============================================================================
// GRUNDLAYOUT UND TITELBLATT
//
// Wird in main.typ als Show-Rule angewendet:
//   #show: doc => project(cfg, doc)
//
// Alle sichtbaren Texte stammen aus lib/i18n.typ, alle Werte aus config.typ.
// =============================================================================

#import "i18n.typ": t

#let project(cfg, body) = {
  set document(
    title: cfg.title,
    author: cfg.author,
    keywords: cfg.keywords,
    date: auto,
  )

  set text(font: cfg.font, size: cfg.font_size, lang: cfg.lang)
  set par(leading: cfg.line_spacing, justify: true, spacing: 1.5em)
  set page(
    paper: "a4",
    margin: cfg.margins,
    numbering: none,
    number-align: bottom + right,
  )

  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(supplement: t.chapter)

  // Nummerierung von abgesetzten Formeln, z. B. "(1)". none = ohne Nummer.
  set math.equation(numbering: cfg.equation_numbering)

  // Einheitliches Tabellenbild, damit nicht jede Tabelle eigene Linien und
  // Innenabstaende mitbringen muss.
  set table(stroke: cfg.table_stroke, inset: cfg.table_inset)
  show table: set text(size: cfg.table_font_size)

  // Lange Tabellen duerfen ueber Seitengrenzen laufen, statt als Ganzes auf
  // die naechste Seite zu rutschen und eine halbe Leerseite zu hinterlassen.
  show figure.where(kind: table): set block(breakable: cfg.breakable_tables)

  show heading: it => {
    // Kapitel beginnen auf einer neuen Seite. weak: true verhindert eine
    // Leerseite, wenn die Seite ohnehin gerade beginnt.
    let starts-page = it.level == 1 and cfg.chapter_pagebreak
    if starts-page { pagebreak(weak: true) }

    if it.level > cfg.heading_depth {
      // Ab cfg.heading_depth + 1: unnummeriert, nur fett und kompakter.
      v(0.5cm)
      text(weight: "bold", size: cfg.font_size, it.body)
      v(0.3em)
    } else {
      // Nach einem Seitenumbruch kein zusaetzlicher Vorabstand.
      if not starts-page { v(1cm) }
      it
      v(0.5em)
    }
  }

  counter(page).update(1)

  // --- Titelblatt ----------------------------------------------------------
  {
    if cfg.university_logo != none {
      align(center, cfg.university_logo)
      v(1.2cm)
    }

    align(center)[
      #text(size: 16pt, weight: "bold")[#cfg.title]

      #if cfg.subtitle != none [
        #v(0.6em)
        #text(size: cfg.font_size)[#cfg.subtitle]
      ]

      #v(1cm)
      #text(size: 14pt, weight: "bold")[#cfg.thesis_type]

      #v(0.5cm)
      #text(size: 11pt)[#t.degree_intro]

      #v(0.3cm)
      #text(size: 14pt, weight: "bold")[#cfg.degree]
      #v(0.2cm)
      #text(size: 11pt)[#t.in_program #cfg.program]

      #v(0.8cm)
      #text(size: 11pt)[#t.submitted_to]\
      #text(size: 11pt)[#cfg.faculty]\
      #text(size: 11pt)[#cfg.university]

      #v(0.8cm)
      #text(size: 11pt)[#t.by]\
      #text(size: 14pt, weight: "bold")[#cfg.author]
      #if cfg.matr_nr != none [
        \ #text(size: 10pt)[#t.matr_label: #cfg.matr_nr]
      ]

      #v(0.5cm)
      #text(size: cfg.font_size)[#cfg.submission_date]

      #v(1.1cm)
      #grid(
        columns: (auto, auto),
        align: (left, left),
        column-gutter: 1em,
        row-gutter: 0.5em,
        ..cfg.advisors.flatten()
      )
    ]

    if cfg.company_logo != none {
      v(1.1cm)
      align(right, cfg.company_logo)
    }

    pagebreak()
  }

  // Die Seitennummerierung wird in lib/frontmatter.typ umgeschaltet.
  body
}
