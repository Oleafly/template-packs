#import "locale.typ": EQUATION

/// Dictionary to store a equations label and caption in order to display them in a custom outline.
/// -> dictionary
#let outlined-equations = state("outlined-equations-key", (:))

/// Custom wrapper for equations to store them in `outlined-equations` and display them in an custom outline.
///
/// ```example
/// #equation(
///   caption: "Quadratic formula",
///   label: <eq:QuadraticFormula>,
///   $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
/// )
/// ```
///
/// -> content
#let equation(
  body,
  /// Caption of the equation. Proving a caption will display the equation in the outline with it's caption. The Caption is not shown below the equation. -> str | content
  caption: none,
  /// Label of the equation. Must be provided. -> dictionary | label | location | ref-label | str
  label: none,
) = {
  if label != none and caption != none {
    outlined-equations.update(it => {
      it.insert(str(label), (label, caption))
      it
    })
  }

  if label == none and caption != none {
    panic("You must set a label if a caption is provided!")
  }

  [
    #body
    #label
  ]
}

