#import "template/lib.typ": paris-saclay-thesis, prune
#import "minitoc.typ": *
#import "algo.typ": algo, comment, d, i

///////////////////////////////////////////
///////////////////////////////////////////
// 1/3 If not already done, download the
//     "New Computer Modern This" font (see README)
///////////////////////////////////////////

///////////////////////////////////////////
// 2/3 Change the value of the following
//     parameters to edit the first two pages.
//     All parameters have a default value, so
//     you can remove some to highlight which
//     ones are still missing.
///////////////////////////////////////////

#show: paris-saclay-thesis.with(
  candidate-name: [Name],
  title-fr: [Title],
  title-en: [Title],
  keywords-fr: (
    "apprentissage profond",
    "modélisation spatio-temporelle",
    "interprétabilité",
    "réseaux de neurones informés par la physique",
    "optimisation géométrique",
  ),
  keywords-en: (
    "deep learning",
    "spatio-temporal modeling",
    " interpretability",
    "physics-informed neural networks",
    "geometric optimization",
  ),
  abstract-fr: [#lorem(60)],
  abstract-en: [#lorem(60)],
  NNT: [1955UPASX000],
  doctoral-school: [École doctorale n°580, sciences et technologies de l'information et de la communication (STIC)],
  doctoral-school-code: "STIC", // for the logo to insert
  specialty: [Spécialité de doctorat: Informatique],
  graduate-school: [Graduate School : Informatique et sciences du numérique],
  university-component: [Référent : Faculté des sciences d'Orsay],
  research-unit-and-advisors: [
    Thèse préparée dans le *Laboratoire Interdisciplinaire des Sciences du
    Numérique (LISN)*, sous la direction de *YOUHOU LES AMIS*, Maitre de conférence et le co-encadrement de *WAOUH LES AMIS*, Maitre de conférence
  ],
  defense-date: [20 octobre 1955],
  thesis-examiners: (
    (
      name: [*Aragorn*],
      title: [Roi du Gondor],
      status: [Président],
    ),
    (
      name: [*Legolas*],
      title: [Prince des Elfes Sylvains],
      status: [Rapporteur &\ Examinateur],
    ),
    (
      name: [*Gimli*],
      title: [Guerrier du royaume d'Erebor],
      status: [Rapporteur &\ Examinateur],
    ),
    (
      name: [*Faramir*],
      title: [Intendant du Gondor],
      status: [Examinateur],
    ),
  ),
  // You can also adjust spacings in the first page with
  // `vertical-spacing-1` to `vertical-spacing-5`
  // and `horizontal-spacing-1` to `horizontal-spacing-2`
)

///////////////////////////////////////////
// 3/3 Starting from here, the third page,
//     no formatting is imposed.
//     However here are some tweaks you
//     might like.
///////////////////////////////////////////

// Switch to a serif font family, size 11



#set text(
  font: "New Computer Modern",
  size: 11pt,
)

// Show links in blue

#show link: set text(fill: blue)

// Show numbers in references (to a bibliography entry, a section, a figure) in blue
// thanks Eric Biedert https://github.com/typst/typst/discussions/4143

#show cite: it => {
  // reference to a bibliography entry -> color only the number, not square brackets, not the potential supplement
  show regex("\["): set text(fill: black) // enforce square brackets in black
  show regex("^\[(\d+)"): set text(fill: blue) // only the first number, in case there is a number in the supplement
  it
}
#show ref: it => {
  if it.element == none {
    // reference to a bibliography entry -> manage by `#show cite` above
    return it
  }
  // reference to a section or a figure
  show regex("[\d]+[\.]?[\d]*[\.]?[\d]*"): set text(fill: blue) // find something like "1", "1.2" or "1.3"
  it
}

// Figure legends in italic and with smaller font size

#show figure.caption: it => [
  #text(size: 10pt, style: "italic")[#it]
]

// Headings numbering & refer to a section with "Chapitre X" instead of "Section X"

#set heading(numbering: "1.1", supplement: "Chapter")

// Refer to an equation with "Équation X" instead of "Equation X"

#set math.equation(supplement: "Equation")

// Set figure supplement to English (tables inside figures inherit this)
// Enable automatic figure placement for better space optimization (like LaTeX floats)
#set figure(supplement: "Figure", placement: auto)

// Tables: fixed position (no floating) with consistent formatting
#show figure.where(kind: table): set figure(supplement: "Table", placement: none)
#show figure.where(kind: table): set figure.caption(position: top)

// Table styling: clean academic format with horizontal rules (booktabs style)
#set table(
  inset: 6pt,
  align: (x, y) => if y == 0 { center } else { left },
  stroke: (x, y) => (
    top: if y == 0 { 1.5pt + black } else if y == 1 { 0.75pt + black } else { 0pt },
    bottom: 1.5pt + black,
    left: 0pt,
    right: 0pt,
  ),
)
#show table: set text(size: 10pt)
#show table.cell.where(y: 0): set text(weight: "bold")

// Headings formatting

