//==============================================================================
// vkr.typ — шаблон пояснительной записки ВКР бакалавра ВолгГТУ
//
// Оформление соответствует методическим указаниям:
//   А. Г. Кравец, М. В. Щербаков. Выпускная квалификационная работа бакалавра:
//   учеб. пособие. — Волгоград: ВолгГТУ, 2024. — 64 с. (раздел 4.1)
//
// Каждое правило вёрстки ниже помечено ссылкой на страницу методички.
// Студенту править этот файл не нужно — все параметры передаются в #vkr(...).
//==============================================================================

//------------------------------------------------------------------------------
// Метрики
//------------------------------------------------------------------------------

// Typst считает высоту строки от cap-height (для Times New Roman = 0.662em),
// поэтому leading = нужная высота строки − cap-height.
//
// Методичка (с. 29) требует буквально: «интервал – полуторный», без числа.
// Полуторный здесь читается по MS Word — именно в нём работает нормоконтроль.
// Для Times New Roman (hhea: (1825+443+87)/2048 = 1.1499em на строку)
// полуторный = 1.5 × 1.1499em = 1.7249em, то есть 24.148pt при кегле 14.
//
// Осторожно с LaTeX как источником истины: \onehalfspacing из setspace даёт
// множитель 1.25, а не 1.5 — это типографская условность пакета. Замер
// эталонного layout.tex дал \baselineskip = 21.25pt, что на 13 % плотнее
// полуторного и не соответствует методичке.
#let line-height = 1.7249em
#let cap-height = 0.662em
#let gost-leading = line-height - cap-height

// Одинарный интервал — для «длинных» таблиц (методичка, с. 33)
#let single-leading = 1.1499em - cap-height

//------------------------------------------------------------------------------
// Русские буквы для перечислений и приложений
// ГОСТ 7.32 / методичка с. 33: исключаются Ё, З, Й, О, Ч, Ь, Ы, Ъ
//------------------------------------------------------------------------------

#let ru-upper = ("А", "Б", "В", "Г", "Д", "Е", "Ж", "И", "К", "Л", "М", "Н",
                 "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ш", "Щ", "Э", "Ю", "Я")
#let ru-lower = ru-upper.map(l => lower(l))

#let ru-letter(n, upper: true) = {
  let alphabet = if upper { ru-upper } else { ru-lower }
  alphabet.at(calc.rem(n - 1, alphabet.len()))
}

//------------------------------------------------------------------------------
// Состояние приложений: внутри приложения рисунки/таблицы нумеруются «А.1»
//------------------------------------------------------------------------------

#let appendix-state = state("appendix-letter", none)

//------------------------------------------------------------------------------
// Приложение (методичка, с. 33)
//   «Каждое приложение следует начинать с новой, отдельной страницы с указанием
//    наверху посередине слова "Приложение", его номера и следом на новой строке
//    центрированного заголовка с прописной буквы»
//------------------------------------------------------------------------------

#let appendix-counter = counter("appendix")

#let appendix(title, body) = {
  pagebreak(weak: true)
  appendix-counter.step()

  context {
    let letter = ru-letter(appendix-counter.get().first())
    appendix-state.update(letter)

    // Собственная нумерация внутри каждого приложения
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)

    // Невидимый заголовок — нужен только для того, чтобы приложение попало
    // в содержание одной строкой: «Приложение А. Название»
    {
      show heading: it => none
      heading(level: 1, numbering: none, outlined: true, bookmarked: true,
        [Приложение #letter. #title])
    }

    // Видимое оформление (методичка, с. 33): слово «Приложение» с буквой
    // наверху посередине, следом на новой строке центрированный заголовок
    set par(first-line-indent: 0pt, justify: false, leading: gost-leading)
    align(center)[Приложение #letter]
    align(center)[#title]
    v(line-height)
  }

  body
}

//------------------------------------------------------------------------------
// Вспомогательные конструкции для содержания записки
//------------------------------------------------------------------------------

// Ненумерованный раздел: Введение, Заключение, Список источников и т. п.
#let unnumbered(title) = heading(level: 1, numbering: none, title)

// Ссылка только на номер, без слова-спутника.
// Нужна для склонений, которых Typst сам не делает и пакета для этого нет:
//   «в таблице #nref(<tbl-metrics>)»  →  «в таблице 1»
// Обычная ссылка @tbl-metrics даёт «таблица 1» — как требует методичка (с. 32)
// для именительного падежа.
#let nref(label) = ref(label, supplement: none)

// Аннотация (методичка, с. 34): на русском и английском, страницы 4 и 5
#let abstract(lang: "ru", body) = {
  pagebreak(weak: true)
  set text(lang: lang)
  align(center, text(weight: "regular", if lang == "ru" [АННОТАЦИЯ] else [ABSTRACT]))
  v(line-height)
  body
}

// Формула с пояснением: первая строка пояснения начинается со слова «где»
// без двоеточия (методичка, с. 32)
#let where-block(body) = {
  set par(first-line-indent: 0pt)
  body
}

