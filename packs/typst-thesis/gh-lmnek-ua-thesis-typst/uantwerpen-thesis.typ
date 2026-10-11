// UAntwerpen Bachelor/Master Thesis Template
// Typst version of uantwerpenbamathesis.cls

// Color definitions for UAntwerpen faculties
#let faculty-colors = (
  ua: (main: rgb("#EA2C38"), side: rgb("#002E65"), heading: rgb("#2d2d2d")),
  be: (main: rgb("#65A812"), side: rgb("#78b929ff"), heading: rgb("#2d2d2d")),
  fbd: (main: rgb("#44B8F3"), side: rgb("#B5DDF7"), heading: rgb("#2d2d2d")),
  ggw: (main: rgb("#7575CB"), side: rgb("#C6B6D2"), heading: rgb("#2d2d2d")),
  lw: (main: rgb("#F1B53D"), side: rgb("#FFDA91"), heading: rgb("#2d2d2d")),
  ow: (main: rgb("#82A1AD"), side: rgb("#C8D9D8"), heading: rgb("#2d2d2d")),
  re: (main: rgb("#D20824"), side: rgb("#ED9D90"), heading: rgb("#2d2d2d")),
  sw: (main: rgb("#ADA500"), side: rgb("#D7D394"), heading: rgb("#2d2d2d")),
  ti: (main: rgb("#B10097"), side: rgb("#DDB8D2"), heading: rgb("#2d2d2d")),
  we: (main: rgb("#006CA9"), side: rgb("#97C0DF"), heading: rgb("#2d2d2d")),
  iob: (main: rgb("#E66208"), side: rgb("#97C0DF"), heading: rgb("#2d2d2d")),
)

// Inset text with vertical line
#let inset-text(body, main-color, base-color) = {
  block(
    width: 88%,
    {
      layout(size => {
        let text-width = size.width - 3em
        let content = text(fill: base-color, size: 11pt, weight: 700)[#body]
        let content-size = measure(block(width: text-width, content))
        let line-height = content-size.height + 0.5em // Add margin to line height
        
        box(
          width: size.width,
          {
            place(
              dx: 0em,
              dy: -0.25em, // Offset to center with the added margin
              line(
                start: (0pt, 0pt),
                end: (0pt, line-height),
                stroke: 2.5pt + main-color
              )
            )
            pad(left: 2.5em, top: 0pt, bottom: 0pt, block(width: text-width, content))
          }
        )
      })
    }
  )
}

// Inset quote with quote icon
#let inset-quote(body, main-color, base-color) = {
  block(
    width: 88%,
    {
      layout(size => {
        let text-width = size.width - 3em
        let content = text(fill: base-color, size: 11pt)[#body]
        let content-size = measure(block(width: text-width, content))
        let line-height = content-size.height + 1em // More margin for quotes
        
        box(
          width: size.width,
          {
            place(
              dx: 0em,
              dy: -0.5em, // Offset to center with the added margin
              line(
                start: (0pt, 0pt),
                end: (0pt, line-height),
                stroke: 2.5pt + main-color
              )
            )
            pad(left: 2.5em, top: 0pt, bottom: 0pt, block(width: text-width, content))
          }
        )
      })
    }
  )
}

