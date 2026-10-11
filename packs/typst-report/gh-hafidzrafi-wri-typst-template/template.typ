// template.typ
// Template Standar Proposal Kegiatan Workshop dan Riset Informatika (WRI) Polinema
// Gunakan berkas ini sebagai acuan pembuatan proposal kegiatan baru.

#import "lib/proposal.typ": *

#show: proposal

// ====================================================================
// 1. DATA KEGIATAN & KEPANITIAAN (SILAKAN UBAH SESUAI KEGIATAN ANDA)
// ====================================================================

#let ketua-pelaksana = (
  nama: "Nama Ketua Pelaksana",
  nim: "254107020000",
  prodi: "D-IV Teknik Informatika",
  jurusan: "Teknologi Informasi",
  alamat: "Jl. Alamat Ketua Pelaksana, Malang",
  telp: "081234567890"
)

#let kepanitiaan = (
  ketua-pelaksana: ketua-pelaksana,
  sekretaris: (nama: "Nama Sekretaris", nim: "254107020001"),
  bendahara: (nama: "Nama Bendahara", nim: "254107020002"),
  sekretaris-title: "Sekretaris Pelaksana",
  bendahara-title: "Bendahara Pelaksana",
  sie-list: (
    (
      nama: "Sie Acara",
      koordinator: (nama: "Nama Koordinator Acara", nim: "254107020003"),
      anggota: (
        (nama: "Nama Anggota Acara 1", nim: "254107020004"),
        (nama: "Nama Anggota Acara 2", nim: "254107020005"),
      )
    ),
    (
      nama: "Sie Kesekretariatan",
      koordinator: (nama: "Nama Koordinator Kestari", nim: "254107020006"),
      anggota: (
        (nama: "Nama Anggota Kestari 1", nim: "254107020007"),
        (nama: "Nama Anggota Kestari 2", nim: "254107020008"),
      )
    ),
    (
      nama: "Sie Humas",
      koordinator: (nama: "Nama Koordinator Humas", nim: "254107020009"),
      anggota: (
        (nama: "Nama Anggota Humas 1", nim: "254107020010"),
        (nama: "Nama Anggota Humas 2", nim: "254107020011"),
      )
    ),
    (
      nama: "Sie Pubdekdok",
      koordinator: (nama: "Nama Koordinator Pubdekdok", nim: "254107020012"),
      anggota: (
        (nama: "Nama Anggota Pubdekdok 1", nim: "254107020013"),
        (nama: "Nama Anggota Pubdekdok 2", nim: "254107020014"),
      )
    ),
    (
      nama: "Sie Konsumsi",
      koordinator: (nama: "Nama Koordinator Konsumsi", nim: "254107020015"),
      anggota: (
        (nama: "Nama Anggota Konsumsi 1", nim: "254107020016"),
        (nama: "Nama Anggota Konsumsi 2", nim: "254107020017"),
      )
    ),
    (
      nama: "Sie Perlengkapan",
      koordinator: (nama: "Nama Koordinator Perlengkapan", nim: "254107020018"),
      anggota: (
        (nama: "Nama Anggota Perlengkapan 1", nim: "254107020019"),
        (nama: "Nama Anggota Perlengkapan 2", nim: "254107020020"),
      )
    ),
  )
)

// Catatan: Jika sumber dana hanya 1 entitas, cukup tulis 1 item tanpa rincian.
// Otomatis akan dicetak tanpa strip pada lembar pengesahan.
#let sumber-dana = (
  (
    uraian: "Swadana",
    rincian: (
      (uraian: "Kas WRI", jumlah: 500000),
    )
  ),
)

