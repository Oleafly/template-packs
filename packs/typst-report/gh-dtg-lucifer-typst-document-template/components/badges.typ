// components/badges.typ
// Status badges, MITRE ATT&CK tags, and metadata chips.

#import "theme.typ": resolve-palette, current-theme

// Generic Pill Badge
#let badge(
  text-content,
  fill: none,
  stroke: none,
  text-color: none,
  size: 8pt,
  radius: 3pt,
  tracking: 0.5pt,
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let bg = if fill != none { fill } else { p.badges.tag.bg }
  let border = if stroke != none { stroke } else { 0.4pt + p.badges.tag.border }
  let fg = if text-color != none { text-color } else { p.badges.tag.text }

  box(
    fill: bg,
    stroke: border,
    radius: radius,
    inset: (x: 5pt, y: 2pt),
    outset: (y: 1pt),
    baseline: 0%,
    [#text(size: size, weight: "bold", fill: fg, tracking: tracking)[#text-content]]
  )
}

// System Policy & Threat Level Status Badge
// Recognized status values: "allow", "alert_admin", "isolate_device", "normal", "suspicious", "critical", "info", "success", "warning"
#let status-badge(
  status,
  label: none,
  size: 8pt,
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let s = lower(str(status))
  let display-text = if label != none { label } else { upper(str(status)) }

  let b-config = if s in ("allow", "success", "benign") {
    p.badges.allow
  } else if s in ("alert", "alert_admin", "suspicious", "warning") {
    p.badges.alert
  } else if s in ("isolate", "isolate_device", "critical", "danger") {
    p.badges.isolate
  } else if s in ("normal",) {
    p.badges.normal
  } else if s in ("info",) {
    p.badges.info
  } else {
    p.badges.tag
  }

  box(
    fill: b-config.bg,
    stroke: 0.5pt + b-config.border,
    radius: 3pt,
    inset: (x: 5.5pt, y: 2pt),
    outset: (y: 1pt),
    baseline: 0%,
    [#text(size: size, weight: "bold", fill: b-config.text, tracking: 0.5pt)[#display-text]]
  )
}

// MITRE ATT&CK Technique Tag
// Example: #mitre-tag("T1046", name: "Network Service Scanning")
#let mitre-tag(
  code,
  name: none,
  size: 8pt,
) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  box(
    fill: if p.mode == "dark" { rgb("#162032") } else { rgb("#f1f5f9") },
    stroke: 0.5pt + if p.mode == "dark" { rgb("#2a3b53") } else { rgb("#cbd5e1") },
    radius: 3pt,
    inset: (x: 5pt, y: 2pt),
    outset: (y: 1pt),
    baseline: 0%,
    [
      #text(font: ("SF Mono", "IBM Plex Mono", "DejaVu Sans Mono"), size: size, weight: "bold", fill: p.primary)[#code]
      #if name != none [
        #text(size: size, fill: p.text-muted)[: #name]
      ]
    ]
  )
}

// Tech / Component Tag
// Example: #tech-tag("Raft Consensus", category: "PROTOCOL")
#let tech-tag(
  name,
  category: none,
  size: 8pt,
) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  box(
    fill: if p.mode == "dark" { rgb("#162032") } else { rgb("#f1f5f9") },
    stroke: 0.5pt + if p.mode == "dark" { rgb("#2a3b53") } else { rgb("#cbd5e1") },
    radius: 3pt,
    inset: (x: 5pt, y: 2pt),
    outset: (y: 1pt),
    baseline: 0%,
    [
      #if category != none [
        #text(size: 7pt, weight: "bold", fill: p.secondary, tracking: 0.5pt)[#upper(category) ]
      ]
      #text(font: ("SF Mono", "IBM Plex Mono", "DejaVu Sans Mono"), size: size, weight: "bold", fill: p.primary)[#name]
    ]
  )
}

// Monospace Code / Protocol Tag
#let protocol-tag(name) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  box(
    fill: if p.mode == "dark" { rgb("#082032") } else { rgb("#e0f2fe") },
    stroke: 0.4pt + if p.mode == "dark" { rgb("#38bdf8") } else { rgb("#bae6fd") },
    radius: 3pt,
    inset: (x: 4.5pt, y: 1.5pt),
    baseline: 0%,
    text(
      font: ("SF Mono", "IBM Plex Mono", "DejaVu Sans Mono"),
      size: 7.5pt,
      weight: "bold",
      fill: if p.mode == "dark" { rgb("#7dd3fc") } else { rgb("#0369a1") }
    )[#name]
  )
}
