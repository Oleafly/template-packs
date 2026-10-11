/**
 * Berkas utama (hub) untuk Lampiran.
 * - "LAMPIRAN" heading ditampilkan rata tengah vertikal di halaman portrait.
 * - setupAppendixBody mengaktifkan halaman landscape dan penomoran lampiran.
 * - Setiap lampiran ditulis di file terpisah (Lampiran 1.typ, Lampiran 2.typ, …)
 *   dan di-include di bawah. Untuk menambah lampiran baru, buat file baru
 *   lalu tambahkan #include di bawah ini.
 */

#import "/template.typ": setupAppendixBody

#align(horizon)[
  #heading(level: 1, numbering: none)[LAMPIRAN]
]

#show: setupAppendixBody

#include "lampiran1.typ"
#include "lampiran2.typ"
#include "lampiran3.typ"
