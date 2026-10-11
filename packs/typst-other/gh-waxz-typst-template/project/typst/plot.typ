#import "@preview/cetz:0.5.2"
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4"
#import "@preview/lilaq:0.6.0" as lq

#set page(width: auto, height: auto, margin: 0cm)

// Standard document text...
Here is the geometric representation of the trigonometric functions on a unit circle:

#figure(
  // The canvas now behaves exactly like an inline image asset
  cetz.canvas(length: 3cm, {
    import cetz.draw: *

    // Design overrides for all internal drawing elements
    set-style(
      mark: (fill: black, scale: 2),
      stroke: (thickness: 0.4pt, cap: "round"),
      angle: (
        radius: 0.3,
        label-radius: .22,
        fill: green.lighten(80%),
        stroke: (paint: green.darken(50%)),
      ),
      content: (padding: 1pt),
    )

    // Background alignment grid
    grid(
      (-1.5, -1.5),
      (1.4, 1.4),
      step: 0.5,
      stroke: gray + 0.2pt,
    )
    circle((0, 0), radius: 1)

    // Axis constructions
    line((-1.5, 0), (1.5, 0), mark: (end: "stealth"))
    content((), $ x $, anchor: "west")
    line((0, -1.5), (0, 1.5), mark: (end: "stealth"))
    content((), $ y $, anchor: "south")

    // X-axis coordinate labels
    for (x, ct) in ((-1, $ -1 $), (-0.5, $ -1/2 $), (1, $ 1 $)) {
      line((x, 3pt), (x, -3pt))
      content((), anchor: "north", ct)
    }

    // Y-axis coordinate labels
    for (y, ct) in ((-1, $ -1 $), (-0.5, $ -1/2 $), (0.5, $ 1/2 $), (1, $ 1 $)) {
      line((32pt, y), (-3pt, y)) // Cleaned up label alignment variable
      content((), anchor: "east", ct)
    }

    // Angle marker placement
    cetz.angle.angle((0, 0), (1, 0), (1, calc.tan(30deg)), label: text(green, [#sym.alpha]))

    // Hypotenuse line construction
    line((0, 0), (1, calc.tan(30deg)))
    set-style(stroke: (thickness: 1.2pt))

    // Sine rendering track
    line((30deg, 1), ((), "|-", (0, 0)), stroke: (paint: red), name: "sin")
    content(("sin.start", 50%, "sin.end"), text(red)[$ sin alpha $])

    // Cosine rendering track
    line("sin.end", (0, 0), stroke: (paint: blue), name: "cos")
    content(("cos.start", 50%, "cos.end"), text(blue)[$ cos alpha $], anchor: "north")

    // Tangent rendering track
    line((1, 0), (1, calc.tan(30deg)), name: "tan", stroke: (paint: orange))
    content("tan.end", $ text(#orange, tan alpha) = text(#red, sin alpha) / text(#blue, cos alpha) $, anchor: "west")
  }),
  caption: [Trigonometric unit circle visualization drawn dynamically using CeTZ.],
)





#figure(
  cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(size: (2, 2), x-tick-step: none, y-tick-step: none, {
      plot.add(((0, 0), (1, 1), (2, .5), (4, 3)))
    })
  }),
  caption: [Cetz plot visualization drawn dynamically using CeTZ-plot.],
)

#let x = lq.linspace(0, 10, num: 1000)
#let y = x.map(x => calc.sin(0.1 * x * x))

#figure(
  lq.diagram(
    lq.plot(x, y),
    lq.plot(x, x => calc.sin(x + 0.541)),
  ),
  caption: [Lilaq plot visualization drawn dynamically.],
)
#figure(
  lq.diagram(
    lq.plot(x, x => 1 - calc.exp(-1 * x), mark: none),
    lq.plot(x, x => 1 - calc.exp(-2 * x), mark: none),
    lq.plot(x, x => 1 - calc.exp(-10 * x), mark: none),
    lq.plot(x, x => (1 - calc.exp(-2 * x)), mark: none),
    lq.plot(x, x => 2 * (1 - calc.exp(-2 * x)), mark: none),
    lq.plot(x, x => 3 * (1 - calc.exp(-2 * x)), mark: none),
  ),
  caption: [Lilaq plot step response.],
)

#page(width: auto, height: auto, margin: 0.5cm)[
  #figure(
    lq.diagram(
      lq.plot(x, x => 1 - calc.exp(-1 * x), mark: none),
      lq.plot(x, x => 1 - calc.exp(-2 * x), mark: none),
      lq.plot(x, x => 1 - calc.exp(-10 * x), mark: none),
      lq.plot(x, x => (1 - calc.exp(-2 * x)), mark: none),
      lq.plot(x, x => 2 * (1 - calc.exp(-2 * x)), mark: none),
      lq.plot(x, x => 3 * (1 - calc.exp(-2 * x)), mark: none),
    ),
    caption: [Lilaq plot step response.],
  )
]
