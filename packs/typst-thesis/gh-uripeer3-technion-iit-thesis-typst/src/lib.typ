// Typst port of the Technion IIT thesis layout workflow.
// Hebrew Abstract is generated in the Hebrew segment and reversed by build.py.
// The public entrypoint is `technion-thesis.with(...)`.

#let _field(data, key, default: "") = data.at(key, default: default)
#let _en(data, default: "") = _field(data, "english", default: default)
#let _he(data, default: "") = _field(data, "hebrew", default: default)
#let _is-after-defense(defense) = defense == "after" or defense == "post"
#let _is-empty(value) = value == "" or value == none
#let _appendix-mode = state("technion-thesis-appendix-mode", false)
#let theorem-counter = counter("technion-thesis-theorem")
#let statement-counter = counter("technion-thesis-statement")

#let degree-text(degree, discipline: (:)) = {
  let disc-en = _en(discipline, default: "Discipline Name")
  let disc-he = _he(discipline, default: "שם התחום המדעי")
  if degree == "phd" or degree == "PhD" {
    (english: "Doctor of Philosophy", hebrew: "דוקטור לפילוסופיה")
  } else if degree == "msc" or degree == "MSc" {
    (english: "Master of Science in " + disc-en, hebrew: "מגיסטר למדעים ב" + disc-he)
  } else if degree == "march" or degree == "MArch" {
    (english: "Master of Architecture", hebrew: "מגיסטר לארכיטקטורה")
  } else if degree == "mecon" or degree == "MEcon" {
    (english: "Master of Economics", hebrew: "מגיסטר לכלכלה")
  } else if degree == "me" or degree == "ME" {
    (english: "Master of Engineering", hebrew: "מגיסטר להנדסה")
  } else {
    panic("Unsupported Technion thesis degree: " + str(degree))
  }
}

#let page-margins(draft: false) = if draft {
  (inside: 2.5cm, outside: 2.5cm, top: 2.5cm, bottom: 2.5cm)
} else {
  (inside: 4cm, outside: 2.5cm, top: 2.5cm, bottom: 2.5cm)
}

#let thesis-page-setup(binding: left, draft: false, numbering: none, number-align: bottom + center) = {
  set page(
    paper: "a4",
    binding: binding,
    margin: page-margins(draft: draft),
    numbering: numbering,
    number-align: number-align,
    header: none,
  )
}

#let base-text-setup(lang: "en", dir: ltr) = {
  set text(
    lang: lang,
    dir: dir,
    size: 11pt,
    font: ("New Computer Modern", "Noto Sans Hebrew", "David CLM", "Times New Roman", "Arial"),
    fallback: true,
  )
  set par(justify: true, leading: 0.65em, first-line-indent: 1.5em)
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  show heading.where(level: 1): set block(above: 1.2em, below: 0.8em)
  show figure.where(kind: "algorithm"): set figure.caption(position: top, separator: [ ])
  show figure.caption.where(kind: "algorithm"): it => block(width: 100%, above: 0pt, below: 0pt)[
    #line(length: 100%, stroke: 0.6pt)
    #block(width: 100%, inset: (top: 0.12em, bottom: 0.12em), above: 1pt, below: 1pt)[
      #strong[#it.supplement #context it.counter.display(it.numbering)] #h(0.35em) #it.body
    ]
    #line(length: 100%, stroke: 0.35pt)
  ]
}

#let _title-block(title, size: 24pt) = [
  #text(size, weight: "bold")[#title]
]

#let english-cover(title, author) = [
  #thesis-page-setup(binding: left, numbering: none)
  #align(center)[
    #v(1fr)
    #_title-block(title)
    #v(1fr)
    #hide[Research Thesis]
    #v(0.5fr)
    #hide[
      Submitted in partial fulfillment of the requirements \
      for the degree
    ]
    #v(2fr)
    #text(18pt, weight: "bold")[#author]
    #v(3fr)
    #hide[
      Submitted to the Senate \
      of the Technion -- Israel Institute of Technology
    ]
  ]
]

