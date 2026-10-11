// =============================================================================
// LEMBAR PENGESAHAN LAPORAN PRAKTIK KERJA LAPANGAN (PKL)
// Program Studi: Teknologi Informasi
// =============================================================================
#import "../../lib.typ": *
#import "../metadata.typ": *

#page(
  header: none,
  footer: context {
    let page-num = counter(page).display("i")
    align(center)[#text(size: 10pt)[#page-num]]
  }
)[
  #align(center)[
    #text(size: 14pt, weight: "bold")[
      LEMBAR PENGESAHAN\
      LAPORAN PRAKTIK KERJA LAPANGAN
    ]
  ]

  #v(1.5cm)
  Laporan Praktik Kerja Lapangan (PKL) ini diajukan oleh:

  #v(0.5cm)
  #table(
    columns: (4cm, 0.5cm, 1fr),
    stroke: none,
    inset: (y: 6pt),
    [Nama Mahasiswa], [:], [#penulis],
    [NIM], [:], [#nim],
    [Jenjang Studi], [:], [Sarjana (S1)],
    [Program Studi], [:], [#program-studi],
    [Fakultas], [:], [#fakultas],
    [Perguruan Tinggi], [:], [#universitas],
    [Judul Laporan PKL], [:], [#judul],
  )

  #v(1cm)
  Laporan Praktik Kerja Lapangan ini telah disetujui dan disahkan oleh:

  #v(1.5cm)
  #align(center)[
    #kota, #datetime.today().display("[day] [month repr:long] [year]")\
    #v(0.3cm)
    *DOSEN PENASEHAT AKADEMIK*\
    #v(2.5cm)
    *( #dosen-pa )*
  ]
]
