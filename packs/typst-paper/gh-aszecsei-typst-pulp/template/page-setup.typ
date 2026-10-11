// ============================================================================
// PAGE SETUP AND STYLING
// Page dimensions, margins, fonts, and paragraph styling
// ============================================================================

#import "config.typ": body-font

// --- PAGE SETUP ---
// Mass-market paperback size: 4.25" x 6.87" (approx 108mm x 175mm)
#let apply-page-setup(body) = {
  set page(
    width: 4.25in,
    height: 6.87in,
    margin: (
      top: 0.7in,
      bottom: 0.45in,
      inside: 0.55in,
      outside: 0.4in,
    ),
    numbering: none,
    number-align: center,
  )
  body
}

// --- FONTS ---
// TeX Gyre Schola (Century Schoolbook clone) - the quintessential 90s paperback font
// Alternative: "TeX Gyre Termes" (Times clone), "Bitstream Charter"
#let apply-text-setup(body) = {
  set text(
    font: body-font,
    size: 9.5pt,
    hyphenate: true,
    lang: "en",
    weight: "regular"
  )
  body
}

// --- PARAGRAPH STYLING ---
#let apply-paragraph-setup(body) = {
  set par(
    justify: true,
    leading: 0.75em,
    first-line-indent: 1.2em,
    spacing: 0.75em,
  )

  // Remove indent after headings and scene breaks
  show heading: it => {
    it
    par(first-line-indent: 0pt)[]
  }

  body
}
