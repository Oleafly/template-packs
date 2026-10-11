// components/theme.typ
// Theme definitions, color palettes, and reactive state management for Light and Dark modes.
// Replicates the Veritas Technical Report design language with full dark mode support.

#let current-theme = state("template-theme", "light")

// Veritas Default Color Constants (Light Theme)
#let primary-color = rgb("#1e3a8a")     // Deep Navy
#let secondary-color = rgb("#0f766e")   // Teal / Cyan Accent
#let accent-red = rgb("#b91c1c")        // Crimson Alert
#let bg-callout = rgb("#f0fdf4")        // Soft Mint / Pastel Green
#let border-callout = rgb("#16a34a")    // Vibrant Green Border
#let bg-note = rgb("#eff6ff")           // Soft Sky Blue
#let border-note = rgb("#2563eb")       // Vivid Blue Border
#let bg-challenge = rgb("#fff7ed")      // Soft Amber / Warm Orange
#let border-challenge = rgb("#ea580c")  // Deep Orange Border
#let bg-tech = rgb("#f8fafc")           // Subtle Slate
#let border-tech = rgb("#64748b")       // Slate Border

// Light Theme Palette
#let light-palette = (
  mode: "light",
  page-bg: rgb("#ffffff"),
  text: rgb("#0f172a"),                 // Slate 900
  text-muted: rgb("#64748b"),           // Slate 500
  text-light: rgb("#94a3b8"),           // Slate 400
  border: rgb("#cbd5e1"),               // Slate 300
  border-subtle: rgb("#e2e8f0"),        // Slate 200
  primary: rgb("#1e3a8a"),              // Deep Navy
  secondary: rgb("#0f766e"),            // Teal Accent
  accent-red: rgb("#b91c1c"),           // Crimson Alert

  callout: (
    bg: rgb("#eff6ff"),                 // Soft Sky Blue
    border: rgb("#2563eb"),             // Vivid Blue
    title: rgb("#1e3a8a"),              // Deep Navy
    label: rgb("#2563eb"),              // Blue
    text: rgb("#1e293b"),               // Dark Slate
  ),

  takeaway: (
    bg: rgb("#f0fdf4"),                 // Soft Mint
    border: rgb("#16a34a"),             // Vibrant Green
    title: rgb("#14532d"),              // Dark Forest Green
    label: rgb("#16a34a"),              // Green
    text: rgb("#064e3b"),               // Deep Green
  ),

  challenge: (
    bg: rgb("#fff7ed"),                 // Soft Warm Orange
    border: rgb("#ea580c"),             // Vivid Orange
    title: rgb("#9a3412"),              // Deep Rust Orange
    label: rgb("#c2410c"),              // Dark Orange
    problem-title: rgb("#7c2d12"),
    problem-text: rgb("#431407"),
    solution-title: rgb("#166534"),
    solution-text: rgb("#14532d"),
  ),

  info: (
    bg: rgb("#f0f9ff"),                 // Sky 50
    border: rgb("#0284c7"),             // Sky 600
    title: rgb("#0369a1"),              // Sky 700
    label: rgb("#0284c7"),
    text: rgb("#0c4a6e"),
  ),

  warning: (
    bg: rgb("#fffbeb"),                 // Amber 50
    border: rgb("#d97706"),             // Amber 600
    title: rgb("#b45309"),              // Amber 700
    label: rgb("#d97706"),
    text: rgb("#78350f"),
  ),

  danger: (
    bg: rgb("#fef2f2"),                 // Red 50
    border: rgb("#dc2626"),             // Red 600
    title: rgb("#b91c1c"),              // Red 700
    label: rgb("#dc2626"),
    text: rgb("#7f1d1d"),
  ),

  code: (
    bg: rgb("#f8fafc"),                 // Slate 50
    border: rgb("#cbd5e1"),             // Slate 300
    bar: rgb("#0f766e"),                // Teal Accent Bar
    inline-bg: rgb("#f1f5f9"),          // Slate 100
    inline-border: rgb("#cbd5e1"),
    line-number: rgb("#94a3b8"),        // Slate 400
    text: rgb("#0f172a"),
  ),

  table: (
    header-bg: rgb("#f1f5f9"),          // Slate 100
    even-bg: rgb("#f8fafc"),            // Slate 50
    odd-bg: rgb("#ffffff"),
    border: rgb("#cbd5e1"),
    header-text: rgb("#0f172a"),
  ),

  cover: (
    card-bg: rgb("#f8fafc"),
    card-border: rgb("#1e3a8a"),
    abstract-bg: rgb("#eff6ff"),
    abstract-border: rgb("#bfdbfe"),
    abstract-text: rgb("#1e3a8a"),
    meta-header: rgb("#475569"),
    meta-text: rgb("#0f172a"),
    sub-text: rgb("#334155"),
    footer-text: rgb("#64748b"),
  ),

  badges: (
    allow: (bg: rgb("#dcfce7"), border: rgb("#86efac"), text: rgb("#166534")),
    alert: (bg: rgb("#fef3c7"), border: rgb("#fde68a"), text: rgb("#92400e")),
    isolate: (bg: rgb("#fee2e2"), border: rgb("#fca5a5"), text: rgb("#991b1b")),
    normal: (bg: rgb("#f1f5f9"), border: rgb("#cbd5e1"), text: rgb("#334155")),
    suspicious: (bg: rgb("#ffedd5"), border: rgb("#fed7aa"), text: rgb("#9a3412")),
    critical: (bg: rgb("#fef2f2"), border: rgb("#f87171"), text: rgb("#b91c1c")),
    info: (bg: rgb("#e0f2fe"), border: rgb("#bae6fd"), text: rgb("#0369a1")),
    tag: (bg: rgb("#f1f5f9"), border: rgb("#cbd5e1"), text: rgb("#475569")),
  ),
)

