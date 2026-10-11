#let cover-letter(name: "", date: "", content) = {
  set text(font: "Libertinus Serif", size: 12pt)
  set par(justify: false, spacing: 20pt)

  grid(
    columns: (1fr, 3fr, 0.5fr),
    
    align(left)[
      #text(16pt, weight: "bold")[#name]
    ],
    
    align(left)[
      [cover letter]
      
      #set text(12pt, weight: "regular")
      
      #content
      
      best, \
      \
      \
      #line(length: 40%)
      #date
    ],
    
    []
  )
}