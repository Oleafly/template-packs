// components/exam.typ — Self-assessment / exam questions
//
// Multiple-choice questions with lettered options and a deferred
// solution key. Each question registers its answer into a state; the
// solution key collects them in document order. For an inline answer
// (e.g. worked examples) pass `show-solution: true`.

#import "/packages/bookkit/theme.typ": fonts, palette, space, type-scale

#let _mc-counter = counter("mc-question")
#let _mc-solutions = state("mc-solutions", ())

#let _letters = ("A", "B", "C", "D", "E", "F")

// ── Multiple-choice question ───────────────────────────────────
// prompt:   the question stem (content)
// options:  array of answer contents
// answer:   1-based index of the correct option
// explanation: optional rationale (shown inline if show-solution, else in key)
#let mc-question(
  prompt,
  options,
  answer: 1,
  explanation: none,
  show-solution: false,
) = {
  _mc-counter.step()
  _mc-solutions.update(arr => arr + ((answer: answer, explanation: explanation),))
  let ans-idx = answer - 1

  block(
    width: 100%,
    inset: space.md,
    fill: palette.bg-subtle,
    stroke: (left: 3pt + palette.primary),
    radius: (right: 4pt),
    breakable: false,
    above: space.lg,
    below: space.lg,
    {
      context {
        let n = _mc-counter.get().first()
        text(weight: "bold", font: fonts.sans, fill: palette.primary-dark)[Frage #n.]
      }
      h(space.sm)
      prompt
      v(space.sm)
      for (i, opt) in options.enumerate() {
        let is-correct = show-solution and i == ans-idx
        grid(
          columns: (auto, 1fr),
          column-gutter: space.sm,
          row-gutter: space.xs,
          {
            set text(weight: "bold", font: fonts.sans)
            if is-correct {
              text(fill: palette.success)[#_letters.at(i))]
            } else {
              text(fill: palette.text-muted)[#_letters.at(i))]
            }
          },
          if is-correct { text(fill: palette.success.darken(10%), weight: "bold", opt) } else { opt },
        )
      }
      if show-solution and explanation != none {
        v(space.sm)
        block(
          width: 100%,
          inset: space.sm,
          fill: palette.success.lighten(90%),
          radius: 3pt,
          {
            set text(size: type-scale.small)
            text(weight: "bold", font: fonts.sans, fill: palette.success.darken(20%))[Lösung: ]
            text(fill: palette.success.darken(20%))[#_letters.at(ans-idx)) — ]
            explanation
          },
        )
      }
    },
  )
}

// ── Solution key ───────────────────────────────────────────────
// Collects all registered answers in document order.
#let solution-key(title: [Lösungsschlüssel]) = {
  block(
    width: 100%,
    inset: space.md,
    fill: palette.primary.lighten(92%),
    stroke: (left: 3pt + palette.primary),
    radius: (right: 4pt),
    breakable: true,
    above: space.lg,
    below: space.lg,
    {
      text(weight: "bold", font: fonts.sans, fill: palette.primary-dark, title)
      v(space.sm)
      context {
        let sols = _mc-solutions.final()
        set text(size: type-scale.small)
        for (i, s) in sols.enumerate() {
          let n = i + 1
          text(weight: "bold", font: fonts.sans)[#n: ]
          text(fill: palette.success.darken(10%), weight: "bold")[#_letters.at(s.answer - 1)]
          if s.explanation != none {
            text(fill: palette.text-muted)[ — ]
            s.explanation
          }
          linebreak()
        }
      }
    },
  )
}
