// lokta.typ. Lokta document themes for Typst (targets Typst >= 0.12).
//
// Plug and play:  #import "@local/lokta:0.1.0": *   (or a relative path)
//   #show: lokta-tech.with(title: "Ingestion Pipeline", org: "Folio", doc-id: "FA-2041", meta: (..))
//   #show: lokta-recipe.with(title: "Dashi Broth", film: "Spirited Away", ..)
//
// Templates: lokta-tech (white technical report), lokta-report (cream editorial
// report), lokta-article, lokta-bulletin, lokta-letter, lokta-cover, lokta-recipe,
// and the lokta-doc base. Helpers: lk-label, lk-rule, lk-measure, lk-endmark,
// lk-note, lk-quote. Token values are exact; do not change them.

// ── Tokens (exact values) ─────────────────────────────────────────────────────
#let lk-ink      = rgb("#16140E")
#let lk-primary  = rgb("#1F1C13")
#let lk-body     = rgb("#2A2620")
#let lk-mut      = rgb("#5C564B")
#let lk-muted    = rgb("#615A4C")
#let lk-faint    = rgb("#8E867A")
#let lk-hairline = rgb("#B8B0A1")
#let lk-hair     = rgb("#DAD7CF")
#let lk-paper0   = rgb("#FAF8EA")
#let lk-paper    = rgb("#F4F1DF")
#let lk-paper2   = rgb("#EAE6D2")
#let lk-paper3   = rgb("#DBD3BB")
#let lk-paper4   = rgb("#C2B89C")
#let lk-marigold = rgb("#FBBC0E")
#let lk-peach    = rgb("#E7A079")
#let lk-lavender = rgb("#A99CB3")
#let lk-aubergine = rgb("#6B4E8E")
#let lk-indigo   = rgb("#2E3E5C")
#let lk-celadon  = rgb("#6E8B6F")
#let lk-celadon-ink = rgb("#4F6B50")
#let lk-cinnabar = rgb("#C23A26")
#let lk-night    = rgb("#070D0E")

#let lk-sans  = "Archivo"
#let lk-mono  = "Spline Sans Mono"
#let lk-serif = "Source Serif 4"
#let lk-cjk   = "Noto Sans JP"
#let lk-deva  = "Mukta"          // Devanagari (Nepali)
#let lk-bengali = "Anek Bangla"  // Bengali
// Multilingual fallback lists: Typst picks the face that covers each glyph.
#let lk-sans-all = (lk-sans, lk-deva, lk-bengali, lk-cjk)
#let lk-serif-all = (lk-serif, "Martel", lk-bengali)

// ── Helpers ───────────────────────────────────────────────────────────────────
#let lk-label(s, color: lk-faint) = text(font: lk-mono, size: 8pt, tracking: 1.2pt, fill: color)[#upper(s)]

#let lk-rule(stroke: 0.5pt + lk-primary) = line(length: 100%, stroke: stroke)

// Hatched end-mark, the system signature.
#let lk-hatch(width: 56pt, color: lk-body) = box(
  height: 6pt, width: width,
  fill: tiling(size: (4pt, 4pt), line(start: (0pt, 4pt), end: (4pt, 0pt), stroke: 1pt + color)),
)

// Measured rule: a short line, a gap, then a hatched end-mark.
#let lk-measure(len: 180pt, hatch: 56pt, color: lk-primary) = grid(
  columns: (len, 1fr, hatch),
  align: horizon,
  line(length: 100%, stroke: 1pt + color),
  [],
  lk-hatch(width: 100%, color: color),
)

#let lk-endmark(color: lk-body) = lk-hatch(width: 56pt, color: color)

#let lk-note(title: "Note", accent: lk-indigo, body) = block(
  fill: lk-paper2, width: 100%, inset: (x: 12pt, y: 10pt),
  stroke: (left: 3pt + accent),
)[
  #lk-label(title, color: accent)
  #v(3pt)
  #set text(font: lk-sans, size: 9.5pt, fill: lk-body)
  #body
]

