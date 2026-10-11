// ============================================================
// AUTO — Daftar tabel, terisi otomatis dari setiap #figure(kind: table)
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR TABEL]
#v(0.8cm)
#show outline.entry: it => {
  set text(size: 11pt, weight: "regular")
  set par(hanging-indent: 5.5em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: table))
