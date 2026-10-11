/*#let matriculation_number = "12563"
#let topic = "Analysis and improvement of team Boxfish's newest rust-based service"
#let course_of_studies = "Angewandte Informatik"
#let centuria = "A22b"
#let tl_number = 4*/
#import "config.typ": * 
#import "constants.typ": *


#let blue_cell(inner_text) = table.cell(fill: nak_color)[
      #align(left)[#text(fill: white)[#inner_text]]
    ]

#let create_cover()=[
  #text(
    fill: nak_color,
    size: 15.96pt
  )[
    #if { language == "en" } {
      title_text
    } else {
     title_text
    }
  ]
  #linebreak()
  #linebreak()
  #linebreak()
  #linebreak()
  
  #align(center)[
    #table(
      columns: (125pt, 350pt),
      rows: (30pt, 90pt, 35pt),
      stroke: 0.3pt,
      blue_cell([#matriculation_number_text]), [#align(left)[#matriculation_number]],
      blue_cell([#topic_text]), [#align(left)[#topic]],
      blue_cell([#bachelor_centuria_text]), [#align(left)[#course_of_studies, #centuria]]
    ) 
  ]
]
