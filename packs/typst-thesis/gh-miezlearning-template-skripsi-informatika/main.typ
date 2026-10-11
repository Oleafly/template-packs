#import "skripsi.typ": *
#import "metadata.typ": *

// =====================================================================
// INISIALISASI TEMPLATE UTAMA
// =====================================================================
#show: skripsi.with(judul: judul, penulis: penulis)

// =====================================================================
// 1. BAGIAN DEPAN — NOMOR HALAMAN ROMAWI TENGAH BAWAH (SPASI 1.0 TUNGGAL)
// =====================================================================
#set par(leading: 0.6em, spacing: 0.6em)

#include "bagian_depan/01_cover.typ"
#include "bagian_depan/02_pernyataan.typ"
#include "bagian_depan/03_pengesahan.typ"
#include "bagian_depan/04_persembahan.typ"
#include "bagian_depan/05_abstrak.typ"
#include "bagian_depan/06_abstract.typ"
#include "bagian_depan/07_kata_pengantar.typ"
#include "bagian_depan/08_daftar.typ"

// =====================================================================
// 2. BAGIAN ISI (BAB I - BAB V) — NOMOR HALAMAN ANGKA ARAB KANAN BAWAH (SPASI 1.5)
// =====================================================================
#counter(page).update(1)
#set page(footer: context align(right)[#counter(page).display("1")])
#set par(leading: 0.75em, spacing: 1.2em)

#include "bab/01_pendahuluan.typ"
#include "bab/02_tinjauan_pustaka.typ"
#include "bab/03_metodologi.typ"
#include "bab/04_hasil_pembahasan.typ"
#include "bab/05_kesimpulan.typ"

// =====================================================================
// 3. BAGIAN AKHIR
// =====================================================================
#include "bagian_akhir/daftar_pustaka.typ"
#include "bagian_akhir/lampiran.typ"
