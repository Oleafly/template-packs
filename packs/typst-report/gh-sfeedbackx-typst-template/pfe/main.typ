// ======================================================
// PFE REPORT — MAIN ENTRY POINT
// ------------------------------------------------------
// This file orchestrates the entire report. It sets
// global margins, includes front matter, chapters,
// bibliography, and back matter in order.
//
// HOW TO USE:
//   1. Edit front/cover_page.typ with your data
//   2. Edit chapters/*.typ with your content
//   3. Run: typst compile main.typ
// ======================================================

// Global page margins
#set page(
  paper: "a4",
  margin: (top: 2.5cm, left: 3cm, right: 2cm, bottom: 2.5em),
)

// ── FRONT MATTER ──────────────────────────────────────
// Cover page (customize in front/cover_page.typ)
#include "front/cover_page.typ"
#pagebreak()

#set heading(numbering: "1.1.1")

// Front matter: dedication, acknowledgment, ToC, etc.
#include "front/index.typ"

// ── MAIN CONTENT ──────────────────────────────────────
// Switch to Arabic page numbering for main content
#set page(
  footer: context {
    stack(
      dir: ttb,
      spacing: 10pt,
      line(length: 100%, stroke: 0.5pt),
      align(center, counter(page).display()),
    )
  },
  numbering: "1",
)

#show heading.where(level: 4): set heading(outlined: false)
#show heading.where(level: 5): set heading(outlined: false)

// Include chapters in order
#include "chapters/ch01-introduction.typ"
#parbreak()

#include "chapters/ch02-host-organizations-project-context.typ"
#parbreak()

#include "chapters/ch03-Conception-Analysis.typ"
#parbreak()

#include "chapters/ch04-foundation-infrastructure.typ"
#parbreak()

#include "chapters/conclusion.typ"
#pagebreak()

// ── BIBLIOGRAPHY ──────────────────────────────────────
#show bibliography: it => {
  set page(
    footer: context {
      stack(
        dir: ttb,
        spacing: 5pt,
        line(length: 100%, stroke: 0.5pt),
        align(center, counter(page).display()),
      )
    },
  )
  show heading.where(level: 1): h => {
    text(size: 14pt, weight: "bold")[#h]
    v(0.8em)
  }
  set heading(numbering: "1.", outlined: false)
  it
}
#bibliography("references.bib", style: "ieee", full: true)
#pagebreak()

// ── BACK MATTER ───────────────────────────────────────
#include "chapters/appendix.typ"
#pagebreak()
#include "front/abstract.typ"



