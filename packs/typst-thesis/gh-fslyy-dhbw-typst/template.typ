// LTeX: enabled=false
// Author: Felix Penn 
// In case of any questions, additions or bugs please visit https://github.com/fslyy/DHBW_Typst
// The Template was created with the Help of "Hinweise zur Anfertigung von Projekt- und Bachelorarbeiten 2.0"

#import "@preview/glossarium:0.5.9": (
  gls, glspl, make-glossary, print-glossary, register-glossary,
)
#import "@preview/hydra:0.6.2": hydra
#import "@preview/codly-languages:0.1.8": *
#import "@preview/codly:1.3.0": *
#import "@preview/drafting:0.2.2": *
#import "@preview/linguify:0.5.0": linguify, load-ftl-data

#let __lang-db = eval(load-ftl-data("./locales", ("en", "de")))
#let t(key, args: (:)) = context linguify(key, from: __lang-db, args: args)

//use caption_with_source("My Figure", [@source]) in captions
#let in-outline = state("in-outline", false)
#let caption_with_source(caption_text, source) = context {
  if in-outline.at(here()) { caption_text } else { [#caption_text — #source] }
}
// use caption_long("Short title", [Long description...]) f.
#let caption_long(short, long) = context {
  if in-outline.at(here()) { short } else { long }
}

