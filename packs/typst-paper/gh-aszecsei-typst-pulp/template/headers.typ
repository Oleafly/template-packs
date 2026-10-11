// ============================================================================
// HEADERS
// Page header functions and chapter title tracking
// ============================================================================

#import "config.typ": header-font

// State to track the current chapter title
#let chapter-state = state("chapter-title", none)

// Common header layout function
#let running-header(left-content, center-content, right-content) = {
  set text(font: header-font, size: 9pt, tracking: 0.05em, style: "italic")
  grid(
    columns: (auto, 1fr, auto),
    align: (left, center, right),
    left-content,
    center-content,
    right-content,
  )
  v(0.1in)
}

// Left page header: book title centered, page number left-aligned
#let running-header-left(title, page-num) = {
  running-header(upper(str(page-num)), upper(title), [])
}

// Right page header: chapter title centered, page number right-aligned
#let running-header-right(chapter-title, page-num) = {
  running-header([], upper(chapter-title), upper(str(page-num)))
}

// Apply headers to pages
#let apply-headers(config) = {
  body => {
    set page(
      numbering: "1",
      header: context {
        let page-num = counter(page).get().first()
        let current-chapter = chapter-state.get()

        if calc.odd(page-num) {
          // Right pages: chapter title centered, page number right-aligned
          if current-chapter != none {
            running-header-right(current-chapter, page-num)
          } else {
            running-header-right(config.title, page-num)
          }
        } else {
          // Left pages: book title centered, page number left-aligned
          running-header-left(config.title, page-num)
        }
      },
      footer: none,
    )
    body
  }
}