#let lk-quote(body, by: none) = block(width: 100%, inset: (left: 16pt), stroke: (left: 2pt + lk-marigold))[
  #set text(font: lk-serif, style: "italic", size: 15pt, fill: lk-primary)
  #body
  #if by != none { v(4pt); lk-label(by, color: lk-mut) }
]

// Editorial table: mono uppercase header over an accent rule, hairline rows, zebra.
// #lk-table(headers: ("Field", "Type"), rows: (("id", "int"), ("name", "str")))
#let lk-table(headers: (), rows: (), columns: auto, align: left, accent: lk-primary) = {
  let ncol = if headers.len() > 0 { headers.len() } else if rows.len() > 0 { rows.first().len() } else { 1 }
  table(
    columns: if columns == auto { ncol } else { columns },
    align: align,
    inset: (x: 10pt, y: 7pt),
    stroke: (x, y) => (
      bottom: if y == 0 { none } else { 0.5pt + lk-hair },
      top: if y == 1 { 1.5pt + accent } else { none },
    ),
    fill: (x, y) => if y > 0 and calc.even(y) { lk-paper2 } else { none },
    ..if headers.len() > 0 {
      (table.header(..headers.map(h => text(font: lk-mono, size: 8pt, tracking: 1pt, fill: lk-mut)[#upper(h)])),)
    } else { () },
    ..rows.flatten().map(c => text(font: lk-sans, size: 9.5pt, fill: lk-body)[#c]),
  )
}

// Callout variants over lk-note.
#let lk-tip(body) = lk-note(title: "Tip", accent: lk-celadon-ink, body)
#let lk-warning(body) = lk-note(title: "Warning", accent: lk-cinnabar, body)

// Figure caption: mono accent label, then a serif italic line. Use in a show rule.
#let lk-caption(accent: lk-mut) = it => block(width: 100%)[
  #text(font: lk-mono, size: 8pt, tracking: 1pt, fill: accent)[#upper[#it.supplement #context it.counter.display(it.numbering)]]
  #h(6pt)
  #text(font: lk-serif, style: "italic", size: 9pt, fill: lk-mut)[#it.body]
]

// Outline / contents styling. Apply inside a template with `show: lk-contents`.
#let lk-contents(body) = {
  show outline.entry: it => {
    set text(font: lk-sans, fill: lk-body)
    if it.level == 1 { v(4pt); set text(weight: 600, fill: lk-primary) }
    it
  }
  body
}

// Footnote styling: a short rule, then mono number and small sans text.
#let lk-footnotes(body) = {
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + lk-hair))
  show footnote.entry: it => { set text(font: lk-sans, size: 8.5pt, fill: lk-mut); it }
  body
}

// Revision history: a labelled table. rows = ((rev, date, author, note), ...).
#let lk-revisions(rows) = lk-table(
  headers: ("Rev", "Date", "Author", "Note"),
  rows: rows, columns: (auto, auto, auto, 1fr),
)

// References: a numbered list without a .bib file. items = (content, content, ...).
#let lk-references(items) = {
  set text(font: lk-sans, size: 9pt, fill: lk-body)
  set par(hanging-indent: 18pt)
  enum(numbering: "[1]", spacing: 0.9em, ..items)
}

