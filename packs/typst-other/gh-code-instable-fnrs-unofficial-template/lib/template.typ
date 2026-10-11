// lib/template.typ — Shared FNRS template library
// Centralizes all reusable formatting, colors, fonts, and components.
#import "@preview/cuti:0.4.0"
#let txt-size-large = 14pt
#let txt-size-medium = 12pt
#let txt-size-small = 10pt
// ─────────────────────────────────────────────
// Colors
// ─────────────────────────────────────────────
#let fnrs-blue = rgb("#0000FF")      // hyperlinks
#let fnrs-light-blue = rgb("#DBE5F1")      // detail_cursus title bar
#let fnrs-light-gray = rgb("#D9D9D9")      // detail_cursus example row
#let fnrs-light-green = rgb("#E2EFD9")     // classement header row
#let fnrs-magenta = rgb("#8B0066")      // classement title accent
#let fnrs-green = rgb("#538135")      // classement instruction text

// ─────────────────────────────────────────────
// Fonts
// ─────────────────────────────────────────────
#let fnrs-font-arial = "Arial"
#let fnrs-font-century = ("Century Gothic", "Avenir", "Futura")
#let fnrs-font-calibri = "Calibri"

// ─────────────────────────────────────────────
// Shared constants
// ─────────────────────────────────────────────
#let fnrs-table-stroke = 0.5pt + black
#let fnrs-instructions-url = "https://e-space.frs-fnrs.be/documents_publics/ressource/BM_consignes_template_EN.pdf"
#let fnrs-header-text = "Fonds de la Recherche Scientifique – FNRS"

// ─────────────────────────────────────────────
// Bilingual helpers
// ─────────────────────────────────────────────

/// Bold French label followed by italic English translation: `**FR** / _EN_`
#let bilingual(
  fr,
  en,
) = [#text(weight: "bold")[#fr] / #text(style: "italic")[#en]]

/// Bold+italic bilingual (both bold): `**FR** / ***EN***`
#let bilingual-bold(
  fr,
  en,
) = [#text(weight: "bold")[#fr] / #text(weight: "bold", style: "italic")[#en]]

/// Table header cell: bold FR on one line, bold-italic EN on the next
#let bilingual-header(fr, en) = [
  #text(weight: "bold")[#fr]
  #linebreak()
  #text(weight: "bold", style: "italic")[#en]
]

// ─────────────────────────────────────────────
// Manual footnote
// ─────────────────────────────────────────────

/// Renders a manual footnote block (number + text, with hanging indent)
#let manual-footnote(number, body, size: 8pt) = {
  par(hanging-indent: 0.25cm, first-line-indent: 0pt)[
    #text(size: size)[#super[#number] #body]
  ]
}

/// Footnote separator line
#let footnote-separator() = {
  line(length: 30%, stroke: fnrs-table-stroke)
  v(4pt)
}

// ─────────────────────────────────────────────
// Page setup: EN templates (A4, 1.5cm margins, Arial txt-size-medium)
// ─────────────────────────────────────────────

#let fnrs-page-setup(show-footer: true, body) = {
  set page(
    paper: "a4",
    margin: (top: 1.5cm, bottom: 1.5cm, left: 1.5cm, right: 1.5cm),
    header-ascent: 0.5cm,
    footer-descent: 0.7cm,
    header: align(right)[
      #text(font: fnrs-font-arial, size: txt-size-small)[#fnrs-header-text]
    ],
    footer: if show-footer {
      context align(right)[
        #text(font: fnrs-font-arial, size: txt-size-small)[
          #counter(page).display() / #counter(page).final().first()
        ]
      ]
    },
  )

  set text(
    font: fnrs-font-arial,
    size: txt-size-medium,
    lang: "en",
    region: "GB",
  )

  set heading(numbering: "1.1")

  set par(
    justify: true,
    spacing: 0pt,
    leading: 0.65em,
    first-line-indent: 0.5em,
  )

  show heading: it => {
    let number = counter(heading).at(it.location())
    if it.level == 1 {
      v(6pt)
      block(spacing: 0pt)[
        #set par(justify: false)
        #set text(weight: "bold", size: txt-size-large)
        #if number != none { [#number.first(). ] }
        #underline(offset: 0.15em, stroke: 0.1em, cuti.fakesc(it.body))
      ]
      v(6pt)
    } else if it.level == 2 {
      v(4pt)
      block(spacing: 0pt)[
        #set par(justify: false)
        #text(weight: "bold", size: txt-size-medium)[
          #if number != none { [#number.map(str).join(".") ] }
          #h(1.1em)
          #it.body
        ]
      ]
      v(4pt)
    }
  }

  show link: it => {
    set text(fill: fnrs-blue)
    underline(it)
  }

  body
}

// ─────────────────────────────────────────────
// Header table (3-col: title | instrument | e-space)
// ─────────────────────────────────────────────

/// Header table used by all EN templates.
/// Cols from docx: 5386 + 1701 + 1984 = 9071 twips
#let fnrs-header-table(
  title: "",
  instructions-url: fnrs-instructions-url,
  instrument: auto,
  espace-number: auto,
) = {
  table(
    columns: (1fr, 1701 / 9071 * 100%, 1984 / 9071 * 100%),
    rows: (auto, 0.7cm),
    stroke: fnrs-table-stroke,
    inset: (x: 3.8pt, y: 6pt),
    align: center + horizon,
    table.cell(rowspan: 2, align: center + horizon)[
      #text(weight: "bold", size: txt-size-large)[#title]
      #linebreak()
      #link(instructions-url)[#text(
        size: txt-size-large,
      )[#cuti.fakesc[instructions]]]

    ],
    table.cell[#text(weight: "bold", size: txt-size-small)[Instrument]],
    table.cell[#text(weight: "bold", size: txt-size-small)[e-space number]],
    table.cell[#if instrument != auto [#text(
      size: txt-size-small,
    )[#instrument]]],
    table.cell[#if espace-number != auto [#text(
      size: txt-size-small,
    )[#espace-number]]],
  )
}

// ─────────────────────────────────────────────
// Section / subsection headings
// ─────────────────────────────────────────────

/// Section heading: bold, small caps, txt-size-large, underlined, left-aligned
#let fnrs-section-heading(number: none, body) = {
  v(6pt)
  block(spacing: 0pt)[
    #set par(justify: false)
    #set text(weight: "bold", size: txt-size-large)
    #if number != none {
      [#number. ]
    }
    #underline(offset: 0.15em, stroke: 0.1em, cuti.fakesc(body))
  ]
  v(6pt)
}

/// Sub-section heading: bold, txt-size-medium
#let fnrs-subsection-heading(number: "", body) = {
  // v(4pt)
  block(spacing: 0pt)[
    #set par(justify: false)
    #text(weight: "bold", size: txt-size-medium)[#number #h(1em) #body]
  ]
  v(4pt)
}
