// -------------------------------------------------------------------------
// File: lib/badges.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Component for inline badges and tags.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

// --- Constants ---
#let BADGE_RADIUS = 3pt
#let BADGE_INSET_X = 5pt
#let BADGE_INSET_Y = 2pt
#let BADGE_SIZE = 0.75em
#let BADGE_BASELINE = 15%

#let COLOR_TEXT = rgb("#ffffff")
#let COLOR_DEFAULT = rgb("#7f8c8d")

// --- Core Badge Function ---

#let badge(content, color: COLOR_DEFAULT) = {
  box(
    fill: color,
    radius: BADGE_RADIUS,
    inset: (x: BADGE_INSET_X, y: BADGE_INSET_Y),
    baseline: BADGE_BASELINE,
    text(
      fill: COLOR_TEXT,
      size: BADGE_SIZE,
      weight: "bold",
      content,
    ),
  )
}
