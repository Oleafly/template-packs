#import "@preview/ctheorems:1.1.3": *
#import "@preview/showybox:2.0.4": showybox

// Global document settings
#let font = "New Computer Modern"
#let lang = "it"

#let colors = (
  rgb("#9E9E9E"), // 0
  rgb("#FFB3B3"), // 1
  rgb("#FFC8A0"), // 2
  rgb("#FFD78C"), // 3
  rgb("#FFEB8C"), // 4
  rgb("#FFFF96"), // 5
  rgb("#EBFF8C"), // 6
  rgb("#C8FF96"), // 7
  rgb("#96FFC8"), // 8
  rgb("#96F5FF"), // 9
  rgb("#96D2FF"), // 10
  rgb("#B4D2FF"), // 11
  rgb("#D2BEFF"), // 12
  rgb("#E6BEFF"), // 13
  rgb("#F5B4F0"), // 14
  rgb("#FFB4DC"), // 15
  rgb("#FFC8DC"), // 16
  rgb("#FFBEC8"), // 17
  rgb("#9E9E9E"), // 18
)

#let translations = (
  "en": (
    "problem": "Problem",
    "theorem": "Theorem",
    "lemma": "Lemma",
    "corollary": "Corollary",
    "definition": "Definition",
    "proposition": "Proposition",
    "remark": "Remark",
    "observation": "Observation",
    "example": "Example",
    "proof": "Proof",
  ),
  "it": (
    "problem": "Esercizio",
    "theorem": "Teorema",
    "lemma": "Lemma",
    "corollary": "Corollario",
    "definition": "Definizione",
    "proposition": "Proposizione",
    "remark": "Nota",
    "observation": "Osservazione",
    "example": "Esempio",
    "proof": "Dimostrazione",
  ),
)

#let t = if lang in translations { translations.at(lang) } else {
  translations.at("en")
}

