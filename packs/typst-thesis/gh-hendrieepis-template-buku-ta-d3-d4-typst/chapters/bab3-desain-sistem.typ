// Jangan hapus baris import ini -- ini yang membuat #bp[...], #sumber[...],
// dan helper lain dari template.typ bisa dipakai di file ini.
#import "../template.typ": *

= Desain Sistem

#bp[Uraian pada bab ini meliputi model yang digunakan, rancangan proyek akhir, variabel dalam proyek akhir, teknik pengumpulan data dan analisis data. Awali pembahasan pada bab ini dengan penjelasan umum tentang solusi yang ditawarkan untuk menjawab Problem.]

== Deskripsi Solusi

#bp[Deskripsikan solusi yang ditawarkan pada buku proyek akhir dengan jelas dan detil. Tuliskan secara argumentatif apa saja fitur-fitur yang ditawarkan pada kegiatan sebagai sesuatu solusi pada kegiatan laporan akhir. Pada contoh judul "Deteksi Kanker dengan Sistem Pakar Berbasis Fuzzy", solusinya adalah Sistem Pakar Berbasis Fuzzy, sehingga penulis disini dapat menjelaskan tentang pemodelan sistem pakar dan fitur-fitur fuzzy yang seperti apa untuk deteksi penyakit kanker. Terangkan secara argumentatif tentang fitur-fitur pemodelan Sistem Pakar dengan Fuzzy sehingga dapat digunakan untuk mendeteksi penyakit kanker.]

== Perancangan Sistem

#bp[Desain sistem adalah penjelasan teknikal dari solusi yang berisi urutan-urutan proses yang akan dilakukan untuk menyelesaikan masalah. Akan lebih mudah dicerna, apabila penjelasan ini disertai dengan diagram sistem secara high-level view sehingga pembaca mendapatkan gambaran menyeluruh tentang desain sistem untuk menyelesaikan Problem. Setelah itu, penulis dapat menguraikan desain sistem yang digunakan dalam buku proyek akhir secara rinci. @fig-desain-sistem adalah contoh diagram desain sistem secara high-level view dan contoh sistematika pembahasan dari diagram desain.]

#figure(
  image("../assets/diagram_bagian.png", width: 8.96cm),
  caption: [Desain sistem dari solusi yang ditawarkan],
) <fig-desain-sistem>

#bp[Gambar diletakkan rata tengah, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah gambar. Setiap gambar harus mempunyai nomer identitas gambar dan diiringi dengan keterangan gambar, yang dituliskan rata tengah dan tebal. Nomer identitas dan keterangan gambar dituliskan pada 1 (satu) baris dibawah gambar. Nomer identitas terdiri dari nomer bab dan nomer urutan gambar pada bab tersebut. Setiap gambar harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. @fig-desain-sistem menunjukkan bagan desain sistem yang mempunyai tiga bagian. Jika isi gambar adalah kutipan, maka penulis dapat menyebutkan sumber referensi dari gambar dibawah gambar dan diatas identitas gambar, dengan rata tengah dan ditulis dengan ukuran 10 point, seperti yang terlihat pada @fig-contoh-kutipan.]

#figure(
  {
    image("../assets/diagram_cisco.jpeg", width: 7.85cm)
    sumber[http://cdn3.techworld.com/cmsdata/features/3210134/cisco-search-patent.jpg]
  },
  caption: [Contoh gambar kutipan],
) <fig-contoh-kutipan>

== Bagian 1

#bp[Disini penulis dapat menjelaskan lebih terperinci apa saja yang ada pada bagian ini. Jika bagian ini mempunyai sub bagian yang perlu diperjelas dalam pembahasan, penulis dapat menuliskannya dalam sub pembahasan pada bagian ini.]

=== Aaaa

#bp[Disini penulis dapat membahas sub bagian Aaaa lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan. Apabila pembahasan penulis memerlukan penulisan persamaan matematis, penulis dapat menuliskannya seperti pada @eq-rekursif.]

#pad(left: 1cm)[
  $ f_i^t = f_i^(t-1) + alpha dot.op (f_i^(t-1) - f_(i-1)^(t-1)) $ <eq-rekursif>
]

#bp[Penulisan persamaan diletakkan pada baris sendiri rata kiri yang masuk 10 mm dari batas kiri, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah gambar. Setiap persamaan harus mempunyai nomer identitas persamaan yang dituliskan rata kanan dan tebal. Setiap persamaan harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. @eq-rekursif menunjukkan keterhubungan antara fungsi pada waktu sekarang dan sebelumnya.]

#bp[Untuk cara penulisan tabel, tabel diletakkan rata tengah, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah tabel. Setiap tabel harus mempunyai nomer identitas tabel dan diiringi dengan keterangan tabel, yang dituliskan rata tengah dan tebal. Nomer identitas dan keterangan tabel dituliskan pada 1 (satu) baris dibawah tabel. Nomer identitas terdiri dari nomer bab dan nomer urutan tabel pada bab tersebut. Setiap tabel harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. @tab-contoh menunjukkan contoh penulisan tabel, yang terdiri dari nomer identitas dan keterangan tabel, dan kemudian isi tabel.]

#figure(
  {
    table(
      columns: (4.98cm, 2.23cm, 2.75cm),
      stroke: 0.5pt + black,
      align: center + horizon,
      table.header(
        table.cell(fill: rgb("#D9D9D9"))[*Kolom 1*],
        table.cell(fill: rgb("#D9D9D9"))[*Kolom 2*],
        table.cell(fill: rgb("#D9D9D9"))[*Kolom 3*],
      ),
      [], [], [],
      [], [], [],
      [], [], [],
      [], [], [],
      [], [], [],
    )
    sumber[Badan Pusat Pengolahan Data, 2012 [7]]
  },
  caption: [Contoh penulisan tabel],
) <tab-contoh>

#bp[Judul pada tabel dapat dituliskan rata tengah, tebal dan berlatar-belakang agak gelap. Jika isi tabel adalah kutipan, maka penulis dapat menyebutkan sumber referensi dari tabel dibawah tabel dengan rata tengah dan ditulis dengan ukuran 10 point, seperti yang terlihat pada @tab-contoh. Satu tabel tidak boleh melebihi dari 1 (satu) halaman. Jika isi tabel terlalu banyak lebih dari 1 (satu) halaman, penulis dapat memecah tabel dan memberikan identitas tabel yang berbeda.]

=== Bbbb

#bp[Disini penulis dapat membahas sub bagian Bbbb lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.]

== Bagian 2

#bp[Disini penulis dapat menjelaskan lebih terperinci apa saja yang ada pada Bagian 2 ini. Jika bagian ini mempunyai sub bagian yang perlu diperjelas dalam pembahasan, penulis dapat menuliskannya dalam sub pembahasan pada bagian ini.]

=== Cccc

#bp[Disini penulis dapat membahas sub bagian Cccc lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.]

=== Dddd

#bp[Disini penulis dapat membahas sub bagian Dddd lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.]

== Bagian 3

#bp[Disini penulis dapat menjelaskan lebih terperinci apa saja yang ada pada Bagian 3 ini. Jika bagian ini mempunyai sub bagian yang perlu diperjelas dalam pembahasan, penulis dapat menuliskannya dalam sub pembahasan pada bagian ini.]

=== Eeee

#bp[Disini penulis dapat membahas sub bagian Eeee lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.]

=== Ffff

#bp[Disini penulis dapat membahas sub bagian Ffff lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.]