#let english-title(title, author, degree, dates) = [
  #align(center)[
    #v(1fr)
    #_title-block(title)
    #v(1fr)
    #text(14pt)[Research Thesis]
    #v(0.5fr)
    #box(width: 4in)[
      #align(center)[
        Submitted in partial fulfillment of the requirements \
        for the degree of #degree
      ]
    ]
    #v(2fr)
    #text(18pt, weight: "bold")[#author]
    #v(3fr)
    #box(width: 3.5in)[
      #align(center)[
        Submitted to the Senate \
        of the Technion -- Israel Institute of Technology \
        #_field(dates, "jewish-english") #h(1cm) Haifa #h(1cm) #_field(dates, "gregorian-english")
      ]
    ]
  ]
]

#let acknowledgement-page(
  supervision,
  publication-info,
  ethics-statement,
  personal,
  financial,
  include-personal: true,
  ethics: false,
  title: [Acknowledgements],
) = [
  #set par(first-line-indent: 0pt)
  #supervision
  #if not _is-empty(publication-info) [
    #v(0.8em)
    #publication-info
  ]
  #if ethics and not _is-empty(ethics-statement) [
    #v(0.8em)
    #ethics-statement
  ]
  #if include-personal [
    #v(1em)
    #align(center)[#text(16pt, weight: "bold")[#title]]
    #personal
    #v(2fr)
  ] else [
    #v(1fr)
  ]
  #financial
]

#let abstract-page(title, body) = [
  #heading(level: 1, numbering: none, outlined: true)[#title]
  #body
]

#let _outline-entry(it, above, below, weight: "regular", fill: true) = block(
  above: above,
  below: below,
  inset: (y: 0.04em),
)[
  #set text(weight: weight)
  #let inner = if fill {
    it.inner()
  } else {
    [#it.body() #h(1fr) #it.page()]
  }
  #link(it.element.location(), it.indented(it.prefix(), inner))
]

#let technion-outline() = [
  #set par(first-line-indent: 0pt)
  #v(4em)
  #text(28pt, weight: "bold")[Contents]
  #v(2.4em)
  #show outline.entry.where(level: 1): it => _outline-entry(
    it,
    0.72em,
    0.18em,
    weight: "bold",
    fill: false,
  )
  #show outline.entry.where(level: 2): it => _outline-entry(
    it,
    0.28em,
    0.08em,
  )
  #show outline.entry.where(level: 3): it => _outline-entry(
    it,
    0.22em,
    0.06em,
  )
  #outline(title: none, indent: level => if level == 0 { 0em } else { level * 1.45em })
]

#let list-of-figures() = context {
  let figures = query(figure.where(kind: image))
  if figures.len() > 0 [
    #heading(level: 1, numbering: none, outlined: true)[List of Figures]
    #set par(first-line-indent: 0pt)
    #for fig in figures {
      let loc = fig.location()
      let chapter = counter(heading).at(loc).at(0)
      let figure-number = counter(figure.where(kind: image)).at(loc).at(0)
      let figure-label = if _appendix-mode.at(loc) {
        numbering("A.1", chapter, figure-number)
      } else {
        numbering("1.1", chapter, figure-number)
      }
      let caption = if fig.caption == none { [] } else { fig.caption.body }
      let page-number = counter(page).at(loc).first()
      block[
        #link(loc)[#figure-label #caption] #h(1fr) #page-number
      ]
    }
  ]
}

#let notation-and-abbreviations(entries, include-unused-abbreviations: false) = {
  let visible = if include-unused-abbreviations {
    entries
  } else {
    entries.filter(item => item.at("used", default: true))
  }
  [
    #heading(level: 1, numbering: none, outlined: true)[Notation and Abbreviations]
    #if visible.len() == 0 [
      No notation or abbreviations were supplied.
    ] else [
      #table(
        columns: (3cm, 1fr, 2.5cm),
        inset: 4pt,
        stroke: none,
        ..visible.map(item => (
          strong(item.at("symbol", default: "")),
          item.at("description", default: ""),
          item.at("pages", default: ""),
        )).flatten(),
      )
    ]
  ]
}

