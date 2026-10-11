// =============================================================
// TEMPLATE ENGINE - Proyek Akhir / Proposal Proyek Akhir PENS
//
// File ini berisi SELURUH kode "mesin" template: cover, sistem
// heading, penomoran gambar/tabel/persamaan otomatis, watermark,
// dan front/back matter (Abstrak, Daftar Isi/Gambar/Tabel/Pustaka).
//
// Mahasiswa TIDAK PERLU mengedit file ini. Cukup edit `main.typ`
// (untuk data diri) dan file-file di folder `chapters/` (untuk
// menulis isi buku). Lihat README.md untuk panduan lengkap.
// =============================================================

#let biru = rgb("#002BA6")
#let emas = rgb("#F2CB00")
#let abu  = rgb("#808080")

// -------------------------------------------------------------
// Helper paragraf & elemen kecil yang dipakai di dalam bab-bab
// (chapters/*.typ). Import semuanya lewat:
//   #import "../template.typ": *
// -------------------------------------------------------------

// body paragraph: first line indent 1cm, justified (matches w:ind firstLine=567)
#let bp(body) = par(first-line-indent: (amount: 1cm, all: true), body)

// gap matching an empty Word paragraph (1.5 line spacing blank line)
#let gap = v(0.85em)

// caption helper for citation source line under a figure (kept manual:
// it's prose text, not a numbered/labelled entity)
#let sumber(txt) = align(center)[#text(size: 10pt)[Sumber: #txt]]

// speech-bubble style callout used on the annotated template page
#let callout(body, w: 3.4cm) = box(
  width: w,
  inset: 5pt,
  radius: 3pt,
  stroke: 0.6pt + rgb("#a5a5a5"),
  fill: white,
)[#align(center)[#text(fill: abu, size: 8pt, style: "italic")[#body]]]

// daftar "Bab N <Judul>" + deskripsi, dipakai di 1.6 Sistematika Penulisan
#let bab_item(num, title, body) = {
  grid(columns: (1.5cm, 1fr), [*Bab #num*], [*#title*])
  par(first-line-indent: 0cm, hanging-indent: 0cm)[#h(1.5cm)#body]
  gap
}

// -------------------------------------------------------------
// CATATAN TODO PENULIS
//   #todo[...] menampilkan catatan abu-abu untuk penulis pada status
//   dokumen "draft" (terlihat saat preview), dan
//   OTOMATIS DISEMBUNYIKAN saat document_status = "final".
//   Status dibaca dari state yang di-set di conf() (lihat di bawah),
//   sehingga #todo[...] bisa dipakai langsung di chapters/*.typ.
// -------------------------------------------------------------
#let doc_status_state = state("document_status", "draft")

#let todo(body) = context {
  if doc_status_state.get() != "final" {
    text(fill: abu)[#body]
  }
}

// -------------------------------------------------------------
// WATERMARK  -- lihat dokumentasi document_status di main.typ.
// -------------------------------------------------------------
#let watermark_labels = (
  draft: "DRAFT",
)

// -------------------------------------------------------------
// JENIS UJIAN  -- label prefix judul di halaman kedua. Lihat
// dokumentasi jenis_ujian di main.typ.
// -------------------------------------------------------------
// Prefix yang ditaruh DI ATAS jenis dokumen (cfg.thesis_type) pada
// halaman kedua. "final" tanpa prefix -> hanya menampilkan jenis dokumen.
#let jenis_ujian_labels = (
  proposal: "PROPOSAL",
  progress: "PROGRES",
  final: "",
)

// -------------------------------------------------------------
// JENJANG  -- menentukan gelar yang tercantum di Halaman Pengesahan.
//   "D3"      -> Gelar Ahli Madya Teknik (A.Md.T.)
//   "Sarjana" -> Gelar Sarjana Terapan Teknik (S.T.r.T.)
// Dipilih lewat variabel `jenjang` di main.typ.
// -------------------------------------------------------------
#let gelar_labels = (
  "D3": "Gelar Ahli Madya Teknik (A.Md.T.)",
  "Sarjana": "Gelar Sarjana Terapan Teknik (S.T.r.T.)",
)

