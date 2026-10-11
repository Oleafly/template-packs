/**
 * Lampiran 1 — LAPORAN MINGGUAN PELAKSANAAN AKTUALISASI MINGGU KE-1 & 2
 */

#import "/src/metadata.typ": namaDenganGelar, nip, satker

= LAPORAN MINGGUAN PELAKSANAAN AKTUALISASI MINGGU KE-1 & 2 <lamp-1>

#table(
  columns: (auto, 1fr),
  stroke: 0.5pt,
  inset: 6pt,
  align: left + horizon,
  table.cell(fill: rgb("ebf1dd"))[*Nama Peserta*], [: #namaDenganGelar],
  table.cell(fill: rgb("ebf1dd"))[*NIP*], [: #nip],
  table.cell(fill: rgb("ebf1dd"))[*Unit Kerja*], [: #satker],
  table.cell(fill: rgb("ebf1dd"))[*Rumusan Isu*], [: ...],
  table.cell(fill: rgb("ebf1dd"))[*Tanggal*], [: 27 Juli - 3 Agustus 2026],
)

#table(
    columns: (0.5fr, 1.4fr, 3fr, 2.5fr, 1.6fr, 1fr, 1.4fr),
    stroke: 0.5pt,
    inset: 6pt,
    align: (x, y) => {
      if x in (0, 5) { center + horizon }
      else { left + horizon }
    },

    // Header
    table.header(
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[No.]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Kegiatan]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Tahapan Kegiatan]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Output/Hasil]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Catatan Mentor]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Paraf Mentor]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Catatan Coach]],

      // Nomor kolom
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(1)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(2)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(3)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(4)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(5)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(6)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(7)]],
    ),

    // ========== Kegiatan (1) ==========
    [1.],
    [Mempelajari Pedoman dan Prinsip Kearsipan Surat],
    [
      #enum(
        numbering: "1)",
        [Meminta arahan dari mentor terkait pedoman kearsipan surat.],
        [Mengumpulkan informasi terkait pedoman dan prinsip kearsipan dari berbagai sumber.],
        [Menyusun pedoman kearsipan surat berdasarkan hasil pengumpulan informasi.],
      )
    ],
    [
      #enum(
        numbering: "i",
        [Arahan dan hasil diskusi bersama mentor.],
        [Rangkuman informasi pedoman dan prinsip kearsipan.],
        [Dokumen pedoman kearsipan surat.],
      )
    ],
    [...],
    [...],
    [...],

    // ========== Kegiatan (2) ==========
    [2.],
    [Membuat Draft Awal Digitalisasi Arsip melalui Google Sites],
    [
      #enum(
        numbering: "1)",
        [Menganalisis kebutuhan sistem arsip digital di unit kerja.],
        [Merancang struktur Google Sites untuk pengarsipan dokumen.],
        [Membuat draft awal halaman arsip digital.],
        [Menguji fungsionalitas unggah dan akses dokumen.],
      )
    ],
    [
      #enum(
        numbering: "i",
        [Dokumen analisis kebutuhan sistem arsip digital.],
        [Rancangan struktur Google Sites.],
        [Draft awal halaman arsip digital.],
        [Hasil pengujian fungsionalitas unggah dan akses.],
      )
    ],
    [...],
    [...],
    [...],

    // ========== Kegiatan (3) ==========
    [3.],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],

    // ========== Kegiatan (4) ==========
    [4.],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],

    // ========== Kegiatan (5) ==========
    [5.],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],

    // ========== Kegiatan (6) ==========
    [6.],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],

    // ========== Kegiatan (7) ==========
    [7.],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
  )

#set heading(numbering: none)
== Bukti-Bukti Pelaksanaan Kegiatan Minggu ke-1 dan ke-2

#text(weight: "bold")[A. Dokumentasi Pelaksanaan Kegiatan]

