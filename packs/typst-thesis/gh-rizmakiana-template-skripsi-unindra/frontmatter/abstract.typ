#import "../config/input.typ" : *

#set enum(numbering: "A.")

= ABSTRAK 
\
+ Nama, NPM: #name, #npm  #v(0.65em)

+ *#thesis-title.* Skripsi; Jakarta; #faculty;; #study-program;; Universitas Indraprasta Persatuan Guru Republik Indonesia, #today_month, #today.year(). #v(0.65em)

+ Jumlah halaman romawi + jumlah bab + jumlah halaman isi #v(0.65em)

+ #grid(
    columns: (55pt, 9pt, auto),
    [Kata Kunci], [:], [#keyword.join(", ")]
  ) #v(0.65em)
  
+ #abstract-point-e #v(0.65em)

+ #grid(
    columns: (auto, 10pt, auto),
    [Referensi],[:],
    [
      15 Buku (tahun 2008-2018) \ 
      4 artikel dalam jurnal (tahun 2009-2010) \
      2 laporan penelitian akademik \
      6 sumber lain \
    ]
  ) #v(0.65em)
  
+ #grid(
    columns: (auto, 10pt, auto),
    [Pembimbing],[:],[#strong[#thesis-advisor1] (Materi)\ #strong[#thesis-advisor2] (Teknik)]
  )

#pagebreak()