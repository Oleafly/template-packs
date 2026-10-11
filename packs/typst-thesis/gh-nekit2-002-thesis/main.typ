#set page(
  margin: (
    right: 10mm,
    bottom: 20mm,
    left: 30mm,
    top: 20mm,
  ),
)
#set text(font: "Times New Roman", lang: "ru", hyphenate: true, size: 13pt)
#set par(justify: true, first-line-indent: (amount: 1.25cm, all: true), spacing: 1em, leading: 1em)


// title
#include "title/title.typ"
// task
#include "task/task.typ"

#set page(numbering: "1")
#counter(page).update(2)
#set heading(numbering: "1.1.")
#show heading: set align(left)
#show heading.where(level: 1): set align(center)
#set enum(indent: 7mm)
#set list(indent: 7mm, marker: [--])
#include "contents.typ"

