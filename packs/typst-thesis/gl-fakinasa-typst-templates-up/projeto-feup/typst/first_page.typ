#let first_page(
  school: "Faculdade de Engenharia da Universidade do Porto",
  degree: "Licenciatura em Engenharia Informática e Computação",
  project_name: "Projeto FEUP 2023/24 --- LEIC",
  title: "Título do Trabalho",
  subtitle: "Subtítulo do Trabalho",
  team: "Equipa 1LEIC11-1",
  coordination_general: "Manuel Firmino e Sara Ferreira",
  coordination_course: "José Magalhães Cruz",
  supervisor: "João Correia Lopes",
  monitor: "Nome do Monitor",
  authors: (),  // Array of dictionaries with name and email
  date: datetime.today(),
  logo_feup: "../figures/uporto-feup.pdf",
  logo_project: "../figures/pup.png",
) = {
  set align(center)

  v(-12pt)
  text(size: 12pt, weight: "bold", smallcaps(school))

  v(1fr)

  // FEUP logo
  if logo_feup != none {
    image(logo_feup, width: 62mm)
  }

  v(1fr)

  // Title and subtitle
  text(size: 24pt, weight: "bold", title)
  linebreak()
  v(6mm)
  text(size: 14pt, weight: "bold", subtitle)

  v(1fr)

  // Project logo
  if logo_project != none {
    image(logo_project, width: 52mm)
  }

  v(1fr)

  // Project name
  text(size: 14pt, weight: "bold", project_name)
  v(4mm)

  text(size: 14pt, weight: "bold")[Coordenação]
  linebreak()
  v(4mm)
  text(size: 12pt)[Geral: #coordination_general #h(18mm) De curso: #coordination_course]
  v(6mm)

  text(size: 14pt, weight: "bold", team)
  linebreak()
  v(4mm)
  text(size: 12pt)[Supervisor: #supervisor #h(12mm) Monitor: #monitor]
  v(6mm)

  // Authors
  text(size: 14pt, weight: "bold")[Estudantes & Autores]
  linebreak()
  v(4mm)

  grid(
    columns: 2,
    align: left,
    column-gutter: 12mm,
    row-gutter: 4mm,
    ..authors.enumerate().map(((i, author)) => {
      // If last author and odd number of authors,
      // center it across both columns
      if i == authors.len() - 1 and calc.odd(authors.len()) {
        grid.cell(colspan: 2, align: center, text(size: 12pt)[#author.name <#author.email>])
      } else {
        text(size: 12pt)[#author.name <#author.email>]
      }
    })
  )

  v(8mm)

  text(size: 12pt)[#date.display("[day] de [month repr:long] de [year]")]

  pagebreak()
}
