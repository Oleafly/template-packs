// Postcard back — 6×4 landscape with 0.125" bleed on every side.
// Final trim is 6in × 4in; the page size below includes bleed.

#let location = sys.inputs.at("location", default: "Kyoto, Japan")
#let date = sys.inputs.at("date", default: "April 2026")

#set page(
  width: 6.25in,
  height: 4.25in,
  margin: 0in,
)

#set text(size: 10pt)

// Center divider line, kept inside the 0.25in safe zone
#place(
  top + left,
  dx: 3.125in,
  dy: 0.5in,
  line(length: 3.25in, angle: 90deg, stroke: 0.4pt + luma(60%)),
)

// --- Left half: caption ---
#place(
  top + left,
  dx: 0.5in,
  dy: 0.55in,
  block(width: 2.4in)[
    #text(size: 14pt, weight: "bold")[#location]
    #v(0.05in)
    #text(size: 10pt, style: "italic", fill: luma(35%))[#date]
  ],
)

// --- Right half: stamp box ---
#place(
  top + right,
  dx: -0.5in,
  dy: 0.5in,
  rect(
    width: 0.9in,
    height: 1.05in,
    stroke: 0.5pt + luma(60%),
    inset: 6pt,
  )[
    #set align(center + horizon)
    #text(size: 7pt, fill: luma(50%))[PLACE\ STAMP\ HERE]
  ],
)

// --- Right half: address lines ---
#place(
  top + left,
  dx: 3.5in,
  dy: 2in,
  stack(spacing: 0.4in,
    line(length: 2.4in, stroke: 0.5pt + luma(35%)),
    line(length: 2.4in, stroke: 0.5pt + luma(35%)),
    line(length: 2.4in, stroke: 0.5pt + luma(35%)),
    line(length: 2.4in, stroke: 0.5pt + luma(35%)),
  ),
)
