// =============================================================================
// DECORATIVE.TYP - Ornaments, dividers, drop caps, and decorative elements
// =============================================================================

// =============================================================================
// DROP CAPS - Multiple styles for chapter openings
// =============================================================================

/// Simple drop cap (2-3 lines tall)
#let drop-cap(letter, body, height: 2, color: black) = {
  let cap = text(size: height * 1.5em, weight: "bold", fill: color)[#letter]
  box[
    #place(top + left, cap)
    #h(1.2em)
    #body
  ]
}

/// Gothic/Medieval style drop cap
#let drop-cap-gothic(letter, body, height: 3) = {
  box[
    #place(top + left)[
      #box(
        width: height * 1em,
        height: height * 1em,
        fill: rgb("#2c2c2c"),
        inset: 4pt,
      )[
        #align(center + horizon)[
          #text(
            size: (height - 0.5) * 1em,
            weight: "bold",
            fill: rgb("#d4af37"),
            font: ("UnifrakturMaguntia", "Old English Text MT", "serif"),
          )[#letter]
        ]
      ]
    ]
    #h(height * 1em + 8pt)
    #body
  ]
}

/// Art Nouveau style drop cap with decorative border
#let drop-cap-nouveau(letter, body, height: 3, accent: rgb("#8b4513")) = {
  box[
    #place(top + left)[
      #box(
        width: height * 1.2em,
        height: height * 1.2em,
        stroke: 2pt + accent,
        radius: 4pt,
        inset: 4pt,
      )[
        #align(center + horizon)[
          #text(
            size: (height - 0.3) * 1em,
            weight: "regular",
            style: "italic",
            fill: accent,
          )[#letter]
        ]
      ]
    ]
    #h(height * 1.2em + 12pt)
    #body
  ]
}

/// Modern minimalist drop cap
#let drop-cap-modern(letter, body, height: 2, color: rgb("#333")) = {
  box[
    #place(top + left)[
      #text(
        size: height * 2em,
        weight: "thin",
        fill: color,
        tracking: -0.05em,
      )[#letter]
    ]
    #h(height * 1.1em)
    #body
  ]
}

/// Outlined drop cap
#let drop-cap-outline(letter, body, height: 2, color: black) = {
  box[
    #place(top + left)[
      #text(
        size: height * 1.8em,
        weight: "bold",
        fill: none,
        stroke: 1.5pt + color,
      )[#letter]
    ]
    #h(height * 1em)
    #body
  ]
}

/// Circled drop cap
#let drop-cap-circled(letter, body, height: 2, bg: rgb("#f0f0f0"), fg: black) = {
  box[
    #place(top + left)[
      #circle(
        radius: height * 0.7em,
        fill: bg,
      )[
        #align(center + horizon)[
          #text(size: height * 0.9em, weight: "bold", fill: fg)[#letter]
        ]
      ]
    ]
    #h(height * 1.5em + 4pt)
    #body
  ]
}

// =============================================================================
// SECTION DIVIDERS
// =============================================================================

/// Classic asterisk divider
#let divider-asterisks(count: 3, spacing: 0.5em) = {
  v(1em)
  align(center)[
    #for i in range(count) {
      if i > 0 { h(spacing) }
      [\*]
    }
  ]
  v(1em)
}

/// Fleuron divider (decorative leaf/flower)
#let divider-fleuron(symbol: "❧", size: 1.5em) = {
  v(1em)
  align(center)[
    #text(size: size)[#symbol]
  ]
  v(1em)
}

/// Line divider with optional center ornament
#let divider-line(width: 40%, ornament: none, stroke-width: 0.5pt) = {
  v(0.8em)
  align(center)[
    #if ornament != none {
      grid(
        columns: (1fr, auto, 1fr),
        align: horizon,
        line(length: 100%, stroke: stroke-width + black),
        h(0.5em) + text(size: 1.2em)[#ornament] + h(0.5em),
        line(length: 100%, stroke: stroke-width + black),
      )
    } else {
      line(length: width, stroke: stroke-width + black)
    }
  ]
  v(0.8em)
}

/// Double line divider
#let divider-double-line(width: 50%, gap: 3pt) = {
  v(0.8em)
  align(center)[
    #box(width: width)[
      #line(length: 100%, stroke: 0.5pt + black)
      #v(gap)
      #line(length: 100%, stroke: 0.5pt + black)
    ]
  ]
  v(0.8em)
}

