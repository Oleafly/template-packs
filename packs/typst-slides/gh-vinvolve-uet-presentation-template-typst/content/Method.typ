#import "../coolUET/coolUET.typ":*

// // #set page(
//   paper: "a4", // Or your desired paper size
//   margin: (top: 2cm, bottom: 2cm, x: 1.5cm), // Adjust margins as needed
//   header: {
//     // This block defines the content of your header
//     [Your Header Text] // Text on the left
//     #h(1fr) // Flexible space in the middle, pushing items apart
//     image("path/to/your-logo.png", width: 2cm) // Logo on the right
//   }
// )

= Method
== Method 1
=== Method 1.1

#set par(justify: true)
#place(top + left,
                 
  stack(
    dir: ltr,     
    spacing: 1cm, 
   
  
    box(
      width: 9cm, 
      [

        \
        \
        #lemma(title: "Abhyankar's lemma",
        
        fill-body: orange.darken(50%).lighten(80%),
        fill-header: yellow.lighten(30%)
        )[

          #lorem(40)
        ]

  
        
        
      ]
    ),


     box(
      width: 7cm, 
      [
        === Method 1.2
        
        
         #lorem(45)
      ]
    ),

    
  )
)

== Method 2
#place(left + top,
  stack(
    dir: ltr,
    spacing: 1cm,
    
    figure(
      rect(fill: blue.darken(40%), width: 4cm, height: 7cm),
      caption: [this is a figure]
    ),
    
    box(
      width: 5cm, 
      [      
         #lorem(12):
         - #lorem(12)
         - #lorem(12)
         - @vaswani2023attentionneed
      ]
    ),
    
    box(
      width: 6cm, 
      [
        
         #lorem(45)
      ]
    ),
  )
)
