#import "template.typ": *
#let title = "Работа 1"
#let author = "Имя Фамилия"
#let course = "Линейная Алгебра и Геометрия"
#let due_time = "1 января, 00:00"
#let group = "группа 1"
#show: footer_header.with(title, author, course, due_time, group)
#show: title_page.with(title, author, course, due_time, group)
#show: template

#problem[
  Просто условие задания.
]
#solution[
  Решение задания.
  $ a + b = b + a $
]
#answer[
  $a = 5, b = 6$
]
#pagebreak()

#problem(name: "12.4 a")[
  Условие задания, но у задания есть имя
]
#solution[
  Решение задания.
  $ 1973 + 234 dot 3 = 2675 $
]
#answer[
  2675
]
#pagebreak()

#problem[
  Задание, где несколько пунктов:\
  *a)* 2 + 8; #h(15pt)
  *б)* 6 + 4.
]
#solution[
  *(а)* $10 <= 2 + 8 <= 10$
]
#answer(no_header: true)[
  10
]
#solution(no_header: true)[
  *(б)* $6 + 4 = 10$
]
#answer(no_header: true)[
  10
]
#pagebreak()

#problem[
  Задача на доказательство
]
#solution[
  Очевидно, что...\
  Заметим, что...\
  Нетрудно увидеть, что...\

  Ч.Т.Д.; Q.E.D.; $qed$
]
#answer(type: "result")[
  ну вот мы и доказали, что все работает.
]