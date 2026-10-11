// =============================================================================
// DAFTAR RIWAYAT HIDUP (Sesuai Lampiran 25 Pedoman PKL UBSI)
// =============================================================================
#import "../../lib.typ": *
#import "../metadata.typ": *

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[DAFTAR RIWAYAT HIDUP]
]
#v(1.5em)

#set par(leading: 6pt) // 1 Spasi sesuai Catatan Lampiran 25

#text(weight: "bold")[I.     Biodata Mahasiswa]
#v(0.2cm)
#pad(left: 0.8cm)[
  #table(
    columns: (4.5cm, 0.3cm, 1fr),
    stroke: none,
    inset: (y: 3pt),
    [NIM], [:], [#nim],
    [Nama Lengkap], [:], [#penulis],
    [Tempat/ Tanggal Lahir], [:], [Jakarta, 1 Januari 2003],
    [Alamat lengkap], [:], [Jl. Raya Kampus UBSI No. 12, Kelurahan Slipi, Jakarta Barat 11480],
  )
]

#v(0.5cm)
#text(weight: "bold")[II.    Pendidikan]
#v(0.2cm)
#pad(left: 0.8cm)[
  #text(weight: "bold")[a.  Formal]
  #v(0.1cm)
  #pad(left: 0.5cm)[
    1. SD Negeri 01 Jakarta, lulus tahun 2015\
    2. SMP Negeri 01 Jakarta, lulus tahun 2018\
    3. SMA Negeri 01 Jakarta, lulus tahun 2021\
    4. Universitas Bina Sarana Informatika (#program-studi, Sarjana), sedang ditempuh
  ]
  #v(0.3cm)
  #text(weight: "bold")[b.  Tidak Formal]
  #v(0.1cm)
  #pad(left: 0.5cm)[
    1. Kursus Bahasa Inggris (General English) di Lembaga Bahasa LIA, tahun 2022\
    2. Pelatihan Pemrograman Web & Database Administrator di BSI Career Center, tahun 2023\
    3. Sertifikasi Fundamental Jaringan Komputer, tahun 2024
  ]
]

#v(0.5cm)
#text(weight: "bold")[III.   Riwayat Pengalaman berorganisasi / perkerjaan]
#v(0.2cm)
#pad(left: 0.8cm)[
  1. Pengurus Himpunan Mahasiswa Teknologi Informasi UBSI, tahun 2023 s.d 2024\
  2. Panitia Seminar Nasional Teknologi Informasi UBSI, tahun 2024\
  3. Anggota Komunitas Linux & Jaringan Komputer Mahasiswa, tahun 2023 s.d sekarang
]

#v(1cm)
#grid(
  columns: (3.5cm, 1fr),
  gutter: 1cm,
  [
    #rect(width: 3cm, height: 4cm, stroke: 1pt + black)[
      #set align(center + horizon)
      #text(size: 10pt)[Foto\ 3x4]
    ]
  ],
  [
    #align(right)[
      #block(width: 7cm)[
        #set align(left)
        #kota, Desember #tahun\
        \
        #v(1.8cm)
        #underline(penulis)
      ]
    ]
  ]
)

#v(1fr)
#text(size: 9pt, style: "italic")[
  *Catatan: Diketik dengan jarak satu spasi, dan tempelkan pas photo berlatar warna merah serta berdasi mengenakan jaket almamater*
]
