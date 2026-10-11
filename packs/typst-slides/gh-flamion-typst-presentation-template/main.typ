#import "@preview/touying:0.6.2": *
#import themes.university: *
#import "@preview/zeitline:0.1.0": timeline
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// ==========================================
// Theme Colors
// ==========================================

// 1. Semantic Color Definitions
#let color-primary      = rgb("#00d4ff")  // Bright Cyan
#let color-secondary    = rgb("#00ff9d")  // Green
#let color-accent       = rgb("#a78bfa")  // Electric purple

#let color-completed    = color-primary
#let color-current      = color-secondary
#let color-future       = rgb("#4a5568")  // Muted Grey

#let color-text         = rgb("#b8c5d6")  // Light Grey for descriptions & lists
#let color-text-light   = rgb("#e8edf5")  // Neutral lightest / main body text
#let color-text-white   = rgb("#ffffff") 
#let color-text-muted   = rgb("#7a8ba3")  // Darker muted text (e.g., footers, dates)

#let color-line         = rgb("#2d3b52")  // Dark background line

// 2. Background / Gradient Colors
#let color-bg-darkest   = rgb("#050814")  // Deepest background shade
#let color-bg-slide     = rgb("#0a0e1a")  // Main slide background
#let color-bg-light     = rgb("#141b2d")  // Lighter background (code blocks, gradients)
#let color-bg-lighter   = rgb("#1a2338")  // Lightest background (code blocks)

// Helper functions for pre-configured text

#let default-text-size = 26pt

#let slide-text(content) = text(fill: color-text, size: default-text-size)[#content]
#let slide-text-light(content) = text(fill: color-text-light, size: default-text-size)[#content]
#let slide-text-white(content) = text(fill: color-text-white, size: default-text-size)[#content]

// Text functions for the timeline slide
#let text-completed(content) = text(fill: color-completed, weight: "bold", size: 14pt)[#content]
#let text-current(content)   = text(fill: color-current, weight: "bold", size: 14pt)[#content]
#let text-future(content)    = text(fill: color-future, weight: "bold", size: 14pt)[#content]

#let desc-active(content)    = text(fill: color-text, size: 12pt)[#content]
#let desc-future(content)    = text(fill: color-future, size: 12pt)[#content]


// Custom dark theme configuration
#let dark-theme = university-theme.with(
  aspect-ratio: "16-9",
  config-common(
    // Custom dark colors - Cyan/Purple/Slate palette
    primary: color-primary,      // Bright cyan (left footer)
    secondary: color-secondary,  // Keep green for content
  ),
  // The stuff here will appear at the bottom of the slides & in the PDF metadata
  config-info(
    title: [Your Presentation Title],
    subtitle: [Your Subtitle Here],
    author: [Your Name],
    date: datetime.today(),
    institution: [],
  ),
  config-colors(
    primary: color-primary,            // Cyan (left footer section)
    secondary: color-accent,           // Electric purple (middle footer section)
    neutral-lightest: color-text-light,
    neutral-darkest: color-bg-slide,
  ),
)

// Add syntax highlighting for opencypher queries (```cypher...)
#set raw(syntaxes: "Cypher.sublime-syntax")

#show: dark-theme

// Override background and text colors
#set page(fill: color-bg-slide)
#set text(fill: color-text-light, font: "Roboto Mono")

// Custom code block styling
#show raw.where(block: true): it => {
  set text(font: "Fira Code", size: 14pt)
  block(
    fill: gradient.linear(
      color-bg-light, 
      color-bg-lighter,
      angle: 135deg
    ),
    stroke: 1pt + color-line,
    radius: 8pt,
    inset: 12pt,
    width: 100%,
    it
  )
}

#show raw.where(block: false): it => {
  set text(font: "Fira Code", fill: color-primary)
  it
}


