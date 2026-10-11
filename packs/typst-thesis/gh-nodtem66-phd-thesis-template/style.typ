#import "graphic.typ": draw_chapter_ribbon, draw_cutting_marks
#import "heading_utils.typ": get_chapter_number, get_chapter_name, get_heading_name

//#let primary_color = cmyk(15%, 100%, 100%, 5%)
#let primary_color = cmyk(0%, 26.83%, 100%, 67.84%)
// State variable for enable/disable drawing the chapter ribbon
// We have only one page background context, so we use a state variable to
// control whether to draw the chapter ribbon or not.
// This style, the prefaces do not have chapter ribbon
// while the main chapters have chapter ribbon.
// This variable is set to true in thesis_style function (below).
#let enable_chapter_ribbon = state("enable_chapter_ribbon", false)

// Template: page_setup 
// ===========================================================
// Page setup for two formats:
//   "print" for book publishing (include offset 3mm for crop marks)
//   "digital" for digital copy of thesis (no crop marks, no offset)
#let page_setup(
  /// "print" or "digital"
  ///
  /// -> str
  format: "print",
  /// The document content
  doc,
) = {

  // Page setup for digital copy
  set page(
    width: 170mm,
    height: 240mm,
    margin: (top: 25mm, left: 20mm, right: 20mm, bottom: 20mm),
  )

  // Page setup for book publishing
  // The actual paper size after cutting is 170mm x 240mm
  set page(
    width: 173mm, // 170mm + extra 3mm for marking at the edge (left for even pages, right for odd pages)
    height: 246mm, // 240mm + extra 6mm for two marking at top and bottom
    margin: (top: 28mm, inside: 20mm, outside: 23mm, bottom: 23mm),
    // inside = margin from book binding, outside = margin from edge of paper
    
    // Add cutting marks and chapter ribbon for print format
    // These functions are defined in graphic.typ
    background: context {
      draw_cutting_marks(offset: 3mm, size: 2.5mm)
      draw_chapter_ribbon(color: primary_color, top_offset: 28mm)
    },
  ) if format == "print"

  // Set default font and size
  set text(font: "Libertinus Serif", size: 12pt)

  // Set paragraph alignment to fully justified
  set par(justify: true)
  set heading(numbering: "1.1")
  show heading: set text(size: 16pt)
  

  // Format the equation reference as (1)
  set math.equation(numbering: "(1)")

  // Format the cross-reference as Fig. 1, Tab. 1, Eq. 1
  // Other references will use their default supplement
  set ref(supplement: it => {
    if it.func() == figure { [Fig.] }
    else if it.func() == table { [Tab.] }
    else if it.func() == math.equation { [Eq.] }
    else { it.supplement }
  })

  // Set the gap between a figure and its label to 0cm
  // There is still a clearance from place. See:
  // https://typst.app/docs/reference/layout/place/#parameters-clearance
  set figure(gap: 0cm)
  doc
}
// End template: page_setup ===========================================================

/// Template: thesis_style
/// ===
/// Thesis style with chapter ribbon and header/footer for main content
#let thesis_style(
  // The document content
  doc,
) = {
  enable_chapter_ribbon.update(true) // Enable chapter ribbon
  set page(
    // Heading for odd and even pages
    // Odd page: right aligned with section name and page number
    // Even page: left aligned with page number and chapter name
    header: context {
      let page_number = counter(page).display("1")
      let chapter_number = get_chapter_number()
      let is_first_page_of_chapter = counter(heading).get().at(0) < chapter_number
      if calc.odd(here().page()) {
        if is_first_page_of_chapter == true {
          // Chapter cover page, do not show header
          return
        }
        align(right, text(primary_color)[
          #get_heading_name() #h(2mm) | #h(1mm) #page_number
        ])
      } else {
        let chapter = get_chapter_name()
        if chapter == none {
          // No chapter found, do not show header
          return
        }
        if chapter_number == 0 {
          // No chapter number found, do not show header
          return
        }
        let chapter_name = get_chapter_name()
        align(left, text(primary_color)[
          #page_number #h(2mm) | #h(2mm) Chapter #chapter_number. #get_chapter_name(limit: 50)
        ])
      }
    },
    header-ascent: 28%,
    
  )
  show heading.where(level: 1): it => context {
    // Default style for level 1 heading
    if it.outlined == false {
      it
      return
    }
    // Custom style for outlined level 1 heading
    pagebreak(to: "odd", weak: true)
    if it.numbering == none {
      v(50mm)
      set align(right)
      block(text(primary_color, size: 3em)[#it.body])
      v(1fr)
    } else {
      v(50mm)
      set align(right)
      block(text(primary_color, size: 3em)[Chapter #counter(heading).get().at(0)])
      block(text(size: 1.5em, it.body))
      v(1fr)
    }
  } // Only apply custom style if enabled
  doc
}
// End template: thesis_style =============================================================

#let postface_style(doc) = {
  enable_chapter_ribbon.update(false) // Disable chapter ribbon
  // Reset style for level-1 heading
  set page(
    // Heading for odd and even pages
    // Odd page: right aligned with chapter name and page number
    // Even page: left aligned with page number and chapter name
    header: context {
      let page_number = counter(page).display("1")
      let chapter_name = get_chapter_name()
      if calc.odd(here().page()) {
        
        align(right, text(primary_color)[
          #chapter_name #h(2mm) | #h(1mm) #page_number
        ])
      } else {
        align(left, text(primary_color)[
          #page_number #h(2mm) | #h(2mm) #chapter_name
        ])
      }
    }
    
  )
  doc
}