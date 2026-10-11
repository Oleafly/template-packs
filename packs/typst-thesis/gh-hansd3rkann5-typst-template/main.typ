#import "utils.typ": inwriting, draft, todo, used-keys, gl
#import "@preview/wordometer:0.1.4": word-count
#import "glossary_func.typ": glossary, symbols
#import "config.typ": * // --- GLOBAL
#import "data.typ": glossary, symbols


// ─── GLOBAL TEXT & LIST SETTINGS ──────────────────────────────────────────────
#set text(lang: if german { "de" } else { "en" }, size: base-size, font: "Noto Sans Indic Siyaq Numbers")
#set text(ligatures: false)

#set list(indent: list-indent, body-indent: list-body-indent, marker: n => context {
  move(dy: 0em, [•])
})
#set enum(indent: list-indent, body-indent: list-body-indent, numbering: (..n) => context {
  move(dy: 0em, numbering("1.", ..n))
})
#show list: it => block(above: list-spacing-above, below: list-spacing-above)[#it]
#show enum: it => block(above: list-spacing-above, below: list-spacing-above)[#it]


// ─── COVER ────────────────────────────────────────────────────────────────────
#include "Cover.typ"
#pagebreak()


// ─── BODY STYLING (active from here onward) ───────────────────────────────────
#show raw: set text(font: base-font)
#show math.equation: set text(font: math-font)

#set par(leading: par-leading, first-line-indent: par-indent, justify: true, spacing: par-spacing)
#set table(inset: table-inset, stroke: stroke-main + black)

#show figure.where(kind: image): set figure(placement: none)
#show figure.where(kind: table): set figure(placement: none)

#show figure.caption: set text(size: caption-text-size)
#show figure.caption: it => [
  #strong(it.supplement + " " + context it.counter.display(it.numbering))#it.separator #it.body
]

#show figure.where(kind: table): it => {
  let has-caption = it.has("caption")
  block(width: 100%, breakable: false)[
    #v(table-spacing-above, weak: true)
    #if has-caption {
      align(center)[
        #it.caption
        #v(par-spacing, weak: true)
        #it.body
      ]
    } else {
      it.body
    }
    #v(section-spacing-bottom, weak: true)
  ]
}

#show heading: set text(font: base-font, weight: "bold")

#show heading.where(level: 1): it => [
  //#pagebreak(weak: true)
  #v(section-spacing-top)
  #set text(weight: "bold")
  #block(below: section-spacing-bottom)[#it]
]

#show heading.where(level: 2): set block(above: h2-above, below: h2-below)
#show heading.where(level: 3): set block(above: h3-above, below: h3-below)

// Reference styling (APA v7 compatible)
#let _ref-seen = state("ref-seen", ())

#show ref: it => {
  let k = str(it.target)
  let entry = (glossary + symbols).find(e => str(e.key) == k)

  if entry != none {
    return gl(k)
  }

  if k.contains(":") {
    return context {
      let seen = _ref-seen.get()
      if k in seen {
        it
      } else {
        [#_ref-seen.update(s => s + (k,))#strong(it)]
      }
    }
  }

  it
}
#show link: set text(fill: main-color-link)

// Outline entry styling (main TOC — level-1 headings bold)
#show outline.entry.where(level: 1): it => {
  v(1.2em, weak: true)
  strong(it)
}


// ╔═════════════════════════════════════════════════════════════════════════════╗
// ║  FRONT MATTER  —  roman page numbering (I, II, III …)                     ║
// ║  To reorder: cut and paste the numbered blocks below.                      ║
// ║  Each block ends with #pagebreak() so they are self-contained.             ║
// ║                                                                            ║
// ╚═════════════════════════════════════════════════════════════════════════════╝
#set page(numbering: "I")
#counter(page).update(1)

// ─── FRONT · 1 · Table of Contents ───────────────────────────────────────────
#outline(
  title: { text(1.3em, weight: 700, "Contents"); v(10mm) },
  indent: outline-indent,
  depth: 3
)
#pagebreak()

