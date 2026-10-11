#import "@preview/cetz:0.3.3": canvas, draw, palette
#import "@preview/cetz-plot:0.1.1": plot

#let example_graph = canvas({
  let data = (
    ("CPU T1 1000", 50),
    ("CPU T1 10000", 10),
    ("CPU T1 100000", 11),
    ("CPU T2 1000", 90),
    ("CPU T2 10000", 60),
    ("CPU T2 100000", 60)
  ).enumerate()

  draw.set-style(
    legend: (
      stroke: rgb(0, 0, 0, 50),
    ),
    axes: (
      tick: (
        length: 0cm,
      )
    )
  )

  draw.group(ctx => {
    plot.plot(
      size: (10, 5),
      axis-style: "scientific-auto",
      y-grid: true,
      y-label: "Deviation (%)",
      y-inset: 0.5pt,
      y-max: 100,
      x-min: -1,
      x-max: 6,
      x-tick-step: none,
      x-ticks:
        data.map(item => {
          let (i, (x, y)) = item
          x
        }).map(testname => rotate(65deg, pad(left: 75pt, rect(width: 80pt, stroke: none, inset: 0pt, align(left, par(leading: 0.6em, text(size: 6pt, testname))))))).enumerate(),
      x-label: text(v(4em) + "Test Name"),
      plot-style: (
        palette.new(
          base: (stroke: (paint: rgb(0, 0, 0, 0), thickness: 0pt), fill: none),
          colors: ("#59E054",).map(rgb),
        )
      ),
      {
        plot.add-bar(
          data.map(item => {
              let (i, (x, y)) = item
              (i, y)
          }),
          x-key: 0,
          y-key: 1,
          error-key: none,
          mode: "basic",
          labels: none,
          bar-width: 0.4,
          axes: ("x", "y"),
        )
      }
    )
  })
})
