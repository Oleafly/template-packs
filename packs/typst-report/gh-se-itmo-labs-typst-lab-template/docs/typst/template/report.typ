#import "theme.typ": default-theme
#import "components/title-page.typ": title-page
#import "components/contents.typ": contents-page

// Главный компонент документа. Он применяет тему, создаёт служебные страницы
// и размещает переданные разделы в фиксированном порядке.
#let lab-report(
  config: (:),
  theme: default-theme,
  task: [],
  work: [],
  conclusion: [],
  sources: [],
) = {
  // Метаданные записываются внутрь итогового PDF.
  set document(
    title: config.work_type + " №" + str(config.lab_number) + " - " + config.discipline,
    author: config.student,
  )

  // Единые параметры всех страниц отчёта.
  set page(
    paper: "a4",
    margin: theme.page-margin,
    numbering: if config.show_page_numbers { "1" } else { none },
    number-align: center + bottom,
  )

  // Базовая типографика. font_family пользователь выбирает в config.typ.
  set text(
    font: config.font_family,
    size: theme.body-size,
    lang: "ru",
    fill: black,
  )

  // Общие правила обычных абзацев: выравнивание, красная строка,
  // межстрочный интервал и дополнительное пространство между абзацами.
  set par(
    justify: true,
    first-line-indent: theme.paragraph-indent,
    leading: theme.paragraph-leading,
    spacing: theme.paragraph-spacing,
  )

  // Заголовки не нумеруются, но автоматически попадают в содержание.
  set heading(numbering: none)

  set figure(gap: 8pt)
  show figure.caption: set text(size: 11pt)

  // H1 — заголовок основного раздела, по центру.
  show heading.where(level: 1): it => block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    inset: (top: 18pt, bottom: 14pt),
    breakable: false,
  )[
    #set par(first-line-indent: 0pt, justify: false)
    #align(center)[
      #text(size: theme.heading-1-size, weight: "bold")[#it.body]
    ]
  ]

  // H2 — крупный подраздел, выровнен влево.
  show heading.where(level: 2): it => block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    inset: (top: 14pt, bottom: 10pt),
    breakable: false,
  )[
    #set par(first-line-indent: 0pt, justify: false)
    #text(size: theme.heading-2-size, weight: "bold")[#it.body]
  ]

  // H3 — вложенный подраздел с меньшими отступами.
  show heading.where(level: 3): it => block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    inset: (top: 10pt, bottom: 7pt),
    breakable: false,
  )[
    #set par(first-line-indent: 0pt, justify: false)
    #text(size: theme.heading-3-size, weight: "bold")[#it.body]
  ]

  // Служебные страницы и основные разделы всегда начинаются с новой страницы.
  title-page(config: config, theme: theme)

  pagebreak()
  contents-page(config: config)

  pagebreak()
  heading(level: 1)[#config.labels.task]
  task

  pagebreak()
  heading(level: 1)[#config.labels.work]
  work

  pagebreak()
  heading(level: 1)[#config.labels.conclusion]
  conclusion

  pagebreak()
  heading(level: 1)[#config.labels.sources]
  sources
}
