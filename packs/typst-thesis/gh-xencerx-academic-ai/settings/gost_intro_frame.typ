#import "gost_fonts.typ": gost-serif

#let gost-title(path: "/assets/title_page.pdf") = {
  // Создаем отдельную страницу без полей, колонтитулов и нумерации для титульного листа
  page(
    margin: 0mm,
    header: none,
    footer: none,
    image(path, width: 100%, height: 100%),
  )
}

#let gost-toc() = {
  // Содержание всегда начинается с новой страницы
  pagebreak(weak: true)

  // Заголовок "СОДЕРЖАНИЕ" (стиль заголовка 1-ого уровня, но по центру)
  align(center)[
    #block(
      above: 0mm,
      below: 16mm,
      sticky: true,
      text(font: gost-serif, size: 18pt, weight: "bold")[СОДЕРЖАНИЕ],
    )
  ]

  // Настройка отображения строк содержания
  show outline.entry: it => {
    // Стиль основного текста для содержания
    set text(font: gost-serif, size: 14pt, weight: "regular")
    // Убираем красную строку (абзацный отступ) для элементов содержания и ставим полуторный интервал
    set par(first-line-indent: 0cm, leading: 1.5em)

    // Получаем название заголовка
    let title = it.element.body

    // Если это заголовок 1 уровня (Введение, Заключение и т.д.), делаем его прописными
    if it.level == 1 {
      title = upper(title)
    }

    // Получаем номер заголовка, если он есть
    let number = if it.element.numbering != none {
      numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
    } else {
      none
    }

    // Заполнитель точками
    let fill = box(width: 1fr, repeat[ . ])

    // Без отступов для всех уровней
    let indent = 0cm

    // Формируем финальную строку: [Отступ] [Номер] [Название] [......] [Страница]
    pad(
      left: indent,
      link(it.element.location())[
        #if number != none [#number ]#title#fill#it.page()
      ],
    )
  }

  // Выводим само оглавление (до 3-го уровня включительно, без стандартного заголовка)
  outline(title: none, depth: 3)
}
