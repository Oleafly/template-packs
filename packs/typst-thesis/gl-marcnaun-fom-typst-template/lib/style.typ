// ─── Page layout per FOM guidelines ──────────────────────────────────────────
// Margins: top 4 cm, bottom 2.8 cm, left 4 cm, right 2 cm

#let body-font    = ("Helvetica Neue", "Arial")
#let heading-font = body-font
#let code-font    = ("Menlo", "IBM Plex Mono", "DejaVu Sans Mono", "Courier New")

// ─── Central size definitions ─────────────────────────────────────────────────
#let body-size   = 11pt
#let fn-size     = body-size - 2pt   //  9 pt  (footnote text)
#let fn-num-size = body-size - 4pt   //  7 pt  (footnote number in text and footnote)

// Headings: H3 = body+1, each +2 pt upward
#let h3-size   = body-size + 1pt   // 12 pt
#let h2-size   = body-size + 3pt   // 14 pt
#let h1-size   = body-size + 5pt   // 16 pt

// Spacing: all derived from body-size
#let leading   = 1.1em
#let par-after = 2.2em                  // 1 blank line after paragraph
#let h-spacing = 2.2 * body-size        // 1 line spacing (absolute, independent of heading size)

// State: was the previous block element a heading?
// Ensures h→h has 1 line gap, text→h has 2 lines.
#let _prev-was-heading = state("prev-was-heading", false)

// Figures / tables / code: outer spacing (1 blank line each)
#let fig-above = 2.2 * body-size
#let fig-below = 2.2 * body-size

// Page
#let page-margins = (top: 4cm, bottom: 2.8cm, left: 4cm, right: 2cm)

// ─── Global document styles ───────────────────────────────────────────────────

#let apply-styles(body) = {
  set page(
    paper:          "a4",
    margin:         page-margins,
    header-ascent:  50%,
    footer-descent: 30%,
  )

  set text(
    font:      body-font,
    size:      body-size,
    lang:      "de",
    region:    "DE",
    hyphenate: true,
  )
  set smartquote(enabled: true, alternative: false)

  set par(
    justify:           true,
    leading:           leading,
    spacing:           par-after,
    first-line-indent: 0pt,
  )

  // ─── Lists (ordered and unordered) ──────────────────────────────────────
  set list(indent: 1.5em, body-indent: 0.5em, spacing: 1.1em)
  set enum(indent: 1.5em, body-indent: 0.5em, spacing: 1.1em)
  show list: set block(above: 2.2em, below: 2.2em)
  show enum: set block(above: 2.2em, below: 2.2em)

  // Reset state when body text appears
  show par: it => { _prev-was-heading.update(false); it }

  // ─── Headings: decimal, max 3 levels ──────────────────────────────────────
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    _prev-was-heading.update(true)
    set text(font: heading-font, weight: "bold", size: h1-size)
    { set block(above: 0pt); it }
    v(h-spacing, weak: true)
  }
  show heading.where(level: 2): it => {
    set text(font: heading-font, weight: "bold", size: h2-size)
    context v(if _prev-was-heading.get() { h-spacing } else { 2 * h-spacing }, weak: true)
    _prev-was-heading.update(true)
    it
    v(h-spacing, weak: true)
  }
  show heading.where(level: 3): it => {
    set text(font: heading-font, weight: "bold", size: h3-size)
    context v(if _prev-was-heading.get() { h-spacing } else { 2 * h-spacing }, weak: true)
    _prev-was-heading.update(true)
    it
    v(h-spacing, weak: true)
  }

  // ─── Tables: only header underline ────────────────────────────────────────
  set table(stroke: none)
  set table.hline(stroke: 0.5pt)
  set table(inset: (x: 0.5em, y: 0.4em))

  show table.cell.where(y: 0): set text(weight: "bold")

  // ─── Figures and tables ───────────────────────────────────────────────────
  // Caption: bottom, centered, bold
  set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set align(center)
  show figure.caption: set text(weight: "bold", size: fn-size)
  set figure(gap: 1em, placement: none)
  show figure: it => {
    v(fig-above, weak: true)
    it
    v(fig-below, weak: true)
  }
  // Code figures: left-aligned
  show figure.where(kind: raw): set align(left)

  // Outline entries for figures/tables/listings: add colon separator (FOM standard).
  // Typst 0.13+ methods: prefix(), body(), page(), indented(prefix, inner, gap).
  // gap defaults to 0.5em which inserts an unwanted space before ": " — set to 0pt.
  show outline.entry: it => {
    if it.element.func() == figure {
      let f = if it.fill != none { box(width: 1fr, it.fill) } else { h(1fr) }
      link(
        it.element.location(),
        it.indented(it.prefix(), [: #it.body()#f#it.page()], gap: 0pt)
      )
    } else {
      it
    }
  }

  // ─── Code blocks: syntax highlighting, gray border ────────────────────────
  show raw.where(block: false): it => {
    box(
      fill:   luma(245),
      stroke: 0.5pt + luma(210),
      radius: 2pt,
      inset:  (x: 3pt, y: 1pt),
      text(font: code-font, size: 0.88em, it),
    )
  }

  show raw.where(block: true): it => {
    set align(left)
    set text(font: code-font, size: fn-size, lang: "und")
    block(
      width:  100%,
      fill:   luma(248),
      stroke: 1.5pt + luma(200),
      radius: 3pt,
      inset:  0pt,
      clip:   true,
      stack(
        // Language bar (top right)
        if it.lang != none {
          block(
            width: 100%,
            fill:  luma(230),
            inset: (x: 0.9em, y: 0.35em),
            align(right,
              text(fill: luma(100), size: 7.5pt, weight: "bold",
                upper(it.lang))
            ),
          )
        },
        // Line numbers + code (left-aligned)
        block(
          width: 100%,
          inset: (x: 0pt, y: 0.7em),
          grid(
            columns:       (2.2em, 1fr),
            column-gutter: 0pt,
            row-gutter:    0.5em,
            ..it.lines.map(line => (
              align(right,
                box(inset: (right: 0.7em),
                  text(fill: luma(180), size: 8pt, str(line.number)))),
              align(left,
                box(inset: (right: 1em), line.body)),
            )).flatten()
          )
        ),
      ),
    )
  }

  body
}

// ─── Source code figure helper ────────────────────────────────────────────────
#let code-fig(caption: [], label: none, body) = figure(
  kind:       raw,
  supplement: [Quellcode],
  caption:    caption,
  body,
)

