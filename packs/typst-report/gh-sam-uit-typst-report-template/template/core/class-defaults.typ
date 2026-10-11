// /template/core/class-defaults.typ
// Document class presets — the Typst equivalent of LaTeX .cls defaults
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Each class defines sensible defaults for page geometry, typography,
// and component visibility. User overrides are merged on top.

// MARK: Class Definitions

#let class-defaults = (
  // ── Article ─────────────────────────────────────────
  // Simplest format: no cover, no chapter breaks, compact layout.
  // Ideal for quick reviews, short papers, or memos.
  article: (
    paper: "a4",
    font-size: 11pt,
    margin: (x: 2cm, y: 2cm),
    two-sided: false,
    heading-numbering: "1.",
    chapter-pagebreak: false,
    par-leading: 0.65em,
    par-spacing: 1.2em,
    // Component visibility
    show-cover: false,
    show-soft-cover: false,
    show-summary: false,
    show-forewords: false,
    show-acknowledgement: false,
    show-instructor-comment: false,
    show-author: false,
    show-toc: true,
    show-lot: false,
    show-lof: false,
    show-loc: false,
    show-todo-list: false,
    show-acronyms: false,
  ),

  // ── Report ──────────────────────────────────────────
  // Standard single-sided report with cover page and lists.
  report: (
    paper: "a4",
    font-size: 12pt,
    margin: (all: 2.5cm),
    two-sided: false,
    heading-numbering: "1.",
    chapter-pagebreak: true,
    par-leading: 0.65em,
    par-spacing: 1.2em,
    // Component visibility
    show-cover: true,
    show-soft-cover: false,
    show-summary: false,
    show-forewords: false,
    show-acknowledgement: false,
    show-instructor-comment: false,
    show-author: true,
    show-toc: true,
    show-lot: true,
    show-lof: true,
    show-loc: true,
    show-todo-list: false,
    show-acronyms: false,
  ),

  // ── Book ────────────────────────────────────────────
  // Two-sided, chapter-based layout for longer works.
  book: (
    paper: "a4",
    font-size: 12pt,
    margin: (inside: 3cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm),
    two-sided: true,
    heading-numbering: "1.",
    chapter-pagebreak: true,
    par-leading: 0.8em,
    par-spacing: 1.5em,
    // Component visibility
    show-cover: true,
    show-soft-cover: false,
    show-summary: false,
    show-forewords: false,
    show-acknowledgement: false,
    show-instructor-comment: false,
    show-author: false,
    show-toc: true,
    show-lot: true,
    show-lof: true,
    show-loc: true,
    show-todo-list: false,
    show-acronyms: true,
  ),

  // ── Thesis ──────────────────────────────────────────
  // Book + thesis-specific preamble sections.
  thesis: (
    paper: "a4",
    font-size: 11pt,
    margin: (inside: 3cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm),
    two-sided: false,
    heading-numbering: "1.",
    chapter-pagebreak: true,
    par-leading: 0.8em,
    par-spacing: 1.5em,
    // Component visibility
    show-cover: true,
    show-soft-cover: true,
    show-summary: true,
    show-forewords: true,
    show-acknowledgement: true,
    show-instructor-comment: true,
    show-author: false,
    show-toc: true,
    show-lot: true,
    show-lof: true,
    show-loc: true,
    show-todo-list: true,
    show-acronyms: true,
  ),
)
