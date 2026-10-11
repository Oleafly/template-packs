// University of Melbourne Thesis Template - Utilities

#import "../assets/colors/unimelb-colors.typ": *
#import "./fonts.typ": font-theme, font-themes

// Package imports
#import "@preview/cetz:0.5.2"
#import "@preview/codly:1.3.0": *
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.8": gridx, hlinex, tablex, vlinex
#import "@preview/unify:0.7.0": unit
#import "@preview/theorion:0.4.0": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.0": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/zebraw:0.4.0": zebraw
#import "@preview/equate:0.2.1": *
#import "@preview/showybox:2.0.1": showybox
#import "@preview/codetastic:0.2.2": qrcode
#import "@preview/glossarium:0.5.1": gls, glspl, make-glossary, print-glossary

#let make-thesis-style(font_theme: "unimelb", profile: "default") = {
  let fonts = font-theme(name: font_theme)

  // Profile-aware color definitions
  let color-space = if profile == "print" { cmyk } else { rgb }

  (
    fonts: fonts,
    colors: (
      primary: color-space(traditional-heritage-100), // Official UoM blue #000F46
      secondary: color-space(magpie-dark-100), // Official dark grey #2D2D2D
      accent: color-space(sheoak-light-100), // Official red #FF2D3C
      success: color-space(red-gum-light-100), // Official green #9FB825
      warning: color-space(yam-daisy-100), // Official yellow #FFD629
      link: color-space(link), // Official link color #083973
      background: color-space(white), // White background
      surface: color-space(magpie-light-25), // Light grey surface #F1F1F1
    ),
    spacing: (
      paragraph-leading: 1.2em,
      heading-above: ("1": 2em, "2": 1.5em, "3": 1em),
      heading-below: ("1": 1em, "2": 0.8em, "3": 0.5em),
    ),
  )
}

#let thesis-style = make-thesis-style(profile: "default")

#let available-font-themes = font-themes()

// =================================
// Theorem Environment Setup
// =================================

// Configure theorion for theorem environments (no init function needed)
// #show: theorion-init

#let theorem-counter = counter("theorem")
#let theorem(title: none, body) = context {
  theorem-counter.step()
  block[
    *Theorem #theorem-counter.display().*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let lemma-counter = counter("lemma")
#let lemma(title: none, body) = context {
  lemma-counter.step()
  block[
    *Lemma #lemma-counter.display().*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let corollary-counter = counter("corollary")
#let corollary(title: none, body) = context {
  corollary-counter.step()
  block[
    *Corollary #corollary-counter.display().*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let definition-counter = counter("definition")
#let definition(title: none, body) = context {
  definition-counter.step()
  block[
    *Definition #definition-counter.display().*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let example-counter = counter("example")
#let example(title: none, body) = context {
  example-counter.step()
  block[
    *Example #example-counter.display().*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let remark(title: none, body) = {
  block[
    *Remark.*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

// =================================
// Algorithm Environment
// =================================

#let algorithm-counter = counter("algorithm")

#let algorithm(
  body,
  caption: none,
  title: none,
  breakable: false,
) = {
  algorithm-counter.step()
  let algorithm-title = if title != none {
    title
  } else {
    [Algorithm #algorithm-counter.display()]
  }

  figure(
    kind: "algorithm",
    supplement: "Algorithm",
    caption: caption,
    pseudocode(
      body,
      booktabs: true,
      numbered-title: algorithm-title,
    ),
  )
}

// =================================
// Enhanced Code Display
// =================================

// Configure codly for code highlighting with comprehensive language support
#show: codly-init.with()

#codly(
  languages: (
    rust: (name: "Rust", icon: "🦀", color: rgb("#000000")),
    python: (name: "Python", icon: "🐍", color: rgb("#3776AB")),
    typst: (name: "Typst", icon: "📝", color: rgb("#239DAD")),
    javascript: (name: "JavaScript", icon: "🟨", color: rgb("#F7DF1E")),
    java: (name: "Java", icon: "☕", color: rgb("#ED8B00")),
    cpp: (name: "C++", icon: "⚡", color: rgb("#00599C")),
    c: (name: "C", icon: "⚡", color: rgb("#A8B9CC")),
    r: (name: "R", icon: "📊", color: rgb("#276DC3")),
    matlab: (name: "MATLAB", icon: "🔢", color: rgb("#0076A8")),
    bash: (name: "Bash", icon: "💻", color: rgb("#4EAA25")),
    sql: (name: "SQL", icon: "🗄️", color: rgb("#336791")),
    latex: (name: "LaTeX", icon: "📄", color: rgb("#008080")),
  ),
  display-name: true,
  display-icon: true,
  zebra-fill: rgb("#f8f8f8"),
  radius: 3pt,
)

// Enhanced code block with captioning and consistent styling
#let code-block(
  body,
  lang: none,
  caption: none,
  numbers: true,
  breakable: false,
) = {
  if caption != none {
    figure(
      kind: "code",
      supplement: "Listing",
      caption: caption,
      if numbers {
        zebraw(body, lang: lang)
      } else {
        raw(body, lang: lang, block: true)
      },
    )
  } else {
    if numbers {
      zebraw(body, lang: lang)
    } else {
      raw(body, lang: lang, block: true)
    }
  }
}

// =================================
// Enhanced Table and Figure Functions
// =================================

#let thesis-table = tablex.with(
  auto-lines: false,
  header-rows: 1,
  header-hlines-have-priority: true,
  column-gutter: 1em,
)

#let thesis-figure = figure.with(
  gap: 1em,
  placement: auto,
)

// Subfigure support
#let subfigure = figure.with(
  kind: "subfigure",
  supplement: "Figure",
  numbering: numbly("{1.1}a)", default: "1.1)"),
)

// =================================
// Word Count and Statistics
// =================================

#let word-count(text) = {
  let words = text.split(regex("\\s+")).filter(w => w != "")
  words.len()
}