// Nama program studi yang mengikuti `jenjang`. Dipakai di dua tempat:
//   1. Cover (halaman 1), baris program studi (huruf besar via #upper).
//   2. Halaman Pengesahan, baris "Mengetahui" (Ketua Program ...).
// Nama jurusan/department (mis. "Teknik Elektronika") tetap diambil
// dari cfg.department.
#let ketua_prodi_labels = (
  "D3": "Program Studi Diploma 3",
  "Sarjana": "Program Studi Sarjana Terapan",
)

// Helper terpisah (bukan hardcode per halaman): menghasilkan satu
// watermark diagonal transparan, dipasang ke semua halaman lewat
// #set page(background: ...) di dalam conf() di bawah.
#let watermark(document_status) = {
  if document_status in watermark_labels {
    place(
      center + horizon,
      rotate(-45deg, text(
        size: 40pt,
        weight: "bold",
        fill: rgb(120, 120, 120, 20%),
      )[#watermark_labels.at(document_status)]),
    )
  }
}

// -------------------------------------------------------------
// HALAMAN PENGESAHAN  -- dikonversi dari Halaman-Pengesahan.docx.
// Dipasang sebagai halaman tersendiri tepat setelah halaman cover
// kedua (lihat pemanggilan di dalam conf() di bawah). Sebagian data
// (judul, nama, NRP, prodi) diambil otomatis dari cfg; bagian
// pembimbing/penguji dibiarkan sebagai isian manual ([...]).
// -------------------------------------------------------------
#let signature_line(role, name, nip: "") = grid(
  columns: (3.2cm, 0.4cm, 1fr, 2.4cm),
  align: (left + bottom, left + bottom, left + bottom, center + bottom),
  row-gutter: 0.2em,
  // ( ~~~~~~~~~ ) = ~9 karakter spasi (non-breaking) sebagai tempat tanda tangan
  role, [:], underline[#name], [(~~~~~~~~~~~~~~~~~~~)],
  [], [], [NIP. #nip], [],
)

// Watermark Halaman Pengesahan -- memakai satu gambar watermark penuh
// halaman (assets/watermark-halaman-pengesahan.png). Gambar ini SUDAH
// berupa watermark full-page yang memudar, jadi tidak perlu di-tile
// maupun ditutup lapisan putih transparan lagi.
#let watermark_pengesahan = image(
  "assets/watermark-halaman-pengesahan.png",
  width: 100%,
  height: 100%,
)

#let halaman_pengesahan(cfg, jenjang: "Sarjana") = page(background: watermark_pengesahan)[
  #set align(center)
  #text(size: 14pt, weight: "bold")[HALAMAN PENGESAHAN]
  #v(0.8cm)
  #text(size: 14pt, weight: "bold")[#upper(cfg.title)]
  #v(0.8cm)
  Oleh: \
  #v(0.2cm)
  #text(weight: "bold")[#cfg.author] \
  #text(weight: "bold")[NRP. #cfg.student_id]
  #v(0.8cm)
  #text(weight: "bold")[
    Proyek Akhir ini digunakan sebagai salah satu syarat untuk memperoleh
    #gelar_labels.at(jenjang, default: gelar_labels.Sarjana) di \
    #cfg.institution
  ]
  #v(0.4cm)
  #text(weight: "bold")[#cfg.year]
  #v(1.0cm)

  #set align(left)
  #text(weight: "bold")[Disetujui oleh:]
  #v(0.6cm)
  #signature_line([Pembimbing 1], cfg.promoter_1, nip: cfg.promoter_1_nip)
  #v(0.4cm)
  #signature_line([Pembimbing 2], cfg.promoter_2, nip: cfg.promoter_2_nip)
  #v(0.4cm)
  #signature_line([Penguji], cfg.examiner_1, nip: cfg.examiner_1_nip)
  #v(0.4cm)
  #signature_line([Penguji], cfg.examiner_2, nip: cfg.examiner_2_nip)
  #v(1.0cm)

  #set align(center)
  #text(weight: "bold")[Mengetahui,]
  #v(1.8cm)
  Ketua #ketua_prodi_labels.at(jenjang, default: cfg.study_program) #cfg.department \
  #cfg.institution
  #v(1.6cm)
  #underline[#cfg.head_of_program] \
  NIP. #cfg.head_of_program_nip
]

