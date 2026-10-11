#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.3.4"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#import "@preview/theorion:0.3.3": *
#import cosmos.clouds: *
#import "@preview/lilaq:0.6.0"
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/fontawesome:0.6.0": *

#let author = "ShangJhe Li"
#let doc-name = "Book Template"
#let subtitle = "A practical Typst book template"

#let latin-font = "Libertinus Serif"
// #let latex-font = "CMU serif"
#let mono-font = "SauceCodePro NFM"
// #let mandrin-font = "Source Han Serif"
#let mandrin-font = "AR PL KaitiM Big5"

#let references(names: array) = {
  let heading = "References/Discussion: "
  align(left, text(11pt)[
    #if names.len() == 1 {
      [#heading #names.at(0)]
    } else {
      [
        #heading
        #for name in names {
          [- #name]
        }
      ]
    }
  ])
}

// Clue Setting
#let tip(title: "Tip", ..args) = clue(
  icon: fa-lightbulb(),
  title: title,
  border-color: yellow,
  accent-color: yellow,
  ..args,
)

#let code(title: "Code", ..args) = clue(
  icon: fa-code(),
  title: title,
  border-color: rgb("#7287fd"),
  accent-color: rgb("#7287fd"),
  ..args,
)

#let warning(title: "Warning", ..args) = clue(
  icon: fa-warning(),
  title: title,
  border-color: rgb("#ffb639"),
  accent-color: rgb("#ffb639"),
  ..args,
)

#let tasks(title: "Tasks", ..args) = clue(
  icon: fa-tasks(),
  title: title,
  border-color: rgb("#9774ff"),
  accent-color: rgb("#9774ff"),
  ..args,
)

#let note(title: "Note", ..args) = clue(
  icon: fa-note-sticky(),
  title: title,
  border-color: rgb("#26e1d1"),
  accent-color: rgb("#26e1d1"),
  ..args,
)

#let file-tree(title: "Directory Structure", content, ..args) = clue(
  icon: fa-folder-tree(),
  title: title,
  border-color: rgb("#73d24b"),
  accent-color: rgb("#73d24b"),
  [#no-codly[#content]],
  ..args,
)

#let instruction(title: "Instruction", ..args) = clue(
  icon: fa-terminal(),
  title: title,
  border-color: rgb("#e04689"),
  accent-color: rgb("#e04689"),
  ..args,
)

// Code Reference
#let code-ref(path: str, lang: str, caption: "") = {
  let code_raw = read(path, encoding: "utf8")
  code(title: if caption != "" { caption } else { path })[
    #codly(
      stroke: .5pt + black,
      radius: 0.3em,
      inset: 0.4em,
    )
    #align(center)[
      #block()[
        #raw(code_raw, lang: lang, block: true)
      ]
    ]
  ]
}

#let title(
  subtitle: subtitle,
  date: datetime.today().display(),
) = {
  page(
    margin: 0pt,
    header: none,
    footer: none,
    numbering: none,
  )[
    #set text(font: (latin-font, mandrin-font))
    #rect(
      width: 100%,
      height: 100%,
      // fill: rgb("#f7f4ef"),
      stroke: none,
      inset: (x: 2.4cm, y: 2.6cm),
    )[
      #align(right)[
        #stack(dir: ttb, spacing: 0.35em)[
          #box(width: 3.4cm, height: 1.4pt, fill: black)
        ]
      ]
      #v(1fr)
      #align(horizon)[
        #block(width: 100%)[
          #box(width: 2.8cm, height: 3pt, fill: rgb("#a23b2a"))
          #v(0.75cm)
          #text(size: 38pt, weight: "bold", doc-name)
          #v(0.65cm)
          #box(width: 8cm, height: 1pt, fill: rgb("#2f3437"))
          #v(0.55cm)
          #text(size: 15pt, fill: rgb("#4d5659"), subtitle)
        ]
      ]
      #v(1fr)
      #grid(columns: (1fr, auto), column-gutter: 1.4cm)[
        #stack(dir: ttb, spacing: 0.4em)[
          #text(size: 9pt, fill: rgb("#5f686b"))[Author]
          #text(size: 14pt, weight: "semibold", author)
        ]
      ][
        #stack(dir: ttb, spacing: 0.4em)[
          #text(size: 9pt, fill: rgb("#5f686b"))[Date]
          #text(size: 14pt, weight: "semibold", date)
        ]
      ]
    ]
  ]
  counter(page).update(1)
}

#let chapter-heading(it) = {
  pagebreak(weak: true)
  v(1.2cm)
  block(width: 100%)[
    #if it.numbering == none [
      #align(center)[
        #box(width: 100%, height: 1.2pt, fill: rgb("#2f3437"))
        #v(-0.9em)
        #text(size: 24pt, weight: "bold", it.body)
        #v(-0.9em)
        #box(width: 100%, height: 1.2pt, fill: rgb("#2f3437"))
      ]
    ] else [
      #v(-2em)
      #align(center)[
        #box(width: 100%, height: 1.2pt, fill: rgb("#2f3437"))
        #v(-0.9em)
        #text(size: 24pt, weight: "bold", fill: rgb("#a23b2a"))[
          Chapter #context counter(heading).display("1")
        ]
        #v(-0.9em)
        #box(width: 100%, height: 1.2pt, fill: rgb("#2f3437"))

        #text(size: 24pt, weight: "bold", it.body)
        #v(2em)
      ]
    ]
  ]
  v(0.85cm)
}

#let conf(doc) = [
  #show: codly-init.with()
  #codly(languages: codly-languages)

  #show: show-theorion

  #set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    numbering: "1",
    header: context [
      #let page-num = counter(page).get().first()
      #let chapter-on-page = query(heading.where(level: 1)).any(
        it => counter(page).at(it.location()).first() == page-num,
      )
      #if not chapter-on-page [
        _ #doc-name _
        #h(1fr)
        #let chapters = query(selector(heading.where(level: 1)).before(here()))
        #let sections = query(selector(heading.where(level: 2)).before(here()))
        #if chapters.len() > 0 {
          let last-chapter = chapters.last()
          let chap-num = counter(heading).at(last-chapter.location()).first()
          let has-section = sections.len() > 0 and counter(heading).at(sections.last().location()).first() == chap-num
          if has-section {
            let last-section = sections.last()
            let sec-num = counter(heading).at(last-section.location()).last()
            let num = str(chap-num) + "." + str(sec-num)
            [#num #last-section.body]
          } else {
            let num = str(chap-num)
            [#num #last-chapter.body]
          }
        }
        #box(fill: black, width: 100%, height: 1pt)  // Top bar
      ]
    ],
    footer: context [
      #box(fill: black, width: 100%, height: 1pt)
      #author
      #h(1fr)
      #counter(page).display("1")
    ],
  )

  #set text(
    font: (
      latin-font,
      mandrin-font,
      // mandrin-kaiti_font,
    ),
    size: 12pt,
    cjk-latin-spacing: auto,
  )

  #set par(justify: true)
  #set heading(numbering: (..nums) => nums.pos().map(str).join(".") + " ")
  #show heading.where(level: 1): chapter-heading
  #set list(indent: 1em)
  #set enum(indent: 1em)

  #show raw: set text(font: mono-font)
  #show: gentle-clues.with(breakable: true)

  #doc
]
