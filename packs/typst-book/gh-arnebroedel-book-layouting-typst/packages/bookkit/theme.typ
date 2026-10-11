// styles/theme.typ — Design token system (pure data, no set/show rules)

// ── Color Palette ──────────────────────────────────────────────
#let palette = (
  // Primary
  primary: rgb("#0d7377"),
  primary-light: rgb("#14a3a8"),
  primary-dark: rgb("#094f52"),
  // Accent
  accent: rgb("#d4a039"),
  accent-light: rgb("#e8c468"),
  accent-dark: rgb("#a67c2e"),
  // Neutrals
  bg: rgb("#ffffff"),
  bg-subtle: rgb("#f5f5f0"),
  bg-muted: rgb("#e8e8e3"),
  text-body: rgb("#1a1a1a"),
  text-muted: rgb("#555555"),
  text-light: rgb("#888888"),
  border: rgb("#cccccc"),
  border-light: rgb("#e0e0e0"),
  // Semantic
  info: rgb("#2563eb"),
  success: rgb("#16a34a"),
  warning: rgb("#d97706"),
  danger: rgb("#dc2626"),
)

// ── Gradient Presets ───────────────────────────────────────────
#let gradients = (
  cover: gradient.linear(palette.primary-dark, palette.primary, angle: 135deg),
  chapter: gradient.linear(palette.primary, palette.primary-light, angle: 0deg),
  accent: gradient.linear(palette.accent-dark, palette.accent, angle: 90deg),
  subtle: gradient.linear(palette.bg-subtle, palette.bg, angle: 180deg),
  // Demo presets for the page-design showcase (chapter 23)
  wash: gradient.linear(palette.primary-dark, palette.primary, palette.primary-light, angle: 160deg),
  radial: gradient.radial(palette.primary-light, palette.primary-dark),
  conic: gradient.conic(palette.primary, palette.accent, palette.primary, angle: 0deg),
)

// ── Part colors ────────────────────────────────────────────────
// Distinguishable hues keyed by part index (i == Teil i+1). Showcase has
// eight parts (I–VIII). Drives thumb-index tabs, margin bands, part coding.
#let part-colors = (
  rgb("#0d7377"), // I   — Grundlagen (teal / primary)
  rgb("#2563eb"), // II  — Komponenten & Layouts (blue)
  rgb("#7c3aed"), // III — Erweiterbarkeit (violet)
  rgb("#16a34a"), // IV  — Community-Pakete (green)
  rgb("#d4a039"), // V   — Template-Muster (amber / accent)
  rgb("#dc2626"), // VI  — Medizinische Fachbuch-Fähigkeiten (red)
  rgb("#475569"), // VII — Seitengestaltung & Kunst (slate)
  rgb("#1f3a5f"), // VIII — Berufs- und Rechtskunde (navy / legal)
)

// ── Type Scale ─────────────────────────────────────────────────
#let type-scale = (
  micro: 7.5pt,
  tiny: 8.5pt,
  small: 9.5pt,
  body: 10.5pt,
  lead: 12pt,
  h4: 13pt,
  h3: 15pt,
  h2: 18pt,
  h1: 24pt,
  display: 36pt,
)

// ── Spacing Scale ──────────────────────────────────────────────
#let space = (
  xs: 4pt,
  sm: 8pt,
  md: 12pt,
  lg: 16pt,
  xl: 24pt,
  xxl: 32pt,
  xxxl: 48pt,
)

// ── Font Families ──────────────────────────────────────────────
// Only fonts available under --ignore-system-fonts (confirmed via
// `typst fonts --ignore-system-fonts --font-path fonts`):
//   Libertinus Serif · New Computer Modern · DejaVu Sans Mono
// To use system fonts (Calibri, Arial etc.) on Windows, remove
// --ignore-system-fonts from scripts/build.ps1 and restore the
// original fallback chains.
#let fonts = (
  serif: ("Libertinus Serif",),
  sans: ("Libertinus Serif",), // no sans font embedded; bold/size provide hierarchy
  mono: ("DejaVu Sans Mono",),
)

// ── Didactic box semantics ─────────────────────────────────────
// Data-driven labels + colors for the medical-didactic box family
// (components/didactics.typ). Each entry: a header label (German,
// idiomatic for medical textbooks) and a base color from `palette`.
#let didactics = (
  objectives: (label: "Lernziele", color: palette.primary),
  summary: (label: "In Kürze", color: palette.primary-dark),
  memo: (label: "Merke", color: palette.accent-dark),
  case: (label: "Klinischer Fall", color: palette.info),
  pearl: (label: "Praxistipp", color: palette.success),
  cave: (label: "Cave", color: palette.danger),
  definition: (label: "Definition", color: palette.primary),
  excursus: (label: "Exkurs", color: palette.text-muted),
  mnemonic: (label: "Merkhilfe", color: palette.accent),
  ddx: (label: "Differenzialdiagnose", color: palette.warning),
)

// ── Evidence grading ───────────────────────────────────────────
// Empfehlungsgrade (A–D) and Evidenzlevel (LOE 1–5) color coding for
// the evidence badges in components/inline.typ.
#let evidence = (
  grade: (
    "A": palette.success,
    "B": palette.info,
    "C": palette.warning,
    "D": palette.danger,
  ),
  // LOE 1 (highest) → 5 (lowest), indexed by level-1
  loe: (palette.success, palette.info, palette.primary, palette.warning, palette.danger),
)

// ── Legal / Berufs- und Rechtskunde ────────────────────────────
// Sober, document-like palette for legal content (components/legal.typ):
// statute quotes, case law, legal definitions, exam schemes, professional
// practice. Each entry: a chip label (German legal idiom) + a base color.
#let legal = (
  norm: (label: "Gesetzestext", color: rgb("#1f3a5f")), // navy — Wortlaut der Norm
  case: (label: "Rechtsprechung", color: rgb("#7b1e3b")), // burgundy — court decisions
  definition: (label: "Legaldefinition", color: palette.primary), // teal — legal definitions
  scheme: (label: "Prüfungsschema", color: rgb("#5b3a8f")), // violet — Gutachten / schemes
  practice: (label: "Berufspraxis", color: palette.accent-dark), // amber — professional duties
)
