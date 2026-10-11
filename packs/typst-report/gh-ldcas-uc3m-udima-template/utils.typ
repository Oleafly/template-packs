//! Auxiliar helper macros
// LTeX: enabled=false

#import "@preview/oxifmt:1.0.0": strfmt



/// Auxiliar table.header
///
/// Usage:
/// ```typc
/// table(
///   // ...
///   ..table-header([], ...),
/// )
/// ```
#let table-header(..children, repeat: true) = {
  (table.header(..children, repeat: repeat), table.hline())
}


/// Scales content to the desired width/height relative to its container.
///
/// - body (content): The content to scale
/// - width (ratio, auto): Desired width (relative to its container)
/// - height (ratio, auto): Desired heigth (relative to its container)
/// - text-size (length, auto): Desired text size. If `auto`, will use current text size.
/// -> content
#let scale-to-container(
  body,
  width: auto,
  height: auto,
  text-size: auto,
) = layout(ly => {
  set text(size: if text-size == auto { text.size } else { text-size })
  if width == auto and height == auto { return body }

  scale(
    x: if width == auto { auto } else { ly.width * width },
    y: if height == auto { auto } else { ly.height * height },
    reflow: true,
    body,
  )
})





/// Like LaTeX's `\noindent`, removes the first-line indentation of the paragraph.
///
/// - body (content): Content.
/// -> content
#let noindent(body) = {
  set par(first-line-indent: 0pt)
  body
}


/// Formats the specified quantity as a two-digit number
#let round = calc.round.with(digits: 2)


/// Formats the specified value as money.
/// - value (int | float): Value to format
/// -> content
#let money(value) = {
  $#strfmt(
    "{:.2}",
    float(value),
    fmt-decimal-separator: ",",
    fmt-thousands-separator: ".",
  ) euro$
}


/// Put big-ass things in a new page, rotated
///
/// - body (content): Body
/// -> content
#let big-ass-thing(body) = page(
  // TODO: visually rotate page, but keep the header on the short side
  // see: https://github.com/typst/typst/discussions/4138
  place(
    horizon + center,
    rotate(
      -90deg,
      reflow: true,
      body,
      // [
      //   #figure(table, caption: caption, placement: none)
      //   #if label != none {
      //     assert(
      //       type(label) == std.label,
      //       message: "You must provide a label, e.g. `<alg:stuff>`",
      //     )
      //     label
      //   }
      // ],
    ),
  ),
)


/// Places a bunch of figures "right here" (`placement: none`).
///
/// - body (content): Body containing figures
/// -> content
#let right-here(body) = {
  set figure(placement: none)
  body
}