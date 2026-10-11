#import "../styles/numbering.typ": appendix-numbering
#import "../styles/globals.typ": eq-counter, continued-header-state

#let appendix-page(it) = {
  counter(heading).update(0)
  eq-counter.update(0)
  set heading(numbering: appendix-numbering)
  set math.equation(numbering: it => eq-counter.display("(A-1-a)"))

  let figure-numbering = super => numbering("A-1", counter(heading).get().first(), super)
  show figure: set figure(numbering: figure-numbering)
  it
}
