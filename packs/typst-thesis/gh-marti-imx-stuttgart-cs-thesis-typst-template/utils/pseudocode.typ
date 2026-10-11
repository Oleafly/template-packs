#import "@preview/lovelace:0.3.1": *
#import "@preview/headcount:0.1.0": dependent-numbering

#let pseudocode(title, content, placement: top) = {
  let code =  pseudocode-list(numbered-title: [#title #h(1fr)], line-gap: .6em, booktabs: true, booktabs-stroke: 1.5pt + black, content)

  show figure.caption: none
  
  figure(
    code,
    numbering: dependent-numbering("1.1"),
    kind: "algorithm",
    supplement: "Algorithm",
    placement: placement,
    caption: title
  )
}