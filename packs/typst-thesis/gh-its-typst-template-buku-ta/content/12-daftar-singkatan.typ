// ============================================================
// OPSIONAL EDIT — Daftar singkatan, tambah/hapus baris sesuai kebutuhan
// ============================================================

#import "../template/lib.typ": headz

#headz[DAFTAR SINGKATAN]
#v(1cm)
#set text(size: 12pt)
#table(
  columns: (3cm, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 0.6em),
  [*Singkatan*], [*Kepanjangan*],
  [FHE],   [Fully Homomorphic Encryption],
  [ITS],   [Institut Teknologi Sepuluh Nopember],
  // Tambahkan singkatan lain di sini...
)
