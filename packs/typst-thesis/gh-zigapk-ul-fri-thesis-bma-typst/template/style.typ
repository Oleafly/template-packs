// =============================================================================
// UL FRI Magistrsko delo – Typst style
// Based on: UL-FRI/thesis-BMA LaTeX template
// =============================================================================

#import "@preview/headcount:0.1.0": dependent-numbering

// --- LaTeX logo helper -------------------------------------------------------
// Reproduces the kerning of the LaTeX wordmark.

#let LaTeX = {
  [L]
  h(-0.36em)
  text(size: 0.725em, baseline: -0.25em)[A]
  h(-0.15em)
  [T]
  h(-0.1667em)
  text(baseline: 0.225em)[E]
  h(-0.125em)
  [X]
}

// --- Utility: extract plain text from content --------------------------------
// Heading bodies may be sequences, not just plain text nodes.
// This recursively extracts text for use in headers.

#let content-to-text(c) = {
  if type(c) == str {
    c
  } else if c.has("text") {
    c.text
  } else if c.has("children") {
    c.children.map(content-to-text).join()
  } else if c.has("body") {
    content-to-text(c.body)
  } else {
    ""
  }
}

// --- Helper: detect chapter-opening page -------------------------------------
// Returns true if a level-1 heading starts on the current page.

#let is-chapter-page() = {
  let all-h1 = query(heading.where(level: 1))
  all-h1.any(h => h.location().position().page == here().position().page)
}

// --- Helper: empty double page (for blank verso pages) -----------------------

#let clear-empty-double-page() = {
  pagebreak(to: "odd", weak: true)
}

// --- Header/footer styles ----------------------------------------------------

// Mainmatter header: LaTeX fancyhdr "mainmatter" style
//   Chapter-opening pages (always odd): NO header; page number centered in footer
//   Even pages: page number LEFT, chapter title (uppercased) RIGHT, rule below
//   Odd pages (non-chapter): section title LEFT, page number RIGHT, rule below
#let mainmatter-header = context {
  let pg = counter(page).at(here()).first()
  let is-odd = calc.rem(pg, 2) == 1

  // Chapter-opening pages: no header (footer handles page number)
  if is-chapter-page() {
    return
  }

  let header-line = line(length: 100%, stroke: 0.5pt)

  // Find the current chapter title (\leftmark in LaTeX)
  let chapter-title = ""
  let chapter-page = 0
  let all-h1 = query(heading.where(level: 1))
  for h in all-h1 {
    if h.location().position().page <= here().position().page {
      chapter-page = h.location().position().page
      if h.numbering != none {
        let nums = counter(heading).at(h.location())
        chapter-title = numbering(h.numbering, ..nums) + ". " + content-to-text(h.body)
      } else {
        chapter-title = content-to-text(h.body)
      }
    }
  }

  // Find the current section title (\rightmark in LaTeX)
  let section-title = ""
  let all-h2 = query(heading.where(level: 2))
  for h in all-h2 {
    if h.location().position().page <= here().position().page and h.location().position().page >= chapter-page {
      if h.numbering != none {
        let nums = counter(heading).at(h.location())
        section-title = numbering(h.numbering, ..nums) + ". " + content-to-text(h.body)
      } else {
        section-title = content-to-text(h.body)
      }
    }
  }

  let hdr-size = 12pt

  // Push header down to match LaTeX vertical position
  v(-24pt)

  if is-odd {
    // Odd pages (non-chapter): section title left, page number right
    grid(
      columns: (1fr, auto),
      align: (left, right),
      text(size: hdr-size, upper(section-title)),
      text(size: hdr-size, str(pg)),
    )
  } else {
    // Even pages: page number left, chapter title right
    grid(
      columns: (auto, 1fr),
      align: (left, right),
      text(size: hdr-size, str(pg)),
      text(size: hdr-size, upper(chapter-title)),
    )
  }
  v(-8pt)
  header-line
}

// Mainmatter footer: only shows centered page number on chapter-opening pages
#let mainmatter-footer = context {
  if is-chapter-page() {
    let pg = counter(page).at(here()).first()
    align(center, text(size: 12pt, str(pg)))
  }
}

// --- Main template function --------------------------------------------------