// Beginning of template block
#let template(
  title: "",
  subtitle: "",
  author: "",
  abstract: none,
  bib: (),
  accent: colors.at(10),
  body,
) = {
  set document(title: title)

  show: thmrules

  set page(
    numbering: "1",
    number-align: center,
    header: context {
      if here().page() == 1 {
        return
      }
      box(stroke: (bottom: 0.7pt), inset: 0.2em)[#text(
        font: font,
      )[#author #h(1fr)#title]]
    },
  )

  set heading(numbering: "1.")
  show heading: it => {
    set text(font: font)
    set par(first-line-indent: 0em)

    if it.level == 1 and counter(heading).get().at(0) > 1 {
      pagebreak()
    }

    if it.numbering != none {
      text(accent, weight: 500)[#sym.section]
      text(accent)[#counter(heading).display() ]
    }
    it.body
  }

  set text(font: font, lang: lang)

  show math.equation: set text(weight: 400)


  // Title row
  align(center)[
    #set text(font: font)
    #block(text(weight: 700, 25pt, title))
    #v(1.6em, weak: true)
    #if subtitle != none [#text(18pt, weight: 500)[#subtitle]]
    #v(1.3em, weak: true)
    #if author != none [#text(14pt)[#author]]

  ]

  // Abstract
  if abstract != none [#align(center)[#abstract]]

  // TOC
  set outline(indent: 1em)

  show outline: set heading(numbering: none)
  show outline: set par(first-line-indent: 0em)

  show outline.entry.where(level: 1): it => {
    text(font: font, accent)[#strong[#it]]
  }
  show outline.entry: it => {
    text(font: font, accent)[#it]
  }

  outline()
  pagebreak()

  // Paragraphs
  set par(
    justify: true,
    first-line-indent: 0em,
  )

  // Main body
  body

  // Bibliography
  if bib != () {
    bib
  }
}

#let thmtitle(t, color: rgb("#000000")) = {
  text(font: font, weight: "semibold", fill: color)[#t]
}
#let thmname(t, color: rgb("#000000")) = {
  text(font: font, fill: color)[(#t)]
}

#let thmtext(t, color: rgb("#000000")) = {
  let a = t.children
  if (a.at(0) == [ ]) {
    a.remove(0)
  }
  t = a.join()

  text(font: font, fill: color)[#t]
}

#let thmbase(
  identifier,
  head,
  ..blockargs,
  supplement: auto,
  padding: (top: 0em, bottom: 0em),
  namefmt: x => [(#x)],
  titlefmt: strong,
  bodyfmt: x => x,
  separator: [#h(0.1em).#h(0.2em) \ ],
  base: "heading",
  base-level: none,
) = {
  if supplement == auto {
    supplement = head
  }
  let boxfmt(name, number, body, title: auto, ..blockargs_individual) = {
    if not name == none {
      name = [ #namefmt(name)]
    } else {
      name = []
    }
    if title == auto {
      title = head
    }
    if not number == none {
      title += " " + number
    }
    title = titlefmt(title)
    body = bodyfmt(body)
    pad(
      ..padding,
      showybox(
        width: 100%,
        radius: 0.3em,
        breakable: true,
        padding: (top: 0em, bottom: 0em),
        ..blockargs.named(),
        ..blockargs_individual.named(),
        [#title#name#titlefmt(separator)#body],
      ),
    )
  }

  let auxthmenv = thmenv(
    identifier,
    base,
    base-level,
    boxfmt,
  ).with(supplement: supplement)

  return auxthmenv.with(numbering: "1.1")
}

#let styled-thmbase = thmbase.with(
  titlefmt: thmtitle,
  namefmt: thmname,
  bodyfmt: thmtext,
)

#let builder-thmbox(color: rgb("#000000"), ..builderargs) = styled-thmbase.with(
  titlefmt: thmtitle.with(color: color.darken(30%)),
  bodyfmt: thmtext.with(color: color.darken(70%)),
  namefmt: thmname.with(color: color.darken(30%)),
  frame: (
    body-color: color.lighten(92%),
    border-color: color.darken(10%),
    thickness: 1.5pt,
    inset: 1.2em,
    radius: 0.3em,
  ),
  ..builderargs,
)

#let builder-thmline(
  color: rgb("#000000"),
  ..builderargs,
) = styled-thmbase.with(
  titlefmt: thmtitle.with(color: color.darken(30%)),
  bodyfmt: thmtext.with(color: color.darken(70%)),
  namefmt: thmname.with(color: color.darken(30%)),
  frame: (
    body-color: color.lighten(92%),
    border-color: color.darken(10%),
    thickness: (left: 2pt),
    inset: 1.2em,
    radius: 0em,
  ),
  ..builderargs,
)

// Styles
#let problem-style = builder-thmbox(color: colors.at(16), shadow: (
  offset: (x: 2pt, y: 2pt),
  color: luma(70%),
))

#let theorem-style = builder-thmbox(color: colors.at(6), shadow: (
  offset: (x: 3pt, y: 3pt),
  color: luma(70%),
))

#let lemma-style = builder-thmbox(color: colors.at(14), shadow: (
  offset: (x: 3pt, y: 3pt),
  color: luma(70%),
))

#let corollary-style = builder-thmbox(color: colors.at(12), shadow: (
  offset: (x: 3pt, y: 3pt),
  color: luma(70%),
))

#let definition-style = builder-thmline(color: colors.at(8))
#let remark-style = builder-thmline(color: colors.at(0))
#let observation-style = builder-thmline(color: colors.at(4))

#let proposition-style = builder-thmbox(color: colors.at(2), shadow: (
  offset: (x: 3pt, y: 3pt),
  color: luma(70%),
))

#let example-style = builder-thmline(color: colors.at(9))

// Boxes
#let problem = problem-style("problem", t.problem)
#let theorem = theorem-style("theorem", t.theorem)
#let lemma = lemma-style("lemma", t.lemma)
#let corollary = corollary-style("corollary", t.corollary)
#let definition = definition-style("definition", t.definition)
#let proposition = proposition-style("proposition", t.proposition)
#let remark = remark-style("remark", t.remark)
#let observation = observation-style("observation", t.observation)
#let example = example-style("example", t.example).with(numbering: none)

#let proof(body, name: none) = {
  thmtitle[#t.proof]
  if name != none {
    [ #thmname[#name]]
  }
  thmtitle[.]
  body
  h(1fr)
  $square$
}
