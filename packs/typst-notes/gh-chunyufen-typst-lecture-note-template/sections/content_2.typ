// content_2.typ
#import "/globals.typ": *

= The Section

== Slide Title

#lorem(160)

#let fig = figure(
image("../images/ai_robot.jpg", width: 60%),
caption: [A figure],
)
#let body = lorem(180)
#wrap-content(fig, body)

The way forward is to develop a new model for AI forensic analysis of cybercrime @frowisSafeguardingEvidentialValue2020.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.lighten(60%),
    body-color: red.lighten(80%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center
  ),
  shadow: (
    offset: 3pt,
  ),
  title: "Tutorial",
  [#lorem(50)]
)

/*
#focus-slide[
  Tutorial:

  #lorem(20) test test
]

*/