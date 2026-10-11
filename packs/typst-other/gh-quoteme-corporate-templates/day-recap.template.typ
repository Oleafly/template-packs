// day-recap.template.typ

#let ink = rgb("#1d2733")
#let muted = rgb("#5d6875")
#let rule = rgb("#cfd6dd")
#let accent = rgb("#1d4ed8")
#let done-color = rgb("#16a34a")
#let pending-color = rgb("#d97706")

#let todo-item(label, done: false) = {
  let marker = if done { text(fill: done-color)[#sym.checkmark] } else { text(fill: pending-color)[#sym.circle.stroked.small] }
  let label-color = if done { muted } else { ink }
  grid(
    columns: (14pt, 1fr),
    column-gutter: 6pt,
    align(top)[#marker],
    align(top)[#text(size: 10.5pt, fill: label-color)[#label]],
  )
  v(5pt)
}

#let day-recap(
  date: datetime.today(),
  todos: (),
  notes: none,
  body,
) = {
  let date-str = date.display("[day padding:zero].[month padding:zero].[year]")
  let weekday = date.display("[weekday repr:long]")

  set page(
    paper: "a4",
    margin: (top: 1.6cm, bottom: 1.8cm, x: 1.8cm),
    footer: context align(right)[
      #text(size: 8.5pt, fill: muted)[
        Day Recap #h(12pt) #counter(page).display("1 / 1", both: true)
      ]
    ],
  )
  set text(
    font: ("Avenir Next", "Helvetica Neue", "Arial"),
    fill: ink,
    size: 10.5pt,
  )
  set par(justify: true, leading: 0.7em)
  set heading(numbering: none)

  show heading.where(level: 1): it => block(above: 18pt, below: 12pt)[
    #text(size: 15pt, weight: "bold", fill: ink)[#it.body]
    #v(6pt)
    #line(length: 100%, stroke: (paint: rule, thickness: 0.8pt))
  ]

  show heading.where(level: 2): it => block(above: 14pt, below: 8pt)[
    #text(size: 11.5pt, weight: "semibold", fill: ink)[#it.body]
  ]

  // Header
  text(size: 8.5pt, tracking: 0.16em, fill: muted)[DAY RECAP]
  v(10pt)
  text(size: 28pt, weight: "bold", fill: ink)[#date-str]
  v(4pt)
  text(size: 13pt, fill: muted)[#weekday]

  v(20pt)
  line(length: 100%, stroke: (paint: rule, thickness: 1pt))
  v(16pt)

  // Todos section
  if todos.len() > 0 {
    text(size: 9pt, weight: "semibold", fill: muted)[TODOS]
    v(10pt)
    for item in todos {
      if type(item) == array {
        todo-item(item.at(0), done: item.at(1))
      } else {
        todo-item(item)
      }
    }
    v(8pt)
    line(length: 100%, stroke: (paint: rule, thickness: 0.8pt))
    v(16pt)
  }

  // Notes / recap section
  if notes != none {
    text(size: 9pt, weight: "semibold", fill: muted)[NOTES]
    v(8pt)
    text(size: 10.5pt, fill: ink)[#notes]
    v(16pt)
    line(length: 100%, stroke: (paint: rule, thickness: 0.8pt))
    v(16pt)
  }

  body
}
