#import "../lib.typ": *

#show: checklist

#sequence(withTime: true)[
  #withCrew("P")[
    #step[Step 1]
    #subStep(atTime: "01:00")[Step 2]
  ]
]
