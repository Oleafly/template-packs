#import "@preview/unify:0.7.1": add-unit, num, numrange, qty, qtyrange, unit
#import "@preview/cetz:0.3.1": canvas, draw, plot

#let title-page(
  title: none,
  subtitle: none,
  author: none,
  bottom-text: none,
  logo: none,
  institute: none,
  team-members: none,
) = page("a4", margin: 1cm)[
  #v(2.5%)
  #align(center)[
    #grid(
      columns: (1fr, 2fr, 1fr),
      rows: 1,
      align: center,
      gutter: 1cm
    )[
      #if type(logo) == str { image(logo, width: 70%) } else { logo }
    ][
      #align(left)[#text(institute, size: 14pt)]
    ][
      // Third block empty
    ]
  ]
  #line(length: 100%)
  #align(center)[#underline[#text(subtitle, size: 22pt)]]
  #v(30pt)
  #align(center)[#text(title, size: 32pt)]
  #v(20pt)

  #align(center, text(size: 16pt)[#author])

  #if team-members != none {
    v(2cm)
    align(center)[
      #set text(size: 14pt)
      #table(
        columns: (auto, auto),
        align: (left, center),
        stroke: none,
        // inset: 0.8em,
        table.hline(),
        table.header([Ονοματεπώνυμο], [Αριθμός Μητρώου]),
        table.hline(),
        ..for member in team-members {
          (member.at(0), member.at(1))
        },
        table.hline(),
      )
    ]
  }

  #place(
    bottom + center,
    [
      #align(center, text(size: 19pt)[#bottom-text])
    ],
  )
]

#let conf(
  title: "",
  short-title: none,
  subtitle: none,
  author: "",
  institute: "",
  logo: none,
  date: datetime.today(),
  team-members: none,
  body,
) = {
  set document(title: title, author: author, date: date)
  set par(justify: true)
  set text(
    font: "GFS Neohellenic",
    size: 11pt,
    lang: "el",
    region: "GR",
  )
  show math.equation: set text(font: "GFS Neohellenic Math")
  show raw: set text(font: "Comic Code")

  show link: it => underline(text(fill: blue, it))
  show ref: set text(fill: blue)
  set heading(numbering: "1.")
  show figure.where(kind: table): set figure.caption(position: top)

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }
  set math.equation(
    numbering: it => {
      let count = counter(heading.where(level: 1)).at(here()).first()
      if count > 0 { numbering("(1.1)", count, it) } else { numbering("(1)", it) }
    },
  )

  let date-str = date.display("[day]/[month]/[year]") + "\nΑθήνα"

  title-page(
    title: title,
    subtitle: subtitle,
    author: author,
    institute: institute,
    logo: logo,
    bottom-text: date-str,
    team-members: team-members,
  )

  counter(page).update(1)

  set page(
    paper: "a4",
    margin: (x: 1cm, top: 2cm, bottom: 2cm),
    header-ascent: 35%,
    numbering: "1",
    header: [
      #grid(
        columns: (1fr, 1fr),
        align(left)[#author], align(right)[#if short-title != none { short-title } else { title }],
      )
      #line(length: 100%, stroke: 0.3pt)
    ],
  )

  body
}


// Helper function to format code blocks consistently
// Use read() to load the content directly from the file
// Ensure the .py files are in the same folder as this .typ file
#let code-attachment(title, filename) = {
  block(breakable: true)[
    == #title
    #text(style: "italic", size: 10pt)[Αρχείο: #raw(filename)]
    #v(0.5em)
    #raw(read(filename), lang: "python", block: true)
  ]
  v(0.5cm)
}
