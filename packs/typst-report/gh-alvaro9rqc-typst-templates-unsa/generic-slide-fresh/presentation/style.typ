// --- VISUAL DESIGN TOKENS AND STYLE SYSTEM ---

// --- DESIGN TOKENS ---
// Centralized theme values for color palettes, typography, and page sizes.

/// The main canvas background color (off-white/cream).
#let color-bg = rgb("#fafafa")

/// The primary corporate highlight/accent color (yellow).
#let color-primary = rgb("#f8cd21")

/// The elegant contrasting background color (black).
#let color-secondary = rgb("#000000")

/// The decorative geometric outline and timeline color (light gray).
#let color-decor = rgb("#d9d9d9")

/// The primary body text color (dark charcoal).
#let color-text-dark = rgb("#111111")

/// The secondary body text color for descriptions and captions (muted gray).
#let color-text-muted = rgb("#555555")

/// The default typographic font family for all slides.
#let font-main = "Inter"

/// Standard HD slide canvas width.
#let slide-width = 1440pt

/// Standard HD slide canvas height.
#let slide-height = 810pt


// --- THEME DICTIONARY ---
// Grouped visual configurations for clean, unified component usage.
#let theme = (
  bg: color-bg,
  primary: color-primary,
  secondary: color-secondary,
  decor: color-decor,
  text-dark: color-text-dark,
  text-muted: color-text-muted,
  font: font-main,
  width: slide-width,
  height: slide-height
)


// --- GLOBAL DOCUMENT TEMPLATE ---

/// Applies visual styles, document-wide page setups, margins, and text hierarchies.
///
/// - body (content): The presentation content structure.
/// -> content
#let template(body) = {
  // Global page dimensions for high-definition slide aspect ratios (16:9)
  set page(
    width: theme.width,
    height: theme.height,
    margin: 0pt,
    fill: theme.bg
  )
  
  // Default presentation text setups
  set text(
    font: theme.font,
    size: 20pt,
    lang: "es", // Preserves Spanish lang tag for spellcheck compatibility
    fill: theme.text-dark,
  )
  
  // Disable automatic paragraph justification for readable slides
  set par(justify: false)
  
  // Code block layout and syntax highlight coloring
  show raw.where(block: true): it => block(
    fill: rgb("#f6f8fa"),
    width: 100%,
    inset: 1.2em,
    radius: 8pt,
    stroke: 0.5pt + rgb("#e1e4e8"),
    text(size: 14pt, fill: rgb("#24292e"), it),
  )
  
  // Styled bullets using the primary accent color
  set list(
    marker: (
      [#text(fill: theme.primary)[•]],
      [#text(fill: theme.primary)[–]]
    )
  )

  body
}
