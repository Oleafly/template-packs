// =============================================================================
// FORMULIR PENILAIAN PKL DARI PERUSAHAAN (Sesuai Lampiran 27 Pedoman PKL UBSI)
// =============================================================================
#import "../../lib.typ": *
#import "../metadata.typ": *

#pagebreak()

// Jika perusahaan memiliki format penilaian tersendiri, mahasiswa cukup melampirkan scannya
// Konfigurasi file-nilai-perusahaan ada di metadata.typ

#if file-nilai-perusahaan != none [
  #align(center)[
    #text(size: 14pt, weight: "bold")[LEMBAR NILAI PKL]
  ]
  #v(0.5cm)
  #image(file-nilai-perusahaan, width: 100%)
] else [
  // Format Lampiran 27 Halaman 1: Formulir Penilaian 13 Unsur
  align(center)[
    #text(size: 13pt, weight: "bold")[FORMULIR PENILAIAN PRAKTIK KERJA LAPANGAN (PKL)]
  ]
  #v(0.5cm)

  #set text(size: 10pt)
  #table(
    columns: (0.8cm, 6.5cm, 1fr),
    stroke: 0.5pt + black,
    inset: 4.5pt,
    [1], [Nama], [#penulis],
    [2], [Nomor Induk Mahasiswa], [#nim],
    [3], [Kelas], [#kelas],
    [4], [Perguruan Tinggi], [#universitas],
    [5], [Fakultas], [#fakultas],
    [6], [Program Studi], [#program-studi],
    [7], [Tgl. PKL], [#tanggal-mulai-pkl s/d #tanggal-selesai-pkl],
    [8], [Nama Instansi/Perusahaan], [#nama-instansi],
    [9], [Unit Kerja], [#divisi-instansi],
    [10], [Alamat instansi/ perusahaan], [#alamat-instansi],
    [11], [Telepon], [#kontak-instansi],
    [12], [Nama Pembimbing di Instansi], [Nama Pembimbing Perusahaan],
  )

  #v(0.3cm)
  #table(
    columns: (0.8cm, 9.5cm, 2.5cm, 2.5cm),
    stroke: 0.5pt + black,
    inset: 4.5pt,
    table.header(
      table.cell(rowspan: 2, align: center + horizon)[*No*],
      table.cell(rowspan: 2, align: center + horizon)[*Unsur Penilaian*],
      table.cell(colspan: 2, align: center)[*Nilai*],
      [*Angka*], [*Huruf*],
    ),
    // Kedisiplinan
    table.cell(colspan: 4, fill: luma(240))[*Kedisiplinan*],
    [1], [Ketepatan waktu/disiplin dalam mengerjakan tugas], [], [],
    [2], [Sikap kerja/prosedur kerja], [], [],
    [3], [Tanggung jawab terhadap tugas], [], [],
    [4], [Kehadiran/absensi], [], [],

    // Prestasi Kerja
    table.cell(colspan: 4, fill: luma(240))[*Prestasi kerja*],
    [5], [Kemampuan kerja], [], [],
    [6], [Keterampilan kerja], [], [],
    [7], [Kualitas hasil kerja], [], [],

    // Kemampuan Beradaptasi
    table.cell(colspan: 4, fill: luma(240))[*Kemampuan beradaptasi*],
    [8], [Kemampuan berkomunikasi], [], [],
    [9], [Kerjasama], [], [],
    [10], [Kerajinan/inisiatif], [], [],

    // Lain-lain
    table.cell(colspan: 4, fill: luma(240))[*Lain-lain*],
    [11], [Memiliki rasa percaya diri], [], [],
    [12], [Mematuhi aturan dan tata tertib PKL], [], [],
    [13], [Penampilan/kerapihan], [], [],

    // Rata-rata
    table.cell(colspan: 2, align: right)[*Nilai Rata-rata*], [], [],
  )

  #v(0.2cm)
  #text(size: 8.5pt, style: "italic")[
    *Ketentuan penilaian:*\
    Nilai diisi dengan angka antara 0 sampai 100.\
    Pada kolom Huruf, berisi kalimat dari angka. Contoh: Nilai 80 maka Huruf : Delapan Puluh
  ]

  // Halaman 2: Persetujuan Penilaian
  #pagebreak()
  #v(1cm)
  #table(
    columns: (1fr, 1fr),
    stroke: 0.5pt + black,
    inset: 6pt,
    table.cell(colspan: 2, fill: luma(240), align: center)[*Persetujuan Penilaian*],
    table.cell(colspan: 2)[*Judul Laporan:* #judul],
    [Tgl. Pengesahan: ], [Tgl. Penilaian: ],
    [Nama Dosen Penasehat Akademik:\ #dosen-pa], [Nama Penilai:\ Nama Pembimbing Perusahaan\ Jabatan: Kepala Divisi IT],
    [Tanda Tangan:

#v(1.5cm)], [Tanda Tangan:
(stempel instansi/ perusahaan)

#v(1.5cm)],
  )

  #v(1.5cm)
  #text(size: 8.5pt, style: "italic")[
    *Catatan:*\
    - Format Lembar Penilaian ini digunakan untuk mahasiswa yang mendapatkan Surat Keterangan PKL dari Perusahaan/Institusi\
    - Format ini digunakan jika perusahaan/instansi tidak memiliki format penilaian tersendiri\
    - Lembar Penilaian ini WAJIB dilampirkan dalam laporan Praktik Kerja Lapangan beserta Surat Keterangan PKL, dan harus asli.\
    - Apabila di tempat PKL memiliki format penilaian tersendiri, maka yang dilampirkan adalah dari perusahaan atau instansi tempat PKL.
  ]
]