// Dark Theme Palette
#let dark-palette = (
  mode: "dark",
  page-bg: rgb("#090d16"),             // Very dark navy-slate
  text: rgb("#e2e8f0"),                 // Slate 200
  text-muted: rgb("#94a3b8"),           // Slate 400
  text-light: rgb("#64748b"),           // Slate 500
  border: rgb("#1e293b"),               // Slate 800
  border-subtle: rgb("#151f30"),        // Slate 900
  primary: rgb("#60a5fa"),              // Lighter Navy / Blue Accent
  secondary: rgb("#2dd4bf"),            // Mint / Teal Accent
  accent-red: rgb("#f87171"),           // Soft Coral Red

  callout: (
    bg: rgb("#0d1b33"),                 // Deep Night Blue
    border: rgb("#3b82f6"),             // Blue 500
    title: rgb("#93c5fd"),              // Blue 300
    label: rgb("#60a5fa"),              // Blue 400
    text: rgb("#cbd5e1"),               // Slate 300
  ),

  takeaway: (
    bg: rgb("#062419"),                 // Deep Night Forest Green
    border: rgb("#22c55e"),             // Green 500
    title: rgb("#86efac"),              // Green 300
    label: rgb("#4ade80"),              // Green 400
    text: rgb("#bbf7d0"),               // Mint Green Light
  ),

  challenge: (
    bg: rgb("#24140a"),                 // Deep Night Orange
    border: rgb("#f97316"),             // Orange 500
    title: rgb("#fdba74"),              // Orange 300
    label: rgb("#fb923c"),              // Orange 400
    problem-title: rgb("#fed7aa"),
    problem-text: rgb("#ffedd5"),
    solution-title: rgb("#86efac"),
    solution-text: rgb("#bbf7d0"),
  ),

  info: (
    bg: rgb("#082032"),                 // Deep Cyan/Sky
    border: rgb("#38bdf8"),
    title: rgb("#7dd3fc"),
    label: rgb("#38bdf8"),
    text: rgb("#e0f2fe"),
  ),

  warning: (
    bg: rgb("#2b1d06"),                 // Deep Amber
    border: rgb("#fbbf24"),
    title: rgb("#fde68a"),
    label: rgb("#fbbf24"),
    text: rgb("#fef3c7"),
  ),

  danger: (
    bg: rgb("#2d0d0f"),                 // Deep Crimson
    border: rgb("#f87171"),
    title: rgb("#fca5a5"),
    label: rgb("#f87171"),
    text: rgb("#fee2e2"),
  ),

  code: (
    bg: rgb("#0c1322"),                 // Slate/Navy Night
    border: rgb("#1e293b"),
    bar: rgb("#2dd4bf"),                // Teal Accent Bar
    inline-bg: rgb("#162032"),
    inline-border: rgb("#2a3b53"),
    line-number: rgb("#64748b"),
    text: rgb("#e2e8f0"),
  ),

  table: (
    header-bg: rgb("#131c2e"),
    even-bg: rgb("#0e1524"),
    odd-bg: rgb("#090d16"),
    border: rgb("#1e293b"),
    header-text: rgb("#f1f5f9"),
  ),

  cover: (
    card-bg: rgb("#0f172a"),
    card-border: rgb("#3b82f6"),
    abstract-bg: rgb("#172554"),
    abstract-border: rgb("#1e40af"),
    abstract-text: rgb("#93c5fd"),
    meta-header: rgb("#94a3b8"),
    meta-text: rgb("#f8fafc"),
    sub-text: rgb("#cbd5e1"),
    footer-text: rgb("#64748b"),
  ),

  badges: (
    allow: (bg: rgb("#052e16"), border: rgb("#166534"), text: rgb("#86efac")),
    alert: (bg: rgb("#451a03"), border: rgb("#92400e"), text: rgb("#fde68a")),
    isolate: (bg: rgb("#450a0a"), border: rgb("#991b1b"), text: rgb("#fca5a5")),
    normal: (bg: rgb("#1e293b"), border: rgb("#334155"), text: rgb("#cbd5e1")),
    suspicious: (bg: rgb("#431407"), border: rgb("#9a3412"), text: rgb("#fdba74")),
    critical: (bg: rgb("#450a0a"), border: rgb("#b91c1c"), text: rgb("#fca5a5")),
    info: (bg: rgb("#082f49"), border: rgb("#0369a1"), text: rgb("#7dd3fc")),
    tag: (bg: rgb("#1e293b"), border: rgb("#334155"), text: rgb("#94a3b8")),
  ),
)

// Resolves active palette based on the given theme override, CLI argument, or default
#let resolve-palette(theme-override: none) = {
  let theme-name = if theme-override != none {
    theme-override
  } else if sys.inputs.at("theme", default: none) != none {
    sys.inputs.at("theme")
  } else {
    "light"
  }

  if theme-name == "dark" {
    dark-palette
  } else {
    light-palette
  }
}
