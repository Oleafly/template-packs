// ═══════════════════════════════════════════════════════════════════════════
// RUNNING HEAD — "you are here" text for the page header
// ═══════════════════════════════════════════════════════════════════════════
//
// `running-section()` returns the innermost heading that started at or before
// the current page, as a clickable link, e.g. "2.3 Sample preparation".
// Use it in config.typ:
//
//     header-right: running-section(),
//
// Because it is a `context` expression it is re-evaluated for every page.

// `depth`     — deepest heading level to display (1 ⇒ chapters only).
// `transform` — optional function applied to the finished content, handy for
//               shortening long titles (see the `shorten` example in
//               config.typ).
#let running-section(depth: 2, transform: it => it) = context {
  let sel = heading.where(level: 1)
  for level in range(2, depth + 1) {
    sel = sel.or(heading.where(level: level))
  }

  // Everything that has started by the end of this page — the same rule LaTeX
  // uses, so a chapter opening page already shows its own title.
  let candidates = query(sel).filter(h => h.location().page() <= here().page())
  if candidates.len() == 0 { return }

  let current = candidates.last()
  let title = if current.numbering == none {
    current.body
  } else {
    [#numbering(current.numbering, ..counter(heading).at(current.location())) #current.body]
  }

  transform(link(current.location(), title))
}
