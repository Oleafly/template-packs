#let entry(left, right) = (
  block(breakable: false, left),
  [],
  block(breakable: false, right),
)

#let heading(heading) = (
  ..entry(v(10pt), []),
  ..entry(heading, [])
)