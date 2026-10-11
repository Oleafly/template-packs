#let title_page(
  university: "НАЗВА ВАШОГО НАВЧАЛЬНОГО ЗАКЛАДУ",
  faculty: "НАЗВА ФАКУЛЬТЕТУ",
  department: "Назва кафедри",
  report_header: "Практична робота №1",
  work_type: "до лабораторної роботи",
  subject: "Назва дисципліни",
  topic: "ТЕМА РОБОТИ",
  student_info: "студента групи ІТ-21 \nПрізвища Івана Петровича",
  supervisor_info: "посада, вчене звання \nПрізвище І. П.",
  city: "Київ",
  year: "2026",
) = {
  set text(
    font: (
      "Liberation Serif",
      "PT Serif",
    ),
    size: 14pt,
    lang: "uk",
  )

  set page(
    header: none,
    numbering: none,
  )
  set align(center)

  text(size: 14pt, weight: "bold")[
    МІНІСТЕРСТВО ОСВІТИ І НАУКИ УКРАЇНИ \
    #university \
    #if faculty != none [
      #faculty \
    ]
    #department
  ]

  v(4cm)

  text(size: 18pt, [
    #report_header \
  ])

  text(size: 14pt)[
    з дисципліни "#subject"\
    на тему: \
    «#topic»
  ]

  v(3cm)

  align(left)[
    #block(width: 8.5cm, align(left)[
      Виконав: \
      #student_info \
      \
      #if supervisor_info != none [
          Перевірив: \
          #supervisor_info
      ]
    ])
  ]

  v(1fr)

  text(size: 14pt)[
    #city --- #year
  ]

  pagebreak()
}

#let template(
  body,
) = {
  // Global Page Configuration
  set page(
    paper: "a4",
    margin: (
      top: 20mm,
      bottom: 20mm,
      left: 30mm,
      right: 10mm,
    ),
    header: context {
      let page_num = counter(page).get().first()
      // Numbering starts from 1 (title page) but is hidden on page 1
      if page_num > 1 {
        align(right, str(page_num))
      }
    },
  )

  // Typography with metric-compatible fallbacks
  set text(
    font: (
      "Liberation Serif",
      "PT Serif",
    ),
    size: 14pt,
    lang: "uk",
  )

  // Paragraph and Line spacing
  set par(
    justify: true,
    leading: 1.5em,
    first-line-indent: (amount: 1.25cm, all: true),
  )

  show raw: it => {
    set par(
      justify: false,
      leading: 0.5em,
      first-line-indent: 0pt
    )
    set text(size: 12pt)
    block(
      fill: luma(240),
      inset: 8pt,
      radius: 4pt,
      width: 100%,
      breakable: true,
      it
  )
}

  // Heading numbering configuration
  set heading(
    numbering: "1.1",
  )

  // Heading 1: Centered, Bold, Uppercase, Page Break
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set align(center)
    text(weight: "bold", upper(it.body))
    v(1em)
    // Reset secondary counters for chapter-relative numbering
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
  }


  // Issue #1595 Fix: Non-latin enumerations (lists) are cursed
  let enum-depth = state("enum-depth", 0)
  show enum: it => {
    enum-depth.update(d => d + 1)
    it
    enum-depth.update(d => d - 1)
  }
  set enum(
    indent: 1.25cm,
    numbering: n => context {
      let d = enum-depth.get()
      if d == 1 {
        // Apparently, DSTU 3008:95 doesn't allow certain letters
        // https://www.dnu.dp.ua/docs/ndc/standarts/DSTU_3008-95.pdf
        let alphabet = ("а", "б", "в", "г", "д", "е", "ж", "з", "и", "к", "л", "м", "н", "п", "р", "с", "т", "у", "ф", "х", "ц", "ш", "щ", "ю", "я",)
        if n <= alphabet.len() {
          alphabet.at(n - 1) + ")"
        } else {
          str(n) + ")"
        }
      } else if d == 2 {
        str(n) + ")"
      } else {
        [---]
      }
    },
  )

  // Caption formatting: Chapter.Number
  show figure.caption: it => context {
    let ch = counter(heading.where(level: 1)).get().first()
    let n = counter(figure.where(kind: it.kind)).get().first()
    if it.kind == image {
      [Рисунок #ch.#n -- #it.body]
    } else if it.kind == table {
      align(left)[Таблиця #ch.#n \ #it.body]
    }
  }

  // Equation numbering in parentheses
  set math.equation(
    numbering: (..nums) => context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n = nums.pos().first()
      [(#ch.#n)]
    },
  )

  body
}

// --- DOCUMENT ASSEMBLY ---

#title_page(
  university: "НАЦІОНАЛЬНИЙ ТЕХНІЧНИЙ УНІВЕРСИТЕТ УКРАЇНИ \"КПІ\" ім. Ігоря Сікорського",
  faculty: none,
  department: "Кафедра інформатики та програмної інженерії",
  report_header: "Лабораторна робота №1",
  subject: "Методи та технології паралельного програмування",
  topic: "Засоби створення та керування потоками в паралельних мультипоточних програмах",
  student_info: "студент групи ІО-29мп \nШевченко Ч. І.",
  supervisor_info: "професор \nАнгел М. В.",
)

#show: template

#heading(level: 1, outlined: true, numbering: none)[ЗМІСТ]
#outline(
  title: none,
  indent: auto,
)

#heading(level: 1, outlined: true, numbering: none)[ВСТУП]
Текст вступної частини з обов'язковим абзацним відступом.

*Тема*: Засоби створення та керування потоками в паралельних мультипотокових програмах.

*Мета*: Ознайомлення з базовими принципами роботи потоків, набуття практичних навичок паралельного програмування.

*Завдання*: Розробити програмне забезпечення, що реалізує багатопотокову обробку даних, та проаналізувати результати. На прикладі цього програмного забезпечення необхідно показати переваги та недоліки інструментів багатопотокового програмування.

= ОСНОВНА ЧАСТИНА
У цьому розділі наведено детальний опис ходу виконання лабораторної роботи, а також результати тестування розроблених структур та алгоритмів.

== Форматування багаторівневих списків
Відповідно до вимог оформлення технічної документації, списки повинні мати чітку ієрархічну структуру.

Приклад вкладеного списку за вимогами:
+ Перший рівень
+ Другий елемент
  + Вкладений елемент першого підрівня
    + Елемент найнижчого рівня
  + Ще один вкладений елемент
+ Повернення до основного списку

== Реалізація алгоритму
Нижче наведено лістинг тестової програми:
```rs
fn main() {
  let mut x = 5;
  x = 6;
}
```
Програма успішно скомпільована, помилок під час виконання не виявлено.

#heading(level: 1, outlined: true, numbering: none)[ВИСНОВКИ]
Підсумковий текст роботи.
