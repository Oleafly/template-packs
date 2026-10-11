#import "@preview/tiaoma:0.3.0"
#import "kit-thesis.typ": *
#import "@preview/abbr:0.2.3"
#import "/utils.typ": citation-color, load-bibliography, monospace-font, serif-font

// setup
#include "abbreviations.typ"

// TODO: customize these values
#show: kit-thesis.with(
  author: [Author],
  title: [Title],
  thesis-type: [Bachelor's Thesis],
  group-logo: image("assets/ces-black.png"),
  institute: [CES - Chair for Embedded Systems],
  first-examiner: [First Examiner],
  second-examiner: [Second Examiner],
  advisor: [Advisor],
  lang: "en",
  abstract: include "sections/abstract.typ",
  german-abstract: include "sections/abstract_de.typ",
  is-draft: true,
  style: (
    serif-font: serif-font,
    monospace-font: monospace-font,
    citation-color: citation-color,
  ),
)

// sections
// TODO: add your sections here
#include "sections/introduction.typ"

// TODO: if you want to include an appendix leave this in, otherwise remove it
#appendix[#include "sections/appendix.typ"]

#state("header.enabled").update(false)

// abbreviations and bibliography
#abbr.list()
#load-bibliography(main: true)


