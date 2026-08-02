#let part(
  title,
  number,
) = {
  page(
    numbering: none,
    v(7cm) +
    align(center, text(size: 4em, font: "linux biolinum")[Part #number]) +
    align(center, text(weight: 300, size: 2em, title)),
    margin: (bottom: 2cm, top: 2cm, left: 1.5cm, right: 1.5cm),
  )
  // pagebreak()
}

#let book(
  // The book's title.
  title: [Book title],

  // The book's author.
  author: "Author",

  // A dedication to display on the third page.
  dedication: none,

  // Details about the book's publisher that are
  // display on the second page.
  publishing-info: none,

  // The book's content.
  symbols: none,
  abbreviations: none,
  quote: none,
  preface: none,
  summary: none,
  samenvatting: none,
  papers: none,
  publications: none,
  presentations: none,
  appendices: none,
  acknowledgements: none,
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)
  let part2 = "Peer-Reviewed Publications, Preprints, and Conference Contributions"

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(font: "Linux Libertine", size: 11.0pt)

  // Configure the page properties.
  set page(
    width: 16cm,
    height: 24cm,
    margin: (bottom: 2cm, top: 2cm, left: 2cm, right: 2cm),
  )

  // TITLE PAGE
  // page(align(center + horizon)[
  //   #text(size: 2em)[*#title*]
  //   #v(6em, weak: true)
  //   #text(size: 1.5em, weight: "thin", author)
  // ])

  // Display publisher info at the bottom of the second page.
  if publishing-info != none {
    align(center + bottom, text(0.8em, publishing-info))
  }

  // pagebreak()

  let part-counter = counter("part")
  let new-part(title) = {
    part-counter.step()
    heading(
      level: 1,
      numbering: "I",
      [Part #part-counter.display(): #title]
    )
  }

  // Table of contents
  // Configure heading numbering
  let titles_roman = (
    "Summary (EN)", "Summary (NL)", "List of Symbols",
    "List of Abbreviations",
  )
  let titles_ABC = ("A Selection of Peer-Reviewed Publications and Preprints",)

  if quote != none {
    // align(right, {
    //   v(4em)
    //   text(20pt, weight: 700, font: "linux biolinum", "Preface")
    // })
    // v(1em)
    set text(11pt)
    set block(spacing: 0.78em)
    quote
    pagebreak()
  }

  set heading(numbering: "1.1")
  page(numbering: none)[
    #show heading: set align(center)
    #heading(numbering: none, outlined: false, "Table of Contents")
    #set text(11pt)
    #locate(loc => {
      let chapter_count = 0
      let headings = query(heading.where(level: 1, outlined: true).or(heading.where(level: 2)), loc)
      for (i, h) in headings.enumerate() {

        let title_ = h.body

        // if it's a "part", it's title equals the title of the document or
        // "a selection of published papers"
        let page-num = none
        if i < titles_roman.len() {
          page-num = numbering("i", counter(page).at(h.location()).first())
        } else {
          page-num = counter(page).at(h.location()).first()
        }

        // number should be formatted as A, B, C if it comes after the chapters
        let number = none
        if h.numbering != none {
          let c = counter(heading).at(h.location())
          if c.len() == 1 {  // only increment for level 1 headings
            chapter_count += 1
            if chapter_count == 1 { // insert "part I: title" before first
              v(36pt)
              grid(
                columns: (5em, auto),
                gutter: 1em,
                align: (top, top + left),
                text(weight: "bold", size: 1.3em, "Part I: "),
                text(weight: "bold", size: 1.3em, title)
              )
            } else if chapter_count == 6 + 1 {  // insert part II after last
              v(36pt)
              grid(
                columns: (5em, auto),
                gutter: 1em,
                align: (top, top + left),
                text(weight: "bold", size: 1.3em, "Part II: "),
                text(weight: "bold", size: 1.3em, part2)
              )
            }
          }
          if chapter_count > 6 {  // after main text, use A/B/C
            number = numbering("A.", ..c)
          } else {
            number = numbering("1.", ..counter(heading).at(h.location()))
          }
        }
        let line = if h.level == 1 { none } else { line(length: 100%, stroke: (dash: "dotted")) }
        v(if h.level == 1 { 36pt } else { 0pt })
        grid(
          columns: (1em, auto, 1fr, 1em),
          gutter: 1em,
          align: (top, horizon + left, bottom, bottom + right),
          text(
            number,
            size: if h.level == 1 { 1.3em } else { 0em },
            weight: 700,
          ),
          text(weight: if h.level == 1 { "bold" } else { "regular" },
               size: if h.level == 1 { 1.3em } else { 1em },
               title_),
          box(width: 100%, line),
          text(
            luma(70%),
            size: if h.level == 1 { 1em } else { 1em },
            str(page-num),
          )
        )
        v(-0.4em)
      }
    })
  ]

  show heading.where(level: 1): it => context {
    pagebreak(to: "odd")

    align(right, {
      v(4em)
      text(1.3em, weight: 700, font: "linux biolinum", it.body)
    })
    v(1em)
  }

  set page(
    numbering: numbering("i", 1),
    number-align: center,
  )
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)

  page(numbering: none)[]
  page(numbering: none)[]
  counter(page).update(1)
  if preface != none {
    heading(numbering: none, outlined: true, "Acknowledgements")
    preface
    pagebreak()
  }

  if summary != none {
    heading(numbering: none, outlined: true, "Summary")
    summary
    pagebreak()
  }
  if samenvatting != none {
    heading(numbering: none, outlined: true, "Samenvatting")
    samenvatting
    pagebreak()
  }

  // List of Symbols
  if symbols != none {
    heading(numbering: none, outlined: true, "List of Symbols")
    table(
      columns: (auto, auto),
      inset: 4pt,
      stroke: none,
      align: (center + horizon, horizon + left),
      ..symbols.map(((symbol, description)) => (
        [$ #symbol $],
        [#description]
      )).flatten()
    )
    pagebreak()
  }

  // List of Abbreviations
  if abbreviations != none {
    heading(numbering: none, outlined: true, [List of Abbreviations])
    table(
      columns: (auto, auto),
      inset: 4pt,
      stroke: none,
      align: (center, left),
      ..abbreviations.map(((abbr, full)) => (
        text(weight: 700, font: "linux biolinum", abbr),
        [#full]
      )).flatten()
    )
    pagebreak()
  }


  // Books like their empty pages.
  // pagebreak(to: "odd")
  page(numbering: none)[]
  part(title, "I")
  counter(heading).update(0)
  counter(page).update(1)

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  show par: set block(spacing: 0.78em)

  // configure equations?
  set math.equation(numbering: "(1)")

  // Configure page properties.
  set page(
    numbering: numbering("1", 1),
    number-align: center,
    header: locate(loc => {
          let page_number = counter(page).at(loc).first()
          // Chapter 1 begins at page 2/3
          if calc.even(page_number) and (page_number > 2) {
            let chapter = counter(heading.where(level: 1)).at(loc).first()
            let chapter_title = query(
              selector(heading.where(level: 1)).before(loc),
              loc
            ).last().body
            set align(left)
            text(
              size: 11pt,
              font: "linux biolinum",
              smallcaps("chapter " + str(chapter) + ":    " + lower(chapter_title)),
            )
          }
        })
  )

  set figure(numbering: it => {
    // let numbering-string = it.numbering
    let num_chapter = counter(heading).display().first()
    [#num_chapter.#it]
  })

  show figure.caption: it => {
    block(
      width: 90%,
      spacing: 0.9em,
      par(leading: 0.3em, text(10pt, font: "linux biolinum", it)),
    )
  }


  // Configure chapter headings
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => context {
    pagebreak(to: "odd")

    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    let number = if it.numbering != none {
      counter(heading).display("1")
      h(7pt, weak: true)
    }
    align(right, {
      v(-1em)
      text(9em, weight: 300, number, fill: luma(70%), font: "linux biolinum")
      v(-10em)
      text(1.4em, weight: 700, font: "linux biolinum", it.body)
    })
    v(1em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    align(center, it)
    v(0.5em)
  }
  pagebreak()

  body

  let hidden-heading(body, level: 1) = {
    // Create a dummy heading that won't be displayed but can be queried
    [#heading(
      body,
      level: level,
      outlined: true,
      numbering: none
    )#box(width: 0pt, height: 0pt)
    ]
  }

  let publication-page(
    number: "",
    title: "",
    authors: "",
    journal: "",
    contributor: "",
    copyright: "",
    num_pages: none,  // ignored
  ) = {
    set page(
      width: 16cm,
      height: 24cm,
      margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
      header: none,
    )
    hidden-heading(level: 2, [Paper #number])

    // v(3cm)
    // align(
    //   center,
    //   text(size: 12pt)[#underline[Paper #number]],
    // )
    v(0.5cm)
    align(center, text(size: 12pt, font: "linux biolinum", weight: "bold")[#title])
    v(0.5cm)
    align(center, authors)
    v(0.5cm)
    align(center, journal)
    v(9cm)

    contributor
    v(1cm)
    text(size: 9pt)[
      Reprinted with permission.\
      #copyright
    ]
  }
  counter(heading).update(0)
  set page(header: none)
  show heading.where(level: 1): it => context {
    pagebreak(to: "odd")

    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    let number = if it.numbering != none {
      counter(heading).display("A")
      h(7pt, weak: true)
    }
    align(right, {
      v(-1em)
      text(9em, weight: 300, number, fill: luma(70%), font: "linux biolinum")
      v(-10em)
      text(1.4em, weight: 700, font: "linux biolinum", it.body)
    })
    v(1em)
  }

  // insert page for part II
  // page(v(10cm) + align(center, "part II"))
  // pagebreak()
  part(part2, "II")
  heading(level: 1, outlined: true, "Selected Publications and Preprints")
  pagebreak()

  for paper in papers {
    publication-page(..paper)
    pagebreak()
    for i in array.range(paper.at("num_pages")) {
      pagebreak()
    }
  }

  let show-publication(
    index: none,
    title: none,
    authors: none,
    journal: none,
  ) = {
    v(0.1cm)
    grid(
      columns: (2em, auto),
      align: (top, top + left),
      text(index),
      text(weight: "bold", title) + linebreak() +
      authors + linebreak() +
      journal
    )
  }
  let show-presentation(
    index: none,
    title: none,
    authors: none,
    event: none,
    date: none,
    location: none,
  ) = {
    v(0.1cm)
    grid(
      columns: (2em, auto),
      align: (top, top + left),
      text(index),
      text(weight: "bold", title) + linebreak() +
      authors + linebreak() +
      emph(event) + linebreak() +
      date + linebreak() +
      location
    )
  }

  set heading(numbering: "A.1")
  heading(level: 1, outlined: true, "Appendices")
  for i in array.range(appendices.len()) {
    let a = appendices.at(i)
    heading(level: 2, outlined: true, a.at("title"))
    a.at("body")
  }


  heading(level: 1, outlined: true, "List of Publications and Conference Contributions")
  set heading(numbering: none)
  heading(level: 2, outlined: true, "Publications and Preprints")
  for i in array.range(publications.len()) {
    show-publication(index: str(i + 1), ..publications.at(i))
  }

  heading(level: 2, outlined: true, "Presentations at Conferences & Workshops")
  text[The following list enumerates only those presentations for which I was the main
  presenter.]
  for i in array.range(presentations.len()) {
    show-presentation(index: str(i + 1), ..presentations.at(i))
  }

  // set page(
  //   header: none,
  //   margin: (bottom: 2cm, top: 2cm, left: 1cm, right: 1cm),
  // )

  // page(image("paper1/paper_1.svg", width: 100%))
  // page(image("paper1/paper_2.svg", width: 100%))
  // page(image("paper1/paper_3.svg", width: 100%))


  set page(
    header: none,
    margin: (bottom: 2cm, top: 2cm, left: 2cm, right: 2cm),
  )
  show heading: it => {
    pagebreak(to: "odd")
    v(1em)
    text(20pt, weight: 500, it.body)
  }
  bibliography(style: "american-physics-society", "references.bib")
  if acknowledgements != none {
    pagebreak()
    acknowledgements
  }
}

#let to_roman(num) = {
  let roman = (
    (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
    (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
    (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
  )
  let result = ""
  for (value, symbol) in roman {
    while num >= value {
      result += symbol
      num -= value
    }
  }
  result
}

#let paper(n) = {
  text(
    weight: 700,
    size: 11pt,
    "Paper " + to_roman(n)
  )
}

