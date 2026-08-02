#import "@preview/cetz:0.4.0"

/// Balances text, useful for headings, captions, centered text, or others.

/// Balances lines of text while keeping the minimum amount of lines possible.
/// Works by shrinking the width of the text until it can't be shrunk anymore.
///
/// Unbalanced text:
/// #example(```
///   #rect(width: 25em, lorem(10))
/// ```)
///
/// Balanced text:
/// #example(```
///   #rect(width: 25em, balance(lorem(10)))
/// ```)
///
/// -> content
#let balance(
  /// The text to balance. -> content
  body,
  /// Maximum number of iterations to perform. -> int
  max-iterations: 20,
  /// The precision to which to balance. -> length
  precision: 0.1em,
) = context layout(size => {
  set text(hyphenate: par.justify) if text.hyphenate == auto
  let lead = par.leading.to-absolute()
  let line-height = measure(body).height + lead
  let initial-size = measure(width: size.width, body)
  let initial-lines = (initial-size.height + lead) / line-height

  let high = initial-size.width
  let low = high * (1 - (1 / initial-lines)) / 2

  let extra-lines = initial-lines
  for i in range(0, max-iterations) {
    let candidate = high - (high - low) / (extra-lines + 1)
    set par(justify: false)
    let (height, width) = measure(width: candidate, body)
    if height > initial-size.height {
      low = candidate
      extra-lines = (height - initial-size.height) / line-height
    } else {
      high = width
      if measure(width: width - precision, body).height > initial-size.height {
        break
      }
      high -= precision.to-absolute()
    }
    if high - low < precision.to-absolute() {
      break
    }
  }

  block(width: high, body + if par.justify { linebreak(justify: true) })
})

#set par(justify: true, first-line-indent: 1.8em)
#set text(font: "New Computer Modern", lang: "en", size: 11pt)
#set page(paper: "a4", margin: 3.5cm)
#show figure: it => {
  if it.placement == none {
    block(it, inset: (y: .75em))
  } else {
    place(
      it.placement + center,
      float: true,
      block(it, inset: (y: .75em)),
    )
  }
}
#show figure.caption: emph
#show figure.caption: balance

#lorem(600)
#figure(
  placement: top,
  cetz.canvas(length: 2cm, {
    import cetz.draw: *

    line((0, 0), (1, 0), (0, 1), (0, 0))
    line((0, 1), (1, 1), (1, 0))
    circle((0, 0), radius: .05, fill: blue)
    circle((1, 0), radius: .05, fill: blue)
    circle((0, 1), radius: .05, fill: blue)
    circle((1, 1), radius: .05, fill: blue)
    // content((0, -.2), $alpha_1$)
    // content((1, -.2), $alpha_2$)
    // content((0, 1.2), $alpha_3$)
    // content((1, 1.2), $alpha_4$)
    content((0.5, -0.5), [FEM])

    line((2, -.05), (3, -.05), (2, .95), (2, -.05))
    line((3.1, 0.05), (3.1, 1.05), (2.1, 1.05), (3.1, 0.05))
    circle((2, -.05), radius: .05, fill: blue)
    circle((3, -.05), radius: .05, fill: blue)
    circle((2, .95), radius: .05, fill: blue)
    circle((3.1, 1.05), radius: .05, fill: blue)
    circle((2.1, 1.05), radius: .05, fill: blue)
    circle((3.1, 0.05), radius: .05, fill: blue)
    // content((2, -.2), $alpha_1$)
    // content((3, -.2), $alpha_2$)
    // content((1.8, 0.95), $alpha_3$)
    // content((3.3, 0.05), $alpha_4$)
    // content((3.1, 1.25), $alpha_5$)
    // content((2.15, 1.25), $alpha_6$)
    content((2.5, -0.5), [DG])

    line((4, -.1), (5, -.1), (4, .9), (4, -.1))
    line((5.2, 0.1), (5.2, 1.1), (4.2, 1.1), (5.2, 0.1))
    line((4, -.25), (5, -.25), stroke: red)
    line((3.85, -.1), (3.85, .9), stroke: red)
    line((4.1, 1), (5.1, 0), stroke: red)
    line((4.2, 1.25), (5.2, 1.25), stroke: red)
    line((5.35, 0.1), (5.35, 1.1), stroke: red)
    circle((4, -.1), radius: .05, fill: blue)
    circle((5, -.1), radius: .05, fill: blue)
    circle((4, .9), radius: .05, fill: blue)
    circle((5.2, 1.1), radius: .05, fill: blue)
    circle((5.2, .1), radius: .05, fill: blue)
    circle((4.2, 1.1), radius: .05, fill: blue)
    circle((4, -.25), radius: .05, fill: red)
    circle((5, -.25), radius: .05, fill: red)
    circle((3.85, -.1), radius: .05, fill: red)
    circle((3.85, .9), radius: .05, fill: red)
    circle((4.1, 1), radius: .05, fill: red)
    circle((5.1, 0), radius: .05, fill: red)
    circle((4.2, 1.25), radius: .05, fill: red)
    circle((5.2, 1.25), radius: .05, fill: red)
    circle((5.35, 0.1), radius: .05, fill: red)
    circle((5.35, 1.1), radius: .05, fill: red)
    content((4.5, -0.5), [HDG])
  }),
  caption: [Comparison of degrees of freedom in a mesh with the FEM method, DG and HDG using the Lagrange basis function of order 1 for interpolation. In this case, given the low order, HDG introduces too many additional degrees of freedom to be advantageous.],
) <fem-dg-hdg>

= a

#lorem(40)
