#import "lib/shared-lib.typ": is-page-empty

#let title = "Einsatz eines Flux-Kompensators für Zeitreisen mit einer maximalen Höchstgeschwindigkeit von WARP 7"
#let authors = ("Max Mustermann",) // Note: The array of length one needs a trailing comma, as in (1,).
#let date = datetime.today()

#let logo-left = image("assets/TH_Mannheim_Logo_CMYK_blau.svg")
#let logo-right = none

#let degree = "Master" // "Bachelor"
#let course = "Informatik"
#let faculty = "Fakultät für Informatik"
#let university = "Technische Hochschule Mannheim"
#let supervisor-hs = "Prof. Peter Mustermann, Technische Hochschule Mannheim"
#let supervisor-company = "Erika Mustermann, Paukenschlag GmbH"

#let heading-font = "Latin Modern Sans" // like HSMA: "Arial"
#let body-font = "New Computer Modern" // "libertinus serif"

#let body-text-size = 12pt
#let numbering-alignment = center

// Workaround for "Using sub-files imported into main file, while citing a single bibliography."
// https://www.reddit.com/r/typst/comments/12pdmzc/using_subfiles_imported_into_main_file_while/?rdt=58657
#let bib_state = state("bib_state", bibliography("sources.bib", title: none))

//
// Template
//

#let template = body => {
  set document(title:title, author: authors, date: date)

  set page(
    number-align: numbering-alignment,
    // https://github.com/typst/templates/blob/main/wonderous-book/lib.typ#L91
    header: context {
      // Is this an empty page inserted to keep page parity?
      if is-page-empty() {
        return
      }

      // Are we on a page that starts a chapter?
      let i = here().page()
      if query(heading.where(level: 1)).any(it => it.location().page() == i) {
        return
      }

      let headings = query(selector(heading.where(level: 1)).before(here()))

      if headings.len() == 0 {
        return
      }

      let heading-last = headings.last()
      let heading-counter = counter(heading).get()
      let header-txt = str("")

      if heading-last.numbering != none {
        header-txt += [#heading-last.supplement #numbering(heading-last.numbering, heading-counter.first()) -- ]
      }
      header-txt += heading-last.body

      // set text(style: "italic", weight: "semibold", 1em)
      set align(center)
      stack(
        dir: ttb,
        header-txt,
        v(0.8em),
        line(length: 100%, stroke: 0.75pt),
      )
    },
  )

  show heading: set text(weight: "semibold", font: heading-font)
  set text(font: body-font, lang: "de", body-text-size)

  set par(justify: true, leading: 0.75em)
  show raw.where(block: true): set par(justify: false)

  set figure.caption(separator: [ --- ], position: bottom)
  show figure: set block(breakable: true)

  show heading.where(level: 1): it => {
    it + v(1em)
  }
  show heading.where(level: 2): it => v(1.25em) + it + v(0.75em)
  show heading.where(level: 3): it => v(1em) + it + v(0.65em)
  show heading.where(level: 4): it => v(1em) + it + v(0.65em)
  show heading.where(level: 5): it => v(1em) + it + v(0.65em)
  show heading.where(level: 6): it => v(1em) + it + v(0.65em)

  body
}
