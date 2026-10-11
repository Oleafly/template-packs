#import "@preview/hydra:0.6.2": anchor, hydra
#import "@preview/headcount:0.1.0": *

/* showFooterState: Possible values:
 * doe+number
 * number
 * none
 */
#let showFooterState = state("showFooterState", "doe-number")
#let showFooter(type) = showFooterState.update(type)

#let addToPDFBookmark(entry) = {
  show heading: none
  heading(numbering: none, bookmarked: true, outlined: false)[#entry]
}

#let project(body) = {
  set par(justify: true, first-line-indent: 1em, leading: .75em)
  set text(font: "STIX Two Text", size: 12.5pt)
  set heading(numbering: "1.")
  set list(indent: 1em)
  set enum(indent: 1em)
  set figure(
    gap: 15pt,
    numbering: dependent-numbering("1.1"),
  )
  set page(
    footer: context {
      if showFooterState.get() == "doe+number" {
        [
          _Division of Electronics Engg, SOE, CUSAT_
          #h(1fr)
          #counter(page).display()
        ]
      } else if showFooterState.get() == "number" {
        [
          #align(center)[#counter(page).display()]
        ]
      }
    },
    header: context {
      let current-page = here().page()
      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)
      if counter(heading).get().first() > 0 and not has-heading [
        // Display header from 1st numbered heading
        Distributed Communication Network
        #h(1fr)
        #emph[#hydra(1)]
      ]
    },
  )

  // Show title along with section numer
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      link(el.location(), [#emph[#it: #el.body]])
    } else {
      it
    }
  }

  show bibliography: set heading(numbering: "1.")

  show heading.where(level: 1): it => {
    set align(center + top)
    if it.numbering == none [
      #set align(center + top)
      #pagebreak(weak: true)
      #block[
        #v(0.5cm)
        #text(size: 24pt, weight: "bold")[#it.body]
        #v(1cm)
      ]
    ] else [
      #pagebreak(weak: true)
      #block[
        #text(size: 24pt, weight: "bold")[
          Chapter #counter(heading).get().first(): #v(-15pt)
          #it.body
        ]
        #v(1cm)
      ]]
  }

  show heading.where(level: 2): it => {
    block[
      #text(size: 18pt, weight: "bold")[#counter(heading).display().trim(".") #it.body]
      #v(10pt)
    ]
  }

  show heading.where(level: 3): it => {
    block[
      #text(size: 15pt, weight: "bold")[#counter(heading).display().trim(".") #it.body]
      #v(10pt)
    ]
  }

  // Set spacing for heading outline
  show outline.entry.where(level: 1): it => {
    if it.element.func() == heading {
      v(5pt)
      strong(it)
    } else {
      v(3pt)
      it
    }
  }

  show outline.entry: it => {
    // things that shouldnt be numbered
    let no-nums = query(label("unnumbered"))
    if it.element in no-nums {
      return strong[
        #it.body()
        // dots
        #box(width: 1fr, repeat(gap: 0.15em)[.]) #it.page()
      ]
    }
    it
  }

  show figure: set block(spacing: 25pt)
	// italicize captions
  show figure.caption: it => { emph[#it] }
  show raw: set text(font: "DejaVu Sans Mono")
  // contents
  body
}
