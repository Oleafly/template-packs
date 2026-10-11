#import "../states.typ": *

#let answer(body) = context {
  if print-answers.get() {
    body
  }
}

#let nonanswer(body) = context {
  if not print-answers.get() {
    body
  }
}

#let solution(title: "Solution", grading: none, body) = context {
  if print-answers.get() {
    box(width: 100%, height: auto, stroke: 0.5pt, inset: 6pt)[
      #if grading != none [
        *Grading:* #grading
      ]
      *#title:* #body
    ]
  }
}

