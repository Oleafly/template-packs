#import "dimensions.typ": *
#import "graphics.typ": *
#import "styles.typ": *
#import "tools.typ": *

// Set of available fittings

// Container shrink around container
#let shrink = "shrink"
// Content expand to all available space
#let expand = "expand"
// Content expand horizontally, but shrink vertically
#let expand-h = "expand-h"
// Content expand vertically, but shrink horizontally
#let expand-v = "expand-v"
// Content tries to keep square form for available space
#let squared = "squared"

// Helper function for building any container.
// - fitting: Declares how layout of container works. Can be shrink, expand, expand-h or expand-v
// - insets: Inner insets around background
// - background: Arbitrary shape to frame content
// - body: Actual content
#let container(
  fitting: shrink,
  insets: paddings(1),
  background: (size) => rect(width: size.width, height: size.height),
  body
) = {
  layout(size => {
    let padArgs = if type(insets) == dictionary {
      insets
    } else {
      (rest: insets)
    }

    let bodyWithPadding = pad(..padArgs)[#body]
    let contentSize = () => {
      measure(block(width: size.width)[#bodyWithPadding])
    }

    let size = if fitting == expand {
      size
    } else if fitting == shrink {
      measure(bodyWithPadding)
    } else if fitting == expand-h {
      (width: size.width, height: contentSize().height)
    } else if fitting == expand-v {
      (width: contentSize().width, height: size.height)
    } else if fitting == squared {
      let minDimention = calc.min(size.width, size.height)
      (width: minDimention, height: minDimention)
    } else {
      panic("fitting " + fitting + " is not supported, expected: shrink|expand|expand-h|expand-v")
    }

    [
      #block(width: size.width, height: size.height)[
        #background(size)
      ]
      #place(center + horizon)[
        #block(width: size.width, height: size.height)[
          #bodyWithPadding
        ]
      ]
    ]
  })
}

// Container wrappend in frame.
// Parameters:
// - stroke: Stroke width
#let framed(
  stroke: strokes.thin,
  radius: paddings(1) - 0.1 * paddings(1),
  insets: paddings(1),
  fitting: shrink,
  body
) = container(
  fitting: fitting,
  insets: insets,
  background: size => frame(
    width: size.width,
    height: size.height,
    stroke: stroke,
    radius: radius
  ),
  body
)


#let propBox(
  shape: frame.with(radius: paddings(1) - 0.1 * paddings(1)),
  dx: 0pt,
  dy: 0pt,
  width: 100%,
  height: 100%,
  caption: none,
  content: none
) = container(
  fitting: squared,
  background: size => shape(
    width: size.width,
    height: size.height,
    stroke: strokes.normal
  )
)[
  #box(width: width, height: height)[
    #place(horizon + center, dy: -0.4em)[ #propBody(content) ]
    #place(bottom + center, dx: dx, dy: dy)[
      #propCap[ #caption ]
    ]
  ]
]

#let badge(
  height: auto,
  width: auto,
  padding: 0.2em,
  alignment: top + right,
  contentAlignment: horizon + center,
  content: none,
  body
) = [
  #box[
    #body
    #place(alignment)[
      #rect(
        width: width,
        height: height,
        fill: white,
        stroke: strokes.normal
      )
      #place(contentAlignment)[
        #box(
          width: width,
          height: height,
          pad(padding, propCap(content))
        )
      ]
    ]
  ]
]

#let repeated(count, spacing: paddings(1), body) = grid(
  row-gutter: spacing,
  ..(range(count).map(_ => body))
)

#let innerRowStrokes(stroke: strokes.hairline) = (x, y) => (
  top: if y > 0 { stroke } else { 0pt },
  bottom: none
)

#let innerColumnStrokes(stroke: strokes.hairline) = (x, y) => (
  left: if x > 0 { stroke } else { 0pt },
  right: none
)

#let simpleTable(header, ..cells) = {
  let headerCell(content) = table.cell(
    stroke: none,
    tableHeader(content)
  )

  table(
    columns: header.len(),
    stroke: strokes.hairline,
    table.header(..(header.map(headerCell))),
    ..cells
  )
}

#let inputGrid(lines, lineHeight: paddings(3), width: 100%) = {
  let gridBox(body) = box(width: width, height: lines * lineHeight, body)
  let gridLine(y) = line(start: (0%, y), length: 100%, stroke: strokes.hairline)

  if lines == 0 {
    none
  } else if lines == 1 {
    gridBox[
      #gridLine(lineHeight)
    ]
  } else {
    gridBox[
      #for lineNumber in range(1, lines) {
        place(center, gridLine(lineHeight * lineNumber))
      }
    ]
  }
}

#let hstack(size: (1fr,), skipNone: false, ..elems) = {
  grid(
    columns: matchedSize(filterNone(elems.pos(), shouldSkip: skipNone), size),
    ..elems
  )
}

#let vstack(size: (auto,), skipNone: false, ..elems) = {
  grid(
    rows: matchedSize(filterNone(elems.pos(), shouldSkip: skipNone), size),
    ..elems
  )
}
