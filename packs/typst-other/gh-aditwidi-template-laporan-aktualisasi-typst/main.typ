#import "template.typ": setupMainBody, rancanganAktualisasiTemplate
#import "src/metadata.typ": *

// Inisialisasi Templat

#show: rancanganAktualisasiTemplate.with(
  coverTitle: coverTitle,
  coverSubTitle: coverSubTitle,
  rancanganTitle: rancanganTitle,
  nama: nama,
  nip: nip,
  jabatan: jabatan,
  satker: satker,
  golongan: golongan,
  angkatan: angkatan,
  tahun: tahun,
  institution: institution,
  submissionDate: submissionDate,
)

// --- BAGIAN PERSIAPAN (FRONTMATTER)

#include "src/lembarPersetujuan.typ"

// Memuat Berita Acara Pengesahan
#include "src/beritaAcaraPengesahan.typ"

// Memuat Abstrak Bahasa Indonesia
#include "src/abstrak.typ"

// Memuat Kata Pengantar
#include "src/kataPengantar.typ"

// Memuat Daftar Isi
#include "src/daftarIsi.typ"
#pagebreak(weak: true)

//Memuat Daftar Tabel
#include "src/daftarTabel.typ"
#pagebreak(weak: true)

// Memuat Daftar Gambar
#include "src/daftarGambar.typ"
#pagebreak(weak: true)

// Memuat Daftar Lampiran (DITAMBAHKAN SETELAH DAFTAR TABEL)
#include "src/daftarLampiran.typ"
#pagebreak(weak: true)

// --- TUBUH UTAMA (MAIN BODY) ---
#show: setupMainBody

#include "BAB 1/bab1.typ"

#include "BAB 2/bab2.typ"

#include "BAB 3/bab3.typ"





#bibliography("references.bib", style: "laporan-aktualisasi.csl", title: "DAFTAR PUSTAKA")
#pagebreak(weak: true)


#include "Lampiran/Lampiran.typ"
