#import "states.typ"

#import "questions.typ": *

#let title(
  class,
  instructors,
  semester,
  exam  
) = [
  #set text(size: 20pt, font: "Latin Modern Roman Dunhill")
  #v(-18pt)
  #grid(columns: (1fr, 1fr),
    align: (left, right),
    row-gutter: 3pt,
    inset: 3pt,
    [#class], [#instructors],
    [#semester], [#exam]
  )
  #v(-18pt)
]

#let pointstable() = [
  #context {
    table(
      columns: ((2cm), (0.9cm,) * states.num-questions(), (1.5cm)).flatten(),
      
      [Question:], 
        ..for q in states.questions.at(<exam-end>) { (str(q.num),) }, [ Total ],
        
      [Points:], 
        ..for q in states.questions.at(<exam-end>) { (str(q.points),) }, [ #states.num-points() ]
    )
  }
]

#let frontpage(
  class,
  instructors,
  semester,
  exam,
  time,
  last-edited,
) = [
  #v(-1cm)
  #line(length: 100%, stroke: 3pt)
  #title(class, instructors, semester, exam)
  #line(length: 100%, stroke: 3pt)

  #context if states.print-answers.get() {
    v(-0.2em)
    text(fill: red.darken(10%))[*Solutions last updated: #last-edited*]
    v(-1.5em)
  }

  #v(12pt)
  #smallcaps("Print") Your Name: 
    #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])

  #v(12pt)
  #smallcaps("Print") Your Student ID: 
    #box(width: 1fr, [#line(length:60%, stroke: 0.5pt)])

  #v(12pt)
  #smallcaps("Print") the Name and Student ID of the person to your left: 
    #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])
    
  #v(12pt)
  #smallcaps("Print") the Name and Student ID of the person to your right: 
    #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])

  #v(12pt)
  #smallcaps("Print") the Name and Student ID of the person in front of you: 
    #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])
    
  #v(12pt)
  #smallcaps("Print") the Name and Student ID of the person behind you: 
    #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])
    

  #line(length: 100%, stroke: 1pt)

  #context [ 
    You have #time. There are #states.num-questions() questions of varying credit. (#states.num-points() points total) 
  ]
  
  #align(center)[
    #pointstable()
  ]
  
  #states.print-answers.update(true)
  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      #set par(justify: false)
      For questions with *circular bubbles*, you may select only one choice.
      
      #multi-choice(
        [ Unselected option (Completely unfilled) ],
        bad()[ Don't do this (it will be graded as incorrect) ],
        correct()[ Only one selected option (completely filled) ],
      )
    ],
    [
      #set par(justify: false)
      For questions with *square checkboxes*, you may select one or more choices.
      
      #multi-select(
        correct()[You can select],
        correct()[multiple squares],
        bad()[(Don't do this)],
      )
    ]
  )
  #states.print-answers.update(false)
  
  Anything you write outside the answer boxes or you #strike([cross out]) will not be graded. If you write multiple answers, your answer is ambiguous, or the bubble/checkbox is not entirely filled in, we will grade the worst interpretation. For coding questions with blanks, you may write at most one statement per blank and you may not use more blanks than provided.
  
  If an answer requires hex input, you must only use capitalized letters (`0xB0BACAFE` instead of `0xb0bacafe`). For hex and binary, please include prefixes in your answers unless otherwise specified, and do not truncate any leading 0’s. For all other bases, do not add any prefixes or suffixes.


  #line(length: 100%, stroke: 1pt)
    #box(width: 100%, stroke: 1pt, inset: 6pt, )[
    As a member of the UC Berkeley community, I act with honesty, integrity, and respect for others. I will follow the rules of this exam.
  ]
  
  Acknowledge that you have read and agree to the honor code above and sign your name below: 
  #v(20pt)
  #box(width: 1fr, [#line(length:100%, stroke: 0.5pt)])

  #pagebreak()
]

