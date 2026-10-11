// ============================================================
// AUTO — Wrapper agar tabel bisa dipotong antar halaman
// ============================================================

#let allow-table-break(body) = {
  show figure.where(kind: table): set block(breakable: true)
  body
}
