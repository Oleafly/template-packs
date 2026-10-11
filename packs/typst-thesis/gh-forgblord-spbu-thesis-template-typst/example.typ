#import "titlepage.typ": *
#import "main-content.typ": *

// Apply content-related styling
#show: configure_content

#title_page(
  author_name: (
    first_name: "Павел",
    last_name: "Павлов",
    patronymic: "Павлович",
  ),
  thesis_title: "Пишем свою выпускную квалификационную работу в Typst!",
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
    dept: "АОА Завод высокоточных\nдеталей",
    name: "Олегов Олег Олегович",
  ),
  year: "2026",
)

#pagebreak()
#outline(
  indent: 1em,
  title: [Содержание],
)

#pagebreak()
#uheading[Введение]

Используя самописную функцию `uheading`, можно добавлять главы, в которых не нужна нумерация!
К таким главам относятся:

#set list(
  spacing: 1em,
  // indent: 2.5cm-1em,
  indent: 1.25cm,
  marker: ([•], [◦], [▪]),
)

#show list: it => {
  set list(indent: 1.25cm)
  it
}

#set enum(
  full: true,
  spacing: 1em,
  // indent: 2.5cm-1em,
  indent: 1.25cm,
)

#show enum: it => {
  set enum(indent: 1.25cm)
  it
}

- "Введение"
- "Обзор литературы"
- "Заключение"
- "Выводы"
- "Список использованных источников"

#pagebreak()
= Название главы

#lorem(20)

== Название параграфа (превью текста)

#lorem(50)

#lorem(50)

== Вставляем код

Для того, чтобы вставлять картинки или листинги кода, можно воспользоваться функцией `figure`.

#figure(
  caption: [Функция для подсчета чисел фиббоначи],
)[
  ```python
  def fib(n):
    if n <= 1:
      return n
    else:
      return fib(n - 1) + fib(n - 2)
  print(fib(25))
  ```
] <hello_world>

Чтобы сослаться на листинг, необходимо к фигуре добавить ссылку, используя `<ref_name>` синтаксис.
Ссылка на @hello_world выполняется с использованием следующего синтаксиса: `@ref_name`.

== Вставляем картинки

Аналогичная ситуация будет и с картинками:

#figure(
  caption: [Милый котенок. Он ничего не знает про ВКР],
)[
  #image("images/lil_cat.jpg", height: 20%)
] <cute_cat>

Также мы можем и ссылаться на картинки.
Например, это котик Рыжик (@cute_cat), и он ничего не смыслит в ВКР.
Оно ему и не надо --- ведь он котенок!

== Вставляем таблицы

Для размещения таблиц все будет аналогично предыдущим примерам.
Только теперь мы будем использовать функцию `table`:

#figure(
  caption: [Котята-близнецы из нашей выборки],
)[
  #table(
    columns: (auto, 1fr, 1fr),
    inset: 10pt,
    align: horizon,
    table.header([], [*Котенок*], [*Вес*]),
    image("/images/lil_cat.jpg", height: 20%), [Рыжик], [200 грамм],
    image("/images/lil_cat.jpg", height: 20%), [Коржик], [300 грамм],
  )
] <some_table>

== Списки

Списки бывают нумерованные и ненумерованные.
_Ненумерованные_ списки выглядят так:

- Уровень 1
  - Уровень 2
    - Уровень 3

_Пронумерованные списки_ выглядят так:

+ Уровень 1
  + Уровень 2
    + Уровень 3

Пока что я не знаю, как сделать так, чтобы для последующих уровней не было таких больших отступов.
Да и в целом не знаю, какие отступы должны быть.

== Цитирования

Для составления списка источников используется ГОСТ 7.0.5.2008.
Как я понимаю, Typst его содержит.
Генерирование списка источников делается с помощью функции `bibliography`.
Туда подается `bib`-файл а также специфизируется стиль библиографии при помощи параметра `style`.

*Важно*!
Цитирования без ссылок в списке не обозначаются!

Пример цитирования книги --- @book_example.
Пример цитирования статьи --- @article_example.
Пример цитирования онлайн-источника --- @web_example.

Цитирование нескольких источников происходит аналогично: подряд перечисляются референсы на соответствующие источники без каких-либо разделителей.
Таким образом, @article_example @web_example.

#pagebreak()
= Больше я не знаю, что еще надо

#lorem(20)

== Какой-то параграф

#lorem(100)

== Какой-то параграф

#lorem(100)

#pagebreak()

= О приложениях

Приложения делаются с помощью функции `appendix_section`.
Поскольку функциия вовзращает `content`-блок, то в ней все пишется с использованием стандартного markup'а.

В приложениях обычно прикладываются: (1) листинги кода, (2) большие таблицы, (3) схемы, (4) ссылки на репозитории с проектом.

Чтобы ссылаться на приложения внутри текста, используется синтаксис для ссылок, описанный ранее.
Так, [@appendix_source_code] предоставляет ссылку на исходный код.

#pagebreak()

#bibliography(
  "sources.bib",
  style: "gost-r-705-2008-numeric",
)
#pagebreak()

// #show is for applying appendix section styling to all content below
#show: appendix_section

= Приложения


== Ссылка на репозиторий с исходным кодом <appendix_source_code>

URL: #link("https://github.com/forgblord/spbu-thesis-template-typst") (дата обращения: 16.05.2026)

== Сравнение котиков

#figure()[
  #table(
    columns: (auto, 1fr, 1fr),
    inset: 10pt,
    align: horizon,

    table.header([], [*Котенок*], [*Вес*]),

    image("/images/lil_cat.jpg", height: 20%), [Рыжик], [200 грамм],
    image("/images/lil_cat.jpg", height: 20%), [Коржик], [300 грамм],
  )
]

== Реализация самого быстрого алгоритма сортировки

#show figure: set block(breakable: true)
#figure()[
  ```C
  #include <stdio.h>
  #include <stdlib.h>
  #include <time.h>
  #include <stdbool.h>
  #include <stddef.h>

  void shuffle(int a[], int length) {
      int temp;
      int random;

      for (size_t i = 0; i < length; i++) {
          random = rand() % length;
          temp = a[random];
          a[random] = a[i];
          a[i] = temp;
      }
  }

  bool sorted(int a[], int length) {
      for (size_t i = 0; i < length - 1; i++) {
          if (a[i] > a[i + 1]) {
              return false;
          }
      }
      return true;
  }

  void bogoSort(int a[], int length) {
      while (!sorted(a, length)) {
          shuffle(a, length);
      }
  }

  int main(void) {
      int input[] = {68, 14, 78, 98, 67, 89, 45, 90, 87, 78, 65, 74};
      int size = sizeof(input) / sizeof(input[0]);

      srand((unsigned)time(NULL));

      bogoSort(input, size);

      printf("Sorted result:");
      for (size_t i = 0; i < size; i++) {
          printf(" %d", input[i]);
      }
      printf("\n");

      return 0;
  }
  ```
]
