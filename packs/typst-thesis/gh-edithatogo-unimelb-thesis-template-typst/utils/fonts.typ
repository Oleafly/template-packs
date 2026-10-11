// Font theme registry for the University of Melbourne Typst template
// Provides reusable font stacks with sensible fallbacks so authors can
// switch between serif/sans combinations without editing layout files.

// Public API:
// - font-theme(name) -> returns (serif, sans, mono)
// - font-themes() -> tuple of available theme names

#let _font-themes = (
  "unimelb": (
    serif: (
      "Source Serif Pro",
      "Fraunces",
      "Times New Roman",
      "Liberation Serif",
      "DejaVu Serif",
      "STIX Two Text",
      "LMRoman10",
    ),
    sans: (
      "Source Sans Pro",
      "Arial",
      "Liberation Sans",
      "DejaVu Sans",
      "Noto Sans",
    ),
    mono: (
      "JetBrains Mono",
      "Fira Code",
      "Cascadia Code",
      "Source Code Pro",
      "Courier New",
      "Liberation Mono",
    ),
  ),
  "classic": (
    serif: (
      "Libertinus Serif",
      "TeX Gyre Pagella",
      "Palatino Linotype",
      "Times New Roman",
      "DejaVu Serif",
    ),
    sans: (
      "TeX Gyre Heros",
      "Helvetica",
      "Arial",
      "Liberation Sans",
      "DejaVu Sans",
    ),
    mono: (
      "Courier Prime",
      "Courier New",
      "Liberation Mono",
      "DejaVu Sans Mono",
    ),
  ),
  "modern": (
    serif: (
      "STIX Two Text",
      "Charter",
      "Cormorant Garamond",
      "Noto Serif",
      "DejaVu Serif",
    ),
    sans: (
      "Inter",
      "Roboto",
      "Open Sans",
      "Source Sans Pro",
      "Noto Sans",
    ),
    mono: (
      "Iosevka",
      "JetBrains Mono",
      "Fira Code",
      "Source Code Pro",
      "Courier New",
    ),
  ),
)

#let font-theme(name: "unimelb") = {
  _font-themes.at(name, default: _font-themes.at("unimelb"))
}

#let font-themes() = _font-themes.keys()
