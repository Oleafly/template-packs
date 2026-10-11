#let manuscript(
  title: [Title],
  author: [Author Name],
  last-name: [Last Name],
  contact-info: [],
  word-count: [0],
  body
) = {
  // 1. General Page Setup
  set page(
    paper: "us-letter",
    margin: 1in,
    header: context {
      // Headers (Page 2 onwards)
      if here().page() > 1 {
        set text(font: ("Courier Prime"), size: 12pt)
        align(right)[
          #upper(last-name) / #upper(title) / #counter(page).display()
        ]
      }
    },
    header-ascent: 0.5in,
  )

  // 2. Text Styling
  set text(
    font: ("Courier Prime"),
    size: 12pt,
    fallback: true,
  )
  
  // Double-spaced (Typst leading is space between lines, 
  // so we set line spacing to 2.0em or use par spacing)
  set par(
    leading: 1.2em, // Adjusting for "Double Spaced" look in Courier
    justify: false, // Left-aligned (ragged right)
    first-line-indent: 0.5in,
  )

  // 3. Title Page (Page 1)
  {
    // Contact Info (Top-left)
    place(top + left, contact-info)
    
    // Word Count (Top-right)
    place(top + right, [Approx. #word-count words])
    
    // Vertically centered title/author
    align(center + horizon)[
      #upper(title) \
      by \
      #author
    ]
    
    pagebreak()
  }

  // Reset page counter after title page
  counter(page).update(1)
  
  // 4. Content Logic
  body
}

// 5. Chapter Heading Helper
#let chapter(title) = {
  pagebreak(weak: true)
  v(1.33in) // Move down approx 1/3 of the page
  align(center)[
    #title
  ]
  v(2em) // Drop down two double-spaced lines
}

// 6. Scene Break Helper
#let scenebreak() = {
  align(center)[
    #v(1em)
    \#
    #v(1em)
  ]
}

// 7. End Helper
#let end() = {
  align(center)[
    #v(1em)
    END
  ]
}
