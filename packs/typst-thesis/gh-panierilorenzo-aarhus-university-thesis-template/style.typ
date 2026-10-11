// Copyright (c) 2025 Lorenzo Panieri <lorenzo.panieri@pm.me>
// See LICENSE file for details

#import "@preview/ctheorems:1.1.3": thmrules
#import "@preview/numbly:0.1.0": numbly

#let _red = rgb(255, 0, 0)
#let _blue = rgb(0, 64, 240)
#let _green = rgb(0, 255, 0).darken(40%)
#let _yellow = rgb("fedf00").darken(30%)

// use these colors if you want to update your color theme globally
// you can set this to whatever you prefer.
#let palette = (
  bg-grey1: luma(98%),
  bg-grey2: luma(95%),
  fg-grey1: luma(40%),
  fg-grey2: luma(60%),
  link-blue: _blue,
  red: _red,
  blue: _blue,
  green: _green,
  yellow: _yellow,
  bg-red: _red.lighten(80%),
  fg-red: _red.darken(30%),
  bg-blue1: _blue.lighten(95%),
  bg-blue2: _blue.lighten(90%),
)

#let template(
  programme: "<Name of Your Master Programme>",
  title: "<Title of Your Thesis>",
  // you can use a single student name, in this case the text will be adjusted
  // automatically to say "Student" instead of "Students"
  students: ("<Student Name>", "<Student Name>"),
  supervisor: "<Name of Your Supervisor>",
  // if you have a co-supervisor you must specify them here
  cosupervisor: none,
  date: datetime.today(),
  // if you do not include a bibliography path, it will not be rendered
  // the bibliography and references are rendered in IEEE style
  bibliography_path: none,
  // adds a red "DRAFT" warning on the header of each page, remember to remove
  // it before handing in!
  draft: false,
  // set to false to use the default Typst font instead
  use_latex_font: true,
  // provide additional syntax highlighting syntaxes, for instance if you are
  // developing a programming lanugage or are using a lesser known language.
  // These should be in `.sublime-syntax` format.
  syntaxes: (),
  // you can give a different path for your university logo, or just replace
  // the file logo.svg with a different logo.
  logo_path: "logo.svg",
  c,
) = {
  show: thmrules

  // === styling ===

  // links and references
  show link: set text(fill: palette.link-blue)
  show ref: set text(fill: palette.link-blue)
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      [Equation~]
      numbering(el.numbering, ..counter(eq).at(el.location()))
    } else {
      // Other references as usual.
      it
    }
  }
  show footnote: set text(fill: palette.link-blue)

  // body text
  set text(lang: "en")
  set text(font: "New Computer Modern") if use_latex_font
  set par(justify: true, leading: 0.6em)

  // tables
  show table: set par(justify: false)
  show figure.where(kind: table): set figure.caption(position: top)

  // numbering
  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")
  set enum(numbering: "1.a. ")

  // raw code blocks
  show raw: set text(font: "IBM Plex Mono", ligatures: true, discretionary-ligatures: true)
  show raw.where(block: true): set align(left)
  show raw.where(block: false): it => box(
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    fill: palette.bg-grey2,
    it,
  )

  // figures
  show figure.caption: set text(font: "Atkinson Hyperlegible", size: 10pt, fill: palette.fg-grey1)

  // page header
  set page(header: align(center, text(fill: palette.red)[*DRAFT*])) if draft

  // content
  [
    #align(center)[
      #smallcaps[
        #text(size: 20pt)[Aarhus University] \
        #text(size: 16pt)[Master Thesis] \
        #v(3em)
        #text(size: 11pt, programme) \
      ]
      #v(2em)
      #box(
        stroke: (
          x: 0pt,
          y: 1.5pt,
        ),
        inset: 1em,
      )[
        #par(leading: 5pt, text(size: 23pt, strong(title)))
      ]
      #v(5pt)
      #box(
        width: 80%,
        columns(2)[
          #align(left)[
            #if students.len() <= 1 { [_Student:_] } else { [_Students:_] } \
            #students.join([\ ])
          ]
          #colbreak()
          #align(right)[
            _Supervisor:_ \
            #supervisor \
            #if cosupervisor != none {
              [
                _Co-Supervisor:_ \
                #cosupervisor
              ]
            }
          ]
        ],
      ),
      #v(5pt)
      #text(size: 14pt, date.display("[month repr:long] [day], [year]"))
      #v(20pt)
      #image(
        width: 55%,
        logo_path,
      )
    ]
    #pagebreak()
    #c

    #if bibliography_path != none {
      bibliography(style: "ieee", full: false, bibliography_path)
    }
  ]
}

// start page numbering with roman numerals
#let intro_numbering(c) = {
  set page(numbering: "i")
  counter(page).update(1)
  c
}

// start page numbering with arabic numerals
#let body_numbering(c) = {
  set page(numbering: "1")
  counter(page).update(1)
  c
}

// start numbering sections with letters
#let appendix(body) = {
  set heading(
    numbering: "A.1.",
    supplement: "Appendix",
  )
  show heading.where(depth: 1): it => [
    Appendix #counter(heading).display(it.numbering) #it.body
  ]
  counter(heading).update(0)
  body
}
