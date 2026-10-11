// The template entry point: #show: init.with(theme: "flexoki-light")

#import "settings.typ": (
  def-fonts, def-headings, def-margin, def-paper, def-side, def-texts,
  def-theme, resolve-settings, settings,
)
#import "layout.typ": page-background, page-footer, paper-margin
#import "heading.typ": heading-rules
#import "theorem.typ": theorem-rules

#import "@preview/hydra:0.6.3": anchor

#let init(
  it,
  paper: def-paper,
  margin: def-margin,
  side: def-side,
  texts: def-texts,
  fonts: def-fonts,
  headings: def-headings,
  theme: def-theme,
) = context {
  let s = resolve-settings(paper, margin, side, texts, fonts, headings, theme)

  // The line grid is built around the ascender height of the body font at the
  // configured size, so measure it from the resolved settings.
  s.texts.ascender = measure(text(font: s.fonts.body, size: s.texts.size, "h")).height

  settings.update(_ => s)

  let (paper, margin, side, body, fonts, texts, headings, theme) = s

  set page(
    fill: theme.page,
    margin: paper-margin(margin, texts),
    background: page-background(paper, margin, side, fonts, theme),
    footer: page-footer(body, margin, side, fonts, theme),
    header: anchor(),
  )

  set text(font: fonts.body, size: texts.size, fill: theme.text)
  set par(
    leading: texts.step,
    // Keep lines at least `step + ascender` apart so mixed font sizes stay on
    // the grid.
    spacing: (texts.step + texts.ascender) * 1.5 - texts.ascender,
    justify: true,
  )

  show math.equation: set text(font: fonts.math)
  show math.equation.where(block: true): block.with(breakable: true)
  show math.equation.where(block: false): it => it // inline equations: unchanged

  // Number headings from level 2 on; level 1 is a divider page.
  set heading(numbering: (..levels) => {
    let parts = levels.pos()
    if parts.len() > 1 { parts.map(str).join(".") } else { none }
  })

  show: heading-rules
  show: theorem-rules.with(
    base-level: headings.thm.base,
    pattern: headings.thm.numbering,
  )

  it
}
