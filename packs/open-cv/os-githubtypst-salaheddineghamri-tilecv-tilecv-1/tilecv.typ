/*
 * file contains all the functions and building blocks.
 */

// list-in-grid
// items as a list or bullet point of items
#let make-list-in-grid() = (content, list-or-items) => grid(
  columns: auto,
  rows: auto,
  if list-or-items == "list" {
    [#content.join[ -- ]]
    } else if list-or-items == "items" {
    for item in content [- #item]
  }
)

#let styled-rect(body, color, height: auto) = rect(
    fill: rgb(color),
    height: height,
    width: 100%,
    body
)

// entry-with-date, entry can be a timeline-item
// normal entry with date, title and details
#let make-entry-with-date(config) = (date, entry, details, with-progress: false) => {
    let entry-details = { if with-progress == true {
        grid(rows: auto, gutter: config.timeline_entry_items_gutter, ..details)
    } else {
        par(details, justify:true)
      }
    }

    grid(
    columns: (config.date_column_width, auto),
    rows: auto,
    gutter: config.entry_gutter,
    grid.cell(
        rowspan: 2,
        emph[#text(date, weight: "light", size: config.date_font_size)],
    ),
        upper[#text(entry, weight: "bold", size: config.default_font_size)],
    entry-details)
}

// progress timeline
#let make-timeline-item(config) = (date, entry, details) => grid(
  columns: (auto, 1fr),
  rows: (auto, auto),
  gutter: config.timeline_entry_items_gutter,
  align: (left, bottom),
    [- #text(entry, weight: "bold")],
    align(left)[#text(date, size: config.date_font_size)],
  grid.cell(
    colspan: 2,
      list(marker: [],
          indent: -2.3pt,
          [#rect(stroke: (left: gray),
              inset: 5pt,
              fill: none
          )[#par(text(details, size: config.default_font_size - 0.3pt), justify: true)]]
      )
  )
)

#let make-tilecv-block(config) = (title, content, highlight) => {
  let fill = if highlight { config.highlight_bg_color } else { white }
  grid(
    gutter: 0pt,
    styled-rect([#upper[#title]], config.title_bg_color),
    styled-rect(pad(top: config.block_gap, bottom: config.block_gap, [#content]), fill, height: auto)
  )
}

// the custumization of basic building block
#let make-snapshot-block(config) = (title, content, highlight) => {
    let fill = if highlight { config.highlight_bg_color } else { white }
    grid(
        rows: (auto, 1fr),
        styled-rect([#upper[#title]], config.title_bg_color),
        styled-rect(pad(top: config.block_gap, bottom: config.block_gap, [#content]), fill, height: 1fr)
    )
}

#let make-tilecv-layout(config) = (sections, doc,) => {

    // Page layout
    set text(font: config.default_font, weight: "regular", size: config.default_font_size)
    set align(left)
    let paper_size = config.page_size
    set page(
      paper: {paper_size},
      margin: {
        if paper_size == "us-letter" {
          (left: 2cm, right: 1.4cm, top: 1.2cm, bottom: 1.2cm)
          } else {
          (left: 1.4cm, right: 1.4cm, top: 1cm, bottom: 1cm)
        }
      },
    )

    // a grid cell that span 2 columns
    let two-column-cell(body) = grid.cell(
        colspan:2,
        body
    )

    // a grid cell that span 2 rows
    let two-raws-cell(body) = grid.cell(
        rowspan:2,
        body
    )

    // definition of tilecv layout as grid
    //let tilecv_layout = grid(
    //    columns: (1fr, 1fr, 1fr),
    //    rows: (1fr, auto, auto),
    //    gutter: 4pt,
    //    grid.cell(
    //        colspan: 3,
    //        grid(gutter: 4pt,
    //            columns: (1fr, 1fr, 1fr),
    //            sections.at(0),
    //            two-column-cell(sections.at(1))
    //            )
    //    ),
    //    two-column-cell(sections.at(2)),
    //    two-raws-cell(sections.at(3)),
    //    two-column-cell(two-raws-cell(..sections.slice(4,)))
    //)

    // TODO: enhance response
    let tilecv_layout = {
        // Required sections (0 and 1)
        let required_sections = if sections.len() >= 2 {
            (sections.at(0), two-column-cell(sections.at(1)))
        } else if sections.len() >= 1 {
            (sections.at(0), [])  // Empty cell if section 1 missing
        } else {
            panic("At least section 0 is required")
        }

        // Optional sections
        let section_2 = if sections.len() > 2 { two-column-cell(sections.at(2)) } else { [] }
        let section_3 = if sections.len() > 3 { two-raws-cell(sections.at(3)) } else { [] }
        let remaining_sections = if sections.len() > 4 {
            two-column-cell(two-raws-cell(..sections.slice(4)))
        } else { [] }

        grid(
            columns: (1fr, 1fr, 1fr),
            rows: (1fr, auto, auto),
            gutter: 4pt,
            grid.cell(
                colspan: 3,
                grid(gutter: 4pt,
                    columns: (1fr, 1fr, 1fr),
                    ..required_sections
                )
            ),
            section_2,
            section_3,
            remaining_sections
        )
    }

    [#tilecv_layout]
    doc
}
