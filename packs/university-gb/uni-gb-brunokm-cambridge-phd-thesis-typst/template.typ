// Shared layout for the Typst edition.
#let appendix-mode = state("thesis-appendix", false)

#let chapter-number() = context numbering(
  if appendix-mode.get() { "A" } else { "1" },
  counter(heading).get().first(),
)

#let numbered-within-chapter(n) = context [#chapter-number().#n]

// References and lists must use the target's chapter, not the reader's location.
#let number-at(element) = context {
  let location = element.location()
  let chapter = counter(heading).at(location).first()
  let prefix = numbering(if appendix-mode.at(location) { "A" } else { "1" }, chapter)
  let item-counter = if element.func() == figure { element.counter } else { counter(math.equation) }
  [#prefix.#item-counter.at(location).first()]
}

#let prose-cite(key) = [#cite(key, form: "author", style: "apa")~#cite(key)]

#let chapter-break(two-sided: true) = {
  // This scope also clears the header/footer on an inserted verso page.
  set page(header: none, footer: none)
  pagebreak(weak: true, to: if two-sided { "odd" } else { none })
}

#let index-entry(key, body) = [
  #metadata(key) <thesis-index-entry>
  #body
]

#let print-index() = context {
  let entries = query(<thesis-index-entry>)
  let keys = entries.map(it => it.value).dedup().sorted()
  for key in keys {
    let occurrences = entries.filter(it => it.value == key)
    let pages = occurrences.map(it => counter(page).at(it.location()).first()).dedup()
    block[
      #key, #pages.map(n => {
        let occurrence = occurrences.find(it => counter(page).at(it.location()).first() == n)
        link(occurrence.location(), str(n))
      }).join([, ])
    ]
  }
}

#let subfigure(body, caption, letter, target, parent: <fig:examples>) = block[
  #metadata((parent: parent, letter: letter))#target
  #align(center, body)
  #v(0.4em)
  #align(center)[(#letter) #caption]
]

#let subfigure-ref(target) = context {
  let item = query(target).first()
  link(item.location())[#ref(item.value.parent, supplement: none)#item.value.letter]
}

#let running-header(two-sided: true) = context {
  let physical-page = here().page()
  let headings = query(heading).filter(it => it.location().page() <= physical-page)
  let chapters = headings.filter(it => it.level == 1)
  // Chapter openings suppress running headers.
  if chapters.len() > 0 and chapters.last().location().page() != physical-page {
    let chapter = chapters.last()
    let sections = headings.filter(it => it.level == 2 and it.numbering != none
      and it.location().page() >= chapter.location().page())
    let chapter-title = chapter.body
    let section-title = if sections.len() == 0 { chapter-title } else {
      let section = sections.last()
      [#numbering(section.numbering, ..counter(heading).at(section.location())) #section.body]
    }
    set text(size: 10pt)
    set par(leading: 0.4em, first-line-indent: 0pt)
    let number = strong(counter(page).display())
    if not two-sided or calc.odd(physical-page) {
      grid(columns: (1fr, auto), column-gutter: 1em, section-title, number)
    } else {
      grid(columns: (auto, 1fr), column-gutter: 1em, number, align(right, chapter-title))
    }
    v(2pt)
    line(length: 100%, stroke: 0.4pt)
  }
}

