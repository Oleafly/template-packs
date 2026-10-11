#import "../func/utils.typ": under-construction

= PRESENTATION OF THE PROJECT

...

== Problematic
...

- ...
- ...
- ...
- ...
- ...

== Project Objective
...

- ...
- ...
- ...
- ...


== Targeted Impact

...

== Methodology

...

== Project Timeline
...

// @typstyle off
#figure(
  align(center)[
    #set text(size: 10pt)

    #let task-row(..weeks) = (
      ..weeks
        .pos()
        .map(w => {
          if w == [x] {
            table.cell(fill: rgb("#fede6a"))[]
          } else {
            []
          }
        }),
    )

    #table(
      columns: (23%, ..(77% / 24,) * 24),
      table.header(
        table.cell(align: center, rowspan: 2)[#strong[Tasks]],
        table.cell(align: center, colspan: 24)[#strong[Weeks]],
        ..range(1, 25).map(i => table.cell(align: center, inset: (y: 8pt, x: 0pt))[#strong[#i]]),
      ),
      inset: (left: 8pt, y: 7.7pt, right: 0pt),

      // Tasks
      table.cell(align: left)[1],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[2],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [ ], [ ], [ ], [ ], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[3],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [ ], [ ], [x], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[4],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [x], [ ], [x], [ ], [x], [ ], [ ], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[5],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [x], [ ], [x], [ ], [ ], [x], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[6],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [ ], [ ], [ ], [ ], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[7],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[8],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [ ], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),
    )
  ],
  caption: [The project timeline and how the work was split across the internship period over 24 weeks, noted by the colored cells.],
) <activity_table>
// @typstyle on
