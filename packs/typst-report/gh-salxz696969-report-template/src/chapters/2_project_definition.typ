= PROJECT PRESENTATION AND SCOPE <ch_project_presentation>

In this chapter, we will describe the project in more detail, including
  general presentation of the project, problematic, objectives, and
  project planning.

== General Presentation of the Project

TO FILL — Describe the project: what it is, its purpose, who it serves,
  and the main problems it solves.

== Problematic

TO FILL — Describe the main problems or challenges that the project
  addresses. List each problem with a brief explanation.

== Objectives

TO FILL — List the objectives of the project. Each objective should
  respond to the problems identified above.

== Planning of Project

TO FILL — Describe the project planning: how the project was introduced,
  the workflow, and how tasks were organized throughout the internship.

== Methodology

TO FILL — Describe the development methodology and workflow followed
  during the internship (e.g., Agile, Kanban, Scrum).

== Project Timeline

TO FILL — Provide a project timeline table showing the main phases and
  weeks of the internship.

#figure(
  align(center)[
    #set text(size: 9pt)

    #let task-row(..weeks) = (
      ..weeks
        .pos()
        .map(w => {
          if w == [x] {
            table.cell(fill: rgb("#299ddc"))[]
          } else {
            []
          }
        }),
    )

    #table(
      columns: (25%, ..(75% / 13,) * 13),
      table.header(
        table.cell(align: center, rowspan: 2)[*Tasks*],
        table.cell(align: center, colspan: 13)[*Weeks*],
        ..range(1, 14).map(i => table.cell(align: center)[*#i*]),
      ),

      table.cell(align: left)[TO FILL],
      ..task-row([x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[TO FILL],
      ..task-row([ ], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[TO FILL],
      ..task-row([ ], [ ], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x]),

      table.cell(align: left)[TO FILL],
      ..task-row([ ], [ ], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x]),

      table.cell(align: left)[TO FILL],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [x]),
    )
  ],
  caption: [TO FILL — Activities timeline],
) <activity_table>


