/*
appendixConfig.typ

This file contains the definition for the appendix headings.
*/

#let appendixCounter = counter("appendix")
#let appendix-heading(body) = {
  context appendixCounter.step()
  align(left)[
    #figure(
    text(size: 16pt, weight: "bold")[
      #context appendixCounter.display("A.") #body
    ],
    supplement: "Appendix",
    kind: "appendixHeading"
    ) 
  ]
  v(0.8em)
}