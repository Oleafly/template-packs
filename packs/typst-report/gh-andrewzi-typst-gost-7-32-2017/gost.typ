#let FONT = "Times New Roman"

// Константы
#let START-PAGE = 2
#let MARGIN = (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
#let TEXT-SIZE = 14pt
#let INDENT = 1.25cm
#let GAP = 0.65em
#let LANG = "ru"
#let HYPHENATE = false
#let JUSTIFY = true
#let PAGE-NUMBERING = "1"
#let LONG-DASH = [---]
#let LIST-DOT = [)]
#let leading = 1.5em
#let LEADING = leading - 0.45em // Нормализация
#let PAR-LEADING = LEADING
#let SPACING = LEADING
#let LIST-INDENT = 0.25cm
#let listing-kind = "listing"
#let appendix-names = ("А", "Б", "В", "Г", "Д", "Е", "Ж", "И", "К", "Л", "М", "Н", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ш", "Щ", "Э", "Ю", "Я")

// Настройка отображения листингов
#show figure.where(kind: listing-kind): set figure(supplement: [Листинг])
#show figure.where(kind: listing-kind): set figure.caption(position: top)

// Настройка страницы
#set page(
  // Отступы от краев страницы
  margin: MARGIN,
  // Нумерация на страницах
  numbering: PAGE-NUMBERING
)

// Настройка текста
#set text(
  size: TEXT-SIZE,
  lang: LANG,
  hyphenate: HYPHENATE
)

#set text(font: FONT)
#show raw: set text(font: FONT, size: TEXT-SIZE)

// Настройка абзацев
#set par(
  justify: JUSTIFY,
  first-line-indent: (
    amount: INDENT,
    all: true
  ),
  spacing: SPACING,
  leading: PAR-LEADING
)

// Состояние для приложений
#let in-appendix = state("in-appendix", true)

// Содержание
#set outline(indent: INDENT, depth: 3, title: context {text(size: TEXT-SIZE, upper[#h(
  (page.width - MARGIN.left - 1.83 * MARGIN.right - measure(text(size: TEXT-SIZE, upper[содержание])).width) / 2
)содержание])})
#show outline: set block(below: INDENT / 2)
#show outline: it => {
  it
  in-appendix.update(false)
}
#show outline.entry: it => {
  show linebreak: [ ]
  let prefix = it.prefix()
  let inner = if prefix == none { it.inner() } else { prefix + h(0.5em) + it.inner() }
  link(it.element.location(), it.indented(none, inner))
}

// Ссылки через @
#set ref(supplement: none)
#set figure.caption(separator: " — ")

// Нумерация математических формул
#set math.equation(numbering: none)

#show image: set align(center)
#set figure(gap: GAP)
#show figure.where(kind: image): set figure(supplement: [Рисунок])

// Общие стили для таблиц И листингов
#show figure.where(kind: table).or(figure.where(kind: listing-kind)): it => {
  set block(breakable: true)
  set figure.caption(position: top)
  it
}
#show figure.caption.where(kind: table).or(figure.caption.where(kind: listing-kind)): set align(left)
#show table.cell: set align(left)

// Списки (ненумерованный и нумерованный)
#show list: it => {
  set par(justify: true, first-line-indent: (
    amount: INDENT,
    all: true
  ))
  
  let flag = false
  for item in it.children {
    if flag == false {
      [---#h(LIST-INDENT)#item.body]
      flag = true
    } else {
      [#h(INDENT)---#h(LIST-INDENT)#item.body]
    }
    [\ ]
  }
}
#show enum: it => {
  set par(justify: true, first-line-indent: (
    amount: INDENT,
    all: true
  ))
  
  let counter = 1
  let flag = false
  for item in it.children {
    if (item.has("number") and item.number != auto) {
      counter = item.number
    }
    if flag == false {
      [#counter#LIST-DOT#h(LIST-INDENT)#item.body]
      flag = true
    } else {
      [#h(INDENT)#counter#LIST-DOT#h(LIST-INDENT)#item.body]
    }
    [\ ]
    counter += 1
  }
}

// Заголовки
#set heading(numbering: "1.1.1", hanging-indent: 0pt)

#show heading: set text(size: TEXT-SIZE, hyphenate: false)

#let structural-heading-titles = (
  performers: [СПИСОК ИСПОЛНИТЕЛЕЙ],
  abstract: [РЕФЕРАТ],
  terms: [ТЕРМИНЫ И ОПРЕДЕЛЕНИЯ],
  abbreviations: [ПЕРЕЧЕНЬ СОКРАЩЕНИЙ И ОБОЗНАЧЕНИЙ],
  intro: [ВВЕДЕНИЕ],
  conclusion: [ЗАКЛЮЧЕНИЕ],
  references: [СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ]
)

#let current-appendix-letter = state("current-appendix-letter", "")

// Кастомная функция нумерации для фигур в приложениях
#let appendix-numbering(it) = context {
  if in-appendix.get() {
    let letter = current-appendix-letter.get()
    letter + "." + str(it)
  } else {
    str(it)
  }
}

