// -------------------------------------------------------------------------
// File: template/config.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Configuration constants for the Typify template.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

// --- Configuration Constants ---
// Colors (Default Theme)
#let COLOR_PRIMARY = rgb("#2C3E50")        // Bleu-gris foncé professionnel
#let COLOR_LINK = rgb("#005eb8")
#let COLOR_GRAY = rgb("#929292")           // Couleur header/footer
#let COLOR_ACCENT = rgb("#ECF0F1")         // Gris clair pour fond
#let COLOR_ACCENT_BORDER = rgb("#34495E")  // Bordure assortie

// HEIA Theme Override
#let COLOR_HEIA_PRIMARY = rgb("#007CB7")
#let COLOR_HEIA_ACCENT = rgb("#AFA8A1")
#let COLOR_HEIA_ACCENT_BORDER = rgb("#83776B")

// Fonts
#let FONT_MAIN = "Aptos"
#let FONT_CODE = "JetBrains Mono"

// Layout
#let PAGE_FORMAT = "a4"
#let PAGE_MARGIN_TOP = 1.18in
#let PAGE_MARGIN_BOTTOM = 1.28in
#let PAGE_MARGIN_LEFT = 0.98in
#let PAGE_MARGIN_RIGHT = 0.98in

// Typography
#let TEXT_LANG = "en"
#let TEXT_SIZE = 11pt
#let TEXT_LEADING = 0.65em
#let PAR_SPACING = 8pt  // Espacement après paragraphe

// Defaults
#let DEFAULT_TITLE = "Typify Document"
#let DEFAULT_DATE = datetime.today()
#let DEFAULT_DATE_FORMAT = "[day].[month].[year]"