#let thesis(
  info,
  print: true,
  two-sided: true,
  font: "XCharter",
  font-size: 12pt,
  body,
) = {
  set document(
    title: info.pdf-title,
    author: info.author,
    description: info.subject,
    keywords: info.keywords,
  )
  set text(font: font, size: font-size, lang: "en", region: "GB")
  show math.equation: set text(font: "XCharter Math")
  set par(justify: true, leading: 0.8em, first-line-indent: 1.5em, spacing: 0.8em)
  set page(
    paper: "a4",
    margin: if print and two-sided {
      (inside: 30.625mm, outside: 25.625mm, y: 37.125mm)
    } else if print {
      (left: 30.625mm, right: 25.625mm, y: 37.125mm)
    } else { (x: 26.25mm, y: 37.125mm) },
    binding: left,
    numbering: "i",
    header: none,
    footer: none,
    header-ascent: 5mm,
  )
  set heading(numbering: "1.1.1", supplement: [Section])
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 4): set heading(numbering: none, outlined: false)
  show heading.where(level: 1): it => {
    chapter-break(two-sided: two-sided)
    if it.numbering != none {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      counter(footnote).update(0)
    }
    block(above: 0pt, below: 1.5em, sticky: true)[
      #set text(size: 24pt, weight: "bold")
      #set par(first-line-indent: 0pt, leading: 0.45em)
      #if it.numbering != none [
        #if appendix-mode.get() { [Appendix] } else { [Chapter] } #chapter-number() \
      ]
      #it.body
    ]
  }
  show heading.where(level: 2): set text(size: 17pt)
  show heading.where(level: 3): set text(size: 14pt)
  show heading.where(level: 4): set text(size: 12pt)
  show heading.where(level: 2): set block(above: 1.25em, below: 0.65em)
  show heading.where(level: 3): set block(above: 1em, below: 0.5em)
  set math.equation(numbering: n => [(#numbered-within-chapter(n))], supplement: [Equation])
  set figure(numbering: numbered-within-chapter, gap: 0.65em)
  show figure.where(kind: image): set figure(supplement: [Fig.])
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure.where(kind: table): set figure.caption(position: top)
  set figure.caption(separator: [ ])
  show figure.caption: set text(size: 11pt)
  show figure.caption: set par(leading: 0.35em, first-line-indent: 0pt)
  show ref: it => context {
    let element = it.element
    if element == none or it.form == "page" or not (figure, math.equation).contains(element.func()) {
      it
    } else {
      let supplement = if it.supplement == auto { element.supplement } else { it.supplement }
      if type(supplement) == function { supplement = supplement(element) }
      let number = if element.func() == math.equation { [(#number-at(element))] } else { number-at(element) }
      link(element.location(), if supplement != none and supplement != [] { supplement + [~] + number } else { number })
    }
  }
  set enum(numbering: "1.", indent: 1.5em, body-indent: 0.5em)
  set list(indent: 1.5em, body-indent: 0.5em)
  set raw(theme: none)
  show raw: set text(font: "DejaVu Sans Mono", size: 8.5pt)
  show raw.where(block: true): set block(above: 0.6em, below: 0.6em, breakable: false)
  show link: set text(fill: if print { black } else { rgb("174b91") })
  show outline: set par(first-line-indent: 0pt, leading: 0.4em, spacing: 0.6em)
  show outline.entry: it => context {
    let element = it.element
    let prefix = if element.func() == figure { number-at(element) } else { it.prefix() }
    link(element.location(), it.indented(prefix, [
      #it.body() #box(width: 1fr, it.fill) #it.page()
    ]))
  }
  body
}

#let title-page(info) = page(header: none, footer: none)[
  #set par(first-line-indent: 0pt, leading: 0.5em)
  #align(center)[
    #text(size: 24pt, weight: "bold", info.title)
    #v(0.4em)
    #text(size: 17pt, weight: "bold", info.subtitle)
    #v(1.2fr)
    #info.crest
    #v(0.8fr)
    #text(size: 18pt, weight: "bold", info.author)
    #v(1em)
    #if info.supervisor != none [#info.supervisor \ ]
    #if info.advisor != none [#info.advisor \ ]
    #info.university
    #v(1.1fr)
    #info.submission-text \
    #emph(info.degree)
  ]
  #v(1.4fr)
  #grid(columns: (1fr, auto), info.college, info.date)
]

#let front-section(title, two-sided: true, body) = {
  show heading.where(level: 1): it => {
    chapter-break(two-sided: two-sided)
    block(width: 100%, above: 0pt, below: 2em, sticky: true, align(center, text(size: 16pt, weight: "bold", it.body)))
  }
  heading(level: 1, numbering: none, outlined: false, bookmarked: true, title)
  body
}

#let notation(groups) = {
  heading(level: 1, numbering: none)[Notation]
  for group in groups {
    block(above: 1em, below: 0.65em, sticky: true, strong(group.title))
    table(
      columns: (42mm, 1fr),
      inset: (x: 0pt, y: 4pt),
      column-gutter: 3mm,
      stroke: none,
      align: left,
      ..group.entries.flatten(),
    )
  }
}
