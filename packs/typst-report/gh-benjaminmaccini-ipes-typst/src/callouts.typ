// ===========================================================================
// callouts.typ — boxes, case studies, key messages, recommendations.
//
// Each block is a `figure` with its own `kind`, which buys auto-numbering,
// `@label` cross-references and `index-of(kind: ..)` listings for free. Each
// also carries its own scoped `show` rule, so the blocks work standalone and
// do not depend on the `report` show rule having been applied.
// ===========================================================================

#import "@preview/showybox:2.0.4": showybox
#import "theme.typ": get-theme, section-accent
#import "marks.typ": hairline

/// Title bar shared by `box-note` and `case-study`.
#let _bar(label, title, fg, t) = {
  set par(leading: 0.5em)
  set text(fill: fg)
  text(font: t.fonts.display, size: t.scale.h3, tracking: 0.1em)[#upper(label)]
  if title != none {
    h(0.6em)
    text(fill: fg.transparentize(45%))[|]
    h(0.6em)
    text(font: t.fonts.display, size: t.scale.h3, tracking: 0.04em)[#upper(title)]
  }
}

/// A definitional or explanatory box — the "BOX 3 · SUPPLY MANAGEMENT" form.
///
/// ```typ
/// #box-note(title: [Supply management])[
///   Supply management can take several forms...
/// ] <box:supply>
/// ```
#let box-note(
  /// Box title, also used for the `index-of(kind: "box")` listing.
  title: none,
  /// Override the accent. Defaults to the current section's accent.
  accent: auto,
  /// Let the box split across pages.
  breakable: true,
  /// Optional footer, typically a source line.
  footer: none,
  /// Label to attach, e.g. `tag: <box:stocks>`, so the block can be referenced
  /// with `@box:stocks`. A label cannot be attached at the call site because
  /// these blocks carry their own `show` rules, which makes the returned
  /// content styled.
  tag: none,
  /// Box contents.
  body,
) = {
  show figure.where(kind: "box"): it => context {
    let t = get-theme()
    let c = if accent == auto { section-accent() } else { accent }
    // `figure` centres its body; these blocks are left-aligned units.
    set align(left)
    showybox(
      frame: (
        title-color: c,
        body-color: t.colors.surface,
        footer-color: t.colors.surface-strong,
        border-color: c,
        radius: 0pt,
        thickness: 0pt,
        inset: (x: 1.1em, y: 0.85em),
      ),
      title-style: (align: left, boxed-style: none),
      body-style: (align: left),
      breakable: breakable,
      width: 100%,
      title: _bar(
        [Box #it.counter.display(it.numbering)],
        if it.caption != none { it.caption.body },
        white,
        t,
      ),
      footer: if footer != none { text(size: t.scale.fine, fill: t.colors.muted, footer) } else { "" },
      {
        set text(size: t.scale.small, fill: t.colors.ink)
        set par(justify: true, leading: 0.6em)
        it.body
      },
    )
  }
  show figure.caption: none

  let fig = figure(kind: "box", supplement: [Box], caption: title, numbering: "1", body)
  if tag == none { fig } else { [#fig#tag] }
}

/// A case study: a real-world example, keyed to a place.
///
/// Visually distinct from `box-note` — a heavy left rule rather than a filled
/// panel — because the two appear on the same page often enough that they need
/// to be told apart at a glance.
#let case-study(
  /// Case-study title, also used for the `index-of` listing.
  title: none,
  /// Where the case study is set, e.g. `[Brazil]`. Printed as an eyebrow.
  region: none,
  /// Override the accent.
  accent: auto,
  /// Optional source line, set beneath the body.
  source: none,
  /// Label to attach, e.g. `tag: <box:stocks>`, so the block can be referenced
  /// with `@box:stocks`. A label cannot be attached at the call site because
  /// these blocks carry their own `show` rules, which makes the returned
  /// content styled.
  tag: none,
  /// Case-study contents.
  body,
) = {
  show figure.where(kind: "case-study"): it => context {
    let t = get-theme()
    let c = if accent == auto { section-accent() } else { accent }
    set align(left)
    block(
      width: 100%,
      above: t.spacing.block * 1.3,
      below: t.spacing.block * 1.3,
      breakable: true,
      stroke: (left: (thickness: 3pt, paint: c)),
      inset: (left: 1.1em, rest: 0pt),
      {
        set par(leading: 0.5em)
        text(
          size: t.scale.fine,
          tracking: 0.2em,
          weight: 700,
          fill: c,
        )[#upper[Case study #it.counter.display(it.numbering)]#if region != none [ · #upper(region)]]

        v(0.45em)
        if it.caption != none {
          text(font: t.fonts.display, size: t.scale.h2, fill: t.colors.ink, tracking: 0.02em)[
            #upper(it.caption.body)
          ]
          v(0.5em)
        }
        {
          set text(size: t.scale.small)
          set par(justify: true, leading: 0.62em)
          it.body
        }
        if source != none {
          v(0.5em)
          text(size: t.scale.fine, fill: t.colors.muted)[#source]
        }
      },
    )
  }
  show figure.caption: none

  let fig = figure(kind: "case-study", supplement: [Case study], caption: title, numbering: "1", body)
  if tag == none { fig } else { [#fig#tag] }
}

/// The "KEY MESSAGES" opener: a run of short, emphatic statements.
///
/// Pass each message as a list item; the first sentence of each is picked out
/// in the display face, which is how the source reports handle them.
#let key-messages(
  /// Heading printed above the list.
  title: [Key messages],
  /// Override the accent.
  accent: auto,
  /// A `list` of messages.
  body,
) = context {
  let t = get-theme()
  let c = if accent == auto { t.colors.primary } else { accent }

  block(width: 100%, above: 0pt, below: t.spacing.section)[
    #text(font: t.fonts.display, size: t.scale.h1, fill: c)[#upper(title)]
    #v(0.4em)
    #line(length: 26%, stroke: (thickness: 3pt, paint: t.colors.accent, cap: "square"))
    #v(1em)

    #show list.item: it => block(above: 0.9em, below: 0.9em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.9em,
        align: (top + left, top + left),
        box(width: 7pt, height: 7pt, fill: t.colors.accent, baseline: -0.35em),
        it.body,
      )
    ]
    #set text(size: t.scale.lead, weight: 300)
    #set par(leading: 0.68em, justify: false)
    #body
  ]
}

/// A numbered policy recommendation.
#let recommendation(
  /// Recommendation title.
  title: none,
  /// Override the accent.
  accent: auto,
  /// Label to attach, e.g. `tag: <rec:stocks>`, so the block can be referenced
  /// with `@rec:stocks`. A label cannot be attached at the call site because
  /// these blocks carry their own `show` rules, which makes the returned
  /// content styled.
  tag: none,
  /// Recommendation contents.
  body,
) = {
  show figure.where(kind: "recommendation"): it => context {
    let t = get-theme()
    let c = if accent == auto { t.colors.accent } else { accent }
    set align(left)
    block(width: 100%, above: t.spacing.block * 1.2, below: t.spacing.block * 1.2, breakable: true)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        align: (top + right, top + left),
        text(font: t.fonts.display, size: t.scale.h1, fill: c)[
          #it.counter.display(it.numbering)
        ],
        [
          #if it.caption != none [
            #text(font: t.fonts.body, size: t.scale.h3, weight: 700, fill: t.colors.ink)[
              #it.caption.body
            ]
            #v(0.35em)
          ]
          #set text(size: t.scale.small)
          #set par(justify: true, leading: 0.62em)
          #it.body
        ],
      )
    ]
  }
  show figure.caption: none

  let fig = figure(
    kind: "recommendation",
    supplement: [Recommendation],
    caption: title,
    numbering: "1",
    body,
  )
  if tag == none { fig } else { [#fig#tag] }
}
