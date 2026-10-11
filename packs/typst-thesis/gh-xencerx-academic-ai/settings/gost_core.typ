#import "gost_fonts.typ": gost-serif

#let gost-core(body) = {
  // Страницы
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 10mm, top: 21.8mm, bottom: 20mm),
    footer: context {
      // Нумерация страниц: по центру внизу, арабскими цифрами
      // Номерация начинается со страницы, следующей за меткой <start-numbering>
      let page-num = counter(page).get().first()

      // Ищем метку начала нумерации
      let start-label = query(<start-numbering>).first()
      let start-page = if start-label != none {
        start-label.location().page()
      } else {
        3 // fallback: если метка не найдена, начинаем с 3-й страницы
      }

      // Показываем номер только на страницах после метки
      if page-num > start-page {
        align(center, text(font: gost-serif, size: 12pt, weight: "regular", str(page-num)))
      }
    },
  )

  // Основной текст
  set text(
    font: gost-serif,
    size: 14pt,
    weight: "regular",
    lang: "ru",
  )

  // Абзацы
  set par(
    justify: true,
    first-line-indent: (amount: 1.25cm, all: true),
    leading: 1.14em, // полуторный интервал
    spacing: 1.14em, // интервал между абзацами
  )

  // Заголовки
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      str(n.first()) // Level 1: "1" (без точки)
    } else {
      n.map(str).join(".") + "." // Level 2+: "1.1." (с точкой)
    }
  })

  show heading: it => {
    // Получаем номер
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
    } else {
      none
    }

    let body-text = it.body
    let above-space = if it.level == 1 { 0mm } else { 21mm }

    // Если это заголовок первого уровня, добавляем разрыв страницы перед ним
    if it.level == 1 {
      pagebreak(weak: true)
    }

    // Определяем размер текста для каждого уровня
    let h-size = if it.level == 1 { 18pt } else if it.level == 2 { 16pt } else { 14pt }

    let style-text(content) = {
      let res = text(size: h-size, weight: "bold", content)
      if it.level == 1 {
        res = upper(res) // Все прописные для 1 уровня
      }
      return res
    }

    // Создаем сетку, если есть номер, иначе выводим просто текст
    let result = if number != none {
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.5em,
        style-text(number), style-text(body-text),
      )
    } else {
      style-text(body-text)
    }

    block(
      above: above-space,
      below: 16mm, // Интервал после заголовков 10 мм
      sticky: true,
      pad(left: 1.25cm, result),
    )
  }

  // 3. Маркированные и нумерованные списки
  set list(
    indent: 1.25cm,
    body-indent: 0.8cm, // Отступ маркера 1.25, текст начинается на 2.25
    marker: "●",
  )

  set enum(
    indent: 1.25cm,
    body-indent: 0.8cm,
    numbering: "1", // Без точки в конце
  )

  body
}
