#grid(
  columns: (1fr,1fr),
  fill: none,
  [],)[
    #set text(top-edge: 1em, bottom-edge: 0em)// Equal to Office365 Word's Single Line Spacing 
    #set par(leading: 0.17em)
    #align(left)[
      #v(1fr)
      #set par(justify: true)
      #lorem(50)
    ]
  ]