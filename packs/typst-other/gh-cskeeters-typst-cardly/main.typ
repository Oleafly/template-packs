#import "card_param.typ": * // configure parameters here
#import "card.typ": *

#show: setup

#set text(size: 20pt, font: "Amatic SC")

#card(

  front: block(
    width: 100%,
    height: 100%,
    clip: true,
    // fill: rgb("#A00"),
    fill: rgb("#373"),
    // fill: tiling(image(width: 1in, "background.jpg")),
    // stroke: black, // show full block to cut marks
    // inset: (top:-0mm, left:-0pt), // adjust top/left and height for zoom/pan
    to-cut-right(top-third(align(center, image("christmas-santa-and-reindeer-svgrepo-com.svg", width: 83%))))
  ),

  inside-left: [],

  inside-right: to-cut-right(margin(length: 10mm, top-third({
    align(center)[
      Wishing you a Merry Christmas filled with
      joy, love, and cherished moments.

      May the magic of the season warm your heart
      and light your way into a wonderful New Year!
    ]
    pad(left: 50%)[
      Love,\
      Chad
    ]
  }))),

  back: to-cut-left(margin(length: 3mm, {
    align(center,{
      v(1fr)
      text(17pt)[This card was produced with Typst, Cardly, and Love.]
      v(2fr)
      text(font:"Libertinus Serif", features:("smcp",), .5em)[Graphic by soco-st on SVGRepo.com]
    })
  })),
)
