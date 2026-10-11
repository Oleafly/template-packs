// arc42 Template shared configuration
// Set to true to show arc42 help texts, false to hide them
#let show-arc42-help = true

// arc42help function: renders help blocks conditionally
#let arc42help(content) = {
  if show-arc42-help {
    block(
      width: 100%,
      inset: 12pt,
      stroke: 0.5pt + luma(180),
      fill: luma(245),
      radius: 4pt,
      content,
    )
  }
}
