#import "lib/index.typ": (
  report_abbreviations_page, report_bibliography_page,
  report_equation_numbering, report_equation_rules, report_figure_numbering,
  report_heading_rules, report_labels, report_outline_page, report_page,
  report_table_numbering, report_title_page,
)
#import "../lib/lib.typ": code_long_form, full_document_code
#import "../lib/theme.typ": bibliography_style


#let report_content(
  thesis: none,
  bibliography_sources: none,
  bibliography_full: false,
  bibliography_style: bibliography_style,
  body,
) = [
  #show heading: report_heading_rules
  #show figure.where(kind: image): set figure(
    numbering: report_figure_numbering,
  )
  #show figure.where(kind: table): set figure(numbering: report_table_numbering)
  #set math.equation(numbering: report_equation_numbering)
  #show math.equation.where(block: true): report_equation_rules

  #report_title_page(
    topic: thesis.topic,
    city: thesis.document.city,
    year: thesis.document.year,
  )

  #report_outline_page(
    document_name: code_long_form(code: thesis.document.codes.report),
    topic: thesis.topic,
    group: thesis.student.group,
    document_code: full_document_code(code: thesis.document.codes.report),
    implemented_by: thesis.student.initials,
    reviewed_by: thesis.advisor.initials,
    norm_controller: thesis.consultant.initials,
    approved_by: thesis.document.approved_by,
  )

  #report_abbreviations_page(
    document_code: full_document_code(code: thesis.document.codes.report),
    abbreviations: thesis.report.abbreviations,
  )

  #report_page(document_code: full_document_code(
    code: thesis.document.codes.report,
  ))[
    #body
  ]

  #if bibliography_sources != none {
    report_bibliography_page(
      bibliography_sources,
      document_code: full_document_code(code: thesis.document.codes.report),
      style: bibliography_style,
      full: bibliography_full,
    )
  }
]
