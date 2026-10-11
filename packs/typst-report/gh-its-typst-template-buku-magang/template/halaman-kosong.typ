// ============================================================
// AUTO — Pemisah antarbagian (cetak bolak-balik).
//
// Aturan: setiap bagian baru (bab, daftar pustaka, dll) selalu
// mulai di halaman GENAP.
//   - Kalau bagian berikutnya jatuh di halaman ganjil, halaman
//     ganjil itu otomatis diisi tulisan
//     "Halaman ini sengaja dikosongkan." lalu bagian baru mulai
//     di halaman genap berikutnya.
//   - Kalau memang sudah jatuh di halaman genap, tidak ada
//     halaman tambahan sama sekali.
// ============================================================

#let halaman-kosong(lang: "id") = {
  let teks = if lang == "id" {
    "Halaman ini sengaja dikosongkan."
  } else {
    "This page is intentionally left blank."
  }

  // Tutup halaman bagian sebelumnya
  pagebreak(weak: true)

  // Tulisan hanya muncul di halaman lompatan yang dibuat di bawah ini
  set page(background: place(
    top + center,
    dy: 2.5cm,
    text(style: "italic")[#teks],
  ))

  // Lompat ke halaman genap; kalau sudah genap, tidak terjadi apa-apa
  pagebreak(to: "even", weak: true)
}