#let bibliography-entry-for(entries, key) = {
  let matches = entries.filter(entry => entry.at("key", default: "") == key)
  if matches.len() > 0 { matches.at(0) } else { none }
}

#let alpha-cite(entries, it) = {
  let entry = bibliography-entry-for(entries, str(it.key))
  if entry == none {
    it
  } else {
    let label = entry.at("label", default: str(it.key))
    [#text("[")#label#if it.supplement != none [, #it.supplement]#text("]")]
  }
}

#let alpha-bibliography-section(sources, entries, style) = [
  #if sources.len() > 0 [
    #let bibliography-style = if style == "alphanumeric" { "ieee" } else { style }
    // Typst's built-in alphanumeric CSL is citation-only; IEEE supplies the bibliography body.
    #hide[#bibliography(sources, title: [Bibliography], style: bibliography-style)]
  ]
  #v(2.8cm)
  #pad(left: 1.5cm)[
    #text(22pt, weight: "bold")[Bibliography]
    #parbreak()
    #v(0.5em)
    #for entry in entries [
      #block(above: 0.42em, below: 0.42em)[
        #grid(
          columns: (5.7em, 1fr),
          column-gutter: 0.45em,
          align: (left, left),
          [#text("[")#entry.at("label", default: "")#text("]")],
          entry.at("body", default: []),
        )
      ]
    ]
  ]
]

#let bibliography-section(sources, style, entries: ()) = [
  #if style == "alphanumeric" and entries.len() > 0 [
    #alpha-bibliography-section(sources, entries, style)
  ] else if sources.len() > 0 [
    #let bibliography-style = if style == "alphanumeric" { "ieee" } else { style }
    // Typst's built-in alphanumeric CSL is citation-only; IEEE supplies the bibliography body.
    #bibliography(sources, title: [Bibliography], style: bibliography-style)
  ]
]

#let hebrew-cover(title, author) = [
  #thesis-page-setup(binding: right, numbering: none)
  #base-text-setup(lang: "he", dir: rtl)
  #align(center)[
    #v(1fr)
    #_title-block(title)
    #v(1fr)
    #hide[חיבור על מחקר]
    #v(0.5fr)
    #hide[לשם מילוי חלקי של הדרישות לקבלת התואר]
    #v(2fr)
    #text(18pt, weight: "bold")[#author]
    #v(3fr)
    #hide[מוגש לסנט הטכניון -- מכון טכנולוגי לישראל]
  ]
]

#let hebrew-title(title, author, degree, dates) = [
  #align(center)[
    #v(1fr)
    #_title-block(title)
    #v(1fr)
    #text(14pt)[חיבור על מחקר]
    #v(0.5fr)
    #box(width: 3.5in)[
      #align(center)[
        לשם מילוי חלקי של הדרישות לקבלת התואר \
        #degree
      ]
    ]
    #v(2fr)
    #text(18pt, weight: "bold")[#author]
    #v(3fr)
    #box(width: 4in)[
      #align(center)[
        הוגש לסנט הטכניון -- מכון טכנולוגי לישראל \
        #_field(dates, "jewish-hebrew") #h(0.75cm) חיפה #h(0.75cm) #_field(dates, "gregorian-hebrew")
      ]
    ]
  ]
]

#let hebrew-abstract(body) = [
  #set page(numbering: "i", number-align: bottom + center)
  #set par(first-line-indent: 0pt, leading: 0.65em, justify: true)
  #heading(level: 1, numbering: none, outlined: true)[תקציר]
  #body
]

