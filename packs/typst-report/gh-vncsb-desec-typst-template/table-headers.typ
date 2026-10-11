#import "settings.typ": *
#let default-alignment = center + horizon

#let h-header(table-content) = {
  set table(
    align: default-alignment,
    fill: (x, y) => if y == 0 {
      highlight-fill-color
    },
  )
  show table.cell: it => {
    if it.y == 0 {
      set text(white)
      strong(it)
    } else {
      it
    }
  }

  table-content
}

#let v-header(table-content) = {
  set table(
    align: default-alignment,
    fill: (x, y) => if x == 0 {
      highlight-fill-color
    },
  )
  show table.cell: it => {
    if it.x == 0 {
      set text(white)
      strong(it)
    } else {
      it
    }
  }

  table-content
}
