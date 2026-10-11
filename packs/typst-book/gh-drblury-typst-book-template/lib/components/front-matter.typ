// =============================================================================
// FRONT-MATTER.TYP - Front matter components for books
// =============================================================================

// =============================================================================
// SERIES PAGE - "Also by this author"
// =============================================================================

/// Series page listing other books
#let series-page(
  author: none,
  title: "Also by this Author",
  books: (),
  series-info: none,
) = {
  set page(numbering: none)
  
  v(1fr)
  
  align(center)[
    #if author != none {
      text(size: 1.1em, style: "italic")[#author]
      v(1em)
    }
    
    #text(size: 1.4em, tracking: 0.1em)[#upper(title)]
    v(2em)
    
    #for book in books {
      if type(book) == str {
        text(style: "italic")[#book]
      } else {
        // Book is a dictionary with title, series, year
        text(style: "italic")[#book.title]
        if "series" in book {
          text(size: 0.9em, fill: rgb("#666"))[ (#book.series)]
        }
        if "year" in book {
          text(size: 0.85em, fill: rgb("#888"))[ — #book.year]
        }
      }
      v(0.5em)
    }
    
    #if series-info != none {
      v(2em)
      line(length: 30%, stroke: 0.5pt + rgb("#999"))
      v(1em)
      text(size: 0.9em, fill: rgb("#666"))[#series-info]
    }
  ]
  
  v(1fr)
  pagebreak()
}

// =============================================================================
// PRAISE/REVIEWS PAGE
// =============================================================================

/// Single praise/review entry
#let praise-entry(quote, source, publication: none) = {
  block(spacing: 1.5em)[
    #text(style: "italic")["#quote"]
    #v(0.3em)
    #align(right)[
      #text(size: 0.9em)[
        — #text(weight: "semibold")[#source]
        #if publication != none [, #emph[#publication]]
      ]
    ]
  ]
}

/// Praise/Reviews page
#let praise-page(
  title: "Praise for",
  book-title: none,
  reviews: (),
) = {
  set page(numbering: none)
  
  v(2em)
  
  align(center)[
    #text(size: 1.2em, tracking: 0.1em)[#upper(title)]
    #if book-title != none {
      v(0.3em)
      text(size: 1.5em, weight: "bold", style: "italic")[#book-title]
    }
  ]
  
  v(2em)
  
  for review in reviews {
    praise-entry(
      review.quote,
      review.source,
      publication: review.at("publication", default: none),
    )
  }
  
  pagebreak()
}

// =============================================================================
// DRAMATIS PERSONAE - Character list for plays/complex novels
// =============================================================================