// Daftar pengeluaran tiap sie. Typst akan otomatis menghitung subtotal dan total.
#let pengeluaran = (
  "Sie Acara": (
    (uraian: [#emph[Snack Reward] (3 #emph[set] x \@Rp12.000)], jumlah: 36000),
    (uraian: [Hadiah #emph[Mini Games]], jumlah: 50000),
  ),
  "Sie Kesekretariatan": (
    (uraian: "Cetak Proposal Kegiatan (12 lembar x @Rp500)", jumlah: 6000),
    (uraian: "Cetak Surat Peminjaman (6 lembar x @Rp500)", jumlah: 3000),
    (uraian: "Materai Rp10.000 (1 lembar x @Rp12.000)", jumlah: 12000),
    (uraian: "Jilid Proposal Kegiatan", jumlah: 6000),
  ),
  "Sie Konsumsi": (
    (uraian: "Air Galon Isi Ulang", jumlah: 7000),
    (uraian: [#emph[Snack] Peserta (100 #emph[pcs] x \@Rp2.500)], jumlah: 250000),
    (uraian: "Konsumsi Pemateri", jumlah: 50000),
  ),
  "Sie Perlengkapan": (
    (uraian: [Baterai #emph[Mic] (4 #emph[pcs] x \@Rp10.000)], jumlah: 40000),
    (uraian: "Lakban Hitam", jumlah: 40000),
  )
)

#let total-biaya = hitung-total-pengeluaran(pengeluaran)

// ==========================================
// HALAMAN 1: COVER
// ==========================================
#render-cover(
  nama-kegiatan: [PROPOSAL KEGIATAN\ WORKSHOP DAN RISET INFORMATIKA – NAMA KEGIATAN],
  tema-kegiatan: [“TEMA KEGIATAN WRI”],
  ketua-pelaksana: ketua-pelaksana,
  organisasi: "WORKSHOP DAN RISET INFORMATIKA",
  institusi: "POLITEKNIK NEGERI MALANG",
  tahun: "2026"
)

#pagebreak()

// ==========================================
// HALAMAN 2: SURAT PERNYATAAN KAPEL
// ==========================================
#render-surat-pernyataan(
  ketua-pelaksana: ketua-pelaksana,
  nama-kegiatan: "Nama Kegiatan WRI",
  hari-kegiatan: "Minggu",
  tanggal-pelaksanaan-teks: "hari Minggu tanggal 1 bulan November tahun 2026",
  jam-pelaksanaan: "09.00",
  periode-wri: "2026/2027",
  tanggal-surat: "20 Oktober 2026"
)

#pagebreak()

// ==========================================
// HALAMAN 3: LEMBAR PENGESAHAN
// ==========================================
#render-lembar-pengesahan(
  nama-kegiatan: "Nama Kegiatan WRI",
  sub-judul: "KE-XX WORKSHOP DAN RISET INFORMATIKA",
  ketua-pelaksana: ketua-pelaksana,
  waktu-pelaksanaan: "Minggu, 1 November 2026",
  tempat-pelaksanaan: "Ruang LSI 1, Lantai 6 Gedung Teknik Sipil Politeknik Negeri Malang",
  total-biaya: total-biaya,
  sumber-dana-list: ("Swadana",), // 1 item -> dicetak tanpa strip otomatis
  panitia-count: 21,
  peserta-count: 60,
  peserta-keterangan: "Mahasiswa Baru Jurusan Teknologi Informasi Politeknik Negeri Malang",
  tanggal-pengesahan: "20 Oktober 2026"
)

#pagebreak()

// ==========================================
// BATANG TUBUH PROPOSAL
// ==========================================

= I. PENDAHULUAN

== 1.1. Latar Belakang
#pad(left: 21.3pt)[
  #set par(first-line-indent: (amount: 32.4pt, all: true))
  Tuliskan latar belakang kegiatan secara komprehensif di sini. Jelaskan urgensi pelaksanaan kegiatan, konteks kebutuhan mahasiswa, serta kontribusi kegiatan terhadap pengembangan keilmuan dan komunitas Workshop dan Riset Informatika.

  Jelaskan pula fokus tema yang diusung serta target capaian pembelajaran atau luaran yang diharapkan dari seluruh rangkaian kegiatan.
]

== 1.2. Landasan Kegiatan
#pad(left: 21.3pt)[
  AD/ART Workshop dan Riset Informatika Politeknik Negeri Malang periode 2026/2027.
]

#v(18pt)
= II. NAMA KEGIATAN
#v(12pt)
#align(center)[“Nama Kegiatan WRI”]
#v(18pt)

= III. TEMA KEGIATAN
#v(12pt)
#align(center)[“Tema Kegiatan WRI”]
#v(12pt)

#pagebreak()

= IV. TUJUAN KEGIATAN
Tujuan diadakan Program Kerja ini adalah:
#pad(left: 18.0pt)[
  #set enum(indent: 0pt, body-indent: 18.0pt, spacing: 12pt)
  + Memperkenalkan komunitas Workshop dan Riset Informatika.
  + Meningkatkan wawasan dan keterampilan teknis peserta.
  + Memberikan wadah diskusi dan kolaborasi antar mahasiswa.
]

= V. WAKTU DAN TEMPAT KEGIATAN
Waktu dan tempat pelaksanaan kegiatan  ini adalah:
#pad(left: 10pt)[
  #grid(
    columns: (80pt, 10pt, 1fr),
    row-gutter: 10pt,
    [hari, tanggal], [:], [Minggu, 1 November 2026],
    [waktu], [:], [09.00 – 15.00 WIB],
    [tempat], [:], [Ruang LSI 1, Lantai 6 Gedung Teknik Sipil Politeknik Negeri Malang]
  )
]

