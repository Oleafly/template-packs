// © 2025 Vanessa Alves & Marco Schnider
// Mitwirkende: Jannis Tschan, Georgiy Shevoroshkin

#import "@preview/codelst:2.0.2": sourcecode
#import "../meta.typ": meta

// Regular text size
#let text-size = 10pt

// Heading sizes
#let heading-size-depth-1-first = 22pt
#let heading-size-depth-1-second = 20pt
#let heading-size-depth-2 = 18pt
#let heading-size-depth-3 = 16pt
#let heading-size-depth-4 = 14pt
#let heading-size-depth-5 = 12pt

#let heading-weight = 600
#let heading-top-edge = 3mm
#let heading-bottom-edge = -3mm

// Custom colors dictionary
#let colors = (
  white: rgb("#ffffff"),
  black: rgb("#191919"),
  primary: rgb("#8C195F"),
  secondary: rgb("#D72864"),
  table: rgb("#ffe4ee"),
  link-background: rgb("#fff7fa"),
  link-underline: rgb("#d62863"),
  light-green: green.lighten(40%),
  light-red: red.lighten(40%),
  light-blue: blue.lighten(40%),
  light-orange: orange.lighten(40%),
  light-purple: purple.lighten(40%),
  light-grey: luma(230),
  mint-green: rgb(225, 255, 184),
)

#let light-green-cell(name) = table.cell(fill: colors.light-green, name)
#let light-red-cell(name) = table.cell(fill: colors.light-red, name)
#let light-blue-cell(name) = table.cell(fill: colors.light-blue, name)
#let light-orange-cell(name) = table.cell(fill: colors.light-orange, name)
#let light-purple-cell(name) = table.cell(fill: colors.light-purple, name)

// Provide words in German and English
#let languages = (
  de: (
    figure-table: "Tab.",
    figure-image: "Abb.",
    figure-code: "Listing",
    print: "Ausdruck",
    team: "Team / Autoren",
    advisor: "Referent",
    co-advisor: "Koreferent",
    counter-reader: "Gegenleser",
    _and: "und",
    toc: "Inhaltsverzeichnis",
    protocol: "Sitzungsprotokolle",
  ),
  en: (
    figure-table: "Tab.",
    figure-image: "Figure",
    figure-code: "Listing",
    print: "Print",
    team: "Team / Authors",
    advisor: "Advisor",
    co-advisor: "Co-advisor",
    counter-reader: "Counter reader",
    _and: "and",
    toc: "Table of contents",
    protocol: "Minutes of proceedings",
  ),
)


