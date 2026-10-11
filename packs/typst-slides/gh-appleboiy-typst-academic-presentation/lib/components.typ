// General reusable components for presentations

// Paper image wrapper that automatically fits images to constrained size
#let paper-image(img-content, width: 100%, height: auto, fit: "contain") = {
  box(
    width: width,
    height: height,
    clip: false,
    img-content
  )
}

// Paper figure with automatic image fitting and caption
#let paper-figure(img-content, caption: none, max-height: none) = {
  let img = if max-height != none {
    box(
      width: 100%,
      height: max-height,
      clip: false,
      img-content
    )
  } else {
    img-content
  }
  
  if caption != none {
    figure(img, caption: caption)
  } else {
    img
  }
}

// Slide split layout for side-by-side content
#let slide-split(left-content, right-content, proportion: (1fr, 1fr)) = {
  grid(
    columns: proportion,
    gutter: 2em, // Generous spacing so columns don't bleed into each other
    align: (left + horizon, left + horizon),
    left-content,
    right-content
  )
}

// Academic insight/takeaway box with Computer Modern font
#let paper-insight(body) = {
  block(
    width: 100%,
    fill: luma(240),
    stroke: (left: 3pt + black), // Heavy left anchor
    inset: (x: 12pt, y: 10pt),
    radius: 0pt,
    {
      text(font: "New Computer Modern", weight: "bold", size: 0.9em)[TAKEAWAY: ]
      text(font: "New Computer Modern", style: "italic", size: 0.9em)[#body]
    }
  )
}

// Slide content wrapper to prevent overflow
// Use this to wrap slide content and ensure it stays within boundaries
#let slide-content(
  max-height: 85%, // Maximum height relative to slide
  body
) = {
  block(
    width: 100%,
    height: max-height,
    clip: false, // Don't clip, but constrain layout
    {
      // Use a container that respects height limits
      box(
        width: 100%,
        height: 100%,
        {
          // Set text to be more compact if needed
          set par(leading: 0.55em, spacing: 0.55em)
          set block(spacing: 0.55em)
          body
        }
      )
    }
  )
}

// Auto-scaling content wrapper that shrinks text if content is too large
#let auto-fit-content(
  max-height: 85%,
  min-scale: 0.7, // Minimum scale factor (70%)
  body
) = {
  // This wrapper will attempt to fit content by reducing spacing and size
  block(
    width: 100%,
    {
      set par(leading: 0.5em, spacing: 0.5em)
      set block(spacing: 0.5em)
      body
    }
  )
}

// Two-column layout with compact spacing
#let two-columns(left, right, ratio: 50%) = {
  let left-width = ratio
  let right-width = 100% - ratio
  
  grid(
    columns: (left-width, right-width),
    gutter: 0.8em,
    [#left],
    [#right]
  )
}

// Three-column layout with compact spacing
#let three-columns(col1, col2, col3) = {
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    [#col1],
    [#col2],
    [#col3]
  )
}

// Image with caption
#let captioned-image(path, caption, width: 70%) = {
  figure(
    image(path, width: width),
    caption: caption
  )
}

// Image grid (2x2, 3x3, etc.)
#let image-grid(images, columns: 2, captions: ()) = {
  grid(
    columns: (1fr,) * columns,
    gutter: 1em,
    ..images.enumerate().map(((i, img)) => {
      let cap = if i < captions.len() { captions.at(i) } else { none }
      if cap != none {
        figure(image(img, width: 100%), caption: cap)
      } else {
        image(img, width: 100%)
      }
    })
  )
}

// Highlight box
#let highlight-box(body, color: yellow) = {
  block(
    fill: color.lighten(80%),
    inset: 10pt,
    radius: 4pt,
    stroke: 1pt + color,
  )[
    #body
  ]
}

