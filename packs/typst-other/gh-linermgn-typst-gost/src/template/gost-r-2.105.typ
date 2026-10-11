/**
 * Настройки требований ГОСТ Р 2.105-2019
 * https://protect.gost.ru/v.aspx?control=8&baseC=6&page=6&month=6&year=2024&search=&RegNum=1&DocOnPageCount=15&id=224791
 **/

// титульный лист (8)
#let titlePage(
  code: auto,
  company: auto,
  product: auto,
  title: auto,
  year: datetime.today().year(), // текущий год
) = [
  #set page(footer: [#year], header: [], paper: "a4", margin: (
    top: 2cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  ))

  #set align(center)

  // наименование ведомства (8.9, поле 1)
  * #company *

  #v(2em)

  #align(left, {
    "УТВЕРЖДЕН"
    parbreak()
    code + "-ЛУ"
  })

  #v(6em)

  // наименование изделия и документа прописными буквами (8.9, поле 4)
  #upper[
    #product

    * #title *
  ]

  // обозначение (код) документа (8.9, поле 6)
  #code

  #v(2em)

  // количество листов (8.9, поле 7)
  #context [
    на
    #counter(page).final().at(0)
    листах
  ]
  #pagebreak()
]

// настройки документа
#let gost(
  code: auto, // код документа
  headerCode: true, // отображать в шапке страниц код документа
  company: auto,
  product: auto,
  title: auto,
  description: auto,
  keywords: auto, // ключевые слова для pdf документа
  year: datetime.today().year(), // текущий год
  author: auto,
  font-size: 12pt, // размер шрифта 11-14pt (5.1.1)
  font-name: "Times New Roman", // пропорциональный шрифт с засечками (5.1.1)
  body,
) = {
  // настройка документа
  set document(
    author: author,
    title: title,
    description: description,
    keywords: keywords,
  )

  // настройка страницы
  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 1.5cm,
      left: 2cm,
      right: 2cm,
    ), // размер полей (ГОСТ 7.0.11-2011, 5.3.7)
    numbering: "1", // сквозная нумерация страниц
    number-align: top,
    header: align(center)[
      #counter(footnote).update(0) // для каждой страницы используют отдельную систему нумерации сносок (6.13.5)
      #set par(leading: 0.5em)
      #context counter(page).display()\
      #if (headerCode) {
        code
      }
    ],
  )

  // общие настройки текста
  set text(
    lang: "ru",
    size: font-size,
    font: font-name,
    hyphenate: true, // допускается перенос в основном тексте (5.1.2)
  )

  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (
      all: true,
      amount: font-size * 2.5, // абзац равен пяти знакам используемой гарнитуры шрифта (5.1.4)
    ),
    leading: 1em, // рекомендуется полуторный межстрочный интервал (5.1.2)
  )

  // настройки заголовков
  show heading: it => {
    if it.level == 1 {
      pagebreak() // каждый раздел технической документации рекомендуется начинать с новой страницы (6.6.5)
    }

    set text(hyphenate: false) // не допускается перенос в заголовках (5.1.2)

    // расстояние между заголовком и текстом или двумя заголовками равно не менее чем двум высотам шрифта (6.6.3)
    v(24pt, weak: true)

    if counter(heading).display() != "0" {
      counter(heading).display()
      " "
    }
    it.body

    // расстояние между заголовком и текстом или двумя заголовками равно не менее чем двум высотам шрифта (6.6.3)
    v(24pt, weak: true)
  }

  // настройка списков
  set list(marker: [--], indent: font-size * 2.5)
  set enum(indent: font-size * 2.5)

  // настройка содержания
  set outline(depth: 3)
  show outline: it => {
    show heading: set align(center)
    it
  }

  // настройки для вставок (рисунки + таблицы)
  set figure.caption(separator: [ -- ])

  // настройка рисунков
  show figure.where(kind: image): set figure(supplement: [Рисунок])

  // настройка таблиц
  show table.cell: set text(size: 0.8em) // для таблиц размер текста на 1-2 пункта меньше основного (5.1.1)

  show figure.where(kind: table): set figure(supplement: [Таблица])

  show figure.where(kind: table): it => {
    set block(breakable: true)
    set figure.caption(position: top) // наименование следует помещать над таблицей (6.8.1)
    set align(left) // слово Таблица указывают слева (6.8.7)
    it
  }

  // перед номером таблицы пишут слово Таблица с заглавной буквы и разреженным шрифтом (6.8.2)
  show figure.caption.where(kind: table): it => {
    set text(tracking: 0.15em)
    set par(first-line-indent: 0pt)

    it.supplement
    " "
    context counter(figure.where(kind: table)).display()

    set text(tracking: 0pt)
    " – "
    it.body
  }

  // настройка сноски (6.13)
  set footnote(numbering: "1)") // знак сноски выполняют арабскими цифрами со скобкой (6.13.4)

  // отрисовка титульного листа (обязательный элемент)
  titlePage(
    code: code,
    company: company,
    product: product,
    title: title,
    year: year,
  )

  // остальная часть документа, к которому применятся заданные выше настройки
  body
}

// примечания (6.12)
#let remark(..remarks) = {
  set text(
    tracking: 0.15em,
    size: 0.9em,
  ) // Примечания выделяют уменьшенным размером шрифта. Слово Примечание выделяют разрядкой (6.12.2)

  if (remarks.pos().len() == 1) {
     // одно примечание не нумеруют (6.12.3)
    "Примечание"
    set text(tracking: 0pt)
    " – "
    remarks.at(0)
  } else if (remarks.pos().len() > 1) {
    // несколько примечаний нумеруют по порядку арабскими цифрами (6.12.3)
    "Примечания"
    set text(tracking: 0pt)

    parbreak()

  set enum(numbering: "1")

    enum(..remarks.pos())
  }
}

// примеры (6.14), оформляют аналогично 16.2
#let example(..examples) = {
  set text(
    size: 0.9em,
    style: "italic",
    weight: "bold",
  ) // примеры выделяют полужирным курсивом, уменьшенным размером шрифта (6.14.2)

  set enum(numbering: "1")

  if (examples.pos().len() == 1) {
    "Пример – "
    examples.at(0)
  } else if (examples.pos().len() > 1) {
    "Примеры"
    parbreak()

    enum(..examples.pos())
  }
}