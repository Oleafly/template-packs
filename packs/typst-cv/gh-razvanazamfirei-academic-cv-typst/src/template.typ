#import "page.typ": left_indent, line_spacing

#let header(name, date) = {
  align(
    center,
    stack(
      dir: ttb,
      spacing: 6pt,
      upper("University of Pennsylvania – School of Medicine"),
      "Curriculum Vitae",
      align(right)[
        Date: #underline(date.display("[month repr:long] [day], [year repr:full]"))
      ],
      v(9pt),
      underline(upper(name)),
    ),
  )
}

#let education(..entries) = {
  grid(
    columns: (left_indent, 1.75in, 0.38in, 1fr),
    row-gutter: line_spacing,
    ..for entry in entries.pos() {
      ([], [#entry.start --- #entry.end], entry.degree, entry.university)
    },
  )
}

#let date-block(..items) = {
  let year_parse(date) = {
    if type(date) == array {
      if date.len() == 0 {
        []
      } else if date.len() == 1 {
        date.first()
      } else if date.len() == 2 {
        [#date.first() --- #date.at(1)]
      } else {
        date
      }
    } else {
      // Handle content types (like [N/A])
      date
    }
  }
  grid(
    columns: (left_indent, 1.75in, 1fr),
    row-gutter: line_spacing,
    ..for item in items.pos() {
      let year = year_parse(item.years)
      let content = item.content.text.replace("---", "\u{2014}")
      ([], year, content)
    },
  )
}

#let contact_info(title, ..lines) = {
  grid(
    columns: (left_indent, 1fr),
    [= #title], [#lines.pos().join("\n")],
  )
}

#let bibliography_section(title, ..items) = {
  [== #title]
  set par(hanging-indent: 0.5in, linebreaks: "optimized")
  grid(
    columns: (left_indent, 1fr),
    row-gutter: line_spacing,
    ..for item in items.pos() {
      ([], [#item])
    },
    []
  )
}

#let editorial_section(title, ..items) = {
  [= #title]
  set par(hanging-indent: 0.5in, linebreaks: "optimized")
  grid(
    columns: (0.5in, 1fr),
    row-gutter: line_spacing,
    ..for item in items.pos() {
      ([], [#item])
    },
  )
}
