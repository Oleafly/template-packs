// ====================================================================
// TEMPLATE SKRIPSI FAKULTAS TEKNIK - UNIVERSITAS MULAWARMAN (TYPST)
// ====================================================================

// Box Catatan / Petunjuk Panduan (sesuai template Unmul)
#let catatan(body) = block(
  fill: rgb("fff4e5"),
  stroke: (left: 4pt + rgb("e65100")),
  inset: (x: 12pt, y: 10pt),
  radius: (right: 4pt),
  width: 100%,
  [
    #set text(size: 10pt, fill: rgb("4e342e"), font: "Times New Roman")
    #set par(leading: 1.15em, first-line-indent: 0cm, justify: true)
    *Keterangan / Petunjuk:* \
    #body
  ]
)

// Halaman Sampul Luar (Hardcover)
#let halaman-cover-luar(
  judul: "",
  penulis: "",
  nim: "",
  fakultas: "Fakultas Teknik",
  universitas: "Universitas Mulawarman",
  kota: "Samarinda",
  tahun: "2025",
  logo: none,
  logo-width: 3.0cm,
  no-urut: true,
) = {
  // Margin 4-4-3-3: Top 4cm, Left 4cm, Bottom 3cm, Right 3cm
  set page(
    footer: none,
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
    header: if no-urut != false and no-urut != none {
      let no-text = if type(no-urut) == str { no-urut } else { "No. Urut Skripsi" }
      align(right)[
        #rect(stroke: 0.8pt, inset: (x: 10pt, y: 4.5pt))[
          #text(font: "Times New Roman", size: 10.5pt)[#no-text]
        ]
      ]
    } else {
      none
    },
  )
  set text(font: "Times New Roman", lang: "id")
  set par(justify: false, leading: 0.4em, spacing: 0.5em, first-line-indent: 0cm)

  align(center)[
    #text(weight: "bold", size: 16pt)[#upper(judul)]

    #v(2.3cm)
    #text(weight: "bold", size: 13pt)[SKRIPSI]

    #v(1.8cm)
    #text(weight: "bold", size: 13pt)[
      Oleh:\
      \
      #upper(penulis)\
      #nim
    ]

    #v(2.0cm)
    #if logo != none {
      if type(logo) == str {
        image(logo, width: logo-width)
      } else {
        logo
      }
    } else {
      rect(width: logo-width, height: logo-width, stroke: 0.6pt)[
        #align(center + horizon)[*LOGO UNMUL BERWARNA*]
      ]
    }

    #v(2.6cm)
    #text(weight: "bold", size: 13pt)[
      #upper(fakultas) \
      #upper(universitas)
    ]

    #v(2.6cm)
    #text(weight: "bold", size: 13pt)[
      #upper(kota) \
      #tahun
    ]
  ]
  pagebreak()
}

// Halaman Sampul Dalam (Halaman Judul)
#let halaman-cover-dalam(
  judul: "",
  penulis: "",
  nim: "",
  program-studi: "Informatika",
  fakultas: "Fakultas Teknik",
  universitas: "Universitas Mulawarman",
  kota: "Samarinda",
  tahun: "2025",
  logo: none,
  logo-width: 3.0cm,
) = {
  set page(
    header: none,
    footer: context align(center)[#text(font: "Times New Roman", size: 12pt)[#counter(page).display("i")]],
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )
  counter(page).update(1)
  set text(font: "Times New Roman", lang: "id")
  set par(justify: false, leading: 0.4em, spacing: 0.5em, first-line-indent: 0cm)
  
  align(center)[
    #text(weight: "bold", size: 16pt)[#upper(judul)]

    #v(2.0cm)
    #text(weight: "bold", size: 13pt)[SKRIPSI]

    #v(0.8cm)
    #text(size: 11pt)[
      Diajukan sebagai salah satu syarat untuk menyelesaikan pendidikan \
      pada Program Studi Strata 1 #program-studi, \
      #fakultas, #universitas
    ]

    #v(1.4cm)
    #text(weight: "bold", size: 13pt)[
      Oleh:\
      \
      #upper(penulis)\
      #nim
    ]

    #v(1.6cm)
    #if logo != none {
      if type(logo) == str {
        image(logo, width: logo-width)
      } else {
        logo
      }
    } else {
      rect(width: logo-width, height: logo-width, stroke: 0.6pt)[
        #align(center + horizon)[*LOGO UNMUL B&W*]
      ]
    }

    #v(2.2cm)
    #text(weight: "bold", size: 13pt)[
      #upper(fakultas) \
      #upper(universitas)
    ]

    #v(2.6cm)
    #text(weight: "bold", size: 13pt)[
      #upper(kota) \
      #tahun
    ]
  ]
  pagebreak()
}

