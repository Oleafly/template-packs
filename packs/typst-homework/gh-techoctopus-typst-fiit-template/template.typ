 #let project(
  title: "",
  subtitle: "",
  author: [],
  date: none,
  logo: none,
  affiliation: (),
  academic-year: [],
  assignment: (
    subject: "",
    practitioners: "",
    exercise_time: "",
  ),
  body,
 ) = {

  set document(
    author: author.name,
    title: title,
    date: if date != none [date] else {datetime.today()}
  )
  
  set page(
    numbering: "1", 
    number-align: right,
  )
  
  set text(font: "New Computer Modern", lang: "sk")

  show par: set block(above: 0.75em, below: 0.75em)

  set heading(numbering: "1.1")
  set par(leading: 0.58em)

  set align(center)

  text(1.2em, weight: "bold", affiliation.faculty)
  v(1pt)
  text(1.2em, affiliation.university)  
  
  v(1fr)
  if logo != none {
    align(center, image(logo, width: 25%))
  }
  v(1fr)

  text(1.6em, subtitle)
  v(0pt)
  text(1.8em, weight: 700, title)

  v(1fr)
  
  align(
    center,
    block(
      width: 90%,
      [
        #grid(
          columns: 2,
          align: left,
          gutter: 8em,
          text[
            *Autor:* #author.name \
            *Email:* #author.email \
            *ID*: #author.id \
          ],
          text[
            *Predmet:* #assignment.subject \
            *Cvičiaci:* #assignment.practitioners \
            *Cvičenie:* #assignment.exercise_time \
          ]
        )
      ]
    )
  )

  v(1fr)

  text(1.2em, [
    Akademický rok 
    #academic-year
  ])
  
  pagebreak()

  set page(
    header: [
      #set text(8pt)
      #smallcaps[#author.name]
      #h(1fr)
      #smallcaps[#title]
    ]
  )

  set par(
    justify: true,
  )
  set align(start)
  set align(alignment.top)
  
  outline(
    title: "Obsah",
  )
  pagebreak()

  body
 }