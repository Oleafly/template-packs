// ============================================================
// AMIA Annual Symposium — Template Core Library
// ============================================================
//   - US Letter, 1in margins, single column
//   - Times New Roman 10pt, single-spaced, justified
//   - Title: 14pt bold centered
//   - Authors: 12pt bold centered, comma-separated
//   - All headings 10pt: bold / bold+italic / italic
//   - AMA/NLM-style superscript citations (no brackets, comma-separated)
//   - Numbered equations (1), (2), ...
//   - No page numbers
// ============================================================

// ---- Document Styles ----
// IMPORTANT: In Typst, top-level `#set`/`#show` rules in an *imported* module
// do NOT propagate to the importing document — only `#let` definitions are
// imported. So all document-wide styling is bundled into this function and
// applied from inside `amia-symposium` (via `#show: template-styles`), which
// makes the rules take effect on the actual paper body.
#let template-styles(body) = {
  // ---- Page Setup ----
  set page(
    paper: "us-letter",
    margin: (left: 1in, right: 1in, top: 1in, bottom: 1in),
    numbering: none,
    header: none,
  )

  // ---- Global Text Defaults ----
  set text(
    font: "Times New Roman",
    size: 10pt,
    lang: "en",
  )

  // ---- Paragraph Defaults ----
  // Match paragraph spacing to the line leading so consecutive paragraphs
  // stay on the same vertical rhythm without an extra paragraph gap. Section
  // spacing is controlled by the heading block rules below.
  set par(
    justify: true,
    first-line-indent: 0pt,
    leading: 0.5em,
    spacing: 0.5em,
  )

  // ---- Heading Defaults ----
  // All headings: 10pt (same as body). Their block rules provide the spacing
  // around section boundaries independently of body paragraph spacing.

  // Level 1: section headings — 10pt bold
  show heading.where(level: 1): set text(size: 10pt, weight: "bold", style: "normal")
  show heading.where(level: 1): set block(above: 1em, below: 0.6em)

  // Level 2: sub-section headings — 10pt bold + italic
  show heading.where(level: 2): set text(size: 10pt, weight: "bold", style: "italic")
  show heading.where(level: 2): set block(above: 0.8em, below: 0.5em)

  // Level 3: sub-sub-section headings — 10pt italic
  show heading.where(level: 3): set text(size: 10pt, weight: "regular", style: "italic")
  show heading.where(level: 3): set block(above: 1em, below: 0.6em)

  // ---- Figure / Table Caption Defaults ----
  // 9pt captions with a bold "Figure N." / "Table N." prefix, regular body.
  set figure(placement: top)
  set figure.caption(separator: [. ])
  show figure.caption: set align(left)
  show figure.caption: set text(size: 9pt)
  show figure.caption: set par(leading: 0.5em, spacing: 0pt)
  show figure.caption: it => context [
    #strong[#it.supplement #it.counter.display(it.numbering)#it.separator]#it.body
  ]

  // ---- Table Defaults ----
  // Tighter cell padding so tables aren't overly loose.
  set table(stroke: 0.5pt + black, inset: (x: 6pt, y: 3pt))

  // ---- Equation Defaults ----
  // Number display equations as (1), (2), ... on the right; referenceable via labels.
  set math.equation(numbering: "(1)")

  // ---- Bibliography output style ----
  // Drop the default "Bibliography" title (we render our own "References"
  // heading). Slightly tighter line-height, with an even gap between entries
  // that matches the line spacing so the list reads uniformly.
  set bibliography(title: none)
  show bibliography: set text(size: 9pt)
  show bibliography: set par(first-line-indent: 0pt, leading: 0.5em, spacing: 0.5em)

  body
}

// ---- Helper: Title Block ----
// Renders title, authors (comma-separated), and affiliations with 1,2,3 numbering.
// `author-breaks` contains 1-based positions after which a hard line break is inserted.
#let title-block(title-text, authors, affiliations, author-breaks: ()) = {
  set align(center)
  set par(justify: false, leading: 0.5em)

  // --- Title: 14pt bold ---
  set text(size: 14pt, weight: "bold")
  title-text
  v(1pt)

  // --- Authors: 12pt bold, comma-separated ---
  set text(size: 12pt, weight: "bold")
  let author-entries = authors.map(((name, inst-idxs)) => {
    let sup-nums = inst-idxs.map(i => super(str(i)))
    [#name#sup-nums.join(super(","))]
  })
  for (i, entry) in author-entries.enumerate() {
    entry
    if i < author-entries.len() - 1 {
      if author-breaks.contains(i + 1) {
        linebreak()
      } else {
        [, ]
      }
    }
  }
  v(0pt)

  // --- Affiliations: numbered 1, 2, 3 ---
  set text(
    size: 11pt,
    weight: "bold", 
    // style: "italic"
  )
  let affil-entries = affiliations.enumerate().map(((i, text)) => {
    let num = super(str(i + 1))
    [#num #text]
  })
  affil-entries.join(linebreak())
  v(0pt)
}

// ---- Helper: Abstract Block ----
// "Abstract" sits on its own line like a section heading; the abstract text
// starts on the next line, in italic.
#let abstract-block(body) = {
  set align(left)
  {
    set text(size: 10pt, weight: "bold")
    [Abstract]
    linebreak()
  }
  {
    set text(size: 10pt, style: "italic")
    body
  }
  v(3pt)
}

// ---- Helper: Keywords ----
#let keywords-block(words) = {
  set align(left)
  set text(size: 10pt)
  let kw = words.join("; ")
  [*Keywords:* #kw]
  v(8pt)
}

// ---- Helper: References Heading ----
#let references-heading() = {
  v(0.3em)
  set align(center)
  set text(size: 10pt, weight: "bold")
  [References]
  set align(left)
}