// ==========================================
// Reusable Horizontal Timeline Function
// ==========================================
#let h-timeline(..items) = {
  // Extract the positional arguments (the dictionaries)
  let timeline-data = items.pos()
  let column-count = timeline-data.len()
  
  // Failsafe: Don't render if empty
  if column-count == 0 { return }
  
  let dynamic-columns = (1fr,) * column-count

  grid(
    columns: dynamic-columns,
    rows: (auto, 4em, auto),
    align: center + horizon,
    
    // Row 1: Titles & Descriptions
    ..timeline-data.map(item => {
      if item.status == "completed" [
        #text-completed(item.title) \ #desc-active(item.desc)
      ] else if item.status == "current" [
        #text-current(item.title) \ #desc-active(item.desc)
      ] else [
        #text-future(item.title) \ #desc-future(item.desc)
      ]
    }),
    
    // Row 2: The Continuous Line & Markers
    ..for (i, item) in timeline-data.enumerate() {
      let marker-color = if item.status == "completed" { color-completed } 
                         else if item.status == "current" { color-current } 
                         else { color-future }
                         
      let line-color = if item.status == "completed" { color-completed } else { color-line }
      
      (box(width: 100%, height: 100%, [
        // Draw connecting line (except for the very last item)
        #if i < column-count - 1 {
          place(horizon, dx: 50%, line(length: 100%, stroke: 3pt + line-color))
        }
        // The timeline dot
        #place(center + horizon, circle(radius: 0.5em, fill: color-bg-slide, stroke: 3pt + marker-color))
      ]),)
    },
    
    // Row 3: Dates / Quarters
    ..timeline-data.map(item => {
      if item.status == "completed" { text-completed(item.date) }
      else if item.status == "current" { text-current(item.date) }
      else { text-future(item.date) }
    })
  )
}

// Make labels on headings render their title instead of number
// i.e. 
// = Cool Title <cool-title>
// @cool-title => 'Cool Title' instead of 1.0
#show ref: it => {
  let el = it.element
  // Check if the label is attached to an element, and if it's a heading
  if el != none and el.func() == heading {
    link(it.target, el.body)
  } else {
    it
  }
}

//
// CONFIG END
// 


// ==========================================
// Sample Slides - One per feature
// ==========================================


// Title Slide; Gradient background with centered text
#slide[
  #set align(center + horizon)
  #set page(fill: gradient.linear(
    color-bg-darkest,
    color-bg-slide,
    color-bg-light,
    angle: 135deg
  ))

  #text(size: 48pt, weight: "bold", fill: color-primary)[
    Sample Presentation Title
  ]

  #v(0.5em)

  #text(size: 20pt, fill: color-text)[
    A brief subtitle
  ]
]

#speaker-note[
  Speaker notes appear here. They are visible in presenter mode
  or when exporting to HTML via touying-exporter.
]


= Introduction


// Overview slide; Cross-references via @label link to other sections
// The labels are optional, however, they keep the text here in sync with
// the title, so that's quite useful
== Overview

#slide-text-light[
  - @features
  - @diagrams
  - @schema-diagram
  - @timeline-demo
  - @conclusion
]

#speaker-note[
  Use `= Section Title <label>` to create a label, then `\@label` to link to it.
  The custom ref override renders the heading title instead of a number.
]


// Section heading with label (for cross-referencing)
= Features <features>


// Bullet Lists; slide-text-white / slide-text-light / slide-text variants
== Bullet Lists

#slide-text-white[
  - First level bullet point
    - Second level with more detail
    - Another sub-point
  - Another first level point
]

#v(1em)

#slide-text-light[
  Use `slide-text-white`, `slide-text-light`, or `slide-text` for different emphasis.
]

#speaker-note[
  Three helper functions provide pre-configured text styles for slides.
]


// Centered Statement; Large single statement
== Centered Statement

#align(center + horizon)[
  #text(size: 36pt, weight: "bold", fill: color-primary)[
    A centered statement.
  ]
]

#speaker-note[
  Use `align(center + horizon)` for impactful single-line slides.
]


// Code Blocks; Syntax-highlighted code (Rust example)
== Code Blocks

```rust
fn fibonacci(n: u64) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn main() {
    for i in 0..10 {
        println!("fib({}) = {}", i, fibonacci(i));
    }
}
```

#speaker-note[
  Code blocks support syntax highlighting for many languages.
  Custom syntaxes can be added via `.sublime-syntax` files
  (see `Cypher.sublime-syntax` for an example).
]


// Diagrams; Simple Fletcher node-edge diagram
== Diagrams <diagrams>

#align(center + horizon)[#diagram(
  node-fill: gradient.linear(color-bg-light, color-bg-lighter, angle: 135deg),
  node-inset: 14pt,
  node-corner-radius: 8pt,
  spacing: 3em,

  node((0, 0), text(fill: color-text-white)[Client], stroke: 2pt + color-primary),

  edge((0, 0), (1, 0), "-|>", stroke: 2pt + color-primary,
    label: text(fill: color-text-white, size: 14pt)[request],
    label-fill: none,
    label-side: left,
  ),

  node((1, 0), text(fill: color-text-white)[Server], stroke: 2pt + color-secondary),

  edge((1, 0), (2, 0), "-|>", stroke: 2pt + color-secondary,
    label: text(fill: color-text-white, size: 14pt)[query],
    label-fill: none,
    label-side: left,
  ),

  node((2, 0), text(fill: color-text-white)[Database], stroke: 2pt + color-accent),
)]

