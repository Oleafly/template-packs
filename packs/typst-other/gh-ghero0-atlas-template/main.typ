#let dark-george = true


#import "template.typ": *
#show: ATLAS-document.with(
  title: "TITLE",
  information: [],
  footer-title: "FOOTER-TITLE",
  header-title: "HEADER-TITLE",
  icons-top: [],
  icons-bottom: [
    #grid(
      columns: 2,
      row-gutter: 10pt,
      column-gutter: 10pt,
      stroke: 0pt,
      inset: 10pt,
      align: horizon + center,
    )[
      #if (dark-george) {
        image("assets/ENSSAT-logo/ENSSAT-logo-light.png", width: 200pt)
      } else {
        image("assets/ENSSAT-logo/ENSSAT-logo-dark.png", width: 200pt)
      }
    ][
      #if (dark-george) {
        image("assets/NTNU-logo/NTNU hovedlogo - hvit - bredde.svg", width: 120pt)
      } else {
        image("assets/NTNU-logo/NTNU hovedlogo - farger - bredde.svg", width: 120pt)
      }
    ]
  ],
  funky-mode: false,
  dark-mode: dark-george,
  debug: false,
)

// INTRODUCTION
#heading(numbering: none)[Abstract]
#lorem(100)
#lorem(200)
#lorem(100)


// OUTLINE
#pagebreak()
#outline(indent: auto)
#pagebreak()

= Part 1
#figure(caption: [ATLAS figure])[
  #if (dark-george){
    image("assets/ATLAS-logo/ATLAS-logo-full-light.svg",width: 60%)
  } else {
    image("assets/ATLAS-logo/ATLAS-logo-full-dark.svg",width: 60%)
  }
]
== Part 1.1


== Part 1.2



#heading(numbering: none)[Conclusion]

#lorem(200)

#lorem(100)
