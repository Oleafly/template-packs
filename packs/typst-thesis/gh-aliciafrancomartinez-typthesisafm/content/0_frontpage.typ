#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm), // Adjust margins to frame your text over the art
  background: image("../assets/0_portada.png", width: 100%, height: 100%, fit: "cover"),
)
#v(-30pt)
#align(center)[
  #set text(size: 12pt, weight: "light", fill: rgb("#333333"))
      #set par(leading: 0.65em)
      PhD Dissertation, 2026
    ]

#v(20pt)
// Global text settings
#set text(
  font: "Linux Libertine", 
  size: 11pt,
  weight: "light",
  fill: rgb("#1A1A1A"),
)

#align(center)[
  // Header Section
  #v(0.2cm) // Pushes title down from the top edge
  #block(width: 100%)[
    #set text(size: 37pt, tracking: 1pt)
    #smallcaps[Mi tesis]
    
    #v(0cm)
    
    #set text(size: 20pt, style: "italic", weight: "regular")
    #set par(leading: 0.8em)
    El título de tesis más impresionante \ que jamás habremos leído
  ]

  // This spacer pushes the footer to the bottom
  #v(1fr)

  // Minimalist Footer
  // If the image is dark here, you might need to change 'fill' to white
#align(center)[
  #set text(size: 20pt, weight: "bold")
      Nombre Apellidos \
      #set text(size: 15pt, weight: "light", fill: rgb("#333333"))
      #set par(leading: 0.65em)
      Supervised by Nombre Apellidos
    ]
  ]
      
