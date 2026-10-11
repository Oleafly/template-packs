// ============================================================
// OUP Bioinformatics / Oxford Academic — Typst Template
// Matches the official OUP oup-authoring-template PDF exactly.
// ============================================================

// ── Colours ──────────────────────────────────────────────────
#let oup-gray  = rgb("#444444")
#let oup-lgray = rgb("#999999")

// ── Fonts ─────────────────────────────────────────────────────
#let body-font = ("Latin Modern Roman", "TeX Gyre Termes", "Linux Libertine", "Times New Roman")
#let sans-font = ("Latin Modern Sans", "TeX Gyre Heros", "Linux Biolinum", "Liberation Sans", "Arial")
#let mono-font = ("Latin Modern Mono", "TeX Gyre Cursor", "DejaVu Sans Mono", "Courier New")

// ── Shared counters ───────────────────────────────────────────
#let _thm-counter  = counter("oup-theorem")
#let _algo-counter = counter("oup-algorithm")

// ╔══════════════════════════════════════════════════════════════╗
// ║                    TEMPLATE FUNCTION                        ║
// ╚══════════════════════════════════════════════════════════════╝
#let oup-article(
  journal-title:        "Bioinformatics",
  doi:                  "10.1093/bioinformatics/XXXXXXX",
  pub-year:             "2025",
  volume:               none,
  issue:                none,
  pages:                none,           // e.g. "1–10"
  article-type:         "Paper",

  title:                [Article Title],
  short-title:          none,
  subtitle:             none,

  authors:              (),   // (name:, affil:(), orcid:none, corr:false)
  affiliations:         (),   // (id:, dept:none, org:, address:none)
  corr-author:          none, // content, e.g. [email-id.com]

  received:             none,
  revised:              none,
  accepted:             none,
  editor:               none,

  abstract:             none,
  abstract-structured:  none, // (Motivation:[…], Results:[…], …)
  keywords:             (),
  abbreviations:        (),

  additional-abstract:  none,
  graphical-abstract:   none, // pass true for grey placeholder, or image(…)
  key-messages:         none,

  bibliography-file:    none,
  bibliography-style:   "vancouver",

  biographies:          (),

  body,
) = {

  // ── document defaults ─────────────────────────────────────
  set document(title: title, author: authors.map(a => a.name))
  set text(font: body-font, size: 8.5pt, lang: "en", hyphenate: true)
  set par(justify: true, leading: 0.55em, spacing: 0.85em)
  set math.equation(numbering: "(1)")
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt + black),
    gap: 0.4em,
  )

  // ── heading styles ────────────────────────────────────────
  // All body headings: unnumbered, bold sans-serif
  // Level 1: centred (matches reference PDF)
  // Level 2: bold italic sans, left-aligned
  // Level 3: bold serif, left-aligned
  // Level 4: bold italic serif, left-aligned
  // Level 5: regular serif, left-aligned
  set heading(numbering: none)
  // LaTeX default style: all headings are SERIF, centered
  // Section:       11.5bp bold centered serif
  // Subsection:    10.5bp bold centered serif (NOT italic)
  // Subsubsection: 9.75bp bold-italic centered serif
  // Paragraph:     9.5bp  bold centered serif
  show heading.where(level: 1): it => block(
    above: 1.1em, below: 0.45em, width: 100%,
    align(center, text(font: body-font, size: 11.5pt, weight: "bold", it.body))
  )
  show heading.where(level: 2): it => block(
    above: 0.9em, below: 0.38em, width: 100%,
    align(center, text(font: body-font, size: 10.5pt, weight: "bold", it.body))
  )
  show heading.where(level: 3): it => block(
    above: 0.8em, below: 0.32em, width: 100%,
    align(center, text(font: body-font, size: 9.75pt, weight: "bold", style: "italic", it.body))
  )
  show heading.where(level: 4): it => block(
    above: 0.7em, below: 0.28em, width: 100%,
    align(center, text(font: body-font, size: 9.5pt, weight: "bold", it.body))
  )
  show heading.where(level: 5): it => block(
    above: 0.6em, below: 0.24em, width: 100%,
    align(center, text(font: body-font, size: 9.5pt, it.body))
  )

  // ── figure captions ───────────────────────────────────────
  show figure.caption: it => {
    set text(size: 8.5pt)
    set par(leading: 0.48em)
    context [*#it.supplement #it.counter.display(it.numbering)* #it.body]
  }

  // ── tables ────────────────────────────────────────────────
  set table(
    stroke: (_, y) => (
      top:    if y <= 1 { 0.7pt + black } else { 0pt },
      bottom: 0.7pt + black,
    ),
    fill: none,
    inset: (x: 5pt, y: 3.5pt),
  )
  show table.cell.where(y: 0): set text(weight: "bold", size: 8.5pt)
  show table: set text(size: 8.5pt)

  // ── code ──────────────────────────────────────────────────
  show raw: set text(font: mono-font, size: 8pt)
  show raw.where(block: true): it => block(
    fill: rgb("#F5F5F5"), inset: 8pt, radius: 2pt, width: 100%, it)

  show link: set text(fill: rgb("#004B87"))

  // ── running head helpers ──────────────────────────────────
  let hdr-center = {
    let parts = (journal-title, pub-year)
    if volume != none { parts.push("Volume " + volume) }
    if issue  != none { parts.push("Issue "  + issue)  }
    parts.join(", ")
  }

  // ── page geometry & headers/footers ──────────────────────
  set page(
    paper: "a4",
    margin: (top: 2.6cm, bottom: 2.5cm, left: 1.85cm, right: 1.85cm),

    header: context {
      let pg = here().page()
      if pg == 1 {
        // ── Page 1 header ──────────────────────────────────
        // Left: thin vertical grey bar + text block
        // Right: small solid grey rectangle
        // Structure from reference PDF:
        //   [thin bar][journal text lines] ............. [grey box]
        set text(size: 9pt, font: body-font)
        let left-line1 = {
          let parts = (journal-title, pub-year)
          if pages != none { parts.push("pp. " + pages) }
          parts.join(", ")
        }
        // LaTeX: thin vertical bar (1.5mm, black!50) + 7bp serif text + 55x20pt grey box
        pad(top: 8pt,
          grid(
            columns: (2pt, 1fr, auto),
            gutter: 0pt,
            // thin vertical grey bar — black!50 = rgb(128,128,128)
            rect(width: 2pt, height: 100%, fill: rgb("#808080")),
            // text block: journal info + DOI + published (7bp serif)
            pad(left: 4pt, {
              set text(size: 7pt, font: body-font)
              [#text(style: "italic")[#left-line1] \ ]
              [DOI added during production \ ]
              [Published: Date added during production \ ]
              v(1pt)
              text(weight: "bold", size: 7pt, article-type)
            }),
            // grey box: 55pt wide x 20pt tall, black!20 ≈ rgb(204,204,204)
            align(top + right,
              rect(width: 55pt, height: 20pt, fill: rgb("#CCCCCC"))
            ),
          )
        )
      } else if calc.even(pg) {
        // Even: bold-page  italic-journal  then rule below  (LaTeX: sffamilyfontbold + sffamilyfontitalic)
        set text(size: 8pt, font: sans-font)
        [#text(weight: "bold")[#str(pg)]#h(6pt)#text(style: "italic")[#hdr-center]]
        v(3pt)
        line(length: 100%, stroke: 0.5pt)
      } else {
        // Odd (>1): italic-journal  bold-page  then rule below
        set text(size: 8pt, font: sans-font)
        [#text(style: "italic")[#hdr-center]#h(1fr)#text(weight: "bold")[#str(pg)]]
        v(3pt)
        line(length: 100%, stroke: 0.5pt)
      }
    },
    header-ascent: 38%,

    footer: context {
      let pg = here().page()
      set text(size: 6.25pt, font: body-font, fill: black)
      if pg == 1 {
        // Separator line above footer
        line(length: 100%, stroke: 0.5pt + black)
        v(2pt)
        // Dates with bold labels on one line
        let dp = ()
        if received != none { dp.push([*Received:* #received]) }
        if revised  != none { dp.push([*Revised received:* #revised]) }
        if accepted != none { dp.push([*Accepted:* #accepted]) }
        if dp.len() > 0 {
          dp.join([. ])
          linebreak()
        }
        [#sym.copyright The Author(s) #pub-year. Copyright and licence statements to be updated by the publisher during production.]
      }
    },
    footer-descent: 30%,
  )

  // ════════════════════════════════════════════════════════════
  // TITLE BLOCK  (single-column, full-width)
  // ════════════════════════════════════════════════════════════

  // Space below the header (the header block already shows "Paper")
  v(18pt)

  // ── Title — centred, large bold sans ─────────────────────
  if subtitle != none {
    align(center, text(size: 10pt, font: sans-font, style: "italic", subtitle))
    v(3pt)
  }
  // LaTeX default: 18bp/20pt bold serif, centered
  align(center,
    text(size: 18pt, font: body-font, weight: "bold",
      par(leading: 0.75em, justify: false, title)))
  v(10pt)

  // ── Authors — centred ─────────────────────────────────────
  align(center, {
    set text(size: 11pt, font: body-font)
    let entries = authors.map(a => {
      let sups = a.at("affil", default: ()).map(str)
      if a.at("corr", default: false) { sups.push("∗") }
      let badge = if a.at("orcid", default: none) != none {
        h(1pt)
        link("https://orcid.org/" + a.orcid,
          box(fill: rgb("#A6CE39"), radius: 2pt,
            inset: (x: 2pt, y: 0.5pt),
            text(size: 5.5pt, fill: white, weight: "bold", "iD")))
      } else { [] }
      [#a.name,#super[#sups.join(",")]#badge]
    })
    // Join with space; insert "and " before last entry
    if entries.len() > 1 {
      entries.slice(0, -1).join([ ]) + [ and ] + entries.last()
    } else if entries.len() == 1 {
      entries.first()
    }
  })
  v(8pt)

  // ── Affiliations — centred, small ────────────────────────
  align(center, {
    set text(size: 9pt, font: body-font)
    set par(leading: 0.52em, justify: false)
    for af in affiliations {
      super(str(af.id))
      if af.at("dept", default: none) != none { af.dept + ", " }
      af.org
      if af.at("address", default: none) != none { ", " + af.address }
      linebreak()
    }
  })
  v(5pt)

  // ── Corresponding author — centred ───────────────────────
  if corr-author != none {
    align(center,
      text(size: 7pt, font: body-font, [*Corresponding author.* #corr-author]))
    v(4pt)
  }

  // ── Dotted rule ───────────────────────────────────────────
  // OUP uses a dotted/dashed separator line between corr-author and Abstract
  line(length: 100%, stroke: (paint: rgb("#AAAAAA"), dash: "dotted", thickness: 0.6pt))
  v(6pt)

  // ── Abstract section — centred heading, bold body, justified ─
  // LaTeX default: 11.5bp bold centered serif
  align(center, text(size: 11.5pt, font: body-font, weight: "bold", "Abstract"))
  v(4pt)
  {
    set text(size: 9.75pt, font: body-font, weight: "bold")
    set par(leading: 0.56em, justify: true)
    if abstract-structured != none {
      for (lbl, txt) in abstract-structured.pairs() [
        #lbl #txt
        #parbreak()
      ]
    } else if abstract != none {
      abstract
    }
  }
  v(5pt)

  // ── Keywords ──────────────────────────────────────────────
  if keywords.len() > 0 {
    text(size: 9.75pt, font: body-font, [*Keywords* #keywords.join(", ")])
    linebreak()
  }

  // ── Abbreviations ─────────────────────────────────────────
  if abbreviations.len() > 0 {
    text(size: 9.75pt, font: body-font, [*Abbreviations* #abbreviations.join(", ")])
    linebreak()
  }
  v(4pt)

  // ── Additional Abstract ───────────────────────────────────
  // Centred bold heading, then bold justified body
  if additional-abstract != none {
    align(center, text(size: 11.5pt, font: body-font, weight: "bold",
      "Additional Abstract"))
    v(4pt)
    {
      set text(size: 9.5pt, weight: "bold")
      set par(justify: true, leading: 0.56em)
      additional-abstract
    }
    v(6pt)
  }

  // ── Graphical Abstract ────────────────────────────────────
  // Centred bold heading, then content or grey placeholder rectangle
  if graphical-abstract != none {
    align(center, text(size: 11.5pt, font: body-font, weight: "bold",
      "Graphical Abstract"))
    v(5pt)
    if graphical-abstract == true {
      rect(width: 100%, height: 85pt, fill: rgb("#C8C8C8"))
    } else {
      graphical-abstract
    }
    v(6pt)
  }

  // ── Key Messages — stroked box ───────────────────────────
  if key-messages != none {
    block(
      width: 100%,
      stroke: 0.7pt + black,
      inset: (x: 10pt, y: 8pt),
    )[
      #text(size: 9.5pt, weight: "bold")[Key Messages]
      #v(3pt)
      #set text(size: 9.5pt, weight: "regular")
      #key-messages
    ]
    v(5pt)
  }

  // ── dotted rule before two-column body ───────────────────
  line(length: 100%, stroke: (paint: rgb("#AAAAAA"), dash: "dotted", thickness: 0.6pt))
  v(6pt)

  // ════════════════════════════════════════════════════════════
  // TWO-COLUMN BODY
  // ════════════════════════════════════════════════════════════
  // LaTeX default columnsep = 18pt
  columns(2, gutter: 18pt, {
    body

    if bibliography-file != none {
      set bibliography(style: bibliography-style, title: "References")
      show bibliography: set text(size: 8.5pt)
      bibliography(bibliography-file)
    }

    if biographies.len() > 0 {
      for bio in biographies {
        let has-img = bio.at("image", default: none) != none
        block(above: 0.8em,
          grid(
            columns: if has-img { (55pt, 1fr) } else { (1fr,) },
            column-gutter: 6pt,
            ..if has-img {
              (image(bio.image, width: 55pt, height: 55pt, fit: "cover"),)
            } else { () },
            [#set text(size: 8.5pt); *#bio.name* #bio.bio]
          )
        )
      }
    }
  })
}


// ╔══════════════════════════════════════════════════════════════╗
// ║              CONVENIENCE HELPER FUNCTIONS                   ║
// ╚══════════════════════════════════════════════════════════════╝

// ── Appendix ─────────────────────────────────────────────────
#let appendix(body) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  show heading.where(level: 1): it => block(
    above: 1.1em, below: 0.45em, width: 100%,
    align(center, text(
      font: ("TeX Gyre Heros","Linux Biolinum","Liberation Sans","Arial"),
      size: 9.5pt, weight: "bold",
      context "Appendix " + counter(heading).display("A") + " " + it.body
    ))
  )
  body
}

// ── Wide (full-width) figure ──────────────────────────────────
#let wide-figure(caption: none, body) = figure(
  placement: top, scope: "parent", caption: caption, body)

// ── Theorem environments ──────────────────────────────────────
#let _thm(kind, body, subhead: none, italic: true) = {
  _thm-counter.step()
  block(above: 0.8em, below: 0.5em, width: 100%)[
    #set text(size: 9.5pt)
    #context strong(kind + " " + _thm-counter.display())
    #if subhead != none [ (#subhead)]
    #h(0.4em)
    #if italic { text(style: "italic", body) } else { body }
  ]
}

#let theorem(body, subhead: none)     = _thm("Theorem",    body, subhead: subhead, italic: true)
#let proposition(body, subhead: none) = _thm("Proposition",body, subhead: subhead, italic: true)
#let example(body, subhead: none)     = _thm("Example",    body, subhead: subhead, italic: false)
#let remark(body, subhead: none)      = _thm("Remark",     body, subhead: subhead, italic: false)
#let definition(body, subhead: none)  = _thm("Definition", body, subhead: subhead, italic: false)

#let proof(body, of: none) = block(above: 0.6em, below: 0.8em, width: 100%)[
  #set text(size: 9.5pt)
  #if of != none { emph[Proof of #of] } else { emph[Proof] }
  #h(0.4em)#body #h(1fr) $square$
]

// ── Algorithm ─────────────────────────────────────────────────
#let algorithm(caption: none, body) = {
  _algo-counter.step()
  block(width: 100%, above: 0.9em, below: 0.9em,
    stroke: (top: 0.7pt, bottom: 0.7pt),
    inset: (x: 8pt, y: 6pt),
  )[
    #set text(size: 9pt)
    #context strong("Algorithm " + _algo-counter.display())
    #if caption != none [ #caption]
    #line(length: 100%, stroke: 0.5pt)
    #set text(font: ("TeX Gyre Cursor","DejaVu Sans Mono","Courier New"), size: 8.5pt)
    #body
  ]
}

// ── Table with footnotes ──────────────────────────────────────
#let table-with-notes(caption: none, notes: (), ..args) = figure(
  caption: caption, supplement: "Table",
  block[
    #table(..args)
    #if notes.len() > 0 {
      set text(size: 8pt)
      set par(leading: 0.42em)
      v(2pt)
      for n in notes [#n \ ]
    }
  ]
)

// ── Block quote ───────────────────────────────────────────────
#let block-quote(body) = pad(left: 1.5em, right: 1em,
  text(size: 9.5pt, style: "italic", body))

// ── Back-matter sections ──────────────────────────────────────
#let _back(title, body) = [= #title
#body]

#let competing-interests(body)  = _back("Conflicts of interest", body)
#let author-contributions(body) = _back("Author contributions statement", body)
#let acknowledgements(body)     = _back("Acknowledgments", body)
#let funding(body)              = _back("Funding", body)
#let data-availability(body)    = _back("Data availability", body)
