#import "@preview/timeliney:0.4.0"

#figure(timeliney.timeline(
  show-grid: true,
  {
    import timeliney: *
    
    headerline(group(([*20xx*], 6)))
    headerline(
      group("Mars"),
      group("Avril"),
      group("Mai"),
      group("Juin"),
      group("Juillet"),
      group("Août"),
    )
  
    taskgroup(title: [*Tâche A*], {
      task("Sous-tâche A1", (0, 0.5), style: (stroke: 2pt + green))
      task("Sous-tâche A2", (0.5, 1), style: (stroke: 2pt + green))
    })

    taskgroup(title: [*Tâche B*], {
      task("Sous-tâche B1", (1, 1.5), style: (stroke: 2pt + yellow))
      task("Sous-tâche B2", (1.5, 2), style: (stroke: 2pt + yellow))
    })
    taskgroup(title: [*Tâche C*], {
      task("Etat de l'art ML", (2, 3), style: (stroke: 2pt + blue))
      task("Sous-tâche C1", (3, 4), style: (stroke: 2pt + blue))
      task("Sous-tâche C2", (4,6), style: (stroke: 2pt + blue))
    })
    // taskgroup(title: [*Marketing*], {
    //   task("Press demos", (3.5, 7), style: (stroke: 2pt + gray))
    //   task("Social media advertising", (6, 7.5), style: (stroke: 2pt + gray))
    // })

    // milestone(
    //   at: 3.75,
    //   style: (stroke: (dash: "dashed")),
    //   align(center, [
    //     *Conference demo*\
    //     Dec 2023
    //   ])
    // )

    // milestone(
    //   at: 6.5,
    //   style: (stroke: (dash: "dashed")),
    //   align(center, [
    //     *App store launch*\
    //     Aug 2024
    //   ])
    // )
  }
),caption:[Exemple de diagramme de Gantt])<gantt>
