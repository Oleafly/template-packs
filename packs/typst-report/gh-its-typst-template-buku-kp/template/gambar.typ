// ============================================================
// AUTO — Figure wrapper untuk gambar dengan caption dan supplement otomatis
// ============================================================

#let gambar(path, caption: "", width: 80%) = figure(
  image(path, width: width),
  caption: caption,
  supplement: [Gambar],
)