#let curlang = state("curlang", "de")
// Template based on LaTeX Article Class
#let article(
  lang: "de",
  eq-numbering: none,
  text-size: text-size,
  page-numbering: none,
  page-numbering-align: center,
  heading-numbering: "1.1  ",
  body,
) = {
  curlang.update(lang)
  // Document's basic properties
  set page(
    margin: (left: 20mm, right: 15mm, top: 25mm, bottom: 15mm),
    numbering: page-numbering,
    number-align: page-numbering-align,
    foreground: context [
      #place(
        top + right,
        dx: -15mm,
        dy: 6mm,
        meta.top-right-logo,
      )
    ],
  )

  set text(font: ("Calibri", "Libertinus Serif"), lang: lang, size: text-size)

  set math.equation(numbering: eq-numbering)
  show math.equation: set text(weight: 400)

  set heading(numbering: (..ns) => {
    let ns = ns.pos()
    if ns.len() == 1 {
      return numbering("I", ..ns)
    } else {
      ns.remove(0)
      return numbering("1.1", ..ns)
    }
  })

  show heading.where(level: 1): it => {
    let level1-selector = selector(heading).before(here())
    let level1-counter = counter(level1-selector)

    // Continue level 2 counter in new main chapter
    let level2-selector = selector(heading.where(level: 2)).before(here())
    let level2-counter = counter(level2-selector)
    let current-outline-num = level2-counter.final()
    current-outline-num.at(0) = level1-counter.final()
    counter(heading).update(current-outline-num.flatten())

    text(
      heading-size-depth-1-second,
      weight: heading-weight,
      bottom-edge: heading-bottom-edge,
      [ Kapitel #level1-counter.display("I")\ ],
    )
    text(
      heading-size-depth-1-first,
      weight: heading-weight,
      bottom-edge: -10mm,
      it.body,
    )
  }
  show heading.where(level: 2): set text(
    heading-size-depth-2,
    weight: heading-weight,
    top-edge: heading-top-edge,
    bottom-edge: heading-bottom-edge,
  )
  show heading.where(level: 3): set text(
    heading-size-depth-3,
    weight: heading-weight,
    top-edge: heading-top-edge,
    bottom-edge: heading-bottom-edge,
  )
  show heading.where(level: 4): set text(
    heading-size-depth-4,
    weight: heading-weight,
    top-edge: heading-top-edge,
    bottom-edge: heading-bottom-edge,
  )
  show heading.where(level: 5): set text(
    heading-size-depth-5,
    weight: heading-weight,
    top-edge: heading-top-edge,
    bottom-edge: 0mm,
  )

  set outline(
    indent: auto,
  )
  show outline.entry.where(level: 1): it => {
    v(20pt, weak: true)
    text(size: heading-size-depth-5, bottom-edge: -1mm, strong(it))
  }

  // Referencing Figures, set the supplement for the corresponding language
  show figure.where(kind: table): set figure(
    supplement: languages.at(lang).figure-table,
  )
  show figure.where(kind: image): set figure(
    supplement: languages.at(lang).figure-image,
  )
  show figure.where(kind: raw): set figure(
    supplement: languages.at(lang).figure-code,
  )

  // Table style
  set table(
    stroke: black,
    gutter: auto,
    fill: none,
    inset: (right: 1.5em),
  )

  // Configure figures (tables)
  show figure.where(kind: table): it => {
    set align(center)
    v(heading-size-depth-5, weak: true)
    it.body
    if it.has("caption") {
      v(if it.has("gap") { it.gap } else { 16pt }, weak: true)
      strong(it.supplement)
      if it.numbering != none {
        [ ]
        strong(it.counter.display(it.numbering))
      }
      [*: *]
      it.caption.body
    }
    v(14pt, weak: true)
  }

  // Configure figures (images)
  show figure.where(kind: image): it => {
    show: pad.with(x: 24pt)
    set align(center)
    v(heading-size-depth-5, weak: true)
    it.body
    if it.has("caption") {
      v(if it.has("gap") { it.gap } else { 16pt }, weak: true)
      strong(it.supplement)
      if it.numbering != none {
        [ ]
        strong(it.counter.display(it.numbering))
      }
      [*: *]
      it.caption.body
    }
    v(14pt, weak: true)
  }

  // Configure code (raw)
  show figure.where(kind: raw): it => {
    show: pad.with(x: 24pt)
    set align(center)
    v(heading-size-depth-5, weak: true)
    block(
      radius: 4pt,
      fill: luma(250),
      stroke: luma(230),
      inset: (
        x: 1em,
        y: 1em,
      ),
      it.body,
    )
    if it.has("caption") {
      v(if it.has("gap") { it.gap } else { 16pt }, weak: true)
      strong(it.supplement)
      if it.numbering != none {
        [ ]
        strong(it.counter.display(it.numbering))
      }
      [*: *]
      it.caption.body
    }
    v(14pt, weak: true)
  }

  show link: it => {
    highlight(
      [
        #set text(weight: 500)
        #underline(offset: 0.7mm, stroke: colors.link-underline, it)
      ],
      fill: colors.link-background,
    )
  }

  show ref: it => {
    highlight(
      [
        #set text(weight: 500)
        #underline(offset: 0.7mm, stroke: colors.link-underline, it)
      ],
      fill: colors.link-background,
    )
  }

  // Main body
  set par(justify: true)
  body
}

#let authors-text = meta.authors.join(
  " " + context languages.at(curlang.get())._and + " ",
)

#let maketitle() = {
  let (
    title,
    subtitle,
    date,
    git-hash,
    authors,
    advisor,
    co-advisor,
    gegenleser,
    background,
    overlay,
  ) = meta
  set document(author: authors, title: title)
  place(top + left, dx: -35mm, dy: 5mm, background)
  place(top + left, dx: -20mm, dy: -40mm, overlay)

  place(bottom + right, dy: 0mm, table(
    stroke: none,
    align: left,
    columns: 50%,
    text(weight: heading-weight, heading-size-depth-1-first, title),
    text(heading-size-depth-3, subtitle),
    v(0.5em),

    text(context languages.at(curlang.get()).print + ":"),
    text(heading-size-depth-4)[#date #if (git-hash != none) { [(Git revision: #git-hash)] } ],
    v(0.5em),

    text(context languages.at(curlang.get()).team + ":"),
    text(heading-size-depth-4, authors-text),
    v(0.5em),

    text(context languages.at(curlang.get()).advisor + ":"),
    text(heading-size-depth-4, advisor),
    v(0.5em),

    text(context languages.at(curlang.get()).co-advisor + ":"),
    text(heading-size-depth-4, co-advisor),
    v(0.5em),

    text(context languages.at(curlang.get()).counter-reader + ":"),
    text(heading-size-depth-4, gegenleser),
  ))
}

// Textbox to highlight Text
#let textbox(content) = box(
  width: 100%,
  fill: colors.mint-green,
  inset: 11pt,
  content,
)

