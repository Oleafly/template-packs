// Design tokens. Plain constants: there is one light theme, so nothing here
// needs state. The accent is the only per-deck value and lives in Touying's
// `self.colors.primary`, not in this file.

// ---------------------------------------------------------------------------
// Fonts
// ---------------------------------------------------------------------------

// Typst warns about every unknown family in a list, even when an earlier one
// resolves, so each fallback absent on some platform is a permanent warning
// there. The mono and math fallbacks are embedded in the Typst binary and
// never warn. Typst embeds no sans, and without a fallback a missing Inter
// drops to Libertinus Serif; Arial covers macOS and Windows at the cost of one
// spurious warning on Linux systems without it. Keep these lists short.
#let font-sans = ("Inter", "Arial")
#let font-mono = ("JetBrains Mono", "DejaVu Sans Mono")
#let font-math = ("STIX Two Math", "New Computer Modern Math")

// STIX Two has a smaller x-height than Inter; scale math so inline symbols
// sit level with the surrounding text.
#let math-scale = 1.1em

// ---------------------------------------------------------------------------
// Neutrals
// ---------------------------------------------------------------------------

#let paper = rgb("#ffffff")
#let ink = rgb("#1f2328")
#let ink-muted = rgb("#59636e")
#let ink-subtle = rgb("#818b98")
#let rule = rgb("#d1d9e0")
#let surface = rgb("#f6f8fa") // code blocks only
#let marker = rgb("#ebcb8b") // `#highlight`, a highlighter pen; never the accent

// ---------------------------------------------------------------------------
// Accent presets. `accent:` also accepts any color.
// ---------------------------------------------------------------------------

#let accents = (
  blue: rgb("#1a5fb4"),
  navy: rgb("#2f5597"), // muted blue, closer to a classic beamer deck
  green: rgb("#1a7f37"),
  burgundy: rgb("#8c2131"),
  purple: rgb("#6e40c9"),
  orange: rgb("#bc4c00"),
  mono: ink,
)

// Color of titles: the accent's hue taken down to ink darkness, so a title
// reads as a tinted ink and `#alert` stays the brightest thing on the slide.
// Blue gives navy, burgundy a dark wine, `mono` stays ink.
#let title-ink(accent) = {
  let (l, c, h, ..) = oklch(accent).components()
  oklch(calc.min(l, 30%), c * 0.7, h)
}

// ---------------------------------------------------------------------------
// Type scale, for the 841.89 x 473.56 pt "presentation-16-9" page.
// ---------------------------------------------------------------------------

#let size = (
  display: 40pt, // section slide title
  deck-title: 34pt, // title slide; academic titles are long
  focus: 32pt, // focus slide
  title: 27pt, // slide title
  subtitle: 22pt,
  body: 20pt, // default of the theme's `text-size`
  // Relative to the body, so that `text-size:` or a local
  // `#set text(size: ..)` scales a slide's content as a whole.
  small: 0.8em, // tables, labels, bibliography
  note: 0.65em, // footnotes, captions, sources
  micro: 11pt, // footer, counters
)

// ---------------------------------------------------------------------------
// Spacing
// ---------------------------------------------------------------------------

#let space = (
  page-x: 40pt,
  page-top: 78pt, // holds the slide title
  page-bottom: 40pt, // holds the footer
  title-gap: 18pt, // title rule -> first line of body
  footer-gap: 14pt, // body area -> footer
  // An auto-sized figure (with its caption) squeezed below this height makes
  // the slide warn as overfull. About 40% of the 16:9 body (355pt).
  figure-min: 150pt,
)
