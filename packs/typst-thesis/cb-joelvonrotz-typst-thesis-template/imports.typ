#import "@preview/drafting:0.2.2"
#import "@preview/subpar:0.2.2"

#let subfigures = subpar.grid.with(
  numbering: super => numbering("1.1", counter(heading).get().first(), super),
  numbering-sub-ref: (super, sub) => numbering("1.1a", counter(heading).get().first(), super, sub),
)