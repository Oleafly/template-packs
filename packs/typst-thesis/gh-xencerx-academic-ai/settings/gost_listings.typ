#import "gost_fonts.typ": gost-serif, gost-mono

#let gost-listing-chapter-num-state = state("gost-listing-chapter-numbering", false)

#let _gost-in-listing = state("gost-in-listing", false)


// GOST Listings Settings
#let gost-listings(chapter-numbering: false, body) = {
  // Сохраняем параметр chapter-numbering в состояние
  gost-listing-chapter-num-state.update(chapter-numbering)

  // Устанавливаем префикс для листингов
  show figure.where(kind: "listing"): set figure(supplement: "Листинг")
  // Разрешаем фигурам-листингам переноситься между страницами
  show figure.where(kind: "listing"): set block(breakable: true)

  show heading.where(level: 1): it => {
    if chapter-numbering {
      counter(figure.where(kind: "listing")).update(0)
    }
    it
  }

  // Перекрестные ссылки на листинги
  show ref: it => context {
    if it.element != none and it.element.func() == figure and it.element.kind == "listing" {
      let loc = it.element.location()
      let h-num = counter(heading).at(loc).first()
      let l-num = counter(figure.where(kind: "listing")).at(loc).first()

      let sup = it.supplement
      if sup == auto { sup = "Листинг" }

      let app-letter = state("gost-app-letter", none).at(loc)
      let num-str = if app-letter != none { app-letter + "." + str(l-num) } else if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(l-num)
      } else { str(l-num) }

      link(it.target)[#sup #num-str]
    } else {
      it
    }
  }

  // Оформление подписи листинга
  show figure.where(kind: "listing"): it => context {
    set align(left)

    let caption-text = if it.caption != none {
      set text(font: gost-serif, size: 12pt, weight: "regular", style: "italic")
      set par(first-line-indent: 0cm, leading: 0.65em, justify: false)

      let h-num = counter(heading).get().first()
      let l-num = it.counter.get().first()

      let app-letter = state("gost-app-letter", none).get()
      let num-str = if app-letter != none {
        app-letter + "." + str(l-num)
      } else if chapter-numbering and h-num > 0 {
        str(h-num) + "." + str(l-num)
      } else {
        str(l-num)
      }

      block(
        width: 100%,
        below: 1mm,
        sticky: true,
        align(left)[#it.supplement #num-str --- #it.caption.body],
      )
    } else {
      none
    }

    block(
      width: 100%,
      breakable: true,
      above: 8mm, // Отступ перед подписью до основного текста (6мм)
      below: 8mm,// Отступ после листинга (6 мм)
      {
        caption-text
        it.body
      },
    )
  }

  // Оформление raw-блоков:
  // Если мы внутри gost-listing — рамку НЕ добавляем (таблица уже её даёт), только применяем шрифт. Иначе — стандартное оформление по ГОСТу.
  show raw.where(block: true): it => context {
    set text(font: gost-mono, size: 10pt)
    set par(first-line-indent: 0cm, leading: 0.65em, justify: false)

    if _gost-in-listing.get() {
      // Рамка снаружи — от таблицы, здесь только шрифт
      it
    } else {
      block(
        width: 100%,
        stroke: 0.5pt + black,
        inset: 6pt,
        breakable: true,
        it,
      )
    }
  }

  body
}


// Макрос для вставки листинга с автоматической нумерацией строк шагом 10
#let gost-listing(
  file: none,
  code: none,
  caption: none,
  lang: none,
  numbers: false,
  new-page: false,
) = {
  if new-page {
    pagebreak(weak: true)
  }

  let content = if file != none {
    read(file)
  } else if code != none {
    code
  } else {
    ""
  }

  let raw-body = if numbers {
    let lines = content.split("\n")
    let numbered-lines = ()
    let n = 10
    for line in lines {
      let num-str = str(n)
      if n < 100 { num-str = num-str + "  " } else if n < 1000 { num-str = num-str + " " }
      numbered-lines.push(num-str + " " + line)
      n += 10
    }
    raw(numbered-lines.join("\n"), lang: lang, block: true)
  } else {
    raw(content, lang: lang, block: true)
  }

  figure(
    caption: caption,
    kind: "listing",
    supplement: "Листинг",
    [
      #_gost-in-listing.update(true)
      #metadata("lst-start") <gost-lst-start>

      #table(
        columns: (1fr,),
        stroke: 0.5pt + black,
        inset: 0pt,

        table.header(
          repeat: true,
          table.cell(
            stroke: none,
            inset: 0pt,
            context {
              let caps = query(selector(<gost-lst-start>).before(here(), inclusive: true))
              if caps.len() > 0 {
                let start-page = caps.last().location().page()
                if here().page() > start-page {
                  let h-num = counter(heading).get().first()
                  let l-num = counter(figure.where(kind: "listing")).get().first()
                  let app-letter = state("gost-app-letter", none).get()
                  let is-chap = gost-listing-chapter-num-state.get()

                  let num-str = if app-letter != none {
                    app-letter + "." + str(l-num)
                  } else if is-chap and h-num > 0 {
                    str(h-num) + "." + str(l-num)
                  } else {
                    str(l-num)
                  }

                  pad(bottom: 1mm, align(left, text(
                    font: gost-serif,
                    size: 12pt,
                    style: "italic",
                    weight: "regular",
                    "Продолжение Листинга " + num-str,
                  )))
                }
              }
            },
          ),
        ),

        // Сам листинг в ячейке с отступами
        table.cell(inset: 6pt, raw-body),
      )

      #_gost-in-listing.update(false)
    ],
  )
}
