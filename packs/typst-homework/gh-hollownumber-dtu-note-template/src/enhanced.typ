// Enhanced DTU Template Components
// Advanced components with syntax highlighting and rich content features

#import "colors.typ": *
#import "@preview/codelst:2.0.2": sourcecode

// Enhanced code block with syntax highlighting
#let code-block(code, language: none, caption: none, line-numbers: false) = {
  let bg-color = rgb("#f8f8f8")
  let border-color = dtu-gray

  block(
    width: 100%,
    fill: bg-color,
    stroke: 1pt + border-color,
    radius: 3pt,
    inset: 1em,
    [
      #if caption != none [
        #text(size: 10pt, weight: "bold", fill: dtu-dark-blue)[#caption]
        #v(0.5em)
      ]
      #sourcecode(
        numbering: if line-numbers { "1" } else { none },
        frame: none,
      )[#code]
    ]
  )
}

// Enhanced table styling
#let dtu-table(..args, caption: none, header-color: dtu-blue) = {
  let content = if caption != none [
    #figure(
      table(..args, fill: (_, row) => if row == 0 { header-color.lighten(80%) }),
      caption: caption,
      kind: table
    )
  ] else [
    #table(..args, fill: (_, row) => if row == 0 { header-color.lighten(80%) })
  ]
  content
}

// Enhanced quote block
#let dtu-quote(content, author: none, source: none) = {
  block(
    width: 100%,
    inset: (left: 1.5em, right: 1em, top: 1em, bottom: 1em),
    stroke: (left: 3pt + dtu-blue),
    fill: rgb("#f8f9ff"),
    [
      #text(style: "italic", fill: dtu-dark-blue)[#content]
      #if author != none or source != none [
        #v(0.5em)
        #align(right)[
          #text(size: 10pt, fill: dtu-gray)[
            #if author != none [— #author]
            #if source != none [ (#source)]
          ]
        ]
      ]
    ]
  )
}

// Alert box with icons
#let alert(content, type: "info") = {
  let (color, icon, title) = if type == "warning" {
    (dtu-yellow, "⚠", "Warning")
  } else if type == "error" {
    (dtu-coral, "❌", "Error")
  } else if type == "success" {
    (dtu-green, "✅", "Success")
  } else {
    (dtu-blue, "ℹ", "Info")
  }

  rect(
    width: 100%,
    inset: 1.2em,
    fill: color.lighten(90%),
    stroke: 2pt + color,
    radius: 4pt,
    [
      #text(weight: "bold", fill: color.darken(20%), size: 12pt)[#icon #title]
      #v(0.3em)
      #content
    ]
  )
}

// Figure helper
#let figure-helper(content, caption: "", kind: "figure", supplement: auto) = {
  figure(
    content,
    caption: caption,
    kind: kind,
    supplement: supplement
  )
}
