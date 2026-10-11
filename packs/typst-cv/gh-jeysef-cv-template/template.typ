#let cv(
  author: "",
  title: "Curriculum Vitae",
  keywords: (),   
  profile-picture: none,
  lang: "en",
  ..cells 
) = {
  // --- PDF Metadata ---
  set document(
    author: author,
    title: author + " - " + title,
    keywords: keywords,
    date: auto 
  )
  
  set page(
    paper: "a4",
    margin: (left: 1.5cm, right: 1.5cm, top: 1.5cm, bottom: 1.5cm),
  )
  
  set text(
    font: ("Arial", "Helvetica", "Liberation Sans", "DejaVu Sans"), 
    size: 9pt, 
    fill: rgb("#000000"),
    lang: lang
  )
  
  set par(leading: 0.6em)

  // --- Semantic Heading Style ---
  // Blue, Right-Aligned, Uppercase
  show heading.where(level: 2): it => {
    set text(fill: rgb("#003366"), weight: "bold", size: 9pt)
    align(right + top, upper(it.body))
  }

  // --- Visual Header ---
  grid(
    columns: (1fr, auto),
    gutter: 1em,
    align(left + horizon)[
      #v(0.5em)
      #text(weight: "bold", size: 16pt, tracking: 1pt)[#upper(author)]
      #v(0.2em)
      #text(size: 10pt, fill: gray)[#title]
    ],
    if profile-picture != none {
      box(
        // Slightly reduced size to prevent margin clipping
        radius: 50%, 
        clip: true, 
        width: 3cm, 
        height: 3cm, 
        image(profile-picture, fit: "cover", width: 100%, height: 100%)
      )
    }
  )
  
  v(1.5cm)

  // --- Main Layout Table ---
  table(
    columns: (26%, 0pt, 1fr), 
    inset: (x: 8pt, y: 4pt),
    stroke: none,             
    column-gutter: 1em,
    row-gutter: 0.6em,        
    
    // Continuous vertical separator
    table.vline(x: 1, stroke: 0.5pt + rgb("#808080")),

    ..cells.pos().flatten()
  )
}

// --- Helpers ---

#let cv-section(title) = {
  (
    heading(level: 2, title),
    [], 
    []
  )
}

#let cv-item(label, value) = {
  (
    align(right + top, label),
    [], 
    align(left + top, value)
  )
}

#let cv-bullet-item(label, value) = {
  cv-item([• #label], value)
}

#let cv-spacer() = {
  (v(0.3em), [], v(0.3em))
}

#let link-blue(url, label: none) = {
  let display = if label == none { url } else { label }
  text(fill: blue, link(url)[#display])
}