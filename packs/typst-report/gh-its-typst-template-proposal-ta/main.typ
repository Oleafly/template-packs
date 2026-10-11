// ============================================================
// AUTO — Entry point utama, orchestrator dokumen. Jangan diubah.
// ============================================================

#import "template/lib.typ": *
#import "template/template.typ": template
#import "content/01-halaman-judul.typ": halaman-judul
#import "content/02-lembar-pengesahan.typ": lembar-pengesahan
#import "content/03-abstrak.typ": halaman-abstrak

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

// 1. Halaman judul dalam (putih)
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

// Abstrak
#halaman-abstrak(data, lang: "id")
#halaman-kosong(lang: "id")
#halaman-abstrak(data, lang: "en")
#halaman-kosong(lang: "en")

// Daftar Isi
#include "content/04-daftar-isi.typ"

// Daftar Gambar
#include "content/05-daftar-gambar.typ"
#halaman-kosong(lang: "id")

// Daftar Tabel
#include "content/06-daftar-tabel.typ"
#halaman-kosong(lang: "id")

// Daftar Kode Semu
#include "content/07-daftar-kode-semu.typ"
#halaman-kosong(lang: "id")

// Daftar Kode Sumber
#include "content/08-daftar-kode-sumber.typ"
#halaman-kosong(lang: "id")

// Daftar Singkatan
#include "content/09-daftar-singkatan.typ"
#halaman-kosong(lang: "id")

// Daftar Simbol
#include "content/10-daftar-simbol.typ"
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
#halaman-kosong(lang: "id")

// Daftar Pustaka
#include "content/11-daftar-pustaka.typ"
#halaman-kosong(lang: "id")

// Lampiran
#include "content/12-lampiran.typ"
#halaman-kosong(lang: "id", trailing: false)

