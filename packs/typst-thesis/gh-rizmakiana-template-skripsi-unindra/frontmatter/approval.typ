#import "../config/input.typ": *

#show <center>: set align(center)

= LEMBAR PERSETUJUAN UJIAN SKRIPSI
\
\
#grid(
  columns: (100pt, 10pt, 1fr),
  row-gutter: 1em,
  // Jarak antar baris
  [Nama], [:], [#name],
  [NPM], [:], [#npm],
  [Fakultas], [:], [#faculty.slice(9)],
  [Program Studi], [:], [#study-program.slice(14)],
  [Judul Skripsi], [:], [#thesis-title],
)
\
\
\
\
Telah diperiksa dan disetujui untuk diujikan <center>
\
\
\
\
\
#columns(2, gutter: 8pt)[
  Pembimbing Materi <center>
  \
  \
  \
  \
  \
   #thesis-advisor1 <center>
   #thesis-advisor1-id <center>

  #colbreak()

  Pembimbing Teknik <center>
  \
  \
  \
  \
  \
  #thesis-advisor2 <center>
  #thesis-advisor2-id <center>

]

#pagebreak()