// ── Technical report (white paper, hitec-style) ──────────────────────────────
#let lokta-tech(
  title: "", subtitle: none, org: "", doc-id: "", meta: (:), accent: lk-indigo, body,
) = {
  set page(
    paper: "a4", fill: white, margin: (x: 2cm, y: 2.2cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(columns: (1fr, 1fr), lk-label(title), align(right, lk-label(doc-id)))
        v(4pt); lk-rule(stroke: 0.5pt + lk-hair)
      }
    },
    footer: context {
      lk-rule(stroke: 0.5pt + lk-hair); v(3pt)
      grid(columns: (1fr, 1fr, 1fr),
        lk-label(doc-id),
        align(center, lk-label("Confidential")),
        align(right, lk-label(counter(page).display("01 / 1", both: true))))
    },
  )
  set text(font: lk-sans, size: 10.5pt, fill: lk-body)
  set par(leading: 0.72em, spacing: 0.95em)
  set heading(numbering: "1.1")
  show heading: it => {
    v(if it.level == 1 { 1.4em } else { 1em })
    grid(columns: (auto, 1fr), column-gutter: 0.6em,
      text(font: lk-mono, fill: accent, size: if it.level == 1 { 13pt } else { 11pt })[
        #context { if it.numbering != none { counter(heading).display(it.numbering) } }
      ],
      text(font: lk-sans, weight: if it.level == 1 { 700 } else { 600 },
        size: if it.level == 1 { 15pt } else { 12.5pt }, fill: lk-primary)[#it.body])
    v(0.3em)
  }
  show raw.where(block: true): it => block(
    width: 100%, fill: rgb("#F4F4F1"), stroke: 0.5pt + lk-hair, inset: 12pt,
    text(font: lk-mono, size: 9pt, fill: lk-primary, it),
  )
  show figure.caption: lk-caption(accent: accent)
  show outline.entry: it => { set text(font: lk-sans, fill: lk-body); if it.level == 1 { v(4pt) }; it }
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + lk-hair))
  show footnote.entry: it => { set text(font: lk-sans, size: 8.5pt, fill: lk-mut); it }

  // Title block
  lk-label(org, color: lk-mut); v(0.5em)
  box(width: 40pt, height: 6pt, fill: accent); v(0.8em)
  if doc-id != "" { lk-label(doc-id, color: accent); v(0.3em) }
  text(font: lk-sans, weight: 800, size: 30pt, fill: lk-primary)[#title]
  if subtitle != none { linebreak(); v(2pt); text(size: 15pt, weight: 500, fill: lk-mut)[#subtitle] }
  v(1.2em); lk-rule(stroke: 1pt + lk-primary); v(0.7em)
  grid(columns: (1fr, 1fr, 1fr), row-gutter: 12pt, ..meta.pairs().map(p => {
    box[#lk-label(p.first()) #v(3pt) #text(font: lk-sans, weight: 600, size: 11pt, fill: lk-primary)[#p.last()]]
  }))
  v(1.6em)

  body
}

// ── Editorial base (cream paper), foundation for article/letter/recipe ───────
#let lokta-doc(title: "", running: "", footer-mark: "光の写本", body) = {
  set page(paper: "a4", fill: lk-paper, margin: (x: 2.2cm, y: 2.4cm),
    header: context {
      if running != "" and counter(page).get().first() > 1 {
        grid(columns: (1fr, auto), lk-label(running), lk-label(title, color: lk-mut))
        v(3pt); lk-rule(stroke: 0.5pt + lk-paper4)
      }
    },
    footer: context grid(columns: (1fr, 1fr),
      text(font: lk-cjk, size: 9pt, fill: lk-primary, weight: 700)[#footer-mark],
      align(right, lk-label(counter(page).display("1")))))
  set text(font: lk-serif, size: 10.5pt, fill: lk-body)
  set par(justify: true, leading: 0.72em, spacing: 0.95em)
  show heading: it => text(font: lk-sans, weight: 700, fill: lk-primary, size: 14pt)[#it.body]
  body
}

// ── Editorial report (cream, warm counterpart to lokta-tech) ─────────────────
#let lokta-report(title: "", subtitle: none, org: "", meta: (:), accent: lk-aubergine, body) = {
  set page(paper: "a4", fill: lk-paper, margin: (x: 2.2cm, y: 2.4cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(columns: (1fr, 1fr), lk-label(org), align(right, lk-label(title, color: lk-mut)))
        v(4pt); lk-rule(stroke: 0.5pt + lk-paper4)
      }
    },
    footer: context {
      lk-rule(stroke: 0.5pt + lk-paper4); v(3pt)
      grid(columns: (1fr, auto),
        text(font: lk-cjk, size: 9pt, fill: lk-primary, weight: 700)[光の写本],
        align(right, lk-label(counter(page).display("01 / 1", both: true))))
    })
  set text(font: lk-sans, size: 10.5pt, fill: lk-body)
  set par(leading: 0.72em, spacing: 0.95em)
  set heading(numbering: "1.1")
  show heading: it => {
    v(if it.level == 1 { 1.3em } else { 0.9em })
    grid(columns: (auto, 1fr), column-gutter: 0.6em,
      text(font: lk-mono, fill: accent, size: if it.level == 1 { 13pt } else { 11pt })[
        #context { if it.numbering != none { counter(heading).display(it.numbering) } }],
      text(font: lk-sans, weight: if it.level == 1 { 700 } else { 600 },
        size: if it.level == 1 { 15pt } else { 12.5pt }, fill: lk-primary)[#it.body])
    v(0.3em)
  }
  show figure.caption: lk-caption(accent: accent)
  show outline.entry: it => { set text(font: lk-sans, fill: lk-body); if it.level == 1 { v(4pt) }; it }
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + lk-hair))
  show footnote.entry: it => { set text(font: lk-sans, size: 8.5pt, fill: lk-mut); it }
  // Title block
  lk-label(org, color: lk-mut); v(0.6em)
  text(font: lk-sans, weight: 800, size: 28pt, fill: lk-primary)[#title]
  if subtitle != none { linebreak(); v(2pt); text(font: lk-serif, style: "italic", size: 14pt, fill: lk-mut)[#subtitle] }
  v(1em); lk-measure(); v(0.8em)
  if meta.len() > 0 {
    grid(columns: (1fr, 1fr, 1fr), row-gutter: 10pt, ..meta.pairs().map(p =>
      box[#lk-label(p.first()) #v(3pt) #text(font: lk-sans, weight: 600, size: 11pt, fill: lk-primary)[#p.last()]]))
    v(1.4em)
  }
  body
}

// ── Article (cream, long-form editorial) ─────────────────────────────────────
#let lokta-article(title: "", deck: none, author: none, kicker: "Article", running: "Lokta", body) = {
  set page(paper: "a4", fill: lk-paper, margin: (x: 2.4cm, y: 2.4cm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(columns: (1fr, auto), lk-label(running), lk-label(title, color: lk-mut))
        v(3pt); lk-rule(stroke: 0.5pt + lk-paper4)
      }
    },
    footer: context align(right, lk-label(counter(page).display("1"))))
  set text(font: lk-serif, size: 10.5pt, fill: lk-body)
  set par(justify: true, leading: 0.74em, spacing: 0.95em, first-line-indent: 1.2em)
  show heading: it => { v(0.6em); text(font: lk-sans, weight: 700, size: 13pt, fill: lk-primary)[#it.body]; v(0.2em) }

  lk-label(kicker, color: lk-cinnabar); v(0.5em)
  par(first-line-indent: 0pt, text(font: lk-sans, weight: 800, size: 30pt, fill: lk-primary)[#title])
  if deck != none { v(4pt); par(first-line-indent: 0pt, text(font: lk-serif, style: "italic", size: 14pt, fill: lk-mut)[#deck]) }
  if author != none { v(6pt); lk-label("By " + author, color: lk-mut) }
  v(0.7em); lk-rule(stroke: 1pt + lk-primary); v(0.9em)
  body
}

// ── Bulletin (single-sheet notice, mono-forward) ─────────────────────────────
#let lokta-bulletin(title: "", meta: (:), accent: lk-marigold, body) = {
  set page(paper: "a4", fill: lk-paper0, margin: (x: 2.2cm, y: 2.2cm),
    footer: context grid(columns: (1fr, auto),
      lk-label("Bulletin"), align(right, lk-label(counter(page).display("01 / 1", both: true)))))
  set text(font: lk-sans, size: 10.5pt, fill: lk-body)
  set par(leading: 0.72em, spacing: 0.9em)
  show heading: it => { v(0.7em); lk-label(it.body, color: lk-mut); v(0.2em) }

  box(width: 100%, fill: accent, inset: (x: 14pt, y: 12pt))[
    #lk-label("Bulletin", color: lk-ink)
    #v(4pt)
    #text(font: lk-sans, weight: 800, size: 24pt, fill: lk-ink)[#title]
  ]
  v(0.7em)
  if meta.len() > 0 {
    grid(columns: meta.pairs().map(_ => 1fr), column-gutter: 12pt, ..meta.pairs().map(p =>
      box[#lk-label(p.first()) #v(2pt) #text(font: lk-mono, size: 10pt, fill: lk-primary)[#p.last()]]))
    v(4pt); lk-rule(stroke: 2pt + lk-primary); v(0.8em)
  }
  body
  v(1em); lk-endmark()
}

// ── Letter (cream, correspondence) ───────────────────────────────────────────
#let lokta-letter(sender: (), recipient: (), date: "", subject: none, sign: "", body) = {
  set page(paper: "a4", fill: lk-paper, margin: (x: 2.6cm, y: 2.6cm),
    footer: context align(center, lk-label(counter(page).display("1"))))
  set text(font: lk-serif, size: 10.5pt, fill: lk-body)
  set par(leading: 0.74em, spacing: 0.95em)

  grid(columns: (1fr, auto),
    stack(spacing: 2pt, ..sender.map(l => text(font: lk-sans, size: 9.5pt, fill: lk-primary)[#l])),
    align(right, lk-label(date)))
  v(0.6em); lk-rule(stroke: 1pt + lk-primary); v(1em)
  stack(spacing: 2pt, ..recipient.map(l => text(font: lk-sans, size: 10pt, fill: lk-body)[#l]))
  v(1em)
  if subject != none { text(font: lk-sans, weight: 700, fill: lk-primary)[#subject]; v(0.8em) }
  body
  v(1.4em)
  text(font: lk-sans, size: 10pt, fill: lk-primary)[#sign]
}

// ── Cover (pigment ground, vertical spine) ───────────────────────────────────
#let lokta-cover(
  title: "", subtitle: none, label: "Specimen", ground: lk-lavender, ink: lk-primary,
  spine: "光の写本", body,
) = {
  set page(paper: "a4", fill: ground, margin: 0pt,
    background: place(left + horizon, dx: 0.7cm,
      text(font: lk-cjk, size: 96pt, weight: 700, fill: lk-paper0.transparentize(20%))[#spine]))
  set text(font: lk-sans, fill: ink)
  block(inset: (x: 2.4cm, y: 2.6cm), width: 100%, height: 100%)[
    #lk-label(label, color: ink.transparentize(25%))
    #v(1fr)
    #text(weight: 800, size: 64pt, fill: ink)[#title]
    #if subtitle != none { v(8pt); text(font: lk-serif, style: "italic", size: 20pt, fill: ink.transparentize(10%))[#subtitle] }
    #v(18pt)
    #grid(columns: (180pt, 1fr, 56pt), align: horizon,
      line(length: 100%, stroke: 1.5pt + ink), [], lk-hatch(width: 100%, color: ink))
    #v(1fr)
    #body
  ]
}

// ── Recipe (cream, after the cookbook page) ──────────────────────────────────
#let lokta-recipe(
  title: "", film: none, note: none, meta: (), ingredients: (), steps: (), body,
) = lokta-doc(title: title, running: "Recipe")[
  #grid(columns: (1fr, auto), column-gutter: 24pt, align: top,
    if note != none {
      block(width: 100%)[
        #set text(font: lk-serif, style: "italic", size: 9.5pt, fill: lk-mut)
        #note
        #if film != none { v(4pt); lk-label("[" + film + "]", color: lk-faint) }
      ]
    } else { [] },
    align(right, stack(spacing: 4pt, ..meta.map(m => text(font: lk-sans, weight: 600, size: 10pt, fill: lk-primary)[#m]))))
  #v(8pt)
  #lk-measure()
  #v(10pt)
  #grid(columns: (200pt, 1fr), column-gutter: 24pt, align: top,
    grid(columns: (auto, 1fr), column-gutter: 8pt,
      rotate(-90deg, reflow: true, lk-label("Ingredients")),
      stack(spacing: 5pt, ..ingredients.map(i => text(font: lk-sans, size: 10pt, fill: lk-body)[• #i]))),
    align(right + horizon, text(font: lk-sans, weight: 800, size: 40pt, fill: lk-primary)[#title]))
  #v(10pt)
  #lk-measure()
  #v(12pt)
  #set text(font: lk-sans, size: 10.5pt, fill: lk-body)
  #enum(tight: false, ..steps)
  #body
]
