
#import "lib.typ": page_outline_stroke

#let footer_inner_stroke = 1pt
#let footer_strong_stroke = page_outline_stroke

#let footer_strong_lines(columns: none, rows: none, vlines: (), hlines: ()) = {
  let lines = (
    table.hline(y: 0, stroke: page_outline_stroke),
    table.hline(y: rows, stroke: page_outline_stroke),
    table.vline(x: 0, stroke: page_outline_stroke),
    table.vline(x: columns, stroke: page_outline_stroke),
  )

  for line in vlines {
    lines += (table.vline(..line, stroke: footer_strong_stroke),)
  }

  for line in hlines {
    lines += (table.hline(..line, stroke: footer_strong_stroke),)
  }

  lines
}

#let footer_f2a(
  document_code: none,
) = context {
  [
    #set text(size: 10.5pt)
    #table(
      columns: (7mm, 10mm, 23mm, 15mm, 10mm, 1fr, 10mm),
      rows: (5mm, 5mm, 5mm),
      stroke: footer_inner_stroke,
      inset: (x: 0.8mm, y: 0.4mm),
      align: horizon + center,
      ..footer_strong_lines(
        columns: 7,
        rows: 3,
        vlines: (
          (x: 1),
          (x: 2),
          (x: 3),
          (x: 4),
          (x: 5),
          (x: 6),
        ),
        hlines: (
          (y: 2),
        ),
      ),

      [], [], [], [], [],
      table.cell(rowspan: 3, align: center + horizon)[
        #text(size: 16pt)[#document_code]
      ],
      [#text()[Арк.]],

      [], [], [], [], [],
      table.cell(rowspan: 2)[#counter(page).display()],

      [#text()[Зм.]],
      [#text()[Арк.]],
      [#text()[№ докум.]],
      [#text()[Підпис]],
      [#text()[Дата]],
    )
  ]
}

#let footer_f2(
  document_name: none,
  topic: none,
  group: none,
  document_code: none,
  sheet_number: none,
  sheet_count: none,
  implemented_by: none,
  reviewed_by: none,
  norm_controller: none,
  approved_by: none,
) = [
  #set text(size: 10.5pt)
  #table(
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 1fr, 5mm, 5mm, 5mm, 17mm, 18mm),
    rows: range(8).map(_ => 5mm),
    stroke: footer_inner_stroke,
    inset: (x: 0.8mm, y: 0.4mm),
    align: horizon + center,
    ..footer_strong_lines(
      columns: 11,
      rows: 8,
      vlines: (
        (x: 1),
        (x: 2),
        (x: 3),
        (x: 4),
        (x: 5),
        (x: 6, start: 3),
        (x: 9, start: 3, end: 5),
        (x: 10, start: 3, end: 5),
      ),
      hlines: (
        (y: 2),
        (y: 3),
        (y: 4, start: 6),
        (y: 5, start: 6),
      ),
    ),

    [], [], [], [], [],
    table.cell(colspan: 6, rowspan: 3, align: center + horizon)[
      #text(size: 16pt)[#document_code]
    ],

    [], [], [], [], [],

    [],
    [],
    [#text()[№ докум.]],
    [#text()[Підпис]],
    [#text()[Дата]],

    table.cell(colspan: 2)[#text()[Розробив]],
    [#text(size: 8pt)[#implemented_by]],
    [],
    [],

    table.cell(rowspan: 5, align: center + horizon, inset: 2.5mm)[
      #align(center)[
        #text(weight: "bold")[#topic]
        #v(0.1mm)
        #text()[#document_name]
      ]
    ],

    table.cell(colspan: 3)[
      #text()[Літера]
    ],
    [#text()[Аркуш]],
    [#text()[Аркушів]],

    table.cell(colspan: 2)[#text(size: 9pt)[Перевірив]],
    [#text(size: 7pt)[#reviewed_by]],
    [],
    [],
    [], [], [],
    [#sheet_number],
    [#sheet_count],

    table.cell(colspan: 2)[], [], [], [],
    table.cell(rowspan: 3, colspan: 5, align: center + horizon, inset: 1.5mm)[
      #text()[НТУУ КПІ ім. Ігоря\ Сікорського, ФІОТ, #group]
    ],

    table.cell(colspan: 2)[#text()[Н. Контр.]],
    [#text(size: 8pt)[#norm_controller]],
    [],
    [],

    table.cell(colspan: 2)[#text(size: 9pt)[Затвердив]],
    [#text(size: 8pt)[#approved_by]],
    [],
    [],
  )
]
