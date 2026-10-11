// ============================================================
// Colour themes
// ------------------------------------------------------------
// Every theme is a dictionary with the same keys. Add your own
// theme here (or pass a dictionary directly to `poster(theme: ...)`).
// ============================================================

#let theme-navy = (
  name: "navy",
  // Main accent: block titles, list markers, links, emphasised text
  primary: rgb("#00305A"),
  // Header
  header-bg: white,
  header-fg: black,
  header-rule: none, // colour of the rule under the header, or `none`
  // Plain block
  block-bg: white,
  block-title: rgb("#00305A"),
  block-rule: black,
  // Example block (tinted, used e.g. for motivation / research question)
  example-bg: rgb("#F0F8FF"),
  example-title: rgb("#00305A"),
  // Alert block (tinted, used e.g. for results / takeaways)
  alert-bg: rgb("#FFF5F2"),
  alert-title: rgb("#00305A"),
  // Footer
  footer-bg: white,
  footer-fg: black,
  footer-rule: none,
  // Body text
  text: black,
  muted: rgb("#555555"),
)

#let theme-sapienza = (
  name: "sapienza",
  // "Rosso Sapienza" — Pantone 202 C
  primary: rgb("#822433"),
  header-bg: white,
  header-fg: black,
  header-rule: none,
  block-bg: white,
  block-title: rgb("#822433"),
  block-rule: black,
  example-bg: rgb("#F5F1EC"),   // warm light beige
  example-title: rgb("#822433"),
  alert-bg: rgb("#FBEFF0"),     // very light rose
  alert-title: rgb("#822433"),
  footer-bg: white,
  footer-fg: black,
  footer-rule: none,
  text: black,
  muted: rgb("#555555"),
)

// Filled-header variants: coloured header band with white text.
// Use with a white/negative version of your logo.
#let theme-navy-filled = theme-navy + (
  name: "navy-filled",
  header-bg: rgb("#00305A"),
  header-fg: white,
  footer-bg: rgb("#00305A"),
  footer-fg: white,
)

#let theme-sapienza-filled = theme-sapienza + (
  name: "sapienza-filled",
  header-bg: rgb("#822433"),
  header-fg: white,
  footer-bg: rgb("#822433"),
  footer-fg: white,
)

#let themes = (
  navy: theme-navy,
  sapienza: theme-sapienza,
  "navy-filled": theme-navy-filled,
  "sapienza-filled": theme-sapienza-filled,
)
