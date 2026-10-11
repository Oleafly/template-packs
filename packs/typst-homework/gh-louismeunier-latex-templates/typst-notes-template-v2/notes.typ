// ! setup
#import "@preview/ctheorems:1.1.3": *
#import "@preview/fontawesome:0.4.0": *
// ! font sizes
#let fontsizes = (
  normal: 12pt,
  section: 14pt,
  subsection: 12pt,
  large: 20pt,
  small: 8pt,
)
// ! colours
#let solarized = (
  yellow: rgb("#b58900"),
  orange: rgb("#cb4b17"),
  red: rgb("#dc322f"),
  magenta: rgb("#d33682"),
  violet: rgb("#6c71c4"),
  violetlight: rgb("#B6B8E2"),
  blue: rgb("#268bd2"),
  cyan: rgb("#2aa198"),
  cyanlight: rgb("#d4ecea"),
  green: rgb("#859900"),
  base2: rgb("#eee8d5"),
  gray: rgb("#f2f2f2"),
)

#let conf(
  course_code: none,
  course_title: none,
  subtitle: none,
  semester: none,
  professor: none,
  author: "Louis Meunier",
  cute: none,
  // abstract: [],
  doc,
) = {
  v(4em)
  set align(left)
  text(25pt, course_code, weight: "bold") + text(25pt, " - " + course_title)
  text(12pt, "\n" + subtitle)
  // if cute != none {
  //   // set align(center)
  //  figure(
  //     image(cute, width: 100%)
  //   )
  // }
  // set align(left)
  // fa-icon("cat")
  text(12pt, "\n\nBased on lectures from " + semester + " by " + professor + ".")
  text(12pt, "\nNotes by " + text(link("https://notes.louismeunier.net", author)))

  set par(
    first-line-indent: 1em,
    leading: 0.8em,
    linebreaks: "simple",
  )
  // text(font: "Font Awesome 6 Free Solid", "cat")
  // let count = authors.len()
  // let ncols = calc.min(count, 3)
  // grid(
  //   columns: (1fr,) * ncols,
  //   row-gutter: 24pt,
  //   ..authors.map(author => [
  //     #author.name \
  //     #author.affiliation \
  //     #link("mailto:" + author.email)
  //   ]),
  // )

  // par(justify: false)[
  //   *Abstract* \
  //   #abstract
  // ]

  v(2em)
  set text(size: fontsizes.small)
  outline(indent: 1em)

  set page(
    margin: 1.5cm,
    footer-descent: 60%,
  )

  // TODO update if want to

  set text(
    font: "TeX Gyre Pagella",
    size: fontsizes.normal,
  )
  show math.equation: set text(font: "TeX Gyre Pagella Math")
  show raw: set text(font: "TeX Gyre Pagella Math")

  show link: set text(fill: gray)
  show link: underline

  set align(left)
  show: thmrules.with(qed-symbol: $square.filled$)

  // ! headers
  set heading(numbering: "1.1")

  show heading.where(
    level: 1,
  ): it => text(
    size: fontsizes.section,
    weight: "bold",
    if (it.numbering != none) {
      par(
        leading: 0em,
        first-line-indent: 0em,
        $section$ + counter(heading).display(it.numbering) + h(.5em) + smallcaps(it.body) + "\n",
      )
    } else {
      par(leading: 0em, first-line-indent: 0em, it.body + [.] + "\n")
    },
  )

  show heading.where(
    level: 2,
  ): it => text(
    size: fontsizes.subsection,
    weight: "semibold",
    // style: "italic",
    par(leading: 0em, first-line-indent: 0em, $section$ + counter(heading).display(it.numbering) + h(.5em) + it.body),
    // it.numbering + h(.5em) + it.body + [.],
  )
  show heading.where(
    level: 3,
  ): it => text(
    size: fontsizes.subsection,
    weight: "semibold",
    // style: "italic",
    par(leading: 0em, first-line-indent: 0em, counter(heading).display(it.numbering) + h(.5em) + it.body),
    // it.numbering + h(.5em) + it.body + [.],
  )

  // ! this is the footer
  set page(footer: context [
    #let elems = query(
      selector(heading).before(here()),
    )
    #let subsection = elems.last().body
    #let num = counter(heading).display(elems.last().numbering)

    #text(num, size: fontsizes.small)
    #text(subsection, size: fontsizes.small)
    #h(1fr)
    #text(
      counter(page).display(
        "1",
        // both: true,
      ),
      size: fontsizes.small,
    )
  ])

  doc
}


