#import "../skripsi.typ": *
#import "../metadata.typ": *

= Tinjauan Pustaka

== Penelitian Terkait

#catatan[
  Bagian ini menjelaskan beberapa penelitian terkait yang berhubungan dengan proses Penelitian. Menggunakan pustaka yang baru, relevan, dan asli dari jurnal ilmiah atau buku. Uraikan dengan jelas kajian pustaka yang menimbulkan gagasan dan mendasari penelitian. Tinjauan pustaka mengacu pada Daftar Pustaka.
]

Kajian mengenai penelitian-penelitian terkait yang telah dilakukan sebelumnya diperlukan dalam rangka mendukung penelitian ini. Daftar penelitian terkait antara lain:

+ *Metode yang digunakan:* Backpropagation Neural Network. *Temuan Penelitian:* Data yang digunakan pada penelitian ini adalah data produksi kelapa sawit dari tahun 2015 hingga 2017 yang berjumlah 319 data. Dalam penelitian ini dilakukan 5 pengujian untuk mendapatkan nilai terbaik #cite(<amir2002>, form: "prose").
+ Penelitian terkait 2.
+ Penelitian terkait 3.
+ Penelitian terkait 4.
+ Penelitian terkait 5.
+ Dst...

*Perbedaan dengan Penelitian Sebelumnya*

Berdasarkan referensi yang terkait, maka didapatkan perbedaan penelitian yang terdahulu sebagai dasar penelitian ini.

== Teori Pendukung

Penjelasan teori pendukung pertama menguraikan konsep dasar yang digunakan #cite(<andono2017>).

== Teori Pendukung

Penjelasan teori pendukung kedua.

=== Teori Pendukung Sub BAB

Penjelasan sub bab tingkat pertama.

=== Teori Pendukung Sub BAB

Penjelasan sub bab tingkat kedua.

== Teori Pendukung

#catatan[
  Identitas gambar diletakkan di bawah gambar. Sedangkan identitas tabel diletakkan di atas tabel. Rata tengah, cetak tebal.
]

#figure(
  rect(width: 8.5cm, height: 4.5cm, stroke: 0.8pt)[
    #align(center + horizon)[*Gambar Skematik / Ilustrasi*]
  ],
  caption: [Geometri Patch Antena Mikrostrip Dengan Teknik Pencatuan Electro-Magnetically Coupled],
) <fig:antena>

Penulisan tabel menggunakan format 1 garis sederhana (*simple stroke*) sebagai berikut:

#figure(
  table(
    columns: (auto, 1.5fr, 1.2fr, 0.5fr, 1.5fr),
    align: (center, left, center, center, left),
    [*No.*], [*Nama Mahasiswa*], [*NIM*], [*L/P*], [*Program Studi*],
    [1], [Mahasiswa A], [1815025063], [L], [S1 Informatika],
    [2], [Mahasiswa B], [1815025121], [L], [S1 Informatika],
    [3], [Mahasiswa C], [1715015068], [L], [S1 Informatika],
    [4], [Mahasiswa D], [1715025029], [P], [S1 Informatika],
    [5], [Mahasiswa E], [1815025123], [L], [S1 Informatika],
  ),
  caption: [Tabel Data Mahasiswa Informatika],
) <tab:mahasiswa>
