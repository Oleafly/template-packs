// ============================================================
// AUTO — Daftar kode sumber, terisi otomatis dari setiap #kode-sumber()
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR KODE SUMBER]
#v(0.8cm)
#show outline.entry: it => {
  set text(size: 11pt, weight: "regular")
  set par(hanging-indent: 7em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: "kode"))
