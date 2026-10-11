// ═══════════════════════════════════════════════════════════════════════════
// CONFIG — everything about YOUR thesis
// ═══════════════════════════════════════════════════════════════════════════
//
// This is the first (and often the only) file you have to edit. It is used by
// both main.typ (the whole thesis) and preview.typ (a single chapter), so the
// two always look the same.
//
// Anything you delete falls back to a sensible default — see lib/thesis.typ
// for the full list of options and lib/theme.typ for colours and fonts.

#import "lib/running-head.typ": running-section
#import "lib/utils.typ": shorten

// Long chapter titles do not fit in a page header. This shortens them on the
// fly; add your own patterns or delete the whole thing.
#let short-form = shorten.with(replacements: (
  ("(?i)analytical ultracentrifugation", "AUC"),
  ("(?i)band-forming experiment", "BFE"),
))

#let thesis-info = (
  // ── Title page ──────────────────────────────────────────────────────────
  title: "A Modelling Framework for Band-Forming Analytical Ultracentrifugation Experiments",
  authors: (
    (name: "Ada Lovelace", born: "10 December 1815, London", student-id: "01234567"),
  ),

  submission-text: "Doctoral thesis for obtaining the academic degree",
  degree: "Doctor of Natural Sciences",
  major: "(Dr. rer. nat.)",

  university: "Universität Konstanz",
  faculty: "Faculty of Sciences",
  department: "Department of Chemistry",
  // Replace assets/logo.png with your own institution's logo, adjust the
  // width, or set `logo: none` to get a placeholder box instead.
  logo: image("assets/logo.png", width: 6cm),

  location: "Konstanz",
  date: "2026",
// Uncomment the following lines for your committee
//  supervisor: "Prof. Dr. Alan Turing",
//  co-supervisor: "Prof. Dr. Grace Hopper",

  // ── Running head and foot ───────────────────────────────────────────────
  // Header: short title on the left, current section on the right.
  // Footer: surname on the left, page number in the middle, university right.
  short-title: "A Modelling Framework for BFEs in AUC",
  header-right: running-section(depth: 2, transform: short-form),

  // ── Structure and layout ────────────────────────────────────────────────
  // Set `two-sided: true` for the printed version: the margins mirror and
  // every chapter starts on a right-hand page.
  two-sided: true,
  columns: 1,
  outline-depth: 3,
  numbering-per-chapter: true, // "Figure 2.3" rather than "Figure 17"

  // ── Look ────────────────────────────────────────────────────────────────
  // accent: rgb("#8a1538"),      // one colour for headings, links and boxes
  // theme: (
  //   font-size: 12pt,
  //   font-serif: ("Libertinus Serif",),
  //   margin: (inside: 3.5cm, outside: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  // ),
  // labels: (                    // translate the fixed words on the cover
  //   submitted-by: "vorgelegt von",
  //   contents: "Inhaltsverzeichnis",
  // ),
)

// ── Bibliography ────────────────────────────────────────────────────────────
// Export your .bib file and citation style once, so main.typ and preview.typ
// agree. Typst ships with many styles (ieee, apa, chicago-author-date,
// american-chemical-society, ...); you can also point at a local .csl file.
#let bib-file = "references.bib"
#let bib-style = "american-chemical-society"
