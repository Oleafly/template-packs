// lib/ttd.typ
// Komponen tanda tangan (Signature Blocks) Proposal Kegiatan WRI Polinema

#let render-box-materai(nominal: "10000") = {
  rect(
    width: 55pt,
    height: 44pt,
    stroke: 0.75pt,
    align(center + horizon)[
      #text(size: 8.5pt, weight: "bold")[Materai\ #nominal]
    ]
  )
}

#let render-ttd-pair(
  ttd-kiri: (
    jabatan: "",
    nama: "",
    id: "",
  ),
  ttd-kanan: (
    jabatan: "",
    nama: "",
    id: "",
  ),
  space: 72pt,
  gutter: 15pt,
) = {
  grid(
    columns: (1fr, 1fr),
    gutter: gutter,
    align: left,
    [
      #ttd-kiri.jabatan,\
      #v(space)
      #ttd-kiri.nama\
      #ttd-kiri.id
    ],
    [
      #ttd-kanan.jabatan,\
      #v(space)
      #ttd-kanan.nama\
      #ttd-kanan.id
    ]
  )
}

#let render-ttd-pernyataan(
  tanggal: "",
  pembina: (
    nama: "",
    nip: "",
    jabatan: "Dosen Pembina Kemahasiswaan",
  ),
  ketua-pelaksana: (
    nama: "",
    nim: "",
  ),
  space: 72pt,
  gutter: 20pt,
) = {
  grid(
    columns: (1fr, 1fr),
    column-gutter: gutter,
    row-gutter: 0pt,
    align: left,

    // Row 1: Header Jabatan & Tanggal
    [
      #hide[Malang, #tanggal]\
      Menyetujui,\
      #pembina.jabatan,
    ],
    [
      Malang, #tanggal\
      #hide[Menyetujui,]\
      Ketua Pelaksana,
    ],

    // Row 2: Ruang TTD basah (kiri) & Materai 10000 (kanan)
    [
      #v(space)
    ],
    [
      #v((space - 44pt) / 2)
      #render-box-materai()
      #v((space - 44pt) / 2)
    ],

    // Row 3: Nama & NIP/NIM
    [
      #pembina.nama\
      NIP. #pembina.nip
    ],
    [
      #ketua-pelaksana.nama\
      NIM. #ketua-pelaksana.nim
    ],
  )
}
