// Muqova sahifasi — faqat layout (SRP, DIP: faqat parametrlarga bog'liq)

#let cover-page(
  title: "",
  author: "",
  section-lbl: "",
  section-title: "",
  teacher: "",
  group: "",
  talaba-id: "",
  submitted: "",
) = page(
  numbering: none,
  header: none,
  footer: none,
)[
  #set par(first-line-indent: 0pt, justify: false)
  #set align(center)

  #v(2.5cm)

  #stack(
    spacing: 0pt,
    rect(
      width: 14cm,
      stroke: rgb("#b8a078") + 0.75pt,
      inset: (x: 16pt, y: 14pt),
    )[
      #set text(size: 20pt, weight: "regular")
      #title
    ],
    rect(
      width: 14cm,
      stroke: black + 0.75pt,
      inset: (x: 16pt, y: 14pt),
    )[
      #set text(size: 17pt, weight: "regular")
      #author
    ],
  )

  #v(3cm)

  #set text(size: 14pt)
  #block(spacing: 0.65em)[
    *#section-lbl:* #section-title \
    *O'qituvchi:* #teacher \
    *Guruh identifikatori:* #group \
    *Talaba ID:* #talaba-id \
    *Taqdim etilgan sana:* #submitted yil
  ]

  #v(2cm)
]
