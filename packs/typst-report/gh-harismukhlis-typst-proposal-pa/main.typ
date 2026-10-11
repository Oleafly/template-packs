#import "template.typ": image-format, proposal, table-format
#import "components/placeholder.typ": content-placeholder

#show: proposal.with(
  title: "judul proyek akhir",
  name: "nama mahasiswa",
  nrp: "0123456789",
  advisor1: "nama pembimbing 1",
  nip1: "0123456789",
  advisor2: "nama pembimbing 2",
  nip2: "0123456789",
  prodi: "prodi",
  departemen: "departemen",
)

= PENDAHULUAN

== LATAR BELAKANG

Deskripsikan latar belakang dari permasalahan yang akan diangkat pada penelitian proyek akhir. Latar belakang berisi penjelasan dari _Problem Domain_ yang termuat pada judul penelitian. Misalkan penulis mengambil suatu judul berikut "Deteksi Penyakit Kanker Dengan Sistem Pakar Berbasis Fuzzy". Judul tersebut mempunyai Problem adalah Deteksi Penyakit Kanker, Problem Domain adalah Penyakit Kanker, dan Uniqueness adalah Sistem Pakar Berbasis Fuzzy.

Berkaitan dengan Latar Belakang, Problem Domain-nya adalah tentang penyakit kanker, sehingga disini penulis dapat menceritakan tentang penyakit kanker dan tingkat urgensi (seperti tingkat kenaikan jumlah penderitanya dari tahun ke tahun, gawatnya penyakit kanker tersebut, dan semisalnya). Latar belakang yang baik berisikan problem domain yang mempunyai tingkat urgensi tinggi.

== PERMASALAHAN

Deskripsikan dengan jelas permasalahan yang ingin diteliti pada proyek akhir. Permasalahan berisi penjelasan dari _Problem_ yang termuat pada judul penelitian. Deskripsi masalah sebaiknya dituliskan dengan gaya bahasa deskriptif. Pada contoh judul diatas, Problem-nya adalah tentang deteksi penyakit kanker, sehingga penulis disini dapat menceritakan tentang sulitnya pendeteksian penyakit kanker dengan mendeskripsikan faktor- faktor yang membuat sulit dalam pendeteksiannya. Uraian permasalahan yang baik manakala penulis berhasil menyakinkan kepada pembaca tentang seberapa tingkat urgensi dari permasalahan tersebut sehingga membuat pembaca yakin bahwa permasalahan tersebut membutuhkan solusi dari penelitian pada proyek akhir penulis.

== TUJUAN

Deskripsikan dengan jelas tujuan penelitian proyek akhir yang diangkat. Tujuan proyek akhir harus jelas, singkat, dan mengandung klaim orisinalitas. Tuliskan secara argumentatif apa saja fitur-fitur yang ditawarkan pada penelitian sebagai sesuatu solusi yang baru untuk mengklaim orisinalitas pada penelitian proyek akhir. Untuk memberikan gambaran yang jelas apa yang dilakukan dan solusi unik apa yang akan ditawarkan pada penelitian, tujuan sebaiknya diawali dengan kalimat pembuka seperti ini: “_Penelitian proyek akhir ini mengajukan suatu pendekatan / algoritma / pemodelan / teknik / metode yang baru untuk mengatasi ........................_ (hubungan dengan Problem) _dengan memakai / menggunakan / mempresentasikan / melibatkan_ (sebutkan solusi memakai apa)”. Kalimat-kalimat selanjutnya kemudian memperjelas solusi dengan fitur-fitur unik seperti apa yang ditawarkan pada penelitian sebagai suatu solusi untuk menjawab permasalahan.

Pada contoh judul diatas, orisinalitasnya adalah Sistem Pakar Berbasis Fuzzy, sehingga penulis disini dapat menjelaskan tentang pemodelan sistem pakar dan fitur-fitur fuzzy yang seperti apa untuk deteksi penyakit kanker. Kalimat pertama pada tujuan dapat diawali dengan contoh berikut, “_Penelitian proyek akhir ini mengajukan suatu pendekatan baru untuk pendeteksian penyakit kanker dengan mempresentasikan model klasifikasi menggunakan Sistem Pakar yang berbasis Fuzzy_”. Kemudian pada kalimat- kalimat berikutnya terangkan secara argumentatif tentang fitur-fitur unik pemodelan Sistem Pakar dengan Fuzzy sehingga dapat digunakan untuk mendeteksi penyakit kanker.

