// ============================================================
// AUTO — Halaman sampul luar. Semua isi diambil dari data.yaml.
// Tata letak: pita putih berisi logo di atas, badan merah di bawah.
// ============================================================

#import "../template/lib.typ": *

// Warna sampul (merah bata) — ubah di sini kalau pedoman berubah
#let warna-sampul = rgb("#BF504D")

#let _logo() = image("../assets/brand/logo-its-docx.png", height: 2.2cm)

// Blok teks sampul. Dipakai ulang oleh halaman judul (versi hitam-putih).
#let isi-sampul(data, warna-teks: white) = [
  #set text(fill: warna-teks, font: "Arial")
  #set par(first-line-indent: 0pt, justify: false, leading: 0.7em, spacing: 0.6em)

  // Baris mata kuliah, contoh: "MAGANG – EF234722"
  #text(size: 10pt, weight: "bold")[#data.tipe – #data.kode-mk]
  #v(0.5cm)

  // Judul laporan
  #text(size: 12pt, weight: "bold")[#data.judul]
  #v(0.7cm)

  // Tempat & waktu pelaksanaan
  #text(size: 10pt)[
    #data.instansi.nama \
    #data.instansi.alamat \
    Periode: #data.periode.mulai – #data.periode.selesai
  ]
  #v(1.0cm)

  // Penulis
  #text(size: 10pt, weight: "bold")[Oleh:]
  #v(0.35cm)
  #grid(
    columns: (5.2cm, auto),
    text(size: 10pt)[#data.mahasiswa.nama],
    text(size: 10pt)[#data.mahasiswa.nrp],
  )
  #v(0.4cm)

  // Pembimbing
  #text(size: 10pt)[
    #text(weight: "bold")[Pembimbing Departemen] \
    #data.pembimbing-departemen.nama
  ]
  #v(0.35cm)
  #text(size: 10pt)[
    #text(weight: "bold")[Pembimbing Lapangan] \
    #data.pembimbing-lapangan.nama
  ]
  #v(0.8cm)

  // Institusi
  #text(size: 10pt)[
    #upper(data.institusi.departemen) \
    #data.institusi.fakultas \
    #data.institusi.nama \
    #data.institusi.kota #data.tahun
  ]
]

#let halaman-cover(data) = {
  set page(
    paper: "a5",
    margin: 0cm,
    fill: warna-sampul,
    header: none,
    footer: none,
    numbering: none,
  )

  // Pita putih atas berisi logo ITS
  block(
    fill: white,
    width: 100%,
    height: 5.2cm,
    inset: (left: 2.5cm, right: 2cm, top: 1.4cm, bottom: 1.4cm),
    align(left + horizon, _logo()),
  )

  // Badan merah
  pad(left: 2.5cm, right: 2cm, top: 1.1cm, bottom: 0cm, isi-sampul(data))
}
