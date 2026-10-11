#import "../state.typ": secondary-active

#let themed_math(
  theme,
  body,
  block-width: 105%,
  block-stroke: (left: 5pt),
  block-fill: black,
) = {
  show math.equation.where(block: true): it => context {
    let math-text = text(
      it,
      size: theme.sizes.math,
      font: theme.type.math.font,
      weight: theme.type.math.weight,
      style: theme.type.math.style,
      fill: block-fill,
    )

    if secondary-active.get() {
      math-text
    } else {
      box(
        width: block-width,
        stroke: block-stroke,
        math-text,
      )
    }
  }
  show math.equation.where(block: false): it => box(text(
    it,
    size: theme.sizes.math,
    font: theme.type.math.font,
    weight: theme.type.math.weight,
    style: theme.type.math.style,
  ))
  body
}
