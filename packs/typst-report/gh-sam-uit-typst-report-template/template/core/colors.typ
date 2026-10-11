// /template/core/colors.typ
// Themed color palette for the document template
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Centralized color definitions used across the template.
// All components should reference these instead of hard-coding colors.

// MARK: Semantic Colors

/// Primary accent — used for table headers, TOC wrappers, etc.
#let clr-accent = blue

/// Subtle accent — lighter variant for backgrounds and borders
#let clr-accent-light = blue.lighten(90%)
#let clr-accent-lighter = blue.lighten(98%)

/// Border and stroke colors
#let clr-border = blue.lighten(80%)
#let clr-border-light = blue.lighten(90%)

/// Heading decoration color
#let clr-heading-rule = black.lighten(60%)

/// Gray palette for neutral UI elements
#let clr-neutral-bg = luma(240)
#let clr-neutral-border = luma(300)
#let clr-neutral-text = gray

/// Cover page gradients
#let clr-cover-gradient = gradient.linear(teal, blue, angle: 45deg)
#let clr-cover-bg = rgb(248, 250, 252)

/// Callout severity colors
#let clr-info = teal
#let clr-note = blue
#let clr-warn = orange
#let clr-error = red
#let clr-success = green

/// Code block colors
#let clr-code-bg = luma(240)
#let clr-code-line = luma(300)

/// Quote block
#let clr-quote-bg = luma(248)
#let clr-quote-border = luma(180)