#table(
    columns: (0.4fr, 2fr, 3fr, 3fr),
    stroke: 0.5pt,
    inset: 6pt,
    align: (x, y) => {
      if x == 0 { center + horizon }
      else { left + horizon }
    },

    table.header(
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[No.]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Kegiatan]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Tahapan Kegiatan]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Dokumentasi]],

      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(1)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(2)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(3)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(4)]],
    ),

    // ========== Kegiatan 1 (3 tahapan) ==========
    table.cell(rowspan: 3, align: center + horizon)[1.],
    table.cell(rowspan: 3)[Mempelajari Pedoman dan Prinsip Kearsipan Surat],
    [1) Meminta arahan dari mentor terkait pedoman kearsipan surat.],
    [Foto kegiatan diskusi dengan mentor / tangkapan layar komunikasi.],

    [2) Mengumpulkan informasi terkait pedoman dan prinsip kearsipan dari berbagai sumber.],
    [Foto/tangkapan layar sumber referensi yang digunakan.],

    [3) Menyusun pedoman kearsipan surat berdasarkan hasil pengumpulan informasi.],
    [Foto/tangkapan layar dokumen pedoman yang disusun.],

    // ========== Kegiatan 2 (4 tahapan) ==========
    table.cell(rowspan: 4, align: center + horizon)[2.],
    table.cell(rowspan: 4)[Membuat Draft Awal Digitalisasi Arsip melalui Google Sites],
    [1) Menganalisis kebutuhan sistem arsip digital di unit kerja.],
    [Foto/tangkapan layar dokumen analisis kebutuhan.],

    [2) Merancang struktur Google Sites untuk pengarsipan dokumen.],
    [Foto/tangkapan layar rancangan struktur situs.],

    [3) Membuat draft awal halaman arsip digital.],
    [Foto/tangkapan layar halaman Google Sites.],

    [4) Menguji fungsionalitas unggah dan akses dokumen.],
    [Foto/tangkapan layar hasil pengujian.],

    // ========== Kegiatan 3-7 placeholder ==========
    table.cell(align: center + horizon)[3.], [...], [...], [...],
    table.cell(align: center + horizon)[4.], [...], [...], [...],
    table.cell(align: center + horizon)[5.], [...], [...], [...],
    table.cell(align: center + horizon)[6.], [...], [...], [...],
    table.cell(align: center + horizon)[7.], [...], [...], [...],

    // ============================================================
    // CARA MENGGUNAKAN TABEL DOKUMENTASI:
    // 1. Setiap kegiatan menggunakan rowspan untuk kolom No. dan
    //    Kegiatan. Jumlah rowspan = jumlah tahapan kegiatan.
    // 2. Contoh Kegiatan 1: 3 tahapan → rowspan: 3
    //    Baris pertama: table.cell(rowspan: 3)[1.], table.cell(rowspan: 3)[Nama], [1) ...], [...]
    //    Baris kedua-dst: hanya 2 cell (tahapan + dokumentasi) karena
    //    kolom No. dan Kegiatan sudah di-cover rowspan.
    // 3. Penomoran tahapan: manual (1), 2), 3), ...) karena setiap
    //    baris adalah cell terpisah.
    // 4. Untuk menambah kegiatan baru, copy blok kegiatan terakhir
    //    (dari "// ==== Kegiatan N ====" sampai sebelum komentar ini)
    //    dan paste di atas placeholder, lalu ganti No. dan rowspan.
    // ============================================================
  )

...

#text(weight: "bold")[B. Output/Hasil Kegiatan]

#table(
    columns: (0.4fr, 2fr, 4fr),
    stroke: 0.5pt,
    inset: 6pt,
    align: (x, y) => {
      if x == 0 { center + horizon }
      else { left + horizon }
    },

    table.header(
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[No.]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Kegiatan]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Output]],

      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(1)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(2)]],
      table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(3)]],
    ),

    // ========== Kegiatan 1 ==========
    [1.],
    [Mempelajari Pedoman dan Prinsip Kearsipan Surat],
    [
      #enum(numbering: "i")[
        1 file Pedoman Kearsipan Surat
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 2 ==========
    [2.],
    [Membuat Draft Awal Digitalisasi Arsip melalui Google Sites],
    [
      #enum(numbering: "i")[
        1 file Draft Awal Digitalisasi Arsip (Google Sites)
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 3 ==========
    [3.],
    [Membuat Rancangan Web Dashboard Diseminasi Data Strategis],
    [
      #enum(numbering: "i")[
        1 file Rancangan Sistem
      ][
        1 file Laporan Kegiatan Ketiga
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 4-7 placeholder ==========
    [4.], [...], [...],
    [5.], [...], [...],
    [6.], [...], [...],
    [7.], [...], [...],

    // ============================================================
    // CARA MENGGUNAKAN TABEL OUTPUT:
    // 1. Setiap kegiatan diisi dalam 1 baris (3 kolom).
    // 2. Kolom Output diisi dengan enum(numbering: "i") untuk item
    //    berpenomoran romawi, diikuti keterangan dan link.
    // 3. Untuk menambah kegiatan baru, copy baris kegiatan terakhir
    //    dan paste di atas placeholder.
    // ============================================================
  )

...
#set heading(numbering: "1.")
