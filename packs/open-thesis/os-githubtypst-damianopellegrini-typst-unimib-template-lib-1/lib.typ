#let thesis-footer(bachelor: true, authors, extras) = {
  import "packages.typ": langDb, linguify.linguify
  if extras.len() < 1 {
    panic("Extras length must be at least 1 using the thesis-footer component")
  }

  let mentor = extras.at(0)
  let extras = extras.slice(1)

  [
    *#linguify("mentor", from: langDb):* #mentor.name \
    #for extra in extras {
      [*#linguify("co-mentor", from: langDb):* #extra.name \ ]
    }
  ]

  v(1.5fr, weak: true)
  align(right)[
    *#{ linguify(if bachelor { "bachelor-thesis-of" } else { "master-thesis-of" }, from: langDb) }:* \
    #for author in authors {
      [
        #author.name \
        matr. #author.matr

      ]
    }
  ]
}

#let report-footer(authors, extras) = {
  import "packages.typ": langDb, linguify.linguify
  [
    *#linguify("report-of", from: langDb):* \
    #for author in (..authors, ..extras) {
      [#author.name #author.matr \ ]
    }
  ]
}

#let notes-footer(authors, extras) = {
  import "packages.typ": langDb, linguify.linguify
  [
    *#linguify("notes-of", from: langDb):* \
    #for author in authors {
      [#author.name #author.matr\ ]
    }
  ]

  if extras.len() > 0 {
    v(1.5fr, weak: true)
    align(right)[
      *#linguify("helper", from: langDb):* \
      #for extra in extras {
        [#extra.name #extra.matr \ ]
      }
    ]
  }
}

