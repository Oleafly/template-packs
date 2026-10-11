#import "@preview/numbly:0.1.0": numbly
#import "@preview/hydra:0.6.2": hydra, anchor

// Define color palette
#let main-color = rgb("#239423")
#let math-color = rgb("#e6870a")
#let code-color = rgb("#800080")

// Define horizontal rules
#let hor-rule(color: black, stroke: 1.5pt) = [
  #line(length: 100%, stroke: stroke + color)
]
#let big-rule(color: main-color, stroke: 15pt) = [
  #line(length: 100%, stroke: stroke + color)
]

#let apply-format(
  name: "Title",
  description: none,
  dark: false,
  body,) = [
  // TODO implement dark mode
  // Set the page size and margins
  #set page(paper: "a4")
  #set page(margin: (
    top: 2cm, bottom: 2cm, x: 2cm)
  )
  // Define the standard font
  #set text(size: 11pt)

  #set page(header: anchor())

  #set page(footer: context[
    #align(right)[
      #counter(page).display(
        "I",
      )
    ]
  ])

  #set enum(
    full:true, 
    numbering: numbly("{1:1}.", "{2:(a)}", "{3:(i)})")
  )
  

  // Title block
  #big-rule()
  #v(-0.25em)
  #hor-rule()
  #align(center)[
    #text(
      name,
      size: 2.5em,
      weight: "bold",
    )
    #linebreak()
    // Author
    #text(
      "Moritz Gerhardt",
      size: 1.5em,
      weight: "bold",
      fill: black,
    )
    
    // GitHub link
    #link(
      "https://github.com/moricetamol"
    )[
      #box(
        image("github-mark.svg", height: 1.5em)
      ) #text(baseline: -0.5em)[
          *`moricetamol`*
      ]
    ]
  ]
  #hor-rule()
  
  #set heading(numbering: (..numbers) => [
      #let level = numbers.pos().len()
      #if (level == 1) {
        return numbering("I -", numbers.pos().at(level - 1))
      } else if (level == 2) {
        return numbering("1 -", numbers.pos().at(level - 1))
      } else if (level == 3) {
        return numbering("(a) -", numbers.pos().at(level - 1))
      }
    ]
  )
  // Heading settings
  #show heading.where(level: 1): head => [
    #set align(center)
    #big-rule()
    #v(-0.6em)
    #hor-rule()
    #if (head.numbering != none) {
      counter(heading).display(
        head.numbering
      )
    }
    #head.body
    #v(-0.75em)
    #hor-rule()
  ]
  #show heading.where(level: 2): head => [
    #set align(left)
    #counter(heading).display(
      head.numbering
    )
    #head.body
    #v(-0.7em)
    #hor-rule(color: main-color.darken(10%))
    #v(-1em)
    #hor-rule(color: main-color.darken(10%))
  ]
  #show heading.where(level: 3): head => [
    #set align(left)
    #counter(heading).display(
      head.numbering
    )
    #head.body
    #v(-0.7em)
    #hor-rule(color: main-color.darken(10%))
  ]
  #set heading(bookmarked: true)
  #set heading(outlined: true)
  #set heading(supplement: none)

  #show link: underline
  #show link: set text(fill: blue, weight: "bold")

  #show ref: it => {
    let el = it.element
    // Skip all other references.
    if el == none or el.func() != heading { return it }

    if el.func() == heading {
      return link(
        el.location(),
        // counter(heading).display(el.numbering) + " " + 
        el.body
      )
    }
  }

  #v(-0.75em)
  #description
  #body
]