/// Wave divider
#let divider-wave(width: 60%) = {
  v(1em)
  align(center)[
    #text(size: 0.8em, tracking: 0.2em, fill: rgb("#888"))[
      #for i in range(15) { [∿] }
    ]
  ]
  v(1em)
}

/// Diamond divider
#let divider-diamonds(count: 3, size: 0.5em) = {
  v(1em)
  align(center)[
    #for i in range(count) {
      if i > 0 { h(size) }
      text(size: size)[◆]
    }
  ]
  v(1em)
}

/// Dotted divider
#let divider-dots(count: 5, spacing: 1em) = {
  v(1em)
  align(center)[
    #for i in range(count) {
      if i > 0 { h(spacing) }
      [•]
    }
  ]
  v(1em)
}

/// Scene break (for novels)
#let scene-break(style: "asterisks") = {
  if style == "asterisks" {
    divider-asterisks()
  } else if style == "line" {
    divider-line()
  } else if style == "space" {
    v(2em)
  } else if style == "fleuron" {
    divider-fleuron()
  } else {
    divider-asterisks()
  }
}

// =============================================================================
// CHAPTER ORNAMENTS
// =============================================================================

/// Decorative chapter number
#let chapter-number-ornate(number, style: "boxed") = {
  if style == "boxed" {
    box(
      fill: rgb("#333"),
      inset: 12pt,
      radius: 4pt,
    )[
      #text(fill: white, size: 2em, weight: "bold")[#number]
    ]
  } else if style == "circled" {
    circle(
      radius: 1.5em,
      fill: none,
      stroke: 2pt + black,
    )[
      #align(center + horizon)[
        #text(size: 1.5em, weight: "bold")[#number]
      ]
    ]
  } else if style == "underlined" {
    stack(
      dir: ttb,
      spacing: 4pt,
      text(size: 3em, weight: "bold")[#number],
      line(length: 2em, stroke: 2pt + black),
    )
  } else if style == "roman" {
    text(size: 2em, tracking: 0.1em)[
      #upper(numbering("I", number))
    ]
  }
}

/// Chapter heading with decorative elements
#let chapter-heading-decorated(
  number: none,
  title,
  subtitle: none,
  ornament: "═",
) = {
  v(3em)
  align(center)[
    #if number != none {
      text(size: 0.9em, tracking: 0.3em, fill: rgb("#666"))[CHAPTER]
      v(0.3em)
      chapter-number-ornate(number, style: "underlined")
      v(1em)
    }
    
    // Ornament line above
    text(size: 0.8em, tracking: 0.5em, fill: rgb("#999"))[
      #for i in range(10) { ornament }
    ]
    v(0.5em)
    
    // Title
    text(size: 2em, weight: "bold")[#title]
    
    #if subtitle != none {
      v(0.3em)
      text(size: 1.1em, style: "italic", fill: rgb("#555"))[#subtitle]
    }
    
    // Ornament line below
    v(0.5em)
    text(size: 0.8em, tracking: 0.5em, fill: rgb("#999"))[
      #for i in range(10) { ornament }
    ]
  ]
  v(2em)
}

// =============================================================================
// BORDERS AND FRAMES
// =============================================================================

/// Simple frame
#let frame-simple(body, padding: 12pt) = {
  block(
    width: 100%,
    stroke: 1pt + black,
    inset: padding,
  )[#body]
}

/// Double frame
#let frame-double(body, padding: 12pt, gap: 3pt) = {
  block(
    width: 100%,
    stroke: 1pt + black,
    inset: gap,
  )[
    #block(
      width: 100%,
      stroke: 1pt + black,
      inset: padding,
    )[#body]
  ]
}

/// Decorative corner frame
#let frame-corners(body, padding: 16pt, corner-size: 12pt) = {
  let corner = box(width: corner-size, height: corner-size)[
    #place(top + left)[#line(length: corner-size, stroke: 1.5pt + black)]
    #place(top + left)[#line(length: corner-size, angle: 90deg, stroke: 1.5pt + black)]
  ]
  
  block(
    width: 100%,
    inset: padding,
  )[
    #place(top + left, dx: -padding/2, dy: -padding/2)[#corner]
    #place(top + right, dx: padding/2, dy: -padding/2)[#scale(x: -100%)[#corner]]
    #place(bottom + left, dx: -padding/2, dy: padding/2)[#scale(y: -100%)[#corner]]
    #place(bottom + right, dx: padding/2, dy: padding/2)[#scale(x: -100%, y: -100%)[#corner]]
    #body
  ]
}

