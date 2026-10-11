#import "@preview/cetz:0.4.2"

#let number=if ("number" in sys.inputs) {sys.inputs.number} else {"Interview Number"}
#let name=if ("name" in sys.inputs) {sys.inputs.name} else {"Student Name"}
#let grade=if ("grade" in sys.inputs) {sys.inputs.grade} else {"0"}
#let regrade=if ("regrade" in sys.inputs) {sys.inputs.regrade} else {"0"}
#let gradeMax=if ("gradeMax" in sys.inputs) {sys.inputs.gradeMax} else {"180"}
#let regradeMax=if ("regradeMax" in sys.inputs) {sys.inputs.regradeMax} else {"180"}
#let subject=if ("subject" in sys.inputs) {sys.inputs.subject} else {"Subject"}
#let semester=if ("semester" in sys.inputs) {sys.inputs.semester} else {"Semester"}
#let date=if ("date" in sys.inputs) {sys.inputs.date} else {"Date"}
#let time=if ("time" in sys.inputs) {sys.inputs.time} else {"Time"}
#let topic=if ("topic" in sys.inputs) {sys.inputs.topic} else {""}

// TODO: in python
#let language=if ("language" in sys.inputs) {sys.inputs.language} else {""}

#let topics=if ("topics" in sys.inputs) {sys.inputs.topics} else {"0"}
#let posts=if ("posts" in sys.inputs) {sys.inputs.posts} else {"0"}
#let topics_read=if ("topics_read" in sys.inputs) {sys.inputs.topics_read} else {"0"}
#let posts_read=if ("posts_read" in sys.inputs) {sys.inputs.posts_read} else {"0"}
#let max_topics=if ("max_topics" in sys.inputs) {sys.inputs.max_topics} else {"0"}
#let max_posts=if ("max_posts" in sys.inputs) {sys.inputs.max_posts} else {"0"}
#let max_topics_read=if ("max_topics_read" in sys.inputs) {sys.inputs.max_topics_read} else {"0"}
#let max_posts_read=if ("max_posts_read" in sys.inputs) {sys.inputs.max_posts_read} else {"0"}

#let projects=(1,2,3,4,5,6).map(i => if ("project" + str(i) in sys.inputs) {sys.inputs.at("project" + str(i))} else {"0"})
#let projectsMax=(1,2,3,4,5,6).map(i => if ("projectMax" + str(i) in sys.inputs) {sys.inputs.at("projectMax" + str(i))} else {"15"})
#let projects=projects.zip(projectsMax)
#let tests=(1,2,3,4,5,6).map(i => if ("tests" + str(i) in sys.inputs) {sys.inputs.at("tests" + str(i))} else {"0"})
#let testsMax=(1,2,3,4,5,6).map(i => if ("testsMax" + str(i) in sys.inputs) {sys.inputs.at("testsMax" + str(i))} else {"15"})
#let tests=tests.zip(testsMax)


// = Test #{projects.at(0)}

#align(center)[
  #text(20pt)[
    #number. #name
  ]
]

