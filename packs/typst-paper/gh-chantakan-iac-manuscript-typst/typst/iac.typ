#import "fonts.typ": apply-fonts

// Text extraction for the abstract's whitespace-delimited word count.
#let manuscript-text(value) = {
  if type(value) == str { value }
  else if type(value) == content {
    if value.has("text") { value.text }
    else if value.has("children") { value.children.map(manuscript-text).join() }
    else if value.has("body") { manuscript-text(value.body) }
    else if value.func() == linebreak or value.func() == parbreak { " " }
    else { "" }
  } else { "" }
}
#let unnumbered(title) = heading(numbering: none, title)
#let manuscript(
  paper-code: "IAC-26-REPLACE",
  title: [],
  authors: (),
  affiliations: (),
  copyright: [],
  corresponding-note: auto,
  abstract: [],
  keywords: (),
  heading-spacing: 11.50pt,
  keep-heading: true,
  body,
) = {
  let abstract-words = manuscript-text(abstract).split(regex("\\s+")).filter(w => w != "").len()
  assert(abstract-words <= 400, message: "IAC: abstract exceeds 400 whitespace-delimited words")
  assert(keywords.len() <= 6, message: "IAC: at most six keywords")
  assert(authors.len() > 0, message: "Add at least one author")
  set document(title: title, author: authors.map(a => a.name))
  show: apply-fonts
  // Word LTSC reference PDF: 11.50pt nominal ordinary baseline interval at nominal 10pt.
  // PDF intervals alternate around 11.50pt (mostly 11.52pt, sometimes 11.40pt).
  // Explicit line extents keep the open-font fallback on the same baseline grid.
  set text(top-edge: 0.933em, bottom-edge: -0.217em,
    hyphenate: false, overhang: false, kerning: false, ligatures: false)
  set super(typographic: false, size: 0.65em, baseline: -0.348em)
  set page(
    paper: "us-letter", margin: 70.85pt,
    header-ascent: 16.898pt, footer-descent: 24.08pt,
    header: align(center, text(8pt, top-edge: 7.488pt, bottom-edge: -1.752pt)[
      77#super[th] International Astronautical Congress (IAC 2026), Antalya, Türkiye, 5-9 Oct 2026.\
      #copyright
    ]),
    footer: context pad(x: 35.45pt, text(10pt, grid(columns: (1fr, 1fr),
      align(left, paper-code),
      align(right)[Page #counter(page).display("1 of 1", both: true)],
    ))),
  )
  set par(linebreaks: "simple", justify: true, first-line-indent: (amount: 14.2pt, all: true),
    leading: 0pt, spacing: 0pt)
  set heading(numbering: "1.1.1", outlined: true)
  show heading: it => block(above: heading-spacing, below: 0pt, sticky: keep-heading)[
    #set par(first-line-indent: 0pt)
    // Bold and italic retain the ordinary baseline interval.
    #set text(size: 10pt, weight: if it.level == 1 { "bold" } else { "regular" },
      style: if it.level == 1 { "normal" } else { "italic" })
    #if it.numbering != none {
      context {
        let number = counter(heading).display(if it.level == 1 { "1." } else { "1.1.1" })
        let natural-indent = measure(number).width + 2.5pt
        let indent = if it.level == 1 { calc.max(14.2pt, natural-indent) } else { natural-indent }
        let prefix = number + h(indent - measure(number).width)
        block(inset: (left: indent), above: 0pt, below: 0pt)[#h(-indent)#prefix#it.body]
      }
    } else { it.body }
  ]
  set math.equation(numbering: "(1)", supplement: [Eq.])
  // Equation labels must not inherit the body paragraph's Word-style depth.
  show math.equation: set text(top-edge: "cap-height", bottom-edge: "baseline")
  show math.equation.where(block: true): set block(above: 11.50pt, below: 11.50pt)
  set figure(gap: 0pt)
  set figure.caption(separator: [. ])
  show figure.where(kind: image): set figure(supplement: [Fig.])
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set align(left)
  show figure.caption: it => {
    set par(first-line-indent: 0pt, justify: false)
    it
  }
  // The source uses one ordinary blank paragraph around figures and tables.
  show figure: set block(above: 11.50pt, below: 11.50pt)
  set table(inset: (x: 5.4pt, y: 0pt), stroke: none)
  set list(indent: 12pt, body-indent: 5pt, spacing: 3pt)
  set enum(indent: 12pt, body-indent: 5pt, spacing: 3pt)
  set footnote.entry(indent: 9pt)
  show footnote.entry: set text(size: 8pt)
  show quote: set par(first-line-indent: 0pt)
  show bibliography: it => {
    set par(first-line-indent: 0pt, spacing: 0pt)
    // Typst 0.14 uses a 1.5em block inset and a matching negative h for CSL hanging indents.
    show block: item => {
      if type(item.inset) == dictionary and item.inset.at("left", default: none) == 1.5em {
        let fields = item.fields()
        fields.inset = (left: 14.2pt)
        let content = fields.remove("body")
        block(content, ..fields)
      } else { item }
    }
    show h.where(amount: -1.5em): h(-14.2pt)
    show regex("[0-9]+–[0-9]+"): it => box(text(top-edge: "cap-height", bottom-edge: "baseline", it))
    it
  }
  {
    set par(first-line-indent: 0pt, justify: false)
    // The DOCX centers these three paragraphs with a 14.2pt first-line indent.
    let front-center(value) = pad(left: 14.2pt, align(center, value))
    front-center(paper-code)
    v(11.50pt)
    front-center(strong(title))
    v(11.50pt)
    front-center(authors.map(a => strong(a.name) + strong(super(a.affiliation))
      + if a.at("corresponding", default: false) { [\*] } else { [] }).join(strong(", ")))
    v(11.50pt)
    for a in affiliations {
      [#super(a.id) #emph(a.text)#linebreak()]
    }
    v(11.50pt)
    if corresponding-note != auto { corresponding-note }
    else { for a in authors.filter(a => a.at("corresponding", default: false)) {
      [\* Corresponding author: #link("mailto:" + a.email)[#a.email]#linebreak()]
    }
    }
    v(11.50pt)
    align(center, strong[Abstract])
  }
  abstract
  if keywords.len() > 0 {
    block[
      #set par(first-line-indent: 0pt)
      *Keywords:* #keywords.join(", ")
    ]
  }
  v(11.50pt)
  metadata((kind: "iac-manuscript", abstract-words: abstract-words, keywords: keywords.len()))
  columns(2, gutter: 16.75pt, body)
}

// Keep table body and remarks together; the figure supplies its title above.
#let manuscript-table(body, caption: [], note: [], ..options) = figure(
  block(breakable: false)[
    #set par(first-line-indent: 0pt, justify: false)
    #set block(above: 0pt, below: 0pt)
    #body
    #if note != [] { v(3pt); note }
  ], kind: table, supplement: [Table], caption: caption, ..options,
)
