#let content-header-numbering(..number) = {
  let n = number.pos()
  let level = n.len()
  if level == 1 { numbering("I.", ..n) } else if level <= 3 {
    numbering("1.1.1.", ..n)
  } else {
    numbering("a.1.", ..n.slice(3))
  }
}
