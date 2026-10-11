#import "clean-dhbw/lib.typ": *

#let appendix = [
  == Abschnitt
  #figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))
  #figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))

  #equation(
    caption: "Meine Gleichung",
    label: <gleichungUntenAnhang1>,
    $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
  )

  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $
  $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $

  #equation(
    caption: "Meine Gleichung",
    label: <gleichungUntenAnhang2>,
    $ (-b plus.minus sqrt(b^2 - 4 dot a dot c)) / (2 dot a) $,
  )

  = Anhang 2 <anhang:secondAppendix>
  #figure(caption: "Eine Abbildung", image(width: 4cm, "assets/ts.svg"))

  == Level 2 Anhang
]