// Создаем счетчик для приложений
#let appendix-counter = counter("appendix")

#let number-to-appendix-letter(n) = {
  appendix-names.at(n - 1)
}

// Функция для создания приложения (с автоматической буквой)
#let appendix(name: none, body) = { context {
  set par(first-line-indent: (
    amount: 0pt,
    all: true
  ))
  set align(center)
  // Увеличиваем счетчик приложений
  appendix-counter.step()
  
  // Получаем текущую букву
  let letter = number-to-appendix-letter(appendix-counter.get().first())
  align(center)[
    #heading(numbering: none, outlined: false, level: 1)[
      #{
        show heading: none
        heading(level: 1, numbering: none)[ПРИЛОЖЕНИЕ #letter. #name]
      }
      #h(-INDENT)ПРИЛОЖЕНИЕ #letter
      #align(center)[#text(size: TEXT-SIZE, weight: "regular")[#h(-INDENT)#name]]
      #v(GAP)
    ]
  ]
  
  // Устанавливаем состояние приложения
  in-appendix.update(true)
  current-appendix-letter.update(letter)
  
  // Сбрасываем и настраиваем счетчики фигур
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: listing-kind)).update(0)
  
  // Применяем все стили к содержимому приложения
  {
    // Устанавливаем кастомную нумерацию для фигур
    set figure(numbering: appendix-numbering)
    
    // Применяем позицию caption для таблиц и листингов
    show figure.where(kind: table).or(figure.where(kind: listing-kind)): set figure.caption(position: top)
    
    // Применяем выравнивание для ячеек таблиц
    show table.cell: set align(left)
    
    // Модифицируем caption для изменения supplement и выравнивания
    show figure.caption: it => context {
      if in-appendix.get() {
        let letter = current-appendix-letter.get()
        
        // Проверяем, является ли это листингом из функции listing
        if it.supplement == none {
          // Это листинг из функции listing, применяем выравнивание влево
          align(left, it.body)
        } else {
          // Это обычная фигура (image/table), добавляем supplement и выравнивание
          let supplement-text = if it.kind == image {
            "Рисунок"
          } else if it.kind == table {
            "Таблица"
          } else if it.kind == listing-kind {
            "Листинг"
          } else {
            it.supplement
          }
          
          align(center, [#supplement-text #it.counter.display(it.numbering) #it.separator #it.body])
        }
      } else {
          it
        }
      }
    }
    body
  }
  
  // Выходим из режима приложения
  in-appendix.update(false)
  current-appendix-letter.update("")
}

#let structure-heading-style = it => {
  align(center)[#upper(it)]
}

