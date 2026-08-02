
#let vyt-table-fancy(body) = {
  set table(
    stroke: 2pt + blue,
    columns: (auto, 1fr, 1fr),
    //stroke: 1pt black,
    fill: (column, row) => {
      if (row == 0) {
        blue.lighten(60%)
      } else if (calc.rem(row, 2) == 0) {
        rgb("f0f0f0")
      } else { 
        white
      }
    },
    align: (left, center, right),
    //header: 1,
  )
  show table.cell.where(y: 0): set text(fill: white)
  body
}


#let vyt-table-fancy1(
  ..content, 
  num-header-rows: 1,
  header-cell-fill: color.blue,
  header-text-fill: color.white,
  text-fill: none,
  cell-fill: none,
) = {
  // Apply text color to the header rows
  show table.cell.where(y: 0): set text(
    fill: header-text-fill,
  )

  // Define the table with other properties, like fill color for header
  table.with(
    fill: (x, y) => {
      if (y < num-header-rows) { 
        header-cell-fill
      } /*else {
        if (type(cell-fill) == function) {
          cell-fill(x, y)
        } else if(type(cell-fill) == color) {
          cell-fill
        }
      }*/
    },
    inset: 10pt,
    align: center,
    ..content // Unpack the provided content
  )
}