#let thesis(
  config: (:),
  body,
) = {
  // --- Document metadata ---
  set document(
    title: config.at("title", default: ""),
    author: config.at("author", default: ""),
  )

  // --- Font setup ---
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: "sl",
    region: "SI",
  )

  // Math font
  show math.equation: set text(font: "New Computer Modern Math")

  // --- Page setup ---
  // A4, double-sided margins matching LaTeX template (measured from compiled PDF):
  //   inner (binding) = 43mm, outer = 30mm
  //   top = 46mm, bottom = 46mm
  // Note: the FRI official spec says 30/20mm, but the LaTeX template actually
  // uses ~43mm inner / 30mm outer due to \addtolength adjustments on LaTeX defaults.
  // We match the LaTeX visual output, not the FRI spec text.
  // Line spacing: 1.3x (LaTeX \baselinestretch{1.3})
  set page(
    paper: "a4",
    margin: (
      top: 46mm,
      bottom: 46mm,
      inside: 43mm,
      outside: 30mm,
    ),
    header-ascent: 20pt,
  )

  set par(
    leading: 0.65em * 1.3, // approximate 1.3x line spacing
    first-line-indent: 1.5em,
    justify: true,
  )

  // --- Heading styles ---
  // Chapter headings: two-line LaTeX book style
  //   Numbered:   "Poglavje N" / gap / "Title"
  //   Appendix:   "Dodatek A"  / gap / "Title"
  //   Unnumbered: just "Title"
  // All level-1 headings start on a new odd page with a large top gap.
  show heading.where(level: 1): it => {
    // Restart per-chapter counters for numbered content here, rather than via a
    // separate `show heading` rule: a re-emitting heading rule would strip the
    // block spacing of sub-headings (levels 2-4).
    counter(figure.where(kind: image)).update((0,))
    counter(figure.where(kind: table)).update((0,))
    counter(figure.where(kind: "algorithm")).update((0,))
    counter(math.equation).update((0,))
    pagebreak(to: "odd", weak: true)
    v(80pt)
    set par(justify: false, first-line-indent: 0pt)

    if it.numbering != none {
      let is-appendix = it.numbering == "A.1" or it.numbering == "A"
      let prefix = if is-appendix { "Dodatek" } else { "Poglavje" }
      let num-fmt = if is-appendix { "A" } else { "1" }

      // LaTeX \huge at 12pt = 24.88pt, \Huge at 12pt ≈ 26pt
      block(above: 0pt, below: 0pt, text(size: 24.88pt, weight: "bold")[#prefix #counter(heading).display(num-fmt)])
      v(36pt)
      block(above: 0pt, below: 0pt, text(size: 26pt, weight: "bold")[#it.body])
    } else {
      block(above: 0pt, below: 0pt, text(size: 26pt, weight: "bold")[#it.body])
    }

    v(46pt)
  }

  // Sub-headings stay real heading elements (block-level), styled via set rules.
  // Reconstructing them as content would make Typst trim the trailing below-spacing
  // at the document top level; keeping them as elements preserves proper spacing
  // and avoids indenting the following paragraph. Numbering uses the default layout.
  show heading.where(level: 2): set text(size: 14pt, weight: "bold")
  show heading.where(level: 2): set block(above: 2.0em, below: 1.5em)
  show heading.where(level: 3): set text(size: 12pt, weight: "bold")
  show heading.where(level: 3): set block(above: 1.6em, below: 1.2em)
  show heading.where(level: 4): set text(size: 12pt, weight: "bold")
  show heading.where(level: 4): set block(above: 1.4em, below: 1.1em)

  // Chapter-aware numbering defaults (main body).
  set figure(numbering: dependent-numbering("1.1"), placement: auto)
  set math.equation(numbering: dependent-numbering("(1.1)"), supplement: none)

  // --- Figure and table captions ---
  show figure.caption: it => {
    set text(size: 10pt)
    align(center)[
      #text(weight: "bold")[#it.supplement #it.counter.display(it.numbering):]
      #it.body
    ]
  }

  // --- Table of contents styling ---
  set outline.entry(fill: box(width: 1fr, repeat[#h(0.25em).#h(0.25em)]) + h(0.5em))
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): it => {
    v(1.8em, weak: true)
    strong(it)
  }
  // Povzetek and Abstract: show in TOC but without page numbers
  show outline.entry: it => {
    let dominated-labels = (<heading:povzetek>, <heading:abstract>)
    let dominated = dominated-labels.any(lbl => {
      query(lbl).any(el => el.location() == it.element.location())
    })
    if dominated {
      v(1.8em, weak: true)
      strong(link(it.element.location(), it.indented(it.prefix(), it.body())))
    } else {
      it
    }
  }

  // --- Hyperlink styling ---
  show link: it => {
    set text(fill: black)
    it
  }

  // Emit body
  body
}
