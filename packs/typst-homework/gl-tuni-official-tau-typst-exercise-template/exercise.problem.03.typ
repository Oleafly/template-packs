
#import "@preview/cetz:0.5.2" as cetz

#let radius = 3cm

#let radiusNotation = $r=#radius.cm() "cm"$

@fig.p3.circle contains a circle with a radius #radiusNotation.

#figure(
  cetz.canvas({
    import cetz.draw: *
    circle(
      (0,0),
      radius: radius,
      stroke: 2pt,
    )
    line(
      (0, 0),
      (radius.cm(), 0),
      name: "line",
      stroke: 2pt,
    )
    set-style(
      content: (
        padding: .2
      )
    )
    content("line.mid", radiusNotation, anchor: "south",)
  }),
  caption: [A circle with a radius of #radiusNotation.]
) <fig.p3.circle>

Find out the circumference of the circle.
