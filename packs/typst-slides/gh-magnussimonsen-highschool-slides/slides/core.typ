#import "utils.typ": *

// 
// Defaults & Constants
// 

// Fonts: Fallback lists ensure the template works across different OSs.
// "Liberation Sans" on Linux, "Calibri" on Windows, "Roboto" on Web.

// WINDOWS fonts list (to get wrid of warnings)
//#let default-main-font = ("Calibri", "Arial")
//#let default-code-font = ("Consolas", "Courier New")

// LINUX fonts list (to get rid of warnings)
//#let default-main-font = ("Liberation Sans", "Noto Sans", "Arial")
//#let default-code-font = ("Liberation Mono", "Noto Mono", "Courier New")

// Cross-platform defaults.
// Keep these as *fallback lists* so the template works across OSes without
// requiring users to install specific fonts.
#let default-main-font = (
  "Calibri",
  "Arial",
  "Liberation Sans",
  "Noto Sans",
  "Roboto",
)

#let default-code-font = (
  "Consolas",
  "Courier New",
  "Liberation Mono",
  "Noto Mono",
  "Roboto Mono",
  "DejaVu Sans Mono",
)

// Font Sizes
#let default-header-font-size = 22pt
#let default-content-font-size = 20pt
#let default-focusbox-font-size = 1em
#let default-table-font-size = 1em

// Layout Constants
// These control the spacing and geometry of the slides.
#let layout-header-height-title = 1.6em
#let layout-header-height-no-title = 1.5em
#let layout-header-inset = 0.6cm
#let layout-top-margin-extra = 0.5cm
#let layout-top-margin-default = 1.75cm
#let layout-margin-x = 1.6cm
#let layout-margin-bottom = 1.2cm

// ============================================================================
// State Management
// ============================================================================

// We use state to pass configuration from the global `slides` show rule
// down to individual `slide` calls.
#let state-header-font-size = state("header-font-size", default-header-font-size)
#let state-main-font = state("main-font", default-main-font)
#let state-code-font = state("code-font", default-code-font)
#let state-equation-numbering = state("equation-numbering", "(1)")
#let state-reset-equation = state("reset-equation", false)
#let state-footer-text = state("footer-text", "")
#let state-focusbox-font-size = state("focusbox-font-size", default-focusbox-font-size)
#let state-table-font-size = state("table-font-size", default-table-font-size)
#let state-current-subslide = state("current-subslide", 1)


// ============================================================================
// Main Configuration (Global)
// ============================================================================

// Convert a percentage-like value into a Typst ratio.
// Accepts either a ratio (e.g. `90%`) or a float/decimal (e.g. `0.9`).
#let as-ratio(value) = {
  if type(value) == ratio {
    value
  } else if type(value) == float or type(value) == decimal {
    value * 100%
  } else {
    panic("Expected a ratio like 90% (or a float like 0.9).")
  }
}

// Pause / meanwhile markers are detected only at the top-level of the slide body.
// If you place them inside nested structures (lists, grids, blocks, etc.), the
// auto-repeat detection will not see them.

#let slides(
  ratio: "16-9",
  main-font: default-main-font,
  code-font: default-code-font,
  font-size-headers: default-header-font-size,
  font-size-content: default-content-font-size,
  focusbox-font-size: default-focusbox-font-size,
  table-font-size: default-table-font-size,
  // Back-compat names (underscored)
  footer_text: none,
  reset_equation_numbers_per_slide: none,
  equation_numbering_globally: none,
  // Preferred names (hyphenated)
  footer-text: none,
  reset-equation-numbers-per-slide: none,
  equation-numbering-globally: none,
  body,
) = {
  // Resolve aliases (panic only if the user provides both).
  if footer_text != none and footer-text != none {
    panic("Use either footer_text or footer-text, not both.")
  }
  if reset_equation_numbers_per_slide != none and reset-equation-numbers-per-slide != none {
    panic("Use either reset_equation_numbers_per_slide or reset-equation-numbers-per-slide, not both.")
  }
  if equation_numbering_globally != none and equation-numbering-globally != none {
    panic("Use either equation_numbering_globally or equation-numbering-globally, not both.")
  }

  let footer = if footer-text != none { footer-text } else if footer_text != none { footer_text } else { "" }
  let reset-eq = if reset-equation-numbers-per-slide != none {
    reset-equation-numbers-per-slide
  } else if reset_equation_numbers_per_slide != none {
    reset_equation_numbers_per_slide
  } else {
    true
  }
  let global-eq = if equation-numbering-globally != none {
    equation-numbering-globally
  } else if equation_numbering_globally != none {
    equation_numbering_globally
  } else {
    true
  }

  // Update global state with user configuration
  state-header-font-size.update(font-size-headers)
  state-main-font.update(main-font)
  state-code-font.update(code-font)
  state-focusbox-font-size.update(focusbox-font-size)
  state-table-font-size.update(table-font-size)
  state-reset-equation.update(reset-eq)
  state-footer-text.update(footer)

  let numbering_format = if global-eq { "(1)" } else { none }
  state-equation-numbering.update(numbering_format)

  // Apply global document settings
  set text(font: main-font, size: font-size-content)
  set page(paper: "presentation-" + ratio, fill: white)
  set math.equation(numbering: numbering_format)

  body
}