// Code Styling
#let sourcecode = sourcecode.with(
  frame: code => block(
    radius: 4pt,
    fill: white,
    stroke: colors.light-grey,
    inset: (
      x: 0.5em,
      y: 0.25em,
    ),
    text(size: 5.5pt, code),
  ),
  gutter: 4pt,
)

#let title-without-numbering(
  title: "",
  depth: 1,
  top-edge: heading-top-edge,
  bottom-edge: heading-bottom-edge,
) = {
  text(
    title,
    weight: heading-weight,
    top-edge: top-edge,
    bottom-edge: (
      if (depth == 5) { -1mm } else { heading-bottom-edge }
    ),
    size: if depth == 1 { heading-size-depth-1-first } else if depth == 2 {
      heading-size-depth-2
    } else if depth == 3 { heading-size-depth_3 } else if depth == 4 {
      heading-size-depth_4
    } else if depth == 5 { heading-size-depth_5 },
  )
}

#let fr-table(
  id: [],
  name: [],
  beschreibung: [],
  fr_caption: [],
) = {
  set table(
    align: start,
    columns: (auto, 1fr),
    fill: (x, _) => if x == 0 { colors.table } else { none },
  )
  figure(
    table(
      [*ID*],
      strong(id),
      [*Name*],
      name,
      [*Beschreibung*],
      beschreibung,
    ),
    caption: fr_caption,
  )
}

#let use-case-table(
  id: [],
  name: [],
  akteur: [],
  beschreibung: [],
  voraussetzung: [],
  standard-verlauf: [],
  alternativ-verlauf: none,
  nachbedingung: [],
  priorität: [],
  resultat: [],
  uc-caption: [],
  status-color: green,
) = {
  set table(
    align: start,
    columns: (1fr, 4fr, 0.2fr),
    fill: (x, _) => if x == 0 { colors.table } else { none },
  )
  figure(
    table(
      [*ID*], strong(id), table.cell(fill: status-color, []),
      [*Name*], table.cell(colspan: 2, name),
      [*Akteur*], table.cell(colspan: 2, akteur),
      [*Beschreibung*], table.cell(colspan: 2, beschreibung),
      [*Voraussetzung*], table.cell(colspan: 2, voraussetzung),
      [*Standard-Verlauf*], table.cell(colspan: 2, standard-verlauf),
      [*Alternativ-Verlauf*], table.cell(colspan: 2, alternativ-verlauf),
      [*Nachbedingung*], table.cell(colspan: 2, nachbedingung),
      [*Priorität*], table.cell(colspan: 2, priorität),
      [*Resultat*], table.cell(colspan: 2, resultat),
    ),
    caption: uc-caption,
  )
}

#let nfr-table(
  id: [],
  beschreibung: [],
  anforderungen: [],
  priorität: [],
  messung: [],
  testen: [],
  resultat: [],
  nfr-caption: [],
  status-color: blue,
) = {
  set table(
    align: start,
    columns: (1fr, 4.1fr, 0.2fr),
    fill: (x, _) => if x == 0 { colors.table } else { none },
  )
  figure(
    table(
      [*ID*], strong(id), table.cell(fill: status-color, []),
      [*Beschreibung*], table.cell(colspan: 2, beschreibung),
      [*Anforderungen*], table.cell(colspan: 2, anforderungen),
      [*Priorität*], table.cell(colspan: 2, priorität),
      [*Messung*], table.cell(colspan: 2, messung),
      [*Testen*], table.cell(colspan: 2, testen),
      [*Resultat*], table.cell(colspan: 2, resultat),
    ),
    caption: nfr-caption,
  )
}

#let test-ablauf-table(
  id: [],
  name: [],
  beschreibung: [],
  methode: [],
  relevanz: [],
  testumgebung: [],
  intervall: [],
  test-ablauf-caption: [],
) = {
  set table(
    align: start,
    columns: (1fr, 4.1fr),
    fill: (x, _) => if x == 0 { colors.table } else { none },
  )
  figure(
    table(
      [*ID*],
      strong(id),
      [*Name*],
      name,
      [*Beschreibung*],
      beschreibung,
      [*Methode*],
      methode,
      [*Relevant für*],
      relevanz,
      [*Testumgebung*],
      testumgebung,
      [*Intervall*],
      intervall,
    ),
    caption: test-ablauf-caption,
  )
}

#let test-report-table(
  id: [],
  date: [],
  input: [],
  expected-output: [],
  actual-output: [],
  test-report-caption: [],
) = {
  set table(
    align: start,
    columns: (1fr, 4.1fr),
    fill: (x, _) => if x == 0 { colors.table } else { none },
  )
  figure(
    table(
      [*ID*],
      strong(id),
      [*Datum*],
      date,
      [*Input*],
      input,
      [*Erwartetes Resultat*],
      expected-output,
      [*Tatsächliches Resultat*],
      actual-output,
    ),
    caption: test-report-caption,
  )
}
