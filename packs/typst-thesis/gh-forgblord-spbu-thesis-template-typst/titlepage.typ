// =====
// THIS IS CONFIG FILE FOR THE TITLEPAGE
// =====

#let author_thesis_name(
  author_name: (
    first_name: "Павел",
    last_name: "Павлов",
    patronymic: "Павлович",
  ),
  thesis_title: "Очень сложная выпускная квалификационная работа",
) = [
  #align(center)[
    #set text(size: 18pt)
    #text(style: "italic", weight: "bold")[
      #upper(author_name.at("last_name")) #author_name.at("first_name") #author_name.at("patronymic")
    ]

    #text(weight: "bold")[
      Выпускная квалификационная работа
    ]

    #text(style: "italic", weight: "bold")[
      #thesis_title
    ]
  ]
]

#let education_info(
  education_level: "бакалавриат / специалитет / магистратура / аспирантура",
  field_of_study: (
    code: "00.00.00",
    name: "Направление обучения X",
  ),
  program_name: (
    code: "ПУ.0000.1900",
    name: "Название основной образовательной программы"
  ),
) = [
  #align(center)[
    Уровень образования: #education_level

    Направление
    #text(style: "italic")[
      #field_of_study.at("code")
      "#field_of_study.at("name")"
    ]

    Основная образовательная программа
    #text(style: "italic")[
      #program_name.at("code")
      "#program_name.at("name")"
    ]
  ]
]

#let evaluator_person(
  person_relation: "Научный руководитель",
  person: (
    position: "",
    dept: "",
    degree: "",
    academ_title: "",
    name: "",
  ),
) = [
    #set par(
      justify: false,
      leading: 0.5em,
      first-line-indent: 0em,
      spacing: 0.5em,
    )
    #align(left)[
      #person_relation:

      #person.values().join(",\n")
    ]
]

#let pub_year(
  year: "1900",
) = [
  #align(center+bottom)[
      Санкт-Петербург

      #year
  ]
]

#let title_page(
  author_name: (
    first_name: "Павел",
    last_name: "Павлов",
    patronymic: "Павлович",
  ),
  thesis_title: "Такого исследования вы еще не видели!",
  education_level: "магистратура",
  field_of_study: (
    code: "00.00.00",
    name: "Очень сложное направление",
  ),
  program_name: (
    code: "ПИ.0000.1900",
    name: "Непростая образовательная программа",
  ),
  supervisor_person: (
    position: "",
    dept: "",
    degree: "",
    academ_title: "",
    name: "",
  ),
  reviewer_person: (
    position: "",
    dept: "",
    degree: "",
    academ_title: "",
    name: "",
  ),
  year: "2026",
) = [
  #set page(numbering: none)

  #align(center)[
    Санкт-Петербургский государственный университет
  ]

  #v(20mm)

  #author_thesis_name(
    author_name: author_name,
    thesis_title: thesis_title,
  )

  #v(20mm)

  #education_info(
    education_level: education_level,
    field_of_study: field_of_study,
    program_name: program_name,
  )

  #v(25mm)

  #align(right)[
    #block(width: auto)[
      #evaluator_person(
        person_relation: "Научный руководитель",
        person: supervisor_person,
      )

      #v(10mm)

      #evaluator_person(
        person_relation: "Рецензент",
        person: reviewer_person,
      )
    ]
  ]

  #pub_year(year: year)
]

#title_page(
  author_name: (
    first_name: "Павел",
    last_name: "Павлов",
    patronymic: "Павлович",
  ),
  thesis_title: "Такого исследования вы еще не видели!",
  education_level: "магистратура",
  field_of_study: (
    code: "00.00.00",
    name: "Очень сложное направление",
  ),
  program_name: (
    code: "ПИ.0000.1900",
    name: "Непростая образовательная программа",
  ),
  supervisor_person: (
    position: "профессор",
    dept: "кафедра умных наук",
    degree: "доктор физ.-мат. наук",
    name: "Пупкин Иван Иванович",
  ),
  reviewer_person: (
    position: "очень крутая позиция",
    dept: "АОА Завод высокоточных деталей",
    name: "Олегов Олег Олегович",
  ),
  year: "2026",
)
