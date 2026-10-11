// Template - University of Vienna | Universität Wien - Typst version
#import "lib.typ": template-univie, title-block, title-logo

// Author configuration
#let author-name = "Author Name"
#let author-email = "author.name@univie.ac.at"

// Custom commands matching LaTeX definitions
#let todo(content) = text(fill: orange)[\<TODO: #content\>]
#let needcite = text(fill: red)[[CITATION NEEDED]]
#let tempval = text(fill: red)[XX]

// Apply template
#show: template-univie.with(author-name: author-name, author-email: author-email)

// Title page logo
#title-logo

// Title, author, date — matching \maketitle
#title-block(
  [Amazing Title],
  author: author-name,
  email: author-email,
)

// Table of contents
#outline(
  title: [Contents],
  indent: 0pt,
  depth: 2,
)

= Template

== Fonts

In this example the #text(size: 24pt)[huge font size] is set and the #text(size: 8pt)[foot note size also]. A command is used #text(font: "Inria Serif")[to change the style of a sentence].

#lorem(100)

== Mathematics

$ S_n = (X_1 + X_2 + dots.c + X_n)/n = 1/n sum_(i)^(n) X_i $

== Tables

#align(center)[
  #table(
    columns: 3,
    stroke: 1pt,
    [Cell 1], [Cell 2], [Cell 3],
    [Cell 4], [Cell 5], [Cell 6],
    [Cell 7], [Cell 8], [Cell 9],
  )
]

== Example 1

#footnote[Tiny little footnote]#lorem(50)

== Example 2

A link to the #link("https://www.univie.ac.at")[homepage of the University of Vienna].

#lorem(50)

+ Like this,
+ and like this.

- Like this,
- and like this.

#lorem(100)

#bibliography("refs.bib", title: "References", style: "ieee")