// ─── Placeholder figure ───────────────────────────────────────────────────────
#let placeholder(w: 100%, h: 5cm, label: "Figure (Placeholder)") = rect(
  width:  w,
  height: h,
  stroke: 0.5pt,
  fill:   luma(238),
  radius: 2pt,
  align(center + horizon)[
    #text(fill: luma(140), size: 10pt)[#label]
  ],
)

// ─── Frontmatter: Roman numerals, centered in header ─────────────────────────
#let frontmatter-numbering(body) = {
  set page(
    numbering:    "I",
    number-align: center,
    footer:       none,
    header:       context align(center, text(size: 10pt,
      counter(page).display("I")
    )),
  )
  counter(page).update(1)
  body
}

// ─── Mainmatter: Arabic numerals, centered in header ─────────────────────────
#let mainmatter-numbering(body) = {
  set page(
    numbering:    "1",
    number-align: center,
    footer:       none,
    header:       context align(center, text(size: 10pt,
      counter(page).display("1")
    )),
  )
  counter(page).update(1)
  counter(footnote).update(0)
  body
}

// ─── Footnote styles (mainmatter only) ───────────────────────────────────────
// Apply with #show: apply-footnote-styles in main.typ, right before mainmatter.
// Inner show rules override the outer suppression set in main.typ.
#let apply-footnote-styles(body) = {
  set footnote.entry(
    separator: line(length: 40%, stroke: 0.5pt),
  )
  show footnote: it => {
    context {
      let num = counter(footnote).at(here()).first()
      box(baseline: -0.35em, text(size: fn-num-size, weight: "regular", str(num)))
    }
    hide(it)
  }
  show footnote.entry: it => {
    set par(leading: 0.5em, spacing: 3pt)
    set text(size: fn-size)
    context {
      let num = counter(footnote).at(it.note.location()).first()
      box(baseline: -0.3em, text(size: fn-num-size, str(num)))
      h(0.15em)
      it.note.body
    }
  }
  body
}
