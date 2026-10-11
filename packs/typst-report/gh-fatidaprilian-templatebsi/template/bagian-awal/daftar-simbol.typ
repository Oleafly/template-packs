// =============================================================================
// DAFTAR SIMBOL
// =============================================================================

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[DAFTAR SIMBOL]
]
#v(1.5em)

Daftar ini memuat simbol-simbol ilmiah, notasi diagram, atau singkatan teknis yang digunakan dalam laporan ini:

#v(0.5cm)
#table(
  columns: (3cm, 1fr),
  stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { none },
  inset: 8pt,
  [*Simbol / Notasi*], [*Keterangan*],
  [$alpha$], [Konstanta laju pembelajaran (_learning rate_)],
  [$sum$], [Notasi penjumlahan (_summation_)],
  [UML], [Unified Modeling Language],
  [SDLC], [Software Development Life Cycle],
  [API], [Application Programming Interface],
  [DBMS], [Database Management System],
  [HTTP / HTTPS], [Hypertext Transfer Protocol / Secure],
)
