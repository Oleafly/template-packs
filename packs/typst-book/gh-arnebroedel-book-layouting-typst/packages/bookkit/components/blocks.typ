// components/blocks.typ — Block-level components

#import "../theme.typ": fonts, gradients, palette, space, type-scale

// ── Callout ────────────────────────────────────────────────────
// Semantic admonition with left accent bar and toned background.
// tone: "info" | "success" | "warning" | "danger"
#let callout(
  body,
  title: none,
  tone: "info",
  icon: none,
) = {
  let tone-color = if tone == "info" { palette.info } else if tone == "success" { palette.success } else if (
    tone == "warning"
  ) { palette.warning } else { palette.danger }

  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: tone-color.lighten(90%),
    stroke: (left: 3pt + tone-color),
    radius: (right: 4pt),
    breakable: false,
    above: space.lg,
    below: space.lg,
    {
      if title != none {
        set text(weight: "bold", fill: tone-color.darken(20%), font: fonts.sans)
        if icon != none {
          icon
          h(space.xs)
        }
        title
        v(space.xs)
      }
      body
    },
  )
}

// ── Card ───────────────────────────────────────────────────────
// Elevated content card with optional header accent stripe.
#let card(
  body,
  title: none,
  accent: palette.primary,
  width: 100%,
) = {
  block(
    width: width,
    fill: white,
    stroke: (top: 3pt + accent, rest: 0.5pt + palette.border-light),
    radius: 4pt,
    breakable: false,
    above: space.lg,
    below: space.lg,
    {
      if title != none {
        block(
          width: 100%,
          inset: space.md,
          below: 0pt,
          {
            set text(font: fonts.sans, weight: "bold", fill: accent.darken(10%))
            title
          },
        )
        line(length: 100%, stroke: 0.5pt + palette.border-light)
      }
      block(inset: space.md, width: 100%, body)
    },
  )
}

// ── Blockquote ─────────────────────────────────────────────────
// Styled quotation with left border and optional attribution.
#let blockquote(
  body,
  attribution: none,
) = {
  block(
    width: 100%,
    inset: (left: space.lg + 3pt, rest: space.md),
    stroke: (left: 2pt + palette.primary-light),
    breakable: false,
    above: space.lg,
    below: space.lg,
    {
      set text(style: "italic", fill: palette.text-muted)
      body
      if attribution != none {
        v(space.sm)
        align(right, text(size: type-scale.small, style: "normal")[— #attribution])
      }
    },
  )
}

// ── Pull-quote ─────────────────────────────────────────────────
// Large editorial quote that breaks visual rhythm.
#let pull-quote(
  body,
  attribution: none,
) = {
  block(
    width: 100%,
    breakable: false,
    above: space.xl,
    below: space.xl,
    inset: (x: space.xl, y: space.md),
    {
      line(length: 40%, stroke: 1.5pt + palette.primary)
      v(space.sm)
      set text(size: type-scale.h3, style: "italic", fill: palette.primary-dark)
      body
      if attribution != none {
        v(space.sm)
        set text(size: type-scale.small, style: "normal", fill: palette.text-muted)
        align(right)[— #attribution]
      }
      v(space.sm)
      align(right, line(length: 40%, stroke: 1.5pt + palette.primary))
    },
  )
}

// ── Side-note ──────────────────────────────────────────────────
// Smaller annotation block for supplementary information.
#let side-note(
  body,
  title: none,
) = {
  block(
    width: 100%,
    inset: (left: space.lg + 3pt, rest: space.md),
    fill: palette.bg-subtle,
    stroke: (left: 2pt + palette.accent),
    radius: (right: 3pt),
    breakable: false,
    above: space.md,
    below: space.md,
    {
      set text(size: type-scale.small)
      if title != none {
        text(weight: "bold", font: fonts.sans, fill: palette.accent-dark, title)
        v(space.xs)
      }
      body
    },
  )
}

// ── Code-block ─────────────────────────────────────────────────
// Formatted code display with optional title header bar.
#let code-block(
  body,
  title: none,
) = {
  block(
    width: 100%,
    breakable: false,
    above: space.lg,
    below: space.lg,
    stroke: 0.5pt + palette.border-light,
    radius: 4pt,
    clip: true,
    {
      if title != none {
        block(
          width: 100%,
          fill: palette.primary.lighten(85%),
          inset: (x: space.md, y: space.sm),
          {
            set text(font: fonts.sans, size: type-scale.small, fill: palette.primary-dark, weight: "bold")
            title
          },
        )
      }
      block(
        width: 100%,
        fill: palette.bg-subtle,
        inset: space.md,
        {
          set text(font: fonts.mono, size: type-scale.small)
          body
        },
      )
    },
  )
}

// ── Key-concept ────────────────────────────────────────────────
// Highlighted definition or key term box with gradient accent.
#let key-concept(
  body,
  term: none,
) = {
  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: palette.accent.lighten(92%),
    stroke: (left: 3pt + gradient.linear(palette.accent, palette.primary, angle: 90deg)),
    radius: (right: 4pt),
    breakable: false,
    above: space.lg,
    below: space.lg,
    {
      if term != none {
        set text(font: fonts.sans, weight: "bold", fill: palette.accent-dark, size: type-scale.body)
        term
        v(space.xs)
      }
      set text(size: type-scale.small)
      body
    },
  )
}

// ── Protocol-steps ─────────────────────────────────────────────
// Numbered action protocol with visual step weight (catalog form).
// Prefer this over plain enum for SOPs / algorithms under stress scan.
//
// `steps` is an array of either:
//   - content (auto-numbered 1…n), or
//   - dictionary: (label: "4a", body: [...])  — branch / custom step ids
//
// tone: "info" | "success" | "warning" | "danger"
#let protocol-steps(
  steps,
  title: none,
  tone: "info",
) = {
  let tone-color = if tone == "info" { palette.info } else if tone == "success" { palette.success } else if (
    tone == "warning"
  ) { palette.warning } else { palette.danger }

  let rows = ()
  for (i, step) in steps.enumerate() {
    let label = str(i + 1)
    let body = step
    if type(step) == dictionary {
      if "label" in step {
        label = str(step.label)
      }
      body = step.at("body", default: [])
    }
    rows.push((label, body))
  }

  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: tone-color.lighten(92%),
    stroke: (left: 3pt + tone-color),
    radius: (right: 4pt),
    breakable: true,
    above: space.lg,
    below: space.lg,
    {
      if title != none {
        set text(weight: "bold", fill: tone-color.darken(20%), font: fonts.sans)
        title
        v(space.sm)
      }
      for (label, body) in rows {
        grid(
          columns: (auto, 1fr),
          column-gutter: space.sm,
          row-gutter: space.sm,
          align: (center + top, top),
          box(
            width: 1.65em,
            height: 1.65em,
            fill: tone-color,
            radius: 3pt,
            align(center + horizon, text(
              fill: white,
              weight: "bold",
              size: type-scale.small,
              font: fonts.sans,
              label,
            )),
          ),
          body,
        )
        v(space.xs)
      }
    },
  )
}