// ─── FRONT · 2 · List of Figures ─────────────────────────────────────────────
#context {
  let images = query(figure.where(kind: image))
  if images.len() > 0 {
    heading(numbering: none)[List of Figures]
    show outline.entry: it => {
      v(lof-entry-spacing, weak: false)
      link(it.element.location(), text(fill: black, it.indented(
        strong(it.prefix()),
        it.inner()
      )))
    }
    outline(title: none, target: figure.where(kind: image))
    if lof-combined { v(2em) } else { pagebreak() }
  }
}

// ─── FRONT · 3 · List of Tables ──────────────────────────────────────────────
#context {
  let tables = query(figure.where(kind: table))
  if tables.len() > 0 {
    heading(numbering: none)[List of Tables]
    show outline.entry: it => {
      v(lof-entry-spacing, weak: false)
      link(it.element.location(), text(fill: black, it.indented(
        strong(it.prefix()),
        it.inner()
      )))
    }
    outline(title: none, target: figure.where(kind: table))
    pagebreak()
  }
}

// ─── FRONT · 4 · List of Abbreviations & Formula Symbols ─────────────────────
// Note: uses used-keys.final() — Typst "did not converge" warning is expected
// and harmless; the output is correct.
#include "glossary_func.typ"
#metadata(none) <front-matter-end>


// ╔═════════════════════════════════════════════════════╗
// ║  MAIN MATTER  —  arabic page numbering (1, 2, 3 …). ║
// ╚═════════════════════════════════════════════════════╝
#set page(
  numbering: "1",
  footer: context {
    set text(size: footer-size, fill: luma(150))
    grid(
      columns: (1fr, 4em, auto),
      align: (left + top, center + top, right + top),
      inset: (top: 5pt),
      stroke: (top: 0.5pt),
      footer-text,
      [],
      text(fill: black, size: base-size, counter(page).display())
    )
  }
)
#counter(page).update(1)
#set math.equation(numbering: "(1)")
#set heading(numbering: "1.1")
#set figure(numbering: "1")

#show: word-count.with(exclude: (figure, figure.caption, raw, heading))
#if german {
  include "kapitel/1_Einleitung.typ"
  include "kapitel/2_Theoretisches_Konzept.typ"
  include "kapitel/3_Methodik.typ"
  include "kapitel/4_Ergebnisse.typ"
  include "kapitel/5_Diskussion.typ"
  include "kapitel/6_Fazit.typ"
} else {
  include "chapters/1_Introduction.typ"
  include "chapters/2_Theoretical_Concept.typ"
  include "chapters/3_Methodology.typ"
  include "chapters/4_Results.typ"
  include "chapters/5_Discussion.typ"
  include "chapters/6_Conclusion.typ"
}

// Archived exposé — uncomment to include:
//#include "expose/1_ExposéV1.typ"
//#include "expose/2_ExposéV2.typ"
//#include "expose/3_Exposé_Feedback.typ"


// ╔═══════════════════════════════════════════════════════╗
// ║  BACK MATTER                                          ║
// ║  To reorder: cut and paste the numbered blocks below. ║
// ╚═══════════════════════════════════════════════════════╝

// ─── BACK · 1 · Bibliography ──────────────────────────────────────────────────
#context {
  set page(
    numbering: "I",
    footer: context {
      set text(size: footer-size, fill: luma(150))
      align(center, text(fill: black, size: base-size, counter(page).display("I")))
    }
  )
  pagebreak(weak: true)
  counter(page).update(
    counter(page).at(query(<front-matter-end>).last().location()).first() + 1
  )
  bibliography("items.bib", style: "apa")
}

// ─── BACK · 2 · Appendix ──────────────────────────────────────────────────────
#set heading(
  numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      "Appendix " + numbering("A:", ..n)
    } else {
      numbering("A.1", ..n)
    }
  }
)
#counter(heading).update(0)