// ===================
// Slide Definition
// ======

#let slide(
  // Back-compat names
  headercolor: none,
  title: none,
  center_x: none,
  center_y: none,

  // Preferred names
  header-color: none,
  center-x: none,
  center-y: none,

  slide-main-font: none,
  slide-main-font-size: none,
  slide-code-font: none,
  slide-code-font-size: none,
  slide-equation-numbering: auto,
  repeat: auto, // NEW: Number of subslides (auto = auto-detect from pauses)
  textcolor: white, // Custom header text color
  body,
) = {
  // Resolve aliases (panic only if the user provides both).
  if headercolor != none and header-color != none {
    panic("Use either headercolor or header-color, not both.")
  }
  if center_x != none and center-x != none {
    panic("Use either center_x or center-x, not both.")
  }
  if center_y != none and center-y != none {
    panic("Use either center_y or center-y, not both.")
  }

  // Set defaults
  let final-header-color = if header-color != none { header-color } else if headercolor != none { headercolor } else { blue }
  let final-center-x = if center-x != none { center-x } else if center_x != none { center_x } else { false }
  let final-center-y = if center-y != none { center-y } else if center_y != none { center_y } else { true }

  // Determine number of repetitions using helper from utils.typ
  let actual-repeat = if repeat == auto {
    count-pauses(body)
  } else {
    repeat
  }

  if type(actual-repeat) != int or actual-repeat < 1 {
    panic("repeat must be auto or a positive integer.")
  }

  // Generate one page for each subslide
  for subslide-index in range(1, actual-repeat + 1) {
    // Process body content for current subslide using helper from utils.typ
    let processed-body = process-content-for-subslide(body, subslide-index)

    // Generate the slide page
    context {
      state-current-subslide.update(subslide-index)

      // 1. Calculate Layout
      // We manually measure the header to determine the top margin so that content doesn't overlap.
      let header-size = state-header-font-size.get()
      let has-title = title != none
      let header-em-height = if has-title { layout-header-height-title } else { layout-header-height-no-title }

      // Measure header height in absolute units to determine top margin
      let header-height-absolute = measure(text(size: header-size)[#v(header-em-height)]).height
      let top-margin = if has-title {
        header-height-absolute + layout-top-margin-extra
      } else {
        layout-top-margin-default
      }

      // 2. Setup Page
      set page(
        fill: white,
        header-ascent: if has-title { 65% } else { 66% },
        header: [], // We draw the header manually in the background to avoid margin issues
        margin: (x: layout-margin-x, top: top-margin, bottom: layout-margin-bottom),
        background: {
          place(slide-header(
            title,
            final-header-color,
            state-header-font-size.get(),
            inset: layout-header-inset,
            height: header-em-height,
            text-color: textcolor,
          ))
        },
        footer: [
          #set text(size: 12pt, fill: gray)
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            state-footer-text.get(), counter(page).display("1 / 1", both: true),
          )
        ],
      )

      set par(justify: true)

      // 3. Apply Slide-Specific Styles
      let x_align = if final-center-x { center } else { left }
      let y_align = if final-center-y { horizon } else { top }

      // Resolve fonts and sizes (fallback to global state if not overridden)
      let font = if slide-main-font != none { slide-main-font } else { state-main-font.get() }
      let size = if slide-main-font-size != none { slide-main-font-size } else { text.size }
      let code-font-val = if slide-code-font != none { slide-code-font } else { state-code-font.get() }
      let code-size = slide-code-font-size

      // Resolve equation numbering
      let eq-numbering = if slide-equation-numbering == auto {
        state-equation-numbering.get()
      } else if slide-equation-numbering {
        "(1)"
      } else {
        none
      }

      set text(font: font, size: size)
      set math.equation(numbering: eq-numbering)
      set align(x_align + y_align)

      // Raw code blocks always use the code font
      show raw: set text(font: code-font-val, size: if code-size != none { code-size } else { size })

      // Reset equation counter if configured
      if state-reset-equation.get() == true {
        counter(math.equation).update(0)
      }

      // Small vertical correction to start content
      v(0cm)
      processed-body
    }
  }
}

