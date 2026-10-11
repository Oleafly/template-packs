/**
 * Lampiran 3 — LAPORAN MINGGUAN PELAKSANAAN AKTUALISASI MINGGU KE-4
 */

#import "/src/metadata.typ": namaDenganGelar, nip, satker

#pagebreak()
= LAPORAN MINGGUAN PELAKSANAAN AKTUALISASI MINGGU KE-4 <lamp-3>

#table(
  columns: (auto, 1fr),
  stroke: 0.5pt,
  inset: 6pt,
  align: left + horizon,
  table.cell(fill: rgb("ebf1dd"))[*Nama Peserta*], [: #namaDenganGelar],
  table.cell(fill: rgb("ebf1dd"))[*NIP*], [: #nip],
  table.cell(fill: rgb("ebf1dd"))[*Unit Kerja*], [: #satker],
  table.cell(fill: rgb("ebf1dd"))[*Rumusan Isu*], [: ...],
  table.cell(fill: rgb("ebf1dd"))[*Tanggal*], [: 17 - 24 Agustus 2026],
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
        [Melakukan finalisasi pedoman kearsipan surat.],
      )
    ],
    [
      #enum(
        numbering: "i",
        [Dokumen final pedoman kearsipan surat.],
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
        [Finalisasi halaman arsip digital dan dokumentasi.],
      )
    ],
    [
      #enum(
        numbering: "i",
        [Halaman arsip digital final.],
      )
    ],
    [...],
    [...],
    [...],

    // ========== Kegiatan (3) ==========
    [3.],
    [Membuat Rancangan Web Dashboard Diseminasi Data Strategis],
    [
      #enum(
        numbering: "1)",
        [Finalisasi prototipe dashboard.],
        [Menyusun dokumentasi dashboard.],
      )
    ],
    [
      #enum(
        numbering: "i",
        [Prototipe dashboard final.],
        [Dokumen dokumentasi dashboard.],
      )
    ],
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

    // ============================================================
    // CARA MENAMBAH/MENGUBAH KEGIATAN:
    // 1. Setiap kegiatan menempati 1 baris (7 kolom).
    // 2. Kolom Tahapan Kegiatan menggunakan enum(numbering: "1)").
    // 3. Kolom Output/Hasil menggunakan enum(numbering: "i").
    // 4. Untuk menambah kegiatan baru, copy blok kegiatan terakhir
    //    dan paste di atas placeholder.
    // ============================================================
  )

#set heading(numbering: none)
== Bukti-Bukti Pelaksanaan Kegiatan Minggu ke-4

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

    // ========== Kegiatan 1 (1 tahapan) ==========
    table.cell(rowspan: 1, align: center + horizon)[1.],
    table.cell(rowspan: 1)[Mempelajari Pedoman dan Prinsip Kearsipan Surat],
    [1) Finalisasi pedoman kearsipan surat.],
    [Foto/tangkapan layar dokumen final pedoman kearsipan.],

    // ========== Kegiatan 2 (1 tahapan) ==========
    table.cell(rowspan: 1, align: center + horizon)[2.],
    table.cell(rowspan: 1)[Membuat Draft Awal Digitalisasi Arsip melalui Google Sites],
    [1) Finalisasi halaman arsip digital dan dokumentasi.],
    [Foto/tangkapan layar halaman Google Sites final.],

    // ========== Kegiatan 3 (2 tahapan) ==========
    table.cell(rowspan: 2, align: center + horizon)[3.],
    table.cell(rowspan: 2)[Membuat Rancangan Web Dashboard Diseminasi Data Strategis],
    [1) Finalisasi prototipe dashboard.],
    [Foto/tangkapan layar prototipe dashboard final.],

    [2) Menyusun dokumentasi dashboard.],
    [Foto/tangkapan layar dokumen dokumentasi.],

    // ========== Kegiatan 4-7 placeholder ==========
    table.cell(align: center + horizon)[4.], [...], [...], [...],
    table.cell(align: center + horizon)[5.], [...], [...], [...],
    table.cell(align: center + horizon)[6.], [...], [...], [...],
    table.cell(align: center + horizon)[7.], [...], [...], [...],

    // ============================================================
    // CARA MENGGUNAKAN TABEL DOKUMENTASI:
    // 1. Setiap kegiatan menggunakan rowspan untuk kolom No. dan
    //    Kegiatan. Jumlah rowspan = jumlah tahapan kegiatan.
    // 2. Penomoran tahapan: manual (1), 2), 3), ...) karena setiap
    //    baris adalah cell terpisah.
    // 3. Untuk menambah kegiatan baru, copy blok kegiatan terakhir
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
        1 file Pedoman Kearsipan Surat (Final)
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 2 ==========
    [2.],
    [Membuat Draft Awal Digitalisasi Arsip melalui Google Sites],
    [
      #enum(numbering: "i")[
        1 file Halaman Arsip Digital (Final)
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 3 ==========
    [3.],
    [Membuat Rancangan Web Dashboard Diseminasi Data Strategis],
    [
      #enum(numbering: "i")[
        1 file Prototipe Dashboard (Final)
      ][
        1 file Dokumentasi Dashboard
      ]
      Output dapat diakses melalui tautan berikut:\
      #link("https://drive.google.com/drive/folders/11FoJjRF7EHJv7bFjVEXofShQe8zo1CEx?usp=sharing")
    ],

    // ========== Kegiatan 4-7 placeholder ==========
    [4.], [...], [...],
    [5.], [...], [...],
    [6.], [...], [...],

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
