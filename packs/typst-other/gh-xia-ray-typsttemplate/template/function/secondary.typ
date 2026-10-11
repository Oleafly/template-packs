#import "../theme.typ": shared_sizes, shared_type
#import "../state.typ": secondary-active

#let secondary(body) = block(
  width: 100%,
  inset: 8pt,
  stroke: luma(180),
  radius: 5pt,
  {
    secondary-active.update(true)
    show math.equation.where(block: true): it => text(
      it,
      size: shared_sizes.math,
      font: shared_type.math.font,
      weight: shared_type.math.weight,
      style: shared_type.math.style,
    )
    show math.equation.where(block: false): it => text(
      it,
      size: shared_sizes.math,
      font: shared_type.math.font,
      weight: shared_type.math.weight,
      style: shared_type.math.style,
    )
    text(
      font: shared_type.secondary.font,
      size: shared_sizes.regular,
      weight: shared_type.secondary.weight,
      style: shared_type.secondary.style,
      body,
    )
    secondary-active.update(false)
  },
)