#let char-count(text) = {
  text.len()
}

#let page-count = context {
  counter(page).final().first()
}

// =================================
// Utility Functions
// =================================

// Profile-aware image function with compression for draft/screen profiles
#let thesis-image(path, ..args) = {
  let profile = sys.inputs.at("profile", default: "default")

  // Apply compression optimizations based on profile
  if profile == "draft" {
    // Maximum compression for draft - convert to low-quality PNG
    if path.ends-with(".svg") {
      image(path, ..args)
    } else {
      // Force PNG conversion with potential quality loss for faster compilation
      image(path, format: "png", ..args)
    }
  } else if profile == "screen" {
    // Balanced compression for screen viewing
    if path.ends-with(".svg") {
      image(path, ..args)
    } else {
      // Convert to PNG for web-optimized compression
      image(path, format: "png", ..args)
    }
  } else if profile == "print" {
    // High quality for print - preserve original format and quality
    image(path, ..args)
  } else {
    // Default profile - standard handling
    image(path, ..args)
  }
}

// Format dates
#let format-date(date) = {
  let months = (
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  )
  [#date.day() #months.at(date.month() - 1) #date.year()]
}

// Use a caller-provided official logo; keep the public template redistributable.
#let unimelb-logo(custom: none) = {
  if custom != none {
    thesis-image(custom, width: 4cm)
  } else {
    box(
      width: 4cm,
      inset: 8pt,
      stroke: 0.5pt + gray,
      align(center)[University of Melbourne],
    )
  }
}

#let make-spine-text(author: none, title: none, degree: none, year: none) = {
  let segments = (
    if author != none { author } else { none },
    if title != none { title } else { none },
    if degree != none { degree } else { none },
    if year != none { str(year) } else { none },
  ).filter(x => x != none)
  if segments.len() == 0 {
    []
  } else {
    segments.join(" · ")
  }
}

// =================================
// Advanced Package Utilities
// =================================

// Equation numbering and referencing
#let equation-env = equate.with(
  sub-numbering: true,
  number-mode: "label",
)

// Showybox for highlighted content
#let info-box = showybox.with(
  frame: (
    border-color: rgb(traditional-heritage-100),
    title-color: rgb(traditional-heritage-100),
    body-color: rgb(traditional-heritage-100).lighten(95%),
  ),
  title-style: (
    color: white,
    weight: "bold",
  ),
)

#let warning-box = showybox.with(
  frame: (
    border-color: rgb(sheoak-light-100),
    title-color: rgb(sheoak-light-100),
    body-color: rgb(sheoak-light-100).lighten(95%),
  ),
  title-style: (
    color: white,
    weight: "bold",
  ),
)

#let success-box = showybox.with(
  frame: (
    border-color: rgb(red-gum-light-100),
    title-color: rgb(red-gum-light-100),
    body-color: rgb(red-gum-light-100).lighten(95%),
  ),
  title-style: (
    color: white,
    weight: "bold",
  ),
)

// =================================
// QR Code Generation
// =================================

#let generate-qr = qrcode.with(
  width: 2cm,
  height: 2cm,
  error-correction: "M",
)

// =================================
// Landscape Page Support
// =================================

#let landscape-page(body) = {
  // Ensure landscape pages keep the same paper size (A4) and margins.
  // Avoid changing height/width directly to prevent mixed page sizes.
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    flipped: true,
  )
  body
  // Restore to portrait A4 after the landscape content.
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    flipped: false,
  )
}

// =================================
// Advanced Theorem Environments
// =================================

#let proposition(title: none, body) = {
  block[
    *Proposition.*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let axiom(title: none, body) = {
  block[
    *Axiom.*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

#let conjecture(title: none, body) = {
  block[
    *Conjecture.*#h(1em)
    #if title != none [*#title.* #h(1em)]
    #body
  ]
}

// =================================
// Export all utilities
// =================================
