#import "../config.typ": *
#import "../lib.typ": *
#if draft {
  page(margin: 30mm, header: none, footer: none)[
        
    #set text(font: font_sans, size: 11pt, fill: black)
    #let ct_link = cmyk(100%, 50%, 0%, 0%)
    
    // Fancy Book-Style Header
    #align(center)[
      
      // Main title
      #text(
        font: font_serif,
        size: 24pt, 
        weight: "black", 
        fill: black,
        tracking: 0.1em,
        smallcaps[Todo & Notes]
      )
      
      #v(1.2em)
      
      // Version and date in elegant format
      #box(
        inset: (x: 1.5em, y: 0.6em),
      )[
        #text(font: font_serif,size: 9pt, tracking: 0.05em)[
          #smallcaps[Version] #h(0.3em) #text(fill: black)[#myVersion]
          #h(1.5em)
          #text(fill: black)[•]
          #h(1.5em)
          #smallcaps[Generated] #h(0.3em) #text(fill: black)[#datetime.today().display()]
        ]
      ]
    ]
    
    #v(2.5em)
    
    #context {
       let items = query(<todo_item>)
       
       if items.len() == 0 {
         align(center)[
           #v(2em)
           #text(size: 14pt, style: "italic", fill: luma(120))[No pending items found.]
         ]
       } else {
          let grid-items = ()
          
          for item in items {
             let m = item.value
             // Strict filtering: only allow specific kinds
             if m.kind not in ("todo", "noteil", "todoil", "feedback") {
               continue
             }
             
             let loc = item.location()
             let p_num = counter(page).at(loc).first()
             
             let (icon, color, label-text) = if m.kind == "note" { 
                (emoji.lightbulb, rgb("F5C857"), "Note") 
             } else if m.kind == "todo" { 
                (emoji.page.pencil, orange, "Todo") 
             } else if m.kind == "noteil" { 
                (emoji.lightbulb, rgb("F5C857"), "Note") 
             } else if m.kind == "todoil" { 
                (emoji.page.pencil, orange, "Todo") 
             } else if m.kind == "feedback" { 
                (emoji.quest, rgb("#FF5555"), "Feedback") 
             } else { 
                (emoji.page, black, m.kind) 
             }
             
             // Row content
             let display-text = if "done" in m and m.done { strike(m.summary) } else { m.summary }
             
             let status-mark = if m.kind in ("todo", "todoil", "noteil", "feedback") {
                if "done" in m and m.done { "✅" } else { "⬜" }
             } else {
                "-"
             }

             grid-items.push(align(center + horizon, text(size: 10pt)[#status-mark]))
             grid-items.push(align(left + horizon, text(size: 10pt)[#text(size: 12pt)[#icon] #h(0.4em) #text(weight: "bold", fill: color)[#label-text]]))
             grid-items.push(align(left + horizon, text(fill: black, size: 10pt)[#display-text]))
             grid-items.push(align(right + horizon, link(loc)[#text(fill: ct_link, size: 10pt)[#p_num]]))
          }
          
          
          table(
            columns: (3em, 8em, 1fr, 4em),
            inset: (x: 0.8em, y: 0.7em),
            stroke: none,
            align: horizon,
            
            // Header with double rule
            table.hline(stroke: 1pt + black),
            align(center, text(fill: black, size: 9pt, tracking: 0.05em, smallcaps[*Sts*])),
            text(fill: black, size: 9pt, tracking: 0.05em, smallcaps[*Type*]), 
            text(fill: black, size: 9pt, tracking: 0.05em, smallcaps[*Summary*]), 
            align(right, text(fill: black, size: 9pt, tracking: 0.05em, smallcaps[*Page*])),
            table.hline(stroke: 0.5pt + black),
            
            ..grid-items,
            
            table.hline(stroke: 1pt + black),
          )
          

       }
    }
  ]
}