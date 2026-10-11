#import "page.typ": bordered_page
#import "footer.typ": footer_f2, footer_f2a
#import "lib.typ": page_range_sheet_count

#let outline_entry_heading(entry: none, metadata_entries: none) = {
  if metadata_entries {
    entry.value
  } else {
    entry
  }
}

#let outline_entry_row(entry_param: none, metadata_entries: none) = [
  #let entry = outline_entry_heading(
    entry: entry_param,
    metadata_entries: metadata_entries,
  )
  #let entry_location = entry_param.location()
  #let page_number = counter(page).at(entry_location).first()
  #let heading_number = if entry.level == 1 or entry.numbering == none {
    []
  } else {
    [#numbering(entry.numbering, ..counter(heading).at(entry.location())) ]
  }
  #link(entry_location)[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 1.6mm,
      [#pad(left: 11mm * calc.max(entry.level - 1, 0))[
        #heading_number #if entry.level == 1 {
          upper(entry.body)
        } else [ #entry.body ]
      ]],
      [#box(width: 100%, clip: true)[#repeat()[.]]],
      [#page_number],
    )
  ]
]

#let outline_entry_gap(entries: none, index: none, metadata_entries: none) = {
  if index + 1 >= entries.len() {
    0mm
  } else {
    let entry = outline_entry_heading(
      entry: entries.at(index),
      metadata_entries: metadata_entries,
    )
    let next = outline_entry_heading(
      entry: entries.at(index + 1),
      metadata_entries: metadata_entries,
    )

    if next.level > entry.level {
      2mm
    } else if entry.level == 1 {
      3mm
    } else {
      2mm
    }
  }
}

#let outline_page(
  document_name: none,
  topic: none,
  group: none,
  document_code: none,
  implemented_by: none,
  reviewed_by: none,
  norm_controller: none,
  approved_by: none,
  start_label: none,
  end_label: none,
  header_label: none,
  metadata_entries: none,
) = context {
  counter(page).update(1)

  let entries = if metadata_entries {
    query(header_label)
  } else {
    query(selector(heading).and(header_label))
  }
  let sheet_count = page_range_sheet_count(
    start_label: start_label,
    end_label: end_label,
  )
  let first_footer = footer_f2(
    document_name: document_name,
    topic: topic,
    group: group,
    document_code: document_code,
    sheet_number: [1],
    sheet_count: [#sheet_count],
    implemented_by: implemented_by,
    reviewed_by: reviewed_by,
    norm_controller: norm_controller,
    approved_by: approved_by,
  )

  // Typst can vary footer content by page, but the page margin is fixed for
  // this whole flow. Reserve the large first footer to prevent overlap.
  bordered_page(
    footer_space: measure(first_footer).height,
    footer: context {
      let p = counter(page).get().first()
      if p == 1 {
        first_footer
      } else {
        footer_f2a(document_code: document_code)
      }
    },
  )[
    #metadata("start") #start_label

    #align(center)[ЗМІСТ]
    #v(7mm)

    #for (index, entry) in entries.enumerate() [
      #outline_entry_row(entry_param: entry, metadata_entries: metadata_entries)
      #v(outline_entry_gap(
        entries: entries,
        index: index,
        metadata_entries: metadata_entries,
      ))
    ]
  ]
}