#let english-segment(
  degree: "phd",
  defense: "after",
  draft: false,
  ethics: false,
  abbreviations: true,
  include-unused-abbreviations: false,
  metadata: (:),
  abstracts: (:),
  abbreviations-list: (),
  bibliography-sources: (),
  bibliography-style: "alphanumeric",
  bibliography-entries: (),
  body,
) = {
  let title = _field(metadata, "title", default: (:))
  let author = _field(metadata, "author", default: (:))
  let dates = _field(metadata, "dates", default: (:))
  let discipline = _field(metadata, "discipline", default: (:))
  let degree-label = degree-text(degree, discipline: discipline)
  let include-personal = _is-after-defense(defense)
  [
    #thesis-page-setup(binding: left, draft: draft, numbering: none)
    #base-text-setup(lang: "en", dir: ltr)
    #set cite(style: bibliography-style)
    #show cite: it => {
      if bibliography-style == "alphanumeric" and bibliography-entries.len() > 0 {
        alpha-cite(bibliography-entries, it)
      } else {
        it
      }
    }
    #set document(title: _en(title, default: "Thesis Title"), author: _en(author, default: "Name of Author"))
    #english-cover(_en(title, default: "Thesis Title"), _en(author, default: "Name of Author"))
    #pagebreak(to: "odd", weak: true)
    #english-title(_en(title, default: "Thesis Title"), _en(author, default: "Name of Author"), _en(degree-label), dates)
    #pagebreak(to: "odd", weak: true)
    #acknowledgement-page(
      _en(_field(metadata, "supervision", default: (:))),
      _en(_field(metadata, "publication-info", default: (:))),
      _en(_field(metadata, "ethics-statement", default: (:))),
      _en(_field(metadata, "acknowledgements", default: (:))),
      _en(_field(metadata, "financial-acknowledgement", default: (:))),
      include-personal: include-personal,
      ethics: ethics,
    )
    #pagebreak(to: "odd", weak: true)
    #set page(numbering: none)
    #technion-outline()
    #pagebreak(to: "odd", weak: true)
    #list-of-figures()
    #pagebreak(to: "odd", weak: true)
    #counter(page).update(1)
    #set page(numbering: "1", number-align: bottom + center)
    #abstract-page([Abstract], _en(abstracts))
    #pagebreak(to: "odd", weak: true)
    #if abbreviations [
      #notation-and-abbreviations(
        abbreviations-list,
        include-unused-abbreviations: include-unused-abbreviations,
      )
      #pagebreak(to: "odd", weak: true)
    ]
    #set heading(numbering: "1.1")
    #show heading.where(level: 1): it => [
      #pagebreak(to: "odd", weak: true)
      #counter(figure.where(kind: image)).update(0)
      #counter(figure.where(kind: "algorithm")).update(0)
      #theorem-counter.update(0)
      #statement-counter.update(0)
      #_appendix-mode.update(it.numbering == "A.1")
      #block(above: 1.2em, below: 0.8em)[
        #if it.numbering == "A.1" [
          #text(16pt, weight: "bold")[Appendix #counter(heading).display("A")]
        ] else if it.numbering != none [
          #text(16pt, weight: "bold")[Chapter #counter(heading).display("1")]
        ]
        #parbreak()
        #text(22pt, weight: "bold")[#it.body]
      ]
    ]
    #show heading.where(level: 2): it => [
      #statement-counter.update(0)
      #block(above: 1em, below: 0.65em)[
        #if it.numbering != none [
          #text(16pt, weight: "bold")[#counter(heading).display() #h(0.6em) #it.body]
        ] else [
          #text(16pt, weight: "bold")[#it.body]
        ]
      ]
    ]
    #set figure(numbering: n => context numbering("1.1", counter(heading).get().at(0), n))
    #set math.equation(numbering: n => context numbering("(1.1)", counter(heading).get().at(0), n))
    #body
    #pagebreak(to: "odd", weak: true)
    #bibliography-section(bibliography-sources, bibliography-style, entries: bibliography-entries)
  ]
}