#let structure-heading(body) = {
  structure-heading-style(heading(numbering: none)[#body])
}

#let headings(text-size, indent, pagebreaks) = body => {
  show heading: set text(size: text-size)
  set heading(numbering: "1.1.1", hanging-indent: 0pt)
  
  show heading: it => {
    if it.body not in structural-heading-titles.values() {
      pad(it, left: indent)
    } else {
      it
    }
  }
  show heading.where(level: 1): it => {
    if pagebreaks == true and in-appendix.get() == false {
      pagebreak()
    }
    it
  }
  let structural-heading = structural-heading-titles
    .values()
    .fold(selector, (acc, i) => acc.or(heading.where(body: i, level: 1)))
  show structural-heading: set heading(numbering: none)
  show structural-heading: it => {
    structure-heading-style(it)
  }
  body
}
#show heading.where(level: 1): set block(above: PAR-LEADING, below: PAR-LEADING)
#show heading.where(level: 2): set block(above: PAR-LEADING, below: PAR-LEADING)
#show heading.where(level: 3): set block(above: PAR-LEADING, below: PAR-LEADING)
#show heading.where(level: 3): set text(weight: "thin")
#show: headings(TEXT-SIZE, INDENT, true)

// Листинг с поддержкой ссылок
#let listing(title, code-content, lang: none, label: none) = {
  context {
    let listing-num = counter(figure.where(kind: listing-kind)).get().first() + 1
    let is-in-appendix = in-appendix.get()
    let app-letter = if is-in-appendix { current-appendix-letter.get() } else { "" }
    let display = if is-in-appendix { app-letter + "." + str(listing-num) } else { str(listing-num) }    
    let first-page = counter(page).get().first()

    let fig = figure(
      kind: listing-kind,
      supplement: [Листинг],
      caption: none,
      table(
        columns: 1fr,
        stroke: 0.5pt,
        table.header(
          repeat: true,
          table.cell(
            stroke: none,
            align: left,
            inset: (left: 1pt, top: 1pt, bottom: LIST-INDENT),
            context {
              let current-page = counter(page).get().first()
              let cap = if current-page == first-page {
                [Листинг #display --- #title]
              } else {
                [Продолжение листинга #display]
              }
              set text(size: TEXT-SIZE)
              cap
            }
          )
        ),
        table.cell(
          align: left,
          block(
            width: 100%,
            {
              set text(size: TEXT-SIZE)
              set par(leading: LEADING)
              raw(code-content.text, lang: lang)
            }
          )
        )
      )
    )
    if label != none {
      [#fig #label]
    } else {
      fig
    }
  }
}

// Таблица с переносом по ГОСТ
#let gost-table(caption, columns, header: (), body) = {
  context {
    let n = if type(columns) == array { columns.len() } else { 1 }
    let tbl-num = counter(figure.where(kind: table)).get().first() + 1
    let in-app = in-appendix.get()
    let letter = if in-app { current-appendix-letter.get() } else { "" }
    let display = if in-app { letter + "." + str(tbl-num) } else { str(tbl-num) }
    let first-page = counter(page).get().first()

    figure(
      kind: table,
      supplement: [Таблица],
      table(
        columns: columns,
        stroke: 0.5pt,
        inset: 4pt,
        table.header(
          repeat: true,
          table.cell(
            colspan: n,
            stroke: none,
            align: left,
            inset: (left: 1pt, top: 1pt, bottom: LIST-INDENT),
            context {
              let here = counter(page).get().first()
              if here == first-page {
                [Таблица #display --- #caption]
              } else {
                [Продолжение таблицы #display]
              }
            },
          ),
          ..header,
        ),
        ..body,
      ),
    )
  }
}

#context(counter(page).update(START-PAGE))
#let counter1 = counter("level-2")
#let counter2 = counter("level-3")
#let smart-heading(level, body, num: auto) = {
  if level == 2 {
    if num == auto {
      counter1.step()
    }
    else {
      counter1.update(num)
    }
    counter2.update(0)
  } else if level == 3 {
    if num == auto {
      counter2.step()
    }
    else {
      counter2.update(num)
    }
  }
  context {
    if level == 2 {
      heading(level: level)[#body #counter1.get().at(0)]
    } else if level == 3 {
      heading(level: level)[#body #counter2.get().at(0)]
    }
  }
}
#let co = math.class( // запятая с корректными отступами
  "punctuation",
  $op(", ", limits: #false)$
)
#let nothing = text(scale(x: -100%)[#move(dy: -0.08em)[$nothing.rev$]]) // корректный символ пустого множества

// --------------------------ТЕКСТОВОЕ СОДЕРЖАНИЕ ДОКУМЕНТА--------------------------
