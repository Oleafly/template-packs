// components/spreads.typ — Full-page constructs

#import "../theme.typ": fonts, gradients, palette, space, type-scale
#import "../print.typ": page-bleed, print-foreground

// ── Book cover ─────────────────────────────────────────────────
// Full-bleed cover with gradient, title, decorative overlays.
// CRITICAL: After calling this, you MUST pagebreak() + re-apply setup-pages().
// Print mode: bleed + crop marks; fill lives in `background` so it extends
// into the bleed area (body 100% is trim-only; bg/fg resolve with bleed).
#let book-cover(
  title: none,
  subtitle: none,
  author: none,
  edition: none,
) = {
  set page(
    margin: 0pt,
    header: none,
    footer: none,
    bleed: page-bleed,
    foreground: print-foreground,
    // Background resolves % against page+bleed → true press bleed.
    background: rect(width: 100%, height: 100%, fill: gradients.cover, stroke: none),
  )

  // Content sits on the trim area (margin 0); decorative overlays may
  // reach the edges and visually continue into the bleed fill behind.
  block(
    width: 100%,
    height: 100%,
    {
      // Decorative circle — top-right
      place(
        top + right,
        dx: -20pt,
        dy: 40pt,
        circle(radius: 80pt, fill: palette.primary-light.transparentize(70%)),
      )

      // Decorative circle — bottom-left
      place(
        bottom + left,
        dx: 30pt,
        dy: -60pt,
        circle(radius: 120pt, fill: palette.accent.transparentize(80%)),
      )

      // Accent bar — left edge (extends into bleed via background colour)
      place(
        left + horizon,
        rect(width: 8pt, height: 60%, fill: palette.accent),
      )

      // Title block — centered
      align(
        center + horizon,
        block(width: 70%, {
          if title != none {
            text(
              size: type-scale.display,
              weight: "bold",
              fill: white,
              font: fonts.sans,
              title,
            )
          }

          if subtitle != none {
            v(space.lg)
            text(size: type-scale.h3, fill: white.darken(10%), font: fonts.sans, subtitle)
          }

          if author != none {
            v(space.xxl)
            text(size: type-scale.lead, fill: palette.accent-light, font: fonts.sans, author)
          }

          if edition != none {
            v(space.md)
            text(size: type-scale.small, fill: white.darken(20%), font: fonts.sans, edition)
          }
        }),
      )
    },
  )
}

// ── Chapter opener ─────────────────────────────────────────────
// Decorative chapter start with number, title, optional lead paragraph.
// CRITICAL: This component CREATES the heading. Do NOT add = Title separately!
#let chapter-opener(
  title: none,
  lead: none,
  number: auto,
) = {
  pagebreak(weak: true)

  // Gradient accent bar at top
  block(
    width: 100%,
    height: 6pt,
    fill: gradients.chapter,
    above: 0pt,
    below: space.xxl,
  )

  // Large decorative chapter number
  context {
    let chapter-number = if number == auto {
      counter(heading).get().first() + 1
    } else {
      number
    }

    text(
      size: 60pt,
      weight: "bold",
      fill: palette.primary.lighten(70%),
      font: fonts.sans,
      str(chapter-number),
    )
  }

  v(space.md)

  // This IS the heading — chapters must NOT duplicate it
  heading(level: 1, title)

  if lead != none {
    v(space.md)
    block(
      width: 85%,
      text(size: type-scale.lead, fill: palette.text-muted, style: "italic", lead),
    )
  }

  v(space.xxl)
}

// ── Section break ──────────────────────────────────────────────
// Visual separator between major sections within a chapter.
#let section-break() = {
  v(space.xl)
  align(
    center,
    block(width: 40%, {
      line(length: 100%, stroke: 0.5pt + palette.border)
      v(space.xs)
      align(center, text(fill: palette.text-light, size: type-scale.small)[#sym.diamond.filled])
      v(space.xs)
      line(length: 100%, stroke: 0.5pt + palette.border)
    }),
  )
  v(space.xl)
}

// ── Spread start ───────────────────────────────────────────────
// Ensure the following content begins on a verso (even/left) page so a
// two-page feature occupies a true facing spread.
#let spread-start() = pagebreak(to: "even", weak: true)

// ── Feature spread (two facing pages) ──────────────────────────
// Designed left/right pages forming one visual unit. Guarantees a verso
// (even) start so both pages truly face each other in the opened book.
// If the flush lands on a recto, that page is filled with a deliberate
// divider instead of being left blank.
#let feature-spread(
  left-page,
  right-page,
  title: none,
) = {
  pagebreak(weak: true)

  context {
    if calc.odd(here().page()) {
      align(
        center + horizon,
        block(width: 55%, {
          line(length: 100%, stroke: 0.5pt + palette.border)
          v(space.sm)
          text(size: type-scale.small, fill: palette.text-muted, font: fonts.sans, tracking: 2pt)[DOPPELSEITE]
          if title != none {
            v(space.xs)
            text(size: type-scale.lead, fill: palette.primary, weight: "bold", font: fonts.sans, title)
          }
          v(space.sm)
          text(size: type-scale.small, fill: palette.text-light, style: "italic")[
            Bitte aufschlagen — linke und rechte Seite bilden eine Einheit.
          ]
          v(space.sm)
          line(length: 100%, stroke: 0.5pt + palette.border)
        }),
      )
      pagebreak()
    }
  }

  if title != none {
    block(
      width: 100%,
      fill: gradients.chapter,
      inset: (x: space.lg, y: space.md),
      radius: 4pt,
      below: space.lg,
      text(size: type-scale.h3, weight: "bold", fill: white, font: fonts.sans, title),
    )
  }
  left-page

  pagebreak()
  right-page
}

// ── Part page ──────────────────────────────────────────────────
// Full-page divider for book parts.
#let part-page(
  number: none,
  title: none,
) = {
  pagebreak(weak: true)

  // Marker so the running header can suppress itself on this page
  // (queried in styles/page.typ).
  [#metadata(none)<part-page>]

  align(
    center + horizon,
    block(width: 70%, {
      if number != none {
        text(
          size: type-scale.small,
          fill: palette.text-muted,
          font: fonts.sans,
          weight: "bold",
          tracking: 3pt,
          upper(number),
        )
        v(space.lg)
      }

      line(length: 60%, stroke: 2pt + palette.primary)
      v(space.lg)

      text(
        size: type-scale.h1,
        fill: palette.primary,
        font: fonts.sans,
        weight: "bold",
        title,
      )

      v(space.lg)
      line(length: 60%, stroke: 2pt + palette.primary)
    }),
  )

  pagebreak()
}
