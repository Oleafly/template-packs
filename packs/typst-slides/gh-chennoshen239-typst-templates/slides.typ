#import "@preview/touying:0.6.1": *
// #import "@preview/frame-it:2.0.0": *
#import themes.simple: *

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

#show cite: set text(fill: blue)


#show: simple-theme.with(
  aspect-ratio: "16-9",
  header: [Header],
  footer: [Footer],
  primary: red.darken(10%),
)

#set math.equation(numbering: "(1)")
#set text(size: 21pt,)

#let theorem = thmbox("theorem", "Theorem", fill: red.lighten(90%), base_level: 2)
#let proposition = thmbox("proposition", "Proposition", fill: blue.lighten(90%), base_level: 2)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  titlefmt: strong,
  base: "theorem",
)
#let lemma = thmbox("lemma", "Lemma", fill: orange.lighten(90%), base_level: 2)
#let definition = thmbox("definition", "Definition", base_level: 2, fill: teal.lighten(80%))
#let example = thmbox("example", "Example", titlefmt: strong, fill: green.lighten(90%), base_level: 2)

#let proof = thmproof("proof", "Proof")


#title-slide[
  = *Slides Title*
  #v(2em)

  Author 1#footnote[Institute 1] #h(2em)
  Author 2#footnote[Institute 2] \
  #v(1.5em)

  #datetime.today().display() \

]

= Section 1

== Example
#lorem(50)

#focus-slide[
  Focus Here!
]
== Example 2

#theorem[OLS][
  #lorem(50)
]<thm:1>


== Example 3
Let's refer to @thm:1

#lorem(100)
