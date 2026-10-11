// =============================================================
// AUTO — Daftar Pustaka
// =============================================================

#import "../template/lib.typ": *

#headz[DAFTAR PUSTAKA]
#v(1cm)
#show bibliography: set block(width: 100%)
#bibliography("../daftar-pustaka.bib", title: none, style: "american-psychological-association")
