// ============================================================
// AUTO — Grid label:nilai untuk abstrak, pernyataan, dll
// ============================================================
// entries: array of (label, value) tuples

#let entry-fields(entries, col-widths: (5cm, 0.5cm, 1fr), row-gutter: 4pt, bold-labels: false) = grid(
  columns: col-widths,
  row-gutter: row-gutter,
  ..entries.map(v => (
    if bold-labels { text(weight: "bold", v.at(0)) } else { v.at(0) },
    [: ],
    v.at(1),
  )).flatten(),
)
