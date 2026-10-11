#let titlepage(metadata, date: none) = {
  // --- Data Preparation ---
  let data = metadata.data
  
  // --- Page Setup ---
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    numbering: none // Ensures no page numbers (like "i") appear on this page
  )
  
  // Use Roboto as base, condensed via stretch where needed
  set text(font: "Roboto", fill: black)

  // --- 1. Logo (Top Left) ---
  align(center)[
    #let logo = image("../assets/UAM.png")
    #logo
  ]

  // Fixed spacing after logo
  v(1cm)

  // --- 2. "Tesis Doctoral" Label ---
  // Spec: Roboto, Italic, Regular (Not Bold)
  align(left)[
    #text(
      size: 20pt, 
      style: "italic", 
      weight: "regular", 
      stretch: 100%, 
      "Tesis Doctoral"
    )
  ]

  // Push Title down
  v(1.5cm)

  // --- 3. Title ---
  align(center)[
    // Title: Roboto Condensed (stretch 75%), Bold, 28pt
    #set par(leading: 0.35em)
    #text(size: 28pt, weight: "bold", stretch: 75%, data.title)

  ]

  // Separate Title and Author evenly
  v(1cm)

  // --- 4. Author ---
  align(right)[
    #let author-name = if data.authors.len() > 0 { data.authors.first().Name } else { "Author Name" }
    // Author: Roboto Condensed, Bold, 28pt
    #text(size: 28pt, weight: "bold", stretch: 75%, author-name)
  ]

  // Fixed spacing before Program line
  v(2cm)

  // --- 5. PhD Program ---
  align(right)[
    #text(size: 16pt, stretch: 75%)[
      Programa de Doctorado en #metadata.layout.Programa
    ]
  ]

  // Flexible Spring 3: Pushes bottom section to the footer
  v(1.3cm)

  // --- 6. Supervisors 
  
   
    align(left + bottom)[
      #set text(size: 16pt, stretch: 75%)
      Dirección: \
      #v(-.5em)
      
      // Clean Supervisor Loop to avoid artifacts
      #let supervisors = ()
      #if "first" in data.supervisors { supervisors.push(data.supervisors.first.Name) }
      #if "second" in data.supervisors { supervisors.push(data.supervisors.second.Name) }
  
      
      #for s in supervisors [
        #h(30pt) #s \
      ]]
  

  // --- 7. Date/Location) ---

    align(right + bottom)[
      #set text(size: 14pt, stretch: 75%)
      // Push text to very bottom of the cell
      #v(1fr) 
      *Madrid,* \
      *#if date != none { date.display("[year]") } else { "2026" }*
    ]
  pagebreak()
}