// ════════════════════════════════════════════════════════════════════════════
// ТУСУР — шаблон лабораторной работы (ОС ТУСУР 01-2021)
// ════════════════════════════════════════════════════════════════════════════

#set text(font: "Liberation Serif", size: 14pt, lang: "ru", hyphenate: false)
#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm),
  // numbering здесь НЕ ставим — титульный лист не нумеруется (п. 5.11.1)
  number-align: center,
)

// Полуторный интервал + отступ первой строки 1.25 см
#set par(leading: 0.85em, first-line-indent: 1.25cm, justify: true)

// Нумерация разделов: 1, 1.1 — без точки в конце
#set heading(numbering: (..args) => args.pos().map(str).join("."))

// Фиктивный параграф — нужен после каждого заголовка,
// чтобы Typst добавлял отступ первой строки следующего абзаца
#let fakepar = par(text(size: 0pt, ""))

// Заголовок 1 уровня: по центру, 14pt, полужирный, ПРОПИСНЫМИ (п. 5.4.2)
#show heading.where(level: 1): it => context {
  let n = counter(heading).display(it.numbering)
  [
    #block(above: 1em, below: 0.6em, width: 100%,
      align(center, text(size: 14pt, strong(upper(n + h(0.4em) + it.body)))))
    #fakepar
  ]
}

// Заголовок 2 уровня: по центру, 14pt, полужирный, строчными (п. 5.4.2)
#show heading.where(level: 2): it => context {
  let n = counter(heading).display(it.numbering)
  [
    #block(above: 0.8em, below: 0.4em, width: 100%,
      align(center, text(size: 14pt, strong(n + h(0.4em) + it.body))))
    #fakepar
  ]
}

// Подписи к рисункам: «Рисунок N — название», по центру снизу (п. 5.6.4)
#show figure.caption: it => context {
  if it.kind == image [
    #align(center)[Рисунок #counter(figure.where(kind: image)).display() — #it.body]
  ] else [
    #it
  ]
}

// Таблицы: подпись НАД таблицей слева без отступа, шрифт 12 пт (п. 5.5.3–5.5.4)
#show figure.where(kind: table): it => {
  set text(size: 12pt)
  set par(leading: 0.5em, first-line-indent: 0pt, justify: false)
  context {
    let num = counter(figure.where(kind: table)).at(it.location()).first()
    block(width: 100%, below: 0.4em)[Таблица #num – #it.caption.body]
    it.body
    fakepar
  }
}

// Ссылки @label: рисунок → «рисунке N», таблица → «таблице N»
#show ref: it => {
  let el = it.element
  if el != none and el.func() == figure {
    if el.kind == image {
      let num = context counter(figure.where(kind: image)).at(el.location()).first()
      link(el.location())[рисунке #num]
    } else if el.kind == table {
      let num = context counter(figure.where(kind: table)).at(el.location()).first()
      link(el.location())[таблице #num]
    } else { it }
  } else { it }
}

// Отступ после рисунков
#show figure: it => { it; fakepar }

// Блоки кода
#show raw.where(block: true): it => {
  block(fill: luma(245), inset: (x: 10pt, y: 8pt),
        radius: 3pt, width: 100%,
        text(font: "Liberation Mono", size: 10pt, it))
  fakepar
}
// Инлайн-код — без выделения
#show raw.where(block: false): it => it.text

// Ненумерованный заголовок: «Введение», «Заключение» — с прописной буквы (п. 4.7.2, 4.9.2)
#let nheading(body) = {
  pagebreak()
  block(above: 1em, below: 0.6em, width: 100%,
    align(center, text(size: 14pt, strong(body))))
  fakepar
}

// ════════════════════════════════════════════════════════════════════════════
// ТИТУЛЬНЫЙ ЛИСТ — страница 1, номер не проставляется (п. 5.11.1)
// ════════════════════════════════════════════════════════════════════════════
#include "title.typ"
#set page(numbering: "1")  // включается со следующей страницы → Введение = 2

// ════════════════════════════════════════════════════════════════════════════
// ВВЕДЕНИЕ
// ════════════════════════════════════════════════════════════════════════════
#nheading[Введение]

*Цель работы:* цель.

*Задание:* описание задания.

#pagebreak()

// ════════════════════════════════════════════════════════════════════════════
// ОСНОВНОЕ СОДЕРЖАНИЕ
// ════════════════════════════════════════════════════════════════════════════

= Ход работы

== Первый раздел

Текст. Как представлено на @fig-example, ...

#figure(
  image("1.png", width: 80%),
  caption: [Подпись к рисунку],
) <fig-example>

Данные приведены в @tbl-example.

#figure(
  caption: [Название таблицы],
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt, inset: 6pt,
    [*Столбец 1*], [*Столбец 2*],
    [Значение],    [Описание],
  )
) <tbl-example>

== Второй раздел

Текст со вставкой кода:

```python
# пример кода
print("Hello")
```

// ════════════════════════════════════════════════════════════════════════════
// ЗАКЛЮЧЕНИЕ
// ════════════════════════════════════════════════════════════════════════════
#nheading[Заключение]

Итоги работы.
