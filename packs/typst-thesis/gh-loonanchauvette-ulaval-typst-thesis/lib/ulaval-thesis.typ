// Université Laval thesis template for Typst.
// Independent implementation based on FESP rules, the official Word template,
// and ulthese 7.0. It is not an official Université Laval template.

#let ulaval-blue = rgb("#00004d")

#let chapter-numbering(..numbers) = {
  let numbers = numbers.pos()
  if numbers.len() == 1 {
    [Chapitre #numbering("1", ..numbers)]
  } else {
    numbering("1.1", ..numbers)
  }
}

#let appendix-numbering(..numbers) = {
  let numbers = numbers.pos()
  if numbers.len() == 1 {
    [Annexe #numbering("A", ..numbers)]
  } else {
    numbering("A.1", ..numbers)
  }
}

#let single-spaced(body) = {
  set par(leading: 0.2em, spacing: 0.65em)
  body
}

#let long-quote(body) = block(
  inset: (left: 10mm, right: 10mm),
  above: 0.8em,
  below: 0.8em,
  single-spaced(body),
)

#let frontispiece(
  title: none,
  subtitle: none,
  author: none,
  document-type: "Thèse",
  supervisor: none,
  co-supervisors: (),
  heading-font: "Nimbus Sans",
) = {
  set page(numbering: none)
  set par(justify: false, leading: 0.2em, spacing: 0em)
  set align(center)

  // Absolute positions reproduce the downloaded FESP LibreOffice frontispiece.
  place(center + top, dy: 25.4mm, block(width: 100%)[
    #text(font: heading-font, size: 20pt, weight: "bold", title)
    #if subtitle != none {
      linebreak()
      text(font: heading-font, size: 17pt, weight: "bold", subtitle)
    }
  ])
  place(center + top, dy: 59mm)[
    #text(font: heading-font, size: 14pt, weight: "bold", document-type)
  ]
  place(center + top, dy: 89mm)[
    #text(font: heading-font, size: 14pt, weight: "bold", author)
  ]
  place(center + top, dy: 129mm)[
    #text(font: heading-font, size: 14pt)[Sous la direction de :]
  ]
  place(center + top, dy: 141mm, block(width: 100%)[
    #text(font: heading-font, size: 14pt, supervisor)
    #for person in co-supervisors {
      linebreak()
      text(font: heading-font, size: 14pt, person)
    }
  ])
  v(1fr)
  pagebreak()
}

#let front-matter(body) = {
  set page(numbering: "i", number-align: center + bottom, footer-descent: 10mm)
  counter(page).update(2)
  body
}

#let main-matter(body) = {
  pagebreak(weak: true)
  set page(numbering: "1", number-align: center + bottom, footer-descent: 10mm)
  counter(page).update(1)
  body
}

#let appendices(body) = {
  set heading(numbering: appendix-numbering)
  counter(heading).update(0)
  body
}

#let part(title, body) = {
  heading(level: 1, numbering: none, outlined: true, title)
  // Subdivisions of unnumbered parts must not acquire misleading 0.x labels.
  set heading(numbering: none)
  body
}

#let article-chapter(
  title: none,
  french-abstract: none,
  abstract: none,
  abstract-language: "en",
  body,
) = {
  heading(level: 1, title)
  heading(level: 2)[Résumé]
  french-abstract
  if abstract != none {
    heading(level: 2)[Abstract]
    text(lang: abstract-language, abstract)
  }
  body
}

#let contents-list(title: [Table des matières]) = {
  heading(level: 1, numbering: none, outlined: true, title)
  // The official ODT keeps every contents level flush left.
  single-spaced(outline(title: none, indent: 0pt))
}

#let figure-list(title: [Liste des figures]) = {
  heading(level: 1, numbering: none, outlined: true, title)
  single-spaced(outline(title: none, target: figure.where(kind: image)))
}

#let table-list(title: [Liste des tableaux]) = {
  heading(level: 1, numbering: none, outlined: true, title)
  single-spaced(outline(title: none, target: figure.where(kind: table)))
}

#let dedication(body) = {
  pagebreak(weak: true)
  v(15em)
  align(right, emph(body))
  pagebreak()
}

#let epigraph-page(quote, attribution: none) = {
  pagebreak(weak: true)
  v(15em)
  align(right, block(width: 65%)[
    #quote
    #if attribution != none {
      v(0.8em)
      align(right)[— #attribution]
    }
  ])
  pagebreak()
}

#let thesis(
  title: none,
  subtitle: none,
  author: none,
  document-type: "Thèse",
  supervisor: none,
  co-supervisors: (),
  date: datetime.today(),
  language: "fr",
  font: "Nimbus Sans",
  heading-font: "Nimbus Sans",
  body,
) = {
  set document(title: title, author: author, date: date)
  set page(
    paper: "us-letter",
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 30mm),
    numbering: none,
    number-align: center + bottom,
    footer-descent: 10mm,
  )
  set text(font: font, size: 11pt, lang: language)
  set par(justify: true, leading: 0.5em, spacing: 12pt)
  set heading(numbering: chapter-numbering, hanging-indent: 0pt)
  set figure(gap: 0.65em)
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt))

  show link: set text(fill: ulaval-blue)
  show outline: set par(leading: 0.2em, spacing: 0.5em)
  show list: set par(leading: 0.2em, spacing: 0.45em)
  show enum: set par(leading: 0.2em, spacing: 0.45em)
  show footnote.entry: set text(size: 8.5pt)
  show footnote.entry: set par(leading: 0.2em, spacing: 0.35em)
  show bibliography: set par(leading: 0.2em, spacing: 0.55em)

  show heading: it => {
    if it.level == 1 {
      pagebreak(weak: true)
      block(width: 100%, above: 0pt, below: 1.2em, breakable: false)[
        #set align(left)
        #if it.numbering != none {
          text(font: heading-font, size: 16pt, weight: "bold")[
            #counter(heading).display(it.numbering) #h(0.35em) #it.body
          ]
        } else {
          text(font: heading-font, size: 16pt, weight: "bold", it.body)
        }
      ]
    } else if it.level == 2 {
      block(above: 1.05em, below: 0.5em, breakable: false)[
        #text(font: heading-font, size: 14pt, weight: "bold", style: "italic", it)
      ]
    } else if it.level == 3 {
      block(above: 1em, below: 0.45em, breakable: false)[
        #text(font: heading-font, size: 14pt, weight: "bold", it)
      ]
    } else {
      block(above: 0.8em, below: 0.4em, breakable: false)[
        #text(font: heading-font, size: 12pt, weight: "bold", style: "italic", it)
      ]
    }
  }

  frontispiece(
    title: title,
    subtitle: subtitle,
    author: author,
    document-type: document-type,
    supervisor: supervisor,
    co-supervisors: co-supervisors,
    heading-font: heading-font,
  )
  body
}
