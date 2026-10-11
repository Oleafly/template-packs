/*
  File: lembarPersetujuan.typ
  Description: Membangkitkan halaman lembar persetujuan Laporan Hasil Aktualisasi.
               Modul ini menyusun tata letak simetris untuk judul, identitas peserta,
               serta menyediakan ruang tanda tangan yang sejajar untuk Mentor dan Coach.
*/

#import "metadata.typ": *

#set page(numbering: none, footer: none)

#block(height: 100%)[
  #set par(leading: 0.4em, justify: false)
  #align(center)[
    #text(size: 12pt, weight: "bold")[LEMBAR PERSETUJUAN]\
    // Judul Rancangan
    #text(size: 12pt, weight: "bold")[
      #coverTitle \ #coverSubTitle \ PELATIHAN DASAR CALON PNS GOLONGAN #golongan
    ]
  ]

  #v(1fr)

  #set text(size: 11pt, weight: "regular")
  #align(center)[#table(
    columns: (auto, auto),
    stroke: none,
    align: (left, left),
    [Nama], [: #nama],
    [NIP], [: #nip],
    [Unit Kerja], [: #satker],
  )]

  #v(1fr)

  #align(center)[
    Telah disetujui \
    Pada hari #hariSignDate tanggal #signDate  \

    // Menggunakan grid untuk tata letak tanda tangan yang rapi dan sejajar
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 11em,
      // Jarak vertikal yang dialokasikan untuk membubuhkan tanda tangan

      // Baris penunjuk status pembimbing
      [Mentor,], [Coach,],

      // Baris nama pembimbing, NIP, beserta garis tanda tangan
      // Ganti dengan nama dan NIP pembimbing Anda yang sebenarnya.
      [
        #underline[#namaMentor] \
        NIP. #nipMentor
      ],
      [
        #underline[#namaCoach] \
        NIP. #nipCoach
      ],
    )
  ]
]
