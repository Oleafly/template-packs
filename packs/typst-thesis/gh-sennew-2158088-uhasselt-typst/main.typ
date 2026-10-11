#set document(title: "Title", author: "Author")
#set page(paper: "a4", margin: 3.25cm)
#set text(lang: "en", size: 10pt, font: "New Computer Modern")
#set par(
  spacing: 0.65em,
  leading: 0.55em,
  first-line-indent: 0pt
)

#page[
  #set align(center)

  #text(size: 17.28pt)[#smallcaps(all: false)[Universiteit Hasselt]]

  #v(1cm)
  #text(size: 14.4pt)[#smallcaps(all: false)[Masterproef voorgedragen tot het behalen van de graad van master in de informatica]]
  #v(0.5cm)
  #line(length: 100%, stroke: 0.5mm)

  #v(0.4cm)

  #text(size: 24pt, weight: "bold")[Hier komt je titel te staan]

  #v(0.4cm)

  #line(length: 100%, stroke: 0.5mm)

  #v(1.5cm)

  #grid(
    columns: (1fr, 1fr),
    align: (left + top, right + top),
    gutter: 0pt,
    [
      #text(size: 12pt, style: "italic")[Auteur:]

      #v(0.5cm)

      Je naam en voornaam
    ],
    [
      #text(size: 12pt, style: "italic")[Promotor:]

      #v(0.5cm)

      Je promotor (inclusief titel)

      #v(0.5cm)

      #text(size: 12pt, style: "italic")[Co-promotor:]

      #v(0.5cm)

      Je co-promotor (inclusief titel)

      #v(0.5cm)

      #text(size: 12pt, style: "italic")[Begeleider(s):]

      #v(0.5cm)

      En hier de begeleider(s)
    ]
  )

  #v(1cm)

  #text(size: 12pt)[Academiejaar 2025-2026]

  #v(2cm)

  #image("./assets/uhasselt.jpg", width: 40%)
]

