// TITLE PAGE - Professional cover page
//
// Creates a clean, modern title page with:
// - Logo (optional)
// - Title and subtitle
// - Course and term info
// - Author/group metadata box
// - Confidentiality notice (optional)
//

#import "../colors.typ": colors, box-colors
#import "../config.typ": titlepage-labels, date-format, format-date

/// Generate a professional title page.
///
/// This function creates a cover page with logo, title, subtitle,
/// course information, and a metadata card with author details.
///
/// ```example
/// #make-titlepage(
///   title: "Introduction to Typst",
///   subtitle: "TD 1",
///   course: "EPITA",
///   term: "S7",
///   authors: ("John Doe", "Jane Smith"),
///   group: "C1",
///   logo: image("logo.png", width: 6cm),
/// )
/// ```
///
/// - title (str, content): Document title displayed prominently.
/// - subtitle (str, content, none): Optional subtitle below the title.
/// - course (str): Course or institution name.
/// - term (str, none): Academic term (e.g., "S7", "Fall 2025").
/// - authors (array): List of author names.
/// - group (str, none): Group or team identifier.
/// - date (datetime, str): Document date.
/// - logo (content, none): Logo image content.
/// - confidentiality (str, none): Confidentiality notice (e.g., "TLP:AMBER").
/// - labels (auto, dictionary): Override metadata card labels.
/// - date-fmt (str): Date format string.
/// -> content
#let make-titlepage(
  title: "Document Title",
  subtitle: none,
  course: "EPITA",
  term: none,
  authors: (),
  group: none,
  date: datetime.today(),
  logo: none,
  confidentiality: none,
  labels: auto,
  date-fmt: date-format,
) = {
  // Resolve labels
  let lbl = if labels == auto { titlepage-labels } else {
    // Merge with defaults
    let result = titlepage-labels
    if "authors" in labels { result.authors = labels.authors }
    if "group" in labels { result.group = labels.group }
    if "date" in labels { result.date = labels.date }
    result
  }

  // PAGE SETUP
  set page(
    margin: (x: 2.5cm, y: 2cm),
    numbering: none,
  )
  set align(center)

  // LOGO
  if logo != none {
    logo
    v(1.5cm)
  }

  v(1fr)

  // TITLE
  text(size: 28pt, weight: "bold", fill: colors.text)[#title]

  // SUBTITLE
  if subtitle != none {
    v(0.4cm)
    text(size: 16pt, weight: "semibold", fill: colors.question)[#subtitle]
  }

  v(0.8cm)

  // COURSE & TERM
  {
    set text(size: 13pt, fill: luma(80))
    if term != none {
      [#course #sym.dot.c #term]
    } else {
      course
    }
  }

  v(2cm)

  // METADATA CARD
  {
    let scheme = box-colors(colors.metadata)

    block(
      width: 70%,
      stroke: 1pt + scheme.border,
      radius: 6pt,
      fill: scheme.bg,
      inset: 16pt,
      {
        set align(left)
        set text(size: 11pt)

        // Authors row
        if authors.len() > 0 {
          grid(
            columns: (80pt, 1fr),
            gutter: 8pt,
            text(weight: "semibold", fill: luma(60))[#lbl.authors],
            text(fill: colors.text)[
              #for author in authors {
                [#author \ ]
              }
            ],
          )
        }

        // Group row
        if group != none {
          v(8pt)
          grid(
            columns: (80pt, 1fr),
            gutter: 8pt,
            text(weight: "semibold", fill: luma(60))[#lbl.group],
            text(fill: colors.text)[#group],
          )
        }

        // Date row
        v(8pt)
        grid(
          columns: (80pt, 1fr),
          gutter: 8pt,
          text(weight: "semibold", fill: luma(60))[#lbl.date],
          text(fill: colors.text)[#format-date(date, format: date-fmt)],
        )
      }
    )
  }

  v(1fr)

  // CONFIDENTIALITY NOTICE
  if confidentiality != none {
    text(
      size: 9pt,
      fill: luma(140),
      weight: "medium",
      tracking: 1pt,
    )[#upper(confidentiality)]
    v(0.5cm)
  }

  pagebreak(weak: true)
}