// -------------------------------------------------------------
// PERNYATAAN ORISINALITAS  -- dikonversi dari bukuPA.pdf.
// Disisipkan tepat setelah Halaman Pengesahan. Data nama/NRP
// diambil otomatis dari cfg; tempat/tanggal dibiarkan sebagai
// isian manual ([...]).
// -------------------------------------------------------------
#let pernyataan_orisinalitas(cfg) = page[
  #align(center)[#text(size: 14pt, weight: "bold")[PERNYATAAN ORISINALITAS]]
  #v(1.0cm)
  Dengan ini saya menyatakan bahwa bagian atau keseluruhan Proyek Akhir ini:
  #v(0.4cm)
  #enum(
    spacing: 1.0em,
    [Adalah hasil karya sendiri dan tidak mengandung unsur plagiat dari pihak lain,],
    [Tidak pernah diajukan untuk mendapatkan gelar akademis pada suatu Perguruan Tinggi,],
    [Tidak pernah dipublikasikan atau ditulis oleh pihak lain,],
    [Mencantumkan rujukan dan kutipan dengan jujur dan benar terhadap sumber referensi lain yang menunjang pembahasan pada Proyek Akhir ini.],
  )
  #v(0.4cm)
  #bp[Apabila ditemukan bukti bahwa pernyataan saya di atas tidak benar, maka saya bersedia menerima sanksi sesuai dengan ketentuan yang berlaku di #cfg.institution.]
  #v(2.0cm)

  #align(right)[
    Surabaya, .......................... #cfg.year
    #v(2.4cm)
    #underline[#text(weight: "bold")[#cfg.author]] \
    #text(weight: "bold")[NRP. #cfg.student_id]
  ]
]

