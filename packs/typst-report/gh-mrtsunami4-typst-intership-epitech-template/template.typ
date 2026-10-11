#let part_page(title, preamble: none) = {
  page(
    margin: 2.5cm,
    header: none,
    footer: none,
  )[
    #set text(font: "DejaVu Sans")
    #v(1fr)
    #align(center)[
      #text(size: 32pt, weight: "bold", fill: rgb("#013afb"), title)
      #v(0.5cm)
      #line(length: 20%, stroke: 2pt + rgb("#013afb"))
      #if preamble != none {
        v(1cm)
        text(size: 14pt, preamble)
      }
    ]
    #v(1fr)
  ]
}

#let internship_report(
  title: "",
  author: "",
  email: "",
  company_name: "",
  company_logo: none,
  university_name: "Epitech",
  university_logo: none,
  footer_university_logo: none,
  supervisors: (),
  dates: "",
  abstract: none,
  acknowledgements: none,
  body,
) = {
  // Variables
  let brand-color = rgb("#013afb")
  let brand-color-light = brand-color.lighten(95%)
  let bg-light = rgb("#f4f6fd")
  let font-sans = "DejaVu Sans"
  let font-serif = "Libertinus Serif"
  let margin-side = 2.5cm
  let margin-v = 2.5cm
  let page-width = 21cm

  // --- Document Metadata ---
  set document(title: title, author: author)

  // --- Title Page Setup ---
  set page(paper: "a4", margin: 0pt, fill: none)

  set text(font: font-sans, weight: "medium")

  // Bi-color cover page using grid
  grid(
    columns: 1fr,
    rows: (1fr, 1fr),
    fill: (x, y) => if y == 0 { brand-color } else { none },
    align: center + horizon,

    // Top cell (blue background)
    grid.cell(inset: (left: margin-side, right: margin-side, top: 3cm, bottom: 1.5cm))[
      #set text(fill: white)
      #grid(
        columns: (1fr, 1fr),
        align(left)[
          #if university_logo != none { image(university_logo, width: 4cm) } else {
            text(weight: "bold", university_name)
          }
        ],
        align(right)[
          #if company_logo != none { image(company_logo, width: 4cm) } else { text(weight: "bold", company_name) }
        ],
      )
      #v(5cm)
      #align(center)[#text(size: 36pt, weight: "bold", title)]
    ],

    // Bottom cell (white background)
    grid.cell(inset: (left: margin-side, right: margin-side, bottom: 3cm, top: 0pt))[
      #set text(fill: black)
      #v(2cm)
      #align(center)[
        #text(size: 24pt, weight: "semibold", author)
        #v(0.2cm)
        #text(size: 16pt, email)
        #v(0.2cm)
        #text(size: 14pt, style: "italic", fill: rgb("#444444"), dates)
      ]
      #v(1fr)
      #align(left)[
        #set text(size: 11pt)
        #text(weight: "bold", fill: brand-color)[Supervisors / Mentors] \
        #v(1mm)
        #for sup in supervisors [
          #h(0.5em) #sup \
        ]
      ]
    ],
  )

  pagebreak()

  // --- Main Document Page Setup ---
  set page(
    fill: none,
    margin: (top: 3.5cm, bottom: 3.5cm, left: margin-side, right: margin-side),
    header: context {
      set text(size: 9pt, fill: rgb("#666666"), font: font-sans, weight: "medium")
      grid(
        columns: (1fr, auto),
        align(left + horizon, title),
        align(right + horizon)[
          #if company_logo != none { image(company_logo, height: 1cm) } else { text(company_name) }
        ],
      )
      v(0.5cm)
      line(length: 100%, stroke: 0.5pt + rgb("#e0e0e0"))
    },
    footer: context {
      set text(size: 9pt, fill: rgb("#666666"), font: font-sans, weight: "medium")
      line(length: 100%, stroke: 0.5pt + rgb("#e0e0e0"))
      v(0.5cm)
      grid(
        columns: (auto, 1fr, auto),
        align(left + horizon)[
          #let footer-logo = if footer_university_logo != none { footer_university_logo } else { university_logo }
          #if footer-logo != none { image(footer-logo, height: 1cm) } else { text(university_name) }
        ],
        align(center + horizon)[ #author ],
        align(right + horizon)[Page #counter(page).display("1 / 1", both: true)],
      )
    },
  )

  // --- Main Typography & Styling ---
  set text(font: font-serif, size: 12pt, lang: "en", fill: black)
  set par(justify: true, leading: 0.65em, first-line-indent: 0pt, spacing: 1.2em)
  set heading(numbering: "1.1.")

  show heading: it => {
    set text(font: font-sans, fill: brand-color)
    v(1.5em)
    it
    v(0.5em)
  }

  show raw.where(block: true): it => block(
    fill: bg-light,
    inset: 10pt,
    radius: (left: 0pt, right: 4pt),
    stroke: (left: 3pt + brand-color),
    width: 100%,
    it,
  )

  set table(
    stroke: 0.5pt + rgb("#d1d5db"),
    fill: (x, y) => if y == 0 { brand-color } else if calc.even(y) { bg-light } else { none },
  )
  show table.cell.where(y: 0): set text(fill: white, weight: "bold", font: font-sans)

  show terms: set text(font: font-sans, size: 10pt)

  show outline: set text(font: font-sans)

  show figure.caption: set text(size: 9pt, style: "italic", fill: rgb("#555555"))

  show figure.where(kind: image): it => {
    v(1em, weak: true)
    align(center, {
      box(
        stroke: (left: 3pt + brand-color),
        fill: bg-light,
        inset: 12pt,
        radius: (right: 4pt),
        width: 90%,
        it.body,
      )
      v(0.6em, weak: true)
      it.caption
    })
    v(1em, weak: true)
  }

  // --- Frontmatter ---
  if acknowledgements != none {
    heading(numbering: none)[Acknowledgements]
    acknowledgements
    pagebreak()
  }

  if abstract != none {
    heading(numbering: none)[Abstract]
    abstract
    pagebreak()
  }

  heading(numbering: none)[Table of Contents]
  outline(title: none, indent: 2em)
  pagebreak()

  body
}
