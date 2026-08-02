#let require-alt(kind, alt) = {
  if alt == none or alt == [] or alt == "" {
    panic(kind + " requires natural-language alt text.")
  }
}

// `image-figure` wraps any centered content as a captioned, numbered
// figure that emits the metadata the front-matter List of Figures reads.
// Pass an `image(...)` content (or any composite layout) as the `body`.
// The image() call lives in the calling chapter, so its path resolves
// relative to that chapter file — unlike a string passed through the
// package, which would resolve relative to src/helpers.typ and fail.
//
// Set alt text on the inner image() for screen readers, e.g.
//   #image-figure(
//     image("../figures/sample.pdf", alt: "Plot of …"),
//     caption: [Caption text…],
//   )
#let image-figure(
  body,
  caption: none,
  placement: none,
  outlined: true,
) = {
  if type(body) == str {
    panic("image-figure now takes content. Replace `image-figure(\"" + body + "\", ...)` with `image-figure(image(\"" + body + "\", alt: \"…\"), ...)` so the path resolves relative to your chapter.")
  }
  if type(body) == bytes {
    panic("image-figure no longer accepts bytes. Replace `image-figure(read(\"path\", encoding: none), …)` with `image-figure(image(\"path\", alt: \"…\"), …)`. Putting image() inside your chapter is simpler and lets you set alt text and width per call.")
  }
  figure(
    block(width: 100%)[
      #context metadata((
        kind: "uofsc-etd-figure-list-entry",
        label: [Figure~#counter(figure.where(kind: image)).display()],
        caption: caption,
        page: counter(page).display(),
        location: here(),
        outlined: outlined,
      ))
      #align(center, body)
    ],
    placement: placement,
    outlined: outlined,
    caption: caption,
  )
}

// Use this helper for thesis tables that need the class-style horizontal-rule
// treatment. The helper creates a table figure with a heavy top rule, a lighter
// header rule, and a heavy bottom rule while also resetting the paragraph
// styling away from the document body defaults. That matters because thesis
// prose is double spaced and indented, but table cells should be single spaced,
// unindented, and top aligned. Pass the header cells through `header:` and the
// body cells as the trailing positional content.
#let table-figure(
  columns,
  caption: none,
  header: (),
  placement: none,
  outlined: true,
  width: 100%,
  align: left + top,
  inset: (x: 0.35em, y: 0.2em),
  column-gutter: 0.9em,
  row-gutter: 0.15em,
  leading: 0.52em,
  top-rule: 1.15pt + black,
  mid-rule: 0.6pt + black,
  bottom-rule: 1.15pt + black,
  ..cells,
) = {
  let body-cells = cells.pos()
  let header-content = if header == none or header == () {
    ()
  } else {
    (
      table.header(..header),
      table.hline(y: 1, stroke: mid-rule),
    )
  }

  figure(
    block(width: width)[
      #context metadata((
        kind: "uofsc-etd-table-list-entry",
        label: [Table~#counter(figure.where(kind: table)).display()],
        caption: caption,
        page: counter(page).display(),
        location: here(),
        outlined: outlined,
      ))
      #set par(first-line-indent: 0pt, justify: false, leading: leading)
      #table(
        columns: columns,
        stroke: none,
        align: align,
        inset: inset,
        column-gutter: column-gutter,
        row-gutter: row-gutter,
        table.hline(y: 0, stroke: top-rule),
        ..header-content,
        ..body-cells,
        table.hline(stroke: bottom-rule),
      )
    ],
    kind: table,
    placement: placement,
    outlined: outlined,
    caption: caption,
  )
}

#let equation-block(alt: none, block: true, supplement: auto, body) = {
  require-alt("equation-block", alt)
  math.equation(
    alt: alt,
    block: block,
    supplement: supplement,
    body,
  )
}

#let landscape-page(body) = {
  // The format guide requires that landscape pages use 1.25" margins on the long
  // sides (top and bottom in flipped orientation) and 1" margins on the short
  // sides (left and right).
  page(
    paper: "us-letter",
    flipped: true,
    margin: (
      top: 1.25in,
      bottom: 1.25in,
      left: 1in,
      right: 1in,
    ),
  )[#body]
}

#let threepart-figure(
  caption: none,
  notes: none,
  placement: none,
  supplement: auto,
  numbering: auto,
  gap: 0.65em,
  outlined: true,
  kind: auto,
  body,
) = {
  let figure-body = block(width: 100%)[
    #body
    #if notes != none {
      v(0.65em)
      set par(first-line-indent: 0pt, justify: false, leading: 0.52em)
      notes
    }
  ]

  if numbering == auto {
    figure(
      figure-body,
      caption: caption,
      placement: placement,
      supplement: supplement,
      gap: gap,
      outlined: outlined,
      kind: kind,
    )
  } else {
    figure(
      figure-body,
      caption: caption,
      placement: placement,
      supplement: supplement,
      numbering: numbering,
      gap: gap,
      outlined: outlined,
      kind: kind,
    )
  }
}

// `definition-list` lays out a series of (term, description) pairs as a
// single-column block: bold term on its own line, indented description below.
#let definition-list(..pairs) = {
  for pair in pairs.pos() {
    let (term, description) = pair
    block(below: 0.5em, sticky: true)[*#term*]
    block(inset: (left: 0.25in), below: 1em)[#description]
  }
}

// `quote-block` is a thin wrapper around Typst's quote() that adds the
// typographic conventions the Graduate School expects: indented on both
// sides, single-spaced, smaller text.
#let quote-block(body, attribution: none) = block(
  inset: (left: 0.5in, right: 0.5in),
  below: 1em,
)[
  #set par(leading: 0.18in, justify: true)
  #set text(size: 11pt)
  #body
  #if attribution != none [
    #v(0.4em)
    #align(right)[--- #attribution]
  ]
]

// `code-block` renders a multi-line code block with a light gray
// background, a thin border, and single-spaced 9pt monospace lines.
// When a caption is supplied, the block becomes a numbered Code X.Y
// figure with a caption styled to match image-figure captions
// (left-aligned, justified, single-spaced, followed by the same visible
// gap before the next paragraph). Use this for every code reference in
// the document; replace any bare triple-backtick fence with code-block
// so the snippet can be cross-referenced as @code:label.
#let code-block(
  body,
  caption: none,
  alt: none,
) = {
  let panel = block(
    width: 100%,
    breakable: false,
    fill: rgb("#f6f6f6"),
    stroke: 0.5pt + rgb("#cccccc"),
    inset: (x: 0.15in, y: 0.1in),
    radius: 0pt,
  )[
    #context metadata((
      kind: "uofsc-etd-code-list-entry",
      label: [Code~#counter(figure.where(kind: raw)).display()],
      caption: caption,
      page: counter(page).display(),
      location: here(),
      outlined: caption != none,
    ))
    #set par(leading: 0.04in, justify: false, first-line-indent: 0pt)
    #set text(size: 9pt, font: "Latin Modern Mono")
    #set align(left)
    #body
  ]
  if caption == none {
    align(left, panel)
  } else {
    figure(align(left, panel), caption: caption, kind: raw, supplement: [Code])
  }
}