// Wrapper kompatibilitas halaman-cover
#let halaman-cover(
  judul: "",
  penulis: "",
  nim: "",
  program-studi: "Informatika",
  fakultas: "Fakultas Teknik",
  universitas: "Universitas Mulawarman",
  kota: "Samarinda",
  tahun: "2025",
  logo: none,
  diajukan: none,
) = {
  if diajukan != none {
    halaman-cover-dalam(
      judul: judul,
      penulis: penulis,
      nim: nim,
      program-studi: program-studi,
      fakultas: fakultas,
      universitas: universitas,
      kota: kota,
      tahun: tahun,
      logo: logo,
    )
  } else {
    halaman-cover-luar(
      judul: judul,
      penulis: penulis,
      nim: nim,
      fakultas: fakultas,
      universitas: universitas,
      kota: kota,
      tahun: tahun,
      logo: logo,
    )
  }
}

// Halaman Pernyataan Keaslian Skripsi
#let halaman-pernyataan(
  judul: "",
  penulis: "",
  nim: "",
  prodi: "S1 Informatika",
  fakultas: "Fakultas Teknik",
  universitas: "Universitas Mulawarman",
  kota: "Samarinda",
  tanggal: "10 Agustus 2026",
) = {
  set text(font: "Times New Roman", size: 12pt, lang: "id")
  set par(first-line-indent: 0cm, leading: 0.75em, spacing: 0.75em)

  align(center)[
    #text(weight: "bold", size: 14pt)[PERNYATAAN KEASLIAN SKRIPSI]
  ]

  // 3 Baris spasi kosong (Enter x3 di Word)
  v(3 * 18pt)

  [Saya menyatakan dengan sesungguhnya bahwa skripsi dengan judul:]

  // 2 Baris spasi kosong (Enter x2 di Word)
  v(2 * 18pt)

  align(left)[
    #set par(justify: false, leading: 0.45em)
    #text(weight: "bold", size: 12pt)[#upper(judul)]
  ]

  // 2 Baris spasi kosong (Enter x2 di Word)
  v(2 * 18pt)

  [#set par(justify: true, leading: 0.75em)
  yang dibuat sebagai salah satu syarat untuk menyelesaikan pendidikan pada Program Studi #prodi, #fakultas, #universitas, sejauh yang saya ketahui bukan merupakan tiruan atau duplikasi dari skripsi yang sudah dipublikasikan dan atau pernah dipakai untuk mendapatkan gelar kesarjanaan di lingkungan #universitas maupun di Perguruan Tinggi atau instansi manapun, kecuali bagian yang sumber informasinya dicantumkan sebagaimana mestinya.]

  // 2 Baris spasi kosong (Enter x2 di Word)
  v(2 * 18pt)

  grid(
    columns: (1fr, 1fr),
    gutter: 0pt,
    [],
    [
      #set align(left)
      #set par(leading: 0.4em, first-line-indent: 0cm)
      #kota, #tanggal \
      #v(2.3cm)
      #upper(penulis)\
      NIM.#nim
    ]
  )
  pagebreak()
}

// Halaman Pengesahan
#let halaman-pengesahan(
  judul: "",
  penulis: "",
  nim: "",
  kota: "Samarinda",
  universitas: "Universitas Mulawarman",
  fakultas: "Fakultas Teknik",
  pembimbing1: "Nama Pembimbing I, Gelar",
  nip1: "NIP...",
  pembimbing2: "Nama Pembimbing II, Gelar",
  nip2: "NIP...",
  dekan: "Prof. Dr. Ir. H. Tamrin, ST., MT., IPU., ASEAN Eng., APEC Eng",
  nip-dekan: "197002272000121001",
  tanggal-sidang: "Tanggal Bulan Tahun",
  tanggal-jilid: "Tanggal Bulan Tahun",
) = {
  set text(font: "Times New Roman", size: 13pt, lang: "id")
  set par(first-line-indent: 0cm, leading: 0.45em, spacing: 0.6em)

  align(center)[
    #set par(justify: false, leading: 0.45em)
    #text(weight: "bold", size: 16pt)[#upper(judul)]

    #v(1.6cm)
    Oleh:\
    #v(0.2em)
    #upper(penulis)\
    #nim

    #v(1.2cm)
    Telah diujikan pada #tanggal-sidang dan dinyatakan telah \
    memenuhi syarat \
    \
    #kota, #tanggal-jilid

    #v(1.0cm)
    Disahkan oleh:
  ]

  v(0.6cm)
  grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    align: left,
    [
      #set par(justify: false, leading: 0.4em)
      Pembimbing I,\
      #v(2.0cm)
      *#pembimbing1*\
      NIP. #nip1
    ],
    [
      #set par(justify: false, leading: 0.4em)
      Pembimbing II,\
      #v(2.0cm)
      *#pembimbing2*\
      NIP. #nip2
    ]
  )

  v(1.0cm)
  align(center)[
    #set par(justify: false, leading: 0.4em)
    Mengetahui,\
    Dekan #fakultas\
    #universitas\
    #v(2.0cm)
    *#dekan*\
    NIP. #nip-dekan
  ]
  pagebreak()
}

