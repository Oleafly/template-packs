// Aviation Checklist Template
// 
// Michael Gunlock
// 

#let checklist(
  // Optional parameters that can be overridden
  head-left: none,
  head-center: none,
  head-right: none,
  foot: none,
  font: none,
  body
) = {
  // Page setup - A5, two columns, margins
  set page(
    paper: "a5",
    margin: (top: 2cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    columns: 2,
    header: [
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        head-left, head-center, head-right
      )
    ],
    footer: if foot != none {
      align(center, foot)
    }
  )

  // Font setup - conditionally set font if provided
  if font != none {
    set text(font: font, size: 10pt, hyphenate: false)
    set par(justify: false, leading: 0.5em, spacing: 0.5em)
    body
  } else {
    set text(size: 10pt, hyphenate: false)
    set par(justify: false, leading: 0.5em, spacing: 0.5em)
    body
  }
}

// Section with colored title and content
// Default: black background, white text
// Optional bg, fg, spacing-above, and spacing-below arguments
#let section(title, content, bg: black, fg: white, spacing-above: 0.3em, spacing-below: 0.3em) = {
  block(
    width: 100%,
    fill: bg,
    inset: (x: 3pt, y: 5pt),
    align(center, text(fill: fg, title)),
    above: spacing-above,
    below: spacing-below, 
  )
  content
}

// Convenience functions for colored sections
#let section-black(..args) = section(..args, bg:black)
#let section-blue(..args) = section(..args, bg: blue)
#let section-yellow(..args) = section(..args, bg: yellow, fg: black)
#let section-red(..args) = section(..args, bg: red)

// Checklist item with dotfill
// Usage: #cl[Item description][Value]
// Optional indent, spacing-above, and spacing-below parameters
#let item(description, value, indent: 0pt, spacing-above: 0.3em, spacing-below: 0.3em) = {
  block(above: spacing-above, below: spacing-below)[
    #h(indent)
    #text(size: 0.9em)[
      #description
      #box(width: 1fr, repeat[.])
      #value
    ]
  ]
}

// Note (like cl but without dotfill)
#let note(content, indent: 12pt, size: 0.9em, spacing-above:0.3em, spacing-below:0.3em) = {
  block(above: spacing-above, below: spacing-below)[
    #h(indent)
    #text(size: size, content)
  ]
}

// Empty line (for spacing)
// Optoinal count (repeat count), spacing-above, and spacing-below argments
#let emptyline(count: 1, spacing-above: 0.4em, spacing-below: 0.4em ) = {
  for _ in range(count) {
    block(above: spacing-above, below: spacing-below)[
    ]
  }
}