#let unimib(
  /// Title of the document
  ///
  /// -> content
  title: [A long enough thesis title for it to wrap on a newline and show how the title wraps],
  /// The paper main author(s)
  ///
  /// -> ((name: "Mario Rossi", matr: "XXXYYY"),)
  authors: ((name: "Mario Rossi", matr: "XXXYYY"),),
  /// Extras meaning reviewers and the likes.
  ///
  /// -> ((name: "Paolo Bianchi", matr: "XXXYYY"),)
  extras: ((name: "Paolo Bianchi", matr: "XXXYYY"), (name: "Paolo Bianchi", matr: "XXXYYY")),
  /// Document keywords
  ///
  /// -> array(string)
  keywords: (),
  /// University area of education
  ///
  /// -> content
  area: [School of Science],
  /// University department
  ///
  /// -> content
  department: [Department of Informatics, Systems and Communications],
  /// University course
  ///
  /// -> content
  course: [Degree course in Computer Science],
  /// The latter academic year in which you are writing this thesis for
  ///
  /// Example: For academic year 2025-2026 put 2026
  ///
  /// -> int
  scholar-year: datetime.today().year(),
  /// Front-page-footer to use
  ///
  /// -> (authors: array(string), extras: array(string))
  ///
  /// Default: thesis-footer.with(bachelor: false)
  front-page-footer: thesis-footer.with(bachelor: false),
  // front-page-footer: report-footer,
  // front-page-footer: notes-footer,
  /// Optional abstract to show before the outline and after the front page
  ///
  /// -> content | none
  abstract: none,
  /// Optional bibliography to show at the end of the document
  ///
  /// -> content | bibliography | none
  bibliography: none,
  /// Page size and margins
  ///
  /// -> str
  paper-size: "us-letter",
  /// Wheter to put spacing for binding or not
  ///
  /// -> true | false
  binding: false,
  /// Wheter to put an header on each content page
  ///
  /// -> true | false
  per-page-header: true,
  /// Wheter to put a footer on each content page
  ///
  /// -> true | false
  per-page-footer: true,
  /// Rotate the page layout, by default is false. Horizontal content is layed in two columns
  ///
  /// -> true | false
  horizontal: false,
  /// Change color scheme to a dark background, useful for non-printing.
  ///
  /// -> true | false
  // dark: false,
  dark: true,
  body,
) = {
  // MARK: - Local vars
  import "packages.typ": _std-bibliography, colors, langDb, linguify.linguify

  let academic-year = [#linguify("academic-year", from: langDb) #(scholar-year - 1)-#scholar-year]
  let actualColors = if dark { colors.dark } else { colors.light }

  // MARK: - Style document, page & text
  set document(title: title, author: authors.map(a => a.name), date: datetime.today(), keywords: keywords)
  set page(
    paper: paper-size,
    flipped: horizontal,
    fill: actualColors.background,
    margin: if paper-size != "a4" {
      (
        top: (1.5in / 279mm) * 100%,
        inside: (if not binding { 1in } else { 1.75in } / 216mm) * 100%,
        outside: (1in / 216mm) * 100%,
        bottom: (1in / 279mm) * 100%,
      )
    } else {
      (
        top: 1.5in,
        inside: if not binding { 1in } else { 1.75in },
        outside: 1in,
        bottom: 1in,
      )
    },
  )
  set text(font: "New Computer Modern", fill: actualColors.foreground)

  // MARK: - Style outline
  set outline(depth: 3, indent: 1em)

  // MARK: - Style tables
  show table.cell.where(y: 0): smallcaps
  show table.cell: c => {
    if (c.colspan > 1) {
      table.cell(align: center + horizon, c)
    } else {
      c
    }
  }

  set table(
    stroke: (x, y) => (bottom: if y == 0 { actualColors.foreground.transparentize(92%) }),
    fill: (_, y) => if calc.odd(y) { actualColors.foreground.transparentize(97%) } else { actualColors.background },
    align: (x, y) => if y == 0 { center } else if x == 0 { left } else { center },
  )
  show table: t => block(inset: (y: 1.5pt), stroke: (y: 1.5pt + actualColors.foreground.transparentize(86%)), t)

  // MARK: - Style paragraph
  set par(spacing: 1.25em, leading: 0.58em, justify: false)

  // MARK: - Style headings
  set heading(numbering: "1.1.1.")

  // TODO: FIXME: remove numbering for intro and sub-headings, to not put in outline

  /// Heading styling
  ///
  /// Appendix or chapter are numbered patterns starting with either "A" or "1".
  /// Introduction is a section
  ///
  /// Styling is done through set heading(numbering: ) rules, introduction should not have any numbering
  ///
  show heading.where(level: 1): it => {
    let introWord = [#linguify("introduction", from: langDb, lang: text.lang)]
    let isIntro = it.body == introWord

    if it.numbering == none and not isIntro {
      return it
    }

    pagebreak(weak: true)
    block(breakable: false, {
      v(3em)
      if isIntro {
        text(
          size: 1.5em,
          it.body,
        )
        v(1.75em)
        // reset counter for heading after intro
        counter(heading).update(0)
        return
      }

      let firstNumbering = it.numbering.first()

      // set supplement based on first numbering
      let supplement = if firstNumbering in ("1", "I") {
        linguify("chapter", from: langDb, lang: text.lang)
      } else if firstNumbering in ("A", "a") {
        linguify("appendix", from: langDb, lang: text.lang)
      } else {
        it.supplement
      }
      set heading(supplement: supplement)


      [#supplement #counter(heading).display(it.numbering.first())]
      v(.25em)
      text(size: 1.5em, it.body)
      v(.5em)
    })
  }

  // Reset heading counter after numbering change
  show heading: it => {
    let before = query(heading.where().before(it.location(), inclusive: false))
    if before.len() <= 0 or it.numbering == none {
      return it
    }

    let prev = before.last()
    let firstNumbering = it.numbering.first()

    // reset count for the prev level 1 heading if it has different first numbering than now
    if it.level == 1 and prev.numbering != none and it.numbering.first() != prev.numbering.first() {
      counter(heading).update(0)
      it
    } else {
      it
    }
  }

  // Remove numbering from sub-headings in introduction section
  show heading: it => {
    if it.level <= 1 {
      return it
    }

    // remove numbering if previous level 1 heading is intro
    let prev = query(heading.where(level: 1).before(here())).last()
    if prev.body != [#linguify("introduction", from: langDb, lang: text.lang)] {
      it
    } else {
      block(it.body)
    }
  }

  // Set run-in subheadings.
  show heading: it => {
    if it.level > 4 {
      parbreak()
      text(11pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  }

  // MARK: - Style lists
  set enum(indent: 1em, body-indent: 0.9em)
  set list(indent: 1em, body-indent: 0.9em)

  // MARK: - Style bibliography
  show _std-bibliography: set text(8pt)
  set _std-bibliography(style: "ieee")
  set cite(form: "prose")

  // MARK: - Style math equation
  // https://sitandr.github.io/typst-examples-book/book/snippets/math/numbering.html
  show math.equation: set block(spacing: 1.75em)
  // reset math equation counter at each chapter
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }
  // Set numbering as (heading num.eq num)
  set math.equation(numbering: n => {
    let prevs = query(heading.where(level: 1).before(here())).filter(h => h.numbering != none)
    if (prevs.len() != 0 and counter(heading).get().first() != 0) {
      numbering("(" + prevs.last().numbering.first() + ".1)", counter(heading).get().first(), n)
    } else {
      numbering("(1)", n)
    }
  })


  // MARK: - Style code blocks
  set raw(tab-size: 2, theme: if dark { "themes/IR_Black.tmTheme" } else { auto })
  show figure.where(kind: raw): set block(breakable: true)
  show figure.where(kind: raw): set figure(supplement: linguify("code-block", from: langDb))
  show raw.where(block: true): r => {
    set align(r.align)

    block(
      stroke: 1pt + actualColors.foreground.transparentize(92%),
      inset: 1pt,
      grid(
        columns: (auto,) * 2,
        // row-gutter: 0.6em,
        // column-gutter: .8em,
        fill: (x, y) => if x > 0 and calc.even(y) { actualColors.foreground.transparentize(97%) } else {
          actualColors.background
        },
        grid.vline(x: 0, position: end, stroke: actualColors.foreground.transparentize(60%)),
        ..r
          .lines
          .map(line => (align(right, pad(0.3em)[#line.number]), pad(left: 0.8em, rest: 0.3em, line.body)))
          .flatten(),
      ),
    )
  }

  // MARK: - Style references
  show ref.where(form: "normal"): it => {
    // Style bib reference as usual
    if it.element == none {
      return it
    }

    // Style non intro reference as usual
    if (
      it.element.func() != heading
        or (it.element.body != [#linguify("introduction", from: langDb, lang: text.lang)] and it.supplement != function)
    ) {
      return it
    }

    // Style intro as introWord
    link(it.element.location(), [#it.element.body])
  }

  // References supplement
  show ref.where(form: "normal"): set ref(supplement: it => {
    if (
      it.func() == heading
        and (it.numbering.starts-with("1") or it.numbering.starts-with("I") or it.numbering.starts-with("A"))
    ) {
      return linguify(
        if it.numbering.starts-with("1") or it.numbering.starts-with("I") {
          "chapter"
        } else if it.numbering.starts-with("A") {
          "appendix"
        },
        from: langDb,
      )
    }

    it.supplement
  })

  // MARK: - First page

  grid(
    columns: (auto, 1fr),
    column-gutter: 0.4em,
    image("images/bicocca-logo.png", height: 6em),
    stack(
      spacing: 1em,
      smallcaps(text(weight: "thin", linguify("university", from: langDb))),
      strong(area),
      strong(department),
      strong(course),
    ),
  )
  v(4fr)
  align(center, text(2em, weight: "medium", title))
  v(5fr)

  front-page-footer(authors, extras)

  v(2fr, weak: true)

  align(center)[#academic-year]
  pagebreak()

  // MARK: - Abstract & outline

  // Set non content pages to roman numerals
  set page(numbering: "i")
  counter(page).update(1)

  if abstract != none {
    set text(size: 11pt)
    set par(justify: true)
    smallcaps(align(center, text(weight: "extralight", size: 1.2em, [#linguify("abstract", from: langDb)])))
    align(center, abstract)
    pagebreak()
  }

  set page(columns: if horizontal { 2 } else { 1 }) // Here because initial page should be on 1 column
  outline()
  pagebreak()

  // MARK: - Document

  // Reset counter for normal pages
  set page(numbering: "1")
  counter(page).update(1)

  set page(
    header: if per-page-header {
      text(style: "italic", grid(
        columns: (1fr, auto),
        align: top,
        [#title -- #context counter(page).display()],
        context authors.at(calc.rem(counter(page).get().first(), authors.len())).name,
      ))
    } else { auto },
    footer: if per-page-footer {
      text(style: "italic", [
        #linguify("university", from: langDb)
        #h(1fr)
        #academic-year
      ])
    } else { auto },
  )

  body

  if bibliography != none {
    pagebreak()
    bibliography
  }
}
