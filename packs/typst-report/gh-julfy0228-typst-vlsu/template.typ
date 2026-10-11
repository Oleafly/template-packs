// Основной шаблон документа
#import "titlepage.typ": titlepage

#let struct(body) = {
  heading(body, outlined: false, numbering: none, )
}

#let template(
  title: content,
  discipline: content,
  theme: content,
  students: array,
  teacher: dictionary,
  numbering-pages: false,
  numbering-headings: false,
  show-titlepage: true,
  doc
) = {
  // Страница
  set page(
    paper: "a4",
    margin: (
      left: 30mm,
      right: 15mm,
      top: 20mm,
      bottom: 20mm,
    ),
    footer: context {
      let page_num = counter(page).get().first()
      if page_num == 1 {
        set text(size: 12pt)
        align(center)[Владимир, #datetime.today().year()]
      } else if (numbering-pages) {
        align(center)[#counter(page).display()]
      }
    }
  )

  // Текст
  set text(lang: "ru", font: "Times New Roman", size: 14pt)
  show raw: set text(font: "Courier New", size: 11pt)

  // Заголовки
  show heading: set text(size: 14pt, weight: "bold")
  set heading(numbering:
    if numbering-headings {
      "1.1"
    }
  )

  // Заголовки первого уровня
  show heading.where(level: 1): set block(above: 2em, below: 2em)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): upper
  show heading.where(level: 1): it => {
      let heading-body = lower(repr(it.body))
      if not heading-body.contains("abstract") and not heading-body.contains("аннотация") {
        pagebreak(weak: true)
      }
      it
  }

  // Заголовки второго уровня
  show heading.where(level: 2): it => {
      pad(it, left: 1.25cm)
  }
  show heading.where(level: 2): set align(left)

  // Заголовки третьего уровня
  show heading.where(level: 3): set align(left)

  // Маркированные списки
  set list(
    indent: 1.5em,
    body-indent: 0.5em,
    spacing: 1em,
  )

  // Нумерованные списки
  set enum(
    numbering: "1)",
    indent: 1.5em,
    body-indent: 0.5em,
    spacing: 1em,
  )

  // Титульник
  if show-titlepage {
    show: titlepage.with(
      title: title,
      discipline: discipline,
      theme: theme,
      students: students,
      teacher: teacher
    )
  }

  // Абзацы
  set par(
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
    leading: 1.5em - 0.75em,
    spacing: 1.5em,
  )

  // Листинги
  show figure.where(kind: raw): set block(breakable: true)

  // Таблицы — ГОСТ 7.32-2017, п. 6.6
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }
  show figure.where(kind: table): set block(breakable: true)
  show figure.caption.where(kind: table): set align(left)
  show table.cell: set align(left)

  // Позже проверить с приложениями
  // Содержание (ГОСТ 7.32-2017, п. 6.10)
  set outline(indent: 1.25cm, depth: 3)
  show outline: set block(below: 1.25cm / 2)
  // Отображение приложений в содержании:
  // — уровень 1: «Приложение А Название»
  // — уровень 2+: «А.1 Название» (без слова «Приложение»)
  show outline.entry: it => {
    show linebreak: [ ]
    if state("appendixes", false).at(it.element.location()) {
      let body = if it.element.level == 1 {
        [Приложение #it.prefix(). #it.element.body]
      } else {
        [#it.prefix() #it.element.body]
      }
      link(it.element.location(), it.indented(
        none,
        body
          + sym.space
          + box(width: 1fr, it.fill)
          + sym.space
          + sym.wj
          + it.page(),
      ))
    } else {
      it
    }
  }
  show outline.entry: it => {
    if it.level == 1 {
      [#upper(it)]
    } else {
      it
    }
  }

  doc
}
