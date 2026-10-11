// ═══════════════════════════════════════════════════════════════════════════
// THESIS — the entry point of the template
// ═══════════════════════════════════════════════════════════════════════════
//
// You apply it once, at the top of main.typ:
//
//     #import "lib/thesis.typ": thesis
//     #show: thesis.with(title: "...", authors: ("Ada Lovelace",))
//
// `#show: f` means "hand the rest of the document to the function f". So
// everything you write below that line becomes the `body` argument here, and
// this function decides what surrounds it: cover page, front matter, table of
// contents, page numbering and the layout rules.
//
// Every argument has a sensible default — pass only what you need.

#import "theme.typ": resolve-theme, theme-state
#import "cover.typ": show-cover, default-cover-labels
#import "layout.typ": show-layout
#import "blocks.typ": check-todos

#let default-labels = default-cover-labels + (
  contents: "Contents",
)

#let thesis(
  // ── Who and what ───────────────────────────────────────────────────────
  title: "",
  // A list of authors. Each is either a plain string or a dictionary
  // `(name: "...", born: "...", student-id: "...")` — the extra keys only
  // show up on the cover page.
  authors: (),

  // ── Cover page (all optional) ──────────────────────────────────────────
  degree: none, // "Doctor of Natural Sciences"
  major: none, // "(Dr. rer. nat.)"
  submission-text: none, // "Doctoral thesis for obtaining the academic degree"
  university: none,
  faculty: none,
  department: none,
  location: none,
  date: none,
  supervisor: none,
  co-supervisor: none,
  logo: none, // path to an image, or ready-made content

  // ── Running head and foot ──────────────────────────────────────────────
  // `auto` fills in a sensible default; `none` leaves the slot empty.
  short-title: auto, // auto ⇒ `title`
  short-author: auto, // auto ⇒ surname of the first author
  header-left: auto, // auto ⇒ short title
  header-right: none, // e.g. `running-section()`, see lib/running-head.typ
  footer-left: auto, // auto ⇒ short author
  footer-right: auto, // auto ⇒ university

  // ── Structure ──────────────────────────────────────────────────────────
  // Content placed between the cover and the table of contents
  // (acknowledgements, summary, list of publications, ...). Its pages are
  // numbered with roman numerals and its headings are not numbered.
  frontmatter: none,

  // ── Switches ───────────────────────────────────────────────────────────
  cover: true,
  show-outline: true,
  outline-depth: 3,
  header-footer: true,
  columns: 1,
  // true ⇒ mirrored margins and chapters starting on right-hand pages.
  // Turn this on for the printed, double-sided version.
  two-sided: false,
  numbering-per-chapter: true, // "Figure 2.3" instead of "Figure 17"

  // ── Look ───────────────────────────────────────────────────────────────
  accent: none, // shortcut for `theme: (accent: ...)`
  theme: (:), // any keys of `default-theme`, see lib/theme.typ
  labels: (:), // override the visible words, see `default-labels`

  body,
) = {
  // ── Resolve settings ───────────────────────────────────────────────────
  let overrides = theme
  if accent != none { overrides = overrides + (accent: accent) }
  let th = resolve-theme(overrides)
  let lbl = default-labels + labels

  let author-list = if type(authors) == array { authors } else { (authors,) }
  let name-of(a) = if type(a) == str { a } else { a.name }
  let author-names = author-list.map(name-of)

  let head-title = if short-title == auto { title } else { short-title }
  let head-author = if short-author != auto {
    short-author
  } else if author-names.len() > 0 {
    author-names.first().split(" ").last() // surname
  } else {
    none
  }

  // ── PDF metadata (must come before any content) ────────────────────────
  set document(title: title, author: author-names)

  // Publish the theme so helpers such as `note()` can read the colours.
  theme-state.update(th)

  // ── Cover page ─────────────────────────────────────────────────────────
  set page(numbering: none)
  if cover {
    show-cover(
      title: title,
      authors: author-list,
      degree: degree,
      major: major,
      submission-text: submission-text,
      university: university,
      faculty: faculty,
      department: department,
      location: location,
      date: date,
      supervisor: supervisor,
      co-supervisor: co-supervisor,
      logo: logo,
      theme: th,
      labels: lbl,
    )
    pagebreak(weak: true, to: "odd")
  }
  if supervisor != none and co-supervisor != none {
    show text: set align(bottom+left)
    show text: set par(spacing: 1em)
    v(1fr)
    grid(columns: 2, row-gutter: 1em, column-gutter: 1em)[1. Gutachter][#supervisor][2. Gutachter][#co-supervisor]
    pagebreak(weak: true, to: "odd" )
  }
  else {
    v(1fr)
    pagebreak(weak: true, to: "odd" )
  }

  // ── Everything from here on gets the layout rules ──────────────────────
  show: it => show-layout(
    it,
    theme: th,
    column-count: columns,
    two-sided: two-sided,
    chapter-start: if columns > 1 { "column" } else { "page" },
    numbering-per-chapter: numbering-per-chapter,
    show-header-footer: header-footer,
    header-left: if header-left == auto { head-title } else { header-left },
    header-right: header-right,
    footer-left: if footer-left == auto { head-author } else { footer-left },
    footer-right: if footer-right == auto { university } else { footer-right },
  )

  // ── Front matter: roman page numbers, unnumbered headings ──────────────
  set page(numbering: "I")
  counter(page).update(1)
  set heading(numbering: none)

  if frontmatter != none { frontmatter }

  if show-outline {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true, lbl.contents)
    // The outline brings its own title; we printed a heading instead so that
    // it is styled exactly like every other unnumbered chapter title.
    outline(title: none, depth: outline-depth, indent: auto)
  }

  // ── Main matter: arabic page numbers restarting at 1, numbered chapters ─
  pagebreak(weak: true, to: if two-sided { "odd" })
  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: th.heading-numbering)

  body

  // Invisible. Runs once the whole document exists, so it can report every
  // remaining `#todo` / `#mark` at once — see `strict-todos` in lib/blocks.typ.
  check-todos()
}
