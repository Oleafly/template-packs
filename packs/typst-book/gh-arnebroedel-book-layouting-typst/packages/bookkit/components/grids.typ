// components/grids.typ — Grid components

#import "../theme.typ": fonts, palette, space, type-scale

// ── Gallery grid ───────────────────────────────────────────────
// Dynamic grid with cycling color accents.
#let gallery-grid(
  items,
  column-count: 3,
  gutter: space.md,
  colors: (palette.primary, palette.accent, palette.info, palette.success),
) = {
  let cells = items
    .enumerate()
    .map(((i, item)) => {
      let color = colors.at(calc.rem(i, colors.len()))
      block(
        width: 100%,
        inset: space.md,
        radius: 4pt,
        fill: color.lighten(85%),
        stroke: 0.5pt + color.lighten(40%),
        breakable: false,
        item,
      )
    })

  grid(
    columns: (1fr,) * column-count,
    gutter: gutter,
    ..cells,
  )
}

// ── Feature grid ───────────────────────────────────────────────
// Icon + title + description feature cards.
#let feature-grid(
  features,
  column-count: 3,
) = {
  let cells = features.map(f => {
    block(
      width: 100%,
      inset: space.md,
      radius: 4pt,
      fill: palette.bg-subtle,
      breakable: false,
      {
        text(size: type-scale.h3, f.icon)
        v(space.sm)
        text(size: type-scale.body, weight: "bold", font: fonts.sans, f.title)
        v(space.xs)
        text(size: type-scale.small, f.body)
      },
    )
  })

  grid(
    columns: (1fr,) * column-count,
    gutter: space.md,
    ..cells,
  )
}

// ── Stats grid ─────────────────────────────────────────────────
// Key statistics / KPI display with large numbers.
#let stats-grid(
  stats,
  column-count: auto,
) = {
  let cols = if column-count == auto { stats.len() } else { column-count }

  let cells = stats.map(s => {
    align(
      center,
      block(
        width: 100%,
        inset: space.md,
        breakable: false,
        {
          text(size: type-scale.h1, weight: "bold", fill: palette.primary, s.value)
          v(space.xs)
          text(size: type-scale.small, fill: palette.text-muted, s.label)
        },
      ),
    )
  })

  grid(
    columns: (1fr,) * cols,
    gutter: space.md,
    ..cells,
  )
}

// ── Comparison grid ────────────────────────────────────────────
// Before/after or A vs B grid with labeled headers.
#let comparison-grid(
  left,
  right,
  left-title: "Vorher",
  right-title: "Nachher",
) = {
  grid(
    columns: (1fr, 1fr),
    gutter: space.md,
    block(
      width: 100%,
      inset: space.sm,
      fill: palette.primary,
      radius: (top: 4pt),
      text(fill: white, weight: "bold", left-title),
    ),
    block(
      width: 100%,
      inset: space.sm,
      fill: palette.accent,
      radius: (top: 4pt),
      text(fill: white, weight: "bold", right-title),
    ),

    block(width: 100%, inset: space.md, stroke: (rest: 0.5pt + palette.border-light), left),
    block(width: 100%, inset: space.md, stroke: (rest: 0.5pt + palette.border-light), right),
  )
}
