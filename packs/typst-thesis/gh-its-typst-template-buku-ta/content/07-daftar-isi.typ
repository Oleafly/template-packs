// ============================================================
// AUTO — Daftar isi, dibangun otomatis dari heading dokumen
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR ISI]
#v(1cm)
#show outline.entry: it => {
  show linebreak: [ ]
  set text(size: 12pt, weight: "regular")
  v(1em, weak: true)
  it
}

#outline(
  title: none,
  depth: 3,
  indent: level => level * 1.2em,
)
