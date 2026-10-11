#let gemastik(
  title: [Judul Makalah],
  authors: (),
  abstract: none,
  index-terms: (),
  paper-size: "a4",
  bibliography: none,
  figure-supplement: [Gambar],
  short-title: none,
  footer-text: "Volume 1 Nomor 1 September 2024",
  body,
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.name))

  // Set the body font.
  set text(font: "Times New Roman", size: 10pt)

  // Disable hyphenation for the entire document.
  set text(hyphenate: false)

  // Enums numbering
  set enum(numbering: "1)a)i)")

  // Tables & figures
  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top, separator: [\ ])
  show figure.where(kind: table): set text(size: 9pt)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  show figure.where(kind: image): set text(font: "Helvetica", size: 7pt)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set text(font: "Times New Roman", size: 8pt)
  show figure.caption.where(kind: table): set align(center)
  show figure.where(kind: table): set figure(supplement: [Tabel])

  set figure.caption(separator: [. ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [Tabel] else if fig.kind == image [Gambar] else [#fig.supplement]
    )
    
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))

    if fig.kind == image {
      show figure.caption: it => block[#strong[#prefix~#numbers#it.separator]#it.body]
      fig
    } else {
      show figure.caption: it => block[#strong[#prefix~#numbers#it.separator]#it.body]
      show figure.caption.where(kind: table): smallcaps
      fig
    }
  }

  // Code blocks
  show raw: set text(
    font: "Courier New",
    ligatures: false,
    size: 1em / 0.8,
    spacing: 100%,
  )

  // Configure the page and multi-column properties.
  set columns(gutter: 7.1mm)
  set page(
    columns: 2,
    paper: paper-size,
    margin: (
      top: 23mm,
      bottom: 18mm,
      left: 13mm,
      right: 13mm,
    ),
    header-ascent: 20%,
    header: context {
      let page-num = counter(page).get().first()
      let align-dir = if calc.odd(page-num) { left } else { right }

      set align(align-dir)
      block(width: 100%, {
        set align(align-dir)
        set par(leading: 0.3em)
        text(
          font: "Helvetica",
          size: 9pt,
          weight: "bold",
          // fill: rgb("#666666"),
          [#h(2pt) BULETIN PAGELARAN MAHASISWA NASIONAL BIDANG TEKNOLOGI INFORMASI DAN KOMUNIKASI],
        )
        linebreak()
        text(font: "Helvetica", size: 7pt, 
        // fill: rgb("#666666"), 
        [#h(2pt) ISSN: xxxxxx])
        v(-3pt)
        line(length: 100%, stroke: 0.5pt 
        // + rgb("#a0a0a0")
      )
      })
    },
    footer-descent: 20%,
    footer: context {
      let page-num = counter(page).get().first()
      let is-odd = calc.odd(page-num)

      let author-name = if authors.len() > 0 { authors.first().name } else { "Ketua Tim" }
      let short-t = if short-title != none { short-title } else {
        "Empat kata pertama judul makalah diikuti titik-titik (...)"
      }

      let p1 = [#author-name: #short-t]
      let p2 = footer-text

      let (left-text, right-text) = if is-odd { (p1, p2) } else { (p2, p1) }

      set text(font: "Helvetica", size: 8pt, 
      // fill: rgb("#666666")
    )
      grid(
        columns: (1fr, 1fr),
        align(left)[#left-text], align(right)[#right-text],
      )
    },
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location()),
      ))
    } else {
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "I.A.1") // knp ini kaga bab IV yg bagian "dijelaskan pada ... memungkinkan model untuk mendapatkan laten" // ooh nvm fixed om, eh belom deng, IV.J sekarang niger // eh ngga deng im retarded ok don fixed
  show heading: it => {
    let levels = counter(heading).get()
    let deepest = if levels != () { levels.last() } else { 1 }

    set text(font: "Helvetica", size: 9pt)
    if it.level == 1 {
      // First-level headings are bold, ALL CAPS, left aligned.
      let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [Referensi], [REFERENSI])
      set align(left)
      show: block.with(above: 15pt, below: 10pt, sticky: true)
      set text(weight: "bold")

      if it.numbering != none and not is-ack {
        numbering("I.", deepest)
        h(7pt, weak: true)
      }
      upper(it.body)
    } else if it.level == 2 {
      // Second-level headings are bold, italic, left aligned
      set text(weight: "bold", style: "italic")
      show: block.with(above: 10pt, below: 10pt, sticky: true)
      if it.numbering != none {
        numbering("A.", deepest)
        h(7pt, weak: true)
      }
      upper(it.body)
    } else [
      // Third level headings are italic, left aligned
      #set text(style: "italic")
      #block(above: 10pt, below: 10pt, sticky: true)[
        #if it.numbering != none {
          numbering("1)", deepest)
          h(7pt, weak: true)
        }
        #upper(it.body)
      ]
    ]
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      // level 1 or 2 can be "Bab", everything deeper is "Sub-bab"
      // adjust the level threshold depending on how you structure your doc!
      let prefix = if el.level == 1 { "Bab" } else { "Subbab" }
      
      // calculate the actual numbers for this specific heading!
      let nums = numbering(el.numbering, ..counter(heading).at(el.location()))
      
      link(el.location(), [#prefix #nums])
    } else {
      it
    }
  }

  // Style bibliography.
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(
    title: text(font: "Helvetica", size: 9pt, weight: "bold")[REFERENSI],
    style: "ieee",
  )

  // Display the paper's title and authors at the top
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 12pt,
    {
      // Title
      set align(center)
      set par(leading: 0.5em)
      v(10pt)
      text(font: "Helvetica", size: 20pt, weight: "bold", title)
      v(-12pt)

      // Display the authors list on a single line
      let author-strings = ()
      for (i, author) in authors.enumerate() {
        author-strings.push([#author.name#super(str(i + 1))])
      }
      text(font: "Helvetica", size: 9pt, weight: "bold", author-strings.join(", "))
      v(-2pt)

      // Display affiliations
      set text(font: "Times New Roman", size: 7pt)
      set par(leading: 0.4em)
      for (i, author) in authors.enumerate() {
        let parts = ()
        if "department" in author { parts.push(author.department) }
        if "organization" in author { parts.push(author.organization) }
        if "location" in author { parts.push(author.location) }
        if "email" in author {
          if type(author.email) == str {
            parts.push([email: #link("mailto:" + author.email)[#author.email]])
          } else {
            parts.push([email: #author.email])
          }
        }
        [#super(str(i + 1))#parts.join(", ")]
        linebreak()
      }

      v(-4pt)
      // Corresponding author (assuming first author)
      if authors.len() > 0 [
        #set align(center)
        #emph[Corresponding Author]: #authors.at(0).name
      ]

      v(12pt)

      // Display abstract and index terms full width
      if abstract != none {
        set align(left)
        set par(justify: true, first-line-indent: 0pt, spacing: 0.45em, leading: 0.45em)

        [#text(font: "Helvetica", size: 9pt, weight: "bold")[INTISARI] #h(3pt) *---* #h(3pt) #text(font: "Times New Roman", size: 10pt)[#abstract]]

        v(10pt)

        if index-terms != () {
          parbreak()
          [#text(font: "Helvetica", size: 9pt, weight: "bold")[KATA KUNCI] #h(3pt) *---* #h(3pt) #text(font: "Times New Roman", size: 10pt)[#index-terms.join[, ]]]
        }
        v(5pt)
      }
    },
  )

  set par(justify: true, first-line-indent: (amount: 1em, all: true), spacing: 0.5em, leading: 0.5em)

  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography != none {
    bibliography
  }
}
