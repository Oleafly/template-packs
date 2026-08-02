#let script-size = 8pt
#let footnote-size = 8.5pt
#let small-size = 10pt
#let normal-size = 13pt
#let large-size = 15pt

// task
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}

// formula function
#let formula(body, numbered: true) = figure(
  body,
  kind: "formula",
  supplement: [formula],
  numbering: if numbered { "1" },
)

// footnote
#let footnote(n) = {
  let s = state("footnotes", ())
  s.update(arr => arr + (n,))
  locate(loc => super(str(s.at(loc).len())))
}

#let has_notes(loc) = {
  state("footnotes", ()).at(loc).len() > 0
}

#let print_footnotes(loc) = {
  let s = state("footnotes", ())
  enum(tight: true, ..s.at(loc).map(x => [#x]))
  s.update(())
}

// DOCUMENT
#let article(
  
  title: "defined-into-document", // The article's title.
  subtitle: "defined-into-document",
  authors: (), // An array of authors. For each author you can specify a name, department, organization, location, and email. Everything but the name is optional.
  abstract: none, // Your article's abstract. Can be omitted if you don't have one.
  paper-size: "a4", // The article's paper size. Also affects the margins.
  bibliography-file: none, // The path to a bibliography file if you want to cite some external works.

  // The document's content.
  body,
  
) = {
  // Formats the author's names in a list with commas and a final "and".
  let names = authors.map(author => author.name)
  let author-string = if authors.len() == 2 {
    names.join(" and ")
  } else {
    names.join(", ", last: ", and ")
  }

  // Set document metdata.
  set document(title: title, author: names)

  // Set the body font.
  set text(size: normal-size, font: "New Computer Modern")

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size != "a4-paper" {
      (
        top: (116pt / 279mm) * 80%,
        left: (126pt / 216mm) * 80%,
        right: (128pt / 216mm) * 80%,
        bottom: (94pt / 279mm) * 80%,
      )
    } else {
      (
        top: 117pt,
        left: 118pt,
        right: 119pt,
        bottom: 96pt,
      )
    },

    // The page header should show the page number and list of authors, except on the first page. The page number is on the left for even pages and on the right for odd pages.
    header-ascent: 14pt,
    header: locate(loc => {
      let i = counter(page).at(loc).first()
      if i == 1 { return }
      set text(size: script-size)
      grid(
        columns: (6em, 1fr, 6em),
        if calc.even(i) [#i],
        align(center, upper(
          if calc.odd(i) { title } else { title }
        )),
        if calc.odd(i) { align(right)[#i] }
      )
    }),

    // On the first page, the footer should contain the page number.
    footer-descent: 12pt,
    footer: locate(loc => {
      let i = counter(page).at(loc).first()
      if i == 1 {
        align(center, text(size: script-size, [#i]))
      }
    })
  )

  // Configure headings.
  set heading(numbering: "1.")
  show heading: it => {
    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    // Level 1 & 2 : smallcaps. Others : bold, without numbers
    set text(size: normal-size, weight: 400)
    if it.level == 1 or it.level == 2 {
      set text(size: 13pt)
      smallcaps[
        #v(18pt, weak: true)
        #number
        #it.body
        #v(normal-size, weak: true)
      ]
      // counter(figure.where(kind: "formula")).update(0)
    } else {
      set text(size: 13pt)
      v(18pt, weak: true)
      // number
      let styled = if it.level == 3 { strong } else { emph }
      styled(it.body + [. ])
      h(7pt, weak: true)
    }
  }

  // Configure lists and links.
  set list(indent: 24pt, body-indent: 5pt)
  set enum(indent: 24pt, body-indent: 5pt)
  show link: set text(font: "New Computer Modern Mono")

  // Configure citation and bibliography styles.
  set cite(style: "numerical", brackets: true)
  set bibliography(style: "apa", title: "References")

  // figures and formulas styles
  show figure.where(kind: "figure"): it => {
    show: pad.with(x: 23pt)
    set align(center)

    v(12.5pt, weak: true)

    // Display the figure's body.
    it.body

    // Display the figure's caption.
    if it.has("caption") {
      // Gap defaults to 17pt.
      v(if it.has("gap") { it.gap } else { 17pt }, weak: true)
      smallcaps[Figure]
      if it.numbering != none {
        [ #counter(figure).display(it.numbering)]
      }
      [. ]
      it.caption
    }

    v(15pt, weak: true)
  }

  show figure.where(kind: "formula"): it => align(center, block(
    above: 20pt, below: 18pt, {
    emph(it.body)
    v(if it.has("gap") { it.gap } else { 17pt }, weak: true)
    [(]
      if it.numbering != none {
        //counter(heading).display()
        it.counter.display(it.numbering)
      }
    [)]

    }
  ))

  // Display the title and authors.
  v(35pt, weak: true)
  align(center, upper({
    v(50pt, weak: true)
    text(size: large-size, weight: 700, title)
    v(25pt, weak: true)
    text(size: footnote-size, subtitle)
    v(50pt, weak: true)
  }))
  align(center,
    for author in authors {
      let keys = ("title", "name")
  
      let dept-str = keys
        .filter(key => key in author)
        .map(key => author.at(key))
        .join(", ")
  
      smallcaps(dept-str)
      linebreak()
  
      v(12pt, weak: true)
    }
  )

  // Configure paragraph properties.
  set par(first-line-indent: 0em, justify: true)
  show par: set block(spacing: 0.9em, below:14.0pt)

  // Display the abstract
  if abstract != none {
    v(50pt, weak: true)
    set text(script-size)
    show: pad.with(x: 35pt)
    smallcaps[Abstract. ]
    abstract
  }

  // Display the article's contents.
  v(29pt, weak: true)
  body

  // Display the bibliography, if any is given.
  if bibliography-file != none {
    show bibliography: set text(8.5pt)
    show bibliography: pad.with(x: 0.5pt)
    bibliography(bibliography-file)
  }

  // The thing ends with details about the authors.
  show: pad.with(x: 11.5pt)
  set par(first-line-indent: 0pt)
  set text(7.97224pt)

  for author in authors {
    let keys = ("department", "organization", "location")

    let dept-str = keys
      .filter(key => key in author)
      .map(key => author.at(key))
      .join(", ")

    smallcaps(dept-str)
    linebreak()

    if "email" in author [
      _Email address:_ #link("mailto:" + author.email) \
    ]

    if "url" in author [
      _URL:_ #link(author.url)
    ]

    v(12pt, weak: true)
  }
  
}

