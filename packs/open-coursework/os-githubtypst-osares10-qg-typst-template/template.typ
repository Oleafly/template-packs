#set document(
    author: "Oswaldo Arias Estrada",
    title: "1st Partial Exam",
  )
#set page(
  paper: "us-letter",
)
#set text(
  font: "Atkinson Hyperlegible",
  size: 12pt,
  hyphenate: false,
  lang: "en",
)

#let questionarie(
  teacher: "",
  title: "",
  subject: "",
  school: "",
  faculty: "",
  academy: "",
  class: "",
  date: "",
  paper: "",
  textFont: "",
  codeFont: "",
  schoolLogo: "",
  schoolLogoWidth: "",
  facultyLogo: "",
  facultyLogoWidth: "",
  instructions: "",

  examID: "",
  points: "",

  body,
) = {
  set smartquote(quotes: "“”")
  set heading(
    numbering: "1.1."
  )
  show heading: it => block[
    #counter(heading).display()
    #text(it.body)
    #v(1em)
  ]
  set par(
    justify: true,
  )
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
    radius: 8pt,
    above: 1em,
    below: 2em,
  )
  show figure: set block(breakable: true)
  show link: it => {
    box(
        fill: cmyk(20%, 10%, 0%, 3%),
        inset: 3pt,
        radius: 3pt,
        baseline: 15%,
        [
          #set text(
              font: codeFont,
              size: 9pt,
              fill: cmyk(100%, 100%, 0%, 7%),
          )
          #it
        ]
    )
  }
  set list(
    indent: 1em,
    spacing: 1em,
  )

  table(columns: 10, align: center,
    table.cell(rowspan: 3, colspan: 1)[#image(schoolLogo, width: schoolLogoWidth)], table.cell(colspan: 8)[*#school*], table.cell(rowspan: 3, colspan: 1)[#image(facultyLogo, width: facultyLogoWidth)],

    table.cell(colspan: 8)[*#faculty*],

    table.cell(colspan: 2)[*Subject*],table.cell(colspan: 3)[#subject],table.cell(colspan: 3)[*#title*],

    table.cell(colspan: 1)[*Academy*], table.cell(colspan: 7)[#academy], table.cell(colspan: 1)[*Date*], table.cell(colspan: 1)[#date],
    
    table.cell(colspan: 1)[*Teacher*], table.cell(colspan: 7)[#teacher], table.cell(colspan: 1)[*Class*], table.cell(colspan: 1)[#class],

    table.cell(colspan: 1)[*Student*], table.cell(colspan: 7)[], table.cell(colspan: 1)[*Student ID*], table.cell(colspan: 1)[],

    table.cell(colspan: 1)[*Exam ID*], table.cell(colspan: 7, )[#examID], table.cell(colspan: 1)[*Score*], table.cell(colspan: 1, )[#h(2em)/#points], 
  )

  text()[*Instructions.*]
  text(instructions)

  body
}