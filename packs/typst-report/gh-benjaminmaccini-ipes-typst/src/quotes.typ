// ===========================================================================
// quotes.typ — pull quotes, epigraphs and statistic callouts.
//
// These are the "picked-out" elements that break up long policy prose. All
// three bleed into the outer margin by default via `marginalia.wideblock`,
// which is what gives the page its magazine rhythm.
// ===========================================================================

#import "@preview/marginalia:0.3.1" as marginalia
#import "@preview/zero:0.7.0"
#import "theme.typ": get-theme, section-accent
#import "marks.typ": source-note

/// A pull quote: a sentence lifted from the body and set large.
///
/// ```typ
/// #pull-quote(attribution: [IPES-Food, 2024])[
///   Territorial markets feed the majority of the world's population.
/// ]
/// ```
#let pull-quote(
  /// Who said it. Set small beneath the quote.
  attribution: none,
  /// Override the accent.
  accent: auto,
  /// `true` extends the block into the outer margin.
  wide: true,
  /// Set `false` to drop the leading rule.
  rule: true,
  /// The quotation.
  body,
) = context {
  let t = get-theme()
  let c = if accent == auto { section-accent() } else { accent }

  let inner = block(
    width: 100%,
    above: t.spacing.section,
    below: t.spacing.section,
    breakable: false,
    {
      if rule {
        line(length: 18%, stroke: (thickness: 3pt, paint: c, cap: "square"))
        v(0.6em)
      }
      set text(size: t.scale.h2, weight: 300, fill: t.colors.ink)
      set par(leading: 0.66em, justify: false)
      body
      if attribution != none {
        v(0.6em)
        set text(size: t.scale.fine, weight: 700, tracking: 0.16em, fill: c)
        upper(attribution)
      }
    },
  )

  if wide { marginalia.wideblock(inner) } else { inner }
}

/// An epigraph: a short quotation set above or beneath a heading.
#let epigraph(
  /// Attribution line.
  source: none,
  /// The quotation.
  body,
) = context {
  let t = get-theme()
  block(width: 82%, above: t.spacing.block, below: t.spacing.section, {
    set text(size: t.scale.base, style: "italic", fill: t.colors.muted)
    set par(leading: 0.64em)
    body
    if source != none {
      v(0.35em)
      set text(size: t.scale.fine, style: "normal", tracking: 0.12em, weight: 600)
      upper[— #source]
    }
  })
}

/// A statistic callout: one big number carrying one claim.
///
/// `value` may be a number (grouped with `zero`), a string, or content.
///
/// ```typ
/// #stat(value: 70, unit: [%], label: [of the world is fed by small-scale producers])
/// ```
#let stat(
  /// The figure itself.
  value: none,
  /// Unit or suffix, set smaller beside the value.
  unit: none,
  /// The claim the figure supports.
  label: none,
  /// Provenance, set beneath the label.
  source: none,
  /// Override the accent.
  accent: auto,
  /// Size of the figure. `auto` is sized to work both on its own and inside a
  /// `stat-row`; pass `theme.scale.mega` for the full-page treatment.
  size: auto,
  /// `true` extends the block into the outer margin.
  wide: false,
) = context {
  let t = get-theme()
  let c = if accent == auto { section-accent() } else { accent }
  let size = if size == auto { t.scale.display * 1.2 } else { size }

  let shown = if type(value) in (int, float) {
    zero.num(str(value))
  } else { value }

  let inner = block(
    width: 100%,
    above: t.spacing.block * 1.2,
    below: t.spacing.block * 1.2,
    breakable: false,
    {
      set par(leading: 0.4em)
      // One box, so the unit can never be orphaned onto its own line.
      box({
        text(font: t.fonts.display, size: size, fill: c)[#shown]
        if unit != none {
          text(font: t.fonts.display, size: size * 0.45, fill: c)[#unit]
        }
      })
      if label != none {
        v(0.25em)
        block(width: 100%)[
          // Narrow columns plus justification plus hyphenation is how a stat
          // row turns into a wall of broken words.
          #set text(size: t.scale.small, weight: 300, fill: t.colors.ink, hyphenate: false)
          #set par(leading: 0.6em, justify: false)
          #label
        ]
      }
      if source != none {
        v(0.3em)
        source-note(source)
      }
    },
  )

  if wide { marginalia.wideblock(inner) } else { inner }
}

/// A row of statistics, sized evenly. Pass the results of `stat`.
#let stat-row(..items) = context {
  let t = get-theme()
  let cells = items.pos()
  block(width: 100%, above: t.spacing.section, below: t.spacing.section, grid(
    columns: cells.map(_ => 1fr),
    column-gutter: 1.4em,
    ..cells,
  ))
}
