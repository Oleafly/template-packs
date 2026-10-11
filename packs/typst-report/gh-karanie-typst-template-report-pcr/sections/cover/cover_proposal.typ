#import "../../config.typ": *

#align(horizon)[
  #align(center, text(weight: "bold")[
    #set text(size: 1.2em)
    
    #pad(bottom: 16pt)[
      #upper[#report_type]
    ]
    
    #pad(bottom: 64pt)[#upper[#title_block]]
    
    #pad(bottom: 64pt)[
      #image(
        "../../media/logo_pcr.png",
        width: 3in,
      )
    ]
    
    #pad(bottom: 42pt)[
      #underline[#author_name] \
      #author_id
    ]
    
    #pad(bottom: 32pt)[
      Pembimbing \
      #underline[#advisor_name]
    ]
    
    #text(weight:"bold")[
      #upper[
        #program_of_study\
        #campus_name \
        #year
      ]
    ]
  ])
]