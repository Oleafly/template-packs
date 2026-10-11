// A content-heavy conference poster: A0 portrait with three columns, a figure
// spanning all columns, a chart, a table, math and a multi-column footer.
// The study is made up; only the reference to Little's law is real.
#import "../tum-poster/lib.typ": poster, tum-colors

#show: poster.with(
  size: "a0",
  orientation: "portrait",
  lang: "en",
  title: [Why the Other Queue Is Always Faster],
  subtitle: [A queueing-theoretic field study at the university canteen],
  tagline: [Erika Mustermann, Max Mustermann · Workshop on Everyday Operations Research 2026],
  author: ("Erika Mustermann", "Max Mustermann"),
  faculty: [School of Computation, Information and Technology],
  chair: [Chair of Applied Waiting],
  header: "full",
  footer: (
    [*Technical University of Munich* \
      School of Computation, Information and Technology \
      Chair of Applied Waiting],
    [*Contact* \
      Erika Mustermann \
      erika.mustermann\@example.org],
    [*Data* \
      14 weeks of stopwatch readings, \
      available on request and on paper],
    [*Funding* \
      Self-funded through the canteen card \
      of the first author.],
  ),
)

// Draws a horizontal bar chart with plain Typst shapes, so the example needs
// no image files or packages.
#let bar-chart(data, max: 100, unit: "") = grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  row-gutter: 0.6em,
  align: (right + horizon, left + horizon),
  ..data
    .map(((label, value, color)) => (
      label,
      box(width: value / max * 100%, height: 1.2em, fill: color, inset: (x: 0.4em))[
        #set text(fill: white, weight: "bold")
        #align(right + horizon)[#value#unit]
      ],
    ))
    .flatten(),
)

#place(top, scope: "parent", float: true, figure(
  block(width: 100%, height: 22cm, fill: tum-colors.secondary-grey-light, {
    set align(center + horizon)
    set text(size: 60pt, fill: tum-colors.secondary-blue-dark)
    grid(
      columns: 7,
      column-gutter: 2.5cm,
      [Hungry], [→], [Queue], [→], [Doubt], [→], [Switch queue],
    )
  }),
  caption: [The decision process of a typical canteen visitor. The loop from
    _Switch queue_ back to _Doubt_ is left out for readability.],
))

= Motivation
Every lunchtime, thousands of people pick a queue at the canteen and
immediately suspect they picked the wrong one. Folk wisdom says the other
queue is always faster.

We wanted to find out if that is *actually true* or if it just feels that way
after ten minutes of waiting.

= Contributions
- The first stopwatch-based study of queue envy at a university canteen
- A model that explains why the other queue _looks_ faster
- A practical strategy for choosing a queue, tested on ourselves
  - 70 lunches per author
  - 2 stopwatches and a lot of patience

= Method
We model each counter as a queue with arrival rate $lambda$ and mean waiting
time $W$. By Little's law, the mean number of people in a queue is

$ L = lambda W $

so a queue that looks short is not necessarily fast. Every visitor was offered
a choice between two queues, and we timed both. Nobody was timed without being
asked, and everyone got to keep their lunch.

#colbreak()

= Results
On average, neither queue was faster. People just watch the other queue the
whole time and hardly notice when their own one moves.

#figure(
  bar-chart(
    (
      ([The queue you picked], 100, tum-colors.secondary-grey-mid),
      ([The queue next to you], 99, tum-colors.secondary-grey-dark),
      ([*How fast it feels*], 62, tum-colors.primary-blue),
    ),
    unit: "%",
  ),
  caption: [Mean waiting time relative to the chosen queue. The last bar shows
    the waiting time participants estimated for the other queue.],
)

#figure(
  table(
    columns: 4,
    stroke: none,
    align: (left, right, right, right),
    table.hline(),
    table.header([*Day*], [*Visitors*], [*Mean wait*], [*Queue switches*]),
    table.hline(stroke: 0.5pt),
    [Monday], [1,210], [6.5 min], [0.4],
    [Wednesday], [1,480], [8.0 min], [0.7],
    [Pasta day], [2,030], [11.5 min], [1.9],
    table.hline(),
  ),
  caption: [Measurements per day. Queue switches are per visitor.],
)

= Limitations
All measurements were taken before lunch, when the authors were hungry and
possibly biased. Dessert queues were excluded from the study for reasons of
self-control.

#colbreak()

= Conclusion
The other queue only looks faster. Our advice is to pick any queue, stay in
it and chat with the people around you. Switching cost 1.2 minutes on average
and never paid off.

= Next steps
- Repeat the study at the coffee machine
- Test whether a nice conversation shortens the perceived wait
- Find out why pasta day is always so popular

= References
#set text(size: 0.8em)
+ J. D. C. Little. "A Proof for the Queuing Formula: $L = lambda W$."
  _Operations Research_ 9(3), 1961.
+ E. Mustermann. "Notes from the back of the queue." Unpublished notebook,
  mostly lunch orders, 2026.
