#import "homeworkreport.typ": homework_report, noindent, appendixes, appendix-heading
#import "@preview/physica:0.9.8": *


#show: homework_report.with(
  theme: highlight()[Тема ДЗ],
  author: highlight()[И.О. Фамилия],
  group: highlight()[группа],
  teacher: highlight()[И.О. Фамилия]
)


= Введение

Кратко о том, что содержит этот отчёт, какая задача решается и т.~п.

#lorem(100)

#lorem(50)

= Раздел <head-1>

В данном разделе рассматривается то-то и то-то...

Решается задача...

== Подраздел

// Формула без номера (по умолчанию):
$
a x^2 + b x + c = 0.
$

// Формула с номером — включаем нумерацию явно:

#math.equation(
$
a x^2 + b x + c = 0.
$,
block: true,
numbering: "(1)"
) <eq-quadric>

$
E = m c^2.
$

#math.equation(
$
alpha x^3 + beta x^2 + gamma sqrt(x) = z.
$,
block: true,
numbering: "(1)"
) <eq-x3>

Квадратное уравнение~(@eq-quadric)...
И не квадратное уравнение~(@eq-x3)...

Маркированный список:
- #lorem(20)
- #lorem(32)
- ...

Нумерованный список:
+ #lorem(25)
+ #lorem(33)
+ ...

=== Подподраздел

Ещё информация...

==== Подподподподподподраздел

_*До такого уровня лучше не доходить!*_

== Выводы по разделу~@head-1

+ #lorem(20)
+ #lorem(40)
+ ...

= Второй раздел <head-2>

== Подраздел второго раздела

На рисунке~@fig-demon-core показано «чёртово ядро»...

#figure(
  image("pics/demon-core.jpeg", width: 60%),
  caption: [Плутониевый шар]
) <fig-demon-core>

Ещё один рисунок~@fig-Schrodinger с портретом известного учёного.

#figure(
  image("pics/Schrodinger.webp", width: 50%),
  caption: [Эрвин~Шрёдингер]
) <fig-Schrodinger>

#lorem(50)

#lorem(100)

== Выводы по разделу~@head-2

+ #lorem(40)
+ #lorem(60)
+ ...

В следующем разделе предстоит...

= Очередной раздел <head-3>

Очередной раздел посвящён...

#lorem(50)

#lorem(60)

== Очередной подраздел

В таблице~@tab-system-params приведены параметры системы...

#figure(
  table(
    align: center,
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    table.header([$x$, м], [$y$, м], [Вариант исполнения], [Результат $x^2+y^2$, $"м"^2$], [$Delta$, %]),
    [$1.0$], [$2.5$], [1], [7.25], [4],
    [$2.0$], [$0.0$], [2], [4.00], [5],
    [...]
  ),
  caption: [Параметры системы]
) <tab-system-params>

#lorem(80)

#lorem(50)

== Выводы по разделу~@head-3

+ #lorem(30)
+ #lorem(40)
+ ...

= Заключение

Заключение по работе в соответствии с поставленной целью и задачами.

+ #lorem(40)
+ #lorem(30)
+ #lorem(50)
+ ...


#show: appendixes

= Исходный код программы

```python
print("Привет, мир!")
```

== Подраздел приложения

#lorem(50)

= Дополнительные материалы

На рисунке~@fig-demon-core-experiment показано воспроизведение трагического эксперимента с «чёртовым ядром».

#figure(
  image("pics/pluto-experiment.jpg", width: 50%),
  caption: [Эксперимент с «чёртовым ядром»]
) <fig-demon-core-experiment>

В таблице~@tab-additional-materials приведены дополнительные варианты чего-то.

#figure(
  table(
    align: center,
    columns: (1fr, 2fr, 3fr, 1fr),
    table.header([1], [2], [3], [4]),
    [...], [], [], [],
  ),
  caption: [Дополнительные варианты]
) <tab-additional-materials>
