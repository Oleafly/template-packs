// ============================================================
// OUP Authoring Template for Typst
// Faithfully matches oup-authoring-template.cls v1.2 (2025)
// Contemporary | modern | traditional
// ============================================================

#let oup-blue      = rgb("#002147")
#let oup-rule-grey = rgb("#999999")

#let _jt  = state("jt",  "Journal Title Here")
#let _doi = state("doi", "DOI added during production")
#let _yr  = state("yr",  "YEAR")
#let _vol = state("vol", "XX")
#let _iss = state("iss", "x")
#let _apn = state("apn", "Paper")
#let _acc = state("acc", "Published: Date added during production")

#let _run-header(style) = context {
  let pg      = counter(page).get().first()
  let run     = [#emph[#_jt.get()], #_yr.get(), Vol. #_vol.get(), Issue #_iss.get()]
  let is-even = calc.rem(pg, 2) == 0
  if pg < 2 { return }
  set text(size: 8pt, font: ("Helvetica Neue","Arial","Liberation Sans"))
  stack(dir: ttb, spacing: 5pt,
    if is-even {
      grid(columns: (auto, 1fr),
        align(left,  [#text(weight: "bold")[#pg] #h(6pt)#sym.bullet#h(6pt)]),
        align(right, run))
    } else {
      grid(columns: (1fr, auto),
        align(left,  run),
        align(right, [#h(6pt)#sym.bullet#h(6pt)#text(weight: "bold")[#pg]]))
    },
    line(length: 100%, stroke: 0.5pt + oup-rule-grey)
  )
}

#let _open-header = context {
  grid(columns: (1fr, 45pt), gutter: 8pt,
    align(left)[
      #set text(size: 6.5pt, fill: rgb("#333333"),
                font: ("Helvetica Neue","Arial","Liberation Sans"))
      #emph[#_jt.get()], #_yr.get(), Vol. #_vol.get(), Issue #_iss.get() \
      #_doi.get() \
      #_acc.get() \
      #text(weight: "bold")[#_apn.get()]
    ],
    rect(width: 45pt, height: 55pt, fill: rgb("#4daef9"), stroke: none)
  )
}

// Theorem environments — OUP plain style (no boxes, no colours)
#let _thm = counter("thm")

#let _thm-plain(label, name, body) = {
  _thm.step()
  v(4pt)
  par(hanging-indent: 0pt)[
    #text(weight: "bold")[#label #context _thm.display()#if name != none { [ (#name)] }]
    #h(4pt)
    #text(style: "italic")[#body]
  ]
  v(4pt)
}

#let _thm-roman(label, name, body) = {
  _thm.step()
  v(4pt)
  par(hanging-indent: 0pt)[
    #text(weight: "bold")[#label #context _thm.display()#if name != none { [ (#name)] }]
    #h(4pt)
    #body
  ]
  v(4pt)
}

#let theorem(body,     name: none) = _thm-plain("Theorem",     name, body)
#let proposition(body, name: none) = _thm-plain("Proposition", name, body)
#let lemma(body,       name: none) = _thm-plain("Lemma",       name, body)
#let corollary(body,   name: none) = _thm-plain("Corollary",   name, body)
#let definition(body,  name: none) = _thm-plain("Definition",  name, body)
#let example(body,     name: none) = _thm-roman("Example",     name, body)
#let remark(body,      name: none) = _thm-roman("Remark",      name, body)

#let proof(body, name: none) = {
  v(4pt)
  par(hanging-indent: 0pt)[
    #text(style: "italic", weight: "bold")[Proof#if name != none { [ of #name] }.]
    #h(4pt)
    #body
    #h(1fr) $square$
  ]
  v(4pt)
}

#let blockquote(body) = block(
  inset: (left: 1.5em, top: 3pt, bottom: 3pt),
  text(style: "italic", body)
)

