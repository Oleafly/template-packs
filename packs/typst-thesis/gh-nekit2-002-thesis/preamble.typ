// empty underlined table cell
#let underlined = table.cell(stroke: (bottom: 1pt))[]

// resize text to appropriate size (for tables)
#let text_xpt(txt, x) = {
  text(size: x * 1pt)[#txt]
}

// alignment for tables and their captions
#let table_figure(tbl, cap) = {
  figure(
    align(right)[#tbl],
    caption: [#cap],
  )
}

#let file_listing(file, lang, cap) = {
  figure(raw(read(file), lang: lang, block: true), caption: [#cap])
}

#let work_name = "НИР"
#let student_name = "Косенко Н.И."
#let supervisor_name = "Климов В.В."
#let student_group = "М24-514"
#let document_type = "Пояснительная записка"
#let thesis_theme = "Разработка оптимизированного табличного метода доступа для СУБД PostgreSQL"
