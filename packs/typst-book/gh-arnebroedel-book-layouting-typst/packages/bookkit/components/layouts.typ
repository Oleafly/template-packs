// components/layouts.typ — Layout components

#import "../theme.typ": fonts, gradients, palette, space, type-scale
#import "@preview/marginalia:0.3.1" as marginalia

// ── Margin notes (Tufte-style, collision-free) ─────────────────
// Real margin notes via @preview/marginalia: notes stack in the outer
// margin without overlapping. A chapter must enable the margin column
// once with `#show: marginalia-setup` (which reserves the space and
// MUST be applied before the notes are used).
//
// Note markers use superscript numbers in our embedded fonts — this
// deliberately avoids marginalia's default "Inter" marker style.
#let _margin-numbering = (..i) => text(
  fill: palette.primary,
  weight: "bold",
  size: 6.5pt,
)[#super(numbering("1", ..i.pos()))]

#let margin-note(body, title: none) = marginalia.note(
  numbering: _margin-numbering,
  {
    set text(size: type-scale.tiny, fill: palette.text-body)
    set par(justify: false, leading: 0.55em)
    if title != none {
      text(weight: "bold", font: fonts.sans, fill: palette.primary-dark, title)
      linebreak()
    }
    body
  },
)

// Page setup show-rule for a chapter that uses margin notes. Outer
// margin is widened to hold the note column; inner (binding) stays
// generous. `book: true` keeps inside/outside alternation.
// Binding (inner) margin stays at the book's 25mm; only the outer edge
// is widened to ~32mm to hold the note column.
#let margin-setup = marginalia.setup.with(
  book: true,
  inner: (far: 25mm, width: 0mm, sep: 0mm),
  outer: (far: 5mm, width: 22mm, sep: 5mm),
  top: 25mm,
  bottom: 25mm,
)

// ── Sidebar layout ─────────────────────────────────────────────
// Fixed sidebar + fluid main content via grid.
#let sidebar-layout(
  main,
  sidebar: none,
  sidebar-width: 160pt,
  gutter: space.lg,
  sidebar-position: left,
) = {
  let sidebar-content = block(
    width: 100%,
    fill: palette.bg-subtle,
    inset: space.md,
    radius: 4pt,
    sidebar,
  )

  let cols = if sidebar-position == left {
    (sidebar-width, 1fr)
  } else {
    (1fr, sidebar-width)
  }

  let children = if sidebar-position == left {
    (sidebar-content, main)
  } else {
    (main, sidebar-content)
  }

  grid(
    columns: cols,
    column-gutter: gutter,
    ..children,
  )
}

// ── Magazine layout ────────────────────────────────────────────
// Full-width hero followed by multi-column body.
// GUARD: uses columns() function, never set page(columns: N)
#let magazine-layout(
  hero,
  body,
  column-count: 2,
  gutter: space.lg,
) = {
  block(width: 100%, hero)
  v(space.lg)
  columns(column-count, gutter: gutter, body)
}

// ── Scientific paper ───────────────────────────────────────────
// Two-column academic layout with full-width title and abstract.
#let scientific-paper(
  body,
  title: none,
  authors: none,
  abstract: none,
) = {
  if title != none {
    block(
      width: 100%,
      above: space.lg,
      below: space.md,
      text(size: type-scale.h2, weight: "bold", font: fonts.sans, title),
    )
  }

  if authors != none {
    block(
      width: 100%,
      below: space.md,
      text(size: type-scale.small, fill: palette.text-muted, authors),
    )
  }

  if abstract != none {
    block(
      width: 100%,
      inset: space.md,
      fill: palette.bg-subtle,
      radius: 4pt,
      below: space.xl,
      {
        text(weight: "bold", size: type-scale.small)[Abstract]
        v(space.xs)
        set text(size: type-scale.small)
        abstract
      },
    )
  }

  columns(2, gutter: space.lg, body)
}

// ── Comparison layout ──────────────────────────────────────────
// Side-by-side comparison of two content blocks.
#let comparison-layout(
  left,
  right,
  left-title: none,
  right-title: none,
) = {
  grid(
    columns: (1fr, 1fr),
    column-gutter: space.lg,
    {
      if left-title != none {
        block(below: space.sm, text(weight: "bold", font: fonts.sans, left-title))
      }
      left
    },
    {
      if right-title != none {
        block(below: space.sm, text(weight: "bold", font: fonts.sans, right-title))
      }
      right
    },
  )
}

// ── Adaptive layout ────────────────────────────────────────────
// Width-aware layout: sidebar when wide, stacked when narrow.
// GUARD: uses layout(size => ...), never context { page.width }
#let adaptive-layout(
  body,
  sidebar: none,
  sidebar-width: 160pt,
  breakpoint: 400pt,
) = {
  layout(size => {
    if sidebar != none and size.width > breakpoint {
      grid(
        columns: (sidebar-width, 1fr),
        column-gutter: space.lg,
        sidebar, body,
      )
    } else {
      if sidebar != none {
        block(width: 100%, sidebar)
        v(space.lg)
      }
      body
    }
  })
}

// ── Breakout ───────────────────────────────────────────────────
// Full-width element, used between column sections.
#let breakout(body) = {
  block(
    width: 100%,
    above: space.xl,
    below: space.xl,
    body,
  )
}
