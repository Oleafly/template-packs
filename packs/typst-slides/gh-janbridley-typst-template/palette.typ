// palette.typ
//
//   #import "palette.typ": palette
//   #text(fill: palette.teal)[...]

#let palette = (
  // anchor purple (opens every row in the SVG)
  purple: rgb("#71618D"),
  purple-light: rgb("#A594C3"),
  lilac: rgb("#DCD4E6"),
  mauve: rgb("#AFA8BA"),
  // warm row
  orange: rgb("#FF9B7D"),   // the sidebar orange (template.svg rgb(255,155,125))
  peach: rgb("#FFCEB1"),
  pink: rgb("#C76E96"),
  yellow: rgb("#F9F871"),
  cream: rgb("#FEFEDF"),
  // earthy accents
  rust: rgb("#925A4F"),
  clay: rgb("#CA8D80"),
  taupe: rgb("#BEA6A1"),
  // cool row
  sage: rgb("#4D8075"),
  teal: rgb("#00C9A4"),
  mint: rgb("#53FBDD"),
  deep-teal: rgb("#007897"),
  blue: rgb("#5594CB"),
  cyan: rgb("#00CAE9"),
  // neutrals row
  ink: rgb("#030519"),
  gray-dark: rgb("#6C6575"),
  gray: rgb("#8F8899"),
  gray-darker: rgb("#4A4453"),
  accent: rgb("#B9497B"),
)

/// Hex string of a color, e.g. `#FF9B7D`.
#let hex-of(color) = upper(color.to-hex())

/// A swatch / name / hex reference table for the palette (or any color
/// dictionary). Long palettes are split into two side-by-side tables.
#let palette-table(colors: palette) = {
  let rows(entries) = entries.map(((name, c)) => (
    // rectangular swatch (hairline so pale colors stay visible)
    block(
      fill: c,
      width: 100%,
      height: 0.75em,
      radius: 2pt,
      stroke: 0.5pt + colors.at("gray", default: luma(150)),
    ),
    name,
    hex-of(c),
  )).flatten()
  let make(entries) = table(
    columns: (0.75in, 1fr, auto),
    align: (center, left, left),
    inset: 0.35em,
    stroke: 0.5pt + colors.at("gray", default: luma(150)),
    table.header([*Swatch*], [*Name*], [*Hex*]),
    ..rows(entries),
  )
  let entries = colors.pairs()
  if entries.len() > 12 {
    let half = int(entries.len() / 2)
    grid(
      columns: (1fr, 1fr),
      gutter: 1.2em,
      make(entries.slice(0, half)),
      make(entries.slice(half)),
    )
  } else {
    make(entries)
  }
}
