//
//
// Typst темплейт для курсовых и дипломных работ БГУ
//
//
// - Онлайн редактор:  https://typst.app/project/r1B4Y4PQlxgDViep00zSQC
// - Собрать локально: `typst watch example.typ`
// - Отформатировать:  `typstyle example.typ`
// - LSP:              https://github.com/Myriad-Dreamin/tinymist
// - Документация:     https://typst.app/docs/
// - Пакеты:           https://typst.app/universe/
// - Сжатие картинок:  `magick figure.png figure.jpg`
//                     `jpegoptim -s --size=100kb figure.jpg`
//
// Темплейт сделан в соответствии с:
//
//     Методические рекомендации по организации дипломного проектирования
//     в Белорусском государственном университете от 18.01.2024
//     https://bsu.by/upload/All_units/Metod-rekom-po-org-diplomnogo-proektir-BGU-2024.pdf
//
// А именно:
//
// - Секция 5, page 5-8 (общие штуки)
// - Приложение 2, page 14 (титульная страница)
// - Приложение 3, page 15-20 (форматирование)
//
// License: MIT (C) 2026 0xf1a7face

#let template(body) = [
  // TODO:
  // - code blocks

  #set document(title: none, date: none)
  #set page("a4", margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm))
  #set text(lang: "ru")

  // "Libertinus" - современный фонт с улучщенной поддеркой математики, imho выглядит приятнее всего
  // "New Computer Modern" - дефолтный фонт латека, у него свой вайб
  // "Liberation" - дефолтный фонт LibreOffice, он показывается вместо "Times New Roman"
  #set text(size: 14pt, font: "Liberation Serif")
  // TODO: verify chars per line, lines per page

  #show raw: set text(11pt, font: "Liberation Mono")
  #show raw: pad.with(top: 0.5em, bottom: 0.5em)

  #let indent = 1.25cm
  #set par(
    leading: 0.55em, // Межстрочное расстояние, хз почему они 18pt просят
    first-line-indent: (amount: indent, all: true), // Отступ первой строки
    hanging-indent: 0cm, // Отступ остального текста
    // Казань полностью убрала абзацный отступ (1.25mm)
    spacing: 0.55em + 0.0 * 1.25mm, // Абзацный отступ
    justify: true, // Выравнивание по текста по ширине листа
  )

  #show raw: pad.with(left: indent)

  #set heading(numbering: "1.")

  // Страница 15 пункт 5
  #let move_adjacent_headings() = context {
    let headings = query(selector(heading).before(here()))

    let prev = headings.at(headings.len() - 2)

    if prev.depth != 1 {
      return
    }

    let prev_loc = headings.at(headings.len() - 2).location()

    if prev_loc.position().y + 60pt > here().position().y {
      v(-0.8em)
    }
  }

  #show heading: set text(weight: "bold")
  #show heading: pad.with(left: indent, top: 0.2em, bottom: 0.8em)
  #show heading: it => {
    if it.depth == 1 {
      return it
    }
    move_adjacent_headings()
    set text(size: 14pt, weight: "bold")
    it
  }

  #show heading.where(depth: 1): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "bold")
    set align(center)
    upper(it)
  }

  #show heading: it => {
    assert(
      not it.body.has("text") or not it.body.text.contains(regex("\.+\s*$")),
      message: "Заголовок заканчивается точкой (не надо так)",
    )
    it
  }

  // Страница 16 пункт 7
  #set page(numbering: "1")

  // Страница 16 пункт 8
  #show heading.where(depth: 1): set heading(numbering: n => [Глава #n])

  // Same as `#heading(numbering: none)[Введение]`
  #let chapter_selectors = (
    "Оглавление",
    "Перечень условных обозначений и символов",
    "Реферат",
    "Введение",
    "Заключение",
    "Список использованных источников",
    "Приложение",
  ).map(name => heading.where(body: [#name]))
  #show selector.or(..chapter_selectors): set heading(numbering: none)

  #set heading(numbering: "1.")

  // Страница 16 пункт 9
  #set ref(supplement: none)
  #set figure(supplement: "Рисунок")
  // TODO: figures and captions + point 11 (supplemental text in small)

  // Страница 17 пункт 10
  // N/A

  // Страница 17 пункт 11
  // TODO: captions

  // Страница 17 пункт 12
  // TODO: tables

  // Страница 19 пункт 13
  #set math.equation(numbering: n => [(#counter(heading).get().at(0).#n)])
  #show math.equation: it => {
    linebreak()
    it
    linebreak()
  }

  // Страница 19 пункт 14
  // N/A: Перенос уравнений на усмотрение пользователя

  // Страница 19 пункт 15
  #let note = body => {
    set text(size: 12pt)
    [ Примечание -- _ #body _ ]
  }

  // Страница 19 пункт 16,17
  // TODO: biblioghraphy

  // Страница 20 пункт 18
  // TODO: приложения


  #set list(indent: indent, body-indent: 0.75em, marker: ([*--*], [*--*]))

  #show list: it => {
    it
    v(-0.1em)
  }

  #body
]

// vim:spelllang=en,ru
