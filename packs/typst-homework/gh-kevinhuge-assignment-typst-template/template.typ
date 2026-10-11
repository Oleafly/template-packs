#let project(
  title: "",
  authors: (),
  abstract: none,
  keywords: (),
  lang: "en",
  region: "cn",
  body,
) = {
  let zh_sans = "PingFang SC"
  let en_sans_serif = "Avenir Next"
  let en_sans_fallback = "Helvetica Neue"
  let en_code = "Menlo"
  // Modify the following to change the font stack.
  let title-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let author-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let body-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let heading-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let caption-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let header-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let strong-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let emph-font = (en_sans_serif, en_sans_fallback, zh_sans)
  let raw-font = (en_code, zh_sans)
  let authors = authors.map(author => {
    if not ("name" in author) {
      panic("Each author must provide a `name`.")
    }
    if not ("student_id" in author) {
      panic("Each author must provide a `student_id`.")
    }

    (
      name: author.name,
      student_id: author.student_id,
      organization: if "organization" in author { author.organization } else { none },
      email: if "email" in author { author.email } else { none },
    )
  })

  set document(author: authors.map(author => author.name), title: title)
  set page(
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        align(left)[
          #set text(font: header-font)
          #title
        ]
      }
    },
  )
  set heading(numbering: "1.1")
  set text(font: body-font, lang: lang, region: region)
  set bibliography(style: "institute-of-electrical-and-electronics-engineers")
  counter("problem").update(0)
  counter("problem").step()

  show heading: it => box(width: 100%)[
    #v(0.50em)
    #set text(font: heading-font)
    #if it.numbering != none { counter(heading).display() }
    #h(0.75em)
    #it.body
  ]

  show heading.where(
    level: 1,
  ): it => box(width: 100%)[
    #v(0.5em)
    #set align(center)
    #set heading(numbering: "一")
    #it
    #v(0.75em)
  ]

  // Title
  align(center)[
    #block(text(font: title-font, weight: "medium", 1.75em, title))
    #v(0.5em)
  ]

  // Display the authors list.
  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center)[
        #text(12pt, author.name + " " + author.student_id, font: author-font)
        #if author.organization != none [
          \ #text(12pt, author.organization, font: author-font)
        ]
        #if author.email != none [
          \ #text(12pt, link("mailto:" + author.email), font: author-font)
        ]
      ])
    )

    if not is-last {
      v(16pt, weak: true)
    }
  }
  v(2em, weak: true)

  if abstract != none or keywords.len() > 0 [
    #set par(first-line-indent: 2em, justify: true)
    #if abstract != none [
      *Abstract.* #abstract
    ]
    #if keywords.len() > 0 [
      #v(0.75em, weak: true)
      *Keywords:* #keywords.join(", ")
    ]
    #v(1.5em, weak: true)
  ]

  set par(first-line-indent: 0em, justify: true)
  set enum(indent: 2em)
  set list(indent: 2em)
  set figure(gap: 0.8cm)
  let trailing-gap = v(0.8em, weak: true)

  show figure: it => [
    #v(12pt, weak: true)
    #set text(font: caption-font)
    #it
    #v(12pt, weak: true)
  ]

  show image: it => [
    #it
    #trailing-gap
  ]

  show list: it => [
    #it
    #trailing-gap
  ]

  show enum: it => [
    #it
    #trailing-gap
  ]

  show table: it => [
    #set text(font: body-font)
    #it
    #trailing-gap
  ]
  show strong: set text(font: strong-font)
  show emph: set text(font: emph-font)
  show ref: set text(red)
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
  )

  show raw.where(block: true): it => [
    #it
    #trailing-gap
  ]

  show raw: set text(font: raw-font)
  show link: underline
  show link: set text(blue)
  body
}

#let problem-counter = counter("problem")

#let problem(body) = context {
  problem-counter.step()
  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[#text(weight: "medium")[Exercise #problem-counter.display().] #h(0.75em) #body]
}


#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[#text(weight: "medium")[Solution.] #h(0.75em) #body]
}
