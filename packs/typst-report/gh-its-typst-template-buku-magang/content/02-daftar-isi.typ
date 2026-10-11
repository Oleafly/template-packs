// ============================================================
// AUTO — Daftar isi, dibangun otomatis dari heading dokumen.
// Tidak perlu diketik manual: tambah bab/sub-bab, daftar ikut berubah.
// ============================================================

#import "../template/lib.typ": headz
#headz[DAFTAR ISI]
#v(0.8cm)
#show outline.entry: it => {
  show linebreak: [ ]
  set text(size: 11pt, weight: "regular")
  v(0.8em, weak: true)
  it
}

#outline(
  title: none,
  depth: 3,
  indent: level => level * 1em,
)
