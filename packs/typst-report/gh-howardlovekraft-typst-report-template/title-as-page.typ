// i18n date names
#import "@preview/icu-datetime:0.2.2": fmt


#let title-page(
  author: "Холкин Николай",
  group: "РИ-340917",
  lecturer: [],
  paper-type: [],
  title: [],
  doc,
) = {
  let today = datetime.today()

  align(center)[
    Министерство образования и науки Российской Федерации
    #v(20pt)
    Уральский федеральный университет #linebreak() имени первого Президента России Б. Н. Ельцина
    #v(20pt)
  ]

  v(1fr)

  align(center)[
    #upper(paper-type) #linebreak()
    _"#title"_
    #v(20pt)
  ]

  v(1fr)

  par(first-line-indent: 0pt)[
    Студент: #linebreak()
    _Группа #group #h(1fr) #author _
  ]

  par(first-line-indent: 0pt)[
    Преподаватель: _#h(1fr) #lecturer _
  ]

  v(1fr)

  align(center)[
    Екатеринбург #linebreak()
    #fmt(today, locale: "ru", length: "long")
  ]
  pagebreak()

  // Нумерация со второй страницы!!!
  set page(numbering: "1")
  outline()
  doc
}
