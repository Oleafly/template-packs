// Enables rendering of the graphviz DOT language
#import "@preview/gviz:0.1.0": *
#show raw.where(lang: "dot"): it => render-image(it.text)

// Enables typesetting of pseudocode
#import "@preview/lovelace:0.2.0": *
#show: setup-lovelace
#let pseudocode = pseudocode.with(indentation-guide-stroke: .5pt)
#let pseudocode-list = pseudocode-list.with(indentation-guide-stroke: .5pt)
#let nice-pseudocode(content) = [
  #grid(grid.hline(), pseudocode-list[#content], grid.hline())
]