// Callout box with type-based styling (info, warning, danger, success)
#let callout(type: "info", title: none, body) = {
  // Define color palettes for different callout types
  let colors = (
    info: (bg: rgb("#e8f4fd"), border: rgb("#2196f3")),    // Blue
    warning: (bg: rgb("#fff8e1"), border: rgb("#ffc107")), // Amber/Yellow
    danger: (bg: rgb("#ffebee"), border: rgb("#f44336")),  // Red
    success: (bg: rgb("#e8f5e9"), border: rgb("#4caf50"))  // Green
  )
  
  // Default to 'info' if an unknown type is passed
  let theme = colors.at(type, default: colors.info)
  
  block(
    width: 100%,
    fill: theme.bg,
    stroke: (left: 4pt + theme.border), // Thick left accent line
    radius: (right: 4pt), // Only round the right corners
    inset: 10pt, // Reduced from 12pt
    {
      // Optional Title
      if title != none {
        text(fill: theme.border.darken(30%), weight: "bold", size: 1em)[#title]
        v(4pt, weak: true) // Reduced spacing
      }
      
      // The main content
      set text(size: 0.95em) // Slightly smaller text
      body
    }
  )
}

// Highlight box
#let side-note(body) = {
  block(
    fill: rgb("#fffbf0"),
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#ffc107"),
  )[
    #text(size: 9pt, style: "italic")[#body]
  ]
}

// Bullet points with custom marker
#let custom-list(items, marker: "→") = {
  for item in items [
    #marker #h(0.5em) #item \
  ]
}

// Numbered steps
#let steps(..items) = {
  let steps = items.pos()
  for (i, step) in steps.enumerate() [
    #text(weight: "bold", fill: blue)[Step #(i + 1):] #step
    #v(0.5em)
  ]
}

// Professional feature comparison with booktabs-style framing
#let paper-feature-comparison(feature, old, new) = {
  block(
    width: 100%,
    stroke: (top: 1pt + black, bottom: 1pt + black), // booktabs-style framing
    inset: (y: 8pt, x: 4pt), // Reduced vertical padding
    {
      // Formal smallcaps-style header
      text(weight: "bold", size: 1em)[FEATURE: #feature]
      v(4pt)
      
      grid(
        columns: (1fr, 1fr),
        gutter: 12pt, // Reduced gutter
        
        // Baseline Column
        block(
          width: 100%,
          stroke: (right: 0.5pt + luma(150)), // Subtle separator
          inset: (right: 10pt)
        )[
          #text(style: "italic", size: 0.9em)[Baseline Implementation]
          #v(3pt)
          #text(size: 0.9em)[#old]
        ],
        
        // Proposed Column
        block(width: 100%)[
          #text(weight: "bold", size: 0.9em)[Proposed Architecture]
          #v(3pt)
          #text(size: 0.9em)[#new]
        ]
      )
    }
  )
}

// Professional pros and cons comparison with booktabs-style table
#let paper-pros-cons(pros, cons) = {
  block(
    width: 100%,
    stroke: 0.8pt + black, // Sharp outer border
    radius: 0pt, // Sharp corners, no web-like rounding
    clip: true,
    table(
      columns: (1fr, 1fr),
      stroke: (col, row) => (
        right: if col == 0 { 0.8pt + black } else { none },
        bottom: if row == 0 { 0.8pt + black } else { none }
      ),
      align: left + top,
      
      // Formal Headers
      table.cell(inset: 6pt, fill: luma(245))[
        #text(weight: "bold", size: 0.95em)[Advantages]
      ],
      table.cell(inset: 6pt, fill: luma(245))[
        #text(weight: "bold", size: 0.95em)[Limitations]
      ],
      
      // Content Cells
      table.cell(inset: 8pt)[
        #set text(size: 0.9em)
        #set list(spacing: 0.4em)
        #pros
      ],
      table.cell(inset: 8pt)[
        #set text(size: 0.9em)
        #set list(spacing: 0.4em)
        #cons
      ]
    )
  )
}

// Section divider
#let section-divider(title) = {
  v(2em)
  align(center)[
    #line(length: 100%, stroke: 2pt + gray)
    #v(0.5em)
    #text(size: 18pt, weight: "bold")[#title]
    #v(0.5em)
    #line(length: 100%, stroke: 2pt + gray)
  ]
  v(2em)
}

// Footer note
#let footer-note(body) = {
  v(1fr)
  align(center)[
    #text(size: 8pt, fill: gray, style: "italic")[#body]
  ]
}