#let hebrew-segment(
  degree: "phd",
  defense: "after",
  draft: false,
  ethics: false,
  metadata: (:),
  abstracts: (:),
) = {
  let title = _field(metadata, "title", default: (:))
  let author = _field(metadata, "author", default: (:))
  let dates = _field(metadata, "dates", default: (:))
  let discipline = _field(metadata, "discipline", default: (:))
  let degree-label = degree-text(degree, discipline: discipline)
  let include-personal = _is-after-defense(defense)
  [
    #thesis-page-setup(binding: right, draft: draft, numbering: none)
    #base-text-setup(lang: "he", dir: rtl)
    #hebrew-cover(_he(title, default: "כותרת החיבור"), _he(author, default: "שם המחבר"))
    #pagebreak(to: "odd", weak: true)
    #hebrew-title(_he(title, default: "כותרת החיבור"), _he(author, default: "שם המחבר"), _he(degree-label), dates)
    #pagebreak(to: "odd", weak: true)
    #acknowledgement-page(
      _he(_field(metadata, "supervision", default: (:))),
      _he(_field(metadata, "publication-info", default: (:))),
      _he(_field(metadata, "ethics-statement", default: (:))),
      _he(_field(metadata, "acknowledgements", default: (:))),
      _he(_field(metadata, "financial-acknowledgement", default: (:))),
      include-personal: include-personal,
      ethics: ethics,
      title: [תודות],
    )
    #pagebreak(to: "odd", weak: true)
    #hebrew-abstract(_he(abstracts))
    #pagebreak(to: "odd")
    #hide[.]
  ]
}

#let _theorem-number() = context {
  let heading-numbers = counter(heading).get()
  let chapter = heading-numbers.at(0)
  let theorem = theorem-counter.get().first()
  if _appendix-mode.get() {
    numbering("A.1", chapter, theorem)
  } else {
    numbering("1.1", chapter, theorem)
  }
}

#let _statement-number() = context {
  let heading-numbers = counter(heading).get()
  let chapter = heading-numbers.at(0)
  let section = if heading-numbers.len() > 1 { heading-numbers.at(1) } else { 0 }
  let statement = statement-counter.get().first()
  if _appendix-mode.get() {
    numbering("A.1.1", chapter, section, statement)
  } else {
    numbering("1.1.1", chapter, section, statement)
  }
}

#let _statement-label(name, number: none, title: none, emph-label: false) = {
  let label = if number == none {
    if title == none {
      [#name.]
    } else {
      [#name #title.]
    }
  } else if title == none {
    [#name #number.]
  } else {
    [#name #number (#title).]
  }
  if emph-label {
    emph(label)
  } else {
    strong(label)
  }
}

#let _statement-block(name, body, number, title: none, emph-body: true) = block(
  above: 0.75em,
  below: 0.75em,
)[
  #set par(first-line-indent: 0pt)
  #_statement-label(name, number: number, title: title)
  #h(0.35em)
  #if emph-body {
    emph(body)
  } else {
    body
  }
]

#let theorem(title: none, numbered: true, body) = {
  if numbered {
    [
      #theorem-counter.step()
      #_statement-block([Theorem], body, _theorem-number(), title: title)
    ]
  } else {
    _statement-block([Theorem], body, none, title: title)
  }
}

#let corollary(title: none, numbered: true, body) = {
  if numbered {
    [
      #theorem-counter.step()
      #_statement-block([Corollary], body, _theorem-number(), title: title)
    ]
  } else {
    _statement-block([Corollary], body, none, title: title)
  }
}

#let lemma(title: none, numbered: true, body) = {
  if numbered {
    [
      #statement-counter.step()
      #_statement-block([Lemma], body, _statement-number(), title: title)
    ]
  } else {
    _statement-block([Lemma], body, none, title: title)
  }
}

#let proposition(title: none, numbered: true, body) = {
  if numbered {
    [
      #statement-counter.step()
      #_statement-block([Proposition], body, _statement-number(), title: title)
    ]
  } else {
    _statement-block([Proposition], body, none, title: title)
  }
}

