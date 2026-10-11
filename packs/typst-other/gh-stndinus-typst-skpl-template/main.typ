#import "lib.typ": (
  application_name,
  client,
  client_address,
  document_no,
  document_revision,
  font,
  pre_heading,
  revision_data,
  team_members,
)

// settings
#set text(lang: "id")
#set outline(title: none)
#set heading(numbering: "1.1")
#show heading: set text(font: font.at("sans"))
#show figure.where(kind: image): set figure(supplement: [Gambar])
#show figure.where(kind: table): set figure(supplement: [Tabel])
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption: set text(weight: "bold")

// cover
#set text(font: font.at("sans"))
#set page(margin: (bottom: 10em), footer-descent: 0em, footer: context [
  #set table.cell(align: horizon + center)

  #box(height: 100% - 4em, table(
    columns: (auto, auto, 1fr, 1fr, 1fr),
    rows: 1fr,
    table.cell(rowspan: 3)[#image("logo_fik_udinus_semarang.jpg")],
    table.cell(
      rowspan: 3,
      align: start + horizon,
    )[*Jurusan\ Teknik Informatika\ UDINUS*],
    table.cell(colspan: 2)[*Nomor Dokumen*],
    [*Halaman*],
    table.cell(colspan: 2)[#text(
        style: "italic",
        weight: "bold",
        size: 1.3em,
      )[SKPL-#document_no]],
    [#counter(page).display("1 / 1", both: true)],
    [*Revisi*],
    [_#{ document_revision }_],
    [_#datetime.today().display()_]
  ))
])
#align(center)[
  #v(7em)
  #text(weight: "bold", size: 1.3em)[
    DOKUMEN \
    SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK \
  ]
  #v(2em)

  *#text(size: 2em)[#application_name]*\
  #v(2em)

  untuk\
  #client\
  #client_address

]
#align(center + bottom)[
  #text(size: 1.3em)[
    Dipersiapkan oleh:
  ]
  #for m in team_members [+ #m]
  #v(7em)
]

#pagebreak()
#set page(
  margin: auto,
  footer-descent: 0em,
  footer: context {
    set text(font: font.at("sans"))
    table(
      columns: (1fr, auto, 1fr),
      [*Teknik Informatika UDINUS*],
      [*SKPL-#document_no*],
      table.cell(align: right)[
        *Halaman #counter(page).display((i, j) => [#i dari #j], both: true)*]
      ,
      table.cell(colspan: 3)[
        #set align(center)
        #set text(size: 0.8em)
        Template dokumen ini dan informasi yang dimilikinya adalah milik Teknik Informatika Universitas Dian Nuswantoro
      ]
    )
  },
)

#pre_heading([Daftar Perubahan])
#{
  show table.cell.where(x: 0): strong
  show table.cell.where(y: 0): strong

  table(
    align: (x, y) => {
      if x == 0 or y == 0 { center + horizon } else { auto }
    },
    rows: (auto, 4em),
    columns: (7em, 1fr),
    table.header([Revisi], [Deskripsi]),
    ..for r in revision_data.keys().slice(1) {
      (r, revision_data.at(r).description)
    },
  )
}
#table(
  columns: (1fr, for _ in revision_data { (1fr,) }).flatten(),
  align: center + horizon,
  [INDEX TGL],
  ..for (k, _) in revision_data {
    (k,)
  },
  [Ditulis Oleh],
  ..for (_, v) in revision_data {
    (v.at("author"),)
  },
  [Diperiksa Oleh],
  ..for (_, v) in revision_data {
    (v.at("reviewer"),)
  },
  [Disetujui Oleh],
  ..for (_, v) in revision_data {
    (v.at("approver"),)
  },
)

#pagebreak()
#pre_heading([Daftar Halaman Perubahan])
#{
  let style_header = it => {
    set text(size: 1.3em)
    [*#it*]
  }
  show table.cell.where(y: 0): style_header
  table(
    align: (x, y) => {
      if x == 0 or y == 0 { center + horizon } else { auto }
    },
    columns: (1fr, 1fr, 1fr, 1fr),
    table.header(..for i in range(1, 5) {
      (if calc.odd(i) [Halaman] else [Revisi],)
    }),

    v(75%),
  )
}

// headings outline
#pagebreak()
#set text(font: font.at("serif"))
#pre_heading([Daftar Isi])
#outline()

// tables outline
#pagebreak()
#pre_heading([Daftar Tabel])
#outline(target: figure.where(kind: table))

// figures outline
#pagebreak()
#pre_heading([Daftar Gambar])
#outline(target: figure.where(kind: image))

// body
#pagebreak()
#include "body.typ"
