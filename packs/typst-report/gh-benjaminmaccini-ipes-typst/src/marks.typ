// ===========================================================================
// marks.typ — small typographic primitives shared by the other modules.
// ===========================================================================

#import "@preview/grayness:0.7.0": image-grayscale
#import "theme.typ": get-theme, themed

/// Capitalised display text with the theme's tracking applied. Bebas Neue and
/// most condensed display faces need the extra letterspacing to stay legible
/// at small sizes; body-font caps need it even more.
#let caps(body, tracking: auto, font: auto, weight: auto) = themed(t => {
  let tracking = if tracking == auto { t.options.caps-tracking } else { tracking }
  set text(
    tracking: tracking,
    font: if font == auto { t.fonts.display } else { font },
    weight: if weight == auto { 700 } else { weight },
  )
  upper(body)
})

/// A hairline in the theme's rule colour.
#let hairline(width: 100%, thickness: 0.5pt, color: auto) = themed(t => line(
  length: width,
  stroke: (thickness: thickness, paint: if color == auto { t.colors.rule } else { color }),
))

/// A short heavy rule, used as a lead-in mark above headings and quotes.
#let tick(width: 26pt, thickness: 2.5pt, color: auto) = themed(t => line(
  length: width,
  stroke: (thickness: thickness, paint: if color == auto { t.colors.accent } else { color }, cap: "square"),
))

/// An eyebrow / kicker line: small, tracked caps in a muted or accent colour.
#let kicker(body, color: auto) = themed(t => {
  set text(
    size: t.scale.fine,
    tracking: 0.18em,
    weight: 700,
    font: t.fonts.body,
    fill: if color == auto { t.colors.muted } else { color },
  )
  upper(body)
})

/// A source / provenance line, as used under figures and data stories.
#let source-note(body, prefix: [Source: ]) = themed(t => {
  set text(size: t.scale.fine, fill: t.colors.muted, font: t.fonts.body)
  set par(leading: 0.5em)
  if prefix != none { text(weight: 600, prefix) }
  body
})

/// Normalise an image source and place it to fill its container.
///
/// Typst resolves a relative path against the file that *contains* the call,
/// so a bare relative path handed across a module boundary would be looked up
/// inside this package rather than next to your report. Pass one of:
///
///   - `read("assets/x.png", encoding: none)` — bytes, always correct;
///   - `"/assets/x.png"` — a root-absolute path, resolved from the project root;
///   - ready-made `image(..)` content, which is placed as given.
#let bleed(
  /// Bytes, a root-absolute path, or content.
  src,
  /// Desaturate before placing (used by the `"tint"` treatments).
  grayscale: false,
) = {
  if src == none { return none }
  if type(src) == content { return src }
  let data = if type(src) == bytes { src } else { read(src, encoding: none) }
  if grayscale {
    image-grayscale(data, width: 100%, height: 100%, fit: "cover")
  } else {
    image(data, width: 100%, height: 100%, fit: "cover")
  }
}
