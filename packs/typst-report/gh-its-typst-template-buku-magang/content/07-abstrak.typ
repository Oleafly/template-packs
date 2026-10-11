// ============================================================
// WAJIB EDIT — Abstrak laporan (sekitar 150–250 kata) + kata kunci.
// ============================================================

#import "../template/lib.typ": *

// ISI ABSTRAK — EDIT DI SINI
// Ringkas: latar belakang, tujuan, metode, hasil, kesimpulan.
#let isi-abstrak = [
  [Isi abstrak laporan Magang ditulis di sini. Abstrak berisi ringkasan singkat
  tentang latar belakang, tujuan, metode, hasil, dan kesimpulan. Panjang sekitar
  150–250 kata.]
]

// KATA KUNCI — EDIT DI SINI (3–5 kata, boleh pakai _miring_)
#let kata-kunci = ([kata kunci 1], [kata kunci 2], [kata kunci 3])

// ============================================================
// Tata letak — tidak perlu diedit
// ============================================================

#let halaman-abstrak(data) = {
  // Penanda untuk DAFTAR ISI — tidak tampil di halaman
  {
    show heading: none
    heading(level: 1, outlined: true, numbering: none)[ABSTRAK]
  }

  set par(first-line-indent: 0pt, justify: false)

  align(center, text(size: 12pt, weight: "bold")[#data.judul])
  v(0.7cm)

  entry-fields(
    (
      ([Nama Mahasiswa], [#data.mahasiswa.nama]),
      ([NRP], [#data.mahasiswa.nrp]),
      ([Departemen], [#data.institusi.departemen]),
      ([Pembimbing Departemen], [#data.pembimbing-departemen.nama]),
      ([Pembimbing Lapangan], [#data.pembimbing-lapangan.nama]),
    ),
    col-widths: (4cm, 0.3cm, 1fr),
  )

  v(0.8cm)
  align(center, text(size: 12pt, weight: "bold")[ABSTRAK])
  v(0.5cm)

  set par(justify: true, first-line-indent: 1.25cm)
  isi-abstrak

  v(0.6cm)
  set par(first-line-indent: 0pt, justify: false)
  text(weight: "bold", style: "italic")[Kata Kunci: #kata-kunci.join(", ")]
}
