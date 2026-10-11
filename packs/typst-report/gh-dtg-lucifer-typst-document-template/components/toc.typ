// components/toc.typ
// Table of Contents, List of Figures, and List of Tables helpers and entry formatting.

#import "theme.typ": resolve-palette, current-theme

// Styled Table of Contents Header
#let toc-header(title: "Table of Contents") = context {
  let p = resolve-palette(theme-override: current-theme.get())

  v(12pt)
  text(
    fill: p.primary,
    size: 16pt,
    weight: "bold",
    title
  )
  v(8pt)
  line(length: 100%, stroke: 0.5pt + p.border)
  v(10pt)
}

// Formatted TOC outline entry
#let format-toc-entry(it) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  if it.level == 1 {
    v(6pt)
    text(fill: p.primary, weight: "bold", it)
  } else if it.level == 2 {
    v(2pt)
    text(fill: p.text, weight: "medium", it)
  } else {
    text(fill: p.text-muted, it)
  }
}

// Outline Divider Line
#let outline-divider() = context {
  let p = resolve-palette(theme-override: current-theme.get())
  v(14pt)
  line(length: 100%, stroke: 0.5pt + p.border)
  v(14pt)
}
