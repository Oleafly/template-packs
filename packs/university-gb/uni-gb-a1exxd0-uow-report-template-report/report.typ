#import "template.typ": definition, proof, report, theorem
#import "@preview/wordometer:0.1.5": word-count

#show: report.with(
  title: [A nonsensical template with some notes on\ quantum learning],
  author: "Alex Do",
  student-id: "2100000",
  supervisor: "Dr. Jane Smith",
  date: "April 2026",
)

// ── Front matter ─────────────────────────────────────────────────────
#include "chapters/abstract.typ"
#include "chapters/acknowledgements.typ"

#outline(depth: 3, indent: auto)

// ── Main matter (switch to arabic numerals) ──────────────────────────
#set page(
  numbering: "1",
  header: context {
    // Suppress header on pages where a new chapter starts
    let here-page = here().page()
    if query(heading.where(level: 1)).any(h => h.location().page() == here-page) {
      return
    }

    let chapters = query(heading.where(level: 1).before(here()))
    if chapters.len() == 0 { return }
    let chapter = chapters.last()
    let ch-nums = counter(heading).at(chapter.location())
    if ch-nums.first() == 0 { return }

    set text(size: 9pt)
    emph[#numbering("1", ch-nums.first()). #chapter.body]
    h(1fr)

    let sections = query(heading.where(level: 2).before(here()))
    if sections.len() > 0 {
      let sec = sections.last()
      let sec-nums = counter(heading).at(sec.location())
      if sec-nums.first() == ch-nums.first() {
        emph[#numbering("1.1", ..sec-nums.slice(0, 2)). #sec.body]
      }
    }

    v(2pt)
    line(length: 100%, stroke: 0.5pt)
  },
)
#counter(page).update(1)

#[
  #show: word-count.with(exclude: (math.equation))
  #include "chapters/introduction.typ"
  #include "chapters/background.typ"
  #include "chapters/methodology.typ"
  #include "chapters/evaluation.typ"
  #include "chapters/conclusion.typ"
]


// ── Appendices ──────────────────────────────────────────────────────
#counter(heading).update(0)
#set heading(numbering: "A.1")
#include "chapters/appendix-circuits.typ"

// ── Bibliography ─────────────────────────────────────────────────────
#bibliography("bibliography.bib", style: "ieee")
