// EPITA TD TEMPLATE - Main library
//
// A modern template for French educational documents (TD, TP, exams).
//
// USAGE:
//   #import "src/lib.typ": *
//   #show: td.with(title: "Mon TD", course: "Algo")
//

// Re-export colors
#import "colors.typ": colors, catppuccin, box-colors

// Re-export config (for advanced customization)
#import "config.typ": (
  icons,
  titles,
  question-format,
  titlepage-labels,
  date-format,
  lang-presets,
  format-question-num,
  format-date,
)

// Re-export all boxes
#import "components/boxes.typ": *

// Import titlepage
#import "components/titlepage.typ": make-titlepage

// MAIN TEMPLATE

/// Main document template for TD/TP documents.
///
/// This template sets up the entire document with proper typography,
/// headers, title page, and styling for educational content.
///
/// ```example
/// #import "src/lib.typ": *
///
/// #show: td.with(
///   title: "Introduction to Algorithms",
///   subtitle: "TD 1 - Sorting",
///   course: "EPITA",
///   term: "S7",
///   authors: ("John Doe",),
///   group: "C1",
///   toc: true,
/// )
///
/// = First Section
/// #question[What is an algorithm?]
/// #response[An algorithm is...]
/// ```
///
/// - title (str, content): Document title.
/// - subtitle (str, content, none): Optional subtitle.
/// - course (str): Course or institution name.
/// - term (str, none): Academic term (e.g., "S7").
/// - authors (array): List of author names.
/// - group (str, none): Group identifier.
/// - date (datetime, str): Document date.
/// - logo (content, str, none): Logo image or path.
/// - confidentiality (str, none): Confidentiality notice.
/// - header-left (auto, str, content): Left header content.
/// - header-right (auto, str, content): Right header content.
/// - lang (str): Document language code.
/// - titlepage-labels (auto, dictionary): Override title page labels.
/// - date-fmt (str): Date format string.
/// - toc (bool): Whether to show table of contents.
/// - body (content): Document content.
/// -> content
#let td(
  title: "Document",
  subtitle: none,
  course: "EPITA",
  term: none,
  authors: (),
  group: none,
  date: datetime.today(),
  logo: none,
  confidentiality: none,
  header-left: auto,
  header-right: auto,
  lang: "fr",
  titlepage-labels: auto,
  date-fmt: date-format,
  toc: false,
  body,
) = {
  // HEADER DEFAULTS
  let header-l = if header-left == auto { course } else { header-left }
  let header-r = if header-right == auto {
    format-date(date, format: date-fmt)
  } else { header-right }

  // DOCUMENT METADATA
  set document(title: title, author: authors, date: date)

  // PAGE SETUP
  set page(
    paper: "a4",
    margin: 2.5cm,
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          text(size: 0.9em, fill: luma(100))[#header-l],
          text(size: 0.9em, fill: luma(100))[#header-r],
        )
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + luma(200))
      }
    },
  )

  // TYPOGRAPHY
  set text(
    font: "Inter",
    size: 11pt,
    lang: lang,
    fill: colors.text,
  )

  set par(justify: true, leading: 0.65em)

  // HEADINGS
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(breakable: false)[
      #v(0.8em)
      #text(size: 1.3em, weight: "bold", fill: colors.text)[#it]
      #v(0.4em)
    ]
  }

  show heading.where(level: 2): it => block(breakable: false)[
    #v(0.6em)
    #text(size: 1.1em, weight: "bold", fill: colors.text)[#it]
    #v(0.3em)
  ]

  // LINKS
  show link: it => {
    set text(fill: colors.question)
    underline(it)
  }

  // CODE BLOCKS
  show raw: set text(font: "JetBrains Mono", size: 0.85em)

  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(248),
    stroke: 0.5pt + luma(200),
    radius: 3pt,
    inset: 10pt,
    breakable: false,
    it
  )

  show raw.where(block: false): box.with(
    fill: luma(245),
    inset: (x: 4pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // TABLES
  show table: set block(breakable: false)

  // TITLE PAGE
  // Logo can be content (image) or a path string
  let logo-content = if logo != none {
    if type(logo) == content { logo }
    else { image(logo, width: 6cm) }
  } else { none }

  make-titlepage(
    title: title,
    subtitle: subtitle,
    course: course,
    term: term,
    authors: authors,
    group: group,
    date: date,
    logo: logo-content,
    confidentiality: confidentiality,
    labels: titlepage-labels,
    date-fmt: date-fmt,
  )

  counter(page).update(1)

  // TABLE OF CONTENTS
  if toc {
    outline(
      title: if lang == "fr" { "Table des matières" } else { "Table of Contents" },
      indent: auto,
      depth: 3,
    )
    pagebreak()
  }

  // BODY
  body
}
