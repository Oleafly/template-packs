
#import "../../lib/footer.typ": footer_f2a
#import "../../lib/outline.typ": outline_page
#import "../../lib/page.typ": bordered_page, cover_page, pad_margins
#import "../../lib/lib.typ": body_par_leading, page_margin
#import "../../lib/theme.typ": (
  bibliography_section, bibliography_style, bibliography_title,
)

#let report_labels = (
  header: <report_outline_header>,
  section: <report_section_header>,
  page_start: <report_outline_page_start>,
  page_end: <report_outline_page_end>,
)

#let report_section_counter = counter("report_section")

#let report_heading_title(body) = {
  let title = repr(body)
  if title.starts-with("[") and title.ends-with("]") {
    title.slice(1, -1)
  } else if title.starts-with("sequence([Розділ ") {
    title.split("],").first().slice("sequence([".len())
  } else {
    title
  }
}

#let is_report_section_heading(it) = {
  it.level == 1 and report_heading_title(it.body).starts-with("Розділ ")
}

#let report_section_number(title) = {
  int(title.slice("Розділ ".len()).split(".").first())
}

#let report_section_display_body(title) = {
  let parts = title.split(". ")
  if parts.len() > 1 {
    [#parts.first()\
      #parts.slice(1).join(". ")]
  } else {
    [#title]
  }
}

#let report_section_outline_body(title) = {
  let prefix = "Розділ "
  let parts = title.split(". ")
  if title.starts-with(prefix) and parts.len() > 1 {
    [Розділ #parts.first().slice(prefix.len()) #parts.slice(1).join(". ")]
  } else {
    title
  }
}

#let report_section_heading_render(title, section_number: none) = {
  let display_body = report_section_display_body(upper(title))
  let outline_body = upper(report_section_outline_body(title))
  [
    #if section_number != none {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      counter(heading).update(section_number)
    }
    #colbreak(weak: true)
    #v(pad_margins.top)
    #align(center)[
      #{
        set par(leading: body_par_leading)
        set par(first-line-indent: 0pt, justify: false)
        text(size: 18pt, weight: "bold", hyphenate: false)[#display_body]
      }
    ]
    #metadata((
      level: 1,
      numbering: none,
      body: outline_body,
    )) #report_labels.header #metadata((
      level: 1,
      numbering: none,
      body: title,
    )) #report_labels.section
    #v(1em)
  ]
}

#let report_table_numbering(n) = context {
  let section_number = counter(heading).get().first()
  numbering("1.1", section_number, n)
}

#let report_figure_numbering(n) = context {
  let section_number = counter(heading).get().first()
  numbering("1.1", section_number, n)
}

#let report_equation_numbering(n) = context {
  let section_number = counter(heading).get().first()
  numbering("(1.1)", section_number, n)
}

#let report_equation_rules(it) = {
  if it.numbering == none {
    it
  } else {
    block(width: 100%)[
      #grid(
        columns: (1fr, auto),
        column-gutter: 6mm,
        align: (center + horizon, right + horizon),
        [#it.body],
        [#context numbering(it.numbering, ..counter(math.equation).get())],
      )
    ]
  }
}

#let report_heading_rules(it) = {
  if is_report_section_heading(it) {
    let title = report_heading_title(it.body)
    report_section_heading_render(
      title,
      section_number: report_section_number(title),
    )
  } else if it.level == 1 {
    [#colbreak(weak: true) #it #metadata(it) #report_labels.header]
  } else {
    [#it #metadata(it) #report_labels.header]
  }
}

#let report_section_heading(body) = [
  #report_section_counter.step()
  #context {
    let section_number = report_section_counter.get().first()
    let query_body = [Розділ #section_number. #body]
    report_section_heading_render(
      report_heading_title(query_body),
      section_number: section_number,
    )
  }
]

#let report_page(body, document_code: none) = [
  #bordered_page(
    footer: footer_f2a(document_code: document_code),
  )[
    #body
    #metadata("end") #report_labels.page_end
  ]
]

#let report_outline_page(
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

    start_label: report_labels.page_start,
    end_label: report_labels.page_end,
    header_label: report_labels.header,
    metadata_entries: true,
  )
}

#let report_abbreviations_page(
  document_code: none,
  abbreviations: none,
) = {
  report_page(
    document_code: document_code,
  )[
    #align(center)[
      #heading(numbering: none)[ПЕРЕЛІК УМОВНИХ СКОРОЧЕНЬ]
    ]

    #set par(leading: 0.65em)

    #table(
      columns: (22mm, 1fr),
      inset: (x: 2mm, y: 0.65em),
      column-gutter: 8mm,
      align: left + top,
      stroke: none,
      ..abbreviations.flatten(),
    )
  ]
}

#let report_bibliography_page(
  sources,
  document_code: none,
  title: bibliography_title,
  style: bibliography_style,
  full: false,
) = {
  report_page(document_code: document_code)[
    #bibliography_section(
      sources,
      title: title,
      style: style,
      full: full,
    )
  ]
}

#let report_title_page(
  topic: none,
  city: none,
  year: none,
) = {
  cover_page(right: page_margin.right)[
    #v(68mm)
    #align(center)[
      #text(
        weight: "bold",
        size: 18pt,
      )[ПОЯСНЮВАЛЬНА ЗАПИСКА\ ДО ДИПЛОМНОГО ПРОЄКТУ]
    ]

    #v(5mm)
    #align(center)[
      на тему: "#underline[#emph(topic)]"
    ]

    #v(1fr)
    #align(center)[#city -- #year р.]
  ]
}
