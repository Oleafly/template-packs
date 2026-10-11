// Reusable slide components in the visual language of the UNN brand book.

#import "colors.typ": unn-colors

/// Big statistic: a large bold number with a small caption below.
#let stat(
  value,
  label,
  color: unn-colors.primary,
  value-size: 44pt,
  label-size: 12pt,
) = align(center, stack(
  spacing: 8pt,
  text(size: value-size, weight: "bold", fill: color, value),
  text(size: label-size, fill: unn-colors.gray, label),
))

/// Rounded plaque.
#let pill(
  body,
  fill: unn-colors.panel,
  text-fill: unn-colors.text,
  stroke: none,
  radius: 8pt,
  inset: (x: 12pt, y: 8pt),
  width: auto,
) = box(
  fill: fill,
  stroke: stroke,
  radius: radius,
  inset: inset,
  width: width,
  text(fill: text-fill, body),
)

/// Two-column layout.
#let two-col(
  left,
  right,
  columns: (1fr, 1fr),
  gutter: 18pt,
  align: top,
) = grid(
  columns: columns,
  column-gutter: gutter,
  align: align,
  left, right,
)

/// Map of result clusters: a row of plaques. Indices in `done` are filled
/// green, the `current` index is highlighted with the primary color, the
/// rest stay neutral. Indices are zero-based.
#let result-map(
  items,
  current: none,
  done: (),
  size: 12pt,
  gutter: 8pt,
  height: 52pt,
) = grid(
  columns: (1fr,) * items.len(),
  column-gutter: gutter,
  ..items
    .enumerate()
    .map(((i, item)) => {
      let (fill, text-fill, stroke) = if i in done {
        (unn-colors.green, unn-colors.primary, none)
      } else if i == current {
        (unn-colors.primary, white, none)
      } else {
        (unn-colors.panel-light, unn-colors.gray, unn-colors.panel + 1pt)
      }
      box(
        fill: fill,
        stroke: stroke,
        radius: 8pt,
        inset: (x: 8pt, y: 7pt),
        width: 100%,
        height: height,
        align(center + horizon, text(size: size, fill: text-fill, item)),
      )
    })
)

/// Arrow chain of stages, e.g. Rocq -> OCaml -> JSON -> figures.
#let trust-chain(
  ..steps,
  fill: unn-colors.panel,
  text-fill: unn-colors.primary,
  arrow-fill: unn-colors.accent-blue,
  size: 14pt,
  gutter: 10pt,
) = {
  let cells = steps
    .pos()
    .map(step => box(
      fill: fill,
      radius: 8pt,
      inset: (x: 12pt, y: 9pt),
      align(center + horizon, text(size: size, fill: text-fill, step)),
    ))
    .intersperse(text(
      size: size + 4pt,
      fill: arrow-fill,
      weight: "bold",
      sym.arrow.r,
    ))
  align(center, grid(
    columns: cells.len(),
    column-gutter: gutter,
    align: horizon,
    ..cells,
  ))
}
