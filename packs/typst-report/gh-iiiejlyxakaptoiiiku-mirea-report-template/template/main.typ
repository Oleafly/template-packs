#import "../src/lib.typ": gost
#import "../src/component/title-templates.typ": templates

#let institute-name = "Институт кибербезопасности и цифровых технологий (ИКБ)"
#let department-name = "Кафедра КБ-1 «Защита информации»" // Название кафедры
#let report-number = 1 // Номер практической работы
#let discipline = "Организационное и правовое обеспечение информационной безопасности" // Название дисциплины
#let group = "БАСО-03-21" // Группа студента
#let student-name = "Иванов И.И."
#let reviewer-name = "Иванов И.И."
#let reviewer-position = "Преподаватель кафедры КБ-1"

#show: gost.with(
  title-template: templates.at("mirea-university-report"),
  ministry: "МИНОБРНАУКИ РОССИИ",
  organization: (
    full: "«МИРЭА – Российский технологический университет»",
    short: "РТУ МИРЭА",
  ),
  institute: (
    name: institute-name,
  ),
  department: (
    name: department-name,
  ),
  report-number: report-number,
  discipline: discipline,
  group: group,
  student-name: student-name,
  reviewer-name: reviewer-name,
  reviewer-position: reviewer-position,
  city: "Москва",
)

#outline()

= Введение

#lorem(50)

= Пункт первый

#lorem(70)

== Подпункт

#lorem(100) @petrov2021analiz

#figure(
  image("../assets/image.jpg", width: 120mm),
  caption: [
    Описание рисунка
  ],
)

= Пункт второй

#lorem(30)

== Подпункт второй

#lorem(50) @ivanov2020osnovy

#figure(
  table(
    columns: (auto, auto, auto),
    [Заголовок 1], [Заголовок 2], [Заголовок 3],
    [ячейка 1], [ячейка 2], [ячейка 3],
  ),
  kind: table,
  caption: [Название таблицы],
)

= Пункт третий

#lorem(150) @examplewebsite

#figure(
```python
def bubble_sort(arr):
    n = len(arr)
    # Проход по всему массиву
    for i in range(n):
        # Последние i элементов уже на месте
        for j in range(0, n-i-1):
            # Просмотр массива от 0 до n-i-1
            # Смена местами, если элемент больше следующего
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]

# Пример использования:
my_list = [64, 34, 25, 12, 22, 11, 90]
bubble_sort(my_list)
print("Отсортированный массив:", my_list)
```,
caption: [
  Пузырьковая сортировка
]
)

#bibliography("references.bib")

#set page(
  paper: "a4",
  flipped: true,
  margin: (top: 0.6cm, bottom: 1.6cm, left: 0.5cm, right: 0.5cm)
)

#align(center)[
  #heading(level: 1, numbering: none)[Приложение А]
]

#figure(
  caption: [Таблица с нарушениями принципов],
  table(
    columns: (0.2fr, 2fr, 0.5fr, 3.5fr),
    stroke: .5pt,
    inset: 5pt,
    align: left,
    
    table.header(
      align(center + horizon)[*№*], 
      align(center + horizon)[*Путь*], 
      align(center + horizon)[*Нарушение принципов*], 
      align(center + horizon)[*Код*]
    ),
    
    [1], 
    [MyProject/src/main/scala/com/company/Main.scala],
    [DRY], 
    table.cell(rowspan: 3)[```scala
    object Main extends App {
      val users = List(
        User("Alice", 25),
        User("Bob", 30)
      )
      users.foreach(u => println(s"${u.name} is ${u.age} years old"))
    }
    ```],
    
    [2], 
    [MyProject/src/test/scala/com/company/UserSpec.scala], 
    [DRY],
    
    [3], 
    [MyProject/modules/utils/src/main/scala/org/project/Utils.scala], 
    [DRY],
  )
)

#set page(
  paper: "a4",
  flipped: false,
  margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
)

#align(center)[
  #heading(level: 1, numbering: none)[Приложение Б]
]

#lorem(400)