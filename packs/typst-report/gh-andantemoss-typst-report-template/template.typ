#let project(
  title: "",
  authors: (),
  logo: none,
  project_title: "",
  ulinetitle: false,
  body
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  
  set heading(numbering: "1.")
  
  set par(justify: true)
  show ref: set text(rgb(0,0,150), weight:"bold", style:"normal")
  show ref: underline
  
  // Special Code Blocks
  show raw.where(block: true): it => {
  block[
    #h(1fr)
    #box(
      width: 100%,
      radius: 0.1em,
      stroke: luma(50%),
      inset: 1em,
      fill: luma(99%)
    )[
      #show raw.line: l => context {
        box(width:measure([#it.lines.last().count]).width, align(right, text(fill: luma(50%))[#l.number]))
        h(0.5em)
        l.body
      }
      #it
    ]
  ]
}
  set align(center)
  
  // Title page.
  v(0.65fr)
  if (ulinetitle == true) {
      underline[#text(2.4em, weight: 1000, title)]
    } else {
      text(2.4em, weight: 1000, title)
  }
  
  align(center)[
    
    #text(1.7em, weight: 600, style: "italic", project_title)

  ]
  set align(left)

  set table(
    stroke: none,
    gutter: 0.4em,
    // inset: (right: 1.5em),
    
  )

  // Author information.
  pad(
    top: 0.3em,
    align(center, table(
    columns: (auto, auto, auto),
    inset: 11pt,
    align: horizon,
    
    // table.header(
    //   [*Name*], [*Student ID*], [*Contributions*]
    // ),
    // table.hline(start: 0),
    ..authors.map(author => ([*#author.name*],[*#author.id*], [#author.info])).flatten(),
    
  ))

  )

  // Logo
  if logo != none {
    v(0.7fr)
    align(center, image(logo, width: 37%))
    v(0.025fr)
  } else {
    v(0.75fr)
  }
  
  pagebreak()

  // Table of contents.
  outline(depth: 3)

  set page(
    header: context {
      if counter(page).get().first() > 1 [
        #set text(style: "italic")
        #title
        #h(1fr)
        #project_title
        #block(line(length: 100%, stroke: 0.5pt), above: 0.6em)
      ]
    },
    numbering: "1/1", number-align: center
  )
  
  // Main body.
  // set page()
  show bibliography: set par(first-line-indent: 0pt) 

  counter(page).update(1)
  body
}

// Create a BlockQuote 
#let blockquote = block.with(
   inset: 8pt, radius: 4pt, fill: rgb("#f3f3f3"), stroke: (left: 5pt + black), 
)

// Color text certain colour
#let colblue(x) = text(fill: rgb(44, 99, 238), $#x$)
#let colgr(x) = text(fill: rgb("#36a83f"), $#x$)


#let numbered_eq(content) = math.equation(
    block: true,
    numbering: "(1)",
    content,
)

// Highlight text
#let hl(content) = box(
  content,
  inset: 0em,
  fill: rgb("#fffe69"),
) 

#let epsilon = $epsilon.alt$