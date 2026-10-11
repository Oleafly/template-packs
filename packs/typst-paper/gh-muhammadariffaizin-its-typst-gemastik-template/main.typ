#import "gemastik.typ": gemastik

#show: gemastik.with(
  title: [Judul Makalah Karya/Inovasi dalam Bahasa Indonesia Maksimum 12 Kata],
  abstract: [
    Dokumen ini merupakan format panduan bagi para finalis untuk menulis makalah untuk ajang Pagelaran Mahasiswa Nasional Bidang Teknologi Informasi dan Komunikasi (GEMASTIK). Penulis harus mengikuti petunjuk yang diberikan dalam panduan ini. Penulis dapat meminta bantuan kepada ketua tim dosen pembimbing dalam menyelesaikan masalah yang berkaitan dengan pedoman penulisan ini. Dokumen ini menguraikan langkah demi langkah penulisan makalah, dari judul, abstrak, daftar istilah, badan dokumen, kesimpulan, hingga referensi. Semua langkah harus diikuti secara cermat agar karya tulis dapat diterima dan dipublikasikan. Format penulisan ini disusun berdasarkan IEEE. Dokumen ini juga menjelaskan format halaman, gaya huruf, judul dan penulis, bagian heading, gambar dan tabel, serta rekomendasi lainnya. Semua komponen harus mengikuti standar yang ditetapkan. Dokumen ini merupakan panduan utama bagi finalis GEMASTIK. Penulis harus memastikan bahwa setiap aspek penulisan sesuai dengan ketentuan yang berlaku. Dokumen ini mencakup seluruh aspek penulisan makalah secara keseluruhan.
  ],
  authors: (
    (
      name: "Nama Ketua Tim",
      department: [Nama Fakultas dan Institusi dari Ketua Tim],
      organization: [Institusi],
      location: [Kota, Kodepos Negara],
      email: "ketuatim@institusi.ac.id",
    ),
    (
      name: "Nama Anggota Tim 1",
      department: [Nama Fakultas dan Institusi dari Anggota Tim 1],
      organization: [Institusi],
      location: [Kota, Kodepos Negara],
      email: "anggotatim1@institusi.ac.id",
    ),
    (
      name: "Nama Anggota Tim 2",
      department: [Nama Fakultas dan Institusi dari Anggota Tim 2],
      organization: [Institusi],
      location: [Kota, Kodepos Negara],
      email: "anggotatim2@institusi.ac.id",
    ),
    (
      name: "Nama Pembimbing Tim",
      department: [Nama Fakultas dan Institusi dari Pembimbing Tim],
      organization: [Institusi],
      location: [Kota, Kodepos Negara],
      email: "pembimbing@institusi.ac.id",
    ),
  ),
  index-terms: ("Tuliskan 4-8 kata kunci Anda di sini. Kata kunci dipisahkan dengan koma dan masing-masing kata diawali dengan huruf kapital", "GEMASTIK", "Format Penulisan", "IEEE", "Makalah"),
  bibliography: bibliography("references.bib"),
  )

= PENDAHULUAN

Dokumen ini adalah templat penulisan yang memberikan petunjuk bagaimana menulis makalah dalam Buletin Pagelaran Mahasiswa Nasional Bidang Teknologi Informasi (Buletin GEMASTIK). Pada bagian ini harus dipaparkan tentang latar belakang diusulkannya sebuah karya dan permasalahan yang ingin diselesaikan sehingga diperlukan sebuah karya tertentu. Makalah yang dituliskan setidaknya harus terdiri dari empat Bab utama yaitu Pendahuluan, Metode/Inovasi, Hasil dan Diskusi, serta Kesimpulan, kemudian dilengkapi dengan Referensi. Makalah ditulis dengan jumlah halaman antara 4 s.d 5 halaman dan diunggah bersamaan saat melakukan daftar ulang melalui sistem yang ditentukan oleh penyelenggara GEMASTIK.

= FORMAT HALAMAN