// OUP boxtext — numbered, ruled border, grey title bar
#let _box-counter = counter("boxtext")
#let boxtext(title, body) = {
  _box-counter.step()
  v(4pt)
  block(width: 100%, stroke: 0.5pt + rgb("#555555"), radius: 2pt, clip: true)[
    #block(width: 100%, fill: rgb("#e8e8e8"), inset: (x: 8pt, y: 5pt))[
      #set text(weight: "bold", size: 8pt)
      Box #context _box-counter.display(). #title
    ]
    #block(width: 100%, inset: 8pt)[
      #set text(size: 8pt)
      #body
    ]
  ]
  v(4pt)
}

// Key Messages — simple ruled box
#let key-messages(body) = block(
  width: 100%,
  stroke: 0.6pt + rgb("#555555"),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
)[
  #text(weight: "bold", size: 8.5pt)[Key Messages]
  #v(4pt)
  #set text(size: 8pt)
  #body
]

#let algorithm(title, body) = block(
  width: 100%, stroke: 0.5pt + rgb("#555555"), inset: 8pt, radius: 2pt,
)[
  #text(weight: "bold", size: 8pt)[#title]
  #line(length: 100%, stroke: 0.4pt + rgb("#aaaaaa"))
  #v(3pt)
  #set text(size: 8pt)
  #body
]

#let tablenotes(body) = {
  v(6pt)
  text(size: 7.5pt, body)
}

#let biography(author-image, body) = {
  v(4pt)
  grid(
    columns: if author-image != none { (auto, 1fr) } else { (1fr,) },
    gutter: 8pt,
    ..if author-image != none { (author-image,) } else { () },
    text(size: 8pt, body)
  )
  v(4pt)
}