// ── Setup function ─────────────────────────────────────────────────────────
#let project(
  lang: "en",
  confidentiality_clause: true,
  title_long: none,
  title_short: none,
  thesis_type: none,
  firstname: none,
  lastname: none,
  course: none,
  faculty: none,
  signature_place: none,
  program: none,
  submission_date: none,
  partner_company: none,
  supervisor_university: none,
  abstract: (),
  library_paths: (),
  citation_style: "ieee",
  acronyms: (),
  // ── Cover page: degree statement ────────────────────────────────────────
  degree: "Bachelor of Science (B. Sc.)",
  body,
) = {

  // ── Document metadata ────────────────────────────────────────────────────
  set document(title: title_long)
  set text(lang: lang)

  // ── Page layout ──────────────────────────────────────────────────────────
  set page(paper: "a4", margin: (top: 2.5cm, bottom: 2cm, left: 3.5cm, right: 2.5cm))

  // ── Typography ───────────────────────────────────────────────────────────
  set text(font: "Times New Roman", size: 12pt)
  set par(
    justify: true,
    leading: 1.5em,
    spacing: 1.5em + 6pt,
    justification-limits: (tracking: (min: -0.01em, max: 0.02em), )
  )

  // ── Headings ─────────────────────────────────────────────────────────────
  // in german the standard word for chapter is "Abschnitt".
  // If you prefer it to be referenced via "Kapiel" add 
  // `supplement: [Kapitel]` 
  // to your set heading command
  set heading(numbering: "1.")
  show heading: set text(font: "Times New Roman")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    set text(size: 16pt, weight: "bold")
    v(24pt, weak: true)
    it
    v(18pt)
  }
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    v(12pt)
    it
    v(9pt)
  }
  show heading.where(level: 3): it => {
    set text(size: 12pt)
    v(12pt)
    it
    v(9pt)
  }

  // ── Math equations ───────────────────────────────────────────────────────
  // Chapter-prefixed numbering: (1.1), (1.2), (2.1) …
  set math.equation(numbering: n => {
    let chapter = counter(heading.where(level: 1)).get().first()
    numbering("(1.1)", chapter, n)
  })

  // ── Footnotes ────────────────────────────────────────────────────────────
  set footnote.entry(separator: line(length: 40%, stroke: 0.5pt))
  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(leading: 1em)

  // ── Captions ─────────────────────────────────────────────────────────────
  show figure.caption: set text(size: 11pt)

  // ── Code ─────────────────────────────────────────────────────────────────

  // add a specific language of your choice by including a .sublime-syntax file into the /syntax directory and adding it to this list
  // it can the be referenced via ```language_name ```
  set raw(syntaxes: ("syntax/cds.sublime-syntax", "syntax/abap.sublime-syntax"))
  show raw.where(block: false): box.with(
    fill:    luma(240),
    inset:   (x: 2pt, y: 0pt),
    outset:  (y: 3pt),
    radius:  2pt,
  )
  show figure.where(kind: raw): set block(breakable: true)
  show: codly-init.with()
  codly(
    zebra-fill:    none,
    display-icon:  false,
    display-name:  false,
    number-align:  right + top,
  )

  // ── Glossary ─────────────────────────────────────────────────────────────
  show: make-glossary

  // ── Links ────────────────────────────────────────────────────────────────
  show link: it => {
    if type(it.dest) == str {
      set text(fill: gray.darken(80%))
      underline(
        stroke: (paint: gray, thickness: 0.5pt, dash: "densely-dashed"),
        offset: 4pt,
        it,
      )
    } else {
      it
    }
  }

  // ── Block quotes & margin notes ───────────────────────────────────────────
  set quote(block: true)
  set-margin-note-defaults(
    rect: rect.with(radius: 0.5em),
    fill: orange.lighten(80%),
  )

  // ── Content ────────────────────────────────────────────────────────────────

  // show notes first
  context {
    if query(selector(<margin-note>).or(<inline-note>)).len() > 0 {
      set heading(numbering: none, outlined: false)
      note-outline(title: t("list-of-notes"))
      pagebreak()
    }
  }

  // ── Cover page ───────────────────────────────────────────────────────────
  grid(
    rows:  (1fr, auto, 1fr),
    align: (_, row) => (center + top, center + top, center + bottom).at(row),

    grid(
      columns: (1fr, 1fr),
      // Replace with your Company Logo
      align(left)[#image("assets/SAP-Logo.svg",  height: 2.5cm)],
      align(right)[#image("assets/DHBW-Logo.svg", height: 2.5cm)],
    ),

    // Title block
    align(center)[
      #set par(justify: false)

      #text(20pt)[#faculty]

      #if program != none {
        text(14pt)[#program]
      }

      #v(25pt)

      #text(20pt)[*#title_long*]

      #smallcaps(text(1.25em, weight: "semibold")[#thesis_type])

      #t("degree-statement", args: (degree: degree))

      #v(25pt)

      #if (confidentiality_clause) {
        text(20pt, fill: red)[#t("confidentiality-notice")]
      }

      #text(20pt)[#submission_date]
    ],

    align(center)[
      #table(
        columns: 2,
        align: (left + top, left + top),
        stroke: none,
        [*#t("author"):*], [ #firstname #lastname ],
        [*#t("course"):*], [#course],
        [*#t("partner-company"):*], [#partner_company],
        [*#t("supervisor-university"):*], [#supervisor_university],
        [*#t("submission-date"):*], [#submission_date],
      )
  ],
  )
  pagebreak()

  // ── Confidentiality clause ─────────────────────────────────────────────
  if confidentiality_clause {
    import "assets/confidentiality_clause.typ": confidentialityClauseWith
    confidentialityClauseWith(lang: lang)
    pagebreak()
  }

  // ── Declaration of originality ────────────────────────────────────────
  {
    import "assets/declaration_of_originality.typ": declarationOfOriginalityWith
    declarationOfOriginalityWith(
      title_long:      title_long,
      firstname:       firstname,
      lastname:        lastname,
      signature_place: signature_place,
      type:            thesis_type,
    )
  }
  pagebreak()

  // ── Abstracts ────────────────────────────────────────────────────────────
  for a in abstract {
    let (abstract_lang, abstract_body) = a
      align(center, heading(outlined: false, numbering: none, [#text(
          0.85em,
          smallcaps[Abstract],
        ) ]))
      text(lang: abstract_lang, abstract_body)
      pagebreak()
  }

  // ── Frontmatter: Roman page numbering ────────────────────────────────────
  counter(page).update(1)
  set page(
    numbering: "I",
    footer: context {
      line(length: 100%, stroke: 0.6pt + black)
      v(-0.4cm)
      align(right)[#counter(page).display()]
    },
    footer-descent: 0.75cm,
  )

  // ── Table of contents ─────────────────────────────────────────────────────
  [#show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong(it)
    }
    #outline(
      title:  t("list-contents"),
      depth:  3,
      indent: auto,
      target: selector(heading).before(<__bibliography-end>),
    )
  ]

  // ── List of abbreviations ─────────────────────────────────────────────────
  if acronyms.len() > 0 {
    pagebreak()
    heading(outlined: true, numbering: none, t("list-abbreviations"))
    register-glossary(acronyms)
    print-glossary(acronyms, disable-back-references: true)
  }

  // ── Conditional front matter lists ───────────────────────────────────────
  // Suppress caption sources inside list entries (caption_with_source / caption_long)
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }
  context {
    // List of figures
    if query(figure.where(kind: image)).len() > 0 {
      pagebreak()
      heading(t("list-figures"), numbering: none)
      outline(target: figure.where(kind: image).before(<__appendix-start>), title: none)
    }
    // List of tables
    if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      heading(t("list-tables"), numbering: none)
      outline(target: figure.where(kind: table).before(<__appendix-start>), title: none)
    }
    // List of source code
    if query(figure.where(kind: raw)).len() > 0 {
      pagebreak()
      heading(t("list-code"), numbering: none)
      outline(target: figure.where(kind: raw).before(<__appendix-start>), title: none)
    }
  }

  // ── Main body: Arabic page numbering + running header ────────────────────
  set page(
    header: context {
      if here().page() > 1 {
        let h = {
          let h3 = hydra(3)
          let h2 = hydra(2)
          let h1 = hydra(1)
          if h3 != none { h3 } else if h2 != none { h2 } else { h1 }
        }
        set text(size: 10pt)
        set block(spacing: 4pt)
        grid(
          columns: (auto, 1fr),
          gutter: 8pt,
          title_short,
          align(right)[#h],
        )
        line(length: 100%)
      }
    },
    header-ascent: 1.25cm,
    numbering:     "1",
    footer: context {
      line(length: 100%, stroke: 0.6pt + black)
      v(-0.4cm)
      align(right)[#counter(page).display()]
    },
    footer-descent: 0.75cm,
  )
  counter(page).update(1)

  // ── Tables ───────────────────────────────────────────────────────────────
  // Here you can style the Tables for the Entirety of the thesis
  set table(
    stroke: (_, y) => if y == 0 {
      (top: 0.7pt + black, bottom: 0.7pt + black)
    } else { none },
    align: left,
  )
  show table: set par(leading: 0.6em)
  show table: it => block(stroke: (bottom: 0.7pt + black), inset: 0pt, it)
  show figure.where(kind: table): set figure.caption(position: top)

  [#[] <__thesis_start>]

  body

  [#[] <__thesis_end>]
  // Start of Appendix
  [#[] <__appendix-start>]

  set page(header: none)

  set heading(
    supplement: t("appendix"),
    numbering: (..nums) => {
      let n = nums.pos()
      if n.len() == 2      { numbering("A",    n.at(1)) }
      else if n.len() >= 3 { numbering("A.1.", n.at(1), ..n.slice(2)) }
    },
  )
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    set text(size: 14pt, weight: "bold")
    v(12pt, weak: true)
    it
    v(9pt)
  }
  counter(heading).update(0)

  heading(level: 1, numbering: none, outlined: true, t("appendix"))

  include "assets/appendix.typ"
  {
    import "assets/tool_declaration.typ": toolDeclarationWith
    toolDeclarationWith(lang: lang)
  }
  [#[] <__appendix-end>]

  bibliography(library_paths, title: t("list-bibliography"), style: citation_style)

  {
    import "assets/index_of_attachments.typ": indexOfAttachmentsWith
    indexOfAttachmentsWith(lang: lang)
  }

  [#[] <__bibliography-end>]
}