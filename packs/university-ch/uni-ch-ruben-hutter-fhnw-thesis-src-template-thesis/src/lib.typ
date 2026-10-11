// FHNW Thesis Template - Utility functions
//
// This module provides the FHNW color palette, draft-mode TODO markers,
// custom content environments (definition, theorem, algorithm), and a few
// common abbreviation helpers used throughout the thesis.

// ============================================================================
// Color Definitions (official FHNW branding)
// ============================================================================

#let fhnw-yellow = rgb("#fde70e")      // Primary brand color
#let fhnw-dark-gray = rgb("#2d373c")   // Text and structural lines
#let fhnw-gray = rgb("#8c9196")        // Secondary text
#let fhnw-red = rgb("#d20537")         // Alerts and emphasis
#let fhnw-light-red = rgb("#eb829b")   // Light accent red
#let fhnw-light-gray = rgb("#bec3c8")  // Light borders
#let fhnw-teal = rgb("#006e6e")        // Links and accents
#let fhnw-black = rgb("#000000")
#let fhnw-white = rgb("#ffffff")

// ============================================================================
// Internal configuration state
// ============================================================================

#let thesis-draft-state = state("thesis-draft", true)
#let thesis-color-state = state("thesis-color", true)

#let default-fonts = (
  body: ("Roboto", "Liberation Sans"),
  sans: ("Roboto", "Liberation Sans"),
  mono: ("Source Code Pro", "Liberation Mono"),
)

// ============================================================================
// TODO markers (only render when draft mode is enabled)
// ============================================================================

#let todo(content, color: fhnw-red) = context {
  if thesis-draft-state.get() {
    block(
      width: 100%,
      radius: 3pt,
      inset: 8pt,
      fill: color.lighten(85%),
      stroke: (paint: color, thickness: 0.5pt),
    )[
      #text(weight: "bold", fill: color)[TODO:] #h(0.3em) #content
    ]
  }
}

#let todo-missing(content) = todo(content, color: rgb(204, 0, 204))
#let todo-check(content) = todo(content, color: rgb(204, 0, 0))
#let todo-revise(content) = todo(content, color: rgb(204, 102, 0))
#let todo-citation(content) = todo(content, color: rgb(204, 153, 0))
#let todo-language(content) = todo(content, color: rgb(102, 102, 204))
#let todo-question(content) = todo(content, color: rgb(0, 153, 0))
#let todo-note(content) = todo(content, color: fhnw-dark-gray)

// ============================================================================
// Layout helpers
// ============================================================================

// Chapter heading without a number or outline entry (Abstract, ToC, ...)
#let unnumbered-chapter(body) = {
  heading(level: 1, numbering: none, outlined: false, body)
}

// ============================================================================
// Custom figure types
// ============================================================================

#let algorithm(content, caption: none) = {
  figure(
    align(left)[
      #block(
        width: 100%,
        stroke: (paint: fhnw-light-gray, thickness: 0.5pt),
        radius: 3pt,
        inset: 12pt,
        content,
      )
    ],
    caption: caption,
    supplement: "Algorithm",
  )
}

// ============================================================================
// Highlighting
// ============================================================================

#let important(content) = context {
  if thesis-color-state.get() {
    highlight(fill: fhnw-yellow.lighten(40%), content)
  } else {
    emph(content)
  }
}

// ============================================================================
// Custom content boxes (definitions, theorems)
// ============================================================================

#let definition(title: "Definition", content) = context {
  let accent = if thesis-color-state.get() { fhnw-teal } else { fhnw-dark-gray }
  block(
    width: 100%,
    radius: 3pt,
    inset: 12pt,
    fill: if thesis-color-state.get() { fhnw-teal.lighten(90%) } else { fhnw-white },
    stroke: (paint: accent, thickness: 0.5pt),
  )[
    #text(weight: "bold", fill: accent)[#title.] #h(0.3em) #content
  ]
}

#let theorem(title: "Theorem", content) = context {
  let accent = if thesis-color-state.get() { fhnw-dark-gray } else { fhnw-dark-gray }
  block(
    width: 100%,
    radius: 3pt,
    inset: 12pt,
    fill: if thesis-color-state.get() { fhnw-light-gray.lighten(70%) } else { fhnw-white },
    stroke: (paint: accent, thickness: 0.5pt),
  )[
    #text(weight: "bold", fill: accent)[#title.] #h(0.3em) #content
  ]
}

// ============================================================================
// Common abbreviations
// ============================================================================

#let ie = [_i.e._]
#let eg = [_e.g._]
#let cf = [_cf._]
#let etal = [_et al._]
