// ============================================================
// AUTO — Entry point utama, orchestrator dokumen. Jangan diubah.
// ============================================================

#import "template/lib.typ": *
#import "template/template.typ": template
#import "content/00-cover.typ": halaman-cover
#import "content/01-halaman-judul.typ": halaman-judul
#import "content/02-lembar-pengesahan.typ": lembar-pengesahan
#import "content/03-pernyataan-orisinalitas.typ": pernyataan-orisinalitas
#import "content/04-pernyataan-ai.typ": pernyataan-ai
#import "content/05-abstrak.typ": halaman-abstrak
#import "content/06-kata-pengantar.typ": kata-pengantar
#import "content/16-biodata-penulis.typ": biodata-penulis

// Load metadata dari data.yaml
#let data = yaml("data.yaml")

// Document metadata
#set document(
  title: data.judul.id,
  author: data.mahasiswa.nama,
)

// Wrap semua konten dalam template
#show: template

// ============================================================
// HALAMAN SAMPUL (tanpa nomor halaman)
// ============================================================
#set page(numbering: none)

// 1. Cover luar (biru)
#halaman-cover(data)
#halaman-kosong(lang: "id")

// 2. Halaman judul dalam (putih)
#halaman-judul(data, lang: "id")
#halaman-kosong(lang: "id")
#halaman-judul(data, lang: "en")
#halaman-kosong(lang: "en")

// ============================================================
// FRONT MATTER — penomoran romawi, mulai i dari Lembar Pengesahan
// ============================================================
#set page(numbering: "i")
#counter(page).update(1)

// Lembar Pengesahan
#lembar-pengesahan(data, lang: "id")
#halaman-kosong(lang: "id")
#lembar-pengesahan(data, lang: "en")
#halaman-kosong(lang: "en")

// Pernyataan Orisinalitas
#pernyataan-orisinalitas(data, lang: "id")
#halaman-kosong(lang: "id")
#pernyataan-orisinalitas(data, lang: "en")
#halaman-kosong(lang: "en")

// Pernyataan Kode Etik Penggunaan AI Generatif
#pernyataan-ai(data)
#halaman-kosong(lang: "id")

// Abstrak
#halaman-abstrak(data, lang: "id")
#halaman-kosong(lang: "id")
#halaman-abstrak(data, lang: "en")
#halaman-kosong(lang: "en")

// Kata Pengantar
#kata-pengantar(data)
#halaman-kosong(lang: "id")

// Daftar Isi
#include "content/07-daftar-isi.typ"

// Daftar Gambar
#include "content/08-daftar-gambar.typ"
#halaman-kosong(lang: "id")

// Daftar Tabel
#include "content/09-daftar-tabel.typ"
#halaman-kosong(lang: "id")

// Daftar Kode Semu
#include "content/10-daftar-kode-semu.typ"
#halaman-kosong(lang: "id")

// Daftar Kode Sumber
#include "content/11-daftar-kode-sumber.typ"
#halaman-kosong(lang: "id")

// Daftar Singkatan
#include "content/12-daftar-singkatan.typ"
#halaman-kosong(lang: "id")

// Daftar Simbol
#include "content/13-daftar-simbol.typ"
#halaman-kosong(lang: "id")

// ============================================================
// MAIN MATTER — penomoran arab
// ============================================================

// #pagebreak()
#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

// Bab-bab — edit di content/chapters/01-bab1.typ dst.
#include "content/chapters/01-bab1.typ"
// #halaman-kosong(lang: "id")

#include "content/chapters/02-bab2.typ"
#halaman-kosong(lang: "id")

#include "content/chapters/03-bab3.typ"
// #halaman-kosong(lang: "id")

#include "content/chapters/04-bab4.typ"
// #halaman-kosong(lang: "id")

#include "content/chapters/05-bab5.typ"
#halaman-kosong(lang: "id")

// #include "content/chapters/06-bab6.typ"

// Daftar Pustaka
#include "content/14-daftar-pustaka.typ"
#halaman-kosong(lang: "id")

// Lampiran
#include "content/15-lampiran.typ"
#halaman-kosong(lang: "id")

// Biodata Penulis — bagian terakhir, blank page tanpa trailing break
#biodata-penulis(data)
#halaman-kosong(lang: "id", trailing: false)