// ! theorems
#let thmsettings = (
  inset: (top: 0.6em, left: .5em, right: .5em, bottom: 0.82em),
  base_level: 1,
  padding: (top: 0pt, bottom: -4pt),
)

#let theorem = thmbox(
  "theorem", // identifier
  text($arrow.hook$ + "Theorem", fill: solarized.red), // head
  fill: solarized.gray,
  inset: thmsettings.inset,
  // stroke: 1pt
  base_level: thmsettings.base_level,
  supplement: "Thm.",
  padding: thmsettings.padding,
)

#let lemma = thmbox(
  "lemma", // identifier
  text($arrow.hook$ + "Lemma", fill: solarized.orange), // head
  fill: solarized.gray,
  inset: thmsettings.inset,
  base_level: thmsettings.base_level,
  supplement: "Lem.",
  padding: thmsettings.padding,
)

#let proposition = thmbox(
  "proposition", // identifier
  // $arrow.hook$+" Proposition",
  text($arrow.hook$ + "Proposition", fill: solarized.magenta), // head
  fill: solarized.gray,
  inset: thmsettings.inset,
  base_level: thmsettings.base_level,
  supplement: "Prop.",
  padding: thmsettings.padding,
  // stroke: 1pt
)

#let corollary = thmbox(
  "corollary",
  // $arrow.hook$+" Corollary",
  text($arrow.hook$ + "Corollary", fill: solarized.orange), // head
  fill: solarized.gray,
  inset: thmsettings.inset,
  base_level: thmsettings.base_level,
  padding: thmsettings.padding,
  supplement: "Cor.",
)

#let definition = thmbox(
  "definition",
  // $arrow.hook$+" Definition",
  text($arrow.hook$ + "Definition", fill: solarized.blue),
  fill: solarized.gray,
  inset: thmsettings.inset,
  base_level: thmsettings.base_level,
  padding: thmsettings.padding,
)

#let example = thmbox(
  "example",
  $ast.op.o$ + " Example",
  fill: solarized.cyanlight,
  inset: thmsettings.inset,
  padding: thmsettings.padding,
  base_level: thmsettings.base_level,
)


#let exercise = thmbox(
  "exercise",
  "Exercise",
  fill: solarized.cyanlight,
  inset: thmsettings.inset,
  padding: thmsettings.padding,
  base_level: thmsettings.base_level,
)

#let remark = thmbox(
  "remark",
  "Remark",
  stroke: none,
  inset: (top: 0.4em, left: .5em, right: .5em, bottom: 0.6em),
  base_level: 1,
  padding: thmsettings.padding,
)


#let axiom = thmbox(
  "axiom",
  "Axiom",
  base_level: 0,
  fill: solarized.gray,
  inset: thmsettings.inset,
)

#let proof = thmproof(
  "proof",
  text(
    smallcaps("Proof"),
    // highlight("Proof", fill: white, stroke: black, top-edge: "cap-height", extent: 3pt),
    style: "oblique",
    weight: "regular",
  ),

  inset: (top: 0em, left: 2.8em, right: 1.4em),
  separator: [#h(0.1em). #h(0.2em)],
)

#let solution = thmproof(
  "solution",
  text(
    smallcaps("Solution"),
    // highlight("Proof", fill: white, stroke: black, top-edge: "cap-height", extent: 3pt),
    style: "oblique",
    weight: "regular",
  ),

  inset: (top: 0em, left: 2.8em, right: 1.4em),
  separator: [#h(0.1em). #h(0.2em)],
)

#let question = thmbox(
  "question",
  "Question",
  fill: solarized.violetlight,
  inset: thmsettings.inset,
  padding: thmsettings.padding,
  base_level: thmsettings.base_level,
  bodyfmt: x => text(style: "italic", x),
)
