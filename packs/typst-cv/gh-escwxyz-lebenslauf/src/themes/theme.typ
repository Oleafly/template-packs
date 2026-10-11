// Theme system for Lebenslauf package

#import "everforest.typ": everforest-light

// Professional theme (default)
#let professional-theme = (
  colors: (
    primary: rgb("#1a1a1a"), // Dark gray for headings
    secondary: rgb("#666666"), // Medium gray for secondary text
    accent: rgb("#1e88e5"), // Blue for links and highlights
    background: rgb("#ffffff"), // White background
    border: rgb("#e0e0e0"), // Light gray for borders
    text: rgb("#333333"), // Dark gray for body text
  ),
  fonts: (
    heading: "Calibri",
    body: "Calibri",
    mono: "Consolas",
  ),
  spacing: (
    section: 1em,
    subsection: 0.5em,
    paragraph: 0.3em,
  ),
)

// Modern theme
#let modern-theme = (
  colors: (
    primary: rgb("#2c3e50"), // Dark blue-gray
    secondary: rgb("#7f8c8d"), // Medium gray
    accent: rgb("#e74c3c"), // Red accent
    background: rgb("#ffffff"), // White
    border: rgb("#ecf0f1"), // Very light gray
    text: rgb("#34495e"), // Dark gray-blue
  ),
  fonts: (
    heading: "Helvetica Neue",
    body: "Helvetica Neue",
    mono: "Monaco",
  ),
  spacing: (
    section: 1.2em,
    subsection: 0.6em,
    paragraph: 0.4em,
  ),
)

// Everforest theme
#let everforest-theme = (
  colors: (
    primary: rgb("#3c4841"), // Dark green
    secondary: rgb("#868d80"), // Medium green-gray
    accent: rgb("#a7c080"), // Light green
    background: rgb("#fdf6e3"), // Light cream
    border: rgb("#e0dec7"), // Light brown
    text: rgb("#5c6a72"), // Dark gray-green
  ),
  fonts: (
    heading: "Charter",
    body: "Charter",
    mono: "JetBrains Mono",
  ),
  spacing: (
    section: 1em,
    subsection: 0.5em,
    paragraph: 0.3em,
  ),
)

// Create custom theme
#let create-theme(
  primary: rgb("#1a1a1a"),
  secondary: rgb("#666666"),
  accent: rgb("#1e88e5"),
  background: rgb("#ffffff"),
  border: rgb("#e0e0e0"),
  text: rgb("#333333"),
  heading-font: "Calibri",
  body-font: "Calibri",
  mono-font: "Consolas",
) = (
  colors: (
    primary: primary,
    secondary: secondary,
    accent: accent,
    background: background,
    border: border,
    text: text,
  ),
  fonts: (
    heading: heading-font,
    body: body-font,
    mono: mono-font,
  ),
  spacing: (
    section: 1em,
    subsection: 0.5em,
    paragraph: 0.3em,
  ),
)

// Load a specific theme
#let load-theme(name) = {
  let themes = (
    professional: professional-theme,
    modern: modern-theme,
    everforest: everforest-theme,
  )

  if name in themes {
    themes.at(name)
  } else {
    // Default to professional theme
    professional-theme
  }
}
