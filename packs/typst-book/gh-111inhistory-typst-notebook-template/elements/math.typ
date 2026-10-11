#import "/utils/content-utils.typ": *

#let equation-type = state("__equation-type", none)
#let nested-depth = state("__equation-nested-depth", 0)

/// A hook to render nested fractions with improved readability. Nested fractions will be rendered in vertical style, while top-level fractions will be rendered in horizontal style.
#let v-h-frac(it) = context {
  if it.has("label") and it.label == <__math-frac-stop-render> {
    return it
  }

  let depth = nested-depth.get()
  nested-depth.update(n => n + 1)
  let is-nested = has-func(it.num, math.frac) or has-func(it.denom, math.frac)
  let style = if depth == 0 or is-nested { "vertical" } else { "horizontal" }
  [
    #math.frac(it.num, it.denom, style: style)
    <__math-frac-stop-render>
  ]

  nested-depth.update(n => n - 1)
}

/// Install hooks to indicate whether an equation is block-level or inline, and handles equation numbering based on the presence of the `label` attribute. This hook should be applied at the document level to take effect.
#let math-hook(doc) = {
  show math.equation.where(block: true): it => {
    if it.has("label") and it.label == <__math-equation-stop-render> {
      return it
    }
    if it.has("label") and it.label != <__math-equation-stop-render> {
      return [
        #counter(math.equation).update(n => n - 1)
        #math.equation(
          it.body,
          alt: it.alt,
          block: it.block,
          number-align: it.number-align,
          numbering: it.numbering,
          supplement: it.supplement,
        )
        <__math-equation-stop-render>
      ]
    } else {
      return [
        #counter(math.equation).update(n => n - 1)
        #math.equation(
          it.body,
          alt: it.alt,
          block: it.block,
          number-align: it.number-align,
          numbering: none,
          supplement: it.supplement,
        )
        <__math-equation-stop-render>
      ]
    }
  }
  show math.equation.where(block: true): it => [
    #state("__equation-type", none).update("block")
    #it
  ]
  show math.equation.where(block: false): it => [
    #state("__equation-type", none).update("inline")
    #it
  ]
  doc
}
