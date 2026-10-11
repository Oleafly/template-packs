// ══════════════════════════════════════════════
// Функции для рисунков, таблиц и листингов
// ══════════════════════════════════════════════
#let fig(body, caption: none) = figure(
  body,
  kind: image,
  supplement: [Рисунок],
  caption: caption,
)

#let tbl(body, caption: none) = figure(
  body,
  kind: table,
  supplement: [Таблица],
  caption: caption,
)

#let listing(body, caption: none) = figure(
  body,
  kind: raw,
  supplement: [Листинг],
  caption: caption,
)

// ══════════════════════════════════════════════
// Отступ между секциями
// ══════════════════════════════════════════════
#let b(height: 1em) = v(height)

// ══════════════════════════════════════════════
// Оформление документа
// ══════════════════════════════════════════════
#let conf(
  doc,
  university: "Санкт-Петербургский политехнический университет Петра Великого",
  institute: "Институт компьютерных наук и кибербезопасности",
  school: "Высшая школа программной инженерии",
  work-number: "",
  title: [],
  discipline: [],
  student: [],
  student-group: "",
  supervisor-position: [],
  supervisor: [],
  city: "Санкт-Петербург",
  year: "",
) = {
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru",
    hyphenate: false,
  )
  set par(
    leading: 1.5 * 0.65em,
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
  )
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 3.5cm, right: 1cm),
    numbering: "1",
    number-align: right + bottom,
    footer-descent: 1cm,
  )
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")

  set figure(supplement: [Рисунок])

  show figure.caption: it => {
    set text(size: 14pt)
    set par(first-line-indent: 0em)
    let content = [*#it.supplement #context it.counter.display(it.numbering)* --- #it.body]
    if it.kind == table {
      v(1em)
      align(left, content)
    } else {
      content
      v(1em)
    }
  }
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): it => {
    it
    v(1em)
  }

  // ══════════════════════════════════════════════
  // Переопределение заголовков
  // ══════════════════════════════════════════════
  show heading.where(level: 1): it => {
    v(2em, weak: true)
    set text(size: 14pt, weight: "bold")
    set align(center)
    upper(it)
    v(1em)
  }
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    it
    v(0.2cm)
  }
  show heading.where(level: 3): it => {
    set text(size: 14pt, weight: "bold")
    it
    v(0.2cm)
  }

  show link: underline

  show raw.where(block: true): it => {
    set text(font: "New Computer Modern Mono", size: 12pt)
    set par(leading: 0.55em, first-line-indent: 0cm)
    v(1em - 10pt)
    block(
      width: 100%,
      // fill: luma(245),
      inset: 10pt,
      radius: 3pt,
      // stroke: 0.5pt + luma(200),
      it,
    )
  }

  // ══════════════════════════════════════════════
  // ТИТУЛЬНЫЙ ЛИСТ
  // ══════════════════════════════════════════════
  page(numbering: none, margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm))[
    #set par(first-line-indent: 0cm, leading: 0.65em)
    #set align(center)

    #text(size: 14pt)[
      *#university\
      #institute\
      #school*
    ]

    #v(3fr)

    #text(size: 16pt, weight: "bold")[
      #upper[Лабораторная работа №#work-number]
    ]
    #v(2em)
    #text(size: 14pt)[
      *#title* \
      по дисциплине "#discipline"
    ]

    #v(2fr)

    #set align(left)
    #pad(left: 0cm)[
      Выполнил\
      студент гр. #student-group #h(1fr) #student
      #v(0.1cm)
      #v(0.4cm)
      Руководитель\
      #supervisor-position #h(1fr) #supervisor
      #v(0.1cm)
    ]

    #v(1fr)

    #set align(right)
    #text(size: 14pt)[
      "\_\_\_" \_\_\_\_\_\_\_\_\_ #year г.
    ]

    #v(2fr)

    #set align(center)
    #text(size: 14pt)[
      #city\
      #year
    ]
  ]

  set page(numbering: "1")
  counter(page).update(2)

  doc
}
