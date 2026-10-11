#import "../config/input.typ": *

#show <center>: set align(center)

= LEMBAR PENGESAHAN
\
\
#grid(
  columns: (100pt, 10pt, auto),
  row-gutter: 1em,
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
\
Panitia Ujian <center>
\
\
#grid(
  columns: (100pt, 10pt, 1fr),
  row-gutter: 1em,
  [Ketua], [:], [#rector-university #box(width: 1fr, repeat[.])],
  [], [], [],
  [Sekretaris], [:], [#secretary-of-university #box(width: 1fr, repeat[.])],
  [], [], [],
  [Anggota], [:], [],
)
#table(
  columns: (auto, 20em, 1fr),
  table.header(
    table.cell(align: center)[*No.*],
    table.cell(align: center)[*Nama*],
    table.cell(align: center)[*Tanda Tangan*],
  ),
  [1.], [#examiner1 \ \ ],[],
  [2.], [#examiner2 \ \ ],[],
  [3.], [#examiner3 \ \ ],[],

)

#pagebreak()
