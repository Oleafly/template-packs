#import "gost_fonts.typ": gost-serif

#let gost-chapter-num-state = state("gost-chapter-numbering", false)

#let gost-tables(chapter-numbering: false, body) = {
  gost-chapter-num-state.update(chapter-numbering)

  // Устанавливаем префикс для таблиц
  show figure.where(kind: table): set figure(supplement: "Таблица")
  // Разрешаем фигурам-таблицам переноситься между страницами
  show figure.where(kind: table): set block(breakable: true)

  // Сброс счетчика таблиц при начале новой главы (заголовок 1 уровня)
  show heading.where(level: 1): it => {
    if chapter-numbering {
      counter(figure.where(kind: table)).update(0)
    }
    it
  }

  // Перекрестные ссылки на таблицы ("Таблица 1.1")
  show ref: it => context {
    if it.element != none and it.element.func() == figure and it.element.kind == table {
      let loc = it.element.location()
      let h-num = counter(heading).at(loc).first()
      let t-num = counter(figure.where(kind: table)).at(loc).first()

      let sup = it.supplement
      if sup == auto { sup = "Таблица" }

      let app-letter = state("gost-app-letter", none).at(loc)
      let num-str = if app-letter != none { app-letter + "." + str(t-num) } else if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(t-num)
      } else { str(t-num) }

      link(it.target)[#sup #num-str]
    } else {
      it
    }
  }

  // Оформление подписи (заголовка) таблицы
  show figure.where(kind: table): it => context {
    set align(left)

    let caption-text = if it.caption != none {
      set text(font: gost-serif, size: 12pt, weight: "regular", style: "italic")
      // Одинарный межстрочный интервал и выравнивание по левому краю, убираем абзацный отступ
      set par(first-line-indent: 0cm, leading: 0.65em, justify: false)

      // Вычисляем номер
      let h-num = counter(heading).get().first()
      let t-num = it.counter.get().first()

      let app-letter = state("gost-app-letter", none).get()
      let num-str = if app-letter != none {
        app-letter + "." + str(t-num)
      } else if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(t-num)
      } else {
        str(t-num)
      }

      block(
        width: 100%,
        below: 1mm, // Прилегает к таблице
        sticky: true, // Не отрывать от следующего (таблицы)
        // Выводим "Таблица N --- Текст подписи"
        align(left)[#it.supplement #num-str --- #it.caption.body],
      )
    } else {
      none
    }

    // Размещаем подпись НАД таблицей, а затем саму таблицу
    block(
      width: 100%,
      breakable: true, // Разрешаем перенос таблицы
      above: 8mm, // Отступ перед подписью до основного текста (6мм)
      below: 8mm, // Отступ после таблицы (6 мм)
      {
        caption-text
        it.body
      },
    )
  }

  // Оформление содержимого внутри всех таблиц
  show table.cell: it => {
    set text(font: gost-serif, size: 12pt)
    set par(first-line-indent: 0cm, leading: 0.65em, justify: false)
    it
  }

  body
}

// Макрос для создания таблицы по ГОСТу с переносами и заголовками "Продолжение таблицы..."
#let gost-table(
  columns: auto,
  caption: none,
  header: none,
  ..cells,
) = {
  figure(
    caption: caption,
    kind: table,
    supplement: "Таблица",
    [
      #metadata("tbl-start") <gost-tbl-start>
      #table(
        columns: columns,
        // Заголовок таблицы (шапка), который будет повторяться на новых страницах
        table.header(
          repeat: true,
          table.cell(
            colspan: if type(columns) == array { columns.len() } else { 1 },
            stroke: none,
            inset: 0pt, // Чтобы пустая строка на первой странице не занимала места
            context {
              let caps = query(selector(<gost-tbl-start>).before(here(), inclusive: true))
              if caps.len() > 0 {
                let start-page = caps.last().location().page()
                if here().page() > start-page {
                  let h-num = counter(heading).get().first()
                  let t-num = counter(figure.where(kind: table)).get().first()
                  let app-letter = state("gost-app-letter", none).get()
                  let is-chap = gost-chapter-num-state.get()

                  let num-str = if app-letter != none {
                    app-letter + "." + str(t-num)
                  } else if is-chap and h-num > 0 {
                    str(h-num) + "." + str(t-num)
                  } else {
                    str(t-num)
                  }

                  pad(bottom: 1mm, align(left, text(
                    font: gost-serif,
                    size: 12pt,
                    style: "italic",
                    weight: "regular",
                    "Продолжение Таблицы " + num-str,
                  )))
                }
              }
            },
          ),
          ..{
            let h = if type(header) == arguments { header.pos() } else if type(header) == array { header } else {
              (header,)
            }
            h.map(item => table.cell(
              align: center,
              text(weight: "bold", item), // Жирный текст по центру для заголовков столбцов
            ))
          },
        ),
        ..cells
      )
    ],
  )
}
