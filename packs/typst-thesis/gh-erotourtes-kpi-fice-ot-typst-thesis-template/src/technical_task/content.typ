#import "lib/index.typ": (
  technical_task_labels, technical_task_outline_page, technical_task_page,
  technical_task_title_page,
)
#import "../lib/lib.typ": code_long_form, full_document_code
#import "../lib/heading.typ": heading_config

#let technical_task_content(
  body,
  thesis: none,
) = {
  show heading: it => [
    #heading_config(level: it.level, it: it, number_level_one: true)
    #metadata((
      level: it.level,
      numbering: none,
      body: it.body,
    )) #technical_task_labels.header
  ]

  technical_task_title_page(
    topic: thesis.topic,
    city: thesis.document.city,
    year: thesis.document.year,
  )

  technical_task_outline_page(
    document_name: code_long_form(code: thesis.document.codes.technical_task),
    topic: thesis.topic,
    group: thesis.student.group,
    document_code: full_document_code(
      code: thesis.document.codes.technical_task,
    ),
    implemented_by: thesis.student.initials,
    reviewed_by: thesis.advisor.initials,
    norm_controller: thesis.consultant.initials,
    approved_by: thesis.document.approved_by,
  )

  technical_task_page(document_code: full_document_code(
    code: thesis.document.codes.technical_task,
  ))[
    #body
  ]
}
