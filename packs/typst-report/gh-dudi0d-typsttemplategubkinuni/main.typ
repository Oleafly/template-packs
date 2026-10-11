#set page(
  paper: "a4",
  margin: (
  top: 2cm,
  bottom: 1cm,
  left: 2cm,
  right: 1cm,
)) // page settings
#show heading.where(depth: 1): set align(center) // headers align
#show figure: set align(center) // images align
#set par( // paragraph settings
  first-line-indent: (
    amount: 1.5em,
    all: true,
  ),
)
#set text(font: "Times New Roman", size: 14pt, lang: "ru") // font settings
#include("title.typ") // include title page
#show figure.where(
  kind: table
): set figure.caption(position: top) // table caption settings
#show figure.where(kind: raw): set figure(supplement: [Рис.])
// code caption settings
#set page(numbering: "1") // page numbering settings
#set image(width: 14cm) // image width settings
#show raw.where(block: true): it => {
  block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    stroke: luma(200),
    width: 100%,
    it
  )
} // code block settings
= Задание лабораторной работы
Определить текущих пользователей системы и их права доступа. Создать новых пользователей с различными правами доступа. Проверить права доступа созданных пользователей.
= Ход работы
#figure(image("example.png", width: 14cm), caption: "Запуск терминала")
#figure(image("example.png", width: 14cm), caption: "Создание пользователя")
= Выводы
В ходе выполнения лабораторной работы были изучены методы управления пользователями и правами доступа в операционной системе Linux. Были созданы новые пользователи с различными правами доступа, что позволило понять механизмы безопасности и управления учетными записями в данной ОС.