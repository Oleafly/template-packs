#let cover(title, authors, note, date, content) = {

  set text(font: "Times New Roman", size: 12pt)
  set page(paper: "a4", numbering: none, margin: (left: 4cm, bottom: 4cm, top: 3cm, right: 3cm))
  set par(justify: true, first-line-indent: (amount: 0.5in, all: true))
  set list(indent: 0.5in)
  set enum(indent: 0.5in)
  set image(width: 39%)
  set text(lang: "id")
  align(center + top)[#text(size: 16pt, weight: "bold")[#upper()[#title]]]
  align(center + horizon)[
    #text()[#note]
    #pad(y: 2cm)[

      #figure(image("./asset/logouny.svg", width: 50%))
    ]
    #box[
      #text()[Disusun oleh:\
      #align(left + top)[
        #block()[ #for author in (authors) {
          text()[#author.name (#author.nim)\ ]
        }]
      ] ]
    ]
  ]

  align(center + bottom, text(size: 14pt, weight: "bold")[ PENGANTAR ILMU BAHAN\
  TEKNIK ELEKTRO\
  UNIVERSITAS NEGERI YOGYAKARTA\
  #date])
  pagebreak()
  set page(numbering: "1")

  outline()
  counter(page).update(1)
  pagebreak()

  show heading.where(level: 1): set heading(numbering: (..n) => "BAB " + numbering("I", ..n) + ": ");
  show heading.where(level: 1): set text(size: 14pt)

  show ref: it => {
    let el = it.element // Get the referenced element
    // Check if the element is a heading of level 1
    if el == none or el.func() != heading or el.level != 1 {
      return it // Fallback for other reference types
    }
    // Get the heading levels as an array
    let heading-levels = counter(heading).at(el.location())
    // Format the body of the reference using the supplement and numbers
    let body = "BAB " + numbering("I", ..heading-levels)
    // Create a link to the element's location with the custom body
    link(el.location(), body)
  }

  show heading.where(level: 2): set heading(numbering: "1.1");
  show heading.where(level: 2): set text(size: 12pt)

  set math.equation(numbering: none)
  show par: set par(spacing: 1.5em)

  show figure.where(kind: table): set figure(supplement: "Tabel")
  show figure.where(kind: image): set figure(supplement: "Gambar")

  show <pendahuluan> : text()[Pendahuluan]

  align(center)[#heading(level: 1)[Pendahuluan] <pendahuluan>]
  counter(heading).update(1)

  content

  set heading(numbering: none)
  show heading.where(level: 1): set heading(numbering: none);
  bibliography("./reference.yaml", full: true, style: "apa")
}
