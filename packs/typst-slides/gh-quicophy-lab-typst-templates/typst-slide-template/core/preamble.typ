// ── Presentation dependencies ─────────────────────────────────────────────────
#import "imports.typ": *

// ── Import useful utilities ───────────────────────────────────────────────────
#import "utils.typ": accent-text, box-text, cite-footnote

// ── Theme selection ───────────────────────────────────────────────────────────
// Select the theme name that you want to use from the `themes/` directory.
#let theme-name = "default_theme"

// ── Theme selected theme ──────────────────────────────────────────────────────
// Import the selected theme's main file, which defines colors, fonts, styles and slides.
#import "themes/" + str(theme-name) + "/__init__.typ" as active-theme
#import active-theme: *
