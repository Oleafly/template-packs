#import "glossary.typ": *

= Research Training Program and Progress

#let task(body, status: "todo") = {
  // Define the box appearance based on status
  let box-content = if status == "done" {
    rect(width: 12pt, height: 12pt, fill: green.lighten(70%), stroke: 0.8pt + green.darken(20%), radius: 2pt)[
      #set align(center + horizon)
      #text(size: 9pt, fill: green.darken(40%), weight: "bold")[✓]
    ]
  } else if status == "doing" {
    rect(width: 12pt, height: 12pt, fill: yellow.lighten(70%), stroke: 0.8pt + blue.darken(20%), radius: 2pt)[
      #set align(center + horizon)
      #text(size: 9pt, fill: blue.darken(40%), weight: "bold")[–]
    ]
  } else {
    rect(width: 12pt, height: 12pt, stroke: 0.8pt + gray, radius: 2pt)[]
  }

  // Layout the box and the text side-by-side
  grid(
    columns: (20pt, auto),
    align: horizon,
    box-content,
    body
  )
}

// Cliffe: the blue box with a line through is not really a clear indication of "in progress"
// Usage examples:
#task(status: "done")[Incident Response module]
#task(status: "done")[Systems security module]
#task(status: "doing")[REMA (Reverse Engineering and Malware Analysis) module]
#task(status: "todo")[Start Web and Networks module]
#task(status: "done")[MIT machine learning lectures]
#task(status: "done")[3 Blue 1 Brown videos on Neural Networks]
#task(status: "todo")[Look for resources on MLOps (Machine Learning operations)]

