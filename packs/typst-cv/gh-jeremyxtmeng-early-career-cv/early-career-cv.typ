// early-career-cv.typ — A Typst template for academic/professional CVs with hyperlinks.
//
// Usage:
//   #import "early-career-cv.typ": *
//   #show: cv.with(...)
//   #cv-header(name: "...", ...)
//   = Education
//   #company-row([Degree | University], [Date])
//   #bullets([ - item ])

#import "@preview/fontawesome:0.6.0": *
//#import "@preview/scienceicons:0.1.0": email-icon, linkedin-icon, github-icon



// ── Main template ─────────────────────────────────────────────────────────────
// Apply with `#show: cv` or `#show: cv.with(font: "...", ...)`.
//
// Parameters:
//   font       — body font family          (default: "New Computer Modern")
//   font-size  — base font size            (default: 11pt)
//   paper      — page size string          (default: "us-letter")
//   margin     — page margin dictionary    (default: standard CV margins)
//   link-color — color for body hyperlinks (default: #1155CC dark blue)
//   doc        — document body (injected automatically by `#show: cv`)
#let cv(
  font: "New Computer Modern",
  font-size: 11pt,
  paper: "us-letter",
  margin: (left: 0.5in, right: 0.5in, top: 0.1in, bottom: 0.1in),
  link-color: rgb("#1155CC"),
  doc,
) = {
  set page(paper: paper, margin: margin)
  set text(font: font, size: font-size)
  set par(justify: false, spacing: 0pt, leading: 0.65em)
  set heading(numbering: none)

  // Zero out heading's built-in block spacing; show rules control it explicitly.
  show heading: set block(above: 0pt, below: 0pt)

  // Zero out default block spacing; add it only where needed.
  set block(spacing: 0pt)

  // Dark blue for all body hyperlinks.
  show link: set text(fill: link-color)

  // Level-1 section heading: smallcaps text + bottom rule.
  show heading.where(level: 1): it => {
    v(3pt)
    block(
      width: 100%,
      stroke: (bottom: 0.6pt),
      inset: (bottom: 2pt),
    )[#text(size: 13pt, weight: "regular")[#smallcaps(it.body)]]
    v(3pt)
  }

  // Bullet list: 10pt text, depth-aware top spacing, no orphaned spacing.
  let _list-depth = state("_list-depth", 0)
  show list: it => context {
    let cur-depth = _list-depth.get()
    [#_list-depth.update(n => n + 1)#block(
      above: if cur-depth == 0 { 0pt } else { 0.65em },
      below: 0pt,
    )[
      #set text(size: 10pt)
      #it
      #_list-depth.update(n => n - 1)
    ]]
  }

  set list(
    marker: depth => if depth == 0 { text(size: 8pt)[•] } else { text(size: 8pt)[◦] },
    indent: 14.5pt,
    body-indent: 0.5em,
    spacing: 0.65em,
  )

  doc
}


// ── Header ────────────────────────────────────────────────────────────────────
// Centered name + one-line contact bar. Header links are always black.
//
// Parameters (all optional except `name`):
//   name           — full display name
//   phone          — display string, e.g. "(650) 787-6157"
//   phone-url      — tel: URL override; defaults to "tel:" + phone digits
//   email          — email address (used for both display and mailto: link)
//   linkedin-label — short label, e.g. "linkedin.com/jxtmeng7887"
//   linkedin-url   — full https:// URL
//   github-label   — short label, e.g. "github.com/jeremyxtmeng"
//   github-url     — full https:// URL
//   location       — display string, e.g. "Davis, CA"
//   location-url   — optional map link
#let cv-header(
  name: "Your Name",
  phone: none,
  phone-url: none,
  email: none,
  linkedin-label: none,
  linkedin-url: none,
  github-label: none,
  github-url: none,
  location: none,
  location-url: none,
) = {
  // Collect non-none contact items as (icon-or-none, label, url) tuples.
  let items = ()
  if phone != none {
    items.push((fa-icon("phone"), phone, if phone-url != none { phone-url } else { "tel:" + phone }))
  }
  if email != none {
    items.push((fa-envelope(), email, "mailto:" + email))
  }
  if linkedin-label != none and linkedin-url != none {
    items.push((fa-linkedin(), linkedin-label, linkedin-url))
  }
  if github-label != none and github-url != none {
    items.push((fa-icon("github"), github-label, github-url))
  }
  if location != none {
    items.push((none, location, location-url))
  }

  show link: set text(fill: black)
  align(center)[
    #text(size: 21pt, weight: "bold")[#name]
    #v(8pt)
    #text(size: 10pt)[
      #for (idx, item) in items.enumerate() {
        let (icon, label, url) = item
        if icon != none { icon; " " }
        if url != none { link(url)[#label] } else { label }
        if idx < items.len() - 1 [ $|$ ]
      }
    ]
  ]
}


// ── Row helpers ───────────────────────────────────────────────────────────────
// All rows: left-flush / right-flush, 3 pt gap above and below.

// Raw two-column row — pass any content as `l` and `r`.
#let row(l, r) = {
  v(3pt)
  grid(
    columns: (1fr, auto),
    gutter: 0pt,
    align: (left + horizon, right + horizon),
    l, r,
  )
  v(3pt)
}

// Bold name row: company, institution, degree title, or project name.
// `l` is the bold left label; `r` is the plain right label (date, link, etc.).
#let company-row(l, r) = row(text(weight: "bold", l), r)

// Italic subtitle row: job title or research role.
// Both sides are 10 pt italic; left is also bold.
#let title-row(l, r) = row(
  text(size: 10pt, weight: "bold", style: "italic", l),
  text(size: 10pt, style: "italic", r),
)


// ── Content helpers ───────────────────────────────────────────────────────────

// Wraps a bullet list with consistent 3 pt vertical padding.
// Place directly after a `company-row` / `title-row` block.
#let bullets(body) = {
  v(3pt)
  body
  v(3.5pt)
}

// First publication entry after a section heading (adds 3 pt top gap).
#let pub-init(x) = {
  v(3pt)
  [#set par(hanging-indent: 1.5em)
  #x]
  v(0.65em)
}

// Subsequent publication entries (no extra top gap — previous entry supplies it).
#let pub(x) = {
  [#set par(hanging-indent: 1.5em)
  #x]
  v(0.65em)
}
