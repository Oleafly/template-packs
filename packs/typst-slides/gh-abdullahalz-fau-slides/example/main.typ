#import "@preview/polylux:0.4.0": *
#import "../library.typ": *

// #set text(lang: "de")
#set text(lang: "en")


#show: setup.with(
  department: "tech",
  fill: white, // main text color is its inverse
  //font: "Fira Sans",
  //math-font: "Fira Math",
  //code-font: "Fira Code",
  //text-size: 23pt,
  footer: "FAU Slides",
  date: datetime(day: 15, month: 05, year: 2026).display("[month repr:long] [day], [year]"),
)

// Animations are collapsed, comment out to get animated slides
#enable-handout-mode(true)


#new-logo(image("i4.png", width: 30pt))

// In case you need separate logos for sections and slides (contrast issues)
// otherwise we default to a single logos list
#new-section-logo(image("i5.png"))

#top-slide(
  title: "FAU beamer in typst",
  subtitle: "",
  author: "Abdullah Alzein¹",
  institution: "¹BSc Computer Science, Friedrich-Alexander-Universität Erlangen-Nürnberg",
)

#section[Overview]

#slide[
  = Overview
  == FAU Beamer by Tim Roith
  //#uncover(2)[content] reserves space on the slide for later content
  //#only(2)[content] only takes up needed space on the slides it is shown on 
  #uncover((2, 3))[
    - Uses LaTex
  ]
  #uncover(3)[
    === FAU-Typst
    - Uses Typst
  ]
]

#slide[
  = Image slide
  #align(center)[
    #image("i4.png", width: 40%)
    FAU Chair of Computer Science for System Software (i4)
  ]
]

#slide[
  = Slide with images

  #table(columns: (50%, 50%), stroke: none)[
    #item-by-item[
      - This is constantly WIP
      - Use, adapt and share
    ]
  ][
    #image("kat.png")
    #align(center)[Katze aus IntroML]
  ]
]
#section[FIN]
