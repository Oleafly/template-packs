// Package defaults, configuration merging, and the resolved `settings` state.

#import "theme.typ": def-theme, themes

// Paper: a 1 : sqrt(2) rectangle (A4 proportions) by default.
#let def-paper-width = 21cm
#let def-paper = (
  width: def-paper-width,
  height: def-paper-width * calc.sqrt(2),
)

// Margins, proportional to the paper width. `e` (outer) hosts the sidenotes.
#let def-margin = (
  t: def-paper-width / 9,
  f: def-paper-width / 6,
  e: def-paper-width / 4,
  s: def-paper-width / 9,
)

#let def-side = (
  half-gutter: 0.3cm, // gap between the text body and the sidenote text
  margin: def-margin.s / 3, // extra spacing toward the paper edge
)

// `step` sets the line grid: consecutive baselines sit one step apart.
// `ascender` is not configurable — `init` measures it from the body font.
#let def-texts = (
  size: 11pt,
  step: 7.5pt,
)

#let def-fonts = (
  body: "XCharter",
  math: "TeX Gyre Pagella Math",
  sans: "Hanken Grotesk",
  mono: "IBM Plex Mono",
)

#let def-headings = (
  h2: (
    sym: sym.circle.filled,
    dy: 0pt,
    size: 2,
  ),
  h3: (
    sym: sym.triangle.filled.small.b,
    dy: 0pt,
    size: 1.5,
  ),
  thm: (
    base: 1, // heading level at which theorem numbering restarts
    numbering: "1.1.1", // <section>.<subsection>.<theorem>
  ),
)

// Recursively fill missing (or `none`) entries of `user` from `defaults`.
// Neither argument is mutated.
#let merge-defaults(user, defaults) = {
  if type(defaults) != dictionary {
    return if user == none { defaults } else { user }
  }
  if type(user) != dictionary {
    return defaults
  }
  let merged = (:)
  for (key, default) in defaults {
    merged.insert(key, merge-defaults(user.at(key, default: none), default))
  }
  for (key, value) in user {
    if not merged.keys().contains(key) {
      merged.insert(key, value)
    }
  }
  merged
}

// Merge the user's configuration with the defaults and derive the computed
// values: the text body, the sidenote width, and the resolved theme dictionary.
#let resolve-settings(paper, margin, side, texts, fonts, headings, theme) = {
  let s = merge-defaults(
    (
      paper: paper,
      margin: margin,
      side: side,
      texts: texts,
      fonts: fonts,
      headings: headings,
      theme: theme,
    ),
    (
      paper: def-paper,
      margin: def-margin,
      side: def-side,
      texts: def-texts,
      fonts: def-fonts,
      headings: def-headings,
      theme: def-theme,
    ),
  )

  if not themes.keys().contains(s.theme) {
    panic("Unknown theme: " + str(s.theme))
  }

  s.side.width = s.margin.e - s.side.margin - s.side.half-gutter
  s.body = (
    width: s.paper.width - s.margin.s - s.margin.e,
    height: s.paper.height - s.margin.t - s.margin.f,
  )
  s.theme = themes.at(s.theme)
  s
}

// Published by `init` and read by every other module.
#let settings = state("obelisk:settings", none)
