#let tuftsblue = rgb(49,114,174)
#let tuftsbluedark = rgb(0,46,109)


#let tmc-style(..sink) = {
  arguments(
  align: (left, center, left),
  columns: (2fr, 3fr, 1.5fr),
  gutter: 3pt,
  text(7pt, fill: tuftsblue, style: "italic")[
    The principle teaching\
    hospital for Tufts University\
    School of Medicine
  ],
  image("Tufts_Medical_Center_logo.jpg", width: 70%),
  text(7pt, fill: tuftsbluedark)[
    800 Washington Street\
    Boston, Massachusetts 02111\
    #sub[T] 617 636-5000\
    #link("https://tuftsmedicalcenter.org")[tuftsmedicalcenter.org]
  ]
)}

#let gsbs-style(name: "Kevin Bonham, PhD", 
                title: "Assistant Professor of Medicine"
) = {
  arguments(
    align: (left, right),
    columns: (2fr, 1fr),
    gutter: 3pt,
    image("gsbs.png", width:70%),
    text(7pt, fill: tuftsbluedark)[
      #v(2em)
      #name\
      #title
    ]
)}


#let letter-template(doc,
  name: "Kevin Bonham, PhD",
  email: "kevin.bonham@tuftsmedicine.org",
  title: "Assistant Professor of Medicine",
  affiliation: "GI Division | Tufts Medical Center",
  date: datetime.today(),
  salutation: "To whom it may concern,",
  vmargins: 0.3in,
  signature: v(0.5in),
  style: tmc-style) = {
  set page(
      margin: (bottom: 1.0in, top: 0.5in, rest:1.0in),
  )
  set text(10pt, font:"Liberation Sans")
  show link: set text(fill: tuftsblue)

  grid(..style(name: name, title: title))
  v(vmargins)

  date.display("[month repr:short] [day], [year]")

  v(vmargins)

  salutation
  doc
  linebreak()
  linebreak()

  [
  Sincerely,
  #signature

  #name\
  #email\
  #title\
  #affiliation\
  ]

}
