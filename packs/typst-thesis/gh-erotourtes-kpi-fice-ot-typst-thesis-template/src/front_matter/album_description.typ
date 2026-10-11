#import "../lib/lib.typ": (
  code_long_form, full_document_code, page_range_sheet_count,
)
#import "../lib/page.typ": standard_page
#import "../technical_task/lib/index.typ": technical_task_labels
#import "../report/lib/index.typ": report_labels
#import "../appendix/content.typ": (
  appendix_d1_meta, appendix_d2_meta, appendix_d3_meta, appendix_d4_meta,
)

#let header_cell(body) = table.cell(align: center + horizon)[
  #{
    set par(leading: 0.65em)
    body
  }
]

#let first_table_row(
  topic: none,
  code: none,
  sheets: none,
  target: none,
  format: [A4],
) = {
  let linked(body) = if target == none { body } else { link(target)[#body] }

  (
    [],
    [#align(center)[#text(weight: "bold")[#format]]],
    [#text(weight: "bold")[#linked(code)]],
    [#linked(topic)],
    [#align(center)[#sheets]],
    [],
    [],
  )
}

#let first_table_empty_row = (
  [],
  [],
  [],
  [],
  [],
  [],
  [],
)

#let first_table_rows(entries: none) = {
  let generated = ()
  generated += first_table_empty_row
  generated += first_table_empty_row
  for (i, entry) in entries.enumerate() {
    generated += first_table_row(
      topic: entry.topic,
      code: entry.code,
      sheets: entry.sheets,
      target: entry.target,
    )
    let repeat = if (i < 2) { 4 } else { 5 }
    for i in range(1, repeat + 1) {
      generated += first_table_empty_row
    }
  }
  generated
}

#let album_description_page(
  topic: none,
  group: none,
  codes: none,
  implemented_by: none,
  examined_by: none,
) = {
  let first_table_entries = (
    (
      topic: [#topic\ #code_long_form(code: codes.technical_task)],
      code: full_document_code(code: codes.technical_task),
      target: technical_task_labels.page_start,
      sheets: page_range_sheet_count(
        start_label: technical_task_labels.page_start,
        end_label: technical_task_labels.page_end,
      ),
    ),
    (
      topic: [#topic\ #code_long_form(code: codes.report)],
      code: full_document_code(code: codes.report),
      target: report_labels.page_start,
      sheets: page_range_sheet_count(
        start_label: report_labels.page_start,
        end_label: report_labels.page_end,
      ),
    ),
    (
      topic: [#topic\ #code_long_form(code: codes.d1)],
      code: full_document_code(code: codes.d1),
      target: appendix_d1_meta.title_label,
      sheets: page_range_sheet_count(
        start_label: appendix_d1_meta.start_label,
        end_label: appendix_d1_meta.end_label,
      ),
    ),
    (
      topic: [#topic\ #code_long_form(code: codes.d2)],
      code: full_document_code(code: codes.d2),
      target: appendix_d2_meta.title_label,
      sheets: page_range_sheet_count(
        start_label: appendix_d2_meta.start_label,
        end_label: appendix_d2_meta.end_label,
      ),
    ),
    (
      topic: [#topic\ #code_long_form(code: codes.d3)],
      code: full_document_code(code: codes.d3),
      target: appendix_d3_meta.title_label,
      sheets: page_range_sheet_count(
        start_label: appendix_d3_meta.start_label,
        end_label: appendix_d3_meta.end_label,
      ),
    ),
    (
      topic: [#topic\ #code_long_form(code: codes.d4)],
      code: full_document_code(code: codes.d4),
      target: appendix_d4_meta.title_label,
      sheets: page_range_sheet_count(
        start_label: appendix_d4_meta.start_label,
        end_label: appendix_d4_meta.end_label,
      ),
    ),
  )

  standard_page[
    #set text(size: 11.5pt, hyphenate: false)
    #set par(leading: 0.6em, first-line-indent: 0pt)
    #table(
      columns: (12mm, 10mm, 47mm, 60mm, 12mm, 14mm, 30mm),
      rows: (
        25mm,
        ..range(30).map(_ => 5.3mm),
      ),
      stroke: 0.45pt,
      inset: (x: 1.5mm, y: 1.3mm),
      align: top + left,

      header_cell[#rotate(-90deg)[справки]],
      header_cell[#rotate(-90deg)[Формат]],
      header_cell[#text(weight: "bold")[Значення]],
      header_cell[#text(weight: "bold")[Найменування]],
      header_cell[#rotate(-90deg)[Кіл.\ листів]],
      header_cell[#rotate(-90deg)[№\ екземплярів]],
      header_cell[#text(weight: "bold")[Додаток]],

      [], [], [], [Документація загальна\ Знову розроблена], [], [], [],
      ..first_table_rows(entries: first_table_entries),
    )
    #v(-4.9mm)
    #table(
      columns: (12mm, 10mm, 18mm, 15mm, 10mm, 70mm, 5mm, 5mm, 5mm, 17mm, 1fr),
      rows: (5mm, 5mm, 5mm, 5mm, 5mm, 16mm),
      stroke: 1.5pt,
      inset: (x: 1.2mm, y: 0.6mm),
      align: horizon + left,

      [], [], [], [], [],
      table.cell(rowspan: 3, colspan: 6, align: center)[#text(
        size: 17pt,
        weight: "bold",
        style: "italic",
      )[#full_document_code(code: codes.album_description)]],
      [], [], [], [], [],
      [Зм.], [Лист], [#text(size: 10.5pt)[№ докум.]], [Підпис], [Дата],

      table.cell(colspan: 2)[#text(weight: "bold")[Розроб.]],
      [#implemented_by],
      [],
      [],
      table.cell(
        rowspan: 3,
        align: center + horizon,
        inset: 7mm,
      )[#text(style: "italic")[#topic\ #code_long_form(
          code: codes.album_description,
        )]],
      table.cell(colspan: 3)[Літ.], [Аркуш], [Аркушів],
      table.cell(colspan: 2)[#text(weight: "bold")[Перевір.]],
      [#examined_by],
      [], [], [], [], [], [1], [1],

      table.cell(colspan: 2)[],
      [], [], [],
      table.cell(colspan: 5, align: center)[#text(
        weight: "bold",
        style: "italic",
      )[НТУУ "КПІ" ФІОТ\ #group]],
    )
  ]
}
