// =============================================================================
// THEME.TYP - Theming system for consistent visual styling
// =============================================================================
// Provides color schemes, visual presets, and styling utilities.

#import "config.typ": default-config

// =============================================================================
// Color Palette Definitions
// =============================================================================

/// Light theme (default)
#let theme-light = (
  name: "light",
  background: rgb("#ffffff"),
  surface: rgb("#f8f9fa"),
  text: rgb("#1a1a1a"),
  text-muted: rgb("#6c757d"),
  primary: rgb("#2c3e50"),
  secondary: rgb("#3498db"),
  accent: rgb("#e74c3c"),
  success: rgb("#27ae60"),
  warning: rgb("#f39c12"),
  error: rgb("#c0392b"),
  info: rgb("#3498db"),
  border: rgb("#dee2e6"),
  code-bg: rgb("#f5f5f5"),
  code-text: rgb("#c7254e"),
)

/// Dark theme
#let theme-dark = (
  name: "dark",
  background: rgb("#1a1a2e"),
  surface: rgb("#16213e"),
  text: rgb("#eaeaea"),
  text-muted: rgb("#a0a0a0"),
  primary: rgb("#4fc3f7"),
  secondary: rgb("#81c784"),
  accent: rgb("#ff8a65"),
  success: rgb("#66bb6a"),
  warning: rgb("#ffca28"),
  error: rgb("#ef5350"),
  info: rgb("#4fc3f7"),
  border: rgb("#374151"),
  code-bg: rgb("#0f0f23"),
  code-text: rgb("#f8f8f2"),
)

/// Sepia/vintage theme (for novels)
#let theme-sepia = (
  name: "sepia",
  background: rgb("#f4ecd8"),
  surface: rgb("#efe5cc"),
  text: rgb("#3d3121"),
  text-muted: rgb("#6b5b4d"),
  primary: rgb("#8b4513"),
  secondary: rgb("#a0522d"),
  accent: rgb("#cd853f"),
  success: rgb("#6b8e23"),
  warning: rgb("#daa520"),
  error: rgb("#a52a2a"),
  info: rgb("#4682b4"),
  border: rgb("#d4c4a8"),
  code-bg: rgb("#e8dcc8"),
  code-text: rgb("#8b4513"),
)

/// High contrast theme (accessibility)
#let theme-high-contrast = (
  name: "high-contrast",
  background: rgb("#ffffff"),
  surface: rgb("#f0f0f0"),
  text: rgb("#000000"),
  text-muted: rgb("#333333"),
  primary: rgb("#0000cc"),
  secondary: rgb("#006600"),
  accent: rgb("#cc0000"),
  success: rgb("#006600"),
  warning: rgb("#cc6600"),
  error: rgb("#cc0000"),
  info: rgb("#0000cc"),
  border: rgb("#000000"),
  code-bg: rgb("#f0f0f0"),
  code-text: rgb("#000000"),
)

/// Academic/professional theme
#let theme-academic = (
  name: "academic",
  background: rgb("#ffffff"),
  surface: rgb("#f8f8f8"),
  text: rgb("#212121"),
  text-muted: rgb("#757575"),
  primary: rgb("#1565c0"),
  secondary: rgb("#0277bd"),
  accent: rgb("#d32f2f"),
  success: rgb("#2e7d32"),
  warning: rgb("#f57c00"),
  error: rgb("#c62828"),
  info: rgb("#0288d1"),
  border: rgb("#bdbdbd"),
  code-bg: rgb("#eceff1"),
  code-text: rgb("#37474f"),
)

/// Technical/developer theme
#let theme-technical = (
  name: "technical",
  background: rgb("#ffffff"),
  surface: rgb("#f5f5f5"),
  text: rgb("#24292e"),
  text-muted: rgb("#586069"),
  primary: rgb("#0366d6"),
  secondary: rgb("#28a745"),
  accent: rgb("#d73a49"),
  success: rgb("#28a745"),
  warning: rgb("#ffd33d"),
  error: rgb("#d73a49"),
  info: rgb("#0366d6"),
  border: rgb("#e1e4e8"),
  code-bg: rgb("#f6f8fa"),
  code-text: rgb("#24292e"),
)

/// Solarized theme (popular with developers)
#let theme-solarized = (
  name: "solarized",
  background: rgb("#fdf6e3"),
  surface: rgb("#eee8d5"),
  text: rgb("#657b83"),
  text-muted: rgb("#93a1a1"),
  primary: rgb("#268bd2"),
  secondary: rgb("#2aa198"),
  accent: rgb("#cb4b16"),
  success: rgb("#859900"),
  warning: rgb("#b58900"),
  error: rgb("#dc322f"),
  info: rgb("#268bd2"),
  border: rgb("#eee8d5"),
  code-bg: rgb("#fdf6e3"),
  code-text: rgb("#657b83"),
)

/// Blueprint theme (for technical drawings)
#let theme-blueprint = (
  name: "blueprint",
  background: rgb("#2a3f5f"),
  surface: rgb("#3e5a86"),
  text: rgb("#ffffff"),
  text-muted: rgb("#a0b0c8"),
  primary: rgb("#ffffff"),
  secondary: rgb("#ffc107"),
  accent: rgb("#ff5722"),
  success: rgb("#4caf50"),
  warning: rgb("#ff9800"),
  error: rgb("#f44336"),
  info: rgb("#2196f3"),
  border: rgb("#5c7daA"),
  code-bg: rgb("#243652"),
  code-text: rgb("#ffffff"),
)

