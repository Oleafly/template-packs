// cSpell:disable
#let part(
  title,
  number,
) = {
  page(
    numbering: none,
    margin: (bottom: 2cm, top: 2cm, left: 1.5cm, right: 1.5cm),
    [
      // 1. Temporarily neutralize your global heading rules (pagebreaks, giant numbers) 
      // so they don't break this page's centered formatting.
      #show heading.where(level: 1): it => it.body
      
      // 2. Insert a hidden heading out-of-flow specifically for the outline() to catch.
      #place(hide(heading(level: 1, outlined: true, numbering: none)[Part #number]))
      
      // 3. Your original visual formatting remains perfectly intact.
      #v(4cm)
      #align(center, text(size: 2.5em, weight: "bold")[Part #number])
      #align(center, text(weight: 300, size: 2.0em, title))
    ]
  )
  // pagebreak()
}

#let book(
  // The book's title.
  title: [Bridging the Gap between Computational and Experimental Nuclear Magnetic Resonance Spectroscopy in Nanostructured Materials],

  // The book's author.
  author: "Siebe Vanlommel",
  supervisors: none,

  // A dedication to display on the third page.
  dedication: none,

  // Details about the book's publisher that are
  // display on the second page.
  publishing-info: none,

  // The book's content.
  abbreviations: none,
  quote: none,
  preface: none,
  AIuse: none,
  summary: none,
  samenvatting: none,
  papers: none,
  allpapers: none,
  talks: none,
  posters: none,
  software: none,
  acknowledgements: none,
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)
  let part2 = "A Collection of Papers"

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(size: 11.0pt)

  // Configure the page properties.
  set page(
    width: 16cm,
    height: 24cm,
    margin: (bottom: 2cm, top: 2cm, left: 2cm, right: 2cm),
  )
  
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

  let titles_roman = (
    "Summary (EN)", "Summary (NL)", "List of Symbols",
    "List of Abbreviations",
  )

  set par(leading: 0.78em, first-line-indent: 0pt, justify: true)

  {
  set page(margin: (left: 1in, right: 1in))

  align(bottom + left)[This research has been conducted at the Center for Molecular Modeling (CMM, Ghent University, prof. dr. Veronique Van Speybroeck) in collaboration with ...]
  pagebreak()
  }


  // Table of contents
  // Configure heading numbering
