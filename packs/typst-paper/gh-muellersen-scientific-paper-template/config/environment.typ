#let title_page(
  content,
  title: "",
  authors: (),
  first_corrector: "",
  second_corrector: "",
  institution: "",
  paper_kind: "",
  showOutline: true,
  showTitlePage: true,
  abstract: none,
) = {
  // configuration
  let authorNames = authors.map(author => author.name)
  set document(
    title: title,
    author: authorNames,
  )
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "de",
  )
  set heading(numbering: "1.1.1")
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2cm),
  )
  set block(spacing: 1.2em)
  set par(
    justify: true,
    leading: 1em,
    spacing: 1em,
    first-line-indent: (
      amount: 1em,
      all: false
    ),
  )
  
  // configure figures
  show figure.caption: it => [
    #strong[#it.supplement #context[#it.counter.display()]:] #it.body
  ]
  show figure: set block(
    above: 1.8em,
    below: 1.8em
  )
  

  // configure how code is displayed
  set raw(theme: "light+.tmTheme")
  let style-number(number) = text(luma(120))[#number]
  show raw.where(block: true): it => align(center, grid(
    columns: 2,
    align: (right, left),
    gutter: 0.5em,
    ..it.lines
      .enumerate()
      .map(((i, line)) => (style-number(i + 1), line))
      .flatten()
  ))
  show raw: it => {
    if it.block {
      block(
        fill: luma(240),
        pad(text(it, size: 1.1em), left: 2%, right: 2%, rest: 10%)
      )
    } else {
      highlight(text(it, size: 1.1em), fill: luma(240), top-edge: "ascender", bottom-edge: "descender")
    }
  }

  show footnote.entry: set text(size: 8pt)

  // MARK: Title
  // configure title page
  if showTitlePage == true {
    
    set align(center)
    image("logo.jpg", alt: "logo", width: 40%)
    v(40pt)
    text(19pt, title, weight: "bold")
    linebreak()
    v(5pt)
    text(14pt, paper_kind)
    v(60pt)

    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 24pt,
      ..authors.map(author => [
        #text(author.name, weight: "bold", 16pt) \
        #text("Matrikelnummer: " + author.matr_nr, 11pt) \
        #text("E-Mail: " + link("mailto:" + author.email), 11pt) \
        
      ]),
    )
    if institution != "" {
      v(40pt)
      text(institution, 14pt)
    } else {
      none
    }
    v(1pt)
    text(datetime.today().display("[day].[month].[year]"), 14pt)

    if first_corrector != "" {
      v(150pt)
      grid(
        rows:  (auto, auto),
        row-gutter: 5pt,
        [#text("Erster Prüfer: " + first_corrector, 14pt) \
        #text("Zweiter Prüfer: " + second_corrector, 14pt)]
      )
    }

    pagebreak()
  }

  if abstract != none {
    block(width: 85%)[#abstract]
  }

  set align(left)
  show outline.entry.where(
    level: 1,
  ): it => {
    v(20pt, weak: true)
    strong(it)
  }
  if showOutline == true {
    outline()
    pagebreak()
  }

  set page(
    numbering: "1"
  )
  set heading(numbering: "1.1")
  show heading: set block(above: 1.8em, below: 1em)
  show heading: it => block(counter(heading).display() + h(1em) + it.body)
  counter(page).update(1)

  show heading.where(level: 5): it => {
    set heading(outlined: false)
    strong(it.body + ".") + h(1em)
  } 
  show ref: it => {
    let headingRef = heading
    let element = it.element
    if element != none and element.func() == heading and element.level == 5 {
      link(element.location(), it.supplement)
    } else {
      it
    }
  }

  // configure math refs
  set math.equation(numbering: num => "(" + str(num) + ")", supplement: none)
  
  columns(1, content)
}

#let abstract(body) = {
  align(center, text(1em, weight: 600, [Abstract]))
  align(
    center,
    text[
      #body
    ],
  )
  v(1em)
}
