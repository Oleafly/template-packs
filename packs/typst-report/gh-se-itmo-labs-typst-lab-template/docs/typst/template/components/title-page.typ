// Композиция титульного листа. Данные берутся из config.typ, а размеры —
// из theme.typ. Значения v(...) задают вертикальные расстояния между блоками.
#let title-page(config: (:), theme: (:)) = {
  set text(font: config.font_family, size: theme.body-size, lang: "ru")
  set par(justify: false, first-line-indent: 0pt)

  align(center)[
    #text(size: theme.institution-size)[#config.institution]
  ]

  v(51mm)

  align(center)[
    #text(size: theme.title-size, weight: "bold")[
      #config.work_type №#config.lab_number по дисциплине \
      #config.discipline
      #if config.topic != none {
        linebreak()
        [#config.topic]
      }
    ]
  ]

  v(42mm)

  align(right)[
    #box(width: 96mm)[
      #grid(
        columns: (24mm, 1fr),
        column-gutter: 3mm,
        row-gutter: 1.5mm,
        align: left + top,
        [Выполнил:], [#config.student],
        [Проверил:], [#config.reviewer],
        [#config.group_label:], [#config.group],
      )
    ]
  ]

  v(1fr)

  align(center)[
    #config.city #config.year г.
  ]
}
