// kami-typst · Design Tokens
// Shared across all templates. Import: #import "@preview/kami:0.1.0": *

// ═══════════════════════════════════════════
// Colors
// ═══════════════════════════════════════════

// Surface
#let parchment    = rgb("#f5f4ed")  // Page background — warm cream. Never pure white.
#let ivory        = rgb("#faf9f5")  // Card / lifted container
#let warm-sand    = rgb("#e8e6dc")  // Button / interactive surface
#let dark-surface = rgb("#30302e")  // Dark container
#let deep-dark    = rgb("#141413")  // Dark page background

// Brand — the ONLY chromatic color (≤ 5% of surface)
#let brand     = rgb("#1B365D")  // Ink Blue — accent, CTA, title marker
#let ink-light = rgb("#2D5A8A")  // Brighter variant, for links on dark surfaces

// Text — four-level warm-gray hierarchy
#let near-black = rgb("#141413")  // Primary text — warm olive undertone
#let dark-warm  = rgb("#3d3d3a")  // Secondary — table headers, links
#let olive      = rgb("#504e49")  // Subtext — descriptions, captions
#let stone      = rgb("#6b6a64")  // Tertiary — dates, metadata

// Border
#let border      = rgb("#e8e6dc")  // Primary — section dividers
#let border-soft = rgb("#e5e3d8")  // Secondary — row separators

// Semantic (the one sanctioned exception to single-accent rule)
#let breaking-bg = rgb("#f0e0d8")  // Changelog breaking badge background
#let breaking-fg = rgb("#8b4513")  // Changelog breaking badge text

// Tag background (brand 0.08 over parchment, solid hex — no rgba)
#let tag-bg = rgb("#EEF2F7")

// ═══════════════════════════════════════════
// Fonts (Windows-first, CJK fallback)
// ═══════════════════════════════════════════

#let serif-zh = ("SimSun", "STSong", "Noto Serif CJK SC", "Georgia", "Times New Roman")
#let serif-en = ("Georgia", "Charter", "Palatino", "Times New Roman")
#let serif-ja = ("YuMincho", "MS Mincho", "Noto Serif CJK JP", "SimSun")
#let serif-ko = ("Batang", "AppleMyungjo", "Noto Serif KR", "Georgia")
#let mono     = ("Consolas", "Courier New", "SF Mono", "Fira Code")

// ═══════════════════════════════════════════
// Typography Scale (pt, for A4 print)
// ═══════════════════════════════════════════

#let size-display = 36pt
#let size-h1      = 22pt
#let size-h2      = 16pt
#let size-h3      = 13pt
#let size-lead    = 11pt
#let size-body    = 10pt
#let size-dense   = 9.2pt
#let size-caption = 9pt
#let size-label   = 9pt
#let size-tiny    = 9pt

// Line heights
#let lh-tight   = 1.15   // Headlines
#let lh-dense   = 1.42   // Resume, one-pager
#let lh-reading = 1.55   // Long-doc, letters

// ═══════════════════════════════════════════
// Spacing (4pt base unit)
// ═══════════════════════════════════════════

#let sp-xs  = 2pt
#let sp-sm  = 4pt
#let sp-md  = 8pt
#let sp-lg  = 16pt
#let sp-xl  = 24pt
#let sp-2xl = 40pt
#let sp-3xl = 80pt

// ═══════════════════════════════════════════
// Page Margins (A4, by document type)
// ═══════════════════════════════════════════

#let margin-resume    = (x: 13mm, top: 11mm, bottom: 11mm)
#let margin-one-pager = (x: 18mm, top: 15mm, bottom: 15mm)
#let margin-long-doc  = (x: 22mm, top: 20mm, bottom: 22mm)
#let margin-letter    = (x: 25mm, top: 25mm, bottom: 25mm)
#let margin-portfolio = (x: 15mm, top: 12mm, bottom: 12mm)

// ═══════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════

// Apply page defaults: A4, parchment background, font
#let setup-page(margin: margin-long-doc, lang: "zh") = {
  set page(
    paper: "a4",
    margin: margin,
    background: rect(fill: parchment, width: 100%, height: 100%),
  )
  set text(
    font: if lang == "en" { serif-en }
          else if lang == "ja" { serif-ja }
          else if lang == "ko" { serif-ko }
          else { serif-zh },
    size: size-body,
    fill: near-black,
  )
}
