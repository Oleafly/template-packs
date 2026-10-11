#let themed_table(theme, body) = {
  set table(
    align: center,
    stroke: (x, y) => {
      let styles = (:)
      if y == 0 {
        styles.insert("top", black)
        styles.insert("bottom", black)
      } else if y > 1 {
        styles.insert("top", theme.table.row_rule)
      }
      if x > 0 {
        styles.insert("left", theme.table.divider)
      }
      styles
    },
  )
  show table.cell.where(y: 0): set text(weight: "bold")
  body
}
