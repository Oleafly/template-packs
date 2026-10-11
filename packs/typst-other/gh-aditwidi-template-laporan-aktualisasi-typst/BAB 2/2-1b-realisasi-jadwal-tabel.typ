/**
 * Sub-bab 2.1 — Realisasi Jadwal Kegiatan Aktualisasi (tabel + penjelasan)
 * Landscape diaktifkan oleh hub (bab2.typ) sebelum file ini di-include.
 */

#figure(
  kind: table,
  caption: [REALISASI KEGIATAN AKTUALISASI],
  table(
    columns: (0.5fr, 2.5fr, 1.5fr, 3fr, 1.7fr, 3fr, 2fr),
    stroke: 0.5pt,
    inset: 6pt,
    align: (x, y) => {
      if x in (0, 1, 3, 5, 6) { left + horizon }
      else { center + horizon }
    },
    // Header berulang di setiap halaman saat tabel terpotong
    table.header(
    // Baris 1: Super-header — Rancangan dan Aktualisasi membawahi masing-masing 2 kolom
    // No., Kegiatan, dan Keterangan di-merge (rowspan:2) mencakup baris 1 dan 2
    table.cell(rowspan: 2, align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[No.]],
    table.cell(rowspan: 2, align: left + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Kegiatan]],
    table.cell(colspan: 2, align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Rancangan]],
    table.cell(colspan: 2, align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Aktualisasi]],
    table.cell(rowspan: 2, align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Keterangan]],

    // Baris 2: Sub-header — hanya Jadwal, Target, Pelaksanaan, Realisasi
    // (No., Kegiatan, Keterangan sudah terisi oleh rowspan baris 1)
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Jadwal]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Target]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Pelaksanaan]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[Realisasi]],

    // Baris 3: Nomor kolom (1) s.d. (7)
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(1)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(2)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(3)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(4)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(5)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(6)]],
    table.cell(align: center + horizon, fill: rgb("ebf1dd"))[#text(weight: "bold")[(7)]],
    ),
    // Akhir header berulang

    // Baris 4–10: Data kegiatan aktualisasi
    [], [Contoh Pengisian:], [], [], [], [], [],
    [1.], [Mempelajari Pedoman dan Prinsip Kearsipan Surat], [Minggu ke-1 (23-27 Februari 2026)], [#enum(numbering: "i", [Tersusunnya pedoman kearsipan surat], [Teridentifikasinya jenis-jenis surat])], [Minggu ke-1 (23-27 Februari 2026)], [#enum(numbering: "i", [Pedoman kearsipan surat telah disusun], [Jenis-jenis surat telah teridentifikasi])], [Kegiatan, tahapan, output dan pelaksanaan Sesuai Rancangan],
    [2.], [Membuat Draft Awal Digitalisasi Arsip melalui Google Sites], [Minggu ke-2 (28-31 Februari 2026)], [#enum(numbering: "i", [Tersusunnya pedoman kearsipan surat], [Teridentifikasinya jenis-jenis surat])], [Minggu ke-2 (28-31 Februari 2026)], [#enum(numbering: "i", [Pedoman kearsipan surat telah disusun], [Jenis-jenis surat telah teridentifikasi])], [Kegiatan, tahapan, output dan pelaksanaan Sesuai Rancangan],
    [3.], [Membuat rancangan web dashboard diseminasi data strategis], [Minggu ke-3 (32-35 Februari 2026)], [#enum(numbering: "i", [Rancangan web dashboard diseminasi data strategis], [Tersusunnya pedoman kearsipan surat])], [Minggu ke-3 (32-35 Februari 2026)], [#enum(numbering: "i", [Rancangan web dashboard diseminasi data strategis], [Tersusunnya pedoman kearsipan surat])], [Kegiatan, tahapan, output dan pelaksanaan Sesuai Rancangan],
    [], [], [], [], [], [], [],
    [], [], [], [], [], [], [],
    [], [], [], [], [], [], [],
  )
)

#h(-2em)
#text(weight: "bold")[Penjelasan Tabel:]

#{
  show enum: it => pad(left: 0em, it)
  set par(hanging-indent: 0em, first-line-indent: 1.5em)

  enum(
    numbering: "1.",
    [*Kegiatan 1 – Mempelajari Pedoman dan Prinsip Kearsipan Surat:*

     Kegiatan ini bertujuan untuk memahami pedoman kearsipan surat yang berlaku di BPS. Tahapan yang dilakukan meliputi pengumpulan referensi pedoman kearsipan, identifikasi jenis-jenis surat masuk dan keluar, serta penyusunan pedoman kearsipan surat yang sesuai dengan kebutuhan unit kerja.],

    [*Kegiatan 2 – Membuat Draft Awal Digitalisasi Arsip melalui Google Sites:*

     Kegiatan ini bertujuan untuk mengembangkan sistem digitalisasi arsip berbasis Google Sites. Tahapan yang dilakukan meliputi analisis kebutuhan sistem, perancangan struktur situs, pembuatan draft awal halaman arsip digital, serta pengujian fungsionalitas unggah dan akses dokumen.],

    [*Kegiatan 3 – Membuat Rancangan Web Dashboard Diseminasi Data Strategis:*

     Kegiatan ini bertujuan untuk merancang dashboard web yang menyajikan data strategis secara visual dan interaktif. Tahapan yang dilakukan meliputi identifikasi indikator data strategis, perancangan tata letak dashboard, pemilihan tools visualisasi data, serta pembuatan prototipe awal dashboard.],
  )
}
