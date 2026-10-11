// ============================================================
// AUTO — Daftar kode semu, dibangun otomatis dari #kode-semu()
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR KODE SEMU]
#v(1cm)
#show outline.entry: it => {
  set text(size: 12pt, weight: "regular")
  set par(hanging-indent: 7em)
  v(0.6em, weak: true)
  it
}
#outline(title: none, target: figure.where(kind: "kode-semu"))
