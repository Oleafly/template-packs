// ===========================================================================
// theme.typ — design tokens
//
// Every visual decision in `dossier` reads from a theme dictionary held in
// `theme-state`. No component hard-codes a colour or a font, so re-skinning a
// report is a single `make-theme(..)` call. The defaults are the IPES-Food
// look (deep green / warm orange on cream); pass your own `primary`/`accent`
// and the rest of the system re-derives around them.
// ===========================================================================

// --- internal helpers ------------------------------------------------------

/// Blend `t` of colour `b` into colour `a`.
#let _mix(a, b, t) = color.mix((a, 100% - t), (b, t))

/// Merge a user dictionary over a defaults dictionary (one level deep).
#let _merge(defaults, user) = {
  if user == none { return defaults }
  let out = defaults
  for (k, v) in user { out.insert(k, v) }
  out
}

/// Resolve `auto` to a fallback, otherwise pass the value through.
#let _or(value, fallback) = if value == auto { fallback } else { value }

/// Derive a related colour: rotate the hue, then pull saturation and lightness
/// onto an explicit target.
///
/// Deriving the extra section and series colours beats naming them, so that a
/// theme built from a custom `primary` gets a coherent set instead of two
/// leftover hues from the default palette. Rotating the hue *alone* is not
/// enough: it inherits the source's lightness, so a dark primary yields a
/// near-black and a bright accent yields neon. The tonal targets keep every
/// derived colour in the same register as the ones it sits beside.
#let _derive(c, degrees, lightness: auto, saturation: auto) = {
  let (hue, sat, light, alpha) = color.hsl(c).components()
  color.hsl(
    hue + degrees,
    _or(saturation, sat),
    _or(lightness, light),
    alpha,
  )
}

// --- default token sets ----------------------------------------------------

/// Font stacks. Each entry degrades to a macOS system font so the document
/// still compiles without `--font-path fonts/`.
#let default-fonts = (
  display: ("Bebas Neue", "DIN Alternate", "Impact"),
  body: ("Open Sans", "Avenir Next", "Helvetica Neue", "Arial"),
  serif: ("Charter", "Georgia"),
  mono: ("Menlo", "Courier New"),
)

/// Type scale. Tuned for a two-column-ish A4 measure at `base`.
#let default-scale = (
  micro: 6pt,
  fine: 7pt,
  small: 8pt,
  base: 9.5pt,
  lead: 11.5pt,
  h4: 9.5pt,
  h3: 11pt,
  h2: 15pt,
  h1: 22pt,
  display: 36pt,
  mega: 72pt,
)

/// Vertical rhythm and page furniture.
#let default-spacing = (
  para: 0.62em,
  block: 1.15em,
  section: 1.9em,
  lead-in: 0.45em,
)

/// Page geometry. The left/right values feed `marginalia.setup`, which owns
/// the page margins so that margin notes and wide blocks line up.
#let default-page = (
  paper: "a4",
  book: false,
  inner: (far: 12mm, width: 26mm, sep: 6mm),
  outer: (far: 12mm, width: 26mm, sep: 6mm),
  top: 26mm,
  bottom: 22mm,
  clearance: 12pt,
)

// --- the IPES palette ------------------------------------------------------

// The three colours the default theme is built from. Everything else in the
// default palette is derived from these, so overriding them re-derives the
// whole system rather than leaving these hues stranded in the series colours.
#let ipes-green = rgb("#1f4d3d")
#let ipes-orange = rgb("#e0562a")
#let ipes-gold = rgb("#f2b233")

// --- theme constructor -----------------------------------------------------

