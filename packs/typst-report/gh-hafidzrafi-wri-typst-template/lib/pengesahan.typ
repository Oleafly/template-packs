// lib/pengesahan.typ
// Layout Lembar Pengesahan Proposal Kegiatan WRI Polinema

#import "terbilang.typ": terbilang-rupiah, format-rupiah
#import "ttd.typ": render-ttd-pair

#let render-lembar-pengesahan(
  nama-kegiatan: "",
  sub-judul: "",
  ketua-pelaksana: (
    nama: "",
    nim: "",
    prodi: "D-IV Teknik Informatika",
    jurusan: "Teknologi Informasi"
  ),
  waktu-pelaksanaan: "",
  tempat-pelaksanaan: "",
  total-biaya: 0,
  sumber-dana-list: (), // e.g. ("Swadana",) atau ("Dana DIPA", "Kas WRI")
  panitia-count: 21,
  peserta-count: 60,
  peserta-keterangan: "Mahasiswa Baru Jurusan Teknologi Informasi Politeknik Negeri Malang",
  tanggal-pengesahan: "10 September 2026",
  ketum-wri: (
    nama: "Savero Athallah Hardiana Putra",
    nim: "244107020116",
    jabatan: "Ketua Umum WRI"
  ),
  pembina: (
    nama: "Anugrah Nur Rahmanto, S.Sn, M.Ds.",
    nip: "199112302019031016",
    jabatan: "Dosen Pembina Kemahasiswaan"
  ),
  presiden-bem: (
    nama: "Raihan Zaky Ramadhan",
    nim: "244107020070",
    jabatan: "Presiden BEM"
  ),
  wadir-3: (
    nama: "Ir. Pipit Wahyu Nugroho, M.T.",
    nip: "197005202002121002",
    jabatan: "Wakil Direktur III"
  ),
  kajur: (
    nama: "Mungki Astiningrum, S.T., M.Kom.",
    nip: "197710302005012001",
    jabatan: "Ketua Jurusan Teknologi Informasi"
  )
) = {
  // Section 2 margins (Top 2.0cm, Bottom 1.5cm, Left 4.0cm, Right 2.5cm)
  set page(margin: (top: 2.0cm, bottom: 1.5cm, left: 4.0cm, right: 2.5cm))
  set par(leading: 0.75em, spacing: 0pt, justify: false, first-line-indent: 0pt)

  // Banner Abu-Abu (#BFBFBF)
  rect(
    width: 100%,
    fill: rgb("BFBFBF"),
    stroke: none,
    inset: (y: 6pt),
    align(center)[
      #text(weight: "bold")[LEMBAR PENGESAHAN PROPOSAL KEGIATAN\ #sub-judul]
    ]
  )
  v(10pt)

  // Rincian butir 1 s.d. 7 (Colons aligned at 156pt / pos 3119)
  grid(
    columns: (14pt, 134pt, 8pt, 1fr),
    row-gutter: 10pt,
    [1.], [Kegiatan], [:], [#nama-kegiatan],
    [2.], [Ketua Pelaksana], [], [],
    [], [a. Nama], [:], [#ketua-pelaksana.nama],
    [], [b. NIM], [:], [#ketua-pelaksana.nim],
    [], [c. Jurusan/Program Studi], [:], [#ketua-pelaksana.jurusan/#ketua-pelaksana.prodi],
    [3.], [Waktu Pelaksanaan], [:], [#waktu-pelaksanaan],
    [4.], [Tempat Pelaksanaan], [:], [#tempat-pelaksanaan],
    [5.], [Biaya], [:], [
      #format-rupiah(total-biaya)\
      #emph[(#terbilang-rupiah(total-biaya))]
    ],
    [6.], [Sumber Dana], [:], [
      #if sumber-dana-list.len() <= 1 {
        if sumber-dana-list.len() == 1 {
          sumber-dana-list.at(0)
        } else {
          [-]
        }
      } else {
        for (i, s) in sumber-dana-list.enumerate() {
          if i > 0 { [\ ] }
          [\- #s]
        }
      }
    ],
    [7.], [Panitia #emph[Offline]], [:], [#str(panitia-count) Orang],
    [], [Peserta #emph[Offline]], [:], [#str(peserta-count) Orang (#peserta-keterangan)]
  )

  v(20pt)

  // Tanggal Malang (aligned with right column)
  grid(
    columns: (1fr, 1fr),
    gutter: 15pt,
    [],
    [Malang, #tanggal-pengesahan]
  )
  v(12pt)

  // Tier 1: Ketum WRI & Kapel
  render-ttd-pair(
    ttd-kiri: (jabatan: ketum-wri.jabatan, nama: ketum-wri.nama, id: "NIM. " + ketum-wri.nim),
    ttd-kanan: (jabatan: "Ketua Pelaksana", nama: ketua-pelaksana.nama, id: "NIM. " + ketua-pelaksana.nim),
    space: 72pt,
    gutter: 15pt,
  )

  v(24pt)
  align(center)[Mengetahui dan menyetujui,]
  v(18pt)

  // Tier 2: Pembina & Presiden BEM
  render-ttd-pair(
    ttd-kiri: (jabatan: pembina.jabatan, nama: pembina.nama, id: "NIP. " + pembina.nip),
    ttd-kanan: (jabatan: presiden-bem.jabatan, nama: presiden-bem.nama, id: "NIM. " + presiden-bem.nim),
    space: 72pt,
    gutter: 15pt,
  )

  v(26pt)

  // Tier 3: Wadir III & Kajur
  render-ttd-pair(
    ttd-kiri: (jabatan: wadir-3.jabatan, nama: wadir-3.nama, id: "NIP. " + wadir-3.nip),
    ttd-kanan: (jabatan: kajur.jabatan, nama: kajur.nama, id: "NIP. " + kajur.nip),
    space: 72pt,
    gutter: 15pt,
  )
}