/// Rounded frame with shadow effect
#let frame-shadow(body, padding: 12pt, shadow-offset: 3pt, radius: 4pt) = {
  block[
    #place(dx: shadow-offset, dy: shadow-offset)[
      #block(
        width: 100%,
        fill: rgb("#ccc"),
        radius: radius,
        inset: padding,
      )[#hide[#body]]
    ]
    #block(
      width: 100%,
      fill: white,
      stroke: 1pt + rgb("#333"),
      radius: radius,
      inset: padding,
    )[#body]
  ]
}

// =============================================================================
// DECORATIVE TEXT STYLES
// =============================================================================

/// Small caps text
#let smallcaps-text(body) = {
  text(tracking: 0.05em)[#smallcaps[#body]]
}

/// Letterspaced text (for emphasis)
#let letterspaced(body, amount: 0.1em) = {
  text(tracking: amount)[#body]
}

/// Initial word styling (first word of chapter)
#let initial-word(word, rest) = {
  text(tracking: 0.1em, weight: "semibold")[#upper(word)]
  [ ]
  rest
}

/// Swash/flourish text (if font supports)
#let swash-text(body) = {
  text(style: "italic", tracking: 0.02em)[#body]
}

// =============================================================================
// PAGE DECORATIONS
// =============================================================================

/// Corner flourish for pages
#let page-corner-flourish(position: "top-right", symbol: "❦") = {
  let pos = if position == "top-right" { top + right }
    else if position == "top-left" { top + left }
    else if position == "bottom-right" { bottom + right }
    else { bottom + left }
  
  place(pos, dx: if position.contains("right") { -1em } else { 1em },
        dy: if position.contains("top") { 1em } else { -1em })[
    #text(size: 1.5em, fill: rgb("#999"))[#symbol]
  ]
}

/// Running ornament in header/footer
#let running-ornament(ornament: "•", repeat: 3) = {
  for i in range(repeat) {
    if i > 0 { h(0.5em) }
    text(size: 0.6em)[#ornament]
  }
}

// =============================================================================
// PULL QUOTES AND HIGHLIGHTS
// =============================================================================

/// Large pull quote with decorative marks
#let pull-quote-decorated(body, attribution: none) = {
  v(1em)
  block(
    width: 100%,
    inset: (x: 2em, y: 1em),
  )[
    #align(center)[
      #text(size: 3em, fill: rgb("#ddd"))["]
      #v(-1.5em)
      #text(size: 1.4em, style: "italic", fill: rgb("#444"))[#body]
      #v(-0.5em)
      #text(size: 3em, fill: rgb("#ddd"))["]
      #if attribution != none {
        v(0.5em)
        line(length: 3em, stroke: 1pt + rgb("#999"))
        v(0.3em)
        text(size: 0.9em, tracking: 0.05em, fill: rgb("#666"))[#upper(attribution)]
      }
    ]
  ]
  v(1em)
}

/// Highlighted text box
#let highlight-block(body, color: rgb("#fffde7"), border-color: rgb("#ffd54f")) = {
  block(
    width: 100%,
    fill: color,
    stroke: (left: 4pt + border-color),
    inset: 12pt,
  )[#body]
}

// =============================================================================
// Part Dividers
// =============================================================================

/// Part divider page
#let part-page(number: none, title, subtitle: none) = {
  set page(numbering: none)
  v(1fr)
  
  align(center)[
    #if number != none [
      #text(size: 1.2em, tracking: 0.3em)[PART #number]
      #v(1em)
    ]
    #text(size: 2em, weight: "bold")[#title]
    #if subtitle != none [
      #v(0.5em)
      #text(size: 1.1em, style: "italic")[#subtitle]
    ]
  ]
  
  v(1fr)
  pagebreak()
}

// =============================================================================
// Utility Components
// =============================================================================

/// Blank page with optional text
#let blank-page(message: none) = {
  set page(numbering: none)
  if message != none {
    v(1fr)
    align(center)[
      #text(style: "italic", fill: gray)[#message]
    ]
    v(1fr)
  }
  pagebreak()
}

/// Notes page for reader notes
#let notes-page(title: "Notes", lines: 20) = {
  heading(outlined: false, numbering: none, level: 1)[#title]
  v(1em)
  
  for i in range(lines) {
    line(length: 100%, stroke: 0.5pt + gray)
    v(1.5em)
  }
  
  pagebreak()
}