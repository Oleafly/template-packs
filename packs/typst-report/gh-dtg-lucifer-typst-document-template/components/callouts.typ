// components/callouts.typ
// Signature Callout, Takeaway, and Challenge blocks modeled directly after the Veritas technical report.
// Fully reactive to light/dark themes with crisp typography and letter-spaced category headers.

#import "theme.typ": resolve-palette, current-theme

// Signature Concept Callout Box (Blue)
#let callout(
  title: "In Simple Words",
  label: "CONCEPT NOTE",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let c = p.callout

  rect(
    width: 100%,
    radius: 4pt,
    fill: c.bg,
    stroke: (left: 3.5pt + c.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
    outset: 0pt,
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: c.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: c.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: c.text, size: 0.95em, style: "normal")[#body]
  ]
}

// Signature Key Architectural / Technical Takeaway Box (Green)
#let takeaway(
  title: "Key Architectural Takeaway",
  label: "ARCHITECTURAL PRINCIPLE",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let t = p.takeaway

  rect(
    width: 100%,
    radius: 4pt,
    fill: t.bg,
    stroke: (left: 3.5pt + t.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
    outset: 0pt,
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: t.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: t.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: t.text, size: 0.95em)[#body]
  ]
}

// Signature Engineering Challenge & Resolution Box (Orange)
#let challenge-box(
  challenge: "Engineering Challenge",
  problem: "",
  solution: "",
  label: "ENGINEERING CHALLENGE & RESOLUTION",
  theme: none,
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let ch = p.challenge

  rect(
    width: 100%,
    radius: 4pt,
    fill: ch.bg,
    stroke: (left: 3.5pt + ch.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
    outset: 0pt,
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: ch.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if challenge != "" [
      #text(weight: "bold", fill: ch.title, size: 1.05em)[#challenge]
      #v(5pt)
    ]
    #if problem != "" [
      #text(weight: "bold", fill: ch.problem-title)[The Operational Problem:] #text(fill: ch.problem-text)[#problem]
      #v(5pt)
    ]
    #if solution != "" [
      #text(weight: "bold", fill: ch.solution-title)[Engineering Resolution:] #text(fill: ch.solution-text)[#solution]
    ]
  ]
}

// Information Callout (Sky Blue)
#let info(
  title: "Information",
  label: "INFO",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let inf = p.info

  rect(
    width: 100%,
    radius: 4pt,
    fill: inf.bg,
    stroke: (left: 3.5pt + inf.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: inf.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: inf.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: inf.text, size: 0.95em)[#body]
  ]
}

// Warning Callout (Amber)
#let warning(
  title: "Warning",
  label: "WARNING",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let w = p.warning

  rect(
    width: 100%,
    radius: 4pt,
    fill: w.bg,
    stroke: (left: 3.5pt + w.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: w.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: w.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: w.text, size: 0.95em)[#body]
  ]
}

// Danger / Critical Alert Callout (Crimson)
#let danger(
  title: "Critical Security Alert",
  label: "CRITICAL ALERT",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let d = p.danger

  rect(
    width: 100%,
    radius: 4pt,
    fill: d.bg,
    stroke: (left: 3.5pt + d.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: d.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: d.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: d.text, size: 0.95em)[#body]
  ]
}

// Pro-Tip / Recommendation Callout (Emerald)
#let tip(
  title: "Pro-Tip",
  label: "RECOMMENDATION",
  theme: none,
  body
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let t = p.takeaway

  rect(
    width: 100%,
    radius: 4pt,
    fill: t.bg,
    stroke: (left: 3.5pt + t.border, rest: 0.5pt + p.border),
    inset: (x: 14pt, y: 11pt),
  )[
    #if label != none [
      #text(size: 8pt, weight: "bold", fill: t.label, tracking: 1.5pt)[#label]
      #v(2pt)
    ]
    #if title != none [
      #text(weight: "bold", fill: t.title, size: 1.05em)[#title]
      #v(4pt)
    ]
    #text(fill: t.text, size: 0.95em)[#body]
  ]
}

// Standout Centered Highlight / Contrast Box
// Used in the demo to contrast point-in-time questions vs. world-model foresight
#let highlight-box(
  variant: "blue", // "blue", "green", "red", "amber", "neutral"
  width: 100%,
  align-mode: center,
  body
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let is-dark = p.mode == "dark"

  let (bg, border, text-color) = if variant == "green" {
    if is-dark {
      (rgb("#052e16"), rgb("#22c55e"), rgb("#86efac"))
    } else {
      (rgb("#f0fdf4"), rgb("#4ade80"), rgb("#166534"))
    }
  } else if variant == "red" {
    if is-dark {
      (rgb("#450a0a"), rgb("#f87171"), rgb("#fca5a5"))
    } else {
      (rgb("#fef2f2"), rgb("#f87171"), rgb("#991b1b"))
    }
  } else if variant == "amber" {
    if is-dark {
      (rgb("#451a03"), rgb("#fbbf24"), rgb("#fde68a"))
    } else {
      (rgb("#fffbeb"), rgb("#f59e0b"), rgb("#92400e"))
    }
  } else if variant == "neutral" {
    if is-dark {
      (rgb("#0f172a"), rgb("#334155"), rgb("#cbd5e1"))
    } else {
      (rgb("#f8fafc"), rgb("#cbd5e1"), rgb("#334155"))
    }
  } else {
    // Default blue
    if is-dark {
      (rgb("#0d1b33"), rgb("#3b82f6"), rgb("#93c5fd"))
    } else {
      (rgb("#eff6ff"), rgb("#3b82f6"), rgb("#1e3a8a"))
    }
  }

  align(align-mode)[
    #block(
      fill: bg,
      stroke: 1pt + border,
      inset: (x: 14pt, y: 10pt),
      radius: 5pt,
      width: width,
      text(fill: text-color, weight: "bold")[#body]
    )
  ]
}
