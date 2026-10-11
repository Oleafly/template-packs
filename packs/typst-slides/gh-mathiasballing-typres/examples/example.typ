#import "../lib.typ": *
// Use this for defaults
#show: typres-template.with()

// Or customize it
#show: typres-template.with(
  aspect-ratio: "16-9", // 16-9 or 4-3
  size: 20pt, // Size of text
  fg-color: black, // Text color
  bg-color: white, // Background color
  accent-fg-color: white, // Accent text color
  accent-bg-color: rgb("#000055"), // Accent background color
  padding: 1.5em, // Padding around the slide
  progress-indicator: "progress", // none, dots, count, progress
  show-notes: true, // Show speaker notes
)


// Built-in title slides
#title-slide(
  title: "Main Title",
  subtitle: "Subtitle",
  authors: "Mathias Balling",
  date: "01.01.2026",
)

// Built-in TOC
// This shows all sections (use new-section: true when making slides)
#toc-slide(title: "Outline")



// Defaults for making slides
#slide(
  title: none,
  new-section: false, // If it should be in the TOC
  progress-indicator: true, // Show progress indicator
  hide-header: false, // Should hide the section name
  padding: true, // Apply the padding around the slide
  count-slide: true, // Count the slide in the progress indicator
)[= Default]

#slide(title: "Placement", new-section: true)[
  #place(left + top)[= Top Left]
  #place(center + horizon)[= Center Horizon]
  #place(right + bottom)[= Bottom Right]
]

#slide(title: "Math", new-section: true, hide-header: true)[
  #place(center + horizon)[$ x=integral_1^5 x = sum $]
  #place(center + horizon, dy: 2.5cm)[$ x=integral_1^5 x = sum $]
  #place(left + top)[$ x=integral_1^5 x = sum $]
  #place(right + horizon, dx: -5cm)[$ x=integral_1^5 x = sum $]
]

#empty-slide(title: "Empty", new-section: true)[= Empty]

// Speaker notes (hide/show with show-notes option)
#note[Speaker notes]

// Show the other progress
#show: typres-template.with(
  progress-indicator: "dots", // none, dots, count, progress
)
#slide(title: "Progress Dots", new-section: true)[]

#show: typres-template.with(
  progress-indicator: "count", // none, dots, count, progress
)
#slide(title: "Progress Count", new-section: true)[]
