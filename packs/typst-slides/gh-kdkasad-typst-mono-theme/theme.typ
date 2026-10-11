//
// A monospaced theme for Typst documents.
// Copyright (C) 2025 Kian Kasad (@kdkasad) <kian@kasad.com>
// This project is licensed under the MIT License.
// See the provided LICENSE file for details.
//

#let heading-params = (
  none,
  (
    size: 20pt,
    tracking: -1pt,
    leading: 8pt,
  ),
  (
    size: 16pt,
    tracking: -0.6pt,
    leading: 6pt,
  ),
  (
    size: 12pt,
    tracking: -0.6pt,
    leading: 6pt,
  ),
)

#let heading-font-state = state("heading-font", "Iosevka")

// Theme function. Use in a global show rule, e.g.:
//
//     #show: theme
//
// IMPORTANT: This theme does not set the document metadata. You must
// do so yourself using `#set document(...)`.
//
// The footer will show the current date, copyright, and page number.
// To use a specific date instead of the current date, pass a value as
// the `date` parameter. The value can be a `datetime` object or content:
//
//     #show: theme.with(date: datetime(year: 2025, month: 9, day: 1))
//     #show: theme.with(date: [Friday the 13th])
//
// The copyright is a custom optional content value. E.g.:
//
//     #show: theme.with(copyright: [#sym.copyright 2025 Kian Kasad])
//
// You can customize the fonts used for the headings/title and body
// respectively:
//
//     #show: theme.with(heading-font: "Iosevka", body-font: "Inter")
#let theme(
  it,
  date: auto,
  copyright: none,
  heading-font: "Iosevka",
  body-font: "Iosevka",
) = {
  assert(
    date == auto or type(date) == datetime or type(date) == content,
    message: "date must be auto, datetime, or content"
  )
  assert(
    copyright == none or type(copyright) == content,
    message: "copyright must be none or content"
  )

  heading-font-state.update(heading-font)

  set heading(numbering: "1.")
  set text(10pt, font: body-font)
  set par(leading: 6pt, justify: true)

  set page(
    footer: context {
      let rendered-date = {
        // Use current date if no date is provided
        let date-format = "[month repr:long] [day padding:none], [year]"
        if date == auto {
          datetime.today().display(date-format)
        } else if type(date) == datetime {
          date.display(date-format)
        } else {
          date
        }
      } // rendered-date

      let page-number = {
        counter(page).display()
      }

      set text(8pt, rgb(137, 137, 137))
      grid(
        columns: (1fr, 1fr, 1fr),
        grid.cell(align: left, rendered-date),
        grid.cell(align: center, copyright),
        grid.cell(align: right, page-number),
      )

    } // footer
  )

  show heading: it2 => {
    let level = if it2.level >= heading-params.len() {
      heading-params.len() - 1
    } else {
      it2.level
    }
    let params = heading-params.at(level)
    set text(
      font: heading-font,
      size: params.size,
      weight: "black",
      tracking: params.tracking,
    )
    set par(leading: params.leading)
    it2
  }

  it
}

// Render a title.
// This WILL set the title in the document's metadata as well.
#let title(it) = context {
  assert(type(it) == content, message: "title must be content")
  set text(size: 36pt, font: heading-font-state.get(), weight: "black", tracking: -3pt)
  set par(leading: 10pt)
  set document(title: it)
  it
}
