#import "lib.typ": *

#show: hw.with(
  name: [utopiatopia],
  class: [CSE101],
  hw_num: 0,
  date: datetime(
    year: 2025,
    month: 7,
    day: 4
  )
)

#problem(number: [1a])[
  This is a question!
  #rect[and this is an answer!]
]

#problem(number: [1.2b])[
  #link("This is a link to Typst!")
  #rect(radius:1em)[
    This is an answer box with a modified \
    radius so that a long answer can fit \
    inside of it without clipping into the \
    sides of it #emoji.face.wink
  ]
  #rect[
    Oh \
    noes \
    There's \
    clipping\
    here \

    #box(width: 1in)
    
  ]
]