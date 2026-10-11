#import "metadata.typ": *

#set page(numbering: none, footer: none)

#block(height: 100%)[
  #set par(leading: 0.4em, justify: false)
  #align(center)[
    #text(size: 12pt, weight: "bold")[BERITA ACARA PENGESAHAN]\
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
    Telah disahkan pada \
    Pada hari #hariSignDate tanggal #signDate  \

    // Grid 2x2 untuk 4 penandatangan
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 11em,

      // Baris label
      [Penguji,], [Coach,],

      // Baris tanda tangan
      [
        #underline[#namaPenguji] \
        NIP. #nipPenguji
      ],
      [
        #underline[#namaCoach] \
        NIP. #nipCoach
      ],

      // Baris label
      [Mentor,], [Peserta,],

      // Baris tanda tangan
      [
        #underline[#namaMentor] \
        NIP. #nipMentor
      ],
      [
        #underline[#namaDenganGelar] \
        NIP. #nip
      ],
    )
  ]
]
