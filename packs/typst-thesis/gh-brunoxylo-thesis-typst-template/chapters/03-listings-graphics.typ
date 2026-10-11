#import "@preview/glossarium:0.5.3": make-glossary, print-glossary, gls, glspl
#import "@preview/cetz:0.3.3": canvas, draw, palette
#import "@preview/cetz-plot:0.1.1": plot
#import "../thesis_typ/helper-functions.typ": *
#import "../figures/graph.typ": example_graph

= Listings and Graphics
<ch:listings-graphics>

== Listings

Enumeration with bullets: \
- Item
- Item
 - Sub-item
  - Sub-sub-item

Enumeration with numbers: \
+ Item
+ Item
 + Sub-items appear the same here

== Graphics
Try to use SVGs for the figures. They are vector graphics and can be scaled without loss of quality. \
You can export a chart as svg in powerpoint by right clicking on it and selecting "Save as Picture". \
Then select "SVG" as file format. \
Alternatively, PNG, JPEG, GIF are supported by typst. \

#figure(
  image("../figures/figure1.svg", width: 100%),
  caption: [A generic chart],
) <fig:chart1>

#v(10pt)

#figure(
  image("../figures/figure2.svg", width: 100%),
  caption: [Another generic chart],
) <fig:chart1>

#pagebreak()

== Tables
You can use the table function to create tables. \

#let example-table = table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,

  [],
  [*Area*],
  [*Parameters*],

  [cylinder],
  [$ pi h (D^2 - d^2) / 4 $],
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],

  [tetrahedron],
  [$sqrt(2) / 12 a^3 $],
  [$a$: edge length]
)

#figure(
  example-table,
  caption: [A table example],
) <tab:table1>

=== Another bigger table

#let table_data = (
    [*RabbitMQ*], [Baseline (klein)], [1], [1], [1 Queue], [1 KB], [],
    [], [Baseline (groß)], [1], [1], [1 Queue], [1 MB], [],
    [], [Mehrere Producer], [3], [1], [1 Queue], [10 KB], [],
    [], [Mehrere Queues], [3], [1], [10 Queues], [10 KB], [],
    [], [Viele Queues], [3], [1], [100 Queues], [10 KB], [],
    [], [Einzelner Stream], [1], [1], [1 Stream], [1 KB], [],
    [], [Parallele Streams], [3], [1], [3 Streams], [100 KB], [],
    [], [Viele Streams, Viele Clients], [2], [2], [10 Streams], [10 KB], [],
    [*Apache \ Pulsar*], [Baseline (klein)], [1], [1], [1 Topic], [1 KB], [],
    [], [Baseline (groß)], [1], [1], [1 Topic], [1 MB], [],
    [], [Mehrere Producer], [3], [1], [1 Topic], [10 KB], [],
    [], [Mehrere Topics], [3], [1], [10 Topics], [10 KB], [],
    [], [Batching], [3], [1], [1 Topic], [1 KB], [Batching: 10ms Fenster, 500 Nachrichten max.],
    [], [Batching + Kompression], [3], [1], [1 Topic], [1 KB], [Batching: 10ms Fenster, 500 Nachrichten max., Kompression: LZ4],
    [], [Hohe Parallelität], [2], [0], [100 Topics], [10 KB], [],
    [], [Shared Subscription], [1], [3], [1 Topic], [1 KB], [Subscription-Typ: Shared],
    [], [Failover Subscription], [1], [2], [1 Topic], [1 KB], [Subscription-Typ: Failover],
)

#show table.cell: set text(size: 7.5pt)
#show table.cell.where(x: 6): set text(size: 6pt)
#show table.cell.where(y: 0, x: 6): set text(size: 7.5pt)
#set table(
  // Set horizontal alignment
  stroke: (x, y) => {
    if y == 0 {
      if x > 0 and x < 7 {
        (bottom: 0.7pt + black, left: 0.1pt + black)
      } else {
        (bottom: 0.7pt + black)
      }
    } else if y < 26 {
      if x > 0 and x < 7 {
        (bottom: 0.1pt + black, left: 0.1pt + black)
      } else {
        (bottom: 0.1pt + black)
      }
    } else {
      if x > 0 and x < 7 {
        (left: 0.1pt + black)
      }
    }
  }
)

#figure(
  table(
    columns: (62pt, auto, auto, auto, auto, 30pt, auto),
    align: horizon + center,
    inset: (
      x: 3pt,
      y: 4pt
    ),
    table.header(
      [*Middleware*], [*Testfall*], [*P*], [*C*], [*Topics/Queues/Streams*], [*Nachrichtengröße*], [*Weitere Parameter*]
    ),
    ..table_data
  ),
  caption: [A bigger table example],
)

== Plots

To draw plots directly in typst you can use the `cetz` and `cetz-plot` libraries. \

=== Externally defined functions

As with all types, you can use externally defined functions in a figure like so:

#figure(
  example_graph,
  caption: [A plot example],
) <fig:plot1>

=== Another plot example

#figure(
    canvas({
    let data = (
      // Real-Unoptimized, Real-Optimized, Virtual-Unoptimized, Virtual-Optimized
      ("Windows\nDesktop", (3360.42, 6593.49, 3294.64, 3888.78)),
      ("Windows\nLaptop", (3677.39, 7340.65, 3618.07, 3932.8)),
      ("MacBook\nAir M3", (4141.77, 3977.97, 4094.93, 3884.93)),
      ("Azure VM", (4197.12, 5373.65, 4055.67, 3911.76)),
    )

    draw.set-style(
      legend: (
        stroke: rgb(0, 0, 0, 50),
      ),
      axes:(
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
        y-label: "Runtime (s)",
        y-inset: 0.5pt,
        x-min: -1,
        x-max: 4,
        x-tick-step: none,
        x-ticks: data.map(item => {
          let (host, (real-unop, real-op, virt-unop, virt-op)) = item
          host
        }).map(host => align(center, par(leading: 0.6em, host))).enumerate(),
        x-label: text(v(0.4em) + "Hosts"),
        plot-style: (
          palette.new(
            base: (stroke: (paint: rgb(0, 0, 0, 0), thickness: 0pt), fill: none),
            colors: ("#f34949", "#FF8133", "#96EB46", "#25DB00").map(rgb),
          )
        ),
        {
          plot.add-bar(
            data.map(item => {
              let (host, (real-unop, real-op, virt-unop, virt-op)) = item
              (real-unop, real-op, virt-unop, virt-op)
            }).enumerate(),
            x-key: 0,
            y-key: 1,
            error-key: none,
            mode: "clustered",
            labels: ([Real-Unoptimized], [Real-Optimized], [Virtual-Unoptimized], [Virtual-Optimized]),
            bar-width: 0.75,
            cluster-gap: 0.04,
            axes: ("x", "y"),
          )
        }
      )
    })
  }),
  caption: [A clustered bar chart example],
)

=== Tables, Images and Plots combined

Tables allow to display all types of content in a structured way. \
You can for example combine tables and plots in a single figure. \

#let horizontal-table(elem1, caption1, elem2, caption2) = {
  set image(width: 120%)
  set table(
    stroke: (x, y) => {(0pt)},
    columns: (auto, 1em, auto),
    inset: 0pt,
    align: horizon
  )

  table(
    pad(figure(elem1, caption: caption1), left: -20%),
    "",
    pad(figure(elem2, caption: caption2), right: -20%)
  )
}

#horizontal-table(image("../figures/example-graph.svg"), "Another plot example", example-table, "Another table example")
