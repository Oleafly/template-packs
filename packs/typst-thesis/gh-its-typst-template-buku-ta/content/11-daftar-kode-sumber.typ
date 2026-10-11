// ============================================================
// AUTO — Daftar kode sumber, dibangun otomatis dari #kode-sumber()
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR KODE SUMBER]
#v(1cm)
#show outline.entry: it => {
  set text(size: 12pt, weight: "regular")
  set par(hanging-indent: 8em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: "kode"))
