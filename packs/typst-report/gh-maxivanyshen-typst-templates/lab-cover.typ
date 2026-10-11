#let lab_cover(
  lab_n: 1, 
  topic: "Тема лабораторної роботи", 
  subject: "Назва дисципліни", 
  student: "ініціали студента", 
  professor: "ініціали викладача", 
) = [
  #set page(margin: 2.5cm)
  #set text(size: 14pt, font: "Times New Roman")

  #align(center)[
    Міністерство освіти і науки України \
    Вінницький національний технічний університет \
    Факультет інформаційних технологій та комп’ютерної інженерії \
    \
    Кафедра ПРОГРАМНОГО ЗАБЕЗПЕЧЕННЯ
  ]

  #v(6cm)

  #align(center)[
    Лабораторна робота №#lab_n \
    З дисципліни «#subject» \
    *#topic* \
  ]

  #v(5cm)

  #grid(
    columns: (1fr, 1fr),
    align(left)[
      Виконав ст.:
    ],
    align(right)[
      #student
    ]
  )


  #grid(
    columns: (1fr, 1fr),
    align(left)[
      Прийняв(ла):
    ],
    align(right)[
      #professor
    ]
  )

  #v(5cm)

  #align(center)[
    Вінниця #datetime.today().year()
  ]

  #pagebreak()
]


#lab_cover(
  lab_n: 1, 
  topic: "Тема лабораторної роботи", 
  subject: "Назва дисципліни", 
  student: "ініціали студента", 
  professor: "ініціали викладача", 
)
