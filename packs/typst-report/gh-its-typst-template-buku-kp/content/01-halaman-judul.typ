// ============================================================
// AUTO — Halaman judul dalam (putih). Isi sama dengan sampul luar.
// ============================================================

#import "../template/lib.typ": *
#import "00-cover.typ": isi-sampul

#let _logo() = image("../assets/brand/logo-its-docx.png", height: 2.2cm)

#let halaman-judul(data) = {
  align(left, _logo())
  v(1.1cm)
  isi-sampul(data, warna-teks: black)
}
