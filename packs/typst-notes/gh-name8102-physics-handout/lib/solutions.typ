#import "state.typ": mode-state, theme-state

#let show-answer(body) = context {
  if mode-state.get() == "teacher" { body } else { [] }
}

#let solution(body, title: [解析]) = context {
  if mode-state.get() != "teacher" { return [] }
  let theme = theme-state.get()
  block(
    breakable: true,
    stroke: (left: theme.stroke.normal + theme.colors.rule),
    inset: (
      left: theme.spacing.md,
      right: theme.spacing.md,
      top: theme.spacing.sm,
      bottom: theme.spacing.sm,
    ),
    above: theme.spacing.md,
    below: theme.spacing.md,
  )[
    #text(font: theme.fonts.sans, weight: 700, fill: theme.colors.rule)[#title]
    #v(theme.spacing.xs)
    #body
  ]
}

#let _answer-space(amount, subquestion-count, theme) = {
  if amount == none { return [] }
  if amount == "none" { return [] }
  let height = if amount == auto {
    calc.max(18mm, subquestion-count * 14mm)
  } else {
    assert(
      amount >= 0pt,
      message: "physics-handout: calculation-question: answer-space must be auto, none, or a non-negative length",
    )
    amount
  }
  block(
    height: height,
    breakable: false,
    stroke: (
      top: theme.stroke.hairline + theme.colors.light-rule,
      bottom: theme.stroke.hairline + theme.colors.light-rule,
    ),
    above: theme.spacing.sm,
    below: theme.spacing.sm,
  )[]
}
