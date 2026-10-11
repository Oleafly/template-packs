// ============================================================
// AUTO — Entry point utama, perakit dokumen. Jangan diubah.
// Mau ubah isi? Edit data.yaml dan berkas di folder content/.
// ============================================================

#import "template/lib.typ": *
#import "template/template.typ": template
#import "content/00-cover.typ": halaman-cover
#import "content/01-halaman-judul.typ": halaman-judul
#import "content/06-lembar-pengesahan.typ": lembar-pengesahan
#import "content/07-abstrak.typ": halaman-abstrak
#import "content/08-kata-pengantar.typ": kata-pengantar
#import "content/10-biodata-penulis.typ": biodata-penulis

// Metadata dibaca dari data.yaml
#let data = yaml("data.yaml")

#set document(title: data.judul, author: data.mahasiswa.nama)

#show: template

// ============================================================
// SAMPUL — ikut hitungan romawi, tapi nomornya tidak dicetak
// (sampul = i, halaman judul = ii, dst — sama seperti berkas resmi)
// ============================================================
#set page(numbering: "i")

#halaman-cover(data)
#halaman-kosong()

#halaman-judul(data)
#halaman-kosong()

// ============================================================
// BAGIAN AWAL — lanjut nomor romawi (iii, iv, v, ...)
// ============================================================
#include "content/02-daftar-isi.typ"
#halaman-kosong()

#include "content/03-daftar-gambar.typ"
#halaman-kosong()

#include "content/04-daftar-tabel.typ"
#halaman-kosong()

#include "content/05-daftar-kode-sumber.typ"
#halaman-kosong()

#lembar-pengesahan(data)
#halaman-kosong()

#halaman-abstrak(data)
#halaman-kosong()

#kata-pengantar(data)
#halaman-kosong()

// ============================================================
// BAGIAN ISI — nomor halaman angka biasa (1, 2, 3, ...)
// ============================================================
#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

#include "content/chapters/01-bab1.typ"
#halaman-kosong()

#include "content/chapters/02-bab2.typ"
#halaman-kosong()

#include "content/chapters/03-bab3.typ"
#halaman-kosong()

#include "content/chapters/04-bab4.typ"
#halaman-kosong()

#include "content/chapters/05-bab5.typ"
#halaman-kosong()

#include "content/chapters/06-bab6.typ"
#halaman-kosong()

#include "content/chapters/07-bab7.typ"
#halaman-kosong()

// ============================================================
// BAGIAN AKHIR
// ============================================================
#include "content/09-daftar-pustaka.typ"
#halaman-kosong()

#biodata-penulis(data)