== MANFAAT

Uraikan kontribusi proyek akhir pada pengembangan ilmu pengetahuan teknologi dan seni, pemecahan masalah pembangunan, atau pengembangan kelembagaan. Kontribusi menggambarkan manfaat dari penelitian terhadap pihak tertentu saat penelitian sudah selesai. Kontribusi sebaiknya bersifat spesifik, tidak terlalu luas dan tidak terkesan mengada- ada. Jelaskan siapa yang mendapatkan manfaat dari penelitian penulis dan dalam bentuk apa manfaatnya.

== SISTEMATIKA PENULISAN

Jelaskan tentang sistematika pembahasan dalam buku proyek akhir yang
meliputi :

#{
  set par(first-line-indent: 0pt)
  align(center)[#table(
    columns: (23.9%, 76.1%),
    inset: (left: .08in, right: .08in, top: 0in, bottom: 0in),
    stroke: none,
    align: top + left,
    [#strong[Bab 1]],
    [#strong[Pendahuluan]

      Jelaskan tentang apa saja yang dibahas pada Bab 1. Penjelasan
      memuat bagian-bagian penting pada Pendahuluan

      \
    ],

    [#strong[Bab 2]],
    [#strong[Kajian Pustaka]

      Jelaskan tentang apa saja yang dibahas pada Bab 2. Penjelasan memuat
      bagian-bagian penting pada Kajian Pustaka.

      \
    ],

    [#strong[Bab 3]],
    [#strong[Desain Sistem]

      Jelaskan tentang apa saja yang dibahas pada Bab 3. Penjelasan memuat
      bagian-bagian penting pada Desain Sistem.

      \
    ],

    [#strong[Bab 4]],
    [#strong[Eksperimen dan Analisis]

      Jelaskan tentang apa saja yang dibahas pada Bab 4. Penjelasan memuat
      bagian-bagian penting pada Eksperimen dan Analisis.

      \
    ],

    [#strong[Bab 5]],
    [#strong[Penutup]

      Jelaskan tentang apa saja yang dibahas pada Bab 5. Penjelasan memuat
      bagian-bagian penting pada Penutup.

      \
    ],
  )]
}

= KAJIAN PUSTAKA

\
Awali pembahasan pada bab ini dengan mengutarakan Problem pada Problem Domain dari proyek akhir. Setelah itu, penjelasan tersebut diiringi dengan teori-teori penunjang pada bidang pengetahuan yang terkait dengan Problem Domain dan Problem. Untuk lebih menguatkan klaim orisinalitas proyek akhir penulis, perlu diberikan ulasan tentang penelitian-penelitian terkait yang juga bertujuan untuk mencoba menyelesaikan Problem tersebut.

== DESKRIPSI PERMASALAHAN

Deskripsikan dengan jelas dan detil dari permasalahan yang ingin diselesaikan pada proyek akhir. Permasalahan berisi penjelasan dari _Problem_ yang termuat pada judul kegiatan. Deskripsi masalah sebaiknya dituliskan dengan gaya bahasa deskriptif. Deskripsi masalah boleh memuat gambar, tabel dan skema tertentu untuk mengilustrasikan permasalahan.

== TEORI PENUNJANG

Uraikan dengan jelas dasar teori yang menunjang penelitian proyek akhir yang akan dilakukan. Teori penunjang menguraikan dasar-dasar teori, temuan, dan bahan dari pustaka ilmiah lain, yang dijadikan landasan untuk melakukan proyek akhir yang diusulkan. Uraian dalam Teori Penunjang menjadi landasan untuk menyusun kerangka atau konsep yang akan digunakan dalam proyek akhir. Pada pembahasan teori penunjang, jangan lupa untuk menyebutkan semua kutipan dengan rujukan yang jelas seperti ini @jurnal_example.

== PENELITIAN TERKAIT

Penelitian terkait memuat hasil penelitian pihak lain yang mempunyai Problem yang sama dengan penelitian kita, tetapi dengan menggunakan Uniqueness yang berbeda. Disini ceritakan bagaimana penelitian-penelitian terkait telah mencoba untuk menyelesaikan permasalahan yang sama dengan kita, dengan cara mereka masing-masing yang ditunjukkan dengan kutipan terhadap pustaka. Penelitian terkait yang baik melibatkan kajian pustaka yang relevan dan terpercaya dari jurnal ilmiah internasional ataupun nasional, presentasi ilmiah internasional ataupun nasional, dan buku atau catatan rujukan ilmiah. Penulis harus mencantumkan sumber referensi pada daftar pustaka manakala penulis melakukan rujukan dan kutipan dari pihak lain secara jujur dan benar seperti ini @seminar_example. Pencantuman sumber referensi perlu dilakukan baik terhadap kutipan langsung ataupun kutipan tidak langsung (parafrase).

Untuk kutipan langsung dan pendek (1-2 baris), cara penulisan rujukan untuk kutipan dilakukan dengan memberikan tanda petik ganda di awal dan akhir kutipan dan ditulis miring dan kemudian diiringi dengan sumber referensi pada daftar pustaka, seperti ini "_Ini contoh penulisan rujukan untuk kutipan langsung dan pendek_" @seminar_example@buku_example. Sedangkan untuk kutipan langsung dan panjang (lebih dari 2 baris), Penulis dapat menuliskannya seperti dibawah ini.

#quote()["Ini contoh penulisan rujukan untuk kutipan langsung dan panjang, ditulis pada paragraf terpisah dengan dengan memberikan tanda petik ganda di awal dan akhir kutipan, ukuran font 10 point dan margin kanan kiri yang masuk 10 mm dari batas penulisan, kemudian diiringi dengan sumber referensi pada daftar pustaka." @skripsi_example. Untuk kutipan tidak langsung (parafrase), penulis dapat menuliskan sumber referensi setelah kalimat parafrase selesai, seperti ini @mediapublik_example. ]

= DESAIN SISTEM

\

Uraian pada bab ini meliputi model yang digunakan, rancangan proyek akhir, variabel dalam proyek akhir, teknik pengumpulan data dan analisis data. Awali pembahasan pada bab ini dengan penjelasan umum tentang solusi yang ditawarkan untuk menjawab Problem.

== DESKRIPSI SOLUSI

Deskripsikan solusi yang ditawarkan pada buku proyek akhir dengan jelas dan detil. Tuliskan secara argumentatif apa saja fitur-fitur yang ditawarkan pada kegiatan sebagai sesuatu solusi pada kegiatan laporan akhir. Pada contoh judul “Deteksi Kanker dengan Sistem Pakar Berbasis Fuzzy”, solusinya adalah Sistem Pakar Berbasis Fuzzy, sehingga penulis disini dapat menjelaskan tentang pemodelan sistem pakar dan fitur-fitur fuzzy yang seperti apa untuk deteksi penyakit kanker. Terangkan secara argumentatif tentang fitur-fitur pemodelan Sistem Pakar dengan Fuzzy sehingga dapat digunakan untuk mendeteksi penyakit kanker.

== PERANCANGAN SISTEM

Desain sistem adalah penjelasan teknikal dari solusi yang berisi urutan-urutan proses yang akan dilakukan untuk menyelesaikan masalah. Akan lebih mudah dicerna, apabila penjelasan ini disertai dengan diagram sistem secara high-level view sehingga pembaca mendapatkan gambaran menyeluruh tentang desain sistem untuk menyelesaikan Problem. Setelah itu, penulis dapat menguraikan desain sistem yang digunakan dalam buku proyek akhir secara rinci. Gambar 3.1 adalah contoh diagram desain sistem secara high-level view dan contoh sistematika pembahasan dari diagram desain.

Gambar diletakkan rata tengah, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah gambar. Setiap gambar harus mempunyai nomer identitas gambar dan diiringi dengan keterangan gambar, yang dituliskan rata tengah dan tebal. Nomer identitas dan keterangan gambar dituliskan pada 1 (satu) baris dibawah gambar. Nomer identitas terdiri dari nomer bab dan nomer urutan gambar pada bab tersebut. Setiap gambar harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. Gambar 3.1 menunjukkan bagan desain sistem yang mempunyai tiga bagian. Jika isi gambar adalah kutipan, maka penulis dapat menyebutkan sumber referensi dari gambar dibawah gambar dan diatas identitas gambar, dengan rata tengah dan ditulis dengan ukuran 10 point, seperti yang terlihat pada Gambar 3.2.

#image-format("media/diagram1.jpg", "Desain system dari Solusi yang ditawarkan", img-width: 2.78in)
\
#image-format(
  "media/diagram2.png",
  "Contoh gambar kutipan",
  source: [#link("http://cdn3.techworld.com/cmsdata/features/3210134/cisco-search-patent.jpg")],
  img-width: 2.71in,
)

=== Bagian 1

Disini penulis dapat menjelaskan lebih terperinci apa saja yang ada pada bagian ini. Jika bagian ini mempunyai sub bagian yang perlu diperjelas dalam pembahasan, penulis dapat menuliskannya dalam sub pembahasan pada bagian ini.

==== Aaaa

#content-placeholder() Apabila pembahasan penulis memerlukan penulisan persamaan matematis, penulis dapat menuliskannya seperti pada Persamaan 3.1.

$ f_i^t = f_i^(t-1) + alpha . (f_i^(t-1) - f_(i-1)^(t-1)) $

Penulisan persamaan diletakkan pada baris sendiri rata kiri yang masuk 10 mm dari batas kiri, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah gambar. Setiap persamaan harus mempunyai nomer identitas persamaan yang dituliskan rata kanan dan tebal. Setiap persamaan harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. Persamaan 3.1 menunjukkan keterhubungan antara fungsi pada waktu sekarang dan sebelumnya.

Untuk cara penulisan tabel, tabel diletakkan rata tengah, dengan menyisakan 1 (satu) baris kosong diatas dan dibawah tabel. Setiap tabel harus mempunyai nomer identitas tabel dan diiringi dengan keterangan tabel, yang dituliskan rata tengah dan tebal. Nomer identitas dan keterangan tabel dituliskan pada 1 (satu) baris dibawah tabel. Nomer identitas terdiri dari nomer bab dan nomer urutan tabel pada bab tersebut. Setiap tabel harus dirujuk dan dibahas pada pembahasan dalam paragraf, seperti kalimat berikut. Tabel 3.1 menunjukkan contoh penulisan tabel, yang terdiri dari nomer identitas dan keterangan tabel, dan kemudian isi tabel.

#table-format(
  "Daftar Mahasiswa Berprestasi",
  columns: (2in, 1.37in, 1.32in),
  source: [Badan Pusat Pengolahan Data, 2012 @online_example],
  [Kolom 1],
  [Kolom 2],
  [Kolom 3],
  [#v(.13in)],
  [ ],
  [ ],
  [#v(.13in)],
  [ ],
  [ ],
  [#v(.13in)],
  [ ],
  [ ],
)

Judul pada tabel dapat dituliskan rata tengah, tebal dan berlatar- belakang agak gelap. Jika isi tabel adalah kutipan, maka penulis dapat menyebutkan sumber referensi dari tabel dibawah tabel dengan rata tengah dan ditulis dengan ukuran 10 point, seperti yang terlihat pada Tabel 3.1. Satu tabel tidak boleh melebihi dari 1 (satu) halaman. Jika isi tabel terlalu banyak lebih dari 1 (satu) halaman, penulis dapat memecah tabel dan memberikan identitas tabel yang berbeda.

==== Bbbb

#content-placeholder()

=== Bagian 2

#content-placeholder()

==== Cccc

#content-placeholder()

==== Dddd

#content-placeholder()

=== Bagian 3

#content-placeholder()

==== Eeee

#content-placeholder()

==== Ffff

#content-placeholder()

#set heading(numbering: none)
#bibliography("citation/refs.bib", title: "DAFTAR PUSTAKA", style: "citation/pens.csl")

