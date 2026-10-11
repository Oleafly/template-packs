// Template PKL/Thesis UBSI — pengaturan dan komponen bersama.

#let university-logo = "assets/logos/logo-universitas-bina-sarana-informatika-ubsi.png"

// A4; batas teks mengikuti pedoman: atas 3 cm, kiri 4 cm,
// bawah 2,5 cm, kanan 2,5 cm. Footer berada 0,3 cm dari tepi bawah.
#let thesis-page = (
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 4cm, right: 2.5cm),
  footer-descent: 0.3cm,
)

#let normal-header = context align(right)[#counter(page).display()]
#let centered-footer = context align(center)[#counter(page).display()]

#let is-chapter-page(current-page) = query(heading.where(level: 1)).any(it =>
  it.location().page() == current-page
)

// Halaman pertama bab: nomor di bawah tengah.
// Halaman pokok lainnya: nomor di kanan atas.
#let main-header = context {
  let current-page = here().page()
  if not is-chapter-page(current-page) {
    align(right)[#counter(page).display()]
  }
}
#let main-footer = context {
  let current-page = here().page()
  if is-chapter-page(current-page) {
    align(center)[#counter(page).display()]
  }
}

// Judul bagian awal/akhir, misalnya Daftar Isi dan Daftar Pustaka.
#let section-title(title) = block(
  width: 100%,
  above: 0pt,
  below: 4em,
  align(center)[#text(size: 14pt, weight: "bold")[#title]],
)

#let thesis(body) = {
  set text(
    font: ("Times New Roman", "Liberation Serif"),
    size: 12pt,
    lang: "id",
  )
  set page(..thesis-page, numbering: "1", header: main-header, footer: main-footer)
  // Leading 1em menghasilkan jarak antarbaris dua spasi untuk teks 12 pt.
  set par(
    justify: true,
    first-line-indent: (amount: 1cm, all: true),
    leading: 1em,
  )
  set heading(numbering: "1.1")

  // Caption tabel berada di atas dan tengah: "Tabel 1." lalu judul tabel.
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => align(center)[
    #it.supplement #context it.counter.display(it.numbering).
    #linebreak()
    #it.body
  ]

  show heading.where(level: 1): it => block(
    width: 100%,
    above: 0pt,
    below: 4em,
    breakable: false,
    align(center)[
      #text(size: 14pt, weight: "bold")[
        BAB #counter(heading).display("I")
        #linebreak()
        #it.body
      ]
    ],
  )
  show heading.where(level: 2): it => block(
    above: 2em,
    below: 1em,
    text(weight: "bold")[#counter(heading).display("1.1.") #it.body],
  )
  show heading.where(level: 3): it => block(
    above: 1em,
    below: 1em,
    text(weight: "bold")[#counter(heading).display("1.1.1.") #it.body],
  )
  body
}

#let cover(meta) = [
  #set page(numbering: none, header: none, footer: none)
  #set par(first-line-indent: 0pt, leading: .5em)
  #align(center)[
    #v(1cm)
    #text(size: 14pt, weight: "bold")[#upper(meta.title)]
    #v(1.5em)
    #image(meta.logo, width: 4cm)
    #v(1.5em)
    #text(size: 18pt, weight: "bold")[#upper(meta.subtitle)]
    #v(1.5em)
    #text(size: 12pt)[#meta.purpose]
    #v(2.5em)
    #text(size: 14pt)[#meta.author]
    #linebreak()
    #text(size: 14pt)[NIM: #meta.nim]
    #v(3em)
    #text(size: 12pt, weight: "bold")[PROGRAM STUDI #upper(meta.program)]
    #linebreak()
    #text(size: 12pt, weight: "bold")[FAKULTAS #upper(meta.faculty)]
    #linebreak()
    #text(size: 12pt, weight: "bold")[UNIVERSITAS BINA SARANA INFORMATIKA]
    #linebreak()
    #text(size: 12pt, weight: "bold")[#upper(meta.city)]
    #linebreak()
    #text(size: 12pt, weight: "bold")[#meta.year]
  ]
  #pagebreak()
]

// Bagian awal: angka romawi kecil, bawah tengah.
#let front-matter(body) = [
  #set page(numbering: "i", header: none, footer: centered-footer)
  #counter(page).update(1)
  #body
]

// Bagian pokok: nomor melanjutkan bagian awal dengan angka Arab.
// Halaman awal bab di bawah tengah, halaman lain di kanan atas.
#let main-matter(body) = [
  #pagebreak()
  #set page(numbering: "1", header: main-header, footer: main-footer)
  #body
]

// Bagian akhir: angka latin berlanjut, bawah tengah.
#let back-matter(body) = [
  #pagebreak()
  #set page(header: none, footer: centered-footer)
  #body
]

#let table-caption(number, title) = align(center)[
  #text(size: 12pt)[Tabel #number]
  #linebreak()
  #text(size: 12pt)[#title]
]

#let figure-caption(number, title) = align(center)[
  #text(size: 12pt)[Gambar #number. #title]
]
