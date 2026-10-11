#import "../lib/lib.typ": signature_field, under_field, year_field
#import "../lib/page.typ": cover_page
#import "../report/lib/index.typ": report_labels

#let task_list(start: 1, body) = {
  set enum(
    numbering: "1.",
    start: start,
    body-indent: 5mm,
  )
  body
}

#let task_line(body) = enum.item(body)

#let task_row(number: none, body) = grid(
  columns: (9mm, 1fr),
  column-gutter: 3mm,
  align: top,
  [#number.], body,
)

#let default_assignment_meta = (
  university_line: [НАЦІОНАЛЬНИЙ ТЕХНІЧНИЙ УНІВЕРСИТЕТ УКРАЇНИ\ "КИЇВСЬКИЙ
    ПОЛІТЕХНІЧНИЙ ІНСТИТУТ\ імені ІГОРЯ СІКОРСЬКОГО"],
  faculty: [Факультет інформатики та обчислювальної техніки\ Кафедра
    обчислювальної техніки],
  education_level: [Рівень вищої освіти -- перший (бакалавр)\
    Освітньо-професійна програма\ "Інженерія програмного забезпечення
    комп'ютерних систем"\
    спеціальності 121 “Інженерія програмного забезпечення”],
)

#let assignment_pages(
  meta: none,
  topic: none,
  student_name: none,
  student_name_genitive: none,
  advisor_name: none,
  advisor_line: none,
  head_name: none,
  order_line: none,
  due_date: none,
  input_data: none,
  graphics: none,
  norm_controller: none,
  issue_date: none,
  year: none,
  calendar: none,
  student_sign_name: none,
  advisor_sign_name: none,
) = {
  cover_page[
    #v(18mm)
    #align(center)[
      #align(center)[
        #text(weight: "bold")[#meta.university_line]
        #v(2mm)
        #underline[#meta.faculty]
      ]
      #v(1mm)
      #stack(
        spacing: 10pt,
        [#meta.education_level],
      )
    ]

    #v(6mm)
    #align(right)[
      #block(width: 90mm)[
        #align(right)[
          #text(weight: "bold")[ЗАТВЕРДЖУЮ]\
          #text(weight: "bold")[В. о. завідувача кафедри]
        ]
        #grid(
          columns: (20mm, 60mm),
          align: horizon,
          [ #signature_field() ],
          [
            #under_field(start: 12mm)[ #head_name ]
          ],
        )
        #align(right)[
          #year_field()[#year]
        ]
      ]
    ]

    #v(3mm)
    #align(center)[
      #text(weight: "bold")[ЗАВДАННЯ]\
      на бакалаврський дипломний проєкт студента\
      #v(3mm)
      #underline[#student_name_genitive]
    ]

    #v(7mm)
    #task_list[
      #task_line[
        Тема проєкту #underline[#emph(topic)]\
        керівник проєкту #under_field(caption: [(прізвище, ім'я, по батькові,
          науковий ступінь, вчене звання)])[ #advisor_line ],\
        затверджені наказом по університету від #underline[#order_line]
      ]

      #task_line[
        Термін здачі студентом закінченого проєкту #underline[#due_date]
      ]

      #task_line[
        Вихідні дані до проєкту #underline[#emph(input_data)]
      ]

      #task_line[
        Зміст розрахунково-пояснювальної записки (перелік питань, які
        розробляються)\
        #context for entry in {
          query(report_labels.section).filter(entry => entry.value.level == 1)
        } [
          #h(8mm)#link(entry.location())[
            #underline[#entry.value.body]
          ]\
        ]
      ]
    ]
  ]

  cover_page[
    #task_list(start: 5)[
      #task_line[
        Перелік графічного матеріалу (з точним позначенням обов'язкових
        креслень)
        #underline[#graphics]
      ]

      #task_line[
        Консультанта проєкту, з вказівкою розділів проєкту, які до них вносяться
      ]
    ]

    #v(2mm)
    #box(width: 171mm)[
      #table(
        columns: (37mm, 1fr, 34mm, 34mm),
        rows: (auto, auto, 9mm, 9mm),
        stroke: 0.6pt,
        inset: 5pt,
        align: horizon + center,
        table.cell(rowspan: 2)[Розділ],
        table.cell(rowspan: 2)[Консультант],
        table.cell(colspan: 2)[Підпис, дата],
        [Завдання\ видав],
        [Завдання\ прийняв],
        [Нормоконтроль],
        [#norm_controller],
        [],
        [],
        [],
        [],
        [],
        [],
      )
    ]

    #v(8mm)
    #task_list(start: 7)[
      #task_line[
        Дата видачі завдання #underline[#issue_date]
      ]
    ]

    #v(5mm)
    #align(center)[Календарний план]
    #box(width: 172mm)[
      #table(
        columns: (10mm, 77mm, 55mm, 1fr),
        stroke: 0.6pt,
        inset: (x: 2pt, y: 3pt),
        align: horizon + left,
        [№\ п/п],
        [Найменування етапів\ дипломного проєкту],
        [Терміни виконання\ етапів проєкту],
        [Примітки],
        ..calendar
          .enumerate()
          .map(((index, row)) => (
            [#calc.round(index + 1).],
            [#emph(row.at(0))],
            [#row.at(1)],
            [#row.at(2)],
          ))
          .flatten(),
      )
    ]

    #v(10mm)
    #grid(
      columns: (auto, auto, 5mm, 1fr),
      column-gutter: 2mm,
      row-gutter: 7mm,
      align: horizon,
      [Студент-дипломник],
      [#signature_field()],
      [],
      [#under_field(
        width: 100%,
        body_align: right,
      )[
        #student_sign_name
      ]],

      [Керівник проєкту],
      [#signature_field()],
      [],
      [#under_field(
        width: 100%,
        body_align: right,
      )[
        #advisor_sign_name
      ]],
    )
  ]
}
