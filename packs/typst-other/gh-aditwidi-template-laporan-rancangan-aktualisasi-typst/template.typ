/*
  Function: rancanganAktualisasiTemplate
  Description: Initializes the document with Laporan Hasil Aktualisasi formatting.
               Sets up margins, base typography, paragraph spacing, and
               generates the standard cover page.
  Parameters:
    - coverTitle (string): The title on the cover page.
    - coverSubTitle (string): The subtitle on the cover page.
    - rancanganTitle (string): The title of the laporan.
    - nama (string): The full name of the participant.
    - nip (string): The participant's NIP.
    - jabatan (string): The participant's position.
    - satker (string): The participant's work unit.
    - golongan (string): The participant's rank.
    - angkatan (string): The training batch.
    - tahun (string): The year.
    - institution (string): The institution name.
    - submissionDate (string): The date of submission.
    - bodyContent (content): The entire body of the document.
  Returns:
    - Content: The fully formatted Typst document including the cover page and frontmatter.
*/
#import "@preview/numbly:0.1.0": numbly

#let rancanganAktualisasiTemplate(
  coverTitle: "",
  coverSubTitle: "",
  rancanganTitle: "",
  nama: "",
  nip: "",
  jabatan: "",
  satker: "",
  golongan: "",
  angkatan: "",
  tahun: "",
  institution: "",
  submissionDate: "",
  bodyContent,
  appendixPage: none,
) = {
  // 1. Pengaturan Halaman (Page Setup)
  // Mengatur margin 4-3-4-3 cm dan penomoran halaman romawi kecil di footer.
  set page(
    paper: "a4",
    margin: (left: 4cm, right: 3cm, top: 4cm, bottom: 3cm),
    numbering: "i",
    number-align: center,
    footer: context [
      #align(center)[
        #line(length: 100%, stroke: 0.5pt)
        #counter(page).display("i")
      ]
    ],
  )
  show title: set text(14pt)
  show title: set par(leading: 12pt)
  // show title: set (12pt)

  // 2. Pengaturan Teks (Text Setup)
  // Menggunakan Times New Roman ukuran 12pt sebagai standar naskah.
  set text(font: "Arial", size: 11pt, lang: "id")

  // 3. Pengaturan Paragraf (Paragraph Setup)
  // 1.5 spasi: ~0.65em leading pada 11pt
  set par(justify: true, leading: 1em)
  // show par: set block(spacing: 1.3em)

  // 4. Pengaturan Judul (Heading Setup)
  // Judul Bab (Level 1): Ukuran 14pt, cetak tebal, simetris di tengah.
  show heading.where(level: 1): chapterHeading => {
    pagebreak(weak: true)
    set text(size: 12pt, weight: "bold")
    set align(center)
    v(1em)
    chapterHeading
  }
  // 5. Pembuatan Halaman Sampul (Cover Page Generation)
  set page(numbering: none, footer: none)
  set text(font: "Arial", size: 14pt)
  set par(leading: 0.4em, justify: false)
  align(center)[
    #block(height: 100%)[
      // Logo BPS di bagian paling atas sampul
      #v(-1cm)
      #image("Figure/Logo BPS.png", width: 3cm)

      #text(weight: "bold", size: 14pt)[#coverTitle] \ \
      #text(weight: "bold", size: 12pt)[#coverSubTitle] \
      #text(weight: "bold", size: 12pt)[#institution] \
      #v(4cm)
      #block(width: 12cm)[#text(weight: "bold", size: 12pt)[#rancanganTitle]] \ \
      #v(2cm)
      #text(size: 12pt)[Oleh:] \
      #text(weight: "bold", size: 12pt)[#underline[#nama]] \
      #text(weight: "bold", size: 12pt)[NIP. #nip]\
      #v(0.1cm)
      #text(weight: "bold", size: 11.5pt)[#jabatan pada #satker]

      #v(1fr)

      #text(weight: "bold", size: 12pt)[#institution] \
      #text(weight: "bold", size: 11pt)[BEKERJASAMA DENGAN] \
      #text(weight: "bold", size: 12pt)[LEMBAGA ADMINISTRASI NEGARA] \
      #text(weight: "bold", size: 12pt)[PELATIHAN DASAR CALON PNS GOLONGAN #golongan BPS ANGKATAN #angkatan] \
      #text(weight: "bold", size: 12pt)[JAKARTA, TAHUN #tahun]
    ]
  ]

  pagebreak()
  set page(numbering: "i", number-align: center)
  set page(footer: context [
    #align(center)[
      #line(length: 100%, stroke: 0.5pt)
      #counter(page).display("i")
    ]
  ])
  counter(page).update(1)
  set text(size: 11pt, weight: "regular")
  set par(leading: 1em, justify: true)

  bodyContent

  if appendixPage != none {
    pagebreak()
    appendixPage
  }
}