= VI. SASARAN KEGIATAN
Sasaran kegiatan ini adalah :
+ Seluruh Mahasiswa Jurusan Teknologi Informasi Politeknik Negeri Malang.

#pagebreak()

= VII. SUSUNAN KEPANITIAAN
#render-susunan-kepanitiaan(
  kepanitiaan: kepanitiaan,
  tampilkan-petinggi: true,
  sie-start: 1,
  sie-end: 4
)

#pagebreak()

#v(20pt)
#render-susunan-kepanitiaan(
  kepanitiaan: kepanitiaan,
  tampilkan-petinggi: false,
  sie-start: 5,
  sie-end: 6
)

#pagebreak()

= VIII. SUSUNAN ACARA
#render-susunan-acara((
  (
    hari-tanggal: "Minggu, 1 November 2026",
    sesi: (
      (waktu: "08.30 – 09.00", acara: emph("Open Gate & Registrasi")),
      (waktu: "09.00 – 09.15", acara: emph("Opening MC")),
      (waktu: "09.15 – 09.30", acara: "Sambutan-Sambutan"),
      (waktu: "09.30 – 11.30", acara: "Penyampaian Materi & Praktik"),
      (waktu: "11.30 – 12.30", acara: emph("Ishoma (Istirahat, Sholat, Makan)")),
      (waktu: "12.30 – 14.30", acara: emph("Hands-on Workshop & Mentoring")),
      (waktu: "14.30 – 14.45", acara: "Pengumuman Peserta Terbaik & Kuis"),
      (waktu: "14.45 – 15.00", acara: emph("Closing & Foto Bersama")),
    )
  ),
))

#pagebreak()

= IX. ALOKASI DANA

== 9.1 SUMBER DANA
#render-sumber-dana(sumber-dana)

== 9.2 PENGELUARAN TIAP SIE
#render-pengeluaran-sie(pengeluaran, sie-names: ("Sie Acara", "Sie Kesekretariatan"), sie-offset: 1)

#pagebreak()

#render-pengeluaran-sie(pengeluaran, sie-names: ("Sie Konsumsi", "Sie Perlengkapan"), sie-offset: 3)

== 9.3 TOTAL PENGELUARAN
#render-rekapitulasi(pengeluaran)

#pagebreak()

= X. PENUTUP
#v(6pt)

#h(21.3pt) Demikian proposal Nama Kegiatan WRI ini kami susun dengan sesungguh-sungguhnya, guna terlaksananya program kerja Workshop dan Riset Informatika Politeknik Negeri Malang periode 2026/2027.

Untuk merealisasikannya, kami sangat berharap kerja sama dan bantuan semua pihak yang terkait baik secara moral maupun spriritual demi kesuksesan penyelenggaraan kegiatan ini.

Atas kesediaan dan perhatian semua pihak, kami mengucapkan terima kasih.

#pagebreak()

// ==========================================
// LAMPIRAN: DAFTAR PANITIA OFFLINE
// ==========================================
#render-daftar-panitia-offline(
  "NAMA PROGRAM KERJA / KEGIATAN RESMI",
  kepanitiaan
)
