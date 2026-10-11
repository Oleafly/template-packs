#import "../env.typ": env

#let cover() = {
  set align(center)
  set text(18pt)

  v(20mm)
  [#text(size: 20pt)[卒~~業~~論~~文]]

  v(15mm)
  box(width: 145mm)[
    #align(center)[#env.thesis_title]
  ]
  v(40mm)
  stack(
    dir: ttb,
    spacing: 3mm,
    text(size: 18pt)[#env.college_name #env.faculty_name],
    text(size: 18pt)[ #env.department_name],
  )
  v(15mm)
  [#env.student_name]
  v(25mm)
  [#env.year_of_grad 年度]
  v(10mm)
  [指導教員：#env.supervisor_name]
  pagebreak()
}
