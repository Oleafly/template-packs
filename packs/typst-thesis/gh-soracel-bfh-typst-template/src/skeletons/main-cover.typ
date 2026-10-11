#let MainCover(
  // content
  doc,
  coverImage: none,
  title: none,
  subtitle: none,
  subSubTitle: none,
  informations: none,
  departement: none,
  // config
  primaryColor: none,
  secondaryColor: none,
  companyLogoImage: none,
) = {
  let title-size = 24pt
  let subtitle-size = 14pt
  let footer-size = 8pt

  page({
      // --- Cover image ---
      if coverImage != none {
        box(
          height: 10cm, coverImage
        ) 
      } else {
        box(
          height: 10cm, width: 100%, fill: secondaryColor
        )
      }
      v(0fr)
      line(stroke: 7pt + primaryColor, length: 100%)
      v(5mm)
      
      // --- Titles ---
      place(
        dy: 1cm,
        dx: 2.5cm,
        grid(
          columns: (1fr),
          row-gutter: 24pt,
          [
            #set text(title-size)
            #title
          ],
          [
            #set text(subtitle-size)
            #subtitle
          ],
          [
            #set text(weight: "bold")
            #subSubTitle
          ]
        )
      )

      // --- Information ---
      if informations != none {
        place(
          dy: 10cm,
          dx: 2.5cm,
          grid(
            columns: (1fr, 1fr),
            row-gutter: 10pt,
            ..informations.flatten(),
          )
        )
      }
      
    },
    footer: context {
      place(
        bottom,
        dx: 2.5cm,
        dy: -1cm,
        grid(
          columns: (1fr, 1fr),
          align: (bottom),
          [
            #companyLogoImage
          ],
          [
            #set text(size: footer-size)
            #departement
          ],
        )
      )
      
        
    }, margin: (top: 0cm, left: 0cm, right: 0cm, bottom: 4.5cm)
  )
  doc
}


