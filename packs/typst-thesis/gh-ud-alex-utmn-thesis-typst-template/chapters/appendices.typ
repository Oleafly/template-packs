#import "/assets/appendix.typ": appendix

#appendix[Миллионы скучных таблиц] <app1>



#figure(
  caption: "Описание таблицы",
)[
  #table(
    columns: (1fr, 2fr, 1fr),
    fill: (x, y) => if y == 0 { luma(220) } else { white },
    stroke: 1pt,
    
    [ID], [Имя], [Баллы],
    [1], [Анна], [95],
    [2], [Иван], [88],
    [3], [Мария], [92],
  )
]


\

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: none,
    fill: (_, row) => if row == 0 { rgb("#e0e0e0") } else { none },
    align: center,
    table.header(
      [Параметр], [Значение], [Примечание]
    ),
    [Температура], [22.5 °C], [Норма],
    [Давление], [101.3 кПа], [Стандарт],
    [Влажность], [65 %], [Допустимо],
    [Скорость], [4.2 м/с], [Понижена],
  ),
  caption: [Климатические параметры],
  kind: table,
)

\

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: (x, y) => (left: none, right: none, top: none, bottom: if y == 0 { 0.5pt }),
    table.header(  [Наименование], [Модель], [Кол-во]),
  
    [Сервер], [Dell PowerEdge], [2],
    [Коммутатор], [Cisco 2960], [3],
    [Источник ИБП], [APC SRT], [1],
  ),
  caption: [Состав вычислительного комплекса],
  kind: table,
)

\

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    fill: (_, row) => if row == 0 { rgb("#d9d9d9") } else if calc.rem(row,2) == 0 { rgb("#f2f2f2") } else { none },
    table.header(
      [Код], [Описание], [Статус]
    ),
    [A01], [Первичная настройка], [Завершено],
    [B04], [Тестирование], [В процессе],
    [C12], [Документирование], [Не начато],
    [D08], [Внедрение], [Завершено],
  ),
  caption: [Таблица 1.4 – Этапы выполнения работ],
  kind: table,
)

#pagebreak()

#appendix()[Куча интересных Графиков] <app2>

#figure(caption: "Какой-то график какой-то функции")[
#image("/graphics/sine_function.png")]


#figure(
caption: [Тот же самый график, но уже в двух колонках],
grid(
columns: 2,
image("/graphics/sine_function.png", width: 100%),
image("/graphics/sine_function.png", width: 100%),
)
)

#align(horizon)[
#rotate(-90deg)[
#figure(
caption: [Знакомый график в альбомной ориентации],
image("/graphics/sine_function.png", height: 50%)
)]]