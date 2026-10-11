// ============================================================================
// BACK MATTER
// About the author, also by, teaser pages, and advertisements
// ============================================================================

#import "config.typ": display-font

// --- ABOUT THE AUTHOR ---
#let about-author(bio) = {
  pagebreak(weak: true)
  set page(header: none)
  v(0.8in)
  align(center)[
    #text(
      font: display-font,
      size: 8pt,
      tracking: 0.15em,
    )[ABOUT THE AUTHOR]
  ]
  v(0.6em)
  set text(size: 8.5pt)
  bio
}

// --- ALSO BY ---
#let also-by(author, books) = {
  pagebreak(weak: true)
  set page(header: none)
  v(0.8in)
  align(center)[
    #text(
      font: display-font,
      size: 7.5pt,
      tracking: 0.12em,
    )[ALSO BY #upper(author)]
  ]
  v(0.6em)
  align(center)[
    #set text(size: 8.5pt, style: "italic")
    #for book in books {
      book
      linebreak()
      v(0.1em)
    }
  ]
}

// --- TEASER PAGES (common in pulp paperbacks) ---
#let teaser-page(text-content) = {
  set page(numbering: none)
  v(0.4in)
  set text(size: 8.5pt)
  set par(leading: 0.5em)
  text-content
  v(1fr)
  align(center)[
    #text(size: 6.5pt, tracking: 0.08em)[TURN THE PAGE FOR A PREVIEW...]
  ]
}

// --- ADVERTISEMENT PAGE (back matter) ---
#let ad-page(headline, body-text) = {
  set page(numbering: none)
  v(0.4in)
  align(center)[
    #text(
      font: display-font,
      size: 10pt,
      weight: "bold",
      tracking: 0.06em,
    )[#upper(headline)]
  ]
  v(0.6em)
  set text(size: 8pt)
  body-text
}
