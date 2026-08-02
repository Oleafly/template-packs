#let title-page(
  lab-number: "",
  discipline: "",
  student: "",
  group: "",
  teacher: "",
  year: "",
  megafaculty: "Мегафакультет трансляционных информационных технологий",
  faculty: "Факультет информационных технологий и программирования",
  logo: "itmo-logo.png",
  body
) = {
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm)
  )
  set text(font: "Times New Roman", size: 14pt, lang: "ru")
  set par(leading: 0.6em)

  align(center)[
    #text(weight: "bold")[МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ]\
    #v(0.6em)
    Федеральное государственное автономное образовательное учреждение высшего образования\
    #v(0.6em)
    Санкт-Петербургский национальный исследовательский университет ИТМО\
    #v(0.6em)
    #megafaculty\
    #v(0.6em)
    #faculty
  ]

  v(1fr)

  // --- Название работы ---
  align(center)[
    #text(weight: "bold", size: 16pt)[Лабораторная работа №#lab-number]\
    #v(0.6em)
    По дисциплине «#discipline»
  ]

  v(1fr) 

  // --- Блок информации о студенте и проверяющем ---
  grid(
    columns: (1fr, auto),
    [],
    [
      #set align(left)
      Выполнил студент группы №#group\
      #v(0.3em)
      #text(style: "italic")[#student]\
      #v(1em)
      Проверил\
      #v(0.3em)
      #text(style: "italic")[#teacher]
    ]
  )

  v(1fr)

  // --- Подвал (Логотип, Город, Год) ---
  align(center)[
    #image("itmo-logo.png", width: 45%)
    #v(1cm)
    Санкт-Петербург\
    #v(0.3em)
    #year
  ]
  
  pagebreak()

  set page(
    margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 1.5cm)
  )
  
  body
}