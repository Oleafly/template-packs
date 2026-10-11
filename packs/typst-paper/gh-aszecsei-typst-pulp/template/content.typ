// ============================================================================
// CONTENT ELEMENTS
// Chapter headings, parts, scene breaks, and epigraphs
// ============================================================================

#import "config.typ": display-font
#import "headers.typ": chapter-state

// --- CHAPTER OPENING ---
// Helper function for the opening paragraph of a chapter
// Capitalizes the first three words and removes indent
#let chapter-opening(content) = {
  set par(first-line-indent: 0pt)
  content
}

// --- SCENE BREAK ---
#let scene-break() = {
  v(0.6em)
  align(center)[
    #text(size: 9pt, tracking: 0.2em)[∗ ∗ ∗]
  ]
  v(0.6em)
  par(first-line-indent: 0pt)[]
}

// --- CHAPTER HEADING ---
#let chapter(number, title: none) = {
  pagebreak(weak: true)
  // Update the chapter state for headers
  let chapter-text = if title != none {
    title
  } else {
    "Chapter " + str(number)
  }
  chapter-state.update(chapter-text)

  v(0.5in)
  align(center)[
    #text(
      font: display-font,
      size: 8pt,
      tracking: 0.15em,
      weight: "regular",
    )[CHAPTER]
    #v(0.2em)
    #text(
      font: display-font,
      size: 20pt,
      weight: "bold",
    )[#number]
    #if title != none {
      v(0.3em)
      text(
        font: display-font,
        size: 9pt
      )[#title]
    }
  ]
  hide(heading("CHAPTER " + str(number) + ": " + title, depth: 2))
}

// --- PART HEADING ---
#let part(number, title) = {
  pagebreak(weak: true)
  // Disable header for part page
  set page(header: none)
  v(1.5in)
  align(center)[
    #text(
      font: display-font,
      size: 7.5pt,
      tracking: 0.2em,
    )[PART #number]
    #v(0.4em)
    #text(
      font: display-font,
      size: 13pt,
      weight: "bold",
      tracking: 0.06em,
    )[#upper(title)]
  ]
  hide(heading("PART " + number + ": " + title))
  pagebreak()
}

// --- EPIGRAPH ---
#let epigraph(quote, attribution) = {
  align(right)[
    #pad(left: 7em, right: 0.8em)[
      #set text(size: 8.5pt, style: "italic")
      #set par(justify: false)
      #quote
      #v(0.2em)
      #text(style: "normal", size: 8pt)[— #attribution]
    ]
  ]
  v(1em)
}
