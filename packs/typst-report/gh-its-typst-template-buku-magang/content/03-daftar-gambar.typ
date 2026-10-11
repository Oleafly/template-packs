// ============================================================
// AUTO — Daftar gambar, terisi otomatis dari setiap #gambar()
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR GAMBAR]
#v(0.8cm)
#show outline.entry: it => {
  set text(size: 11pt, weight: "regular")
  set par(hanging-indent: 5.5em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: image))
