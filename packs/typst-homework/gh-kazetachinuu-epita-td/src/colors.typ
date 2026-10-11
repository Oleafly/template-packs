// COLORS - Color palette and utilities
//
// This file defines all colors used in the template.
// Edit here to customize the look and feel.
//
// QUICK CUSTOMIZATION:
// - Change `catppuccin` values to use different base colors
// - Change `colors` mappings to reassign semantic meanings
//

// BASE PALETTE (Catppuccin Macchiato)

/// Base color palette using Catppuccin Macchiato theme.
/// Replace these values with your own colors if desired.
///
/// -> dictionary
#let catppuccin = (
  text:     rgb("#24273a"),  // Dark text color
  base:     rgb("#1e1e2e"),  // Background
  surface:  rgb("#313244"),  // Elevated surfaces

  blue:     rgb("#8aadf4"),  // Primary accent
  green:    rgb("#a6da95"),  // Success, positive
  red:      rgb("#ed8796"),  // Warning, danger
  mauve:    rgb("#c6a0f6"),  // Commands, code
  lavender: rgb("#b7bdf8"),  // Metadata, info
  peach:    rgb("#f5a97f"),  // Examples, highlights
  yellow:   rgb("#eed49f"),  // Caution, notes
  teal:     rgb("#8bd5ca"),  // Requirements
  sky:      rgb("#91d7e3"),  // Evaluation
  flamingo: rgb("#f0c6c6"),  // Scope, boundaries
)

// SEMANTIC COLORS

/// Semantic color mappings for document elements.
/// Maps purpose to actual color values.
///
/// To customize box colors, change the color assignments here.
/// Example: To make questions green instead of blue:
/// ```typst
/// question: catppuccin.green,
/// ```
///
/// -> dictionary
#let colors = (
  question:    catppuccin.blue,      // Question boxes
  response:    catppuccin.green,     // Answer boxes
  warning:     catppuccin.red,       // Important/warning boxes
  command:     catppuccin.mauve,     // Command/terminal boxes
  metadata:    catppuccin.lavender,  // Info boxes
  timeline:    catppuccin.peach,     // Example boxes
  submission:  catppuccin.yellow,    // Submission info
  requirement: catppuccin.teal,      // Prerequisite boxes
  evaluation:  catppuccin.sky,       // Evaluation criteria
  scope:       catppuccin.flamingo,  // Scope boxes
  text:        catppuccin.text,      // Main text color
)

// COLOR UTILITIES

/// Generate a color scheme for boxes from a base accent color.
/// Returns a dictionary with `bg`, `border`, and `title-bg` colors.
///
/// ```example
/// #let scheme = box-colors(rgb("#8aadf4"))
/// // scheme.bg       -> light background
/// // scheme.border   -> darker border
/// // scheme.title-bg -> title bar background
/// ```
///
/// - base-color (color): The accent color to derive the scheme from.
/// -> dictionary
#let box-colors(base-color) = (
  bg:       base-color.lighten(85%),
  border:   base-color.darken(20%),
  title-bg: base-color.lighten(70%),
)

/// Lighten a color by a percentage.
///
/// - color (color): The color to lighten.
/// - amount (ratio): Percentage to lighten (e.g., 50%).
/// -> color
#let lighten(color, amount) = color.lighten(amount)

/// Darken a color by a percentage.
///
/// - color (color): The color to darken.
/// - amount (ratio): Percentage to darken (e.g., 20%).
/// -> color
#let darken(color, amount) = color.darken(amount)
