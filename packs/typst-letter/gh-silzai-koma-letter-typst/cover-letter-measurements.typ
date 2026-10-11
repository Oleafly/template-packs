#set rect(
  height: 100%,
  width: 100%,
  inset: 0pt,
)

#set page(
  paper: "a4",
  header: rect(fill: aqua)[Header],
  footer: rect(fill: aqua)[Footer],
  number-align: center,
  margin: (
    top: 0mm,
    bottom: 0mm,
    left: 0mm,
    right: 00mm
  ),
)
#set text(
  font: "New Computer Modern",
  size: 12pt
)

#grid(
  columns: (1fr, 170mm, 1fr),
  rows: (8mm, 55mm, 36mm),
  gutter: 0pt,
  // align: center + horizon, // remove this when creating actual doc
  // stroke: 1mm,
  rect[1fr],
  rect[170mm width $times$ 8mm height from top of page to start of letterhead],
  rect[1fr],
// Letterhead
  rect[],
  grid.cell(
    rect[letterhead, 55mm height],
    // breakable: false,
    stroke: 0mm,
  ),
  rect[],
// addressee 
  rect[d],
  rect[addressee, 36mm height because the "reference field lines" box needs to be 99mm from the top of the page (refvpos in koma-script)],
  rect[d],
)
// new grid for reference field lines, letter body etc.
#v(0pt, weak: true)
#grid(
  columns: (1fr, 158mm, 1fr),
  rows: (7mm, 151mm),
  gutter: 0pt,
  // align: center + horizon, // remove this when creating actual doc
  // stroke: 1mm,
  rect[1fr],
  [
    #align(right)[158mm width for reline and body, date goes to the right]
  ],
  rect[1fr],
// body
  rect[1fr],
  rect[
    *subject* \ \ \
    opening \ \
    body \ \
    #set par(hanging-indent: 3em)
    closing \ \ \ 
    signature
  ],
  rect[1fr],
)
// footer
#v(0pt, weak: true)
#grid(
    columns: (1fr, 170mm, 1fr),
    rows: (40mm),
    gutter: 0pt,
    rect[], rect[footer], rect[]
)