Cara paling mudah untuk memenuhi persyaratan format penulisan adalah dengan menggunakan dokumen ini sebagai templat. Kemudian, ketikkan teks Anda ke dalamnya. Ukuran kertas harus sesuai dengan ukuran halaman A4, yaitu lebar 210 mm (8,27\") dan panjang 297 mm (11,69\"). Batas margin ditetapkan sebagai berikut:

- Atas = 23 mm (0,90\")
- Bawah = 18 mm (0,70\")
- Kiri = kanan = 13 mm (0,51\")

Artikel penulisan harus dalam format dua kolom dengan ruang 7,1 mm (0,28\") antara kolom.

= STYLE HALAMAN

Paragraf harus tertata dengan baik. Semua paragraf harus rata kanan dan kiri.

== HURUF-HURUF DOKUMEN

Seluruh dokumen harus dalam Times New Roman atau _font_ Times. _Font_ tipe 3 tidak boleh digunakan. Jenis _font_ lain dapat digunakan jika diperlukan untuk tujuan khusus. Fitur ukuran _font_ dapat dilihat pada @table:font-size.

#figure(
  align(center)[#table(
    columns: (2fr, 1fr, 3fr, 3fr, 3fr,),
    align: (center,center,left,left,left,),
    table.header(
      table.cell(align: center, rowspan: 2)[Font
      Type], table.cell(align: center, rowspan: 2)[Font
      Size], table.cell(align: center, colspan: 3)[Font Style],
      table.cell(align: center)[#emph[Regular]], table.cell(align: center)[#emph[Bold]], table.cell(align: center)[#emph[Italic]],),
    table.hline(),
    table.cell(rowspan: 3)[Helvetica], table.cell(align: center)[7], [Keterangan gambar], [Label
    gambar], [],
    table.cell(align: center)[9], [#emph[Heading] level 3], [Nama
    pengarang, #emph[heading] intisari, #emph[heading] level 1,
    #emph[heading] level 2], [#emph[Heading] level 2],
    table.cell(align: center)[20], [], [Judul], [],
    table.cell(rowspan: 4)[Times New
    Roman], table.cell(align: center)[7], [Afiliasi penulis], [], [],
    table.cell(align: center)[8], [Label tabel (dalam kapital), judul
    tabel (dalam #emph[small caps]), #emph[item] referensi
    (parsial)], [#emph[Header] tabel, #emph[subheader]
    tabel], [#emph[Subheader] tabel],
    table.cell(align: center)[9], [Sel dalam tabel], [], [],
    table.cell(align: center)[10], [Isi Intisari, paragraf], [], [],
  )], 
  caption: [Ukuran Huruf dalam Naskah]
  , kind: table
) <table:font-size>

== JUDUL DAN PENULIS

Judul harus dalam Helvetica yang berukuran 20. Nama pengarang harus dalam Helvetica yang berukuran 9. Jumlah kata judul dalam masing-masing bahasa maksimal 12 kata. Penulisan nama penulis tidak boleh menunjukkan nama jabatan (misalnya Dosen Pembimbing), gelar akademik (misalnya Dr.), atau keanggotaan dari setiap organisasi profesional (misalnya Senior Member IEEE).

#figure(
  image("assets/image30.png", height: 2.81496in, width: 3.09646in, alt: "Chart, line chart Description automatically generated"),
  caption: [
    Contoh grafik garis yang menggunakan warna yang kontras baik di layar komputer, maupun dalam hasil cetak hitam-putih.
  ]
) <figure:chart>

Nama keluarga dituliskan di bagian terakhir dari masing-masing nama pengarang (misalnya Hidayat A.K. Suyono). Setiap afiliasi harus dimasukkan, setidaknya nama perusahaan dan nama negara penulis (misalnya SWAMedical Center Pty Ltd, INDONESIA). Alamat _email_ diwajibkan bagi penulis yang bersangkutan.

Pada kolom informasi penulis dan afiliasi, tanggal diterima menunjukkan tanggal penulis melakukan pengajuan makalah ke Gemastik. Sementara itu, tanggal revisi menunjukkan tanggal penulis menyetujui makalah final sebelum makalah diterbitkan.

== BAGIAN HEADING

Sebaiknya digunakan _heading_ tidak lebih dari tiga tingkat. Semua _heading_ harus dalam Helvetica berukuran 9. Huruf pada setiap kata di _heading_ harus berhuruf kapital.

=== HEADING LEVEL 1

_Heading_ level 1 harus dalam huruf kapital, tebal, rata kiri, dan menggunakan penomoran angka Romawi dalam kapital. Sebagai contoh, lihat _heading_ "*III. STYLE HALAMAN*" dari dokumen ini. _Heading_ level 1 yang tidak menggunakan penomoran adalah "Referensi."

=== HEADING LEVEL 2

_Heading_ level 2 harus dalam huruf kapital, tebal, miring, merapat ke kiri, dan dinomori menggunakan abjad dalam kapital. Sebagai contoh, lihat _heading_ "*C. BAGIAN HEADING*" di atas.

=== HEADING LEVEL 3

_Heading_ level 3 harus dalam huruf kapital, miring, rata kiri, dan dinomori dengan angka Arab diikuti dengan tanda kurung kanan. Isi dari bagian level 3 diletakkan di bawah judul _heading_ sebagai paragraf baru. Sebagai contoh, bagian ini diawali dengan _heading_ level 3.

= GAMBAR DAN TABEL

Gambar dan tabel harus terletak di tengah (_centered_). Gambar dan tabel yang besar dapat direntangkan pada kedua kolom. Setiap tabel dan/atau gambar akan diposisikan di bagian atas atau di bagian bawah halaman. Jika diperlukan, gambar dan/atau tabel dapat dibuat mencakup lebih dari satu kolom.

Grafik diperbolehkan berwarna, tetapi makalah akan dicetak dalam format hitam-putih. Gambar tidak boleh menggunakan pola titik-titik karena ada kemungkinan tidak dapat dicetak sesuai aslinya. Gunakan pewarnaan padat dengan kontras, baik untuk tampilan di layar komputer maupun untuk hasil cetak yang berwarna hitam putih, seperti tampak pada @figure:chart.

#figure(
  stack[
    #stack[
      #image("assets/image10.jpg", width: 40%)
      (a)
    ]
    #stack[
      #image("assets/image20.png", width: 40%)
      (b)
    ]
  ],
  caption: [
    Contoh gambar, (a) resolusi kurang, (b) resolusi cukup.
  ]
) <figure:resolution>

@figure:resolution(a) menunjukkan contoh sebuah gambar dengan resolusi rendah yang tidak sesuai dengan ketentuan, sedangkan @figure:resolution(b) menunjukkan contoh dari sebuah gambar dengan resolusi yang memadai. Pastikan bahwa resolusi gambar cukup tinggi agar detail gambar jelas terlihat.

Harap periksa semua gambar dalam jurnal Anda, baik di layar maupun hasil cetak, untuk memastikan bahwa gambar cukup jelas, dan semua label pada gambar dapat dibaca.

== LABEL DAN KETERANGAN GAMBAR

Gambar diberi label dengan menggunakan angka Arab. Label gambar harus dalam huruf tebal dan Helvetica berukuran 8. Judul gambar dalam satu baris (misalnya @figure:resolution) diletakkan di tengah (_centered_), sedangkan judul multibaris harus rata kiri dan kanan (_justified_), misalnya Gambar 1. Label dan judul gambar harus ditempatkan setelah gambar terkait, seperti yang ditunjukkan pada @figure:resolution.

== LABEL DAN JUDUL TABEL

Tabel diberi label menggunakan angka Romawi huruf kapital. Label tabel ditulis rata tengah (_centered_) dan dalam Times New Roman biasa berukuran 8. Setiap awal kata dalam judul tabel menggunakan huruf kapital, kecuali untuk kata hubung, preposisi, partikel, dan sejenisnya, seperti yang tercantum pada bagian III-B. Label dan judul tabel ditulis menggunakan Small Caps. Label dan judul tabel ditempatkan sebelum tabel terkait, seperti yang ditunjukkan pada Tabel I.

== RESOLUSI DAN WARNA GAMBAR

Resolusi gambar minimal adalah 300 ppi. Gambar berwarna hanya tersedia dalam versi _online_. Versi cetak hanya berisi gambar hitam putih.

= REKOMENDASI LAINNYA

== SINGKATAN DAN AKRONIM

Definisikan singkatan dan akronim saat pertama kali disebutkan dalam teks, walaupun telah didefinisikan dalam intisari. Singkatan seperti IEEE, AC, dan DC tidak harus didefinisikan. Singkatan yang menyertakan titik tidak boleh dipisahkan oleh spasi, sehingga "C.N.R.S.," bukan "C. N. R. S." Jangan gunakan singkatan dalam judul kecuali jika tidak dapat dihindari.

== LINK DAN BOOKMARK

Semua _hypertext link_ dan bagian _bookmark_ akan dihapus. Jika makalah perlu merujuk ke alamat _email_ atau URL di artikel, alamat atau URL lengkap harus diketik dalam Times New Roman dan dicetak miring (_italic_).

== PENULISAN PERSAMAAN

Penulisan persamaan diikuti dengan penomoran angka dalam tanda kurung dengan margin rata kanan, seperti dalam @eq:1. Pisahkan persamaan dan nomor persamaan menggunakan _tab_ _space_. Gunakan _equation editor_ untuk membuat persamaan. Untuk membuat persamaan Anda lebih rapat, gunakan tanda garis miring (/), fungsi pangkat, atau pangkat yang tepat. Gunakan tanda kurung untuk menghindari kerancuan dalam pemberian angka pecahan. Jelaskan persamaan saat berada dalam bagian dari kalimat seperti berikut.

$ X(omega)= integral_(- oo)^oo x(t) dot e^(- j omega t) med d t $ <eq:1>

$ x(t)= integral_(- oo)^oo X(omega) dot e^(j omega t) med d omega $ <eq:2>

Pastikan bahwa simbol-simbol di dalam persamaan telah didefinisikan sebelum persamaan atau langsung mengikuti setelah persamaan muncul. Simbol diketik dengan huruf miring (_T_ mengacu pada suhu, tetapi T merupakan satuan Tesla). Ketika mengacu suatu persamaan, tuliskan "@eq:1," bukan "Pers. @eq:1" atau "persamaan @eq:1," kecuali pada awal kalimat: "Persamaan @eq:1 merupakan …"

= KESIMPULAN

Sebagian besar petunjuk format di dokumen ini disadur dari templat untuk artikel IEEE dan JNTETI UGM.

= REFERENSI

Judul pada bagian Referensi tidak boleh bernomor. Semua _item_ referensi dalam _font_ berukuran 8. Tuliskan referensi sesuai format berdasarkan masing-masing kategori sumber, seperti dicontohkan pada bagian Referensi. Penomoran _item_ referensi diketik berurutan dalam tanda kurung siku (misalnya @ref1).

Kutipan (sitasi) dan Referensi ditulis mengikuti standar IEEE. Ketika Anda mengacu pada _item_ referensi (sitasi), silakan menggunakan nomor referensi saja, misalnya @ref2. Jangan menggunakan "Ref. @ref3" atau "Referensi @ref3," kecuali pada awal kalimat, misalnya "Referensi @ref3 menunjukkan bahwa \..." Dalam penggunaan beberapa referensi, masing-masing nomor diketik dengan kurung terpisah (misalnya @ref2, @ref3, @ref4, @ref5, @ref6). Beberapa contoh _item_ referensi dengan kategori yang berbeda ditampilkan pada bagian Referensi, yang meliputi:
- contoh buku pada @ref1,
- contoh seri buku dalam @ref2,
- contoh artikel jurnal di @ref3,
- contoh makalah seminar di @ref4,
- contoh paten dalam @ref5,
- contoh _website_ di @ref6,
- contoh dari suatu halaman web di @ref7,
- contoh _manual databook_ dalam @ref8,
- contoh _datasheet_ dalam @ref9,
- contoh tesis master di @ref10,
- contoh laporan teknis dalam @ref11, dan
- contoh standar dalam @ref12.
