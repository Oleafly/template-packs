#import "/layout/fonts.typ": *

#let titlepage(
  title: "",
  titleFrench: "",
  degree: "",
  program: "",
  specialization: "",
  supervisor: "",
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  presentationDate: datetime,
) = {
  // Quality checks
  //assert(degree in ("Bachelor", "Master"), message: "The degree must be either 'Bachelor' or 'Master'")
  
  set page(
    margin: (left: 20mm, right: 20mm, top: 25mm, bottom: 30mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en"
  )

  set par(leading: 0.5em)
  set par(spacing: 0.5em)

  
  // --- Title Page ---
  grid(
    columns: (1fr, 1fr, 1fr),
    grid.cell(inset:.6cm, align(center + bottom, image("../figures/uga_logo.png", width:80%))),
    grid.cell(""),
    grid.cell(align(center + top, image("../figures/inp_logo.png", width:60%))),
  )

  v(8mm)
  align(center, text(1.3em, weight: 100, program + linebreak() + degree + linebreak() + specialization))

  v(42mm)
  align(center, text(font: fonts.sans, 2.0em, weight: 700, title))
  v(3mm)
  align(center, text(font: fonts.sans, 1.7em, weight: 700, author))
  v(3mm)
  align(center, text(1.2em, weight: 100, presentationDate.display("[month repr:long], [year]")))

  
  v(45mm)

  
  align(center, text(1.2em, weight: 100, "Research performed at YOUR LAB"))
  v(2mm)
  align(center, text(1.2em, weight: 100, "Under the supervision of:" + linebreak() + supervisor))
  v(2mm)
  align(center, text(1.2em, weight: 100, 
        "Defended before a jury composed of:" + linebreak() +
        "Head of the jury" + linebreak() +
        "Jury member 1" + linebreak() +
        "Jury member 2" + linebreak()
  ))

  v(6mm)
  grid(
    columns: (.1fr, 1fr, 1fr, .1fr),
    rows: 1.3em,
    grid.cell(""),
    grid.cell(align(left, text(1.3em, weight: 100, presentationDate.display("[month repr:long]")))),
    grid.cell(align(right, text(1.3em, weight: 100, presentationDate.display("[year]")))),
    grid.cell(""),
  )

}
