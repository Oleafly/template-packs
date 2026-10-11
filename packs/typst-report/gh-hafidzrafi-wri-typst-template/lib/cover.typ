// lib/cover.typ
// Layout Halaman Cover Proposal Resmi WRI Polinema dengan Shading Banner Khas

#let render-cover(
  nama-kegiatan: [PROPOSAL KEGIATAN\ WORKSHOP DAN RISET INFORMATIKA – #emph[EARLY ACCESS]],
  tema-kegiatan: [“WORKSHOP DAN RISET INFORMATIKA – #emph[EARLY ACCESS]”],
  ketua-pelaksana: (nama: "", nim: ""),
  organisasi: "WORKSHOP DAN RISET INFORMATIKA",
  institusi: "POLITEKNIK NEGERI MALANG",
  tahun: "2026",
  logo-path: "../assets/logo-polinema.png"
) = {
  set text(weight: "bold", size: 12pt)
  set par(leading: 0.70em, justify: false)

  // Top Banner (#BFBFBF)
  rect(
    width: 100%,
    fill: rgb("BFBFBF"),
    stroke: none,
    inset: (y: 6pt),
    align(center)[
      #nama-kegiatan
    ]
  )

  v(50pt)
  align(center)[
    #tema-kegiatan
  ]

  v(50pt)
  align(center)[
    #image(logo-path, width: 4.8cm)
  ]

  v(40pt)
  align(center)[
    Oleh :\
    #v(3pt)
    #ketua-pelaksana.nama\
    #v(3pt)
    NIM. #ketua-pelaksana.nim
  ]

  v(1fr)
  // Bottom Banner (#BFBFBF)
  rect(
    width: 100%,
    fill: rgb("BFBFBF"),
    stroke: none,
    inset: (y: 6pt),
    align(center)[
      #upper(organisasi)\
      #upper(institusi)\
      #tahun
    ]
  )
}
