#let view(doc) = {
  set text(font: "IPAMincho", 12pt)
  set par(
    first-line-indent: 1em,
    spacing: 0.65em,
    justify: true,
  )
  set heading(numbering: (..nums) => {
    let numbers = nums.pos()
    if numbers.len() == 1 {
      numbering("第1章　", ..numbers)
    } else {
      numbering("1.1　", ..numbers)
    }
  })

  show heading.where(level: 1): set block(above: 40pt, below: 50pt)
  show heading.where(level: 2): set block(above: 30pt, below: 15pt)
  show heading.where(level: 3): set block(above: 30pt, below: 15pt)
  show heading.where(level: 1): set text(size: 24pt)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 12pt)

  set page(
    paper: "a4",
    margin: (
      top: 40mm,
      bottom: 40mm,
      left: 35mm,
      right: 20mm,
    ),
  )

  doc
}
