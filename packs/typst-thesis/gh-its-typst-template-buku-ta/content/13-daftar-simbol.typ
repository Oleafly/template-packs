// ============================================================
// OPSIONAL EDIT — Daftar simbol, tambah/hapus baris sesuai kebutuhan
// ============================================================

#import "../template/lib.typ": headz

#headz[DAFTAR SIMBOL]
#v(1cm)
#set text(size: 12pt)
#table(
  columns: (3cm, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 0.6em),
  [*Simbol*], [*Keterangan*],
  [$n$],   [Jumlah data],
  [$d$],   [Dimensi vektor],
  // Tambahkan simbol lain di sini...
)
