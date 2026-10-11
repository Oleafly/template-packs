// Shared accent color for both Chinese and English templates
#let default-accent-color = rgb("#262F99")

// --- SVG Icon System ---

// Internal: render an SVG string as an icon box with fill color
#let make-icon(svg-data, fill: rgb("#000000")) = box(
  height: 0.7em,
  width: 1.25em,
  align(
    center + horizon,
    image(
      bytes(svg-data.replace("path d", "path fill=\"" + fill.to-hex() + "\" d")),
      height: 1em,
    ),
  ),
)

// Raw SVG data (read at compile time, relative to this file)
#let fa-angle-right-svg = read("../icons/fa-angle-right.svg")
#let fa-award-svg = read("../icons/fa-award.svg")
#let fa-building-columns-svg = read("../icons/fa-building-columns.svg")
#let fa-code-svg = read("../icons/fa-code.svg")
#let fa-envelope-svg = read("../icons/fa-envelope.svg")
#let fa-github-svg = read("../icons/fa-github.svg")
#let fa-graduation-cap-svg = read("../icons/fa-graduation-cap.svg")
#let fa-linux-svg = read("../icons/fa-linux.svg")
#let fa-phone-svg = read("../icons/fa-phone.svg")
#let fa-windows-svg = read("../icons/fa-windows.svg")
#let fa-wrench-svg = read("../icons/fa-wrench.svg")
#let fa-work-svg = read("../icons/fa-work.svg")

// Pre-rendered icon constants (accent-colored for headings/contact info)
#let fa-award = make-icon(fa-award-svg, fill: default-accent-color)
#let fa-building-columns = make-icon(fa-building-columns-svg, fill: default-accent-color)
#let fa-code = make-icon(fa-code-svg, fill: default-accent-color)
#let fa-envelope = make-icon(fa-envelope-svg, fill: default-accent-color)
#let fa-github = make-icon(fa-github-svg, fill: default-accent-color)
#let fa-graduation-cap = make-icon(fa-graduation-cap-svg, fill: default-accent-color)
#let fa-linux = make-icon(fa-linux-svg, fill: default-accent-color)
#let fa-phone = make-icon(fa-phone-svg, fill: default-accent-color)
#let fa-windows = make-icon(fa-windows-svg, fill: default-accent-color)
#let fa-wrench = make-icon(fa-wrench-svg, fill: default-accent-color)
#let fa-work = make-icon(fa-work-svg, fill: default-accent-color)

// Angle-right is black (used for list bullet markers, not themed)
#let fa-angle-right = make-icon(fa-angle-right-svg)
