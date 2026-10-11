#import "../preamble.typ": student_group, student_name, supervisor_name, text_xpt, thesis_theme, underlined, work_name

#set text(
  size: 10pt,
)
#set par(spacing: 5pt, justify: false, leading: 0.65em)
#set align(center)
МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ

ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ \ ВЫСШЕГО ОБРАЗОВАНИЯ

#text(size: 14pt)[*Национальный исследовательский ядерный университет \ «МИФИ»*]
#line(length: 100%, stroke: 2pt)

#{
  show table.cell.where(y: 0): set text(
    size: 15pt,
  )

  show table.cell.where(y: 1): set text(
    size: 15pt,
  )

  show table.cell.where(y: 2): set text(
    size: 24pt,
    weight: "bold",
  )

  table(
    columns: (auto, 80%),
    stroke: none,
    table.cell(rowspan: 2, image("../images/mephi.png", width: 3.56cm, height: 1.92cm, format: "png")),
    [*Институт
      интеллектуальных кибернетических систем*

      #linebreak()],
    [
      *КАФЕДРА КИБЕРНЕТИКИ*
      #linebreak()
      #linebreak()
    ],
    table.cell(colspan: 2, "Задание на " + work_name),
  )
}

#linebreak()
#table(
  columns: (1fr, 0.7fr, 0.7fr, 2fr),
  stroke: none,
  text_xpt("Студенту гр.", 14),
  table.cell(stroke: (bottom: 1pt))[#text(student_group, size: 14pt)],
  [],
  table.cell(stroke: (bottom: 1pt))[#text("Косенко Никите Игоревичу", size: 14pt)],
  [], text_xpt("(группа)", 9), [], text_xpt("(фио)", 9),
)

#linebreak()

#text("ТЕМА " + work_name, size: 16pt, weight: "bold")

#linebreak()
#linebreak()

#set text(size: 15pt)
#set align(center)
// Разработка оптимизированного табличного метода доступа для СУБД PostgreSQL
#thesis_theme
#linebreak()
#line(length: 95%)

#linebreak()
#linebreak()
#text("ЗАДАНИЕ", size: 16pt, weight: "bold")
#include "task_table.typ"
#linebreak()

#show table: set text(size: 12pt)
#table(
  columns: (0.4fr, 0.6fr, 0.4fr, 1.7fr, 1.2fr, 0.2fr, 2.2fr, 2.1fr, 0.5fr, 2.5fr),
  align: (left, center),
  stroke: none,

  table.cell(rowspan: 2, colspan: 5)[Дата выдачи задания: #linebreak() #linebreak()],
  [],
  [Руководитель],
  underlined,
  [],
  table.cell(stroke: (bottom: 1pt))[#supervisor_name],

  [],
  [],
  [],
  [],
  text_xpt("(ФИО)", 9),

  [«], underlined, [»], underlined,
  [2026 г.], [], [Студент], underlined, [],
  table.cell(stroke: (bottom: 1pt))[#student_name],

  [], [], [], [], [], [], [], [], [], text_xpt("(ФИО)", 9),
)

#pagebreak()
