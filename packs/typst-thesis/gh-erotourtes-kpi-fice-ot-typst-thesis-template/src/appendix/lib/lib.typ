#import "../../lib/footer.typ": footer_f2, footer_f2a
#import "../../lib/lib.typ": (
  code_long_form, full_document_code, page_margin, page_range_sheet_count,
)
#import "../../lib/page.typ": bordered_page, cover_page

#let appendix_title_page(
  number: none,
  letter: none,
  topic: none,
  code: none,
  city: none,
  year: none,
  sheet_count: none,
  title_label: none,
) = {
  cover_page(right: page_margin.right)[
    #if title_label != none [
      #metadata("title") #title_label
    ]
    #align(center)[
      #v(30mm)
      #text(size: 18pt, weight: "bold")[ДОДАТОК #letter]

      #v(10mm)
      #text(size: 18pt)[#topic]

      #v(40mm)
      #text(size: 18pt)[#code_long_form(code: code)]
      #v(3mm)
      #text(size: 18pt)[#full_document_code(code: code)]

      #v(53mm)
      #text(size: 16pt)[Аркушів #sheet_count]

      #v(1fr)
      #text(size: 14pt, weight: "bold")[#city -- #year р.]
    ]
  ]
}

#let appendix_page(
  body,
  meta: none,
  topic: none,
  group: none,
  code: none,
  implemented_by: none,
  reviewed_by: none,
  norm_controller: none,
  approved_by: none,
) = context {
  counter(page).update(1)

  let document_code = full_document_code(code: code)
  let first_footer = footer_f2(
    document_name: code_long_form(code: code),
    topic: topic,
    group: group,
    document_code: document_code,
    sheet_number: [1],
    sheet_count: page_range_sheet_count(
      start_label: meta.start_label,
      end_label: meta.end_label,
    ),
    implemented_by: implemented_by,
    reviewed_by: reviewed_by,
    norm_controller: norm_controller,
    approved_by: approved_by,
  )

  bordered_page(
    footer_space: measure(first_footer).height,
    footer: context {
      let page_number = counter(page).get().first()
      if page_number == 1 {
        first_footer
      } else {
        footer_f2a(document_code: document_code)
      }
    },
  )[
    #metadata("start") #meta.start_label
    #body
    #metadata("end") #meta.end_label
  ]
}
