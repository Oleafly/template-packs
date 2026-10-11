// Palette of the UNN ITMM template, taken from the pptx theme XML
// (ppt/theme/theme1.xml). The palette slide inside the deck writes the
// green as #14D99F, but the theme XML value #14D49F is authoritative.

#let unn-colors = (
  // Primary brand blue: titles, emphasis.
  primary: rgb("#00348A"),
  // Accent blue: secondary emphasis, arrows, list markers.
  accent-blue: rgb("#1E52A8"),
  // Brand green: success / "done" accents.
  green: rgb("#14D49F"),
  // Brand orange: warnings / highlight accents.
  orange: rgb("#FF9B71"),
  // Light blue panel fills.
  panel: rgb("#E2EEFF"),
  panel-light: rgb("#F1F7FF"),
  // Body text.
  text: rgb("#3D3D3E"),
  // Secondary gray text.
  gray: rgb("#404040"),
  // Slide number.
  page-num: rgb("#888DB0"),
)
