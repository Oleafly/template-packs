// Everforest theme for Lebenslauf package
// Based on the Everforest color scheme by sainnhe

#let everforest-palette = (
  // Background colors
  bg0: rgb("#2d353b"),
  bg1: rgb("#343f44"),
  bg2: rgb("#3d484d"),
  bg3: rgb("#475258"),
  bg4: rgb("#4f585e"),
  bg5: rgb("#56635f"),
  // Foreground colors
  fg: rgb("#d3c6aa"),
  red: rgb("#e67e80"),
  orange: rgb("#e69875"),
  yellow: rgb("#dbbc7f"),
  green: rgb("#a7c080"),
  aqua: rgb("#83c092"),
  blue: rgb("#7fbbb3"),
  purple: rgb("#d699b6"),
  // Gray colors
  gray0: rgb("#7a8478"),
  gray1: rgb("#859289"),
  gray2: rgb("#9da9a0"),
)

// Light variant of Everforest
#let everforest-light-palette = (
  // Background colors
  bg0: rgb("#fdf6e3"),
  bg1: rgb("#f4f0d9"),
  bg2: rgb("#efebd4"),
  bg3: rgb("#e6e2cc"),
  bg4: rgb("#e0dcc7"),
  bg5: rgb("#bdc3af"),
  // Foreground colors
  fg: rgb("#5c6a72"),
  red: rgb("#f85552"),
  orange: rgb("#f57d26"),
  yellow: rgb("#dfa000"),
  green: rgb("#8da101"),
  aqua: rgb("#35a77c"),
  blue: rgb("#3a94c5"),
  purple: rgb("#df69ba"),
  // Gray colors
  gray0: rgb("#a6b0a0"),
  gray1: rgb("#939f91"),
  gray2: rgb("#829181"),
)

// Export dark theme
#let everforest-dark = (
  colors: (
    primary: everforest-palette.fg,
    secondary: everforest-palette.gray1,
    accent: everforest-palette.green,
    background: everforest-palette.bg0,
    border: everforest-palette.bg3,
    text: everforest-palette.fg,
    // Additional colors
    highlight: everforest-palette.yellow,
    error: everforest-palette.red,
    success: everforest-palette.green,
    info: everforest-palette.blue,
    warning: everforest-palette.orange,
  ),
  fonts: (
    heading: "Inter",
    body: "Inter",
    mono: "JetBrains Mono",
  ),
  spacing: (
    section: 1em,
    subsection: 0.5em,
    paragraph: 0.3em,
  ),
)

// Export light theme (default for CVs)
#let everforest-light = (
  colors: (
    primary: everforest-light-palette.fg,
    secondary: everforest-light-palette.gray1,
    accent: everforest-light-palette.green,
    background: everforest-light-palette.bg0,
    border: everforest-light-palette.bg4,
    text: everforest-light-palette.fg,
    // Additional colors
    highlight: everforest-light-palette.yellow,
    error: everforest-light-palette.red,
    success: everforest-light-palette.green,
    info: everforest-light-palette.blue,
    warning: everforest-light-palette.orange,
  ),
  fonts: (
    heading: "Inter",
    body: "Inter",
    mono: "JetBrains Mono",
  ),
  spacing: (
    section: 1em,
    subsection: 0.5em,
    paragraph: 0.3em,
  ),
)
