// =============================================================================
// BACK-MATTER.TYP - Back matter components for books
// =============================================================================

// =============================================================================
// AUTHOR INTERVIEW SECTION
// =============================================================================

/// Q&A entry for author interview
#let interview-qa(question, answer) = {
  block(spacing: 1em)[
    #text(weight: "bold")[Q: #question]
    #v(0.5em)
    #text(style: "normal")[A: #answer]
  ]
}

/// Author interview section
#let author-interview(
  title: "A Conversation with the Author",
  intro: none,
  questions: (),
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  if intro != none {
    text(style: "italic")[#intro]
    v(1.5em)
  }
  
  for qa in questions {
    interview-qa(qa.question, qa.answer)
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// BOOK CLUB QUESTIONS
// =============================================================================

/// Book club discussion questions
#let book-club-questions(
  title: "Discussion Questions",
  intro: none,
  questions: (),
  categories: none,
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  if intro != none {
    text(style: "italic", size: 0.95em)[#intro]
    v(1.5em)
  }
  
  if categories != none {
    // Questions organized by category
    for (cat-name, cat-questions) in categories {
      text(weight: "semibold", size: 1.1em)[#cat-name]
      v(0.5em)
      
      for (i, q) in cat-questions.enumerate() {
        [#(i + 1). #q]
        v(0.5em)
      }
      v(1em)
    }
  } else {
    // Simple numbered list
    for (i, q) in questions.enumerate() {
      [#(i + 1). #q]
      v(0.5em)
    }
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// SNEAK PEEK / EXCERPT
// =============================================================================

/// Sneak peek chapter from next book
#let sneak-peek(
  title: "Sneak Peek",
  book-title: none,
  coming: none,
  content,
) = {
  set page(numbering: none)
  
  v(2em)
  
  align(center)[
    #text(size: 1.2em, tracking: 0.1em)[#upper(title)]
    
    #if book-title != none {
      v(0.5em)
      text(size: 1.5em, weight: "bold", style: "italic")[#book-title]
    }
    
    #if coming != none {
      v(0.3em)
      text(size: 0.9em, fill: rgb("#666"))[#coming]
    }
  ]
  
  v(2em)
  line(length: 30%, stroke: 0.5pt + rgb("#999"))
  v(2em)
  
  content
  
  pagebreak(weak: true)
}

// =============================================================================
// EXTENDED BIBLIOGRAPHY STYLES
// =============================================================================

/// Annotated bibliography entry
#let bib-entry-annotated(citation, annotation) = {
  block(spacing: 1em)[
    #set par(hanging-indent: 1.5em)
    #citation
    #v(0.3em)
    #text(size: 0.9em, style: "italic")[#annotation]
  ]
}

/// Annotated bibliography section
#let bibliography-annotated(
  title: "Annotated Bibliography",
  entries: (),
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  for entry in entries {
    bib-entry-annotated(entry.citation, entry.annotation)
  }
  
  pagebreak(weak: true)
}

/// Categorized bibliography
#let bibliography-categorized(
  title: "Bibliography",
  categories: (:),
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  for (cat-name, entries) in categories {
    text(weight: "semibold", size: 1.1em)[#cat-name]
    v(0.5em)
    
    set par(hanging-indent: 1.5em)
    for entry in entries {
      [#entry]
      v(0.3em)
    }
    v(1em)
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// RESOURCE LIST
// =============================================================================

/// Resource entry with URL
#let resource-entry(title, url: none, description: none) = {
  block(spacing: 0.8em)[
    #text(weight: "semibold")[#title]
    #if url != none {
      v(0.2em)
      text(size: 0.9em, fill: rgb("#0066cc"))[#link(url)[#url]]
    }
    #if description != none {
      v(0.2em)
      text(size: 0.9em)[#description]
    }
  ]
}

/// Resource list page
#let resource-list(
  title: "Resources & Further Reading",
  intro: none,
  resources: (),
  categories: none,
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  if intro != none {
    text(style: "italic")[#intro]
    v(1.5em)
  }
  
  if categories != none {
    for (cat-name, cat-resources) in categories {
      text(weight: "semibold", size: 1.1em)[#cat-name]
      v(0.5em)
      
      for res in cat-resources {
        resource-entry(
          res.title,
          url: res.at("url", default: none),
          description: res.at("description", default: none),
        )
      }
      v(1em)
    }
  } else {
    for res in resources {
      resource-entry(
        res.title,
        url: res.at("url", default: none),
        description: res.at("description", default: none),
      )
    }
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// PERMISSIONS / CREDITS PAGE
// =============================================================================

/// Single credit entry
#let credit-entry(item, source, permission: none) = {
  block(spacing: 0.8em)[
    #text(weight: "medium")[#item]
    #v(0.2em)
    #text(size: 0.9em)[#source]
    #if permission != none {
      text(size: 0.85em, fill: rgb("#666"))[ — #permission]
    }
  ]
}

/// Permissions and credits page
#let credits-page(
  title: "Permissions & Credits",
  intro: none,
  credits: (),
  categories: none,
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  if intro != none {
    text(size: 0.9em)[#intro]
    v(1.5em)
  }
  
  if categories != none {
    for (cat-name, cat-credits) in categories {
      text(weight: "semibold", size: 1.05em)[#cat-name]
      v(0.5em)
      
      for credit in cat-credits {
        credit-entry(
          credit.item,
          credit.source,
          permission: credit.at("permission", default: none),
        )
      }
      v(1em)
    }
  } else {
    for credit in credits {
      credit-entry(
        credit.item,
        credit.source,
        permission: credit.at("permission", default: none),
      )
    }
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// GLOSSARY STYLES (Extended)
// =============================================================================

/// Inline glossary term (definition appears inline)
#let glossary-inline(term, definition) = {
  [#text(weight: "bold")[#term]: #definition]
}

/// Sidebar-style glossary entry
#let glossary-sidebar-entry(term, definition, see-also: none) = {
  box(
    width: 100%,
    fill: rgb("#f8f8f8"),
    stroke: (left: 3pt + rgb("#ddd")),
    inset: 8pt,
    radius: (right: 4pt),
  )[
    #text(weight: "bold", size: 0.95em)[#term]
    #v(0.3em)
    #text(size: 0.9em)[#definition]
    #if see-also != none {
      v(0.3em)
      text(size: 0.85em, style: "italic", fill: rgb("#666"))[See also: #see-also]
    }
  ]
  v(0.5em)
}

/// Multi-column glossary
#let glossary-columns(
  title: "Glossary",
  entries: (),
  cols: 2,
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  let sorted = entries.sorted(key: e => upper(e.term))
  
  columns(cols, gutter: 2em)[
    #for entry in sorted {
      text(weight: "bold")[#entry.term]
      h(0.5em)
      text(size: 0.95em)[#entry.definition]
      v(0.5em)
    }
  ]
  
  pagebreak(weak: true)
}

// =============================================================================
// ENDNOTES SYSTEM
// =============================================================================

/// Chapter endnotes section
#let chapter-endnotes(chapter-num, notes: ()) = {
  if notes.len() > 0 {
    text(weight: "semibold", size: 1.05em)[Chapter #chapter-num]
    v(0.5em)
    
    for (i, note) in notes.enumerate() {
      grid(
        columns: (auto, 1fr),
        gutter: 0.5em,
        text(size: 0.85em, weight: "medium")[#(i + 1).],
        text(size: 0.9em)[#note],
      )
      v(0.3em)
    }
    v(1em)
  }
}

/// Full endnotes section
#let endnotes-section(
  title: "Notes",
  chapters: (),
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  for (chapter-num, notes) in chapters {
    chapter-endnotes(chapter-num, notes: notes)
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// ERRATA PAGE
// =============================================================================

/// Single erratum entry
#let erratum-entry(location, error, correction) = {
  grid(
    columns: (auto, 1fr, 1fr),
    gutter: 1em,
    align: (left, left, left),
    text(size: 0.9em, weight: "medium")[#location],
    text(size: 0.9em)[For: #emph[#error]],
    text(size: 0.9em)[Read: #emph[#correction]],
  )
  v(0.5em)
}

/// Errata page
#let errata-page(
  title: "Errata",
  edition: none,
  intro: none,
  errata: (),
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  
  if edition != none {
    text(size: 0.9em, style: "italic")[#edition]
    v(0.5em)
  }
  
  if intro != none {
    text(size: 0.9em)[#intro]
    v(1em)
  }
  
  // Header row
  grid(
    columns: (auto, 1fr, 1fr),
    gutter: 1em,
    text(size: 0.85em, weight: "bold")[Location],
    text(size: 0.85em, weight: "bold")[Error],
    text(size: 0.85em, weight: "bold")[Correction],
  )
  line(length: 100%, stroke: 0.5pt + black)
  v(0.5em)
  
  for err in errata {
    erratum-entry(err.location, err.error, err.correction)
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// INDEX IMPROVEMENTS
// =============================================================================

/// Index entry with sub-entries
#let index-entry-complex(
  term,
  pages: none,
  sub-entries: (),
  see: none,
  see-also: none,
  bold-pages: (),
) = {
  // Main entry
  [#text(weight: if pages != none and pages.len() > 0 { "medium" } else { "regular" })[#term]]
  
  if see != none {
    [. #emph[See] #see]
  } else {
    if pages != none {
      [, ]
      for (i, p) in pages.enumerate() {
        if i > 0 { [, ] }
        if p in bold-pages {
          text(weight: "bold")[#p]
        } else {
          [#p]
        }
      }
    }
    
    if see-also != none {
      [. #emph[See also] #see-also]
    }
  }
  
  // Sub-entries
  if sub-entries.len() > 0 {
    v(0.2em)
    for sub in sub-entries {
      h(1.5em)
      text(size: 0.95em)[#sub.term, #sub.pages.join(", ")]
      v(0.2em)
    }
  }
  
  v(0.3em)
}

/// Advanced index with full formatting
#let index-advanced(
  title: "Index",
  entries: (),
  columns-count: 2,
) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  let sorted = entries.sorted(key: e => upper(e.term))
  let current-letter = ""
  
  columns(columns-count, gutter: 2em)[
    #for entry in sorted {
      let first-letter = upper(entry.term.first())
      if first-letter != current-letter {
        current-letter = first-letter
        v(0.8em)
        text(size: 1.2em, weight: "bold")[#current-letter]
        v(0.3em)
      }
      
      index-entry-complex(
        entry.term,
        pages: entry.at("pages", default: none),
        sub-entries: entry.at("sub-entries", default: ()),
        see: entry.at("see", default: none),
        see-also: entry.at("see-also", default: none),
        bold-pages: entry.at("bold-pages", default: ()),
      )
    }
  ]
  
  pagebreak(weak: true)
}

// =============================================================================
// ABOUT THE SERIES
// =============================================================================

/// About the series page
#let about-series(
  series-name,
  description,
  books-in-series: (),
  upcoming: none,
) = {
  heading(outlined: false, numbering: none, level: 1)[About the #series-name Series]
  v(1em)
  
  description
  
  if books-in-series.len() > 0 {
    v(1.5em)
    text(weight: "semibold")[Books in the Series:]
    v(0.5em)
    
    for (i, book) in books-in-series.enumerate() {
      [#(i + 1). #emph[#book]]
      v(0.3em)
    }
  }
  
  if upcoming != none {
    v(1em)
    text(style: "italic")[Coming soon: #upcoming]
  }
  
  pagebreak(weak: true)
}

// =============================================================================
// NEWSLETTER / MAILING LIST
// =============================================================================

/// Newsletter signup page
#let newsletter-page(
  title: "Stay Connected",
  author: none,
  body,
  url: none,
  qr-code: none,
) = {
  set page(numbering: none)
  
  v(1fr)
  
  align(center)[
    #text(size: 1.3em, tracking: 0.05em)[#upper(title)]
    
    #if author != none {
      v(0.5em)
      text(size: 1.1em, style: "italic")[#author]
    }
  ]
  
  v(2em)
  
  body
  
  if url != none {
    v(1.5em)
    align(center)[
      #text(fill: rgb("#0066cc"))[#link(url)[#url]]
    ]
  }
  
  if qr-code != none {
    v(1em)
    align(center)[#qr-code]
  }
  
  v(1fr)
  pagebreak()
}

// =============================================================================
// Glossary Components
// =============================================================================

/// Create a glossary entry
#let glossary-entry(term, definition, see-also: none) = {
  block(spacing: 0.8em)[
    #text(weight: "bold")[#term]
    #h(1em)
    #definition
    #if see-also != none [
      #text(style: "italic", size: 0.9em)[ See also: #see-also]
    ]
  ]
}

/// Glossary page with sorted entries
#let glossary-page(title: "Glossary", entries) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  // Sort entries alphabetically by term
  let sorted = entries.sorted(key: e => e.term)
  
  for entry in sorted {
    glossary-entry(
      entry.term, 
      entry.definition,
      see-also: entry.at("see-also", default: none)
    )
  }
  
  pagebreak(weak: true)
}

/// Glossary with letter headers
#let glossary-alphabetical(title: "Glossary", entries) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  let sorted = entries.sorted(key: e => upper(e.term))
  let current-letter = ""
  
  for entry in sorted {
    let first-letter = upper(entry.term.first())
    if first-letter != current-letter {
      current-letter = first-letter
      v(0.5em)
      text(size: 1.3em, weight: "bold")[#current-letter]
      v(0.3em)
    }
    glossary-entry(
      entry.term,
      entry.definition,
      see-also: entry.at("see-also", default: none)
    )
  }
  
  pagebreak(weak: true)
}

// -----------------------------------------------------------------------------
// Index Components
// -----------------------------------------------------------------------------

/// Simple index entry
#let index-entry(term, pages) = {
  [#term #box(width: 1fr, repeat[.#h(4pt)]) #pages \ ]
}

/// Index page
#let index-page(title: "Index", entries) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  columns(2, gutter: 2em)[
    #let sorted = entries.sorted(key: e => upper(e.term))
    #let current-letter = ""
    
    #for entry in sorted {
      let first-letter = upper(entry.term.first())
      if first-letter != current-letter {
        current-letter = first-letter
        v(0.5em)
        text(weight: "bold")[#current-letter]
        v(0.3em)
      }
      index-entry(entry.term, entry.pages)
    }
  ]
  
  pagebreak(weak: true)
}

// -----------------------------------------------------------------------------
// Bibliography Components
// -----------------------------------------------------------------------------

/// Simple bibliography section
#let bibliography-section(title: "Bibliography", bib-file: none) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  if bib-file != none {
    bibliography(bib-file, style: "ieee")
  }
  
  pagebreak(weak: true)
}

/// References section with custom entries
#let references-page(title: "References", entries) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  set par(hanging-indent: 1.5em)
  
  for (i, entry) in entries.enumerate() {
    [[#(i + 1)] #entry \ ]
    v(0.3em)
  }
  
  pagebreak(weak: true)
}

// -----------------------------------------------------------------------------
// Appendix Components
// -----------------------------------------------------------------------------

/// Start appendix section (changes heading numbering to letters)
#let appendix-start() = {
  counter(heading).update(0)
  set heading(numbering: "A.1.")
}

/// Appendix chapter
#let appendix-chapter(title, body) = {
  heading(level: 1)[#title]
  body
}

// -----------------------------------------------------------------------------
// Special Chapters
// -----------------------------------------------------------------------------

/// Preface/Foreword page
#let preface-page(title: "Preface", body, author: none, date: none, location: none) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  
  body
  
  if author != none or date != none or location != none {
    v(2em)
    align(right)[
      #if author != none [#author \ ]
      #if location != none [#location \ ]
      #if date != none [#date]
    ]
  }
  
  pagebreak()
}

/// Acknowledgments page
#let acknowledgments-page(title: "Acknowledgments", body) = {
  heading(outlined: true, numbering: none, level: 1)[#title]
  v(1em)
  body
  pagebreak()
}

/// About the Author page
#let about-author-page(
  title: "About the Author",
  name: none,
  bio: none,
  photo: none,
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  
  if photo != none {
    align(center)[
      #box(
        clip: true,
        radius: 50%,
        width: 3cm,
        height: 3cm,
        photo
      )
    ]
    v(1em)
  }
  
  if name != none {
    align(center)[
      #text(weight: "semibold", size: 1.2em)[#name]
    ]
    v(1em)
  }
  
  if bio != none {
    bio
  }
  
  pagebreak()
}

/// Colophon (production details)
#let colophon-page(body) = {
  set page(numbering: none)
  v(1fr)
  set text(size: 0.85em)
  
  align(center)[
    #text(weight: "semibold")[Colophon]
    #v(1em)
    #body
  ]
  
  pagebreak()
}