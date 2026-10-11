#import "@preview/butterick-resume:0.1.1": introduction, template, two-grid
#let personal-data = yaml("/data/personal.yaml")

#set text(lang: "es", region: "bo")

#show: template.with()

#set page(margin: 0.5in)

#introduction(
  name: personal-data.name,
  details: [
    LinkedIn
    #h(1em)
    GitHub
    #h(1em)
    #personal-data.email
  ],
)

= Educación
#two-grid(
  left: [UPSA],
  right: [2021 -- 2025],
)

_Licenciatura en Ingeniería de Sistemas_

- #lorem(10)
- #lorem(10)
- #lorem(10)

#two-grid(
  left: [Colegio],
  right: [2015 -- 2021],
)

_Bachiller en Humanidades_

- #lorem(10)
- #lorem(10)
- #lorem(10)

= Habilidades técnicas

- #lorem(10)
- #lorem(10)
- #lorem(10)

= Proyectos, premios y reconocimientos

#two-grid(
  left: [TecnoUPSA],
  right: [2026],
)

_Primer lugar..._

- #lorem(10)
- #lorem(10)
- #lorem(10)