/// Single character entry
#let character-entry(name, description: none, role: none) = {
  grid(
    columns: (auto, 1fr),
    gutter: 1em,
    [
      #text(weight: "semibold", tracking: 0.02em)[#upper(name)]
      #if role != none {
        text(size: 0.85em, fill: rgb("#666"))[ (#role)]
      }
    ],
    if description != none {
      text(style: "italic", size: 0.95em)[#description]
    },
  )
  v(0.3em)
}

/// Character group (e.g., "The Royal Family")
#let character-group(title, characters) = {
  v(1em)
  text(size: 1.1em, weight: "semibold", tracking: 0.05em)[#title]
  v(0.5em)
  
  for char in characters {
    if type(char) == str {
      character-entry(char)
    } else {
      character-entry(
        char.name,
        description: char.at("description", default: none),
        role: char.at("role", default: none),
      )
    }
  }
}

/// Dramatis Personae page
#let dramatis-personae(
  title: "Dramatis Personae",
  subtitle: none,
  characters: (),
  groups: (:),
  setting: none,
  time: none,
) = {
  set page(numbering: none)
  
  v(2em)
  
  align(center)[
    #text(size: 1.5em, tracking: 0.15em)[#upper(title)]
    #if subtitle != none {
      v(0.3em)
      text(size: 1em, style: "italic")[#subtitle]
    }
  ]
  
  v(2em)
  
  // Ungrouped characters
  if characters.len() > 0 {
    for char in characters {
      if type(char) == str {
        character-entry(char)
      } else {
        character-entry(
          char.name,
          description: char.at("description", default: none),
          role: char.at("role", default: none),
        )
      }
    }
  }
  
  // Grouped characters
  for (group-name, group-chars) in groups {
    character-group(group-name, group-chars)
  }
  
  // Setting and time
  if setting != none or time != none {
    v(2em)
    line(length: 30%, stroke: 0.5pt + rgb("#999"))
    v(1em)
    
    if setting != none {
      text(size: 0.95em)[*Setting:* #setting]
      v(0.3em)
    }
    if time != none {
      text(size: 0.95em)[*Time:* #time]
    }
  }
  
  pagebreak()
}

// =============================================================================
// PRONUNCIATION GUIDE
// =============================================================================

/// Single pronunciation entry
#let pronunciation-entry(term, pronunciation, definition: none) = {
  grid(
    columns: (auto, auto, 1fr),
    gutter: 1em,
    text(weight: "semibold")[#term],
    text(style: "italic", fill: rgb("#555"))[[#pronunciation]],
    if definition != none { text(size: 0.95em)[#definition] },
  )
  v(0.3em)
}

/// Pronunciation guide page
#let pronunciation-guide(
  title: "Pronunciation Guide",
  entries: (),
  note: none,
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  
  if note != none {
    text(size: 0.9em, style: "italic")[#note]
    v(1em)
  }
  
  for entry in entries {
    pronunciation-entry(
      entry.term,
      entry.pronunciation,
      definition: entry.at("definition", default: none),
    )
  }
  
  pagebreak()
}

// =============================================================================
// MAP/ILLUSTRATION PLATES
// =============================================================================

/// Full-page illustration plate
#let illustration-plate(
  image-content,
  caption: none,
  title: none,
) = {
  set page(numbering: none)
  
  v(1fr)
  
  align(center)[
    #if title != none {
      text(size: 1.2em, tracking: 0.1em)[#upper(title)]
      v(1em)
    }
    
    #image-content
    
    #if caption != none {
      v(1em)
      text(size: 0.9em, style: "italic")[#caption]
    }
  ]
  
  v(1fr)
  pagebreak()
}

/// Map page with legend
#let map-page(
  map-image,
  title: "Map",
  legend: none,
  caption: none,
) = {
  set page(numbering: none)
  
  align(center)[
    #text(size: 1.3em, tracking: 0.1em)[#upper(title)]
  ]
  
  v(1em)
  
  align(center)[#map-image]
  
  if legend != none {
    v(1em)
    block(
      width: 80%,
      stroke: 0.5pt + rgb("#999"),
      inset: 8pt,
      radius: 4pt,
    )[
      #text(size: 0.85em, weight: "semibold")[Legend]
      #v(0.5em)
      #text(size: 0.85em)[#legend]
    ]
  }
  
  if caption != none {
    v(0.5em)
    align(center)[
      #text(size: 0.85em, style: "italic")[#caption]
    ]
  }
  
  pagebreak()
}

// =============================================================================
// TIMELINE PAGE
// =============================================================================

/// Timeline entry
#let timeline-entry(date, event, details: none) = {
  grid(
    columns: (100pt, 1fr),
    gutter: 1em,
    align(right)[
      #text(weight: "semibold", size: 0.95em)[#date]
    ],
    [
      #text(weight: "medium")[#event]
      #if details != none {
        v(0.2em)
        text(size: 0.9em, fill: rgb("#555"))[#details]
      }
    ],
  )
  v(0.8em)
}

/// Timeline page for historical context
#let timeline-page(
  title: "Timeline",
  subtitle: none,
  entries: (),
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  
  if subtitle != none {
    text(size: 1em, style: "italic")[#subtitle]
  }
  
  v(1.5em)
  
  for entry in entries {
    timeline-entry(
      entry.date,
      entry.event,
      details: entry.at("details", default: none),
    )
  }
  
  pagebreak()
}

// =============================================================================
// CONTENT WARNINGS PAGE
// =============================================================================

/// Content warnings/trigger warnings page
#let content-warnings(
  title: "Content Note",
  intro: "This book contains themes and content that some readers may find difficult. These include:",
  warnings: (),
  outro: none,
) = {
  set page(numbering: none)
  
  v(1fr)
  
  align(center)[
    #text(size: 1.2em, tracking: 0.1em)[#upper(title)]
  ]
  
  v(2em)
  
  text(size: 0.95em)[#intro]
  
  v(1em)
  
  for warning in warnings {
    [• #warning]
    v(0.3em)
  }
  
  if outro != none {
    v(1.5em)
    text(size: 0.9em, style: "italic")[#outro]
  }
  
  v(1fr)
  pagebreak()
}

// =============================================================================
// TITLE PAGE VARIANTS
// =============================================================================

/// Classic/Traditional title page
#let title-page-classic(
  title: "Book Title",
  subtitle: none,
  author: "Author Name",
  publisher: none,
  year: datetime.today().year(),
) = {
  set page(numbering: none)
  
  v(2fr)
  
  align(center)[
    #text(size: 2.5em, weight: "bold", tracking: 0.02em)[#title]
    
    #if subtitle != none {
      v(0.5em)
      text(size: 1.2em)[#subtitle]
    }
    
    v(1em)
    line(length: 20%, stroke: 1pt + black)
    v(1em)
    
    text(size: 1.3em, style: "italic")[#author]
  ]
  
  v(3fr)
  
  align(center)[
    #if publisher != none {
      text(size: 1em, tracking: 0.05em)[#upper(publisher)]
      v(0.3em)
    }
    text(size: 0.9em)[#year]
  ]
  
  v(1fr)
  pagebreak()
}

/// Modern/Minimalist title page
#let title-page-modern(
  title: "Book Title",
  subtitle: none,
  author: "Author Name",
  accent-color: rgb("#333"),
) = {
  set page(numbering: none)
  
  v(1fr)
  
  // Large accent bar
  place(left, dx: -2cm)[
    #rect(width: 8pt, height: 15em, fill: accent-color)
  ]
  
  align(left)[
    #text(size: 3em, weight: "bold", tracking: -0.02em)[#title]
    
    #if subtitle != none {
      v(0.3em)
      text(size: 1.1em, fill: rgb("#666"))[#subtitle]
    }
    
    v(2em)
    
    text(size: 1.2em, weight: "light")[#author]
  ]
  
  v(2fr)
  pagebreak()
}

/// Elegant/Decorative title page
#let title-page-elegant(
  title: "Book Title",
  subtitle: none,
  author: "Author Name",
  ornament: "❧",
) = {
  set page(numbering: none)
  
  v(2fr)
  
  align(center)[
    text(size: 1.5em, fill: rgb("#999"))[#ornament]
    v(1em)
    
    text(size: 2.2em, style: "italic", weight: "regular")[#title]
    
    #if subtitle != none {
      v(0.5em)
      text(size: 1.1em, tracking: 0.05em)[#subtitle]
    }
    
    v(1em)
    text(size: 1.5em, fill: rgb("#999"))[#ornament]
    
    v(2em)
    
    text(size: 1.1em, tracking: 0.1em)[#upper(author)]
  ]
  
  v(2fr)
  pagebreak()
}

// =============================================================================
// READING GUIDE / DISCUSSION QUESTIONS (Front Matter version)
// =============================================================================

/// Reader's guide intro page
#let readers-guide-intro(
  title: "A Note to Book Clubs",
  body,
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  body
  pagebreak()
}

// =============================================================================
// FAMILY TREE
// =============================================================================

/// Simple family tree entry
#let family-member(name, relation: none, dates: none, note: none) = {
  box(
    stroke: 1pt + rgb("#ccc"),
    radius: 4pt,
    inset: 8pt,
  )[
    #text(weight: "semibold")[#name]
    #if relation != none {
      v(0.2em)
      text(size: 0.85em, style: "italic")[#relation]
    }
    #if dates != none {
      v(0.2em)
      text(size: 0.8em, fill: rgb("#666"))[#dates]
    }
    #if note != none {
      v(0.2em)
      text(size: 0.8em)[#note]
    }
  ]
}

/// Family tree page (simplified - for complex trees, use diagrams)
#let family-tree-page(
  title: "Family Tree",
  subtitle: none,
  content,
) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  
  if subtitle != none {
    text(size: 1em, style: "italic")[#subtitle]
  }
  
  v(1.5em)
  
  content
  
  pagebreak()
}

// =============================================================================
// Title Page Components
// =============================================================================

/// Standard title page
#let title-page(
  title: "Book Title",
  subtitle: none,
  author: "Author Name",
  publisher: none,
  date: datetime.today().display("[month repr:long] [year]"),
  logo: none,
) = {
  set page(numbering: none)
  
  v(1fr)
  
  align(center)[
    #if logo != none {
      logo
      v(2em)
    }
    
    #text(size: 2.5em, weight: "bold")[#title]
    
    #if subtitle != none {
      v(0.5em)
      text(size: 1.3em)[#subtitle]
    }
    
    #v(2em)
    
    #text(size: 1.2em, style: "italic")[#author]
    
    #v(1fr)
    
    #if publisher != none {
      text(size: 1em)[#publisher]
      v(0.5em)
    }
    
    #text(size: 0.9em)[#date]
  ]
  
  v(1fr)
  pagebreak()
}

/// Half-title page (just the title, no other info)
#let half-title-page(title: "Book Title") = {
  set page(numbering: none)
  v(1fr)
  align(center)[
    #text(size: 1.8em, weight: "medium")[#title]
  ]
  v(2fr)
  pagebreak()
}

/// Copyright page
#let copyright-page(
  title: "Book Title",
  author: "Author Name",
  year: datetime.today().year(),
  publisher: none,
  isbn: none,
  edition: none,
  rights: "All rights reserved.",
  additional: none,
) = {
  set page(numbering: none)
  set text(size: 0.85em)
  
  v(1fr)
  
  [
    #text(weight: "semibold")[#title] \ 
    #if edition != none [#edition \ ]
    Copyright \u{00A9} #year #author \ 
    \ 
    #rights \ 
    \ 
    No part of this publication may be reproduced, stored in a retrieval system, 
    or transmitted in any form or by any means, electronic, mechanical, photocopying, 
    recording, or otherwise, without the prior written permission of the copyright holder.
    
    #if publisher != none [
      #v(1em)
      Published by #publisher
    ]
    
    #if isbn != none [
      #v(1em)
      ISBN: #isbn
    ]
    
    #if additional != none [
      #v(1em)
      #additional
    ]
  ]
  
  pagebreak()
}

/// Dedication page
#let dedication-page(dedication-text) = {
  set page(numbering: none)
  v(1fr)
  align(center)[
    #text(style: "italic", size: 1.1em)[#dedication-text]
  ]
  v(2fr)
  pagebreak()
}