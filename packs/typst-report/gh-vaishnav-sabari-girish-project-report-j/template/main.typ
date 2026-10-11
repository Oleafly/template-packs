// ============================================================
//  main.typ — Root entry point
//  Edit config.typ for project details.
//  Add/remove chapter and appendix #include lines below.
// ============================================================

#import "utils.typ": term, chapter-page, include-pdf
#import "config.typ": project

// --- Global text and paragraph settings ---
#set text(font: "Times New Roman", size: 12pt)
#set par(leading: 1.00em)
#set heading(numbering: "1.1")

// --- Front matter (title, certificate, declaration, acknowledgement) ---
#include "front.typ"

// --- TOC styling ---
#show outline.entry: set outline.entry(fill: none)
#show outline.entry.where(level: 1): it => [
  #v(1em)
  #it
]
#show outline.entry.where(level: 1): set text(weight: "bold")
#show outline.entry.where(level: 2): set text(weight: "bold")

// Page break before APPENDICES in TOC
#show outline.entry: it => {
  if it.level == 1 and it.element.body == [APPENDICES] {
    pagebreak()
    it
  } else {
    it
  }
}

#set par(justify: true)
#set page(numbering: "i")
#set list(indent: 2em)

// ── ABSTRACT ─────────────────────────────────────────────────

#align(center)[
  #heading(level: 1, numbering: none)[ABSTRACT]
]

#linebreak()

// TODO: Replace with your abstract text.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

#pagebreak()

// ── TABLE OF CONTENTS ────────────────────────────────────────

#outline(title: "Contents", indent: 2em)

#pagebreak()

// ── LIST OF FIGURES ──────────────────────────────────────────

#align(center)[
  #heading(level: 1, numbering: none)[LIST OF FIGURES]
]
#linebreak()

#context {
  let figs = query(figure.where(kind: image))
  if figs.len() > 0 {
    table(
      columns: (auto, 1fr, auto),
      stroke: 0.5pt,
      inset: 10pt,
      align: (center, left, center),
      table.header([*Fig. No.*], [*Description*], [*Page No.*]),
      ..figs.map(fig => {
        let num = counter(figure).at(fig.location()).first()
        let caption = fig.caption.body
        let page-num = fig.location().page()
        (table.cell[#num], table.cell[#caption], table.cell[#page-num])
      }).flatten()
    )
  } else {
    [No figures found.]
  }
}

#pagebreak()

// ── NOMENCLATURE ─────────────────────────────────────────────

#align(center)[
  #heading(level: 1, numbering: none)[NOMENCLATURE]
]

#context {
  let terms = query(<nomenclature>)
  if terms.len() > 0 {
    table(
      columns: (auto, 1fr),
      stroke: 0.5pt,
      inset: 10pt,
      align: horizon,
      table.header([*Symbol*], [*Description*]),
      ..terms.map(el => (
        table.cell[#el.value.at(0)],
        table.cell[#el.value.at(1)]
      )).flatten()
    )
  } else {
    [No nomenclature entries found.]
  }
}

// ── MAIN CONTENT (Arabic numerals) ───────────────────────────

#set page(numbering: "1")
#counter(page).update(1)

#set page(
  header: emph(text(size: 10pt,
    align(right)[#project.short-title]
  )),
  footer: context emph(text(size: 10pt)[
    #project.title
    #h(1fr)
    #counter(page).display()
  ])
)

#show heading.where(level: 1): it => {
  if it.numbering == none {
    counter(heading).step(level: 1)
  }
  it
}

// ── CHAPTERS ─────────────────────────────────────────────────
// Add or remove chapters as needed.

#include "chapters/chapter_1.typ"
#include "chapters/chapter_2.typ"
#include "chapters/chapter_3.typ"
#include "chapters/chapter_4.typ"
#include "chapters/chapter_5.typ"
#include "chapters/chapter_6.typ"

// ── APPENDICES ───────────────────────────────────────────────

#chapter-page("APPENDICES")
#pagebreak()

#include "appendices/appendix_1.typ"
#include "appendices/appendix_2.typ"

// ── ADDITIONAL DOCUMENTS (PDFs) ──────────────────────────────
// Uncomment and adjust paths/page counts as needed.

// #chapter-page("Patent eFiling")
// #pagebreak()
// #include-pdf("assets/efiling_receipt.pdf", 1)

// #chapter-page("Form 1")
// #pagebreak()
// #include-pdf("assets/form_1.pdf", 5, landscape: true)
