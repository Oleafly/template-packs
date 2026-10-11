#import "common.typ": Large, large, inline, underwrite

#let mk_title_header() = {
  set align(center)
  set par(spacing: 0pt, justify: false, leading: 0.5em)
  set text(size: 11pt, weight: "bold")
  
  [
    Министерство~науки~и~высшего~образования~Российской~Федерации
    #v(1.5em)
    Федеральное~государственное~автономное~образовательное~учреждение~высшего~образования
    "Московский~государственный~технический~университет~имени
    Н.Э.~Баумана (национальный~исследовательский~университет)" #linebreak()
    (МГТУ~им.~Н.Э.~Баумана)
  ]
  
  v(1em)
  line(length: 100%, stroke: 2pt)
  v(3pt)
  line(length: 100%, stroke: 0.5pt)
}

#let mk_title_location(faculty, department) = {
  grid(
    inset: (x: 0pt, y: 0.5em),
    // stroke: black,
    columns: (23%, 1fr),
    [ФАКУЛЬТЕТ],
    underline(faculty),
    [КАФЕДРА],
    underline(department)
  )
}

#let mk_title_main(title, discipline) = {
  set align(center)
  
  text(size: 22pt, underline(upper(title)))
  linebreak()
  text(size: 18pt)[по дисциплине "#discipline"]
}

#let mk_title_properties(author_full, group, theme: none, variant: none) = {
  set align(center)
  set text(size: 14pt)
  
  let theme_prop = if theme != none {
    (grid.hline(), "Тема:", theme)
  } else {
    ()
  }
  
  let variant_prop = if variant != none {
    (grid.hline(), "Вариант:", [#variant])
  } else {
    ()
  }
  
  grid(
    columns: (30%, 50%),
    // stroke: black,
    inset: (y: 0.5em),
    align: left,
    "Студент:", author_full,
    grid.hline(),
    "Группа:", group,
    ..theme_prop,
    ..variant_prop
  )
}

#let mk_title_authors(author, teacher, teacher_position) = {
  set align(center)
  set grid.hline(stroke: 0.75pt)
  set text(size: 12pt)
  
  grid(
    columns: (5fr, 2fr, auto),
    align: bottom + center,
    inset: (y: 0.2em),
    // stroke: black,
    column-gutter: 0.5em,
    grid.cell(align: left + top, "Студент"), none, author,
    grid.hline(start: 1, end: 2), grid.hline(start: 2, end: 3),
    none, text(size: 9pt)[подпись, дата], text(size: 9pt)[Фамилия И.О.],
    grid.cell(align: left + top, teacher_position), none, teacher,
    grid.hline(start: 1, end: 2), grid.hline(start: 2, end: 3),
    none, text(size: 9pt)[подпись, дата], text(size: 9pt)[Фамилия И.О.],
  )
}
