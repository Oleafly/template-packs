#let cover-page(
  title,
  author,
  specialty,
  jury,
  academic-year,
  defense-date,
  host-name,
  host-logo,
) = {
  set align(center)
  set text(font: "Fira Sans", size: 14pt)
  set par(leading: 0.65em)
  set strong(delta: 200)
  set page(margin: ( y: 1.5cm, x: 2cm ))
  
  page(
    background: context rect(
      width: page.width - page.margin.left,
      height: page.height - page.margin.top,
      stroke: 1pt + black,
      fill: none,
    )
  )[
    #table(columns: (17.5%, 65%, 17.5%), stroke: 0pt, 
      image("images/logos/insat_small.jpg", height: 2.5cm),
      [
        #set text(size: 12pt)
        REPUBLIC OF TUNISIA
        #v(-2pt)
        Ministry of Higher Education and Scientific Research
        #v(-2pt)
        University of Carthage
        #v(-2pt)
        *National Institute of Applied Sciences and Technology*
      ],
      image("images/logos/carthage.png", height: 2.5cm)
    )

    #line(length: 100%, stroke: 0.5pt)
    
    #v(12pt)
    #text(size: 24pt)[Graduation Project]
    #v(8pt)

    To obtain the

    #text(size: 24pt)[ENGINEERING DEGREE]
    #v(-16pt)
    #text(size: 18pt)[in Applied Sciences and Technology]
    #v(-10pt)
    #text(size: 18pt)[Specialty : Software Engineering]
    
    #v(16pt)
    #block(width: 75%)[ 
      #line(length: 110%, stroke: 0.5pt)
  
      *#title*
  
      #line(length: 110%, stroke: 0.5pt)
    ]
    #v(16pt)
    
    Presented by :

    #text(size: 16pt)[*#author*]

    Hosted by #host-name

    #image(host-logo, width: 20%)

    Defended on the *#defense-date* in front of a jury composed of :

    #table(
      columns: (auto, auto),
      align: (right, left),
      column-gutter: 2em,
      row-gutter: 0.4em,
      stroke: none,
      [*#jury.president-of-the-jury*],
      [President of the jury],
      [*#jury.reviewer*],
      [Reviewer],
      [*#jury.supervisor-at-the-company*],
      [Supervisor at the Company],
      [*#jury.supervisor-at-insat*],
      [Supervisor at INSAT]
    )

    *Academic year : #academic-year*
  ]

  page[
      #table(columns: (17.5%, 65%, 17.5%), stroke: 0pt, 
      image("images/logos/insat_small.jpg", height: 2.5cm),
      [
        #set text(size: 12pt)
        REPUBLIC OF TUNISIA
        #v(-2pt)
        Ministry of Higher Education and Scientific Research
        #v(-2pt)
        University of Carthage
        #v(-2pt)
        *National Institute of Applied Sciences and Technology*
      ],
      image("images/logos/carthage.png", height: 2.5cm)
    )

    #line(length: 100%, stroke: 0.5pt)
    
    #v(12pt)
    #text(size: 24pt)[Graduation Project]
    #v(8pt)

    To obtain the

    #text(size: 24pt)[ENGINEERING DEGREE]
    #v(-16pt)
    #text(size: 18pt)[in Applied Sciences and Technology]
    #v(-10pt)
    #text(size: 18pt)[Specialty : Software Engineering]
    
    #v(16pt)
    #block(width: 75%)[ 
      #line(length: 110%, stroke: 0.5pt)
  
      *#title*
  
      #line(length: 110%, stroke: 0.5pt)
    ]
    #v(16pt)
    
    Presented by :

    #text(size: 16pt)[*#author*]

    Hosted by #host-name

    #image(host-logo, width: 20%)

    #table(
      columns: (1fr, 1fr),
      align: (center, center),
      stroke: 0.5pt,
      inset: 0.5em,
      
      [
        Supervisor at the Company
        #v(-8pt)
        #jury.supervisor-at-the-company
      ],
      [
        Supervisor at INSAT
        #v(-8pt)
        #jury.supervisor-at-insat
      ],
      [
        #v(54pt)
        #align(start)[Date:]
      ],
      [
        #v(54pt)
        #align(start)[Date:]
      ]
    )

    *Academic year : #academic-year*
  ]
}
