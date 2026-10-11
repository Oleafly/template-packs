#import "include/a5x-template.typ": template
#show: doc => template(doc)

#import "include/elements.typ": titled-box, task-lines, note-lines, week-box, tracker

#grid(columns: (1fr, 136pt),
  [
    #set text(size: 20pt)
    #h(5pt)
    Daily
  ],
  week-box()
)

#tracker()

#titled-box(title: "Notes",
  note-lines(19)
)
