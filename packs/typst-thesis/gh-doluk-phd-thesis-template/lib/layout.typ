// ═══════════════════════════════════════════════════════════════════════════
// LAYOUT — page, running head/foot, headings, figures, tables
// ═══════════════════════════════════════════════════════════════════════════
//
// This is where the visual rules of the document live. `thesis()` applies it
// to everything after the cover page. Most people never need to touch it; if
// you want to change *what a heading looks like*, this is the file.

#import "theme.typ": default-theme

// Numbers figures, tables and equations as "<chapter>.<n>" — the usual style
// for a thesis. Inside unnumbered front matter (where the chapter counter is
// still 0) it falls back to a plain running number.
#let chapter-relative(n) = {
  let chapter = counter(heading).get()
  if chapter.len() > 0 and chapter.first() > 0 {
    numbering("1.1", chapter.first(), n)
  } else {
    numbering("1", n)
  }
}

#let show-layout(
  body,
  theme: default-theme,
  column-count: 1,
  two-sided: false,
  // Where a level-1 heading (a chapter) starts:
  // none | "page" | "odd-page" | "column".
  chapter-start: "page",
  // true ⇒ "Figure 2.3"; false ⇒ "Figure 17".
  numbering-per-chapter: true,
  show-header-footer: true,
  // The five slots of the running head and foot. Each may be a plain string,
  // arbitrary content, or a `context {..}` block that is re-evaluated on every
  // page (see lib/running-head.typ).
  header-left: none,
  header-right: none,
  footer-left: none,
  footer-center: auto, // `auto` ⇒ the page number
  footer-right: none,
) = {
  let accent = theme.accent
  let sans = theme.font-sans

  // A one-sided document has fixed left/right margins; a two-sided one
  // mirrors them, so the wider `inside` margin always sits at the binding.
  let margin = if two-sided {
    theme.margin
  } else {
    (
      left: theme.margin.inside,
      right: theme.margin.outside,
      top: theme.margin.top,
      bottom: theme.margin.bottom,
    )
  }

  let has-header = show-header-footer and (header-left, header-right).any(x => x != none)

  set page(
    paper: theme.paper,
    margin: margin,
    numbering: "1",
    // `set page(columns: ..)` rather than the `columns()` function: the latter
    // would put the whole document inside a container, and page settings
    // cannot be changed from within one.
    columns: column-count,
    header: if has-header {
      block(inset: (bottom: 4pt), {
        set text(size: 9pt, font: sans, fill: theme.text-muted)
        grid(
          columns: (auto, 1fr),
          align(left, header-left),
          align(right, header-right),
        )
      })
    },
    footer: if show-header-footer {
      block(inset: (top: 4pt), {
        set text(size: 9pt, font: sans, fill: theme.text-muted)
        grid(
          columns: (1fr, auto, 1fr),
          align(left, footer-left),
          align(center, if footer-center == auto {
            context counter(page).display()
          } else {
            footer-center
          }),
          align(right, footer-right),
        )
      })
    },
  )

  // ── Body text ──────────────────────────────────────────────────────────
  set text(
    size: theme.font-size,
    font: theme.font-serif,
    lang: theme.lang,
    region: theme.region,
  )
  set par(justify: true, leading: theme.leading, spacing: theme.spacing)
  show raw: set text(font: theme.font-mono)
  show link: set text(fill: accent)
  show ref: set text(fill: accent)

  // ── Headings ───────────────────────────────────────────────────────────
  // `@ch:intro` should read "Chapter 1", not "Section 1".
  show heading.where(level: 1): set heading(supplement: [Chapter])

  // A single rule for every level. The size comes from `theme.heading-sizes`;
  // only level 1 (a chapter) is coloured and starts a new page.
  show heading: it => {
    let sizes = theme.heading-sizes
    let size = sizes.at(calc.min(it.level, sizes.len()) - 1)

    if it.level == 1 {
      if chapter-start == "page" {
        pagebreak(weak: true)
      } else if chapter-start == "odd-page" {
        pagebreak(weak: true, to: "odd")
      } else if chapter-start == "column" {
        colbreak(weak: true)
      }
      if numbering-per-chapter and it.numbering != none {
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(math.equation).update(0)
      }
    }

    v(1.4em, weak: true)
    block(
      sticky: true,
      text(
        font: sans,
        size: size,
        weight: "bold",
        fill: if it.level == 1 { accent } else { black },
        {
          if it.numbering != none {
            counter(heading).display(it.numbering)
            h(0.5em)
          }
          it.body
        },
      ),
    )
    v(if it.level == 1 { 1.1em } else { 0.8em }, weak: true)
  }

  // ── Outlines (table of contents, list of figures, ...) ─────────────────
  show outline: set text(font: sans)
  show outline.entry: it => {
    // In the table of contents: chapters bold, deeper levels lighter and
    // smaller. In a list of figures or tables every entry is equal.
    let is-chapter = it.element.func() == heading and it.level == 1
    set text(
      weight: if is-chapter { "bold" } else { "regular" },
      size: 1em - 0.05em * (it.level - 1),
    )
    if is-chapter { v(0.6em, weak: true) }
    it
  }

  // ── Figures ────────────────────────────────────────────────────────────
  set figure(gap: 0.8em)
  set figure(numbering: if numbering-per-chapter { chapter-relative } else { "1" })
  show figure.caption: it => {
    set text(size: 0.9em, font: sans)
    set par(justify: false, leading: 0.6em)
    // A caption above a table must not be separated from it by a page break.
    block(sticky: it.position == top, align(center, {
      text(weight: "bold", fill: accent)[#it.supplement #context it.counter.display(it.numbering):]
      h(0.35em)
      it.body
    }))
  }
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(breakable: true)

  // ── Tables ─────────────────────────────────────────────────────────────
  // No vertical rules; a heavy rule above and below the header row and a
  // light one between the body rows. Pass `stroke:` to an individual table,
  // or place `table.hline(..)` between its rows, to override this.
  set table(
    stroke: (_, y) => (
      top: if y == 0 { 0.9pt + black },
      bottom: if y == 0 { 0.5pt + black } else { 0.4pt + luma(180) },
    ),
    inset: (x: 6pt, y: 5pt),
  )
  show table.cell.where(y: 0): set text(weight: "bold", font: sans)

  // ── Maths ──────────────────────────────────────────────────────────────
  set math.equation(numbering: if numbering-per-chapter {
    n => "(" + chapter-relative(n) + ")"
  } else {
    "(1)"
  })

  body
}