#let definition(title: none, numbered: true, body) = {
  if numbered {
    [
      #statement-counter.step()
      #_statement-block([Definition], body, _statement-number(), title: title, emph-body: false)
    ]
  } else {
    _statement-block([Definition], body, none, title: title, emph-body: false)
  }
}

#let observation(title: none, numbered: true, body) = {
  if numbered {
    [
      #statement-counter.step()
      #_statement-block([Observation], body, _statement-number(), title: title, emph-body: false)
    ]
  } else {
    _statement-block([Observation], body, none, title: title, emph-body: false)
  }
}

#let note(title: [Note], body) = block(above: 0.75em, below: 0.75em)[
  #set par(first-line-indent: 0pt)
  #emph[#title.] #body
]

#let proof(title: [Proof], body) = block(above: 0.75em, below: 0.75em)[
  #set par(first-line-indent: 0pt)
  #emph[#title] #body #h(1fr) ■
]

#let proofof(target, body) = proof(title: [Proof of #target], body)

#let _algorithm-number() = context {
  let heading-numbers = counter(heading).get()
  let chapter = heading-numbers.at(0)
  let algorithm-number = counter(figure.where(kind: "algorithm")).get().first()
  numbering("1.1", chapter, algorithm-number)
}

#let algorithm-line(number, body) = {
  let label = str(number) + ":"
  block(width: 100%, above: 0pt, below: 0.1em)[
    #box(width: 1.5em)[#align(right)[#label]]
    #h(0.5em)
    #body
  ]
}

#let algorithm(caption: none, body) = figure(
  block(width: 100%)[
    #set align(left)
    #line(length: 100%, stroke: 0.6pt)
    #block(above: 1pt, below: 1pt)[
      #align(left)[
        #strong[Algorithm #_algorithm-number()]
        #if caption != none [
          #h(0.35em)
          #caption
        ]
      ]
    ]
    #line(length: 100%, stroke: 0.35pt)
    #block(width: 100%, inset: (left: 0.2cm, top: 0.25em, bottom: 0.25em))[
      #align(left)[#body]
    ]
    #line(length: 100%, stroke: 0.6pt)
  ],
  caption: none,
  gap: 0pt,
  kind: "algorithm",
  numbering: n => context numbering("1.1", counter(heading).get().at(0), n),
  supplement: [Algorithm],
)

#let technion-thesis(
  degree: "phd",
  defense: "after",
  draft: false,
  ethics: false,
  abbreviations: true,
  include-unused-abbreviations: false,
  metadata: (:),
  abstracts: (:),
  abbreviations-list: (),
  bibliography-sources: (),
  bibliography-style: "alphanumeric",
  bibliography-entries: (),
  segment: "all",
  body,
) = {
  if segment == "english" [
    #english-segment(
      degree: degree,
      defense: defense,
      draft: draft,
      ethics: ethics,
      abbreviations: abbreviations,
      include-unused-abbreviations: include-unused-abbreviations,
      metadata: metadata,
      abstracts: abstracts,
      abbreviations-list: abbreviations-list,
      bibliography-sources: bibliography-sources,
      bibliography-style: bibliography-style,
      bibliography-entries: bibliography-entries,
      body,
    )
  ] else if segment == "hebrew" [
    #hebrew-segment(
      degree: degree,
      defense: defense,
      draft: draft,
      ethics: ethics,
      metadata: metadata,
      abstracts: abstracts,
    )
  ] else [
    #english-segment(
      degree: degree,
      defense: defense,
      draft: draft,
      ethics: ethics,
      abbreviations: abbreviations,
      include-unused-abbreviations: include-unused-abbreviations,
      metadata: metadata,
      abstracts: abstracts,
      abbreviations-list: abbreviations-list,
      bibliography-sources: bibliography-sources,
      bibliography-style: bibliography-style,
      bibliography-entries: bibliography-entries,
      body,
    )
    #pagebreak(to: "odd", weak: true)
    #hebrew-segment(
      degree: degree,
      defense: defense,
      draft: draft,
      ethics: ethics,
      metadata: metadata,
      abstracts: abstracts,
    )
  ]
}
