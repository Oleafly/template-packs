#import "template.typ": *

#let meta = (
  title: "JUDUL LAPORAN",
  subtitle: "LAPORAN PRAKTIK KERJA LAPANGAN",
  author: "NAMA MAHASISWA",
  nim: "NIM",
  program: "NAMA PROGRAM STUDI",
  faculty: "NAMA FAKULTAS",
  purpose: "Diajukan untuk memenuhi salah satu syarat kelulusan",
  city: "KOTA",
  year: "TAHUN",
  logo: university-logo,
)

#show: thesis

// Lembar judul dihitung sebagai halaman awal, tetapi tidak menampilkan nomor.
#cover(meta)

#front-matter[
  // #include "frontmatter/preface.typ"
  // #pagebreak()
  #section-title([DAFTAR ISI])
  #outline(title: none, depth: 3)
  #pagebreak()
  #section-title([DAFTAR GAMBAR])
  #outline(title: none, target: figure.where(kind: image))
  #pagebreak()
  #section-title([DAFTAR TABEL])
  #outline(title: none, target: figure.where(kind: table))
]

#main-matter[
  // Bagian awal tidak memengaruhi nomor Bab I.
  #counter(heading).update(0)
  #include "chapters/bab-1-pendahuluan.typ"
  #include "chapters/bab-2-analisis-dan-perancangan-basis-data.typ"
  #include "chapters/bab-3-implementasi-basis-data.typ"
  #include "chapters/bab-4-penutup.typ"
]

// #back-matter[
//   #section-title([DAFTAR PUSTAKA])
//   #bibliography("references.yml", style: "apa")
// ]
