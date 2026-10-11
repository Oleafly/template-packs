#import "preamble.typ": *
#import "title-as-page.typ": title

#show: preamble
#show: title

#align(center)[= Введение]
*Цель работы:*

*Задачи:*
1. ...

#pagebreak()
// Нумерация задач с единицы
#counter(heading).update(0)
// Задачи лабораторной работы - в tasks.typ
#include "tasks.typ"
#pagebreak()

#align(center)[= Вывод]
...