#let heading_text_size = (none, 18pt, 15pt, 12pt, 11pt) // for each heading level
#show heading.where(level: 1): header => {
  // Skip rendering for Part headings (unnumbered) - they only appear in outline
  if header.numbering == none {
    // Return nothing visible - the part-page function handles the visual
    return
  }

  set text(
    size: heading_text_size.at(1),
    fill: prune,
    font: "New Computer Modern",
    weight: "bold",
  )
  let number = context counter(heading).display("1 • ") // prefix format
  pagebreak(weak: true) // start level 1 headings on a new page

  // Add large chapter number on the right, aligned with heading (not in outline)
  context {
    if header.numbering != none {
      place(
        right + top,
        dx: 2cm,
        dy: -45pt,
        text(
          size: 100pt,
          fill: prune.lighten(70%),
          font: "New Computer Modern",
        )[
          #counter(heading).display(header.numbering)
        ],
      )
    }
  }

  block(breakable: false)[
    #align(center)[
      #upper(header.body)
    ]
    #v(10pt)
    #line(length: 100%, stroke: 1pt + prune)
  ]
  v(heading_text_size.at(1)) // same height spacing as the font size
}
#show heading.where(level: 2): header => {
  set text(
    size: heading_text_size.at(2),
    font: "New Computer Modern",
    weight: "bold",
  )
  pagebreak(weak: true) // start level 2 headings on a new page
  v(heading_text_size.at(2)) // same height spacing as the font size
  block(breakable: false, below: heading_text_size.at(2))[
    #counter(heading).display()~
    #upper(header.body)
  ]
}
#show heading.where(level: 3): header => {
  set text(
    size: heading_text_size.at(3),
    font: "New Computer Modern",
    weight: "bold",
  )
  v(heading_text_size.at(3)) // same height spacing as the font size
  block(breakable: false, below: heading_text_size.at(3))[
    #h(10pt) // small indent
    #counter(heading).display()~
    #header.body
  ]
}
#show heading.where(level: 4): header => {
  set text(
    size: heading_text_size.at(4),
    font: "New Computer Modern",
    weight: "bold",
  )
  v(heading_text_size.at(4)) // same height spacing as the font size
  block(breakable: false, below: heading_text_size.at(4))[
    #h(20pt) // indent for level 4
    #counter(heading).display()~
    #header.body
  ]
}

// Headings formatting in the outline

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true) // small spacing before
  // Check if it's a Part entry (no numbering) - style in prune
  if it.element.numbering == none {
    text(fill: prune, weight: "bold", size: 12pt)[#it]
  } else {
    strong(it) // regular chapter in bold
  }
}
#show outline.entry.where(level: 3): it => {
  text(size: 10pt)[#it] // slightly smaller
}



// Footer with the page number

#set page(footer: context [
  #set align(center)
  #text(
    fill: black,
    size: 12pt,
    weight: "regular",
  )[
    #counter(page).display("1")
  ]
])

// Text justification

#set par(
  justify: true,
  linebreaks: "optimized",
)

// A "Remarque : " text box

#let remarque(number: none, body) = {
  block(stroke: (left: 1pt), inset: 0.5em)[
    #smallcaps[Remarque #number :] #body
  ]
}

// "En résumé" & "Publications et communications scientifiques" boxes

#import "@preview/colorful-boxes:1.4.1": colorbox

#let en_résumé(body) = {
  colorbox(
    title: text(font: "New Computer Modern")[En résumé],
    radius: 2pt,
    width: auto,
    color: "default",
  )[
    #body
    #v(2pt)
  ]
}

#let publications(body) = {
  colorbox(
    title: text(font: "New Computer Modern")[Publications et communications scientifiques],
    radius: 2pt,
    width: auto,
    box-colors: (
      prune: (stroke: prune, fill: white, title: white),
    ),
    color: "prune",
  )[
    #body
    #v(2pt)
  ]
}

// Display the outline




#outline(
  title: [Contents],
  indent: 5em,
  depth: 3, // Show up to X.X.X
  target: selector(heading).after(<part1>).before(<part2>),
)


///////////////////////////////////////////
// Write your thesis below. Bon courage !
///////////////////////////////////////////

// Part separator helper
#let part-page(number, title) = {
  pagebreak(weak: true)
  // Invisible heading for outline only (rendering is skipped by show rule)
  heading(level: 1, numbering: none, outlined: true)[Part #number — #title]
  set page(header: none, footer: none)
  align(center + horizon)[
    #text(size: 24pt, fill: prune, weight: "bold")[Part #number]
    #v(1em)
    #text(size: 32pt, fill: prune, weight: "bold")[#title]
    #v(2em)
    #line(length: 50%, stroke: 2pt + prune)
  ]
}

// Part separator helper for unnumbered parts (Introduction, Conclusion)
#let part-page-unnumbered(title) = {
  pagebreak(weak: true)
  // Invisible heading for outline only (rendering is skipped by show rule)
  heading(level: 1, numbering: none, outlined: true)[#title]
  set page(header: none, footer: none)
  align(center + horizon)[
    #text(size: 32pt, fill: prune, weight: "bold")[#title]
    #v(2em)
    #line(length: 50%, stroke: 2pt + prune)
  ]
}

#metadata("Part 1") <part1>

#part-page-unnumbered("Introduction")
// #include "chapters/introduction.typ"

// ═══════════════════════════════════════════════════════════════════════════════
// PART I: Pesticide Exposure — Data and Context
// ═══════════════════════════════════════════════════════════════════════════════
#part-page("I", "Pesticide Exposure : Data and Context")

#include "chapters/chapter_template.typ"


// ═══════════════════════════════════════════════════════════════════════════════
// PART II: Estimators
// ═══════════════════════════════════════════════════════════════════════════════
#part-page("II", "Estimators")


// #include "chapters_example.typ"


// ═══════════════════════════════════════════════════════════════════════════════
// PART III: Beyond Predictions
// ═══════════════════════════════════════════════════════════════════════════════
#part-page("III", "Beyond Predictions")


#part-page-unnumbered("Conclusion")

// #include "chapters_conclusion.typ"

= Bibliography
#bibliography("Bibliography.bib", title: [Bibliography])

#metadata("Part 2") <part2>

// Switch to appendix numbering (A, B, C...)
#set heading(numbering: "A.1")
#counter(heading).update(0)  // Reset counter to start at A

// #include "appendix/appendix_B.typ"





