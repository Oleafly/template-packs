/// Внутренний модуль: компонент титульной страницы.
/// Не предназначен для прямого использования — вызывается из `template.typ`.

#let _thesis-type-labels = (
  bachelor:   "Выпускная квалификационная работа бакалавра",
  master:     "Выпускная квалификационная работа магистра",
  specialist: "Дипломная работа специалиста",
)

/// Возвращает content титульной страницы.
/// Колонтитулы на странице 1 подавляются через счётчик страниц в template.typ.
///
/// - title (str): Название ВКР
/// - author (str): ФИО студента
/// - group (str): Учебная группа
/// - thesis-type (str): `"bachelor"` | `"master"` | `"specialist"`
/// - advisor (dictionary): `(name: str, degree: str or none)`
/// - consultant (dictionary, none): Аналогично `advisor` или `none`
/// - ministry (str): Название министерства
/// - university (str): Название университета
/// - school (str, none): Физтех-школа / факультет
/// - department (str, none): Кафедра
/// - sub-department (str, none): Отдел / лаборатория
/// - city (str): Город
/// - year (int): Год
/// - logo (str, none): Путь к файлу логотипа
/// -> content
#let _title-page(
  title: "",
  author: "",
  group: "",
  thesis-type: "bachelor",
  advisor: (name: "", degree: none),
  consultant: none,
  ministry: "",
  university: "",
  school: none,
  department: none,
  sub-department: none,
  city: "Москва",
  year: 2026,
  logo: none,
) = {
  set par(first-line-indent: 0pt, justify: false)

  // ── Министерство и университет (жирные, по центру) ─────────────────
  align(center, {
    set text(weight: "bold")
    ministry
    linebreak()
    university
  })

  v(1cm)

  // ── Школа / кафедра / отдел (обычный вес, по центру) ───────────────
  align(center, {
    if school != none {
      school
      linebreak()
    }
    if department != none {
      department
      linebreak()
    }
    if sub-department != none {
      sub-department
    }
  })

  v(3em)

  // ── Тип работы (обычный вес, по центру) ────────────────────────────
  align(center, _thesis-type-labels.at(thesis-type, default: thesis-type))

  v(1fr)

  // ── Название (крупный, обычный вес, по центру) ─────────────────────
  align(center, text(size: 20pt, title))

  v(1fr)

  // ── Блок исполнителей (по правому краю) ────────────────────────────
  align(right, {
    set text(size: 12pt)

    strong[Автор:]
    linebreak()
    [Студент группы ]
    group
    linebreak()
    author

    v(1.5em)
    strong[Научный руководитель:]
    linebreak()
    if "degree" in advisor and advisor.degree != none {
      advisor.degree
      linebreak()
    }
    advisor.name

    if consultant != none {
      v(1.5em)
      strong[Научный консультант:]
      linebreak()
      if "degree" in consultant and consultant.degree != none {
        consultant.degree
        linebreak()
      }
      consultant.name
    }
  })

  v(7em)

  // ── Логотип (если задан) и город/год ───────────────────────────────
  align(center, {
    if logo != none {
      image(logo, width: 100pt)
      linebreak()
    }
    [г. #city, #str(year)]
  })

  pagebreak()
}
