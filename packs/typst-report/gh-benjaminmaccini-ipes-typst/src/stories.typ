// ===========================================================================
// stories.typ — "data stories": figures that carry an argument, not just a
// picture.
//
// Four widths, because the difference between a chart that works and one that
// does not is usually how much room it was given:
//
//   "column"  inside the text measure, like an ordinary figure
//   "wide"    bleeds into the outer margin (via marginalia)
//   "full"    a page of its own, portrait
//   "spread"  a page of its own, landscape — for wide time series and maps
//
// Every variant is a `figure(kind: "story")`, so `index-of(kind: "story")`
// lists them and `@label` references them.
// ===========================================================================

#import "@preview/marginalia:0.3.1" as marginalia
#import "theme.typ": get-theme, section-accent
#import "marks.typ": source-note

/// The furniture around a data story: label, title, standfirst, source.
#let _story-frame(it, subtitle, source, note, accent, t) = {
  let c = if accent == auto { section-accent() } else { accent }

  // `figure` centres its body; a data story reads as a left-aligned unit.
  set align(left)
  block(width: 100%, breakable: false, {
    set par(leading: 0.5em, justify: false)
    text(
      font: t.fonts.display,
      size: t.scale.h3,
      fill: c,
      tracking: 0.12em,
    )[#upper[Figure #it.counter.display(it.numbering)]]

    if it.caption != none {
      v(0.25em)
      text(font: t.fonts.display, size: t.scale.h2, fill: t.colors.ink, tracking: 0.02em)[
        #upper(it.caption.body)
      ]
    }

    if subtitle != none {
      v(0.35em)
      block(width: 88%)[
        #set text(size: t.scale.small, fill: t.colors.muted, weight: 300)
        #set par(leading: 0.6em)
        #subtitle
      ]
    }

    v(0.8em)
    it.body
    v(0.6em)

    if note != none {
      set text(size: t.scale.fine, fill: t.colors.ink)
      set par(leading: 0.55em)
      note
      v(0.3em)
    }
    if source != none { source-note(source) }
  })
}

/// A data story.
///
/// ```typ
/// #data-story(
///   title: [The forces reshaping global food systems],
///   subtitle: [Four pressures, one outcome.],
///   source: [IPES-Food analysis.],
///   width: "spread",
/// )[ #map(..) ]
/// ```
#let data-story(
  /// Figure title, also used by `index-of(kind: "story")`.
  title: none,
  /// Standfirst beneath the title — the sentence that says what to look for.
  subtitle: none,
  /// Provenance line.
  source: none,
  /// Longer explanatory note, set above the source.
  note: none,
  /// `"column"`, `"wide"`, `"full"` or `"spread"`.
  width: "column",
  /// Override the accent.
  accent: auto,
  /// Background fill for `"full"` and `"spread"` pages.
  fill: auto,
  /// Page margin for `"full"` and `"spread"`. These pages carry no running
  /// header and no body text, so the generous margins that keep the reading
  /// measure honest only waste space here.
  margin: 16mm,
  /// Label to attach, e.g. `tag: <fig:imports>`, so the story can be referenced
  /// with `@fig:imports`. A label cannot be attached at the call site because
  /// this block carries its own `show` rules, which makes the returned content
  /// styled.
  tag: none,
  /// The visual itself.
  body,
) = {
  show figure.where(kind: "story"): it => context {
    let t = get-theme()
    _story-frame(it, subtitle, source, note, accent, t)
  }
  show figure.caption: none

  let fig = {
    let f = figure(kind: "story", supplement: [Figure], caption: title, numbering: "1", body)
    if tag == none { f } else { [#f#tag] }
  }

  context {
    let t = get-theme()
    let bg = if fill == auto { t.colors.paper } else { fill }

    if width == "column" {
      fig
    } else if width == "wide" {
      marginalia.wideblock(fig)
    } else if width == "full" {
      // `figure` shrink-wraps; the explicit block is what makes the story take
      // the whole measure of its own page instead of collapsing to its caption.
      page(
        margin: margin,
        header: none,
        footer: none,
        fill: bg,
        align(horizon, block(width: 100%, fig)),
      )
    } else if width == "spread" {
      page(
        flipped: true,
        margin: margin,
        header: none,
        footer: none,
        fill: bg,
        align(horizon, block(width: 100%, fig)),
      )
    } else {
      panic("data-story: width must be \"column\", \"wide\", \"full\" or \"spread\", got " + repr(width))
    }
  }
}
