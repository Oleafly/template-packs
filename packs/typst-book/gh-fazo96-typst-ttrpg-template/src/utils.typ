// This file contains utility functions that can be used to
// automate common tasks in the book.
// It's a good idea to import this file in your content files
// to use the functions defined here.

#import "@preview/markly:0.3.0"
#import "theme.typ": blood-red, dark-red, moon-silver

#let page_illustration(image_path, markly-context) = {
  let image = read(image_path, encoding: none)
  page(header: none, footer: none, margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt))[
    #markly.img-to-bleed(image, markly-context)
  ]
}

// Helper to keep content together (e.g. heading + table)
#let keep_together(body) = {
  block(breakable: false, width: 100%, body)
}

// Custom table styling for RPG tables
// Automatically detects grid tables (more than 2 columns) and disables hyphenation
#let rpg_table(..args, body) = {
  // Extract the columns argument to detect if it's a grid
  let is_grid = false
  if "columns" in args.named() {
    let cols = args.named().columns
    // Check if columns is a number > 2, or an array with length > 2
    is_grid = (type(cols) == int and cols > 2) or (type(cols) == array and cols.len() > 2)
  }

  show table.cell: it => {
    block(breakable: false)[
      #if it.y == 0 {
        set text(fill: white, weight: "bold", size: 9pt)
        it
      } else {
        if is_grid {
          set text(hyphenate: false, size: 9pt)
          set par(justify: false)
          it
        } else {
          it
        }
      }
    ]
  }

  table(
    stroke: none,
    fill: (col, row) => {
      if row == 0 { blood-red } else if calc.rem(row, 2) == 0 { moon-silver.lighten(50%) } else { white }
    },
    inset: 8pt,
    align: left,
    ..args,
    body
  )
}

// Matrix d6 table generator for d66 oracle tables
// Takes an array of 36 items and generates two tables showing the full 6x6 matrix
// Items should be ordered row-by-row: [11, 12, 13, 14, 15, 16, 21, 22, ...]
#let matrix_d6(items, breakable: false) = {
  assert(items.len() == 36, message: "matrix_d6 requires exactly 36 items")

  // First table: columns 1-3
  let table1 = rpg_table(
    columns: (auto, 1fr, 1fr, 1fr),
    [],
    [1],
    [2],
    [3],
    ..for row in range(6) {
      (
        [#(row + 1)],
        items.at(row * 6 + 0),
        items.at(row * 6 + 1),
        items.at(row * 6 + 2),
      )
    }.flatten(),
  )

  // Second table: columns 4-6
  let table2 = rpg_table(
    columns: (auto, 1fr, 1fr, 1fr),
    [],
    [4],
    [5],
    [6],
    ..for row in range(6) {
      (
        [#(row + 1)],
        items.at(row * 6 + 3),
        items.at(row * 6 + 4),
        items.at(row * 6 + 5),
      )
    }.flatten(),
  )

  // Return both tables wrapped in keep_together
  if breakable {
    [
      #table1
      #table2
    ]
  } else {
    keep_together[
      #table1
      #table2
    ]
  }
}

// Two-column d66 table generator for oracle tables
// Takes an array of 36 items and generates a table with d66 roll numbers (11-66)
// Items should be ordered: [11, 12, 13, 14, 15, 16, 21, 22, ..., 66]
#let table_d66(title, items, breakable: true) = {
  assert(items.len() == 36, message: "table_d66 requires exactly 36 items")

  // Generate d66 roll numbers (11-16, 21-26, ..., 61-66)
  let roll_numbers = ()
  for row in range(1, 7) {
    for col in range(1, 7) {
      roll_numbers.push(str(row) + str(col))
    }
  }

  // Build the table content
  let table_content = ([D66], [#title])
  for i in range(36) {
    table_content.push([#roll_numbers.at(i)])
    table_content.push(items.at(i))
  }

  let result = rpg_table(
    columns: (auto, 1fr),
    ..table_content,
  )

  if breakable {
    result
  } else {
    keep_together(result)
  }
}

// Four-column d66 table generator for oracle tables with two side-by-side columns
// Takes an array of 36 items and generates a table with two d66 columns side by side
// Items should be ordered: [11, 12, 13, 14, 15, 16, 21, 22, ..., 66]
#let table_d66_double(title, items, breakable: true) = {
  assert(items.len() == 36, message: "table_d66_double requires exactly 36 items")

  // Generate d66 roll numbers (11-16, 21-26, ..., 61-66)
  let roll_numbers = ()
  for row in range(1, 7) {
    for col in range(1, 7) {
      roll_numbers.push(str(row) + str(col))
    }
  }

  // Build the table content with 4 columns (D66, Detail, D66, Detail)
  let table_content = ([D66], [#title], [D66], [#title])

  // Add 18 rows (half of 36 items)
  for i in range(18) {
    table_content.push([#roll_numbers.at(i)])
    table_content.push(items.at(i))
    table_content.push([#roll_numbers.at(i + 18)])
    table_content.push(items.at(i + 18))
  }

  let result = rpg_table(
    columns: (auto, 1fr, auto, 1fr),
    ..table_content,
  )

  if breakable {
    result
  } else {
    keep_together(result)
  }
}


// Dice notation formatter
#let dice(notation) = {
  text(
    fill: blood-red,
    weight: "bold",
    font: "monospace",
    notation,
  )
}

// Section header with decorative line
#let section-header(title) = {
  block(
    width: 100%,
    breakable: false,
    [
      #set text(size: 24pt, weight: "bold", fill: blood-red)
      #title
      #v(-8pt)
      #line(length: 100%, stroke: 2pt + blood-red)
    ],
  )
}

// Subsection header
#let subsection-header(title) = {
  block(
    width: 100%,
    breakable: false,
    [
      #set text(size: 18pt, weight: "bold", fill: dark-red)
      #title
      #v(-6pt)
      #line(length: 60%, stroke: 1pt + dark-red)
    ],
  )
}

// Info box for important game mechanics
#let info-box(body) = {
  block(
    fill: blood-red,
    stroke: none,
    radius: 0pt,
    inset: 12pt,
    width: 100%,
    [
      #text(fill: white)[#body]
    ],
  )
}
