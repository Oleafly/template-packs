// Header component
#let header(language) = {
  grid(
    columns: (1fr, 1fr),
    align: top,
    stroke: (bottom: .5pt + black),
    inset: (bottom: 5pt),
    image(
      if language == "en" {
        "../res/header_en.png"
      } else if language == "de" {
        "../res/header_de.png"
      },
      width: 70%
    ),
    grid.cell(
      align: right,
      image("../res/nordakademie_logo.png", width: 70%)
    )
  )
}