//------------------------------------------------------------------------------
// Основной шаблон
//------------------------------------------------------------------------------

#let vkr(
  // Идентификатор ПЗ в верхнем колонтитуле (методичка, с. 34):
  //   ВКР - 40 461 806 - 0.27-NN-YY.81
  //   40 461 806 — код вуза; 0.27 — код кафедры;
  //   NN — номер в приказе; YY — год; 81 — шифр ПЗ
  vkr-id: "ВКР – 40 461 806 – 0.27–NN–YY.81",

  // Титульный лист и задание выдаются на кафедре (методичка, с. 29).
  // Сюда кладётся путь к их скану/PDF; страницы 1–3 нумеруются, но номер
  // на них не печатается.
  title-pages: none,
  title-page-count: 3,

  // Шрифт. Times New Roman нельзя коммитить в репозиторий по лицензии,
  // поэтому заданы метрически совместимые запасные варианты для CI и Linux.
  font: ("Times New Roman", "Liberation Serif", "PT Astra Serif", "Tinos"),
  mono-font: ("Consolas", "DejaVu Sans Mono", "Liberation Mono"),
  font-size: 14pt,

  // Расстояние между заголовком и текстом — «два полуторных интервала»,
  // то есть одна пустая строка (методичка, с. 30)
  heading-gap: line-height,

  body,
) = {
  //-- Страница (методичка, с. 29–30): A4, поля 30/10/15/20, номер внизу
  //   по центру без точки, сквозная нумерация с титульного листа
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 10mm, top: 15mm, bottom: 20mm),
    header: context {
      // На титульном листе и задании колонтитул не печатается
      if counter(page).get().first() > title-page-count {
        align(center, text(size: font-size, vkr-id))
      }
    },
    footer: context {
      if counter(page).get().first() > title-page-count {
        align(center, text(size: font-size, counter(page).display("1")))
      }
    },
  )

  //-- Текст: Times New Roman, кегль 14, русские переносы
  set text(font: font, size: font-size, lang: "ru", hyphenate: true)
  show raw: set text(font: mono-font, size: 12pt)

  //-- Абзац: выравнивание по ширине, отступ 15 мм, полуторный интервал.
  //   spacing = leading, чтобы между абзацами не было лишнего отбива.
  set par(
    justify: true,
    first-line-indent: (amount: 15mm, all: true),
    leading: gost-leading,
    spacing: gost-leading,
  )

  //-- Заголовки (методичка, с. 30)
  //   Нумерация арабскими цифрами без точки, с абзацного отступа,
  //   обычный шрифт, переносы слов не допускаются.
  set heading(numbering: "1.1.1")
  show heading: set text(size: font-size, weight: "regular", hyphenate: false)
  show heading: it => {
    // Разделы начинаются с новой страницы
    if it.level == 1 { pagebreak(weak: true) }
    // Методичка, с. 30: «Расстояние между заголовком и текстом равно двум
    // полуторным интервалам (т. е. дважды использовать клавишу "Enter")» —
    // то есть одна пустая строка сверх обычного межстрочного хода.
    block(
      above: if it.level == 1 { 0pt } else { heading-gap },
      below: heading-gap,
      {
        set par(first-line-indent: 0pt, justify: false, leading: gost-leading)
        // Заголовок записывается с абзацного отступа
        h(15mm)
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(1em)
        }
        it.body
      },
    )
  }

  //-- Перечисления (методичка, с. 30–31)
  //   Маркированный список — тире; нумерованный — «1)»; вложенный — «а)»
  //   Текст пункта встаёт на 15 мм — вровень с красной строкой, а маркер
  //   выносится левее (как enumitem leftmargin=15mm в эталоне). Отступы
  //   подобраны под ширину маркера: «–» шире, чем «1)», поэтому значения разные.
  set list(marker: [–], indent: 10mm, body-indent: 0.5em, spacing: gost-leading)
  set enum(
    numbering: (..n) => {
      let nums = n.pos()
      if nums.len() == 1 { [#nums.first())] } else { [#ru-letter(nums.last(), upper: false))] }
    },
    indent: 8.5mm,
    body-indent: 0.5em,
    spacing: gost-leading,
    full: true,
  )

  //-- Формулы (методичка, с. 31–32)
  //   Отдельной строкой по центру, сквозная нумерация справа в круглых скобках
  set math.equation(numbering: "(1)", supplement: none)
  show math.equation.where(block: true): set block(above: line-height, below: line-height)
  //-- Ссылки в тексте (методичка, с. 31–32)
  //   на формулу — «в формуле (1)»;
  //   на рисунок — «рисунок 1»,  на таблицу — «таблица 3» — со строчной буквы,
  //   поэтому слово-спутник в ссылке приводится к нижнему регистру, а в подписи
  //   под рисунком остаётся с прописной.
  show ref: it => {
    let el = it.element
    if el == none { return it }

    if el.func() == math.equation {
      link(el.location(), numbering("(1)", ..counter(math.equation).at(el.location())))
    } else if el.func() == figure {
      link(el.location(), {
        // #ref(<метка>, supplement: none) даёт только номер — это нужно, когда
        // слово требует склонения: «в таблице #ref(<t>, supplement: none)»
        if it.supplement != none and it.supplement != auto {
          it.supplement
          [ ]
        } else if it.supplement == auto {
          lower(el.supplement)
          [ ]
        }
        context numbering(el.numbering, ..counter(figure.where(kind: el.kind)).at(el.location()))
      })
    } else { it }
  }

  //-- Рисунки и таблицы
  //   Рисунок: подпись внизу по центру, «Рисунок 1 – Название» (методичка, с. 32)
  //   Таблица: название над таблицей слева, «Таблица 3 – Название» (методичка, с. 32)
  //   В приложениях нумерация с буквой приложения: «Рисунок А.1» (методичка, с. 33)
  set figure(numbering: n => context {
    let letter = appendix-state.get()
    if letter == none { str(n) } else { letter + "." + str(n) }
  })
  set figure(supplement: [Рисунок], gap: line-height)
  show figure.where(kind: table): set figure(supplement: [Таблица])
  show figure.where(kind: raw): set figure(supplement: [Листинг])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(size: font-size)
  show figure.caption: set par(first-line-indent: 0pt, justify: false)
  set figure.caption(separator: [ – ])
  // Название таблицы прижимается влево, подпись рисунка — по центру
  show figure.where(kind: table): set align(left)
  show figure: set block(above: line-height, below: line-height)

  //-- Таблицы: линии слева, справа и снизу (методичка, с. 33)
  set table(stroke: 0.5pt, inset: (x: 5pt, y: 3pt))
  show table: set par(first-line-indent: 0pt, justify: false)
  show table: set text(size: font-size)

  //-- Ссылки на источники в квадратных скобках (методичка, с. 31) —
  //   обеспечивается стилем gost-r-705-2008-numeric
  show cite: set text(fill: black)
  show link: set text(fill: black)

  //-- Титульный лист и задание
  if title-pages != none {
    // Вставляются как готовые страницы; номера на них не печатаются,
    // но в общую нумерацию входят (методичка, с. 29)
    title-pages
  } else {
    // Заглушка, чтобы нумерация не поехала, пока бланков ещё нет
    for _ in range(title-page-count) {
      pagebreak(weak: true)
      align(center + horizon, text(
        fill: luma(50%),
        [_Здесь будут титульный лист и задание (выдаются на кафедре)._],
      ))
    }
  }

  body
}

//------------------------------------------------------------------------------
// Содержание (методичка, с. 34: «до третьего уровня включительно»)
//------------------------------------------------------------------------------

#let table-of-contents() = {
  pagebreak(weak: true)
  show outline.entry: set par(first-line-indent: 0pt)
  set outline.entry(fill: repeat(justify: false)[.])
  outline(title: [Содержание], depth: 3, indent: 15mm)
}

//------------------------------------------------------------------------------
// Список использованных источников (методичка, с. 31)
//   Стиль ГОСТ Р 7.0.5-2008, числовой — встроен в Typst
//------------------------------------------------------------------------------

// Принимает СОДЕРЖИМОЕ файла, а не путь: пути внутри функции Typst резолвит
// относительно lib/, поэтому в thesis.typ пишется
//   #sources(read("bibliography/references.bib"))
#let sources(data) = {
  pagebreak(weak: true)
  set par(first-line-indent: (amount: 15mm, all: true))
  bibliography(
    bytes(data),
    // Не встроенный стиль, а свой файл: во встроенном диапазон страниц
    // выводится как «Сс. 311–317» вместо «С. 311–317».
    // Подробности правки — в комментарии внутри самого CSL.
    style: "csl/gost-r-705-2008-numeric.csl",
    title: [Список использованных источников],
    full: false,
  )
}
