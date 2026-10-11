#let callout(content) = box(
  fill: rgb("#bae6fd"),
  stroke: 0.8pt + rgb("#1d4ed8"),
  inset: 6pt,
  radius: 4pt,
  content
)

#let project(title: "", authors: (), date: none, body) = {
  let heading_numbering = "I.1.a."
  set footnote(numbering: "(1)")
  set document(author: authors, title: title)
  set page(numbering: "1/1", number-align: center)
  set text(font: "Libertinus Serif", lang: "en", hyphenate: true)
  set heading(numbering: heading_numbering)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]
  
  // Run-in subheadings
  show heading: it => {
    if it.level >= 4 {
      parbreak()
      text(11pt, weight: "regular", smallcaps(it.body))
      linebreak()
    } else {
      it
    }
  }

  show outline.entry.where(
    level: 1
  ): it => {
    v(20pt, weak: true)
    strong(it)
  }

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, strong(author))),
    ),
  )
  columns[
    #show heading.where(level: 1): it => place(
      top + center,
      scope: "parent",
      float: true,
      it
    )
    #outline(indent: 5%, target: 
      heading.where(level: 1)
        .or(heading.where(level: 2))
        .or(heading.where(level: 3)))
  ]
  pagebreak()

  // Main body.
  set par(justify: true, first-line-indent: 1em, spacing: 0.65em)
  let author_names = authors.join(", ")

  set page(
    header: context {
      counter(footnote).update(0)
      
      let page = here().page()
      if page == 2 { return }

      let heading_query = selector(heading.where(level: 1))

      let matching_pages = query(heading_query).map(m => m.location().page())

      // Do not show header if new h1 is introduced on this page
      if page in matching_pages {return}
      
      let selector = heading_query.before(here())
      let heading = query(selector).last()
      
      [#counter(selector).display(heading_numbering) #smallcaps(heading.body)]
    },
    footer: context smallcaps[
      #title - #author_names
      #h(1fr)
      #counter(page).display(page.numbering, both: true)
    ]
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    align(center, it)
    v(1em)
  }

  body
}