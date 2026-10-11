// Page layout and numbering configuration
// Note: Colors are defined in theme.typ

#import "theme.typ": primary-color, accent-color, secondary-color

#let setup-page(heading) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    header: context {
      if heading != none {
        text(size: 10pt, fill: gray)[#heading.title]
        h(1fr)
        text(size: 10pt, fill: gray)[Chapter #heading.number]
      }
    },
    footer: context {
      let pages = query(<pagecount>).first().final
      let current = here().page
      if current > 1 {
        text(size: 10pt, fill: gray)[#current]
        h(1fr)
        text(size: 10pt, fill: gray)[#pages]
      }
    },
    numbering: "i",
  )
}

#let setup-frontmatter(heading) = {
  set page(numbering: "i")
}

#let setup-mainmatter(heading) = {
  set page(numbering: "1")
  counter(page).update(1)
}

#let setup-backmatter(heading) = {
  set page(numbering: "i")
  counter(page).update(1)
}

// Chapter heading style
#let chapter-heading(it) = {
  v(3em)
  text(size: 24pt, weight: "bold", fill: primary-color)[
    #counter(heading).display().
    #it.title
  ]
  v(1em)
  it.body
  v(2em)
}

// Part heading style
#let part-heading(it) = {
  v(4em)
  align(center)[
    text(size: 32pt, weight: "bold", fill: primary-color)[
      Part #it.number
    ]
    v(1em)
    text(size: 28pt, weight: "medium", fill: secondary-color)[
      #it.title
    ]
  ]
  v(2em)
  it.body
  pagebreak()
}

// Section heading
#let section-heading(it) = {
  v(1.5em)
  text(size: 14pt, weight: "bold", fill: primary-color)[
    #counter(heading).display().
    #it.title
  ]
  v(0.5em)
}

// Subsection heading
#let subsection-heading(it) = {
  v(1em)
  text(size: 13pt, weight: "bold", fill: secondary-color)[
    #counter(heading).display().
    #it.title
  ]
  v(0.3em)
}