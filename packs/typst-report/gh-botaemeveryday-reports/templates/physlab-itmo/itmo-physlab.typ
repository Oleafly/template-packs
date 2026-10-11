// ============================================================
// Шаблон отчёта по лабораторной работе
// Физический факультет, Физико-технический мегафакультет
// Университет ИТМО
// ============================================================

#let physlab-report(
  lab-number: "",
  lab-title: "Название работы",
  group: "",
  student: "",
  teacher: "",
  admission-date: "",
  completion-date: "",
  acceptance-date: "",
  font: "STIXGeneral",      // основной шрифт текста (в шаблоне Word — Cambria)
  banner-font: "PT Sans",   // шапка с названием университета (Word: PT Sans 11pt bold)
  form-font: "Arial",       // поля «Группа / Студент / Преподаватель» (Word: Arial 12pt)
  font-size: 12pt,
  body,
) = {
  // --- Параметры страницы
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 1.5cm),
    numbering: "1",
    number-align: left,
  )

  set text(font: font, size: font-size, lang: "ru")
  set par(justify: true, leading: 0.7em)

  // --- Заголовки разделов (1-й уровень) — нумерованные жирные пункты
  set heading(numbering: "1.")
  show heading.where(level: 1): it => {
    v(0.5em)
    block[
      #text(weight: "bold", size: font-size)[#counter(heading).display() #it.body:]
    ]
    v(0.2em)
  }

  // --- Верхняя «шапка» с названием университета и логотипом ----------------
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align(center + horizon)[
      #set text(font: banner-font, weight: "bold", size: 11pt)
      Университет ИТМО \
      Физико-технический мегафакультет \
      Физический факультет
    ],
    align(right + horizon)[#image("itmo-logo.png", height: 1.2cm)],
  )

  v(0.8em)
  line(length: 100%, stroke: 0.4pt)
  v(0.5em)

  // --- Поля «Группа / К работе допущен», «Студент / Работа выполнена» ----
  {
    set text(font: form-font, size: 12pt)
    let field(label, value) = {
      box[#label #h(0.5em) #box(width: 1fr, stroke: (bottom: 0.4pt), inset: (bottom: 2pt))[#align(center)[#value]]]
    }

    grid(
      columns: (1fr, 1fr),
      column-gutter: 1.5em,
      row-gutter: 0.9em,
      field[Группа][#group],   field[К работе допущен][#admission-date],
      field[Студент][#student], field[Работа выполнена][#completion-date],
      field[Преподаватель][#teacher], field[Отчёт принят][#acceptance-date],
    )
  }

  v(1.2em)

  // --- Заголовок отчёта ----------------------------------------------------
  align(center)[
    #text(size: 20pt, weight: "bold")[
      Рабочий протокол и отчёт по \
      лабораторной работе №#lab-number
    ]
  ]

  v(0.6em)
  line(length: 100%, stroke: 0.4pt)
  v(0.4em)
  align(center)[#text(size: 12pt)[«#lab-title»]]
  v(0.4em)
  line(length: 100%, stroke: 0.4pt)
  v(1em)

  // --- Содержимое отчёта ---------------------------------------------------
  body
}

// ============================================================
// Удобные хелперы для таблицы измерительных приборов
// ============================================================

#let prib-table(..rows) = {
  // --- Шапка
  let header = (
    [*№ п/п*], [*Наименование*], [*Тип прибора*],
    [*Используемый\ диапазон*], [*Погрешность\ прибора*],
  )
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon, left + horizon),
    inset: 8pt,
    stroke: 0.5pt,
    ..header,
    ..rows.pos().flatten(),
  )
}

// --- Одна строка таблицы приборов: #prib-row("1", "Вольтметр", "цифровой", "0–20 В", "0.5%")
#let prib-row(num, name, type, range, error) = (
  [#num], [#name], [#type], [#range], [#error],
)

// ============================================================
// Пустые «прибор-строки» — если нужно сразу несколько пустых строк
// ============================================================
#let empty-prib-rows(n) = {
  range(1, n + 1).map(i => prib-row(str(i), "", "", "", ""))
}
