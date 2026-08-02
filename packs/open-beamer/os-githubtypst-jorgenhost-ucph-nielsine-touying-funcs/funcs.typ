#import "@preview/pinit:0.2.2" as pi
#let pinit-highlight-equation-from(
  height: 2em,
  extended-height: 1.4em,
  dy: -0.9em,
  pos: bottom,
  fill: rgb(0, 180, 255),
  highlight-pins,
  point-pin,
  body,
) = {
  pi.pinit-highlight(..highlight-pins, dy: dy, extended-height: extended-height, fill: rgb(
    ..fill.components().slice(0, -1),
    40,
  ))
  pi.pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0.5em } else { -0.9em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(inset: 0.5em, stroke: (bottom: 0.12em + fill), {
      set text(fill: fill)
      body
    }),
  )
}
