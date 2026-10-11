/// Главный модуль шаблона МФТИ. Экспортирует `mipt-diploma`.

#import "title.typ": _title-page

/// Главная функция-шаблон для выпускной квалификационной работы МФТИ.
///
/// Применяется как `show`-правило в самом начале документа.
/// Задаёт форматирование всего документа согласно требованиям МФТИ/ГОСТ
/// и автоматически генерирует титульную страницу.
///
/// == Пример минимального использования
///
/// ```typst
/// #import "@preview/mipt-diploma:0.1.0": *
///
/// #show: mipt-diploma.with(
///   title: "Разработка планировщика задач реального времени",
///   author: "Иванов Иван Иванович",
///   group: "Б01-001",
///   advisor: (name: "Петров П.П.", degree: "к.ф.-м.н., доцент"),
/// )
///
/// #annotation(title-ru: "...", author-ru: "...", body-ru: [...])
///
/// #outline(title: "Содержание")
///
/// #unnumbered[Список сокращений]
/// ...
/// ```
///
/// == Параметры
///
/// - title (str): Полное название ВКР
/// - author (str): ФИО студента в именительном падеже
/// - group (str): Номер учебной группы, например `"Б01-001"`
/// - thesis-type (str): Тип работы — `"bachelor"`, `"master"` или `"specialist"`
/// - advisor (dictionary): Научный руководитель. Поля `name` (str) и
///   опциональное `degree` (str) — учёная степень и должность.
/// - consultant (dictionary, none): Консультант, аналогично `advisor` или `none`
/// - ministry (str): Полное название министерства
/// - university (str): Полное официальное название университета
/// - school (str, none): Название физтех-школы или факультета
/// - department (str, none): Название кафедры
/// - sub-department (str, none): Название отдела или лаборатории
/// - city (str): Город защиты. По умолчанию `"Москва"`.
/// - year (int): Год защиты. По умолчанию 2026.
/// - running-title (str, none): Текст колонтитула. Если `none` — используется `title`.
/// - logo (str, none): Путь к файлу логотипа для титульной страницы.
/// - font (str): Семейство шрифта. По умолчанию `"New Computer Modern"`.
/// - body (content): Содержимое документа.
/// -> content
#let mipt-diploma(
  title: "Название выпускной квалификационной работы",
  author: "Фамилия Имя Отчество",
  group: "Б00-000",
  thesis-type: "bachelor",
  advisor: (name: "Фамилия И.О.", degree: none),
  consultant: none,
  ministry: "Министерство науки и высшего образования Российской Федерации",
  university: "Московский физико-технический институт (национальный исследовательский университет)",
  school: none,
  department: none,
  sub-department: none,
  city: "Москва",
  year: 2026,
  running-title: none,
  logo: none,
  font: "New Computer Modern",
  body,
) = {
  let header-title = if running-title != none { running-title } else { title }

  // ── Параметры страницы ────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    header-ascent: 40%,
    footer-descent: 40%,
    header: context {
      if counter(page).get().first() > 1 [
        #set text(size: 10pt)
        #set par(first-line-indent: 0pt)
        #v(0.4em)
        #header-title
        #v(-0.6em)
        #line(length: 100%, stroke: 0.4pt)
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 {
        align(center, text(size: 10pt, counter(page).display("1")))
      }
    },
    numbering: "1",
  )

  // ── Шрифт и язык ──────────────────────────────────────────────────────
  set text(
    font: font,
    size: 12pt,
    lang: "ru",
    region: "RU",
    hyphenate: true,
  )

  // ── Абзац: полуторный интервал, красная строка ────────────────────────
  set par(
    leading: 1.0em,
    spacing: 1.0em,
    first-line-indent: 1.0cm,
    justify: true,
  )

  // ── Нумерация заголовков ──────────────────────────────────────────────
  set heading(numbering: "1.1.1")
  // Уровень 4 — run-in параграф: без нумерации и без вхождения в оглавление
  show heading.where(level: 4): set heading(numbering: none, outlined: false)

  // ── Стили заголовков ──────────────────────────────────────────────────
  show heading: it => context {
    if it.level == 4 {
      [
        #v(2.0em)
        #text(size: 12pt, weight: "bold", it.body + ".")
        #h(0.75em)
      ]
    } else {
    let has-num = it.numbering != none
    let num-text = if has-num {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    } else { none }

    let (sz, above-sp, below-sp) = if it.level == 1 {
      (14pt, 2.0em, 2.0em)
    } else if it.level == 2 {
      (12pt, 2.0em, 2.0em)
    } else {
      (12pt, 2.0em, 2.0em)
    }

    // Для ненумерованных заголовков 1-го уровня уменьшаем нижний интервал
    let real-below = if it.level == 1 and it.numbering == none {
      1.0em
    } else {
      below-sp
    }

    // Разрыв страницы перед заголовком 1-го уровня
    if it.level == 1 and has-num { pagebreak(weak: true) }

    block(
      above: above-sp, below: real-below, width: 100%,
      par(first-line-indent: 0pt, justify: false,
        text(size: sz, weight: "bold",
          if has-num {
            num-text + h(0.75em) + it.body
          } else {
            it.body
          }
        )
      )
    )
    }
  }

  // ── Оглавление ────────────────────────────────────────────────────────
  set outline(indent: auto)
  show outline.entry: set outline.entry(fill: repeat[.])
  // Заголовки 1-го уровня — жирные, без точек, номер страницы справа
  show outline.entry.where(level: 1): it => {
    v(1.3em)
    strong(it.body() + h(1fr) + it.page())
  }
  show outline: it => {
    set par(first-line-indent: 0pt, leading: 1.0em, spacing: 1.3em)
    set text(size: 12pt)
    it
  }

  // ── Подписи к рисункам и таблицам ────────────────────────────────────
  set figure(placement: none)
  show figure.caption: it => {
    set text(size: 12pt)
    set par(first-line-indent: 0pt, justify: false)
    align(center, it)
  }

  // ── Списки ───────────────────────────────────────────────────────────
  set list(marker: ([•], [–], [·]), indent: 0.5cm)
  set enum(numbering: "1.", indent: 0.5cm)
  show list: it => block(above: 2.0em, below: 2.0em, it)
  show enum: it => block(above: 2.0em, below: 2.0em, it)

  // ── Ссылки — чёрные ───────────────────────────────────────────────────
  show link: set text(fill: black)
  show ref: set text(fill: black)

  // ── Программный код ───────────────────────────────────────────────────
  set raw(tab-size: 4)
  show raw.where(block: true): it => block(
    width: 100%,
    inset: (x: 1em, y: 0.75em),
    radius: 3pt,
    text(size: 10pt, it),
  )

  // ── Титульная страница ─────────────────────────────────────────────────
  _title-page(
    title: title,
    author: author,
    group: group,
    thesis-type: thesis-type,
    advisor: advisor,
    consultant: consultant,
    ministry: ministry,
    university: university,
    school: school,
    department: department,
    sub-department: sub-department,
    city: city,
    year: year,
    logo: logo,
  )

  // ── Основной текст (начинается со страницы 2) ─────────────────────────
  body
}
