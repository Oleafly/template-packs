// ============================================================================
// Slides Library - Main Entry Point
// ============================================================================
// A simple and clean slides template for Typst presentations with pause animations
//
// Author: Magnus Simonsen
// Repository: https://github.com/magnussimonsen/highschool_slides
// License: MIT
//
// Usage:
//   #import "@preview/classroom-deck:0.1.0": *
//
//   #show: slides.with(
//     ratio: "16-9",
//     footer_text: "My Presentation", // or footer-text
//   )
//
//   #slide(title: "First Slide")[
//     Content here
//
//     #pause
//
//     More content after pause
//   ]
// ============================================================================

// Import and re-export core functionality
#import "core.typ": slide, slides

// Import and re-export utilities
#import "utils.typ": (
  // Layout utilities
  focusbox,
  cols,
  // Animation markers
  pause,
  meanwhile,
  // Color palette
  blue,
  red,
  green,
  cyan,
  magenta,
  yellow,
  gray,
  white,
  // Lightened color variants
  blue_light,
  red_light,
  green_light,
  cyan_light,
  magenta_light,
  yellow_light,
  gray_light,
)
