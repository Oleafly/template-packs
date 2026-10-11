// ============================================================
// AUTO — Heading tanpa nomor untuk DAFTAR ISI, DAFTAR PUSTAKA, dll
// ============================================================

#let headz(outlined: true, size: auto, body) = heading(
  level: 1,
  outlined: outlined,
  numbering: none,
  // Membungkus body dengan text(size) agar tidak di-override show rule di template.typ
  if size != auto { text(size: size, body) } else { body },
)
