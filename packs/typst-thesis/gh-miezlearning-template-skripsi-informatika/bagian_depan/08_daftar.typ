#import "../skripsi.typ": *

// --------------------------- DAFTAR ISI ---------------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Isi]
#align(right)[#text(style: "italic", size: 10pt)[halaman]]

#table(
  columns: (1fr, auto),
  stroke: none,
  align: (left, right),
  row-gutter: 6pt,
  [*HALAMAN JUDUL*], [*ii*],
  [*PERNYATAAN KEASLIAN SKRIPSI*], [*iii*],
  [*HALAMAN PENGESAHAN*], [*iv*],
  [*HALAMAN PERSEMBAHAN*], [*v*],
  [*ABSTRAK*], [*vi*],
  [_ABSTRACT_], [*vii*],
  [*KATA PENGANTAR*], [*viii*],
  [*DAFTAR ISI*], [*ix*],
  [*DAFTAR TABEL*], [*xi*],
  [*DAFTAR GAMBAR*], [*xii*],
  [*DAFTAR LAMPIRAN*], [*xiii*],
  [*DAFTAR ISTILAH/LAMBANG*], [*xiv*],
  [*DAFTAR SINGKATAN*], [*xv*],
)
#v(10pt)
#outline(title: none, target: heading.where(outlined: true), indent: 1.5em)

#pagebreak()

// -------------------------- DAFTAR TABEL --------------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Tabel]
#align(right)[#text(style: "italic", size: 10pt)[halaman]]
#outline(title: none, target: figure.where(kind: table), indent: 1.5em)

#pagebreak()

// ------------------------- DAFTAR GAMBAR --------------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Gambar]
#align(right)[#text(style: "italic", size: 10pt)[halaman]]
#outline(title: none, target: figure.where(kind: image), indent: 1.5em)

#pagebreak()

// ------------------------ DAFTAR LAMPIRAN -------------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Lampiran]
#align(right)[#text(style: "italic", size: 10pt)[halaman]]
#table(
  columns: (auto, 1fr, auto),
  stroke: none,
  row-gutter: 8pt,
  [Lampiran 1], [Data Mentah Hasil Penelitian], [13],
)

#pagebreak()

// -------------------- DAFTAR ISTILAH / LAMBANG --------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Istilah/Lambang]
#table(
  columns: (1fr, 2fr),
  stroke: 0.6pt,
  table.header([*Istilah / Lambang*], [*Makna / Arti*]),
  [$"MAPE"$], [Mean Absolute Percentage Error],
  [$eta$], [Learning Rate],
)

#pagebreak()

// ------------------------ DAFTAR SINGKATAN ------------------------
#heading(level: 1, numbering: none, outlined: false)[Daftar Singkatan]
#table(
  columns: (1fr, 2fr),
  stroke: 0.6pt,
  table.header([*Singkatan*], [*Keterangan*]),
  [BPNN], [Backpropagation Neural Network],
  [FFB], [Fresh Fruits Bunch],
)
