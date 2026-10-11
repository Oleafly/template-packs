// =============================================================
// PROYEK AKHIR / PROPOSAL PROYEK AKHIR - Template PENS
//
// File ini SENGAJA dibuat singkat. Mesin template (cover, heading,
// penomoran gambar/tabel/persamaan, dst) ada di `template.typ` --
// tidak perlu dibuka kalau tidak perlu mengubah desain.
//
// Yang perlu kamu lakukan di sini cuma 2:
//   1. Isi data dirimu di blok `cfg` di bawah.
//   2. Tulis isi buku di file-file dalam folder chapters/, lalu
//      daftarkan urutannya lewat #include di bagian paling bawah.
//
// Baca README.md untuk panduan lengkap kalau baru pertama kali
// pakai Typst.
// =============================================================
#import "template.typ": *

// -------------------------------------------------------------
// A. METADATA  -- yang WAJIB kamu edit. Setiap nilai di sini
//    otomatis muncul di cover & halaman judul. Jangan cari-cari
//    teks "Nama Mahasiswa" dkk di tempat lain untuk diedit manual.
// -------------------------------------------------------------
#let cfg = (
  // thesis_type TIDAK ditulis di sini -- otomatis diturunkan dari
  // `jenis_ujian` di bawah (lihat blok JENIS UJIAN).
  title: "JUDUL PROYEK AKHIR",
  // TODO: Perlu dilengkapi penulis -- nama lengkap & gelar mahasiswa pengusul.
  author: "NAMA MAHASISWA",
  // TODO: Perlu dilengkapi penulis -- NRP mahasiswa.
  student_id: "NRP_MAHASISWA",
  
  // TODO: Perlu dilengkapi nama lengkap & gelar promotor 1.
  promoter_1: "NAMA PEMBIMBING 1",
  promoter_1_nip: "NIP_PEMBIMBIMBING 1",
  
  // TODO: Perlu dilengkapi nama lengkap & gelar promotor 1.
  promoter_2: "NAMA PEMBIMBING 2",
  promoter_2_nip: "NIP_PEMBIMBING 2",

  // TODO: Perlu dilengkapi nama lengkap & gelar penguji 1.
  examiner_1: "NAMA PENGUJI 1",
  examiner_1_nip: "NIP_PENGUJI 1",

  // TODO: Perlu dilengkapi nama lengkap & gelar penguji 2.
  examiner_2: "NAMA PENGUJI 2",
  examiner_2_nip: "NIP_PENGUJI 2",

  // TODO: Perlu dilengkapi nama lengkap & gelar Ketua Program Studi (Kaprodi).
  head_of_program: "NAMA KAPRODI",
  head_of_program_nip: "NIP_KAPRODI",

  study_program: "Program Studi Sarjana  Terapan",
  department: "Teknik Elektronika",
  institution: "Politeknik Elektronika Negeri Surabaya",
  year: "2026",
  logo_path: "assets/logo.png",
)

// Gaya sitasi & daftar pustaka otomatis (lihat #bibliography di template.typ)
#let citation_style = "ieee"

// Tampilkan/sembunyikan kotak keterangan font & ukuran pada halaman 2
// (panduan penggunaan template). true = tampil, false = sembunyi.
#let show_page2_annotations = false

// Tampilkan/sembunyikan teks panduan cara menulis Daftar Pustaka
// (muncul di bawah judul DAFTAR PUSTAKA). Saat mulai menulis,
// set ke false (atau hapus baris ini) supaya halaman bersih.
// true = tampil, false = sembunyi.
#let show_daftar_pustaka_guide = true

// -------------------------------------------------------------
// B. STATUS DOKUMEN  -- watermark diagonal otomatis di semua halaman.
//    "draft"     -> watermark "DRAFT"
//    "final"     -> tanpa watermark
// -------------------------------------------------------------
#let document_status = "final"

// -------------------------------------------------------------
// JENIS UJIAN  -- SATU-SATUNYA yang perlu kamu ganti untuk
// berpindah antara proposal / progres / final. Otomatis menentukan:
//   * label judul di halaman judul (prefix PROPOSAL/PROGRES di atas
//     "PROYEK AKHIR" -- jadi thesis_type TIDAK perlu ditulis manual),
//   * tampil/sembunyinya Halaman Pengesahan.
//    "proposal" -> judul "PROPOSAL PROYEK AKHIR", Pengesahan disembunyikan
//    "progress" -> judul "PROGRES PROYEK AKHIR",  Pengesahan disembunyikan
//    "final"    -> judul "PROYEK AKHIR",          Pengesahan ditampilkan
// -------------------------------------------------------------
#let jenis_ujian = "proposal"

// -------------------------------------------------------------
// JENJANG  -- menentukan gelar pada Halaman Pengesahan.
//    "D3"      -> Gelar Ahli Madya Teknik (A.Md.T.)
//    "Sarjana" -> Gelar Sarjana Terapan Teknik (S.T.r.T.)
// -------------------------------------------------------------
#let jenjang = "Sarjana"

// -------------------------------------------------------------
// Pasang semua konfigurasi di atas ke mesin template. Baris ini
// juga otomatis menambahkan cover, Abstrak, Daftar Isi/Gambar/
// Tabel di depan, dan Daftar Pustaka di akhir -- jangan dihapus.
// -------------------------------------------------------------
#show: doc => conf(
  // Nama dokumen selalu "PROYEK AKHIR"; prefix PROPOSAL/PROGRES ditambahkan
  // otomatis dari jenis_ujian. Tidak perlu ditulis di cfg.
  cfg: cfg + (thesis_type: "PROYEK AKHIR"),
  citation_style: citation_style,
  show_page2_annotations: show_page2_annotations,
  show_daftar_pustaka_guide: show_daftar_pustaka_guide,
  document_status: document_status,
  jenis_ujian: jenis_ujian,
  jenjang: jenjang,
  doc,
)

// =============================================================
// C. ISI BUKU  -- daftar bab sesuai urutan. Tambah/hapus/susun
//    ulang baris #include di bawah ini untuk mengatur urutan bab.
//    Nomor BAB dan semua nomor gambar/tabel/persamaan otomatis
//    menyesuaikan, tidak perlu diketik manual.
// =============================================================
#include "chapters/bab1-pendahuluan.typ"
#include "chapters/bab2-kajian-pustaka.typ"
#include "chapters/bab3-desain-sistem.typ"
// BAB 4 & BAB 5 (dan Lampiran) hanya ditampilkan pada tahap progres/final.
// Saat jenis_ujian = "proposal", ketiganya otomatis disembunyikan.
#if jenis_ujian != "proposal" {
  include "chapters/bab4-eksperimen-analisis.typ"
  include "chapters/bab5-penutup.typ"
}
