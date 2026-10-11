#import "gost_fonts.typ": gost-serif

// Временная замена отсутствующего изображения с обычной нумерацией рисунков.
#let gost-image-placeholder(
  caption: none,
  width: 70%,
  height: 60mm,
  note: [Иллюстрация будет добавлена позднее],
) = figure(
  kind: image,
  caption: caption,
  rect(
    width: width,
    height: height,
    fill: luma(96%),
    stroke: 0.5pt + luma(55%),
    radius: 1mm,
    inset: 8mm,
    align(
      center + horizon,
      text(font: gost-serif, size: 11pt, fill: luma(40%), note),
    ),
  ),
)

#let gost-figures(chapter-numbering: false, body) = {
  // Устанавливаем префикс по умолчанию
  set figure(supplement: "Рисунок")

  // Сброс счетчика рисунков при начале новой главы (заголовок 1 уровня)
  show heading.where(level: 1): it => {
    if chapter-numbering {
      counter(figure.where(kind: image)).update(0)
    }
    it
  }

  // Настройка перекрестных ссылок (чтобы в тексте правильно выводилось "Рисунок 1.1")
  show ref: it => context {
    if chapter-numbering and it.element != none and it.element.func() == figure and it.element.kind == image {
      let loc = it.element.location()
      let h-num = counter(heading).at(loc).first()
      let f-num = counter(figure.where(kind: image)).at(loc).first()

      let sup = it.supplement
      if sup == auto { sup = "Рисунок" }

      let num-str = if h-num > 0 { str(h-num) + "." + str(f-num) } else { str(f-num) }

      link(it.target)[#sup #num-str]
    } else {
      it
    }
  }

  // Применяем правила только для фигур, содержащих изображения
  show figure.where(kind: image): it => context {
    set align(center)

    let caption-text = if it.caption != none {
      set text(font: gost-serif, size: 12pt, weight: "bold")
      // Одинарный межстрочный интервал (0.65em) и выравнивание по центру, убираем абзацный отступ
      set par(first-line-indent: 0cm, leading: 0.65em, justify: false)

      // Вычисляем номер
      let h-num = counter(heading).get().first()
      let f-num = it.counter.get().first()

      let app-letter = state("gost-app-letter", none).get()
      let num-str = if app-letter != none {
        app-letter + "." + str(f-num)
      } else if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(f-num)
      } else {
        str(f-num)
      }

      block(
        width: 100%,
        above: 1mm, // Прилегает к рисунку
        // Выводим "Рисунок N --- Текст подписи" (--- превратится в длинное тире)
        align(center)[#it.supplement #num-str --- #it.caption.body],
      )
    } else {
      none
    }

    // Блок, который не разрывается между страницами (изображение + подпись)
    block(
      breakable: false,
      width: 100%,
      below: 8mm, // Отступ после подписи до основного текста (6мм)
      {
        it.body // Сама картинка
        caption-text // Подпись под картинкой
      },
    )
  }

  body
}