// underline with orange = 0% to blue = 100%
#let ratiounderline(val1, val2, showMax:true) = {
  let ratio = if (val1 != "nan" and float(val2)!=0) {float(val1) / float(val2)} else {0}
  let color = color.mix((orange, 1 - ratio), (blue, ratio))
  underline(stroke: 1.5pt + color,
    if showMax {
      [#str(val1)/#str(val2)]
    } else {
      [#str(val1)]
    }
  )
}


#table(
  columns: (0.5fr,0.5fr),
  table.cell(colspan:2, fill:gray.lighten(70%))[#align(center)[Name: #name]],
  table.cell(fill:gray.lighten(70%))[Data],
  table.cell(fill:gray.lighten(70%))[Interview Details],

  table.cell(colspan: 2,inset: 0pt)[
    #grid(
    columns: (0.7fr,0.3fr),
    stroke: 1pt,
    inset: 5pt,
    [
    Grade: #ratiounderline(grade,gradeMax) \
    Re-Exam: #ratiounderline(regrade,regradeMax) \
    Forum Written: #ratiounderline(topics,max_topics,showMax: false) topics, #ratiounderline(posts,max_posts, showMax: false) posts \
    Forum Read: #ratiounderline(topics_read,max_topics_read,showMax: false) topics, #ratiounderline(posts_read,max_posts_read,showMax: false) posts \
    Subject: #subject \
    Semester: #semester \
    Tests: #{tests.map(t => ratiounderline(t.at(0),t.at(1))).join([, ])} \
    Projects: #{projects.map(p => ratiounderline(p.at(0),p.at(1))).join([, ])}
  ],[
    Interview Number: #number \
    Date: #date \
    Time: #time \
    Length: 45 min \
    Language: #language \
  ])],

  table.cell(colspan:2,fill:gray.lighten(70%))[Preamble],
  table.cell(colspan:2)[
    Why do you want to be a tutor? \
    \
    \
    What would you like to change? What feedback do you have for us? \
    \
    \
    Did you attend the precourse? What is your feedback on it? \
    \
    \
  ],
  table.cell(colspan:2,fill:gray.lighten(70%))[Content],
  table.cell(colspan:2)[
    #{if (topic != "") {topic} else {""}} \
    General Notes: \
    #list(marker: box[#square(size:10pt)],
      [Talks to us not blackboard],
      [Do not erase written stuff],
      [Can answer questions],
      [Competent in content],
      [Solve difficult part],
      [Explains ideas highlevel],
      [Good examples],
      [Asks for questions],
      [Can spot mistakes in exercise/own work],
    )
    #v(3%)

    #table(
      columns: (1fr,1fr,1fr,1fr),
      inset: 0pt,
      stroke: 0pt,
      table.cell()[ #box[
        #cetz.canvas({
          import cetz.draw: *
          rect((0,0),(7pt,7pt))
          line((-2pt,9pt), (9pt,-2pt), stroke: 1pt)
        })
      ] no ],
      table.cell()[ #box[
        #cetz.canvas({
          import cetz.draw: *
          rect((0,0),(7pt,7pt))
          line((0,0),(7pt,0pt),(7pt,7pt), fill: black)
        })
      ] half ],
      table.cell()[ #box[
        #cetz.canvas({
          import cetz.draw: *
          rect((0,0),(7pt,7pt))
          line((0,3.5pt),(7pt,3.5pt), fill: black)
          line((3.5pt,0pt),(3.5pt,7pt), fill: black)
        })
      ] yes ],
      table.cell()[ #box[#square(size:7pt, fill:black)] yes ],
    )
  ],
  table.cell(fill:gray.lighten(70%))[Modalities],
  table.cell(fill:gray.lighten(70%))[Information],
  table.cell()[
    #table(
      columns: (0.5fr,0.5fr),
      inset: 0pt,
      stroke: 0pt,
      table.cell()[
        #box[#square(size:10pt)] German Tutorial \
        #box[#square(size:10pt)] English Tutorial
      ],
      table.cell()[
        #box[#square(size:10pt)] Double Tutorial
      ]
    )
  ],
  table.cell()[
    Didaktikseminar before Semester (1CP) \
    (optional) Prog2 Precourse (2CP) \
    Prog2 Tutorial (4CP) 
  ],
)
Tipp: Sort students directly after interview using insert sort.
#table(
  columns: (1fr,1fr,1fr,1fr,1fr),
  inset: 0pt,
  stroke: 0pt,
  table.cell()[ Tutor: ],
  table.cell()[ #box[#circle(radius:4pt)] Good ],
  table.cell()[ #box[#circle(radius:4pt)] Okay ],
  table.cell()[ #box[#circle(radius:4pt)] Needs Work ],
  table.cell()[ #box[#circle(radius:4pt)] Rather Not ],
)

#place(top+right,dy:-0.5cm,dx:1cm)[
  #rotate(15deg)[
    #image("logo.png", width:5cm)
  ]
]