/*
  Function: setupMainBody
  Description: Resets the page numbering system from Roman numerals (used in frontmatter)
               to Arabic numerals (used in the main chapters) starting at page 1.
  Parameters:
    - bodyContent (content): The structural content of the main thesis chapters.
  Returns:
    - Content: The document section equipped with Arabic page numbering.
*/
#let setupMainBody(bodyContent) = {
  // Pengaturan Penomoran Halaman ke Angka Arab
  set page(
    numbering: "1",
    footer: context [
      #align(center)[
        #line(length: 100%, stroke: 0.5pt)
        #counter(page).display("1")
      ]
    ],
  )
  counter(page).update(1)

  set par(
    spacing: 1.5em,
    // Menggeser badan paragraf agar sejajar dengan huruf pertama teks heading
    hanging-indent: 1.5em,
    // Indentasi baris pertama = hanging-indent + 2em
    // (dijumlah manual karena Typst menghitung keduanya dari margin, bukan saling menambah)
    first-line-indent: (amount: 3.5em, all: true),
  )

  // Daftar bernomor/bullet mengikuti hanging-indent paragraf
  show enum: it => pad(left: 1.5em, it)
  show list: it => pad(left: 1.5em, it)

  // Pengaturan Penomoran Heading (BAB I, A, 1)
  set heading(numbering: (n, ..rest) => {
    let total = rest.pos().len() + 1
    if total == 1 {
      [BAB #numbering("I", n)]
    } else if total == 2 {
      [#numbering("A", rest.pos().first()).]
    } else {
      numbering("A.1", rest.pos().first(), rest.pos().last())
    }
  })

  // Pengaturan Keterangan (Caption) Tabel dan Gambar
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.caption: set text(size: 12pt)
  show figure.where(kind: table): set block(breakable: true)

  // set figure(kind: image, supplement: "Gambar")
  // set figure(kind: table, supplement: "Tabel")
  //
  // Pengaturan format tabel
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center } else { left }
    ),
  )
  // Format penomoran objek (Bab.NomorObjek) menggunakan angka Arab
  set figure(numbering: figureNumber => {
    let chapterNumber = counter(heading).get().first()
    [#numbering("1.1", chapterNumber, figureNumber).]
  })
  set figure.caption(separator: [ ])

  // Format penomoran Persamaan (Equation)
  set math.equation(
    numbering: (..nums) => {
      let chapterNumber = counter(heading).get().first()
      numbering("(1.1)", chapterNumber, nums.pos().first())
    },
    block: true,
  )
  //
  // Kustomisasi Heading Level 1 (Bab)
  show heading.where(level: 1): chapterHeading => {
    pagebreak(weak: true)
    let isAppendix = chapterHeading.supplement == [Lampiran]
    set text(size: 14pt, weight: "bold")
    // Judul BAB rata tengah, judul Lampiran rata kiri.
    set align(if isAppendix { left } else { center })
    v(1em)

    // Mengevaluasi apakah heading saat ini diatur untuk memiliki nomor
    if chapterHeading.numbering != none {
      // Mereset penghitung objek hanya saat memasuki bab bernomor baru
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)

      // Mengambil dan merender nomor bab/lampiran
      let currentChapterNumber = counter(heading).display(chapterHeading.numbering)
      if isAppendix {
        [LAMPIRAN #currentChapterNumber #chapterHeading.body]
      } else {
        [#currentChapterNumber #chapterHeading.body]
      }
    } else {
      // Jika numbering adalah 'none' (misal: Daftar Pustaka), cetak teks apa adanya
      chapterHeading.body
    }

    v(1.5em)
  }

  // Kustomisasi Heading Level 2 (Anak Bab)
  show heading.where(level: 2): subHeading => {
    set text(size: 12pt, weight: "bold")
    v(0.5em)
    subHeading
    v(0.5em)
  }

  // Kustomisasi Heading Level 2 (Anak Bab)
  show heading.where(level: 3): subHeading => {
    set text(size: 12pt, weight: "regular")
    // v(0.5em)
    subHeading
    v(0.5em)
  }

  bodyContent
}


/**
 * Menghasilkan Daftar Lampiran secara otomatis berdasarkan indeks heading.
 * Setiap entri menampilkan format "Lampiran 1", "Lampiran 2", dst.
 * dan tertaut ke halaman lampiran terkait.
 */
#let generateDaftarLampiran() = {
  heading(level: 1, numbering: none)[DAFTAR LAMPIRAN]
  v(1cm)
  context {
    let entries = query(
      heading.where(level: 1).and(heading.where(supplement: [Lampiran]))
    )
    for (i, entry) in entries.enumerate() {
      let num = i + 1
      let pageNum = counter(page).at(entry.location()).first()
      link(label("lamp-" + str(num)))[LAMPIRAN #num. #entry.body]
      box(width: 1fr, repeat([.], gap: 0.15em))
      [#pageNum]
      parbreak()
    }
  }
}

/**
 * Membungkus konten lampiran (Lampiran.typ) agar heading level 1/2 yang ditulis
 * langsung (misal: "= Judul Lampiran") otomatis diberi penomoran numerik
 * (1, 1.1, 2, 2.1, dst.) dan dikenali sebagai "Lampiran" oleh Daftar Lampiran,
 * persis seperti cara BAB 1-3 ditulis pada tubuh utama.
 * @param bodyContent Seluruh isi berkas Lampiran.typ (heading + konten lampiran).
 */
#let setupAppendixBody(bodyContent) = {
  // Orientasi landscape untuk seluruh halaman lampiran.
  // Margin: top 4cm (sisi jilid), bottom 3cm, left 4cm, right 3cm.
  set page(flipped: true, margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm))

  // Style tautan: warna biru dan bergaris bawah
  show link: it => text(fill: blue, underline(it.body))

  // Reset indentasi paragraf yang terbawa dari setupMainBody
  // (first-line-indent dan hanging-indent tidak diperlukan di lampiran)
  set par(first-line-indent: 0pt, hanging-indent: 0pt)

  set heading(numbering: "1.1", supplement: [Lampiran])
  // Sub-heading lampiran tidak muncul di Daftar Isi, hanya "LAMPIRAN" utama.
  set heading(outlined: false)
  // Penghitung heading direset agar penomoran lampiran dimulai dari 1,
  // terlepas dari berapa banyak BAB yang mendahuluinya.
  counter(heading).update(0)
  set figure(numbering: figureNumber => {
    let chapterNumber = counter(heading).get().first()
    [#numbering("1.1", chapterNumber, figureNumber).]
  })
  set figure.caption(separator: [ ])
  show figure.where(kind: table): set block(breakable: true)
  show table: set block(breakable: true)

  // Override aturan heading level 1 untuk lampiran.
  // Setiap lampiran dimulai pada halaman baru — pagebreak ditambahkan
  // secara eksplisit di masing-masing file lampiran (lampiran2, lampiran3, …)
  // agar lampiran terakhir tidak menyisakan halaman kosong.
  show heading.where(level: 1): chapterHeading => {
    let isAppendix = chapterHeading.supplement == [Lampiran]
    set text(size: 14pt, weight: "bold")
    set align(if isAppendix { left } else { center })
    v(1em)

    if chapterHeading.numbering != none {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)

      let currentChapterNumber = counter(heading).display(chapterHeading.numbering)
      if isAppendix {
        [LAMPIRAN #currentChapterNumber #chapterHeading.body]
      } else {
        [#currentChapterNumber #chapterHeading.body]
      }
    } else {
      chapterHeading.body
    }

    v(1.5em)
  }

  bodyContent
}
