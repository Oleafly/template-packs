// Ganti semua nilai di blok ini saja untuk identitas dokumen.
#let kampus = "NAMA UNIVERSITAS"
#let fakultas = "FAKULTAS / SEKOLAH"
#let prodi = "PROGRAM STUDI"
#let judul = "JUDUL SKRIPSI ATAU TESIS ANDA"
#let penulis = "Nama Mahasiswa"
#let nim = "1234567890"
#let pembimbing = "Nama Dosen Pembimbing, S.T., M.T."
#let tahun = "2026"

#import "template.typ": setup, cover

#show: setup
#cover(kampus, fakultas, prodi, judul, penulis, nim, pembimbing, tahun)

#pagebreak()
#set page(
  header: align(right)[#text(size: 9pt)[#prodi — #judul]],
  footer: context align(center)[#counter(page).display("1")],
)
#include "bagian/abstrak.typ"

#pagebreak()
#include "bagian/abstract.typ"

#pagebreak()
#outline(title: [DAFTAR ISI])

#pagebreak()
#include "bab/01-pendahuluan.typ"

#pagebreak()
#include "bab/02-tinjauan-pustaka.typ"

#pagebreak()
#include "bab/03-metodologi.typ"

#pagebreak()
#include "bab/04-hasil-pembahasan.typ"

#pagebreak()
#include "bab/05-kesimpulan.typ"

#pagebreak()
#set text(size: 11pt)
= Daftar Pustaka

#bibliography("references.bib", style: "ieee")
