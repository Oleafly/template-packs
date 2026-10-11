// layout.typ

// --- Flattened Color System ---
// Simplified two-level color system for easier access

#let colors = (
  // Backgrounds
  bg-primary: rgb("#F9FAFB"),        // Main card backgrounds
  bg-secondary: rgb("#E5E8EC"),      // Table headers and secondary surfaces
  bg-dark: rgb("#FFFFFF"),           // Pure white backgrounds
  bg-darker: rgb("#F8F9FA"),         // Slightly off-white
  bg-card: rgb("#F9FAFB"),           // Card backgrounds
  
  // Text hierarchy
  text-primary: rgb("#1A1F28"),      // Main text
  text-secondary: rgb("#4B5563"),    // Secondary text
  text-muted: rgb("#9CA3AF"),        // Tertiary/disabled text
  
  // UI elements
  border: rgb("#D0D4D9"),            // Borders
  divider: rgb("#E5E7EB"),           // Dividers
  link: rgb("#2563EB"),              // Links
  link-hover: rgb("#1D4ED8"),        // Link hover state
  header-accent: rgb("#3F4A5A"),     // Section header underlines
  
  // Status/Alert backgrounds
  warning-bg: rgb("#FEF9E7"),        // Warning backgrounds
  surface: rgb("#E5E8EC"),           // General surface color
  surface-hover: rgb("#D8DCE3"),     // Hover states
  
  // Severity colors (from severity-levels)
  severity-high: rgb("#DC2626"),
  severity-warning: rgb("#EA580C"),
  severity-info: rgb("#0284C7"),
  severity-secure: rgb("#16A34A"),
  severity-hotspot: rgb("#7C3AED"),
  severity-caution: rgb("#CA8A04"),
  severity-critical: rgb("#B91C1C"),
  
  // Legacy aliases for backward compatibility
  high: rgb("#DC2626"),
  warning: rgb("#EA580C"),
  info: rgb("#0284C7"),
  secure: rgb("#16A34A"),
  hotspot: rgb("#7C3AED"),
  caution: rgb("#CA8A04"),
  critical: rgb("#B91C1C"),
)

// --- Severity Configuration ---
// Single source of truth for severity levels
#let severity-levels = (
  high: (
    color: rgb("#DC2626"),
    icon: "triangle-exclamation",
    label: "High",
  ),
  medium: (
    color: rgb("#EA580C"),
    icon: "triangle-exclamation",
    label: "Medium",
  ),
  warning: (  // Alias for medium
    color: rgb("#EA580C"),
    icon: "triangle-exclamation",
    label: "Warning",
  ),
  info: (
    color: rgb("#0284C7"),
    icon: "circle-info",
    label: "Info",
  ),
  secure: (
    color: rgb("#16A34A"),
    icon: "check",
    label: "Secure",
  ),
  hotspot: (
    color: rgb("#7C3AED"),
    icon: "fire-alt",
    label: "Hotspot",
  ),
)

// Helper function to get severity configuration
#let get-severity(level, fallback: "info") = {
  let key = lower(str(level))
  severity-levels.at(key, default: severity-levels.at(fallback))
}

// --- Validation Functions ---

/// Validate that a severity level is recognized.
///
/// Parameters:
/// - level: The severity level to validate
///
/// Raises: Assertion error if level is not recognized
#let validate-severity(level) = {
  let key = lower(str(level))
  let valid-levels = ("high", "medium", "warning", "info", "secure", "hotspot")
  assert(
    key in valid-levels,
    message: "Invalid severity level: '" + str(level) + "'. Valid levels are: " + valid-levels.join(", ")
  )
}

/// Validate that a column index is within bounds.
///
/// Parameters:
/// - index: The column index to validate
/// - max-columns: The maximum number of columns
/// - param-name: Name of the parameter being validated (for error messages)
///
/// Raises: Assertion error if index is out of bounds
#let validate-column-index(index, max-columns, param-name: "column index") = {
  if index != none {
    assert(
      type(index) == int,
      message: param-name + " must be an integer or none, got: " + str(type(index))
    )
    assert(
      index >= 0 and index < max-columns,
      message: param-name + " " + str(index) + " is out of bounds (max: " + str(max-columns - 1) + ")"
    )
  }
}

// --- Configurations ---
#let config = (
  font: "Arial",  // Changed to sans-serif for technical report readability
  base-size: 10pt,
  leading: 0.58em, // Global spacing value (vertical rhythm)
  section-spacing: 8pt,
  entry-spacing: 6pt,
  margin: 0.3in,
  table-stroke: 0.75pt + colors.border,
  table-inset: (x: 6pt, y: 5pt), // Consistent table cell padding
  metadata-block-inset: 10pt, // Consistent key-value block padding

  // Component sizing
  badge: (
    padding: (x: 5pt, y: 2pt),
    radius: 3pt,
    font-size: 7.5pt,
  ),

  icon: (
    baseline: 17%,
    default-size: 12pt,
    default-variant: "solid",
  ),

  // Color system
  colors: colors,
)

// --- Utility Functions ---
/// Utility function for vertical spacing.
///
/// Parameters:
/// - amount: The amount of vertical space to add
///
/// Returns: Vertical spacing
#let vgap(amount) = v(amount)

// --- Report Show Rule (Global Setup) ---

/// Apply global report styling and formatting.
///
/// Parameters:
/// - content: The report content to style
///
/// Returns: Styled document content
#let report(content) = {
  set page(
    paper: "us-letter",
    margin: config.margin,
    numbering: "1 / 1",
    number-align: center + bottom,
  )

  set text(
    font: config.font,
    size: config.base-size,
    fill: config.colors.text-primary,
  )

  set par(
    leading: config.leading,
    justify: false,
    spacing: config.leading * 1.65, // Space between paragraphs
  )

  // Enforce global block spacing for vertical rhythm
  set block(above: config.leading * 1.2, below: config.leading * 1.2)
  set list(spacing: config.leading)

  // Hyperlinks should use semantic link color
  show link: it => text(fill: config.colors.link, underline(it))

  content
}
