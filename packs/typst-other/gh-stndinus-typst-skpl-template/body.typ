#import "lib.typ": document_no, figtbl

= Pendahuluan
== Tujuan Penulisan Dokumen
#lorem(50)
== Lingkup Masalah
#lorem(50)
== Definisi dan Istilah
Berikut adalah daftar definisi dan istilah penting yang digunakan dalam dokumen SKPL ini:
#{
  show grid.cell.where(x: 0): strong
  grid(
    columns: 2,
    gutter: 1em,
    [- SRS], [: Software Requirement Specification, atau],
    [- SKPL], [: Dokumen Spesifikasi Kebutuhan Perangkat Lunak],
  )
}
== Aturan Penamaan dan Penomoran
#figure(caption: [Aturan penamaan dan penomoran], figtbl(
  columns: (auto, 1fr),
  table.header([Hal/Bagian], [Aturan Penomoran/Penamaan]),
  [Nomor dokumen SKPL],
  [Antisipasi 3 digit (i.e. `SKPL-XXX`, e.g. #raw("SKPL-" + document_no))],
))
== Referensi
== Ikhtisar Dokumen

= Deskripsi Umum Perangkat Lunak
== Deskripsi Umum Sistem
== Fungsi Produk
== Karakteristik Pengguna
== Batasan
== Lingkungan Operasi

= Deskripsi Umum Kebutuhan
== Kebutuhan Antarmuka Eksternal
=== Antarmuka Pengguna
=== Antarmuka Perangkat Keras
=== Antarmuka Perangkat Lunak
=== Antarmuka Komunikasi

== Deskripsi Fungsional
=== _Use Case Diagram_
#figure(
  image("diagrams/use_case_example.png"),
  caption: [Contoh diagram _use case_],
)
=== Fungsi 1: `{nama_use_case}`
==== Skenario: `{nama_use_case}`
==== Diagram Aktivitas: `{nama_use_case}`
==== Diagram Sekuens: `{nama_use_case}`
==== Diagram Kolaborasi Objek: `{nama_use_case}`

== Deskripsi Kelas-kelas
=== Diagram Kelas
=== Deskripsi Domain Persoalan
=== Deskripsi Kelas Pengendali
=== Deskripsi Kelas _Entity (Persisten)_
=== Deskripsi Kelas _Boundary_

== Deskripsi Perilaku Sistem
== Deployment Diagram
== Kebutuhan Non Fungsional
== Batasan Perancangan
== Ringkasan Kebutuhan
=== Ringkasan Kebutuhan Fungsional
=== Ringkasan Kebutuhan Non Fungsional

#heading(numbering: none)[KONTRIBUSI ANGGOTA KELOMPOK]