// ── Main template ─────────────────────────────────────────────
#let oup-template(
  journal-title:        "Journal Title Here",
  doi:                  "DOI added during production",
  copyright-year:       "YEAR",
  pub-year:             "YEAR",
  vol:                  "XX",
  issue:                "x",
  access:               "Published: Date added during production",
  app-notes:            "Paper",
  first-page:           "1",
  title:                [Article Title],
  short-title:          none,
  authors:              (),
  affiliations:         (),
  corresponding:        none,
  received:             none,
  revised:              none,
  accepted:             none,
  abstract:             [],
  keywords:             (),
  abbreviations:        (),
  other-abstracts:      (),
  key-messages-content: none,
  show-toc:             true,
  style:                "contemporary",
  body
) = {
  _jt.update(journal-title)
  _doi.update(doi)
  _yr.update(pub-year)
  _vol.update(vol)
  _iss.update(issue)
  _apn.update(app-notes)
  _acc.update(access)

  let sans  = ("Helvetica Neue", "Arial", "Liberation Sans")
  let serif = ("Linux Libertine", "Times New Roman", "Georgia")
  let body-font = if style == "traditional" { serif } else { sans }
  let body-size = if style == "contemporary" { 8pt } else { 9pt }

  set text(font: body-font, size: body-size, lang: "en")
  set par(justify: true, leading: 0.65em, spacing: 1.6em)
  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")

  // Level 1: BOLD UPPERCASE, no number shown (OUP unnumsec mode)
  show heading.where(level: 1): it => {
    v(1.2em, weak: true)
    block(link(<oup-toc>, text(size: 14pt, weight: "bold", fill: oup-blue, it.body)))
    v(0.6em, weak: true)
  }
  show heading.where(level: 2): it => {
    v(1em, weak: true)
    block(link(<oup-toc>, text(size: 12pt, weight: "bold", it.body)))
    v(0.5em, weak: true)
  }
  show heading.where(level: 3): it => {
    v(1em, weak: true)
    block(link(<oup-toc>, text(size: 11pt, weight: "bold", it.body)))
    v(0.4em, weak: true)
  }
  show heading.where(level: 4): it => {
    v(0.8em, weak: true)
    link(<oup-toc>, text(size: 10pt, weight: "bold", it.body + [.]))
    h(4pt)
  }

  // Figure captions — left-aligned, period after number
  set figure.caption(separator: [. ])
  show figure.caption: it => {
    set align(left)
    text(size: 8pt)[
      #text(weight: "bold")[#it.supplement #it.counter.display().]
      #it.body
    ]
  }
  set figure(gap: 10pt)
  // Tables: caption above, left-aligned
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set align(left)
  set table(stroke: none, inset: (x: 5pt, y: 4pt))
  show table.cell.where(y: 0): set text(weight: "bold")
  show raw.where(block: true): it => block(
    fill: rgb("#f5f5f5"), stroke: 0.4pt + oup-rule-grey,
    inset: 8pt, radius: 2pt, width: 100%,
    text(size: 7.5pt, font: ("DejaVu Sans Mono", "Courier New"), it)
  )
  show link: set text(fill: oup-blue)

  // ── Title page (single column) ──────────────────────────────
  set page(
    width: 210mm, height: 276mm,
    margin: (top: 25mm, bottom: 20mm, left: 18mm, right: 18mm),
    columns: 1,
    header: _open-header,
    header-ascent: 7mm,
  )

  v(14mm)
  line(length: 100%, stroke: 1.5pt + oup-blue)
  v(6pt)

  text(
    size: if style == "traditional" { 24pt } else if style == "modern" { 36pt } else { 36pt },
    weight: "bold", fill: oup-blue, title
  )
  if short-title != none {
    v(2pt)
    text(size: 24pt, fill: rgb("#555555"), short-title)
  }
  v(8pt)

  {
    let parts = authors.map(a => {
      let ar = a.at("affil", default: ())
      let aa = if type(ar) == str { (ar,) } else { ar }
      let sup = aa.map(n => super[#n]).join()
      let orc = if a.at("orcid", default: none) != none { super[○] } else { [] }
      [*#a.name*#sup#orc]
    })
    text(size: 9pt, parts.join([, ]))
  }
  v(5pt)

  for aff in affiliations {
    text(size: 7.5pt, fill: rgb("#444444"))[#super[#aff.num]#aff.text \ ]
  }

  if corresponding != none {
    v(3pt)
    text(size: 7.5pt)[
      #super[#corresponding.mark]Corresponding author: #link("mailto:" + corresponding.email)[#corresponding.email]
    ]
  }
  v(4pt)
  {
    let parts = ()
    if received != none { parts.push("Received: " + received) }
    if revised  != none { parts.push("Revised: "  + revised) }
    if accepted != none { parts.push("Accepted: " + accepted) }
    if parts.len() > 0 { text(size: 7.5pt, fill: rgb("#666666"), parts.join(" | ")) }
  }

  v(8pt)
  line(length: 100%, stroke: 0.5pt + oup-rule-grey)
  v(6pt)

  // Abstract — plain text, no box (matching OUP original)
  {
    set text(size: 8pt)
    text(weight: "bold", size: 14pt)[Abstract]
    v(3pt)
    abstract
    if keywords.len() > 0 {
      v(4pt)
      [#text(weight: "bold")[Keywords ] #keywords.join(", ")]
    }
    if abbreviations.len() > 0 {
      v(2pt)
      [#text(weight: "bold")[Abbreviations ] #abbreviations.join(", ")]
    }
  }

  // Other abstracts — plain, no extra border
  for oa in other-abstracts {
    v(6pt)
    set text(size: 8pt)
    text(weight: "bold", size: 14pt)[#oa.title]
    v(3pt)
    oa.content
  }

  if key-messages-content != none {
    v(6pt)
    key-messages(key-messages-content)
  }

  // TOC — separate page
  if show-toc {
    pagebreak()
    [#metadata("toc") <oup-toc>]
    v(4pt)
    line(length: 100%, stroke: 0.4pt + oup-rule-grey)
    v(4pt)
    set text(size: 7.5pt)
    outline(title: none, depth: 3, indent: 1.2em)
    v(4pt)
    line(length: 100%, stroke: 0.4pt + oup-rule-grey)
  }

  // ── Body (two-column) ───────────────────────────────────────
  set page(
    columns: 2,
    header: _run-header(style),
    header-ascent: 7mm,
    margin: (top: 22mm, bottom: 20mm, left: 18mm, right: 18mm),
  )
  body
}
