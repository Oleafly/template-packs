// ============================================================
// AUTO — Sisipan halaman kosong antar bagian (cetak bolak-balik)
//
// Dipanggil EKSPLISIT di main.typ setelah setiap bagian yang
// harus diikuti blank page. Implementasinya sederhana:
//   1. pagebreak() — masuk ke halaman kosong
//   2. Teks tengah halaman
//   3. pagebreak() — keluar, siap untuk bagian berikutnya
//
// Asumsi: bagian sebelumnya selalu berakhir di halaman ganjil
// (tiap bagian dirancang 1 halaman). Jika genap, blank page akan
// jatuh di halaman ganjil — cukup hapus pemanggilan ini.
// ============================================================

#let halaman-kosong(lang: "id", trailing: true) = {
  let teks = if lang == "id" {
    "Halaman ini sengaja dikosongkan."
  } else {
    "This page is intentionally left blank."
  }
  pagebreak()
  align(center)[#text(style: "italic")[#teks]]
  if trailing { pagebreak() }
}
