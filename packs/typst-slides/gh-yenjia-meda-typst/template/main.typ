#import "../meda_template.typ": * //You can use absolute path after changing the settings in VSCode

#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
)

// The front slide is the first slide of your presentation
#front-slide(
  title: "Slide",
  subtitle: "Online Meeting || 2025/00 00:00",
  authors: "Your name",
  info: [MeDA Lab || Degree Program of Data Science],
  theme: "", // none, bluey, greeny, reddy, dusky
)

// Title slides create new sections
#title-slide[
  This is a Title slide
]

// A simple slide
#slide(title: "Slide")[
  - This is a simple `slide` with no title.
    - You can add text, lists, links, and more.
  - #stress("Bold and coloured") text by using `#stress(text)`.

]

// Blank slide
#blank-slide[
  - This is a `#blank-slide`.

  - Available #stress[themes]#footnote[Use them as *color* functions! e.g., `#reddy("your text")`]:

  #framed(back-color: white, title: "test")[
    #bluey("bluey"), #reddy("reddy"), #greeny("greeny"), #dusky("dusky"), darky.
  ]
]


// Slide with title
#slide(title: "This is the slide title")[
  #align(center)[
    #framed[This is a `#framed` text. Useful for equations.]
    #framed[$ P_t = alpha - 1 / (sqrt(x) + f(y)) $]
  ]
  Sample references: @typst, @typslides.
  - Add your #stress[bibliography slide]!

    1. `#let bib = bibliography("you_bibliography_file.bib")`
    2. `#bibliography-slide(bib)`
]

// Bibliography
#let bib = bibliography("bibliography.bib")
#bibliography-slide(bib)


#end-slide[
  Q & A
]