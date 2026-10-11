#import "../themes/cea/theme.typ": *

#let circle-image(
  img-path,
  size: 5cm,
  zoom: 1.0,
  dx: 0cm,
  dy: 0cm,
) = {
  box(
    width: size,
    height: size,
    radius: 50%,
    clip: true,
  )[
    #align(center + horizon)[
      #place(
        center + horizon,
        dx: dx,
        dy: dy,
      )[
        #image(
          img-path,
          width: size * zoom,
          height: size * zoom,
          fit: "contain",
        )
      ]
    ]
  ]
}


#let cv(
  name: "",
  title: "",
  summary: "",
  photo: none,
  photo-zoom: 100%,
  photo-dx: 0pt,
  photo-dy: 0pt,
  sidebar: [],
  main: [],
) = {
  set text(font: "Poppins", size: 10pt)
  set page(
    paper: "a4",
    margin: 0pt,
  )

  grid(
    columns: (40%, 60%),
    rows: 100%,
    [
      // Sidebar block
      #rect(
        width: 100%,
        height: 100%,
        fill: cv-blue,
        inset: 20pt,
        [
          #set text(fill: white)
          #if photo != none [

            #align(center)[
              #circle-image(
                photo,
                size: 5cm,
                zoom: photo-zoom,
                dx: photo-dx,
                dy: photo-dy,
              )
            ]
            #v(10pt)
          ]
          #sidebar
        ],
      )
    ],
    [
      // Main Content block
      #rect(
        width: 100%,
        height: 100%,
        inset: (x: 20pt, top: 20pt, bottom: 20pt),
        [
          #text(size: 24pt, weight: "bold", fill: cv-blue, name)
          #v(-5pt)
          #text(size: 18pt, weight: "medium", fill: cv-blue, title)
          #v(-5pt)
          #text(size: 10pt, fill: cv-text-dark, summary)
          #main
        ],
      )
    ],
  )
}

/// Function to format main section titles
/// Draws a line under the title for a clean separation.
#let section-title(title) = {
  v(1pt)
  text(size: 14pt, weight: "bold", fill: cv-blue, title)
  line(length: 100%, stroke: 1pt + cv-blue-light)
}

/// Function to format sidebar section titles
#let sidebar-title(title) = {
  v(10pt)
  text(size: 14pt, weight: "bold", fill: white, title)
  line(length: 100%, stroke: 1pt + cv-blue-light)
}

/// Function to format a job or education entry
/// Uses a grid to align the company name and the date perfectly.
#let entry(date: "", title: "", company: "", description: []) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 6pt,
    [
      #text(weight: "bold", size: 11pt, company)
    ],
    [
      #text(style: "italic", size: 9pt, date, fill: cv-subtext-dark)
    ],
    grid.cell(colspan: 2)[
      #text(weight: "semibold", fill: cv-text-dark, title)
    ],
    grid.cell(colspan: 2)[
      #set text(size: 8pt)
      #description
    ],
  )
  v(6pt)
}
