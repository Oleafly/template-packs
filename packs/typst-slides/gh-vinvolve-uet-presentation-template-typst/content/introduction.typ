#import "../coolUET/coolUET.typ":* 

= Introduction 

== SubIntroduction 1
#lorem(78)

== SubIntroduction 2
#set par(justify: true)
#place(top + left,
                 
  stack(
    dir: ltr,     
    spacing: 1cm, 
    box(
      width: 7cm, 
      [
         #lorem(45)
      ]
    ),

  
    box(
      width: 9cm, 
      [


        #theorem(title: "Pythagorean")[

          $a^2 + b^2 = c^2$
        ]

        #figure(
          image("image9.png", width: 50%), caption: [this is a caption]
        )
        
        
      ]
    )
  )
)

