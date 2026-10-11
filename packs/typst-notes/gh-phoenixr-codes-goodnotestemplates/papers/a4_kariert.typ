#import "../config.typ": *
#set page(
  paper: "a4",
  margin: 0%,
  fill: background-color
)
#rect(
  height: 100%,
  width: 100%,
  fill: tiling(size: (5mm, 5mm))[
    #place(line(start: (0%, 0%), end: (100%, 0%), stroke: foreground-color + .3pt))
    #place(line(start: (0%, 0%), end: (0%, 100%), stroke: foreground-color + .3pt))
  ]
)
