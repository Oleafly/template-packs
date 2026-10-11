#import "gost_fonts.typ": gost-serif

#let _bib-sec = counter("gost-bib-section")
#let _bib-item = counter("gost-bib-item")

#let gost-bibliography-title() = {
  _bib-sec.update(0)
  _bib-item.update(0)

  pagebreak(weak: true)

  // Главный заголовок "СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ"
  // Форматируется как Заголовок 1 уровня: 18пт, полужирный, все прописные, по центру, интервал после 10мм
  align(center)[
    #block(
      above: 0mm,
      below: 10mm,
      sticky: true,
      {
        // Убираем красную строку, чтобы заголовок был ровно по центру
        set par(first-line-indent: 0cm)
        text(font: gost-serif, size: 18pt, weight: "bold")[СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ]
      },
    )
  ]
}

#let gost-bib-section(title) = {
  _bib-sec.step()
  _bib-item.update(0)

  v(1.5em)

  // Заголовок раздела внутри списка литературы
  // 14пт, обычный шрифт (не полужирный), все прописные, по центру, отступ слева 1.25 см
  // Интервал перед 6 мм, после 6 мм, не отрывать от следующего (sticky: true)
  align(center)[
    #block(
      above: 6mm,
      below: 6mm,
      sticky: true,
      {
        set par(first-line-indent: 0cm)
        // context нужен, чтобы прочитать текущее значение счётчика
        context pad(
          left: 1.25cm,
          text(
            font: gost-serif,
            size: 14pt,
            weight: "regular",
            upper(str(_bib-sec.get().first()) + ". " + title),
          ),
        )
      },
    )
  ]

  v(1.5em)
}

#let gost-bib-item(body) = {
  _bib-item.step()

  // Выравнивание по ширине, отступ слева 0, все строки текста после первой сдвинуты (hanging indent)
  // Реализуем через сетку: первая колонка 1.25 см для номера, вторая для текста
  set par(first-line-indent: 0cm, leading: 1.5em, justify: true)

  // Добавляем отступ над блоком, чтобы между источниками сохранялся полуторный интервал
  block(
    width: 100%,
    above: 1.5em,
    below: 0mm,
    context {
      let sec = _bib-sec.get().first()
      let item = _bib-item.get().first()
      grid(
        columns: (1.25cm, 1fr),
        align: (left, left),
        text(font: gost-serif, size: 14pt, weight: "regular", str(sec) + "." + str(item) + "."),
        text(font: gost-serif, size: 14pt, weight: "regular", body),
      )
    },
  )
}