/// Build a complete theme from a small number of decisions.
///
/// Anything left as `auto` is derived from `primary`, `accent` and `paper`, so
/// `make-theme(primary: rgb("#123456"))` yields a coherent system. Pass an
/// explicit value to override any single derivation.
#let make-theme(
  /// Dominant brand colour: section openers, headings, rules.
  primary: ipes-green,
  /// Contrast colour: pull quotes, stats, callout accents.
  accent: ipes-orange,
  /// Third colour, used for a subset of section openers and chart series.
  support: ipes-gold,
  /// Page background.
  paper: rgb("#ffffff"),
  /// Body text colour.
  ink: rgb("#161513"),
  /// Secondary text (captions, sources, folios). `auto` lightens `ink`.
  muted: auto,
  /// Hairline rules and table borders. `auto` derives from `ink` over `paper`.
  rule: auto,
  /// Fill for boxes and case studies. `auto` derives a tint of `primary`.
  surface: auto,
  /// Stronger fill, for box title bars. `auto` derives from `primary`.
  surface-strong: auto,
  /// One accent per top-level section, cycled. `auto` builds a five-colour set.
  sections: auto,
  /// Ordered ramp for choropleths and sequential data. `auto` builds 5 steps
  /// from `paper` to `primary`.
  sequential: auto,
  /// Qualitative series colours for charts. `auto` builds 6.
  categorical: auto,
  /// Overrides merged over `default-fonts`.
  fonts: (:),
  /// Overrides merged over `default-scale`.
  scale: (:),
  /// Overrides merged over `default-spacing`.
  spacing: (:),
  /// Overrides merged over `default-page`.
  page: (:),
  /// Behavioural switches, merged over the defaults below.
  options: (:),
) = {
  let muted = _or(muted, _mix(ink, paper, 45%))
  let rule = _or(rule, _mix(paper, ink, 18%))
  let surface = _or(surface, _mix(paper, primary, 7%))
  let surface-strong = _or(surface-strong, _mix(paper, primary, 14%))

  (
    colors: (
      paper: paper,
      ink: ink,
      muted: muted,
      rule: rule,
      surface: surface,
      surface-strong: surface-strong,
      primary: primary,
      accent: accent,
      support: support,
      sections: _or(
        sections,
        (
          primary,
          accent,
          _derive(primary, 35deg, lightness: 36%, saturation: 50%),
          support,
          _derive(accent, -55deg, lightness: 34%, saturation: 28%),
        ),
      ),
      sequential: _or(
        sequential,
        (
          _mix(paper, primary, 12%),
          _mix(paper, primary, 32%),
          _mix(paper, primary, 55%),
          _mix(paper, primary, 78%),
          primary,
        ),
      ),
      categorical: _or(
        categorical,
        (
          primary,
          accent,
          _derive(primary, 35deg, lightness: 36%, saturation: 50%),
          support,
          _derive(accent, -55deg, lightness: 34%, saturation: 28%),
          _mix(primary, paper, 45%),
        ),
      ),
    ),
    fonts: _merge(default-fonts, fonts),
    scale: _merge(default-scale, scale),
    spacing: _merge(default-spacing, spacing),
    page: _merge(default-page, page),
    options: _merge(
      (
        // Running headers and box titles in caps.
        caps-headers: true,
        // Tracking added to capitalised display text.
        caps-tracking: 0.08em,
        // Draw a hairline under the running header.
        header-rule: true,
        // Number sections 1 / 1.1 / 1.1.1.
        numbered-sections: true,
        // Word used before a top-level heading in the outline and openers.
        section-word: "Section",
      ),
      options,
    ),
  )
}

/// The default theme: the IPES-Food look.
#let ipes-theme = make-theme()

// --- theme access ----------------------------------------------------------

#let theme-state = state("dossier:theme", ipes-theme)

/// Current theme. Requires context.
#let get-theme() = theme-state.get()

/// Run `fn(theme)` inside a context block. Saves writing
/// `context { let t = get-theme(); .. }` in every component.
#let themed(fn) = context fn(get-theme())

/// Accent colour for the section currently being typeset, cycling through
/// `theme.colors.sections`. Requires context.
#let section-accent() = {
  let t = get-theme()
  let n = counter(heading.where(level: 1)).get().first()
  if n <= 0 { t.colors.primary } else {
    t.colors.sections.at(calc.rem(n - 1, t.colors.sections.len()))
  }
}
