#import "./TEMPLATE.typ": *

#show: setup

#tp("Example Presentation", "2026.5.28")

#cot("Content")

#sec("Introduction")

#s2(
  "Overview",

  [
    #img("./figures/cat.png", auto, 6cm)
  ],

  [
    - Example bullet
    - Example content
    - Example workflow
  ],
)

#s("Table Example")[
  #tbl2(
    r([*Item*], [*Description*]),
    r([A], [Example]),
    r([B], [Example]),
  )
]