// Main template function
#let uantwerpen-thesis(
  title: none,
  author: none,
  subtitle: none,
  faculty: "ti",
  degree: none,
  doc-type: none,
  academic-year: none,
  supervisors: (),
  cosupervisors: (),
  extsupervisors: (),
  lang: "en",
  company-logo: none,
  logo-path: none,
  frontmatter-pages: 0, // Number of frontmatter pages (ToC, abstract, etc.) for roman numbering
  draft: false, // Set to true for single-sided draft mode (easier reading on screen)
  body
) = {
  
  // Get faculty colors
  let colors = faculty-colors.at(faculty, default: faculty-colors.ti)
  let main-color = colors.main
  let base-color = colors.side
  let heading-color = colors.heading
  
  // Page setup
  set page(
    paper: "a4",
    margin: if draft {
      // Draft mode: consistent margins for screen reading
      (top: 2.6cm, bottom: 2.5cm, left: 1.6cm, right: 1.6cm)
    } else {
      // Two-sided mode: alternating margins for book binding
      (top: 2.6cm, bottom: 2.5cm, inside: 3.5cm, outside: 1.6cm)
    },
    binding: if draft { left } else { auto },
  )
  
  set page(header: context {
    let page-num = counter(page).get().first()
    if page-num > 1 {
      set text(size: 9pt, style: "italic")
      
      // Check if there's a level 1 heading on this page
      let headings-here = query(selector(heading.where(level: 1)).after(here()))
      let has-chapter-here = false
      if headings-here.len() > 0 {
        let next-heading-loc = headings-here.first().location()
        // Check if the heading is on the same page
        if counter(page).at(next-heading-loc).first() == page-num {
          has-chapter-here = true
        }
      }
      
      // Only show header if there's no chapter heading on this page
      if not has-chapter-here {
        let headings-before = query(selector(heading.where(level: 1)).before(here()))
        if headings-before.len() > 0 {
          let last-heading = headings-before.last().body
          if draft {
            // Draft mode: heading always on right
            align(right, last-heading)
          } else {
            // Two-sided mode: alternating header position
            grid(
              columns: (1fr, 1fr),
              align: (left, right),
              if calc.odd(page-num) { [] } else { last-heading },
              if calc.odd(page-num) { last-heading } else { [] }
            )
          }
        }
      }
    }
  })
  
  set page(footer: context {
    let page-num = counter(page).get().first()
    if page-num > 1 and doc-type != none {
      set text(size: 9pt)
      // Use roman numerals for frontmatter pages (ToC, etc.), arabic for main content
      let display-num = if page-num <= frontmatter-pages + 2 {
        numbering("i", page-num)
      } else {
        str(page-num - frontmatter-pages - 2)
      }
      
      if draft {
        // Draft mode: simple footer with consistent layout
        grid(
          columns: (1fr, 2fr, 1fr),
          align: (left, center, right),
          if logo-path != none { image(logo-path, width: 2.5cm) },
          doc-type,
          box(baseline: 0.2em)[#display-num #h(0.3em) #text(fill: main-color, weight: 700, baseline: 0em, [|])]
        )
      } else {
        // Two-sided mode: alternating footer layout
        // Odd pages: large left margin (inside) -> logo on left
        // Even pages: large right margin (inside) -> logo on right
        grid(
          columns: (1fr, 2fr, 1fr),
          align: (left, center, right),
          if calc.odd(page-num) {
            box(baseline: 0.2em)[#text(fill: main-color, weight: 700, baseline: 0em, [|]) #h(0.3em) #display-num]
          } else {
            if logo-path != none { image(logo-path, width: 2.5cm) }
          },
          doc-type,
          if calc.odd(page-num) {
            if logo-path != none { image(logo-path, width: 2.5cm) }
          } else {
            box(baseline: 0.2em)[#display-num #h(0.3em) #text(fill: main-color, weight: 700, baseline: 0em, [|])]
          }
        )
      }
    }
  })
  
  // Text settings
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: lang,
  )
  
  set par(
    justify: true,
    first-line-indent: 0pt,
    spacing: 0.75em * 1.2,
  )
  
  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    text(
      size: 20.74pt,
      fill: heading-color,
      weight: 700,
      {
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.5em)
        }
        it.body
      }
    )
    v(1.5em)
  }
  
  show heading.where(level: 2): it => {
    v(1em)
    text(
      size: 14.4pt,
      fill: heading-color,
      weight: 700,
      {
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.5em)
        }
        it.body
      }
    )
    v(0.6em)
  }
  
  show heading.where(level: 3): it => {
    v(0.8em)
    text(
      size: 12pt,
      fill: heading-color,
      weight: 700,
      {
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.5em)
        }
        it.body
      }
    )
    v(0.5em)
  }
  
  set heading(numbering: "1.1")
  
  // Math equation styling
  set math.equation(numbering: "(1)")
  
  // Title page
  if title != none and author != none {
    page(
      margin: 0cm,
      header: none,
      footer: none,
    )[
      // Academic year top right
      #place(
        top + right,
        dx: -1.6cm,
        dy: 2.6cm,
        text(size: 12pt, weight: 700, align(right)[
          Academic Year \
          #text(size: 14pt, academic-year)
        ])
      )
      
      // Title with highlight boxes
      #place(
        top + left,
        dx: 3.5cm,
        dy: 6.4cm,
        block(
          width: 14.3cm,
          text(size: 24.88pt, fill: white, weight: 700, font: "Liberation Sans")[
            #box(fill: main-color, inset: (x: 5pt, y: 2pt), title)
          ]
        )
      )
      
      #if subtitle != none {
        place(
          top + left,
          dx: 3.5cm,
          dy: 8.2cm,
          block(
            width: 14.3cm,
            text(size: 20.74pt, fill: white, weight: 700, font: "Liberation Sans")[
              #box(fill: main-color, inset: (x: 5pt, y: 2pt), subtitle)
            ]
          )
        )
      }
      
      // Author name
      #place(
        top + left,
        dx: 3.5cm,
        dy: if subtitle != none { 10cm } else { 9.5cm },
        text(size: 20.74pt, weight: 700, font: "Liberation Sans", author)
      )
      
      // Document type and degree
      #if doc-type != none and degree != none {
        place(
          top + left,
          dx: 3.5cm,
          dy: 12cm,
          block(
            width: 14.3cm,
            text(size: 11pt, font: "Liberation Sans")[
              #doc-type \
              *#degree*
            ]
          )
        )
      }
      
      // Supervisors section
      #place(
        top + left,
        dx: 3.5cm,
        dy: 17.5cm,
        block(
          width: 14.3cm,
          text(size: 11pt)[
            #if supervisors.len() > 0 [
              #if supervisors.len() > 1 [Supervisors:] else [Supervisor:] \
              #for (name, affiliation) in supervisors [
                *#name*, #affiliation \
              ]
            ]
            
            #if cosupervisors.len() > 0 [
              #if supervisors.len() > 0 [ \ ]
              #if cosupervisors.len() > 1 [Co-supervisors:] else [Co-supervisor:] \
              #for (name, affiliation) in cosupervisors [
                *#name*, #affiliation \
              ]
            ]
            
            #if extsupervisors.len() > 0 [
              #if supervisors.len() > 0 or cosupervisors.len() > 0 [ \ ]
              #if extsupervisors.len() > 1 [External Supervisors:] else [External Supervisor:] \
              #for (name, affiliation) in extsupervisors [
                *#name*, #affiliation \
              ]
            ]
          ]
        )
      )
      
      // Company logo
      #if company-logo != none {
        place(
          bottom + right,
          dx: -1.6cm,
          dy: -1.5cm,
          company-logo
        )
      }
      
      // University logo
      #if logo-path != none {
        place(
          bottom + left,
          dx: 1.6cm,
          dy: -1.5cm,
          image(logo-path, width: 6.2cm)
        )
      }
    ]
    
    // Disclaimer page
    page(
      header: none,
      footer: none,
    )[
      #v(1fr)
      #align(bottom)[
        #block(width: 100%)[
          #text(size: 10pt)[
            *Disclaimer*
            
            This document is an examination document that has not been corrected for any errors identified. Without prior written permission of both the supervisor(s) and the author(s), any copying, copying, using or realizing this publication or parts thereof is prohibited. For requests for information regarding the copying and/or use and/or realisation of parts of this publication, please contact to the university at which the author is registered.
            
            Prior written permission from the supervisor(s) is also required for the use for industrial or commercial utility of the (original) methods, products, circuits and programs described in this thesis, and for the submission of this publication for participation in scientific prizes or competitions.
            
            This document is in accordance with the faculty regulations related to this examination document and the Code of Conduct. The text has been reviewed by the supervisor and the attendant.
          ]
        ]
      ]
    ]
    
    // Table of contents
    page()[
      #block(width: 100%)[
        #text(size: 20.74pt, fill: heading-color, weight: 700)[Table of Contents]
        #v(1em)
        #outline(
          title: none,
          depth: 3,
          indent: auto,
        )
      ]
    ]
  }
  
  // Main document body
  // Note: To support roman numbering for frontmatter (like LaTeX \frontmatter and \mainmatter),
  // set frontmatter-pages parameter to the number of pages before main content starts.
  // The counter will automatically switch from roman to arabic numbering.
  counter(page).update(1)
  body
}

// Helper functions for ti faculty (default)
#let inset-text-ti(body) = inset-text(body, faculty-colors.ti.main, faculty-colors.ti.side)

#let inset-quote-ti(body) = inset-quote(body, faculty-colors.ti.main, faculty-colors.ti.side)

// Helper functions for be faculty
#let inset-text-be(body) = inset-text(body, faculty-colors.be.main, faculty-colors.be.side)

#let inset-quote-be(body) = inset-quote(body, faculty-colors.be.main, faculty-colors.be.side)
