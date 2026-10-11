#import "../config/constants.typ": figuresList, tablesList, acronymsList
#set page(numbering: "i")
#heading(level: 1, numbering: none, outlined: false)[
    #text()[Contents]
]

#context {
  // 1. FIND ALL HEADINGS
  let elements = query(heading.where(outlined: true))

  // 2. LOOP OVER EACH FOUND HEADING
  for el in elements {
    // --- FIX 1: RETRIEVE FORMATTED PAGE NUMBER (Roman/Arabic) ---
    // Get the active numbering pattern at that location (e.g., "i" or "1")
    let page_pattern = el.location().page-numbering()
    // Get the raw page counter
    let page_counter = counter(page).at(el.location())
    
    // Combine pattern and counter. If no pattern exists, use simple string.
    let formatted_page_number = if page_pattern != none {
      numbering(page_pattern, ..page_counter)
    } else {
      str(page_counter.first())
    }

    // --- FIX 2: RETRIEVE SECTION NUMBER (1, 1.1, etc.) ---
    let section_number = if el.numbering != none {
      numbering(el.numbering, ..counter(heading).at(el.location()))
      h(0.5em) // Space between number and title
    } else {
      none
    }

    // Make the row clickable
    link(el.location())[

      #set par(first-line-indent: 0em)
      // --- STYLE FOR LEVEL 1 (CHAPTERS) ---
      #if el.level == 1 {
        v(1.2em) // Vertical space above
        set text(size: 1.2em)
        
        // GRID: Col 1 (Number + Title) | Col 2 (Page)
        // Nothing in between -> No dots
        
        grid(
          columns: (1fr, auto),
          align: (left, bottom),
          // Combine section number and body
          box[#section_number #smallcaps(el.body)], 
          text(features: (onum: 1, liga: 1))[#formatted_page_number]
        )
      } 
      
      // --- STYLE FOR SUBSEQUENT LEVELS (Sub-chapters) ---
      #if el.level > 1 and el.level <= 3 {
        v(0.1em) 
        set text(font: "EB Garamond", size: 1em)
        
        // Calculate indentation (multiply by a unit!)
        let indentation = (el.level - 1) * 1.5em
        
        box(width: 1fr)[
          #h(indentation)
          #section_number 
          #h(0.4em)
          #el.body
          #box(width: 1fr, repeat[.]) // The dots!
          #formatted_page_number 
        ]
      }
    ]
  }
}


