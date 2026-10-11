// =================
// Color Definitions
// =================

// Palette is intentionally hardcoded to keep behavior predictable.
// If you want different shades, adjust the percentages in the definitions below.

// Static colors (no state dependency)
#let white = rgb("FFFFFF")     
#let base_gray = rgb("#7c7c7c")
#let gray = base_gray.darken(25%)       
#let base_blue = rgb("#0000FF")  
#let blue = base_blue.darken(25%)
#let base_red = rgb("#FF0000")
#let red = base_red.darken(25%)
#let base_green = rgb("#00FF00")
#let green = base_green.darken(25%)
#let base_cyan = rgb("#22d2d2")
#let cyan = base_cyan.darken(5%)
#let base_magenta = rgb("#FF00FF")
#let magenta = base_magenta.darken(20%)
#let base_yellow = rgb("#FFFF00")
#let yellow = base_yellow.darken(50%)

// Lightened colors (fixed)
// Note: Very high values (e.g. 90%) make colors almost white.
#let blue_light = base_blue.lighten(90%)
#let red_light = base_red.lighten(90%)
#let green_light = base_green.lighten(85%)
#let cyan_light = base_cyan.lighten(80%)
#let magenta_light = base_magenta.lighten(90%)
#let yellow_light = base_yellow.lighten(90%)
#let gray_light = base_gray.lighten(90%)

// =================
// Internal Helpers
// =================

// Creates a colored header box for slides.
#let slide-header(
  title,
  color,
  header-font-size,
  inset: .6cm,
  height: auto,
  text-color: white,
) = context {
  let font-size = header-font-size

  set text(size: font-size)
  let header-height = if height == auto {
    if title != none { 1.6em } else { 1.5em }
  } else {
    height
  }

  rect(
    fill: color,
    width: 100%,
    height: header-height,
    inset: inset,
    if title != none {
      text(text-color, weight: "regular", size: font-size)[
        #h(.1cm) #title
      ]
    },
  )
}

// =================
// Public Utilities
// =================

// Colored box for highlighting content (equations, code, notes)
// Args: text-size (auto), bg (gray), center_x (false), center_y (false), width (auto)
#let focusbox(
  text-size: auto,
  bg: rgb("#F3F2F0"),
  center_x: false,
  center_y: false,
  width: auto,
  content,
) = context {
  let color-map = (
    (blue, blue_light),
    (red, red_light),
    (green, green_light),
    (cyan, cyan_light),
    (magenta, magenta_light),
    (yellow, yellow_light),
    (gray, gray_light),
  )
  
  let match = color-map.find(p => p.at(0) == bg)
  let bg-color = if match != none { match.at(1) } else { bg }
  let center_x_str = if center_x { center } else { left }
  let center_y_str = if center_y { horizon } else { top }

  // Get font size - use auto to fallback to state default
  let font-size = if text-size == auto {
    state("focusbox-font-size", 1em).get()
  } else {
    text-size
  }

  set align(center_x_str + center_y_str)
  set text(size: font-size)
  show raw: set text(size: font-size)
  block(
    fill: bg-color,
    width: width,
    inset: (x: .8cm, y: .8cm),
    breakable: false,
    above: .9cm,
    below: .9cm,
    radius: (top: .2cm, bottom: .2cm),
  )[#content]
}

// Creates a multi-column layout for slide content
// Args: columns (auto = equal width), gutter (1em), bodies (variable number of content blocks)
// Example: #cols[Left content][Right content]
// Example: #cols(columns: (2fr, 1fr))[Wide][Narrow]
// fr stands for "fractional unit"
#let cols(columns: auto, gutter: 1em, ..bodies) = {
  let bodies = bodies.pos()
  let columns = if columns == auto {
    (1fr,) * bodies.len()
  } else {
    columns
  }
  if columns.len() != bodies.len() {
    panic("Number of columns must match number of content blocks")
  }
  grid(columns: columns, gutter: gutter, ..bodies)
}

// =========================
// Animation Markers & Logic
// =========================

// Pause marker for creating animation steps
// Usage: #pause
// Content after #pause will appear on the next subslide
#let pause = metadata((kind: "slides-pause"))

// Meanwhile marker for synchronous reveals
// Usage: #meanwhile
// Resets the pause counter to allow content to be revealed simultaneously
#let meanwhile = metadata((kind: "slides-meanwhile"))

// Determine whether a content item is a marker.
// Returns one of: "pause", "meanwhile", none.
#let marker-kind(item) = {
  if type(item) != content { return none }
  if item.func() != metadata { return none }
  if type(item.value) != dictionary { return none }
  let kind = item.value.at("kind", default: none)
  if kind == "slides-pause" { return "pause" }
  if kind == "slides-meanwhile" { return "meanwhile" }
  none
}

// Count pause markers in content.
// The `#meanwhile` marker starts a new "track" that begins at the *current*
// subslide (not at 1), so content after it appears alongside the current step.
#let count-pauses(body-content) = {
  if type(body-content) != content or not body-content.has("children") {
    return 1
  }

  // Track semantics:
  // - `track-offset`: the global step number the current track starts at.
  // - `local-step`: the step number within the track (1-based).
  let track-offset = 1
  let local-step = 1
  let max-step = 1

  for child in body-content.children {
    let kind = marker-kind(child)

    if kind == "pause" {
      local-step += 1
      max-step = calc.max(max-step, track-offset + local-step - 1)
    } else if kind == "meanwhile" {
      // Start a new track at the *current* global step.
      track-offset = track-offset + local-step - 1
      local-step = 1
      max-step = calc.max(max-step, track-offset)
    }
  }

  max-step
}

// Process content for a specific subslide
// Hide content that appears after pauses not yet reached
#let process-content-for-subslide(body-content, target-subslide) = {
  if type(body-content) != content or not body-content.has("children") {
    return body-content
  }

  // Same semantics as in `count-pauses`.
  let track-offset = 1
  let local-step = 1
  let current-step = track-offset + local-step - 1

  let parts = ()
  let current-part = ()

  // Flush accumulated content into `parts` under the current global step.
  let flush() = {
    if current-part.len() > 0 {
      parts.push((step: current-step, content: current-part.sum(default: [])))
      current-part = ()
    }
  }

  for child in body-content.children {
    let kind = marker-kind(child)

    if kind == "pause" {
      flush()
      local-step += 1
      current-step = track-offset + local-step - 1
    } else if kind == "meanwhile" {
      flush()
      track-offset = current-step
      local-step = 1
      current-step = track-offset
    } else {
      current-part.push(child)
    }
  }

  flush()

  // If there were no pauses/meanwhiles, preserve original content.
  if parts.len() == 0 {
    return body-content
  }

  // Combine parts that should be visible at `target-subslide`.
  let visible = ()
  for part in parts {
    if part.step <= target-subslide {
      visible.push(part.content)
    }
  }

  if visible.len() == 0 { [] } else { visible.sum(default: []) }
}