// Halaman Persembahan
#let halaman-persembahan(
  isi: [Persembahan untuk .........................................................................],
) = {
  align(center)[
    #text(weight: "bold", size: 12pt)[HALAMAN PERSEMBAHAN]
  ]

  v(1fr)
  align(left)[
    #text(style: "italic")[#isi]
  ]
  v(1.5cm)
  pagebreak()
}

// Halaman Abstrak
#let halaman-abstrak(
  label: "ABSTRAK",
  penulis: "",
  nim: "",
  program-studi-label: "Program Studi Informatika",
  pembimbing-label: "Dosen Pembimbing",
  pembimbing1: "",
  pembimbing2: "",
  judul: "",
  isi: [],
  kata-kunci-label: "Kata kunci",
  kata-kunci: [],
) = {
  grid(
    columns: (1fr, 1fr),
    align: (left, left),
    [
      #penulis\
      NIM. #nim\
      #program-studi-label
    ],
    [
      #pembimbing-label\
      I. #pembimbing1\
      II. #pembimbing2
    ]
  )

  v(1.5em)

  align(center)[
    #text(weight: "bold", size: 12pt)[#upper(judul)]
    #v(1em)
    #text(weight: "bold", size: 12pt, style: if label == "ABSTRACT" { "italic" } else { "normal" })[#label]
  ]

  v(1em)
  {
    set par(justify: true, leading: 1em, first-line-indent: 1cm)
    if label == "ABSTRACT" {
      text(style: "italic")[#isi]
    } else {
      isi
    }
  }

  v(1.5em)
  [
    #set par(first-line-indent: 0cm)
    *#kata-kunci-label :* #if label == "ABSTRACT" { text(style: "italic")[#kata-kunci] } else { kata-kunci }
  ]

  pagebreak()
}

// Template Utama Skripsi
#let skripsi(
  judul: "",
  penulis: "",
  body,
) = {
  // Pengaturan Halaman: Kertas A4, Margin Kiri 4cm, Atas 4cm, Kanan 3cm, Bawah 3cm (Format 4-4-3-3)
  set page(
    paper: "a4",
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )

  // Pengaturan Font: Times New Roman 12pt, Bahasa Indonesia (Sesuai Style "Normal")
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "id",
  )

  // Pengaturan Paragraf: Justified, Spasi 1.5 (leading 0.75em), Spacing After 8pt (spacing 1.2em), Indentasi 1cm
  set par(
    justify: true,
    leading: 0.75em,
    spacing: 1.2em,
    first-line-indent: 1cm,
  )

  // Pengaturan Penomoran Heading Bab & Sub-Bab
  set heading(
    numbering: (..nums) => {
      let n = nums.pos()
      if n.len() == 1 {
        numbering("I", n.first())
      } else {
        n.map(str).join(".")
      }
    }
  )

  // Pengaturan Tampilan Heading (Sesuai Style "Heading 1", "Heading 2", "Heading 3")
  show heading: it => {
    if it.level == 1 {
      // Style "Heading 1": 14pt Bold, Centered, BAB I, Spacing After 0pt
      pagebreak(weak: true)
      // Reset nomor persamaan matematika pada setiap bab
      counter(math.equation).update(0)

      set align(center)
      set text(weight: "bold", size: 14pt)
      v(1em)
      if it.numbering != none {
        let num = numbering("I", counter(heading).get().first())
        [BAB #num \ #upper(it.body)]
      } else {
        upper(it.body)
      }
      v(1.2em)
    } else if it.level == 2 {
      // Style "Heading 2": 13pt Bold, Left Aligned, 1.1, Spacing After 0pt
      set align(left)
      set text(weight: "bold", size: 13pt)
      v(1em)
      if it.numbering != none {
        counter(heading).display("1.1 ")
      }
      it.body
      v(0.5em)
    } else if it.level == 3 {
      // Style "Heading 3": 12pt Bold, Black, Left Aligned, 1.1.1, Spacing After 0pt
      set align(left)
      set text(weight: "bold", size: 12pt, fill: black)
      v(0.8em)
      if it.numbering != none {
        counter(heading).display("1.1.1 ")
      }
      it.body
      v(0.4em)
    } else {
      it
    }
  }

  // Pengaturan Caption Figure (Gambar di bawah, Tabel di atas)
  show figure.where(kind: image): it => {
    set align(center)
    it.body
    v(0.5em)
    set text(weight: "bold", size: 12pt)
    it.caption
    v(1em)
  }

  show figure.where(kind: table): it => {
    set align(center)
    set text(weight: "bold", size: 12pt)
    it.caption
    v(0.5em)
    set text(weight: "regular", size: 12pt)
    it.body
    v(1em)
  }

  show figure.where(kind: image): set figure(supplement: [Gambar], numbering: (..nums) => {
    let chapter = counter(heading.where(level: 1)).get().first()
    str(chapter) + "." + str(nums.pos().first())
  })

  show figure.where(kind: table): set figure(supplement: [Tabel], numbering: (..nums) => {
    let chapter = counter(heading.where(level: 1)).get().first()
    str(chapter) + "." + str(nums.pos().first())
  })

  // Pengaturan Penomoran Rumus Matematika di Sisi Kanan: (Bab.Nomor) contoh: (3.1)
  set math.equation(
    numbering: (..nums) => {
      let chapter = counter(heading.where(level: 1)).get().first()
      "(" + str(chapter) + "." + str(nums.pos().first()) + ")"
    }
  )

  // Gaya Tabel Sederhana (Stroke 0.6pt)
  set table(stroke: 0.6pt)

  body
}