pagebreak(to: "odd")
if quote != none {
    quote
    pagebreak()
  }
  set heading(numbering: "1.1")
  show outline.entry.where(level: 1): set outline.entry(fill: none) // remove dots
  show outline.entry.where(level: 2): set outline.entry(fill: none) // remove dots
  show outline.entry.where(level: 3): set outline.entry(fill: none) // remove dots
  pagebreak(to: "odd")
  outline()

  //set page(
  //  numbering: numbering("i", 1),
  //  number-align: center,
  //)

  //page(numbering: none)[]
  page(numbering: none)[]
  //counter(page).update(1)
  
  
  pagebreak(to: "odd")
  counter(page).update(1)
  set page(
    numbering: numbering("i", 1),
    number-align: center,
  )
  if preface != none {
    heading(numbering: none, outlined: true, "Preface")
    preface
    pagebreak()
  }
  if AIuse != none {
    heading(numbering: none, outlined: true, "Use of Generative Artificial Intelligence")
    AIuse
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
  

  // List of Abbreviations
  if abbreviations != none {
    heading(numbering: none, outlined: true, [List of Abbreviations])
    table(
      columns: (auto, auto),
      inset: 4pt,
      stroke: none,
      align: (center, left),
      ..abbreviations.map(((abbr, full)) => (
        text(weight: 700, abbr),
        [#full]
      )).flatten()
    )
    pagebreak()
  }
 
  pagebreak(to: "odd")
  counter(page).update(1)
  part(title, "I")
  counter(heading).update(0)
  show heading.where(level: 1): it => {
    set page(
      numbering: "1",
      number-align: center
    )
    it
  }//svl added to here
  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 0pt, justify: true, spacing: 1.5em)

  // configure equations?
  set math.equation(
    numbering: it => {
    let count = counter(heading.where(level: 1)).at(here()).first()
    numbering("(1.1)", count, it)

    })

  // Configure page properties.
  set page( 
    numbering: numbering("1", 1), 
    number-align: center
  ) 

  set figure(numbering: it => {
    // let numbering-string = it.numbering
    let num_chapter = counter(heading).display().first()
    [#num_chapter.#it]
  })
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    v(1em) // Add some space before the table starts
    it.caption
    it.body
  }
  show figure.caption: it => {
    block(
      width: 80%,
      spacing: 0.9em,
      align(left,text(10pt, it)),
    )
    v(1em)
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      [Chapter #numbering(el.numbering, ..counter(heading).at(el.location()))]
    } else {
      it
    }
  } //svl added

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
      text(9em, weight: 300, number, fill: luma(70%))
      v(-10em)
      text(1.4em, weight: 700, it.body)
    })
    v(1em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    align(center, it)
    v(0.5em)
  }

  pagebreak()

  show cite: it => {
    show "[": ""
    show "]": ""
    super(it)
  }  //added to cite as superscripts (svl)

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
      text(9em, weight: 300, number, fill: luma(70%))
      v(-10em)
      text(1.4em, weight: 700, it.body)
    })
    v(1em)
  }

  // insert page for part II
  // page(v(10cm) + align(center, "part II"))
  // pagebreak()
  part(part2, "II")
  set heading(numbering: "A.1")

  let show-publication(
    index: none,
    title: none,
    authors: none,
    journal: none,
  ) = {
    v(0.1cm)
    grid(
      columns: (5em, auto),
      align: (top, top + left),
      text(weight: "bold", "Paper ") + text(weight: "bold", index),
      text(weight: "bold", title) + linebreak() +
      authors + linebreak() +
      journal
    )
  }

  let show-publication_pages(paper)={
    pagebreak(to: "odd") // svl added to put publication title page on odd number

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
        margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm), // was 2cm 2cm 2cm 2cm
        header: none,
      )
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
      // hidden-heading(level: 2, [Paper #number])

      v(3cm)
      align(
        center,
        text(size: 12pt)[#underline[Paper #number]],
      )
      v(0.5cm)
      align(center, text(size: 12pt, weight: "bold")[#title])
      v(0.5cm)
      align(center, authors)
      v(0.5cm)
      align(center, journal)
      v(4cm)

      align(center, contributor)

      align(bottom + center, text(size: 9pt)[
        #if copyright != none [Reprinted with permission.\
        #copyright]
        #if copyright == none [Copyright the Authors.]
      ])
    }

    publication-page(
        number: paper.at("number"),
        title: paper.at("title"),
        authors: paper.at("authors"),
        journal: paper.at("journal"),
        contributor: paper.at("contributor"),
        copyright: paper.at("copyright"),
        num_pages: paper.at("num_pages"),)
    pagebreak()

    //switch back to include entire paper, takes long to include!
    for i in range(1, paper.num_pages + 1) {
      let page_str = str(i)

      figure(
        image(paper.location + "/page_" + page_str + ".pdf", width: 120%) )
      }

  }

  let show-supporting_pages(paper)={
    pagebreak(to: "odd") // svl added to put publication title page on odd number
    let publication-page(
      number: "",
      title: "",
      authors: "",
      journal: "",
      contributor: "",
      copyright: "",
      num_pages: none,  // ignored
    ) = {
      v(1cm)
      align(
        center,
        text(size: 12pt)[#underline[Paper #number]],
      )
      v(0.5cm)
      align(center, text(size: 12pt, weight: "bold")[#title])
      v(0.5cm)
      align(center, authors)
      v(0.5cm)
      align(center, journal)
      v(4cm)

      align(center, contributor)
      v(1cm)
      align(bottom + center, text(size: 9pt)[
        #if copyright != none [Reprinted with permission.\
        #copyright]
        #if copyright == none [Copyright the Authors.]
      ])
    }

    publication-page(
        number: paper.at("number"),
        title: paper.at("title"),
        authors: paper.at("authors"),
        journal: paper.at("journal"),
        contributor: paper.at("contributor"),
        copyright: paper.at("copyright"),
        num_pages: paper.at("num_pages"),)
    pagebreak()

    //switch back to include entire paper, takes long to include!
  for i in range(1, paper.num_pages + 1) {
    let page_str = str(i) 
    figure(
      image(paper.location + "/page_" + page_str + ".pdf", width: 120%) ) // was 120%
    }
    //figure(
    //  image(paper.location + "/page_"+"001"+".svg", width: 130%)
    //)
    pagebreak()

  }

  let to_roman(num) = {
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

  let show-contributions(
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

  let show-software(
    index: none,
    name: none,
    description: none,
  ) = {
    v(0.1cm)
    grid(
      columns: (2em, auto),
      align: (top, top + left),
      text(index),
      text(weight: "bold", name) + linebreak() +
      text(description)
    )
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
    hidden-heading(level: 2, [Paper #number])

    // v(3cm)
    // align(
    //   center,
    //   text(size: 12pt)[#underline[Paper #number]],
    // )
    v(0.5cm)
    align(center, text(size: 12pt, weight: "bold")[#title])
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

  
 // pagebreak()

  for i in array.range(papers.len()) {
    let paper = papers.at(i)
    let roman_i =  to_roman(i + 1)
    show-publication(
      index: roman_i,
      title: paper.title,
      journal: paper.journal,
      authors: paper.authors,
    )
  }

  for i in array.range(papers.len()) {
    let paper = papers.at(i)
    show-publication_pages(paper) // comment for draft
    show-supporting_pages(paper.supp) // comment for draft
  }

  //heading(level: 1, outlined: true, "Appendix") 

  heading(level: 1, outlined: true, "List of Publications and Pre-prints")
  for i in array.range(allpapers.len()) {
    let paper = allpapers.at(i)
    let roman_i =  to_roman(i + 1)
    show-publication(
      index: roman_i,
      title: paper.title,
      journal: paper.journal,
      authors: paper.authors,
    )
  }
  
  heading(level: 1, outlined: true, "List of Conference Contributions")
  heading(level: 2, outlined: true, "Oral presentations")

  for i in array.range(talks.len()) {
    show-contributions(index: str(i + 1), ..talks.at(i))
  }

  heading(level: 2, outlined: true, "Poster presentations")

  for i in array.range(posters.len()) {
    show-contributions(index: str(i + 1), ..posters.at(i))
  }

  heading(level: 1, outlined: true, "List of used Software Packages")
  v(20pt)

  for i in array.range(software.len()) {
    show-software(index: str(i + 1), ..software.at(i))
  }

  set page(
    header: none,
    margin: (bottom: 2cm, top: 2cm, left: 2cm, right: 2cm),
  )
  heading(level: 1, outlined: true, "Bibliography")
  v(1cm)

  //pagebreak()
  
  bibliography(title:none, style: "nature", "references.bib")

  if acknowledgements != none {
    pagebreak()
    acknowledgements
  }
  show heading: it => {
    pagebreak(to: "odd")
    v(1em)
    text(20pt, weight: 500, it.body)
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

