// ============================================================
// WAJIB EDIT — Kata pengantar. Ganti isi ucapan terima kasih.
// ============================================================

#import "../template/lib.typ": *

#let kata-pengantar(data) = {
  headz[KATA PENGANTAR]
  v(0.8cm)
  set par(justify: true, first-line-indent: 1.25cm)

  [
    Puji syukur penulis panjatkan kepada Tuhan Yang Maha Esa atas karunia-Nya sehingga
    penulis dapat menyelesaikan Laporan Magang yang berjudul:
    "#data.judul".

    Penulis menyadari bahwa masih banyak kekurangan dalam pelaksanaan magang maupun
    penyusunan laporan ini. Namun penulis berharap laporan ini dapat bermanfaat bagi
    pembaca.

    Penulis ingin menyampaikan rasa terima kasih kepada:
  ]

  set par(first-line-indent: 0pt)
  enum(
    [Kedua orang tua penulis.],
    [Bapak/Ibu #data.pembimbing-departemen.nama selaku dosen pembimbing departemen.],
    [Bapak/Ibu #data.pembimbing-lapangan.nama selaku pembimbing lapangan selama
     magang berlangsung.],
    [Teman-teman penulis yang senantiasa memberikan semangat selama pelaksanaan Magang.],
  )

  v(0.8cm)
  align(right)[#data.institusi.kota, #data.tanggal-laporan]
  v(1.6cm)
  align(right)[#data.mahasiswa.nama]
}
