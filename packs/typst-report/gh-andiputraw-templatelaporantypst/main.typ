#set text(font: "Tinos")
#show raw.where(lang: none): raw => {
  text(font: "JetBrains Mono", raw.text)
}


#include "cover.typ"

#pagebreak()
#align(center)[
  #outline(title: text("Daftar Isi"), indent: auto)
]
#pagebreak()

// Content

#show heading.where(level: 1): it => {
  return align(
    center,
    text(
      size: 18pt,
      it.body,
    ),
  )
}

#show heading.where(level: 2): it => {
  return align(
    left,
    text(size: 14pt, it.body),
  )
}

#set par(justify: true)

= Soal 1

#pagebreak()
= BAB 2 KESIMPULAN

// Kesimpulan dari laporan

#pagebreak()
= DAFTAR PUSTAKA

// Isi dengan daftar pustaka, bisa input via json atau sejenisnya
