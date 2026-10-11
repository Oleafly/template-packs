#let setup(body) = {
  set document(title: "Skripsi", author: "Nama Mahasiswa")
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 4cm, right: 3cm),
    numbering: "1",
    number-align: center,
  )
  set text(font: "Times New Roman", size: 12pt, lang: "id")
  set par(justify: true, leading: 0.8em, first-line-indent: 1.25cm)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set align(center)
    set text(weight: "bold")
    block(above: 1.5em, below: 1em, it)
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold")
    block(above: 1em, below: 0.5em, it)
  }
  show figure: set block(above: 1em, below: 1em)
  show figure.caption: it => [#text(size: 10pt)[#it]]
  body
}

#let cover(kampus, fakultas, prodi, judul, penulis, nim, pembimbing, tahun) = {
  set page(numbering: none)
  align(center)[
    #v(1cm)
    #text(size: 15pt, weight: "bold")[#kampus]
    #v(0.5cm)
    #text(size: 13pt)[#fakultas \ #prodi]
    #v(3cm)
    #text(size: 16pt, weight: "bold")[#judul]
    #v(2cm)
    SKRIPSI
    #v(0.7cm)
    Diajukan sebagai salah satu syarat untuk memperoleh gelar
    #v(2cm)
    #text(weight: "bold")[#penulis]
    \ #nim
    #v(2cm)
    Pembimbing:
    \ #pembimbing
    #v(2cm)
    #tahun
  ]
}
