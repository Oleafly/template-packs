#import "imports/boxes.typ": *
#import "imports/text.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "imports/algos.typ": *
#import "imports/preamble.typ": init
#show: init.with(
  name: "My Document",
  description: "This is a description of my document.",
  )

= Stuff here
#lorem(100)

== Smaller stuff here
#lorem(50)

=== Even smaller stuff here
#lorem(20)
=== Different Stuff here

= Change of topic
#lorem(100)
== Lets talk about a lot of something here
#lorem(500)

#psc(title: [Pseudocode])[
  + #psfn([test], [])
    + #psfor[i = 0 #psto 1..10]
      + #psreturn[i]
      - #cm[Comment]
    + #pswhile[i > 0]
      + #pserror[important error]
    + #psforeach[x $in$ arr]
      + #psprint[x]
  + #psstruct([Node], [sdasda])
    + #psif[i % 2 == 0]
      + #pscontinue
    + #pselseif[i % 3 == 0]
      + #psbreak
    + #pselse
      + x = #psstring["hello world"]
]

= Boxes

#db(title: "A definition box with a title")[
  #lorem(20)
]
#sdb[
  Small defininition box that adjusts to the content
]

#idb[Inline Definition box]

#mb(title: "A math box with a title")[
  #lorem(20)
]
#smb[
  Small math box that adjusts to the content
]

#imb[Inline math box]

#cb(title: "A code box with a title")[
  #lorem(20)
]
#scb[
  Small code box that adjusts to the content
]

#icb[Inline code box]

= Text

#dt[This is a definition term]
#mt[This is a math term]
#ct[This is a code term]