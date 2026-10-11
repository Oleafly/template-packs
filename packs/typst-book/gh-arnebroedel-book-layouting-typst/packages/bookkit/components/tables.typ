// components/tables.typ — Table components

#import "../theme.typ": fonts, palette, space, type-scale

// ── Styled table ───────────────────────────────────────────────
// Base table with header styling and zebra striping.
#let styled-table(..args) = {
  block(
    breakable: false,
    above: space.lg,
    below: space.lg,
    width: 100%,
    table(
      stroke: 0.5pt + palette.border-light,
      inset: (x: space.md, y: space.sm),
      fill: (x, y) => {
        if y == 0 { palette.primary } else if calc.even(y) { palette.bg-subtle } else { white }
      },
      ..args,
    ),
  )
}

// ── Comparison table ───────────────────────────────────────────
// Feature comparison with semantic coloring.
#let comparison-table(headers: (), rows: ()) = {
  let col-count = headers.len()

  block(
    breakable: false,
    above: space.lg,
    below: space.lg,
    width: 100%,
    table(
      columns: col-count,
      stroke: 0.5pt + palette.border-light,
      inset: (x: space.md, y: space.sm),
      fill: (x, y) => {
        if y == 0 { palette.primary } else if calc.even(y) { palette.bg-subtle } else { white }
      },
      ..headers.map(h => text(fill: white, weight: "bold", size: type-scale.small, h)),
      ..rows.flatten(),
    ),
  )
}

// ── Long table (multi-page, repeating header) ──────────────────
// Like styled-table but breakable across pages. Wrap the header row
// in `table.header(...)` so it repeats automatically (Typst 0.11+).
#let long-table(..args) = {
  block(
    breakable: true,
    above: space.lg,
    below: space.lg,
    width: 100%,
    table(
      stroke: 0.5pt + palette.border-light,
      inset: (x: space.md, y: space.sm),
      fill: (x, y) => {
        if y == 0 { palette.primary } else if calc.even(y) { palette.bg-subtle } else { white }
      },
      ..args,
    ),
  )
}

// ── Cell spanning helpers ──────────────────────────────────────
// Thin wrappers around table.cell for merged cells.
#let cspan(n, body, ..opts) = table.cell(colspan: n, ..opts, body)
#let rspan(n, body, ..opts) = table.cell(rowspan: n, ..opts, body)

// ── Score table ────────────────────────────────────────────────
// Clinical scoring scheme (e.g. Glasgow Coma Scale, APACHE). Rows are
// `(criterion, points)` pairs; an optional highlighted total row is
// appended when `total` is given.
#let score-table(
  rows,
  headers: ([Kriterium], [Punkte]),
  total: none,
  total-label: [Summe],
) = {
  block(
    breakable: false,
    above: space.lg,
    below: space.lg,
    width: 100%,
    table(
      columns: (1fr, auto),
      align: (left, center),
      stroke: 0.5pt + palette.border-light,
      inset: (x: space.md, y: space.sm),
      fill: (x, y) => {
        if y == 0 { palette.primary } else if calc.even(y) { palette.bg-subtle } else { white }
      },
      table.header(..headers.map(h => text(fill: white, weight: "bold", size: type-scale.small, h))),
      ..rows.map(((crit, pts)) => (crit, align(center, [#pts]))).flatten(),
      ..if total != none {
        (
          table.cell(fill: palette.accent.lighten(75%), text(weight: "bold", font: fonts.sans, total-label)),
          table.cell(
            fill: palette.accent.lighten(75%),
            align(center, text(weight: "bold", font: fonts.sans, [#total])),
          ),
        )
      } else { () },
    ),
  )
}

// ── Reference-value table ──────────────────────────────────────
// Laboratory / vital-sign table with deviation highlighting. Each row
// is a dict: (param, value, range, flag). `flag` ∈ "normal" | "high" |
// "low" | "crit" drives the color of the value and a status chip.
#let _flag-meta = (
  normal: (color: palette.success, mark: sym.checkmark, label: "normal"),
  high: (color: palette.danger, mark: sym.arrow.t, label: "erhöht"),
  low: (color: palette.info, mark: sym.arrow.b, label: "erniedrigt"),
  crit: (color: palette.danger, mark: sym.arrow.t, label: "kritisch"),
)

#let reference-table(
  rows,
  headers: ([Parameter], [Wert], [Referenz], [Status]),
) = {
  let status-chip(flag) = {
    let m = _flag-meta.at(flag, default: _flag-meta.normal)
    box(
      fill: m.color.lighten(if flag == "crit" { 0% } else { 82% }),
      inset: (x: 5pt, y: 2pt),
      radius: 3pt,
      text(
        size: type-scale.tiny,
        weight: "bold",
        font: fonts.sans,
        fill: if flag == "crit" { white } else { m.color.darken(12%) },
        [#m.mark #m.label],
      ),
    )
  }

  block(
    breakable: true,
    above: space.lg,
    below: space.lg,
    width: 100%,
    table(
      columns: (1.4fr, auto, auto, auto),
      align: (left, right, center, center),
      stroke: 0.5pt + palette.border-light,
      inset: (x: space.md, y: space.sm),
      fill: (x, y) => {
        if y == 0 { palette.primary } else if calc.even(y) { palette.bg-subtle } else { white }
      },
      table.header(..headers.map(h => text(fill: white, weight: "bold", size: type-scale.small, h))),
      ..rows
        .map(r => {
          let m = _flag-meta.at(r.flag, default: _flag-meta.normal)
          let value-cell = if r.flag == "normal" {
            [#r.value]
          } else {
            text(fill: m.color.darken(8%), weight: "bold", [#r.value])
          }
          (r.param, value-cell, text(fill: palette.text-muted, size: type-scale.small, [#r.range]), status-chip(r.flag))
        })
        .flatten(),
    ),
  )
}
