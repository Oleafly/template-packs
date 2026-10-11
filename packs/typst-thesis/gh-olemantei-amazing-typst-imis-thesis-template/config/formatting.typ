
// Heads up! This file needs a refactor, but time wasn't on my side.
// Hope you find what you're looking for — may the code gods be in your favor! 🚀
#let titlePageFont = "Calibri"
#let documentFont = "Times New Roman"
#let rawFont = "Lucida Console"
#let pageMarginTop = 2.5cm
#let pageMarginRight = 2.5cm
#let pageMarginBottom = 2cm
#let pageMarginLeft = 3.5cm
#let pageFooterHeight = 1.65cm
#let fontSizeBody = 11pt
#let fontSizeHeading1 = 24pt
#let lineSpacing = 11.75pt
#let paragraphSpacingAfter = 18pt

// ******************
// MAIN TEMPLATE
// ******************

#let thesis(
  title: "Titel der Arbeit",
  subtitle: none,
  english_title: none,
  thesis_type: "Masterarbeit/Bachelorarbeit",
  study_program: "Informatik/Medieninformatik",
  author: "Vorname Nachname des Studierenden",
  supervisor: "Prof. Dr. Vorname Nachname",
  support: "Titel Vorname Nachname des/der Betreuer/in",
  company: none,
  date: "16.02.2025",
  exposé: false,
  doc,
) = {
  import "@preview/alexandria:0.1.1": *
  show: alexandria(prefix: "x-", read: path => read(path))

  //
  // DOCUMENT SETUP
  //
  set page(margin: (
    top: pageMarginTop,
    right: pageMarginRight,
    bottom: pageMarginBottom + pageFooterHeight,
    left: pageMarginLeft,
  ))
  set text(lang: "de")
  set par(justify: true)

  //
  // ELEMENT STYLES
  //

  // heading
  set heading(numbering: "1.1")
  show heading: set par(justify: false)

  show heading.where(level: 1): it => [
    #if exposé == false { pagebreak() } else { v(9pt) }
    #set text(size: fontSizeHeading1, weight: "regular")
    #v(6pt)
    #block[
      #if it.numbering != none [
        #grid(
          columns: (57pt, 1fr),
          rows: 1,
          counter(heading).display(), it.body,
        )
      ]
      #if it.numbering == none [
        #it.body
      ]
    ]
    #v(20pt)
  ]
  show heading.where(level: 2): it => [
    #set text(size: 16pt, weight: "regular")
    #v(18pt)
    #context {
      let elms = query(selector(heading).before(here()))
      if elms.len() > 1 {
        let previous_heading = elms.at(-2)
        let current_heading = elms.at(-1)
        if (
          previous_heading.location().position().page == current_heading.location().position().page
        ) {
          if (
            previous_heading.location().position().y + 74pt > current_heading.location().position().y
          ) {
            v(-23pt)
          }
        }
      }
    }

    #block[
      #if it.numbering != none [
        #grid(
          columns: (57pt, 1fr),
          rows: 1,
          counter(heading).display(), it.body,
        )
      ]
      #if it.numbering == none [
        #it.body
      ]
    ]
    #v(12pt)
  ]
  show heading.where(level: 3): it => [
    #set text(size: 14pt, weight: "regular")
    #v(10pt)
    #context {
      let elms = query(selector(heading).before(here()))
      if elms.len() > 1 {
        let previous_heading = elms.at(-2)
        let current_heading = elms.at(-1)
        if (
          previous_heading.location().position().page == current_heading.location().position().page
        ) {
          if (
            previous_heading.location().position().y + 53pt > current_heading.location().position().y
          ) {
            v(-9pt)
          }
        }
      }
    }

    #block[
      #if it.numbering != none [
        #grid(
          columns: (57pt, 1fr),
          rows: 1,
          counter(heading).display(), it.body,
        )
      ]
      #if it.numbering == none [
        #it.body
      ]
    ]
    #v(10pt)
  ]
  show heading.where(level: 4): it => [
    #set text(size: 12pt, weight: "regular")
    #v(10pt)
    #context {
      let elms = query(selector(heading).before(here()))
      if elms.len() > 1 {
        let previous_heading = elms.at(-2)
        let current_heading = elms.at(-1)
        if (
          previous_heading.location().position().page == current_heading.location().position().page
        ) {
          if (
            previous_heading.location().position().y + 47pt > current_heading.location().position().y
          ) {
            v(-9pt)
          }
        }
      }
    }

    #block[
      #if it.numbering != none [
        #grid(
          columns: (57pt, 1fr),
          rows: 1,
          counter(heading).display(), it.body,
        )
      ]
      #if it.numbering == none [
        #it.body
      ]
    ]
    #v(10pt)
  ]

  // list
  set list(indent: .7cm, body-indent: 0.5cm, marker: ([●], [○], [▪]))

  // table
  set table(
    stroke: (_, y) => (
      top: if y == 0 { 2pt } else if y == 1 { 0.5pt } else { 0pt },
      bottom: 2pt,
    ),
    align: left,
    inset: .25pt,
    // fill: (_, y) => if calc.odd(y) { rgb("F5F5F5") },
  )
  show table.cell: set par(justify: false)

  // figure
  set figure(gap: 20pt)
  show figure: set block(inset: (top: 10pt, bottom: 10pt))
  show raw: set text(font: rawFont, size: 8pt)
  show raw: set align(left)
  show raw.where(block: true): code => {
    grid(
      columns: (auto, auto),
      column-gutter: 5pt,
      row-gutter: par.leading,
      align: (right, raw.align),
      ..for line in code.lines {
        (
          text(fill: gray)[#line.number],
          line.body,
        )
      },
    )
  }
  show figure.where(kind: raw): f => [
    #context[
      #box(width: 100%, fill: rgb("#F5F5F5"), inset: (left: 10pt, right: 10pt))[#f.body] #f.caption
    ]
  ]
  show figure.caption: c => [
    #context {
      text(size: 9pt)[
        #text(weight: "bold")[
          #c.supplement #counter(figure.where(kind: c.kind)).display()#c.separator
        ]
        #h(-2pt)#c.body
      ]
    }
  ]

  // footnote
  show footnote.entry: set text(size: 10pt)
  set footnote.entry(gap: 8pt, indent: 0pt, separator: line(length: 34%, stroke: 0.5pt))
  show footnote.entry: it => {
    let loc = it.note.location()
    let content = it.note.body
    grid(
      columns: (5pt, 1fr),
      rows: 1,
      super[#numbering("1", ..counter(footnote).at(loc))], [#content],
    )
  }
  show super: set text(size: 12pt)

  //
  // HELPER FUNCTIONS
  //
  let to-string(content) = {
    if content.has("text") {
      content.text
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("body") {
      to-string(content.body)
    } else if content == [ ] {
      " "
    }
  }

  //
  // FRONT MATTER
  //

  // title page
  set align(center) if exposé == false
  set text(font: titlePageFont)
  set page(footer: none)

  v(6pt)
  image("./logo.png", height: 3.07cm)
  v(43pt)
  text(22pt, weight: "bold", title)
  linebreak()
  if (subtitle != none) {
    v(9pt)
    text(22pt, weight: "bold", subtitle)
    linebreak()
  }
  v(12pt)
  text(20pt, english_title)
  linebreak()
  v(21pt)
  if exposé == false {
    text(12pt, weight: "bold", thesis_type)
  } else {
    text(20pt, thesis_type)
  }
  linebreak()
  v(6pt)
  text(12pt, "im Rahmen des Studiengangs")
  linebreak()
  text(12pt, weight: "bold", study_program)
  linebreak()
  text(12pt, "der Universität zu Lübeck")
  linebreak()
  v(23pt)
  text(12pt, "vorgelegt von:")
  linebreak()
  v(2pt)
  text(12pt, weight: "bold", author)
  linebreak()
  v(33pt)
  text(12pt, "ausgegeben und betreut von:")
  linebreak()
  v(2pt)
  text(12pt, weight: "bold", supervisor)
  linebreak()
  v(20pt)
  text(12pt, "mit Unterstützung von:")
  linebreak()
  v(if company != none { 7pt } else { 2pt })
  text(12pt, weight: "bold", support)
  linebreak()
  if (company != none) {
    v(7pt)
    text(12pt, "Die Arbeit ist im Rahmen einer Tätigkeit bei der Firma " + company + " entstanden.")
    linebreak()
  }
  v(1fr)
  text(12pt, "Lübeck, " + date)
  v(1fr)

  // abstract
  set page(numbering: "1 / 1", footer: context [
    #if counter(page).get().at(0) != "0" [
      // fix bug where page number is displayed as 0
      #context {
        text(size: 11pt, weight: "regular", font: documentFont)[
          #place(right, dy: -10pt, counter(page).display())
        ]
      }
    ]
  ])

  set align(left)
  set text(font: documentFont, size: fontSizeBody)
  set par(leading: lineSpacing, spacing: paragraphSpacingAfter)
  set block(spacing: fontSizeBody * 1.75)

  counter(page).update(1)
  if exposé == false {
    heading("Kurzfassung", numbering: none)
    include "../_matter/abstract_de.typ"
    v(1fr)
    heading("Schlüsselwörter", depth: 2, numbering: none)
    include "../_matter/keywords_de.typ"

    heading("Abstract", numbering: none)
    include "../_matter/abstract_en.typ"
    v(1fr)
    heading("Keywords", depth: 2, numbering: none)
    include "../_matter/keywords_en.typ"

    // table of contents
    heading("Inhaltsverzeichnis", numbering: none)
    v(-5pt)
    show outline.entry.where(level: 1): it => [
      #set text(weight: "bold")
      #set underline(stroke: 0pt)
      #v(5pt)
      #if it.element.numbering != none [
        #let pageNumber = int(numbering(it.element.numbering, ..counter(page).at(it.element.location())))
        #link((page: pageNumber + 1, x: 0pt, y: 0pt))[
          #grid(
            columns: (22pt, 1fr, auto),
            rows: 1,
            [#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))],
            [#it.element.body
              #box(width: 1fr, align(right, repeat()[.]))],
            align(right + bottom)[#h(2.5pt) #pageNumber],
          )
        ]
      ]
      #if it.element.numbering == none [
        #it
      ]
    ]
    show outline.entry.where(level: 2): it => [
      #set underline(stroke: 0pt)
      #if it.element.numbering != none [
        #let pageNumber = int(numbering(it.element.numbering, ..counter(page).at(it.element.location())))
        #link((page: pageNumber + 1, x: 0pt, y: 0pt))[
          #v(-2pt)
          #grid(
            columns: (36pt, 1fr, auto),
            rows: 1,
            align(right)[#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
              #h(8pt)],
            [#it.element.body
              #box(width: 1fr, align(right, repeat()[.]))],
            align(right + bottom)[#h(2.5pt) #pageNumber],
          )
        ]
      ]
      #if it.element.numbering == none [
        #v(-2pt)
        #it
      ]
    ]
    show outline.entry.where(level: 3): it => [
      #set underline(stroke: 0pt)
      #h(-6pt)
      #if it.element.numbering != none [
        #let pageNumber = int(numbering(it.element.numbering, ..counter(page).at(it.element.location())))
        #link((page: pageNumber + 1, x: 0pt, y: 0pt))[
          #v(-13pt)
          #grid(
            columns: (66pt, 1fr, auto),
            rows: 1,
            align(right)[#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
              #h(22pt)],
            [#it.element.body
              #box(width: 1fr, align(right, repeat()[.]))],
            align(right + bottom)[#h(2.5pt) #pageNumber],
          )
        ]
      ]
      #if it.element.numbering == none [
        #v(-13pt)
        #it
      ]
    ]
    show outline.entry.where(level: 4): it => [
      #set underline(stroke: 0pt)
      #h(-6pt)
      #if it.element.numbering != none [
        #let pageNumber = int(numbering(it.element.numbering, ..counter(page).at(it.element.location())))
        #link((page: pageNumber + 1, x: 0pt, y: 0pt))[
          #v(-13pt)
          #grid(
            columns: (96pt, 1fr, auto),
            rows: 1,
            align(right)[#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
              #h(22pt)],
            [#it.element.body
              #box(width: 1fr, align(right, repeat()[.]))],
            align(right + bottom)[#h(2.5pt) #pageNumber],
          )
        ]
      ]
      #if it.element.numbering == none [
        #v(-13pt)
        #it
      ]
    ]
    outline(title: none, indent: 14pt)

    // fix bug where page number isn't counted
    hide["Platzhalter"]
  }

  //
  // DOCUMENT BODY
  //
  doc

  //
  // BACK MATTER
  //

  if exposé == false {
    // outline of figures
    heading("Abbildungen", numbering: none)
    show outline.entry: it => {
      set par(justify: false)
      set underline(stroke: 0pt)
      let pageNumber = counter(page).at(it.element.location()).at(0)
      let itemNumber = it.element.numbering
      link((page: pageNumber + 1, x: 0pt, y: 0pt))[
        #grid(
          columns: (auto, 1fr, auto),
          rows: 1,
          text(weight: "bold")[
            #it.element.supplement #it.element.counter.at(it.element.location()).at(0): #h(3pt)
          ],
          [#it.element.caption.body
            #box(width: 1fr, align(right, repeat()[.])) #h(2pt)
          ],
          align(right + bottom)[#pageNumber],
        )
      ]
      v(-1.5pt)
    }
    outline(title: none, indent: 14pt, target: figure.where(kind: image))
    // fix bug where page number isn't counted
    hide["Platzhalter"]

    // outline of tables
    heading("Tabellen", numbering: none)
    outline(title: none, indent: 14pt, target: figure.where(kind: table))
    // fix bug where page number isn't counted
    hide["Platzhalter"]
  }

  // bibliography
  if exposé == true { pagebreak() }
  heading("Quellen", numbering: none)
  load-bibliography("../references.bib", style: "american-psychological-association")

  context {
    show par: it => [
      #it
      #v(4.5pt)
    ]

    let (references, ..rest) = get-bibliography("x-")

    let referencesWithPrefix = references.map(x => (
      ref: x,
      prefix: x.key.slice(0, 2),
    ))

    let onlineSources = referencesWithPrefix.filter(x => x.prefix == "ON").map(x => x.ref)
    let softwareSources = referencesWithPrefix.filter(x => x.prefix == "SO").map(x => x.ref)
    let normenSources = referencesWithPrefix.filter(x => x.prefix == "NO").map(x => x.ref)
    let defaultSources = referencesWithPrefix
      .filter(x => x.prefix != "NO" and x.prefix != "SO" and x.prefix != "ON")
      .map(x => x.ref)

    heading("Literatur", numbering: none, depth: 2)
    render-bibliography(title: none, (
      references: defaultSources,
      ..rest,
    ))
    if onlineSources.len() > 0 [
      #heading("Weblinks", numbering: none, depth: 2)
      #render-bibliography(title: none, (
        references: onlineSources,
        ..rest,
      ))
    ]
    if softwareSources.len() > 0 [
      #heading("Software", numbering: none, depth: 2)
      #render-bibliography(title: none, (
        references: softwareSources,
        ..rest,
      ))
    ]
    if normenSources.len() > 0 [
      #heading("Normen", numbering: none, depth: 2)
      #render-bibliography(title: none, (
        references: normenSources,
        ..rest,
      ))
    ]
  }
  // fix bug where page number isn't counted
  hide["Platzhalter"]

  if exposé == false {
    // list of abbreviations
    heading("Abkürzungen", numbering: none)
    import "../_matter/declaration.typ": declaration

    for (abbreviation, full_name) in declaration {
      grid(
        columns: (10pt, 55pt, 1fr),
        rows: 1,
        [],
        text(weight: "bold")[
          #abbreviation#h(5pt)
        ],
        [#full_name],
      )
    }

    // glossary
    heading("Glossar", numbering: none)
    text[Die nachfolgend beschriebenen Fachbegriffe werden hinsichtlich ihrer Bedeutung im Bereich der Medieninformatik erläutert. Die Begriffe können in anderen Bereichen auch andere Bedeutungen besitzen. #emph("Kursiv") gedruckte Begriffe sind selbst wieder im Glossar oder unter den Abkürzungen beschrieben.]
    import "../_matter/glossary.typ": glossary

    for (abbreviation, full_name) in glossary {
      grid(
        columns: (10pt, 105pt, 1fr),
        rows: 1,
        [],
        text(weight: "bold")[
          #abbreviation#h(5pt)
        ],
        [#full_name],
      )
    }

    // attachments
    [
      #set heading(numbering: none)
      = Anhänge
      #label("anhänge")
    ]
    set heading(numbering: none)

    context {
      let entries = query(selector(heading.where(level: 2)).after(here()))
      for entry in entries {
        let number = entry.body.fields().children.at(0)
        let title = entry.body.fields().children.at(3)
        let pageNumber = counter(page).at(entry.location()).at(0)
        link((page: pageNumber + 1, x: 0pt, y: 0pt))[
          #grid(
            columns: (auto, 1fr, auto),
            rows: 1,
            text(weight: "bold")[
              #number: #h(3pt)
            ],
            [#title
              #box(width: 1fr, align(right, repeat()[.])) #h(2pt)
            ],
            align(right + bottom)[#pageNumber],
          )
        ]
      }
    }
    include "../_matter/attachment.typ"

    // statement of authorship
    heading("Erklärung", numbering: none)
    text[Ich versichere an Eides statt, die vorliegende Arbeit selbstständig verfasst und nur die angegebenen Quellen benutzt zu haben.]
    v(100pt)
    image("./signature.jpg", width: 8cm)
    text[#author]
    v(25pt)
    text[Lübeck, den #date]
  }
}

