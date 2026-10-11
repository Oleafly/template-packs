#import "../metadata.typ": *

= Member list & Workload

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: (center, center, center, left, center),
    stroke: 0.5pt,
    inset: 5pt,
    [*No.*], [*Fullname*], [*Student ID*], [*Problems*], [*Percentage of work*],
    ..members.enumerate().map(((i, m)) => (
      [#(i + 1)], 
      [#m.name], 
      [#m.id], 
      [#m.problems.join(linebreak())],
      [#m.work]
    )).flatten()
  )
]
