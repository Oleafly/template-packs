#import "../config.typ": *
#import "../lib.typ": *
#import "changelog_data.typ": changelog

#if draft {
  page(margin: 30mm, header: none, footer: none)[
        
    #set text(font: font_sans, size: 11pt, fill: black)
    
    // Fancy Book-Style Header
    #align(center)[
      
      // Main title
      #text(
        font: "New Computer Modern",
        size: 24pt, 
        weight: "black", 
        fill: black,
        tracking: 0.1em,
        smallcaps[Version History]
      )
      
      #v(1.2em)
      
      // Version and date in elegant format
      #box(
        inset: (x: 1.5em, y: 0.6em),
      )[
        #text(font: "New Computer Modern", size: 9pt, tracking: 0.05em)[
          #smallcaps[Current] #h(0.3em) #text(fill: black)[#myVersion]
          #h(1.5em)
          #text(fill: black)[•]
          #h(1.5em)
          #smallcaps[Generated] #h(0.3em) #text(fill: black)[#datetime.today().display()]
        ]
      ]
    ]
    
    #v(2.5em)
    
    #if changelog == none or changelog.len() == 0 {
         align(center)[
           #v(2em)
           #text(size: 14pt, style: "italic", fill: luma(120))[No changelog entries found.]
         ]
    } else {
      
      let grid-items = ()
      
      for entry in changelog {
        if entry.at("exclude", default: false) { continue }
        
        // Header Row for Version
        grid-items.push(
            table.cell(colspan: 2, align(left)[
                #text(weight: "bold", size: 12pt, fill: black)[#entry.version]
                #h(1em)
                #text(size: 10pt, fill: luma(100))[#entry.date]
                #h(1fr)
                #if "author" in entry {
                   text(size: 9pt, style: "italic", fill: luma(100))[by #entry.author]
                }
            ])
        )
        
        // Changes Row
        grid-items.push(
            table.cell(colspan: 2)[
            #set par(first-line-indent: 0pt)
            #v(0.5em)
            #for change in entry.changes [
              #text(fill: luma(80))[•] #h(0.5em) #change \
            ]
          #v(1em)
        ]
      )
         // Separator
        grid-items.push(
            table.cell(colspan: 2, line(length: 100%, stroke: 0.5pt + luma(200)))
        )
      }

      table(
        columns: (1fr, 4em),
        inset: (x: 0.5em, y: 0.7em),
        stroke: none, //(x, y) => if y == 0 { (bottom: 1pt + black) } else { none },
        align: horizon,
        
        // Header
        table.hline(stroke: 1pt + black),
        text(fill: black, size: 10pt, tracking: 0.05em, smallcaps[*Changelog*]), 
        align(right, text(fill: black, size: 9pt, tracking: 0.05em, smallcaps[])),
        table.hline(stroke: 0.5pt + black),
        
        ..grid-items
        
      )
    }
  ]
}
