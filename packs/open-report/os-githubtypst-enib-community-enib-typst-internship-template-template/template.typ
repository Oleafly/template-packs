#import "@preview/glossarium:0.2.6": *

#import "@preview/codelst:1.0.0": sourcecode, codelst-styles, sourcefile

#import "@preview/showybox:2.0.1": showybox

// somewhat bizare typst thingy here
#let codelst-sourcefile = sourcefile
#let sourcefile(filename, ..args) = codelst-sourcefile(
  read(filename),
  file: filename,
  ..args,
)

#let remark(body) = {
  showybox(
    title-style: (
      weight: 900,
      color: blue.darken(50%),
      sep-thickness: 0pt,
      align: center + horizon,
    ),
    frame: (
      title-color: blue.lighten(80%),
      border-color: blue.darken(50%),
      thickness: (left: 1pt),
      radius: 0pt,
    ),
    title: "Remarque",
    body,
  )
}
// Print content if not on first page
#let not_on_first_page(body: []) = {
  locate(
    loc => {
      let page_number = counter(page).at(loc).first()
      if page_number != 1 {
        body
      }
    },
  )
}

// ENIB template.
#let enib-template(
  title: none,
  sous-titre: none,
  nom: "Prénom NOM",
  tuteur_academique: "",
  maitre_de_stage: "",
  type_stage: [],
  dates: [],
  mail: "",
  logo_company: none,
  img_illustration: none,
  logo_enib: none,
  body,
) = {
  show: make-glossary
  show: codelst-styles
  set document(title: title, author: nom)
  set page(paper: "a4")
  set text(
    lang: "fr",
    size: 11.2pt,
    font: "Linux Libertine",
  )
  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)
  show heading: set block(spacing: 3%)

  // Configure lists.
  set enum(indent: 15pt, body-indent: 5pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure heading numbering
  set heading(numbering: "1.1.1.1")

  // Configure paragraph
  set par(
    first-line-indent: 0.8em, // The indent the first line of a paragraph.
    justify: true, // justify the text.
    leading: 0.8em, // The spacing between lines.
  )

  // Style heading of level 1.
  show heading.where(level: 1): it => {
    set block(below: 20pt, above: 10pt)
    set text(font: "QTPalatine", weight: "black")
    set align(center)
    underline(smallcaps(it), offset: 4pt)
  }

  show heading.where(level: 2): it => {
    set block(below: 15pt, above: 10pt)
    underline(it, offset: 3pt)
  }
  show heading.where(level: 3): it => {
    set block(below: 10pt, above: 5pt)
    it
  }

  show figure: set block(above: 4%, below: 5%)

  // link are blue
  show link: set text(fill: blue.darken(70%))

  // Configure the page.
  set page(
    paper: "a4",
    numbering: "1",
    margin: (
      x: 2cm,
      top: 3.2cm,
      bottom: 3cm,
    ),
    background: image("/assets/front-background.svg"),
    footer: locate(
      loc => {
        let page_number = counter(page).at(loc).first()
        let total_pages = counter(page).final(loc).last()
        if page_number != 1 {
          text(
            12pt,
            grid(
              rows: 2,
              row-gutter: 5pt,
              line(
                length: 100%,
                stroke: (paint: black.lighten(75%)),
              ),
              grid(
                columns: (1fr, auto, 1fr),
                align(horizon + left, link("mailto:" + mail)),
                align(horizon + center, title),
                align(horizon + right)[ #page_number/#total_pages],
              ),
            ),
          )
        }
      },
    ),
    header: not_on_first_page(
      body: [
      #v(45pt)
      #grid(
        columns: (1fr, 1fr),
        align(
          horizon + left,
          box(height: 35pt, logo_company),
        ),
        align(
          horizon + right,
          box(height: 40pt, logo_enib),
        ),
      )
      #line(length: 100%)

      ],
    ),
  )

  grid(
    column-gutter: 40%,
    columns: (30%, 30%),
    align(
      center + horizon,
      logo_enib,
    ),
    align(center + horizon, logo_company),
  )

  v(3.5cm)
  if img_illustration != none{
    img_illustration
  }
  text(
    size: 14pt,
    align(center)[Rapport de #type_stage],
  )

  v(2cm)
  line(length: 100%)
  v(0.3cm)

  text(
    size: 12pt,
    align(center)[Stage du #dates],
  )

  text(
    size: 20pt,
    align(center)[#smallcaps(title)],
  )
  v(0.5cm)
  line(length: 100%)

  v(1.5cm)
  align(center)[#nom]

  
  v(1fr)
  align(
    center,
  )[Tuteur Académique : #tuteur_academique (ENIB) & Maitre de stage: #maitre_de_stage]
  v(0.5cm)

  pagebreak()
  body
}

#let todo(it) = [
#set text(weight: "bold", fill: red.darken(25%))
TODO: #it
]