#let gost-math(chapter-numbering: false, body) = {
  // Базовый размер шрифта для формул (влияет на все символы и индексы)
  show math.equation: set text(size: 14pt)

  // Настройка нумерации формул
  set math.equation(numbering: (..nums) => context {
    let h-num = counter(heading).get().first()
    let eq-num = nums.pos().first()
    let app-letter = state("gost-app-letter", none).get()
    if app-letter != none {
      "(" + app-letter + "." + str(eq-num) + ")"
    } else if chapter-numbering and h-num > 0 {
      "(" + str(h-num) + "." + str(eq-num) + ")"
    } else {
      "(" + str(eq-num) + ")"
    }
  })

  // Сброс счетчика формул при начале новой главы (заголовок 1 уровня)
  show heading.where(level: 1): it => {
    if chapter-numbering {
      counter(math.equation).update(0)
    }
    it
  }

  // Перекрестные ссылки на формулы (выводит "(1.1)" вместо "Уравнение (1.1)")
  show ref: it => context {
    if it.element != none and it.element.func() == math.equation {
      let loc = it.element.location()
      let h-num = counter(heading).at(loc).first()
      let eq-num = counter(math.equation).at(loc).first()

      let num-str = if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(eq-num)
      } else {
        str(eq-num)
      }

      link(it.target)[(#num-str)]
    } else {
      it
    }
  }

  // Настройка отступов (одна пустая строка до и после)
  show math.equation.where(block: true): it => {
    // В Typst параграфный отступ = 1.5em. Установим аналогичные блочные отступы.
    block(above: 1.5em, below: 1.5em, it)
  }

  body
}

// Макрос для формирования списка "где ..." после формулы
#let gost-where(..items) = pad(top: 0em, bottom: 0em)[
  // Убираем абзацный отступ и включаем выравнивание
  #set par(first-line-indent: 0cm, justify: true)
  #let rows = ()
  #let is-first = true

  #for item in items.pos() {
    // Ожидаем массив/кортеж из двух элементов: (символ, описание)
    let (sym, desc) = item
    let prefix = if is-first { "где" } else { "" }
    rows.push(prefix)
    rows.push(sym)
    rows.push([---])
    rows.push(desc)
    is-first = false
  }

  // Сетка для выравнивания
  #grid(
    columns: (2.5em, auto, auto, 1fr),
    row-gutter: 1.5em, // Полуторный интервал между строками
    column-gutter: 0.5em,
    ..rows
  )
]
