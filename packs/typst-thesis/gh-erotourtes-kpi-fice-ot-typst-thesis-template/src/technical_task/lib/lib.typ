#import "../../lib/footer.typ": footer_f2a
#import "../../lib/outline.typ": outline_page
#import "../../lib/page.typ": bordered_page, cover_page
#import "../../lib/lib.typ": page_margin

#let technical_task_labels = (
  page_start: <technical_task_start_page>,
  page_end: <technical_task_end_page>,
  header: <technical_task_header>,
)

#let technical_task_outline_page(
  document_name: none,
  topic: none,
  group: none,
  document_code: none,
  implemented_by: none,
  reviewed_by: none,
  norm_controller: none,
  approved_by: none,
) = {
  outline_page(
    document_name: document_name,
    topic: topic,
    group: group,
    document_code: document_code,
    implemented_by: implemented_by,
    reviewed_by: reviewed_by,
    norm_controller: norm_controller,
    approved_by: approved_by,

    start_label: technical_task_labels.page_start,
    end_label: technical_task_labels.page_end,
    header_label: technical_task_labels.header,
    metadata_entries: true,
  )
}

#let technical_task_page(body, document_code: none) = [
  #bordered_page(
    footer: footer_f2a(document_code: document_code),
  )[
    #body
    #metadata("end") #technical_task_labels.page_end
  ]
]

#let technical_task_title_page(
  topic: none,
  city: none,
  year: none,
) = {
  cover_page(right: page_margin.right)[
    #set par(justify: false)

    #v(68mm)
    #align(center)[
      #text(
        weight: "bold",
        size: 18pt,
      )[ТЕХНІЧНЕ ЗАВДАННЯ\ ДО ДИПЛОМНОГО ПРОЄКТУ]
    ]

    #v(5mm)
    #align(center)[
      на тему: "#underline[#emph(topic)]"
    ]

    #v(1fr)
    #align(center)[#city -- #year р.]
  ]
}