// =============================================================================
// Theme Registry
// =============================================================================

/// All available themes
#let themes = (
  light: theme-light,
  dark: theme-dark,
  sepia: theme-sepia,
  high-contrast: theme-high-contrast,
  academic: theme-academic,
  technical: theme-technical,
  solarized: theme-solarized,
  blueprint: theme-blueprint,
)

/// Get theme from config
/// - config: Book configuration object
/// Returns: Theme dictionary
#let get-theme(config) = {
  let theme-conf = config.at("theme", default: (:))
  
  // Handle custom user-defined theme
  if "custom" in theme-conf and type(theme-conf.custom) == dictionary {
    let base = if "base" in theme-conf.custom {
      themes.at(theme-conf.custom.base, default: theme-light)
    } else {
      theme-light
    }
    return base + theme-conf.custom
  }
  
  // Get theme by name
  let name = theme-conf.at("name", default: "light")
  themes.at(name, default: theme-light)
}

// =============================================================================
// Theme Application
// =============================================================================

/// Apply theme colors to document
/// - theme: Theme dictionary
/// - body: Document content
#let with-theme(theme, body) = {
  set text(fill: theme.text)
  set page(fill: theme.background)
  
  // Style links
  show link: it => text(fill: theme.primary)[#it]
  
  // Style raw/code blocks
  show raw.where(block: false): box.with(
    fill: theme.code-bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  
  show raw.where(block: true): block.with(
    fill: theme.code-bg,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )
  
  body
}

/// Create themed box/container
/// - theme: Theme dictionary
/// - variant: "surface", "primary", "secondary", "accent", "success", "warning", "error", "info"
/// - body: Content
#let themed-box(theme, variant: "surface", body) = {
  let bg = if variant == "surface" {
    theme.surface
  } else if variant == "primary" {
    theme.primary.lighten(85%)
  } else if variant == "secondary" {
    theme.secondary.lighten(85%)
  } else if variant == "accent" {
    theme.accent.lighten(85%)
  } else if variant == "success" {
    theme.success.lighten(85%)
  } else if variant == "warning" {
    theme.warning.lighten(85%)
  } else if variant == "error" {
    theme.error.lighten(85%)
  } else if variant == "info" {
    theme.info.lighten(85%)
  } else {
    theme.surface
  }
  
  let border-color = if variant == "surface" {
    theme.border
  } else if variant in themes {
    theme.at(variant)
  } else {
    theme.border
  }
  
  block(
    fill: bg,
    stroke: 1pt + border-color,
    inset: 12pt,
    radius: 4pt,
    width: 100%,
    body
  )
}

// =============================================================================
// Typography System
// =============================================================================

/// Typographic scale for consistent font sizing
/// - base-size: The body font size
/// Returns: Dictionary of font sizes
#let typography-scale(base-size) = (
  h1: base-size * 2.0,
  h2: base-size * 1.6,
  h3: base-size * 1.4,
  h4: base-size * 1.2,
  h5: base-size * 1.1,
  h6: base-size * 1.0,
  body: base-size,
  sm: base-size * 0.9,
  xs: base-size * 0.8,
)

/// Get typographic size from scale
/// - scale: The typography scale dictionary
/// - size: The requested size key (e.g., "h1")
#let ts(scale, size) = {
  scale.at(size, default: scale.body)
}

// =============================================================================
// Spacing System
// =============================================================================

/// Consistent spacing scale
#let spacing = (
  xs: 0.25em,
  sm: 0.5em,
  md: 1em,
  lg: 1.5em,
  xl: 2em,
  xxl: 3em,
)

/// Get spacing value
#let sp(size) = {
  if size in spacing {
    spacing.at(size)
  } else if type(size) == length {
    size
  } else {
    spacing.md
  }
}

// =============================================================================
// Border Radius
// =============================================================================

#let radius = (
  zero: 0pt,
  sm: 2pt,
  md: 4pt,
  lg: 8pt,
  xl: 12pt,
  full: 9999pt,
)

// =============================================================================
// Shadow Definitions
// =============================================================================

/// Box shadows (for visual depth)
#let shadows = (
  sm: (
    dx: 0pt,
    dy: 1pt,
    blur: 2pt,
    color: rgb("#00000010"),
  ),
  md: (
    dx: 0pt,
    dy: 2pt,
    blur: 4pt,
    color: rgb("#00000015"),
  ),
  lg: (
    dx: 0pt,
    dy: 4pt,
    blur: 8pt,
    color: rgb("#00000020"),
  ),
)

// =============================================================================
// Typography Helpers
// =============================================================================

/// Create text with theme color
/// - theme: Theme dictionary
/// - variant: Color variant name
/// - body: Text content
#let themed-text(theme, variant: "text", body) = {
  let color = if variant in theme {
    theme.at(variant)
  } else {
    theme.text
  }
  text(fill: color)[#body]
}

/// Muted text helper
#let muted(theme, body) = {
  text(fill: theme.text-muted)[#body]
}

// =============================================================================
// Status Colors
// =============================================================================

/// Get status color from theme
/// - theme: Theme dictionary
/// - status: "success", "warning", "error", "info"
#let status-color(theme, status) = {
  if status == "success" { theme.success }
  else if status == "warning" { theme.warning }
  else if status == "error" { theme.error }
  else if status == "info" { theme.info }
  else { theme.text-muted }
}

/// Status indicator dot
#let status-dot(theme, status, size: 8pt) = {
  box(
    width: size,
    height: size,
    radius: size / 2,
    fill: status-color(theme, status),
  )
}
