#import "@preview/touying:0.7.4": *
#import "@preview/showybox:2.0.4": showybox
#import "colors.typ": *
#import "fonts.typ": hcs-fonts-state

/// Reusable callout card with cute rounded corners and clean header
#let cblock(
  title: none,
  type: "info", // "info", "exercise", "tip", "warning", "danger", "cute"
  color: none,
  bg: none,
  border: none,
  radius: 6pt,
  body,
) = {
  let theme = hcs-semantic.at(type, default: hcs-semantic.info)
  let bar-color = if color != none { color } else { theme.primary }
  let body-bg = if bg != none { bg } else { theme.bg }
  let border-color = if border != none { border } else { theme.border }

  let title-arg = if title != none [
    #context {
      let f = hcs-fonts-state.get()
      text(font: f.heading, weight: "bold", size: 0.95em)[#title]
    }
  ] else { none }

  showybox(
    title-style: (
      color: white,
      sep-thickness: 0pt,
      align: horizon,
    ),
    frame: (
      radius: radius,
      thickness: 1pt,
      border-color: border-color,
      title-color: bar-color,
      body-color: body-bg,
      inset: (x: 0.9em, y: 0.75em),
    ),
    above: 0.7em,
    below: 0.7em,
    title: title-arg,
    [
      #context {
        let f = hcs-fonts-state.get()
        set text(font: f.body, fill: hcs-text, size: 0.92em)
        body
      }
    ]
  )
}

/// Hands-on workshop exercise card with metadata badges (time, difficulty, points)
#let exercise-box(
  title: [Workshop Exercise],
  time: none,
  difficulty: none,
  points: none,
  body,
) = context {
  let f = hcs-fonts-state.get()
  let badges = ()
  if time != none {
    badges.push(box(
      fill: rgb("#DDD6FE"),
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: rgb("#5B21B6"), size: 0.78em, weight: "bold")[⏱ #time]
    ))
  }
  if difficulty != none {
    badges.push(box(
      fill: rgb("#C7D2FE"),
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: rgb("#3730A3"), size: 0.78em, weight: "bold")[★ #difficulty]
    ))
  }
  if points != none {
    badges.push(box(
      fill: rgb("#FBCFE8"),
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: rgb("#9D174D"), size: 0.78em, weight: "bold")[#points pts]
    ))
  }

  showybox(
    frame: (
      radius: 6pt,
      thickness: 1.5pt,
      border-color: rgb("#8B5CF6"),
      title-color: rgb("#7C3AED"),
      body-color: rgb("#FAF5FF"),
      inset: (x: 1em, y: 0.85em),
    ),
    above: 0.8em,
    below: 0.8em,
    title: grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(font: f.heading, weight: "bold", size: 1em, fill: white)[#title],
      stack(dir: ltr, spacing: 0.4em, ..badges)
    ),
    [
      #set text(font: f.body, fill: hcs-text, size: 0.92em)
      #body
    ]
  )
}

/// Quote block with a tight left accent pill and subtle background
#let quote-block(body, author: none, color: hcs-blue) = context {
  let f = hcs-fonts-state.get()
  block(
    stroke: (left: 3.5pt + color),
    inset: (left: 0.9em, y: 0.2em),
    [
      #set text(font: f.body, fill: hcs-text, style: "italic", size: 0.95em)
      #body
      #if author != none [
        #v(0.3em)
        #set text(font: f.body, style: "normal", fill: hcs-text-muted, size: 0.85em)
        --- #author
      ]
    ]
  )
}

/// Multi-column layout helper for side-by-side comparisons
#let split(..bodies, columns: auto, gutter: 1.2em, align: top + left) = {
  let list = bodies.pos()
  let cols = if columns == auto { (1fr,) * list.len() } else { columns }
  grid(
    columns: cols,
    gutter: gutter,
    align: align,
    ..list.map(b => block(width: 100%, b))
  )
}

/// Rounded cute pill badge for tags, categories, or status
#let badge(label, fill: hcs-slate-light, color: hcs-navy, radius: 100pt, icon: none) = context {
  let f = hcs-fonts-state.get()
  box(
    fill: fill,
    radius: radius,
    inset: (x: 0.65em, y: 0.25em),
    baseline: 0%,
    [
      #if icon != none [ #icon #h(0.2em) ]
      #text(font: f.accent, fill: color, size: 0.8em, weight: "bold")[#label]
    ]
  )
}

/// Stat / Metric card
#let stat-card(value, label, subtext: none, color: hcs-blue, bg: hcs-surface) = context {
  let f = hcs-fonts-state.get()
  block(
    fill: bg,
    stroke: 1pt + hcs-slate-light,
    radius: 6pt,
    inset: (x: 1em, y: 0.8em),
    width: 100%,
    [
      #text(font: f.accent, fill: color, size: 1.8em, weight: "bold")[#value] \
      #v(-0.3em)
      #text(font: f.heading, fill: hcs-navy, size: 0.9em, weight: "bold")[#label]
      #if subtext != none [
        \ #text(font: f.body, fill: hcs-text-muted, size: 0.75em)[#subtext]
      ]
    ]
  )
}

/// Numbered workshop step
#let step(num, title: none, body) = context {
  let f = hcs-fonts-state.get()
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    align: (top + left, top + left),
    box(
      fill: hcs-navy,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: white, size: 0.85em, weight: "bold")[#num]
    ),
    [
      #if title != none [
        #text(font: f.heading, weight: "bold", fill: hcs-navy)[#title] \
      ]
      #set text(font: f.body, fill: hcs-text, size: 0.92em)
      #body
    ]
  )
  v(0.4em)
}

/// Speaker note for presenter mode (pdfpc)
#let note(text) = [
  #pdfpc.speaker-note(text)
]
