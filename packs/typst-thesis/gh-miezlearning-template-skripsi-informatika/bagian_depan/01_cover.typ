#import "../skripsi.typ": *
#import "../metadata.typ": *

// 1. Cover Luar (Hardcover)
#halaman-cover-luar(
  judul: judul,
  penulis: penulis,
  nim: nim,
  fakultas: fakultas,
  universitas: universitas,
  kota: kota,
  tahun: tahun,
  logo: logo-color,
  logo-width: logo-size,
  no-urut: no-urut,
)

// 2. Sampul Dalam (Halaman Judul)
#halaman-cover-dalam(
  judul: judul,
  penulis: penulis,
  nim: nim,
  program-studi: program-studi,
  fakultas: fakultas,
  universitas: universitas,
  kota: kota,
  tahun: tahun,
  logo: logo-bw,
  logo-width: logo-size-dalam,
)
