// -------------------------------------------------------------------------
// File: template/main.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Core layout definition for the Typify template.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "config.typ": *
#import "components/header.typ": header-content
#import "components/footer.typ": footer-content
#import "components/cover-heia.typ": cover-page-heia
#import "components/cover-default.typ": cover-page-default
#import "components/outlines.typ": table-of-contents, table-of-figures
#import "components/bibliography.typ": generate-bibliography

// --- Main Project Function ---
#let project(
  title: DEFAULT_TITLE,
  authors: "",
  date: DEFAULT_DATE,
  date-format: DEFAULT_DATE_FORMAT,
  header: false,
  toc: false,
  tof: false,
  cover: false,
  heia: true, // HEIA theme by default
  subtitle: none,
  classe: none,
  body,
  footer: true,
  bibliography: false, // Generate bibliography
  bibliography-file: "bibliography.bib", // Bibliography file path (relative to document)
) = {
  // Load theme colors based on heia parameter
  let theme = if heia {
    // HEIA theme: override with HEIA colors
    (
      primary: COLOR_HEIA_PRIMARY,
      accent: COLOR_HEIA_ACCENT,
      accent-border: COLOR_HEIA_ACCENT_BORDER,
      logo: "../../assets/heia-logo.png",
      cover-image: "../../assets/cover.png",
    )
  } else {
    // Default theme: use config colors
    (
      primary: COLOR_PRIMARY,
      accent: COLOR_ACCENT,
      accent-border: COLOR_ACCENT_BORDER,
      logo: none,
      cover-image: none,
    )
  }

  // Process date
  let formatted-date = if type(date) == datetime {
    date.display(date-format)
  } else {
    date
  }

  // Document metadata
  set document(author: authors, title: title)

  // Page Setup
  set page(
    paper: PAGE_FORMAT,
    margin: (
      top: PAGE_MARGIN_TOP,
      bottom: PAGE_MARGIN_BOTTOM,
      left: PAGE_MARGIN_LEFT,
      right: PAGE_MARGIN_RIGHT,
    ),
    header: context {
      if counter(page).get().first() > 1 {
        header-content(title, subtitle, formatted-date, logo: theme.logo)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        footer-content(authors, formatted-date)
      }
    },
  )

  // Text & Typography
  set text(font: FONT_MAIN, lang: TEXT_LANG, size: TEXT_SIZE)

  // Link styling
  show link: set text(fill: COLOR_LINK)
  show link: underline

  // Code Block Styling
  show raw: set text(font: FONT_CODE)

  // Paragraph settings
  set par(justify: true, leading: TEXT_LEADING, spacing: PAR_SPACING)
  set text(hyphenate: false) // Pas de césure automatique

  // Heading Styling (use theme colors)
  set heading(numbering: "1.1.")
  show heading.where(level: 1): it => {
    set text(size: 18pt, weight: "bold", fill: theme.primary, font: FONT_MAIN)
    block(above: 1.5em, below: 1em, it)
  }
  show heading.where(level: 2): it => {
    set text(size: 16pt, weight: "bold", fill: theme.primary, font: FONT_MAIN)
    block(above: 1.5em, below: 1em, it)
  }
  show heading.where(level: 3): it => {
    set text(size: 14pt, weight: "bold", fill: theme.primary, font: FONT_MAIN)
    block(above: 1.5em, below: 1em, it)
  }
  show heading.where(level: 4): it => {
    set text(size: 14pt, weight: "bold", fill: theme.primary, font: FONT_MAIN)
    block(above: 1.5em, below: 1em)[
      #it.body
    ]
  }

  // Table Styling
  set table(
    stroke: 1pt + rgb("c9c9c9"),
    inset: 0.8em,
    fill: (x, y) => if y == 0 { theme.primary } else { none },
  )
  set table.cell(breakable: false)
  show table.cell: it => {
    if it.y == 0 {
      set text(white, weight: "bold")
      strong(it)
    } else {
      set text(black)
      it
    }
  }

  // Figure Styling
  show figure: set figure(supplement: [Figure])

  // Cover page
  if cover {
    if heia {
      cover-page-heia(title, authors, formatted-date, subtitle: subtitle, classe: classe, theme)
    } else {
      cover-page-default(title, authors, formatted-date, subtitle: subtitle, classe: classe, theme)
    }
  }

  // Table of Contents
  if toc {
    table-of-contents()
  }

  // Body Content
  body

  // Bibliography
  if bibliography {
    generate-bibliography(bibliography-file)
  }

  // Table of Figures
  if tof {
    table-of-figures()
  }
}
