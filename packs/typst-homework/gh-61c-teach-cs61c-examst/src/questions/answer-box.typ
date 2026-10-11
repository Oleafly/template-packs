#import "../states.typ"

#let answer-box(
  width: 50%,
  height: 2.25 * 16pt,
  fontsize: auto,
  pre: "",
  post: "",
  answer,
) = context {
  show raw.where(block: false): it => {
    v(.5em)
    it
  }

  show raw: set text(top-edge: 0pt)
  set text(16pt)

  v(-0.5em)
  box(width: width, height: height, stroke: 0.5pt)[
    #set align(horizon)
    #if states.print-answers.get() {
      place(horizon)[
        #grid(
          columns: 4,
          h(0.5em), pre, answer, post,
        )
      ]
    } else {
      grid(
        columns: (auto, 1fr, auto),
        align: (left, left, right),
        inset: 6pt,
        [#pre], [], [#post],
      )
    }
  ]
  v(-0.5em)
}
