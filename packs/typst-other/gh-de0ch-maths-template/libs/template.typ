#import "@preview/commute:0.3.0": node, arr, commutative-diagram

#let color_style = "./color.typ"
#let link_color = rgb(0, 0, 255)
#if color_style == "./bw.typ" {
  link_color = rgb(0, 0, 0)
}


#let textwidth = 100%;
#let img(path, width: textwidth) = {
  align(center, image("../imgs/cat/" + path + ".jpg", width: width))
}

#let bd(term) = [ $bold(#term)$]
#let veck = [$bold("Vect")_k$]
#let homk = [$op("Hom")_k$]
#let Tor = [$"Tor"$]
#let End(c) = [$op("End")_cal(#c)$]
#let Ext = [$"Ext"$]

#let TODO = text(blue)[TODO]


#let fw(doc) = box(width: 100%)[#doc]

#let proof(title: "Proof", term) = block(
  width: 100%,
  breakable: true,
)[_#title._ #term #h(1fr) $qed$]

#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Linux Libertine", lang: "en")

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, author)),
    ),
  )

  // Main body.
  set par(justify: true)
  set heading(numbering: "1.1.")
  set enum(numbering: "(1)")
  show ref: set text(link_color)
  show link: set text(link_color)
  body
}

#let tagged-equation(eq, tag) = {
  [#h(1fr) #eq #h(1fr) #tag]
}


#import color_style: *


