// Imports common variables and libraries
#import "common.typ": *
#set text(lang: report_lang, size: 12pt)
// Initialise codeblock support
#show: codly-init.with()
#codly(languages: codly-languages)
// makes `` more apparent to resemble more like \texttt{} from latex
#show raw.where(block: false): it => box(
  fill: luma(235),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
  text(it)
)

#show heading: set text(weight:"light")
#include("titlepage/_titlepage.typ")
#show heading: set text(weight:"semibold")

// Resets the page number back to one
#counter(page).update(1)
// Large roman numerals 
#set page(numbering: "I")

// Defines table of contents section with the different kinds of listings
#outline(title: [#report_listing_contents])
#pagebreak()
#outline(title: [#report_listing_figure],
target: figure.where(kind: image))
#outline(title: [#report_listing_table],
target: figure.where(kind: table))
#outline(title: [#report_listing_code],
target: figure.where(kind: raw))
#pagebreak()

#set heading(numbering: "1.1  ")
// Resets the page number back to one
#counter(page).update(1)
// Arabic numbers
#set page(numbering: "1")

// Here one adds the different sections
#include("sections/_introduction.typ")
#include("sections/solution.typ")
#include("sections/challenges.typ")
#include("sections/reflection.typ")

#pagebreak(weak:true)
// Renders the bibliography
#bibliography("bib/Hayagriva.yml", title: [#report_listing_bib])
