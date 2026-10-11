#import "template.typ": problem

#let chapter2() = [
  = My Chapter 2 <chapter2>
  #lorem(20)

  == Subchapter 1
  #lorem(40)
  - *field 1* abc efg
  - *field 2* abc efg
  - *field 3* abc efg
  - *field 4* abc efg
  - *field 5* abc efg

  #problem(
    problem: [
      Problem specification
    ],
    exploration: [
      === Common features
      Problem exploration

      / Feature 1:
        #lorem(50) @dickbutt

      / Feature 2:
        #lorem(100)

      #figure(
        image(
          "assets/dickbutt.svg",
          width: 75%,
        ),
        caption: [Dickbutt],
        placement: none,
      ) <dickbutt>

      === Exploration 1
      #lorem(50)

      Here is a reference to figure, @dickbutt.

      === Exploration 2
      #lorem(100)
    ],
    solution: [
      Solution in here
    ],
  )
]
