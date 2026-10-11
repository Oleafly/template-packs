#let simple_table_banding(color1, color2) = {
  return (row) => {
    if calc.rem(row, 2) == 0 {
      color1
    } else {
      color2
    }
  }
}