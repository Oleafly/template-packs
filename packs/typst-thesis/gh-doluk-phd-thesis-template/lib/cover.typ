// ═══════════════════════════════════════════════════════════════════════════
// COVER PAGE
// ═══════════════════════════════════════════════════════════════════════════
//
// Every field is optional: leave it out of `config.typ` and the corresponding
// line simply disappears. All visible words are collected in
// `default-cover-labels` so the page can be translated by passing
// `labels: (submitted-by: "vorgelegt von", ...)` to `thesis()`.

#import "theme.typ": default-theme

#let default-cover-labels = (
  submitted-by: "submitted by",
  at-the: "at the",
  born: "Born:",
  student-id: "Student ID:",
  supervisor: "Supervisor:",
  co-supervisor: "Co-supervisor:",
  reviewers: "Reviewers:",
  logo-placeholder: "LOGO",
)

// `logo` is ready-made content, e.g. `image("assets/logo.png", width: 6cm)`.
// It has to be content rather than a path, because Typst resolves paths
// relative to the file they are written in — and you write yours in
// config.typ, not here.
#let render-logo(logo, width: 6cm, accent: black, placeholder: "LOGO") = {
  if logo == none {
    box(
      width: width,
      height: width * 0.4,
      stroke: 0.6pt + accent,
      radius: 2pt,
      align(center + horizon, text(size: 8pt, fill: accent, placeholder)),
    )
  } else {
    logo
  }
}

#let show-cover(
  title: "",
  authors: (),
  degree: none,
  major: none,
  submission-text: none,
  university: none,
  faculty: none,
  department: none,
  location: none,
  date: none,
  supervisor: none,
  co-supervisor: none,
  logo: none,
  theme: default-theme,
  labels: (:),
) = {
  let lbl = default-cover-labels + labels
  let sans = theme.font-sans
  let serif = theme.font-serif

  // Authors may be given as plain strings or as dictionaries carrying extra
  // cover-page details (see config.typ).
  let author-list = if type(authors) == array { authors } else { (authors,) }
  let field(a, key) = if type(a) == str { none } else { a.at(key, default: none) }
  let name-of(a) = if type(a) == str { a } else { a.name }

  // The cover has no header, no footer and no page number of its own.
  set page(
    paper: theme.paper,
    margin: (x: 2.5cm, y: 2.4cm),
    numbering: none,
    header: none,
    footer: none,
  )
  set par(justify: false)



  v(1.5fr)

  // ── Title ──────────────────────────────────────────────────────────────
  align(center, {
    set par(leading: 0.5em)
    underline(stroke: 2pt + theme.underline, offset: 4pt, evade: false)[
      #text(font: sans, weight: "black", size: 24pt, title)
    ]
  })

  v(1fr)

  // ── Degree ─────────────────────────────────────────────────────────────
  align(center, {
    if submission-text != none {
      text(font: serif, size: 15pt, submission-text)
      linebreak()
      v(0.3em)
    }
    if degree != none {
      text(font: sans, weight: "bold", size: 18pt, degree)
      linebreak()
    }
    if major != none {
      text(font: serif, weight: "bold", size: 16pt, major)
    }
  })

  v(1fr)

  // ── Author ─────────────────────────────────────────────────────────────
  align(center, {
    text(font: serif, size: 14pt, lbl.submitted-by)
    v(0.4em)
    for a in author-list {
      text(font: sans, weight: "bold", size: 18pt, name-of(a))
      
      v(0.6em)
    }
  })

  v(1fr)

  // ── Institution logo ───────────────────────────────────────────────────
  if logo != none or university != none {
    align(center, {
      text(font: serif, size: 14pt, lbl.at-the)
      render-logo(logo, accent: theme.accent, placeholder: lbl.logo-placeholder)
    })
  }

  v(1fr)

  // ── Institution line ───────────────────────────────────────────────────
  if (department, faculty).any(x => x != none) {
    show text: set align(center)
    show text: set par(spacing: 1em, leading: 0pt)
    if faculty != none {
      text(font: serif,  size: 13pt, faculty)
    }
    if department != none {
      text(font: serif, size: 12pt, department)
    }

  }
  v(1.2fr)
  // ── Place and date ─────────────────────────────────────────────────────
  if location != none or date != none {
    align(center, text(font: serif, size: 12pt, {
      if location != none { location }
      if location != none and date != none { [, ] }
      if date != none { date }
    }))
  }
}
