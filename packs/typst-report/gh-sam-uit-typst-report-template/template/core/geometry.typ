// /template/core/geometry.typ
// Paper size and margin resolution
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Resolves paper size strings into Typst page parameters and
// handles one-sided vs two-sided margin asymmetry.

// MARK: Paper Sizes

/// Supported paper size names.
/// Maps to the Typst built-in paper name string for `set page(paper: ...)`.
#let paper-sizes = (
  a4: "a4",
  a5: "a5",
  letter: "us-letter",
)

// MARK: Margin Resolution

/// Resolves a margin specification into a Typst margin dictionary.
///
/// Accepts:
///   - A single length: applied to all sides
///   - A dictionary with `all`: applied to all sides
///   - A dictionary with `x`/`y`: horizontal/vertical
///   - A dictionary with `inside`/`outside`/`top`/`bottom`: for two-sided
///   - A dictionary with `left`/`right`/`top`/`bottom`: explicit sides
///
/// - margin: The raw margin value from config
/// - two-sided (bool): Whether the document uses two-sided layout
/// -> dictionary
#let resolve-margins(margin, two-sided) = {
  if type(margin) == length {
    // Single length → all sides equal
    (top: margin, bottom: margin, left: margin, right: margin)
  } else if type(margin) == dictionary {
    if "all" in margin {
      let m = margin.all
      (top: m, bottom: m, left: m, right: m)
    } else if "x" in margin and "y" in margin {
      (top: margin.y, bottom: margin.y, left: margin.x, right: margin.x)
    } else if "inside" in margin and "outside" in margin {
      // Two-sided: inside = binding edge (left on odd, right on even)
      let top = if "top" in margin { margin.top } else { margin.inside }
      let bottom = if "bottom" in margin { margin.bottom } else { margin.inside }
      if two-sided {
        (top: top, bottom: bottom, inside: margin.inside, outside: margin.outside)
      } else {
        // Fallback: inside → left, outside → right
        (top: top, bottom: bottom, left: margin.inside, right: margin.outside)
      }
    } else {
      // Explicit left/right/top/bottom — pass through
      margin
    }
  } else {
    // Fallback: reasonable default
    (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm)
  }
}

// MARK: Page Geometry

/// Returns the resolved page arguments as a dictionary suitable for
/// spreading into `set page(...)`.
///
/// - paper (str): Paper size name ("a4", "a5", "letter")
/// - margin: Raw margin specification
/// - two-sided (bool): Whether to use two-sided layout
/// -> dictionary
#let page-geometry(paper, margin, two-sided) = {
  let paper-name = if paper in paper-sizes {
    paper-sizes.at(paper)
  } else {
    "a4" // fallback
  }
  let resolved-margin = resolve-margins(margin, two-sided)
  (
    paper: paper-name,
    margin: resolved-margin,
  )
}
