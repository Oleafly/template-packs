#import "../preamble.typ": (
  document_type, 
  student_name, 
  supervisor_name,
  text_xpt,
  thesis_theme,
  underlined
)

#set page(
  footer: [*Москва 2026*],
)

#set text(
  size: 12pt,
  hyphenate: false,
)
#set par(spacing: 5pt, leading: 0.65em)
#set align(center)
МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ

#text(size: 6pt)[ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ]

#text(size: 11pt)[*Национальный исследовательский ядерный университет «МИФИ»*]

#line(length: 100%, stroke: 2pt)
#linebreak()

#{
  show table.cell.where(y: 0): set text(
    size: 15pt,
  )

  show table.cell.where(y: 1): set text(
    size: 15pt,
  )
  show table.cell.where(y: 2): set text(
    size: 14pt,
  )

  show table.cell.where(y: 3): set text(
    size: 20pt,
    weight: "bold",
  )

  show table.cell.where(y: 4): set text(
    size: 14pt,
  )
  table(
    columns: (auto, 80%),
    stroke: none,
    table.cell(rowspan: 2, image("../images/mephi.png", width: 3.56cm, height: 1.92cm, format: "png")),
    [#align(center)[*Институт \
      интеллектуальных кибернетических систем*
    ]],
    [
      *Кафедра №22 «Кибернетика»*
      #linebreak()
      #linebreak()
    ],
    table.cell(colspan: 2, "Направление подготовки 09.04.04 Программная инженерия\n\n"),
    table.cell(colspan: 2, document_type),
    table.cell(colspan: 2, "к научно-исследовательской работе студента на тему:\n\n"),
  )
}

#set text(
  size: 15pt,
)
#set align(center)

#thesis_theme
#linebreak()
#line(length: 100%)
#linebreak()

#let author_cells = ([], text_xpt("(подпись)", 9), [], text_xpt("(ФИО)", 9))

#table(
  columns: (1.2fr, 1fr, 0.2fr, 1fr),
  stroke: none,
  align: (left, center, center, center),
  text_xpt("Группа", 13),
  table.cell(stroke: (bottom: 1pt))[М24-514],
  [], [],
  [#linebreak()
    #text_xpt("Студент", 13)],
  underlined, [],
  table.cell(stroke: (bottom: 1pt))[
    #linebreak()
    #student_name
  ],
  ..author_cells,
  text_xpt("Руководитель", 13), underlined, [],
  table.cell(stroke: (bottom: 1pt))[#supervisor_name],
  ..author_cells,
  text_xpt("Научный консультант", 13), underlined, [], underlined,
  ..author_cells,
)

#table(
  columns: (1.1fr, 1fr, 1.1fr, 1fr),
  align: (center, center, center, center),
  stroke: none,
  text_xpt("Оценка руководителя", 13), underlined, text_xpt("Оценка консультанта", 13), underlined,
  [], text_xpt("(0-30 баллов)", 9), [], text_xpt("(0-30 баллов)", 9),
  [], [], [], [],
  text_xpt("Итоговая оценка", 13), underlined, text_xpt("ECTS", 13), underlined,
  [], text_xpt("(0-100 баллов)", 9), [], [],
  table.cell(colspan: 4, "\nКомиссия"),
)

#table(
  columns: (1.5fr, 1.5fr, 0.3fr, 1.5fr, 1fr),
  align: (center, center, center, center, center),
  stroke: none,
  text_xpt("Председатель", 13), underlined, [], underlined, [],
  ..author_cells, [],
  [], underlined, [], underlined, [#linebreak()],
  ..author_cells, [],
  [], underlined, [], underlined, [#linebreak()],
  ..author_cells, [],
  [], underlined, [], underlined, [#linebreak()],
  ..author_cells, [],
)

