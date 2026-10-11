// ============================================================
// AUTO — Daftar tabel, dibangun otomatis dari figure tabel
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR TABEL]
#v(1cm)
#show outline.entry: it => {
  set text(size: 12pt, weight: "regular")
  set par(hanging-indent: 5.5em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: table))
