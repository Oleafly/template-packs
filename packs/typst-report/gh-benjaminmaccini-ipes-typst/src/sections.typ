// ===========================================================================
// sections.typ — section openers and heading presentation.
//
// Two ways to open a section:
//   = Market management tools           → plain opener page, section accent
//   #section-opener(image: "x.jpg")[..] → full-bleed image opener
//
// Both emit a real level-1 heading, so numbering, cross-references and the
// outline behave identically. `section-opener` renders the title itself and
// suppresses the default level-1 rule for its own heading, which keeps the
// heading in the document (and in the outline) without drawing it twice.
// ===========================================================================

#import "theme.typ": get-theme, section-accent
#import "marks.typ": bleed, caps, kicker, tick

/// Number of the section that is *about to* start, given that its heading has
/// not been counted yet at the time the opener page is being drawn.
#let _next-section-number() = counter(heading.where(level: 1)).get().first() + 1

#let _accent-for(n, t) = t.colors.sections.at(calc.rem(n - 1, t.colors.sections.len()))

/// Render the background layer of an opener page.
///
/// - `treatment: "scrim"` lays a vertical gradient over the photograph so that
///   white type stays legible at the foot of the page.
/// - `treatment: "tint"` desaturates the photograph and washes it with the
///   section accent, which reads as a deliberate duotone.
/// - `treatment: "flat"` ignores `img` entirely and fills with the accent.
#let _opener-background(img, accent, treatment, t) = {
  // The scrim has to leave the photograph alone until it reaches the type.
  // Ramping from the top washes the whole image in accent and reads as a
  // colour cast rather than as a deliberate panel.
  let scrim = gradient.linear(
    (accent.transparentize(100%), 0%),
    (accent.transparentize(100%), 48%),
    (accent.transparentize(45%), 70%),
    (accent.transparentize(4%), 100%),
    angle: 90deg,
  )

  if img == none or treatment == "flat" {
    rect(width: 100%, height: 100%, fill: accent)
  } else if treatment == "tint" {
    place(top + left, bleed(img, grayscale: true))
    place(top + left, rect(width: 100%, height: 100%, fill: accent.transparentize(35%)))
  } else {
    place(top + left, bleed(img))
    place(top + left, rect(width: 100%, height: 100%, fill: scrim))
  }
}

/// The shared foreground of every opener: section label, rule, title, lede.
///
/// The title dominates and the section label is an eyebrow above it — the
/// other way round reads as a numbered divider rather than a section opening.
#let _opener-foreground(n, title, lede, fg, t, inset) = {
  set text(fill: fg, font: t.fonts.body)
  place(
    bottom + left,
    dx: inset,
    dy: -inset,
    block(width: 100% - 2 * inset)[
      // Display type is never justified: stretching a two-line title to the
      // measure is the classic way to make a cover look broken.
      #set par(leading: 0.5em, justify: false)

      #text(size: t.scale.small, tracking: 0.24em, weight: 700, fill: fg.transparentize(25%))[
        #upper(t.options.section-word) #n
      ]

      #v(0.55em)
      #line(length: 30%, stroke: (thickness: 3pt, paint: fg, cap: "square"))
      #v(0.6em)

      #text(font: t.fonts.display, size: t.scale.display * 1.35, tracking: 0.01em)[
        #upper(title)
      ]

      #if lede != none [
        #v(0.7em)
        #block(width: 68%)[
          #set text(size: t.scale.lead, weight: 300)
          #set par(leading: 0.68em, justify: false)
          #lede
        ]
      ]
    ],
  )
}

/// Open a section on a full-bleed page.
///
/// The heading it emits is a normal level-1 heading; only its *default*
/// presentation is suppressed, because this function draws the title itself.
#let section-opener(
  /// Photograph as bytes, a root-absolute path or `image(..)` content — see
  /// `bleed`. `none` gives a flat accent panel.
  image: none,
  /// Optional standfirst paragraph, set under the title.
  lede: none,
  /// `"scrim"`, `"tint"` or `"flat"`. See `_opener-background`.
  treatment: "scrim",
  /// Override the cycled section accent.
  accent: auto,
  /// Colour of the type on the panel.
  fg: white,
  /// Section title.
  body,
) = context {
  let t = get-theme()
  let n = _next-section-number()
  let accent = if accent == auto { _accent-for(n, t) } else { accent }
  let inset = 18mm

  page(
    margin: 0pt,
    header: none,
    footer: none,
    fill: t.colors.paper,
    {
      _opener-background(image, accent, treatment, t)
      _opener-foreground(n, body, lede, fg, t, inset)
      // The heading itself: counted, outlined, cross-referenceable, unseen.
      place(top + left, {
        show heading: none
        heading(level: 1, body)
      })
    },
  )
}

// --- default heading presentation ------------------------------------------

/// Show rules applied by `report`. Kept here so that the plain `= Title` form
/// and `section-opener` stay visually consistent.
#let heading-rules(body) = {
  show heading.where(level: 1): it => context {
    let t = get-theme()
    let n = counter(heading.where(level: 1)).get().first()
    let accent = _accent-for(calc.max(n, 1), t)
    page(
      margin: 0pt,
      header: none,
      footer: none,
      {
        _opener-background(none, accent, "flat", t)
        _opener-foreground(n, it.body, none, white, t, 18mm)
      },
    )
  }

  show heading.where(level: 2): it => context {
    let t = get-theme()
    let accent = section-accent()
    block(above: t.spacing.section, below: t.spacing.block * 0.8)[
      #set par(leading: 0.5em)
      #if it.numbering != none [
        #text(
          font: t.fonts.display,
          size: t.scale.h1,
          fill: accent,
        )[#counter(heading).display(it.numbering)]
        #h(0.35em)
      ]
      #text(font: t.fonts.display, size: t.scale.h1, fill: t.colors.ink, tracking: 0.02em)[
        #upper(it.body)
      ]
    ]
  }

  show heading.where(level: 3): it => context {
    let t = get-theme()
    block(above: t.spacing.section * 0.8, below: t.spacing.block * 0.55)[
      #set text(
        font: t.fonts.body,
        size: t.scale.h3,
        weight: 700,
        fill: section-accent(),
      )
      #it.body
    ]
  }

  show heading.where(level: 4): it => context {
    let t = get-theme()
    block(above: t.spacing.block, below: t.spacing.para)[
      #set text(font: t.fonts.body, size: t.scale.h4, weight: 700, fill: t.colors.ink)
      #it.body
    ]
  }

  body
}