#speaker-note[
  Diagrams are built with the Fletcher library.
  Nodes use the same gradient background as code blocks for consistency.
]


// Schema Diagram; Fletcher with embedded tables (relational schema)
== Schema Diagram <schema-diagram>

#align(center + horizon)[#diagram(
  node-fill: gradient.linear(color-bg-light, color-bg-lighter, angle: 135deg),
  spacing: 4em,

  // Users table
  node((0, 0), [
    #set text(size: 14pt)
    #table(
      columns: (auto, auto),
      stroke: none,
      row-gutter: 0.6em,
      table.cell(colspan: 2, align: center)[#text(fill: color-primary, weight: "bold", size: 18pt)[users]],
      table.hline(stroke: 1pt + color-line),
      text(fill: color-accent, weight: "bold")[PK], text(fill: color-text-white)[id],
      [], text(fill: color-text-light)[name],
      [], text(fill: color-text-light)[email],
    )
  ], shape: "rect", corner-radius: 8pt, inset: 12pt, stroke: 2pt + color-primary, name: <users>),

  // Posts table
  node((1.5, 0), [
    #set text(size: 14pt)
    #table(
      columns: (auto, auto),
      stroke: none,
      row-gutter: 0.6em,
      table.cell(colspan: 2, align: center)[#text(fill: color-secondary, weight: "bold", size: 18pt)[posts]],
      table.hline(stroke: 1pt + color-line),
      text(fill: color-accent, weight: "bold")[PK], text(fill: color-text-white)[id],
      text(fill: color-accent, weight: "bold")[FK], text(fill: color-text-white)[user_id],
      [], text(fill: color-text-light)[title],
      [], text(fill: color-text-light)[content],
    )
  ], shape: "rect", corner-radius: 8pt, inset: 12pt, stroke: 2pt + color-secondary, name: <posts>),

  // Comments table
  node((3, 0), [
    #set text(size: 14pt)
    #table(
      columns: (auto, auto),
      stroke: none,
      row-gutter: 0.6em,
      table.cell(colspan: 2, align: center)[#text(fill: color-accent, weight: "bold", size: 18pt)[comments]],
      table.hline(stroke: 1pt + color-line),
      text(fill: color-accent, weight: "bold")[PK], text(fill: color-text-white)[id],
      text(fill: color-accent, weight: "bold")[FK], text(fill: color-text-white)[post_id],
      [], text(fill: color-text-light)[body],
      [], text(fill: color-text-muted)[created_at],
    )
  ], shape: "rect", corner-radius: 8pt, inset: 12pt, stroke: 2pt + color-accent, name: <comments>),

  // Foreign key edges
  edge(<posts>, <users>, "-|>", stroke: 2pt + color-future),
  edge(<comments>, <posts>, "-|>", stroke: 2pt + color-future),
)]

#speaker-note[
  Embed Typst tables inside Fletcher nodes to create schema diagrams.
  FK arrows show relationships between tables.
]


// Timeline; Horizontal timeline with status indicators
== Timeline <timeline-demo>

#v(0.25em)

#align(center)[(Sample project timeline)]

#h-timeline(
  (status: "completed", date: "Jan", title: "Research", desc: "Literature review"),
  (status: "completed", date: "Feb", title: "Design", desc: "Architecture & planning"),
  (status: "current",   date: "Mar", title: "Implementation", desc: "Core features"),
  (status: "future",    date: "Apr", title: "Testing", desc: "QA & bug fixes"),
  (status: "future",    date: "May", title: "Launch", desc: "Release v1.0"),
)

#speaker-note[
  The `h-timeline` function renders a horizontal timeline.
  Each item needs: status ("completed" / "current" / "future"), date, title, desc.
]


= Conclusion <conclusion>


// Closing Slide; Gradient background with centered text
== Questions?

#slide[
  #set align(center + horizon)
  #set page(fill: gradient.linear(
    color-bg-darkest,
    color-bg-slide,
    color-bg-light,
    angle: 135deg
  ))

  #text(size: 48pt, weight: "bold", fill: color-primary)[
    Questions?
  ]

  #v(1em)

  #text(size: 20pt, fill: color-text)[
    Thank you for your attention!
  ]
]

#speaker-note[
  Open questions
]
