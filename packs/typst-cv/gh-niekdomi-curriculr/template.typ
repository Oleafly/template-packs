#import "@preview/fontawesome:0.6.0": fa-icon

// ─── Settings ────────────────────────────────────────────────────────────────
#let font = "Roboto"
#let fontsize = 10pt
#let page-margin = 3cm
#let color-link = blue
#let color-icon = black
#let color-photo-frame = gray
#let spacing-section = 12pt
#let spacing-entry = 5pt
#let spacing-element = 3pt
#let year-col-width = 9em

// ─── Init ────────────────────────────────────────────────────────────────────
#let init(doc) = {
  set page(paper: "a4", margin: page-margin)
  set text(font: font, size: fontsize)
  set par(justify: true)
  show link: it => text(fill: color-link)[#it]
  // "=" heading becomes a styled section title with separator
  show heading.where(level: 1): it => block(width: 100%)[
    #v(spacing-section)
    #set text(size: 1em, weight: "regular")
    #smallcaps(it.body)
    #v(-0.75em)
    #line(length: 100%, stroke: 0.4pt + black)
  ]
  doc
}

// Placeholder box to use instead of a photo (no image file required)
#let photo-placeholder = box(
  width: 3cm,
  height: 3cm,
  stroke: 2pt + color-photo-frame,
  fill: luma(220),
)

// ─── Header ──────────────────────────────────────────────────────────────────
#let cv-header(name: "", photo: none) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 1.5em,
    align(left + horizon)[
      #text(size: 1.8em, weight: "bold")[#name]
    ],
    if photo != none {
      if type(photo) == str {
        box(
          clip: true,
          stroke: 2pt + color-photo-frame,
          image(photo, width: 3cm, height: 3cm, fit: "cover"),
        )
      } else {
        photo
      }
    },
  )
}

// ─── Timeline entry ──────────────────────────────────────────────────────────
// title:       bold first line (content)
// org:         italic second line (content), optional
// location:    appended to org line, optional
// date:        left column (content)
// description: small text below, optional (content)
// url-github:  GitHub icon link, optional
// url-pdf:     PDF icon link, optional
// url-web:     Globe/browser icon link, optional
// url-linkedin: LinkedIn icon link, optional
#let cv-entry(
  date: none,
  title: none,
  org: none,
  location: none,
  description: none,
  url-github: none,
  url-pdf: none,
  url-web: none,
  url-linkedin: none,
) = {
  let icons = (
    (url-pdf, "file-pdf"),
    (url-web, "globe"),
    (url-linkedin, "linkedin"),
    (url-github, "github"),
  ).filter(x => x.at(0) != none)

  block(breakable: false, grid(
    columns: (year-col-width, 1fr),
    gutter: 1em,
    align(right)[#date],
    grid.vline(stroke: 0.4pt),
    pad(left: 0.5em)[
      // Title line + icons
      #if title != none {
        text(weight: "bold")[#title]
        if icons.len() > 0 {
          h(1fr)
          for (i, icon) in icons.enumerate() {
            if i > 0 { h(1.2em) }
            link(icon.at(0))[#text(fill: color-icon)[#fa-icon(icon.at(1))]]
          }
          h(1em)
        }
      }
      // Org + location line
      #if org != none or location != none {
        v(spacing-element - 0.6em)
        text(style: "italic")[#(
          (org, location).filter(x => x != none).join(", ")
        )]
      }
      // Description
      #if description != none {
        let after-title = org == none and location == none
        v(if after-title { spacing-element - 0.6em } else {
          spacing-element - 1em
        })
        text(size: 8pt)[#description]
      }
    ],
  ))
  v(spacing-entry)
}

// ─── Key-value table ─────────────────────────────────────────────────────────
// entries: array of (label, value) or (label,) tuples
// e.g. (("Englisch", [Verhandlungssicher]), ("Deutsch", [Muttersprache]))
#let cv-kv(entries) = {
  let cells = ()
  for entry in entries {
    let lbl = entry.at(0)
    let val = if entry.len() > 1 { entry.at(1) } else { none }
    let has-val = val != none
    cells.push(align(right, smallcaps(text(
      weight: "semibold",
      lbl + if has-val { ":" } else { "" },
    ))))
    cells.push(if has-val { val } else { [] })
  }
  grid(
    columns: (auto, 1fr),
    column-gutter: 1.5em,
    row-gutter: spacing-entry,
    ..cells,
  )
}

// ─── Two-column personal data ─────────────────────────────────────────────────
// left/right: arrays of (label, value) tuples
#let cv-personal(left: (), col-right: ()) = {
  let build(entries) = {
    let cells = ()
    for entry in entries {
      cells.push(align(right, smallcaps(text(
        weight: "semibold",
        entry.at(0) + ":",
      ))))
      cells.push(entry.at(1))
    }
    grid(columns: (
        auto,
        1fr,
      ), column-gutter: 1.5em, row-gutter: spacing-entry, ..cells)
  }
  grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    build(left), build(col-right),
  )
}
