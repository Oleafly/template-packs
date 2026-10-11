// ============================================================
// AUTO — Figure wrapper untuk kode sumber dengan syntax highlight
// ============================================================
// Penggunaan:
//   #kode-sumber(caption: "Judul", ```python
//   def hello(): pass
//   ```)

#let kode-sumber(caption: "", body) = figure(
  kind: "kode",
  supplement: [Kode Sumber],
  caption: caption,
  block(
    fill: luma(248),
    stroke: 0.5pt + luma(200),
    radius: 3pt,
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    align(left, body),
  ),
)
