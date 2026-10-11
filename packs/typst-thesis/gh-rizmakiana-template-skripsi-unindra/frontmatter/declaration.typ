#import "../config/input.typ" : *

= LEMBAR PERNYATAAN
\
\
Yang bertanda tangan di bawah ini:

\

#grid(
  columns: (70pt, 10pt, auto), 
  row-gutter: 1em,
  [Nama], [:], [#name],
  [NPM], [:], [#npm],
  [Program Studi], [:], [#study-program.slice(14)],
)
\
Dengan ini menyatakan bahwa skripsi dengan judul _ "#thesis-title" _ beserta seluruh isinya adalah benar-benar karya saya sendiri. Saya tidak melakukan penjiplakan atau pengutipan dengan cara-cara yang tidak sesuai dengan etika ilmu yang berlaku dalam masyarakat keilmuan. Atas pernyataan ini, saya siap menanggung risiko/sanksi apabila di kemudian hari ditemukan adanya pelanggaran etika keilmuan atau ada klaim dari pihak lain terhadap keaslian karya saya ini sesuai dengan Undang-Undang Republik Indonesia Nomor 20 Tahun 2003 tentang Sistem Pendidikan Nasional Bab V Pasal 25 ayat 2.
\
\ 
Demikian pernyataan ini saya buat untuk dimanfaatkan sesuai dengan keperluan.
\
\
\
#align(right)[
  #block(width: 200pt)[
    #align(center)[
      Yang Menyatakan

      #v(2cm) // Jarak untuk tanda tangan

      #name
    ]
  ]
]

#pagebreak()