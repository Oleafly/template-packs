// ============================================================
// AUTO — Daftar pustaka, terisi otomatis dari daftar-pustaka.bib
// Cara pakai: tulis #cite(<kunci>) atau @kunci di dalam bab.
// ============================================================

#import "../template/lib.typ": headz

#headz[DAFTAR PUSTAKA]
#v(0.8cm)
#bibliography(
  "../daftar-pustaka.bib",
  title: none,
  style: "institute-of-electrical-and-electronics-engineers",
  full: true,
)