// -------------------------------------------------------------
// PERNYATAAN PENGALIHAN HAK CIPTA  -- dikonversi dari bukuPA.pdf.
// Disisipkan tepat setelah Pernyataan Orisinalitas.
// -------------------------------------------------------------
#let pernyataan_hak_cipta(cfg) = page[
  #align(center)[#text(size: 14pt, weight: "bold")[PERNYATAAN PENGALIHAN HAK CIPTA]]
  #v(1.0cm)
  Dengan ini, saya yang bertanda tangan di bawah ini:
  #v(0.4cm)
  #grid(
    columns: (4cm, 0.4cm, 1fr),
    row-gutter: 0.6em,
    [Nama], [:], [#cfg.author],
    [NRP], [:], [#cfg.student_id],
    [Judul Proyek Akhir], [:], [#cfg.title],
    [Tanggal], [:], [Surabaya, .......................... #cfg.year],
  )
  #v(0.6cm)
  menyatakan bahwa saya selaku penulis (dan/atau mewakili seluruh penulis) secara
  sadar dan sukarela mengalihkan hak cipta (#emph[copyright]) atas Proyek Akhir tersebut
  kepada #cfg.institution.
  #v(0.4cm)
  Demikian pernyataan ini saya buat dengan sebenar-benarnya dan tanpa paksaan dari
  pihak mana pun.
  #v(1.0cm)
  Hormat saya,
  #v(0.6cm)
  [Materai]
  #v(1.4cm)
  #underline[#text(weight: "bold")[#cfg.author]]
]

// =============================================================
// conf()  --  fungsi utama template.
//
// Dipanggil dari main.typ lewat:
//   #show: doc => conf(cfg: cfg, citation_style: citation_style,
//     show_page2_annotations: show_page2_annotations,
//     document_status: document_status, doc)
//
// "body" (parameter terakhir) adalah seluruh isi bab yang ditulis
// lewat #include "chapters/....typ" di main.typ. conf() membungkus
// body itu dengan cover, heading system, penomoran otomatis, front
// matter (Abstrak/Daftar Isi/Gambar/Tabel), dan back matter
// (Daftar Pustaka) -- supaya main.typ & chapters/*.typ bisa tetap
// bersih dan fokus ke konten saja.
// =============================================================
#let conf(
  cfg: (:),
  citation_style: "ieee",
  show_page2_annotations: false,
  show_daftar_pustaka_guide: false,
  document_status: "final",
  jenis_ujian: "proposal",
  jenjang: "Sarjana",
  body,
) = [
  // Simpan status dokumen ke state agar helper #todo[...] di chapters
  // tahu kapan harus tampil (draft) atau disembunyikan (final).
  #doc_status_state.update(document_status)

  #set page(background: watermark(document_status))

  // Halaman 1 & 2 (cover) sengaja tanpa nomor halaman -- lihat
  // PENOMORAN HALAMAN di bawah untuk romawi (mulai Abstrak) dan
  // arab (mulai BAB 1).
  #set page(numbering: none)

  // ---------- global document defaults (used from page 3 onward) ----------
  #set document(title: cfg.title, author: cfg.author)
  #set page(paper: "a4", margin: 2.54cm)
  #set text(font: "Liberation Serif", size: 12pt, lang: "id")
  #set par(justify: true, leading: 0.85em, spacing: 0.85em)

  // =============================================================
  // HEADING SYSTEM
  //   = BAB n Title            (level 1 -> "BAB 1 Pendahuluan")
  //   == Title                 (level 2 -> "1.1 Latar Belakang")
  //   === Title                (level 3 -> "1.1.1 Aaaa")
  //   ==== Title                (level 4 -> "1.1.1.1 ...")
  // =============================================================
  #set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      "BAB " + str(n.at(0))
    } else {
      numbering("1.1.1.1", ..n)
    }
  })

  #show heading.where(level: 1): it => {
    pagebreak(weak: true)
    // every real chapter (numbered heading) restarts figure/table/equation numbering
    if it.numbering != none {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
    }
    v(0.5em)
    if it.numbering != none [
      // numbered chapter, e.g. "= Pendahuluan" -> two lines, uppercase:
      //   BAB 1
      //   PENDAHULUAN
      #align(center)[
        #text(size: 14pt, weight: "bold")[
          #counter(heading).display(it.numbering)
          #linebreak()
          #upper(it.body)
        ]
      ]
    ] else [
      // unnumbered front/back-matter heading (DAFTAR GAMBAR, dst) -> unchanged
      #align(center)[
        #text(size: 14pt, weight: "bold")[#it.body]
      ]
    ]
    v(0.85em)
  }

  #show heading.where(level: 2): it => {
    gap
    text(weight: "bold")[#counter(heading).display(it.numbering)#h(0.6cm)#it.body]
    gap
  }

  #show heading.where(level: 3): it => {
    gap
    text(weight: "bold")[#counter(heading).display(it.numbering)#h(0.6cm)#it.body]
    gap
  }

  #show heading.where(level: 4): it => {
    gap
    text(weight: "bold")[#counter(heading).display(it.numbering)#h(0.6cm)#it.body]
    gap
  }

  // =============================================================
  // FIGURE / TABLE NUMBERING  ->  "Bab.Urutan", e.g. Gambar 3.1, Tabel 3.2
  // fully automatic: chapter number comes from counter(heading), the
  // running index comes from the per-kind figure counter (auto-reset
  // at every chapter boundary by the heading show rule above).
  // =============================================================
  #set figure(numbering: n => context {
    numbering("1.1", counter(heading).get().at(0, default: 0), n)
  })
  #show figure.where(kind: image): set figure(supplement: "Gambar")
  #show figure.where(kind: table): set figure(supplement: "Tabel")
  #show figure.where(kind: table): set figure.caption(position: top)
  #set figure.caption(separator: ". ")
  #set figure(gap: 0.85em)

  #set math.equation(numbering: n => context {
    numbering("(1.1)", counter(heading).get().at(0, default: 0), n)
  })

  // Typst's outline() recomputes a figure entry's numbering in a context
  // that is not pinned to the figure's own location, which would show the
  // wrong chapter number (always 0) for entries. We fix this by overriding
  // the entry's rendering and resolving every counter explicitly at
  // `it.element.location()`.
  //
  // We also special-case level-1 chapter headings here so "DAFTAR ISI"
  // keeps showing them as ONE line, e.g. "BAB 1 PENDAHULUAN" -- even
  // though the heading itself now renders as two lines on its own page
  // (see the heading show rule above). Sub-headings (level 2/3/4) and
  // unnumbered front/back-matter headings are left completely untouched.
  #show outline.entry: it => {
    if it.element.func() == figure {
      link(
        it.element.location(),
        context {
          let loc = it.element.location()
          let chap = counter(heading).at(loc).at(0, default: 0)
          let n = counter(figure.where(kind: it.element.kind)).at(loc).at(0, default: 0)
          let sup = it.element.supplement
          grid(
            columns: (auto, 1fr, auto),
            column-gutter: 0.3em,
            [#sup #chap.#n#h(0.6em)#it.element.caption.body], repeat[.], it.page(),
          )
        }
      )
    } else if it.element.func() == heading and it.element.level == 1 and it.element.numbering != none {
      let loc = it.element.location()
      let num = numbering(it.element.numbering, ..counter(heading).at(loc))
      link(
        loc,
        grid(
          columns: (auto, 1fr, auto),
          column-gutter: 0.3em,
          [#num #h(0.3em) #upper(it.element.body)], repeat[.], it.page(),
        )
      )
    } else {
      it
    }
  }

  // =============================================================
  // PAGE 1 : COVER "PROYEK AKHIR" (full bleed blue)
  // =============================================================
  #page(paper: "a4", margin: 0pt, fill: white)[
    #stack(
      dir: ttb,
      // ---- white header zone (tinggi 5 cm sesuai cover.pdf) ----
      // logo 3 cm dari kiri, jenis dokumen 3,5 cm dari kanan.
      block(height: 5cm, width: 100%, inset: (left: 3cm, right: 3.5cm, top: 0.6cm))[
        #grid(
          columns: (auto, 1fr),
          align: (left + top, right + horizon),
          // lebar logo ~3,5 cm sesuai panduan cover.pdf
          image(cfg.logo_path, width: 3.5cm),
          // jenis dokumen: SEMUA KAPITAL, 20pt, cetak tebal
          text(fill: biru, weight: "bold", size: 20pt)[#{
            let pfx = jenis_ujian_labels.at(jenis_ujian, default: upper(jenis_ujian))
            if pfx != "" { [#pfx \ ] }
            upper(cfg.thesis_type)
          }],
        )
      ],
      // ---- gold stripe (0,5 cm) ----
      block(height: 0.5cm, width: 100%, fill: emas),
      // ---- blue body ----
      block(height: 24.2cm, width: 100%, fill: biru, inset: (left: 2cm, right: 2cm, top: 0.4cm))[
        #set text(fill: white)
        #set align(center)
        #v(1.0cm)
        // Judul: SEMUA KAPITAL, 18pt, cetak tebal
        #text(size: 18pt, weight: "bold")[#upper(cfg.title)]
        #v(2.4cm)
        // Nama & NRP: 16pt, cetak tebal
        #text(size: 16pt, weight: "bold")[#cfg.author] \
        #text(size: 16pt, weight: "bold")[#cfg.student_id]
        #v(1.6cm)
        // DOSEN PEMBIMBING: SEMUA KAPITAL, 16pt, cetak tebal
        #text(size: 16pt, weight: "bold")[DOSEN PEMBIMBING]
        #v(0.6em)
        #text(size: 16pt, weight: "bold")[#cfg.promoter_1] \
        #text(size: 16pt, weight: "bold")[NIP. #cfg.promoter_1_nip]
        #v(0.6cm)
        #text(size: 16pt, weight: "bold")[#cfg.promoter_2] \
        #text(size: 16pt, weight: "bold")[NIP. #cfg.promoter_2_nip]
        #v(2.4cm)
        // Program studi/jurusan: SEMUA KAPITAL, 16pt, cetak tebal
        #text(size: 16pt, weight: "bold")[
          #upper(ketua_prodi_labels.at(jenjang, default: cfg.study_program)) \
          #upper(cfg.department) \
          JURUSAN TEKNIK ELEKTRO
        ]
        #v(0.6cm)
        #text(size: 16pt, weight: "bold")[
          #upper(cfg.institution) \
          #cfg.year
        ]
      ],
    )
  ]

  // =============================================================
  // PAGE 2 : "PROPOSAL PROYEK AKHIR" cover template with annotation
  // callouts (the speech-bubble notes explaining font rules)
  // =============================================================
  #set page(paper: "a4", margin: 2.54cm)
  #set text(size: 12pt)

  #box(width: 100%)[
    #grid(
      columns: (2.4cm, 1fr),
      // Posisi label disamakan persis dengan halaman pertama: logo kiri-atas,
      // jenis dokumen rata kanan-atas (bukan rata tengah).
      align: (left + top, right + top),
      image(cfg.logo_path, width: 2.3cm),
      text(size: 24pt, weight: "bold")[#{
        let pfx = jenis_ujian_labels.at(jenis_ujian, default: upper(jenis_ujian))
        if pfx != "" { [#pfx \ ] }
        upper(cfg.thesis_type)
      }],
    )
    #if show_page2_annotations [#place(top + right, dx: 0.3cm, dy: -0.6cm)[#callout(w: 3.6cm)[Times 24 point Bold]]]
    #if show_page2_annotations [#place(top + left, dx: -2.35cm, dy: 0.3cm)[#callout(w: 2.25cm)[Ukuran A4, kertas 70 gr, warna putih]]]
  ]

  #v(0.6cm)
  #box(width: 100%)[
    #align(center)[#text(size: 20pt, weight: "bold")[#upper(cfg.title)]]
    #if show_page2_annotations [#place(top + right, dx: 0cm, dy: -0.3cm)[#callout(w: 3.9cm)[Font Times 16 point Bold, Semua huruf besar]]]
  ]

  #v(1.8cm)

  #box(width: 100%)[
    #align(center)[
      #text(size: 14pt, weight: "bold")[#cfg.author] \
      #text(size: 14pt)[#cfg.student_id]
    ]
    #if show_page2_annotations [#place(top + right, dx: 0cm, dy: -0.1cm)[#callout(w: 4.0cm)[Font Times 14 point Bold, Awal kata huruf besar]]]
    #if show_page2_annotations [#place(top + left, dx: -2.35cm, dy: 0.45cm)[#callout(w: 2.25cm)[Font Times 14 point]]]
  ]

  #v(1.4cm)

  #box(width: 100%)[
    #align(center)[
      #text(size: 14pt, weight: "bold")[DOSEN PEMBIMBING] \
      #text(size: 14pt)[Nama #cfg.promoter_1] \
      #text(size: 14pt)[NIP. #cfg.promoter_1_nip]
      #v(1em)
      #text(size: 14pt)[Nama #cfg.promoter_2] \
      #text(size: 14pt)[NIP. #cfg.promoter_2_nip]
    ]
    #if show_page2_annotations [#place(top + right, dx: 0cm, dy: 0.1cm)[#callout(w: 3.9cm)[Font Times 14 point Bold, Semua huruf besar]]]
    #if show_page2_annotations [#place(top + right, dx: -1.2cm, dy: 1.0cm)[#callout(w: 3.0cm)[Nama lengkap dan gelar, Font Times 14 point Bold, Awal kata huruf besar]]]
  ]

  #v(2.4cm)

  #align(center)[
    #text(size: 14pt, weight: "bold")[
      #upper(ketua_prodi_labels.at(jenjang, default: cfg.study_program)) \
      #upper(cfg.department) \
      JURUSAN TEKNIK ELEKTRO
    ]
    #v(0.6cm)
    #text(size: 14pt, weight: "bold")[
      #upper(cfg.institution) \
      #cfg.year
    ]
  ]

  #pagebreak()

  // =============================================================
  // HALAMAN PENGESAHAN, PERNYATAAN ORISINALITAS & PERNYATAAN
  // PENGALIHAN HAK CIPTA (dikonversi dari bukuPA.pdf).
  // HANYA ditampilkan saat jenis_ujian = "final"; pada
  // "proposal"/"progress" ketiga halaman ini disembunyikan.
  // Disisipkan tepat setelah halaman cover kedua, masih tanpa
  // nomor halaman.
  // =============================================================
  #if jenis_ujian == "final" {
    halaman_pengesahan(cfg, jenjang: jenjang)
    pernyataan_orisinalitas(cfg)
    pernyataan_hak_cipta(cfg)
  }

  // =============================================================
  // PENOMORAN HALAMAN -- mulai romawi (i, ii, iii, ...) dari halaman
  // ini (Abstrak) sampai sebelum BAB 1. Lihat lagi di bawah, tepat
  // sebelum #body, untuk peralihan ke angka arab mulai BAB 1.
  // =============================================================
  #set page(numbering: "i")
  #counter(page).update(1)

  // =============================================================
  // ABSTRAK -- dua halaman: Bahasa Indonesia (chapters/abstrak.typ)
  // lalu terjemahan Inggris/ABSTRACT (chapters/abstract.typ).
  // =============================================================
  #include "chapters/abstrak.typ"

  #pagebreak()

  #include "chapters/abstract.typ"

  #pagebreak()

  // =============================================================
  // KATA PENGANTAR -- isinya ditulis di chapters/kata-pengantar.typ.
  // =============================================================
  #include "chapters/kata-pengantar.typ"

  #v(1.2cm)

  #pagebreak()

  // =============================================================
  // DAFTAR ISI (auto-generated outline, depth 3 / "===")
  // =============================================================
  #align(center)[#text(size: 20pt, weight: "bold")[DAFTAR ISI]]
  #v(0.5cm)
  #outline(title: none, depth: 3, indent: auto)

  #pagebreak()

  // =============================================================
  // DAFTAR GAMBAR / DAFTAR TABEL (fully automatic, from figure() captions)
  // =============================================================
  #heading(level: 1, numbering: none, outlined: true)[DAFTAR GAMBAR]
  #outline(title: none, target: figure.where(kind: image))

  #pagebreak()
  #heading(level: 1, numbering: none, outlined: true)[DAFTAR TABEL]
  #outline(title: none, target: figure.where(kind: table))

  #pagebreak()

  // =============================================================
  // PENOMORAN HALAMAN -- mulai angka arab (1, 2, 3, ...) lagi dari
  // BAB 1 dan seterusnya (termasuk Daftar Pustaka di akhir).
  // =============================================================
  #set page(numbering: "1")
  #counter(page).update(1)

  // =============================================================
  // ISI BUKU -- seluruh bab dari chapters/*.typ disisipkan di sini
  // =============================================================
  #body

  // =============================================================
  // DAFTAR PUSTAKA
  //
  // Workflow:
  // 1. Tambahkan referensi ke file references.bib
  // 2. Sitasi di dalam naskah dengan:
  //
  //    #cite(<key>)
  //
  // 3. Daftar pustaka akan dibuat otomatis.
  //
  // Contoh:
  //
  //    #cite(<smith2022>)
  //    #cite(<wang2023>)
  // =============================================================
  #pagebreak()

  #heading(
    level: 1,
    numbering: none,
    outlined: true,
  )[DAFTAR PUSTAKA]

  // -----------------------------------------------------------
  // Teks panduan penulisan Daftar Pustaka.
  // Ini HANYA panduan untuk mahasiswa. Cara mematikannya: set
  // `show_daftar_pustaka_guide: false` di main.typ (atau hapus
  // baris itu). Tidak perlu mengubah teks di file ini.
  // -----------------------------------------------------------
  #if show_daftar_pustaka_guide [
    Daftar Pustaka memuat semua referensi yang dipakai pada Penelitian Terkait (F), Teori Penunjang (G) dan Desain Sistem (H). Nama pustaka secara berurutan dituliskan sebagai berikut: Nama peneliti/pengarang, Judul, Nama publikasi (disertai volume/nomer/halaman), penerbit (jika buku) dan tahun. Daftar Pustaka ditulis berdasarkan urutan nama peneliti/pengarang, dan diikuti tahun dan judul jika didapatkan nama peneliti/pengarang yang sama. Berikut contoh sistematika penulisan Daftar Pustaka:

    #set par(first-line-indent: 0pt)
    Nama_Pengarang1, Nama_Pengarang2, Judul Makalah Jurnal Internasional atau Nasional, Nama Jurnal, Vol. xx, No. yy, Hal. aa-bb, Penerbit, Tahun.

    Nama_Pengarang1, Nama_Pengarang2, Judul Makalah Seminar Internasional atau Nasional, Nama Seminar, Tempat, Hal. aa-bb, Tahun.

    Nama_Pengarang1, Nama Pengarang2, Judul Buku Acuan, Penerbit, Edisi xx, Tahun.

    Nama_Mahasiswa_Penulis, Judul Buku Proyek Akhir, Proyek Akhir/Tugas Akhir/Skripsi, Perguruan Tinggi, Tahun.

    Nama_Penulis, Judul Tulisan pada Media Publik, Nama Media Publik, Tanggal/Bulan...., Edisi, Tahun.

    Nama_Penulis, Judul Tulisan pada Media Online, Wikipedia/Nama Ensiklopedia online atau Nama Blog, Alamat internet, Diakses tanggal., Tahun
  ]

  #bibliography(
    "references.bib",
    title: none,
    style: citation_style,
  )

  // =============================================================
  // LAMPIRAN -- isinya ditulis di chapters/lampiran.typ.
  // Diletakkan paling akhir, setelah Daftar Pustaka. Hanya tampil
  // pada tahap progres/final; saat jenis_ujian = "proposal"
  // Lampiran (bersama BAB 4 & BAB 5) disembunyikan.
  // =============================================================
  #if jenis_ujian != "proposal" {
    pagebreak()
    include "chapters/lampiran.typ"
  }
]
