= Appendix
== Project Timeline

The following Gantt chart illustrates our planned project timeline from initial research through final presentation. The timeline is divided into three major phases: Research Phase, Development Phase, and Final Phase.

#figure(
  [
    #set par(leading: 0.5em)

    #import "@preview/timeliney:0.4.0"
    #timeliney.timeline(
      show-grid: true,
      {
        import timeliney: *

        headerline(group(([*2025*], 8)), group(([*2026*], 4)))
        headerline(
          group([*Apr*], [*May*], [*Jun*], [*Jul*], [*Aug*], [*Sep*], [*Oct*], [*Nov*]),
          group([*Dec*], [*Jan*], [*Feb*], [*Mar*], [*Apr*], [*May*]),
        )

        taskgroup(title: [*Research*], {
          task("Title Research", (0, 1.8), style: (stroke: 2pt + blue))
          task(align(center)[Requirements \ Analysis], (0.5, 1.8), style: (stroke: 2pt + blue))
          task(align(center)[Reference \ Exploration], (2, 4), style: (stroke: 2pt + blue))
        })

        taskgroup(title: [*Development*], {
          task(align(center)[Studying About Project], (2, 5), style: (stroke: 2pt + green))
          task(align(center)[Structure \ Design], (3, 4), style: (stroke: 2pt + green))
          task("Unit Tests", (4.5, 11.8), style: (stroke: 2pt + green))
          task(align(center)[Functionality \ Integration], (4.5, 11.8), style: (stroke: 2pt + green))
        })

        taskgroup(title: [*Final Phase*], {
          task("Final Tests", (10.5, 12.5), style: (stroke: 2pt + orange))
          task("Final Refactor", (10.5, 12.8), style: (stroke: 2pt + orange))
          task("Documentation", (10.5, 13.5), style: (stroke: 2pt + orange))
        })

        milestone(
          at: 2,
          style: (stroke: (dash: "dashed")),
          align(center, [
            *Title Defence* \
            Jun 8, 2025
          ]),
        )

        milestone(
          at: 4.5,
          style: (stroke: (dash: "dashed")),
          align(center, [
            *Progress Report* \
            Aug 12, 2025 \
            #super[Today]
          ]),
        )

        milestone(
          at: 10.5,
          style: (stroke: (dash: "dashed")),
          align(center, [
            *Mid-term Report* \
            Feb, 2025
          ]),
        )

        milestone(
          at: 12,
          style: (stroke: (dash: "dashed")),
          align(center, [
            *Final Presentation* \
            March 2026
          ]),
        )
      },
    )
  ],
  caption: "Project Timeline",
)
