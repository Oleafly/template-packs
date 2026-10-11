// ===========================================================================
// covers.typ — front cover, credits page, back cover.
//
// All three are full-page compositions with their own chrome, so each calls
// `page(..)` directly rather than relying on the document's page settings.
// ===========================================================================

#import "@preview/tiaoma:0.3.0"
#import "theme.typ": get-theme
#import "marks.typ": bleed, kicker

/// Front cover.
///
/// With `image` set, the photograph bleeds to the trim and the type sits on a
/// gradient scrim. Without it, the cover is a flat `primary` panel — which is
/// the more common house style for a policy report with no cover art budget.
#let front-cover(
  /// Report title.
  title: none,
  /// Sub-title / standfirst.
  subtitle: none,
  /// Small line above the title, e.g. `[A Special Report]`.
  eyebrow: none,
  /// Cover photograph as bytes, a root-absolute path or `image(..)` content —
  /// see `bleed`. `none` gives a flat panel.
  image: none,
  /// `"scrim"`, `"tint"` or `"flat"`, as in `section-opener`.
  treatment: "scrim",
  /// Issuing organisation, set at the foot.
  publisher: none,
  /// Publication date.
  date: none,
  /// Arbitrary content placed at the top of the cover (a logo, usually).
  logo: none,
  /// Panel colour. Defaults to the theme's `primary`.
  fill: auto,
  /// Colour of the type on the panel.
  fg: white,
) = context {
  let t = get-theme()
  let base = if fill == auto { t.colors.primary } else { fill }
  let inset = 20mm

  page(margin: 0pt, header: none, footer: none, {
    // --- background ---
    if image == none or treatment == "flat" {
      place(top + left, rect(width: 100%, height: 100%, fill: base))
    } else if treatment == "tint" {
      place(top + left, bleed(image, grayscale: true))
      place(top + left, rect(width: 100%, height: 100%, fill: base.transparentize(30%)))
    } else {
      place(top + left, bleed(image))
      place(top + left, rect(
        width: 100%,
        height: 100%,
        // Kept clear over the upper half so the photograph still reads.
        fill: gradient.linear(
          (base.transparentize(100%), 0%),
          (base.transparentize(92%), 40%),
          (base.transparentize(40%), 68%),
          (base.transparentize(0%), 100%),
          angle: 90deg,
        ),
      ))
    }

    set text(fill: fg, font: t.fonts.body)

    // --- top: logo + eyebrow ---
    place(top + left, dx: inset, dy: inset, block(width: 100% - 2 * inset)[
      #if logo != none [#logo #v(1em)]
      #if eyebrow != none [
        #text(size: t.scale.small, tracking: 0.22em, weight: 700)[#upper(eyebrow)]
      ]
    ])

    // --- foot: title block ---
    place(bottom + left, dx: inset, dy: -inset, block(width: 100% - 2 * inset)[
      // Never justify display type — it stretches a wrapped title to the measure.
      #set par(leading: 0.42em, justify: false)
      #text(font: t.fonts.display, size: t.scale.display * 1.5, tracking: 0.01em)[
        #upper(title)
      ]
      #if subtitle != none [
        #v(0.55em)
        #line(length: 22%, stroke: (thickness: 3pt, paint: t.colors.accent, cap: "square"))
        #v(0.5em)
        #block(width: 78%)[
          #set text(size: t.scale.h2, weight: 300)
          #set par(leading: 0.62em, justify: false)
          #subtitle
        ]
      ]
      #if publisher != none or date != none [
        #v(1.4em)
        #set text(size: t.scale.small, tracking: 0.12em, weight: 600)
        #upper(if publisher != none { publisher })
        #if publisher != none and date != none [ #h(0.6em) · #h(0.6em) ]
        #if date != none { upper(date) }
      ]
    ])
  })
}

/// Credits / acknowledgements page.
///
/// `body` is the acknowledgements prose; `citation` and `license` are set as
/// smaller blocks beneath it, which is where reports put the "how to cite this
/// report" and rights statements.
#let credits-page(
  title: [Acknowledgements],
  citation: none,
  license: none,
  contact: none,
  body,
) = context {
  let t = get-theme()
  page(header: none, footer: none, {
    set text(font: t.fonts.body, size: t.scale.small, fill: t.colors.ink)
    set par(justify: true, leading: 0.62em)

    text(font: t.fonts.display, size: t.scale.h2, fill: t.colors.primary)[#upper(title)]
    v(0.6em)
    line(length: 26%, stroke: (thickness: 2.5pt, paint: t.colors.accent, cap: "square"))
    v(1em)

    body

    for (label, content) in (
      ([How to cite this report], citation),
      ([Rights], license),
      ([Contact], contact),
    ) {
      if content != none {
        v(1.2em)
        text(size: t.scale.fine, tracking: 0.18em, weight: 700, fill: t.colors.muted)[
          #upper(label)
        ]
        v(0.35em)
        block(width: 100%, content)
      }
    }
  })
}

/// Back cover: a flat accent panel carrying the colophon.
#let back-cover(
  /// Organisation name, set large.
  publisher: none,
  /// Address / email block.
  contact: none,
  /// Rights statement.
  license: none,
  /// URL. If given, it is also rendered as a QR code.
  url: none,
  /// Set `false` to print the URL without a QR code.
  qr: true,
  /// Panel colour. Defaults to the theme's `primary`.
  fill: auto,
  /// Colour of the type on the panel.
  fg: white,
  /// Optional extra content, placed above the colophon.
  body: none,
) = context {
  let t = get-theme()
  let base = if fill == auto { t.colors.primary } else { fill }
  let inset = 20mm

  page(margin: 0pt, header: none, footer: none, fill: base, {
    set text(fill: fg, font: t.fonts.body, size: t.scale.small)

    if body != none {
      place(top + left, dx: inset, dy: inset, block(width: 100% - 2 * inset, body))
    }

    place(bottom + left, dx: inset, dy: -inset, block(width: 100% - 2 * inset)[
      #grid(
        columns: (1fr, auto),
        align: (bottom + left, bottom + right),
        column-gutter: 10mm,
        [
          #if publisher != none [
            #text(font: t.fonts.display, size: t.scale.h1)[#upper(publisher)]
            #v(0.5em)
          ]
          #set par(leading: 0.6em)
          #if contact != none { contact }
          #if url != none [ #v(0.4em) #text(weight: 600)[#url] ]
          #if license != none [
            #v(0.8em)
            #text(size: t.scale.fine, fill: fg.transparentize(25%))[#license]
          ]
        ],
        if url != none and qr {
          block(fill: fg, inset: 2mm, radius: 1mm, tiaoma.qrcode(
            url,
            options: (fg-color: base, bg-color: fg),
            height: 22mm,
          ))
        },
      )
    ])
  })
}
