#import "@preview/cetz:0.5.0"

/// Places a CeTZ circle by its center point.
///
/// Typst's `place` works from a top-left anchor in this template, while the
/// visual design is easier to describe with circle centers. This helper
/// converts center coordinates and radius to the correct placed CeTZ canvas.
///
/// - center-x (length): Horizontal center position.
/// - center-y (length): Vertical center position.
/// - radius (length): Circle radius.
/// - style (arguments): Additional CeTZ circle styling such as `fill` or `stroke`.
/// -> content
#let place-circle(center-x, center-y, radius, ..style) = place(
    top + left,
    dx: center-x - radius,
    dy: center-y - radius,
    cetz.canvas({
        import cetz.draw: *
        circle((0pt, 0pt), radius: radius, ..style)
    }),
)
