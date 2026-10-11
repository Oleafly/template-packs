// ============================================================
// AUTO — Daftar gambar, dibangun otomatis dari #gambar()
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR GAMBAR]
#v(1cm)
#show outline.entry: it => {
  set text(size: 12pt, weight: "regular")
  set par(hanging-indent: 6.5em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: image))
