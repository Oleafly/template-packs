// ============================================================
// WAJIB EDIT — BAB IV ANALISIS DAN PERANCANGAN SISTEM
// ============================================================

#import "../../template/lib.typ": *

= ANALISIS DAN PERANCANGAN SISTEM

== Analisis Sistem

Pada bab ini dijelaskan tahapan analisis dan perancangan sistem yang dikerjakan selama
magang.

=== Definisi Umum Aplikasi

[Jelaskan secara umum sistem atau aplikasi yang dikerjakan: apa itu, untuk siapa, dan
apa fungsi utamanya.]

== Perancangan Sistem

=== Desain Sistem

[Jelaskan rancangan arsitektur/desain sistem yang akan diimplementasikan. Contoh:
arsitektur _client-server_, _microservice_, arsitektur jaringan, dan sebagainya.]

// Contoh penyisipan gambar. Ganti berkasnya dengan gambar milik penulis
// (simpan di assets/figures/), lalu ganti juga captionnya.
#gambar("../assets/brand/logo-its-docx.png", caption: [Logo ITS], width: 45%)

[Jelaskan gambar arsitektur/desain sistem di atas.]

Spesifikasi komponen sistem dapat dilihat pada tabel berikut.

#figure(
  caption: [Judul Tabel Perangkat Keras],
  table(
    columns: (1.2cm, 1fr, 1fr, 1fr),
    align: (center, left, left, left),
    [*No*], [*Komponen*], [*Fungsi*], [*Spesifikasi Server*],
    [1.], [Nama Komponen], [Deskripsi Fungsi], [Spesifikasi],
    [2.], [Nama Komponen], [Deskripsi Fungsi], [Spesifikasi],
  ),
)

#figure(
  caption: [Judul Tabel Perangkat Lunak],
  table(
    columns: (1.2cm, 1fr, 1fr, 1fr),
    align: (center, left, left, left),
    [*No*], [*Komponen*], [*Fungsi*], [*Spesifikasi Software*],
    [1.], [Nama Komponen], [Deskripsi Fungsi], [Spesifikasi Software],
    [2.], [Nama Komponen], [Deskripsi Fungsi], [Spesifikasi Software],
  ),
)
