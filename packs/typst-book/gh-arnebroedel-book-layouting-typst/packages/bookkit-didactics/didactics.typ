// components/didactics.typ — Medical-didactic content boxes
//
// Reusable pedagogical building blocks for a medical textbook: learning
// objectives, summaries, key points, clinical cases, pearls, cautions,
// definitions, excursus, mnemonics and differential-diagnosis boxes.
// Labels/colors are data-driven from theme.typ (`didactics`).

#import "/packages/bookkit/theme.typ": didactics, fonts, palette, space, type-scale

// ── Header label chip ──────────────────────────────────────────
// Small solid rounded label used as the box's category marker.
#let _label-chip(color, label) = box(
  fill: color,
  inset: (x: 6pt, y: 2pt),
  radius: 3pt,
  text(fill: white, weight: "bold", size: type-scale.tiny, font: fonts.sans, tracking: 0.5pt, upper(label)),
)

// ── Generic didactic box ───────────────────────────────────────
// Tinted block with left accent bar and a labeled header chip.
// `kind` selects label+color from theme `didactics`.
#let didactic-box(
  kind,
  body,
  title: none,
  breakable: true,
) = {
  let meta = didactics.at(kind)
  let color = meta.color

  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: color.lighten(92%),
    stroke: (left: 3pt + color),
    radius: (right: 4pt),
    breakable: breakable,
    above: space.lg,
    below: space.lg,
    {
      _label-chip(color, meta.label)
      if title != none {
        h(space.sm)
        text(weight: "bold", font: fonts.sans, fill: color.darken(20%), title)
      }
      v(space.sm)
      body
    },
  )
}

// ── Lernziele ──────────────────────────────────────────────────
// Learning objectives at the start of a chapter/section. Pass either
// a list/body, or `items:` for an auto-rendered checklist.
#let learning-objectives(body: none, title: none, items: ()) = didactic-box(
  "objectives",
  title: title,
  {
    if items.len() > 0 {
      for it in items {
        grid(
          columns: (auto, 1fr),
          column-gutter: space.sm,
          text(fill: palette.primary, weight: "bold")[#sym.checkmark],
          it,
        )
      }
    }
    if body != none { body }
  },
)

// ── Zusammenfassung / „In Kürze" ───────────────────────────────
#let summary-box(body, title: none) = didactic-box("summary", body, title: title)

// ── Merksatz / Merke ───────────────────────────────────────────
#let memo(body, title: none) = didactic-box("memo", body, title: title, breakable: false)

// ── Praxistipp / Clinical Pearl ────────────────────────────────
#let clinical-pearl(body, title: none) = didactic-box("pearl", body, title: title)

// ── Cave / Red Flag ────────────────────────────────────────────
// Visually distinct from a generic danger callout: filled label chip
// and a heavier accent reserved for contraindications / warnings.
#let cave(body, title: none) = didactic-box("cave", body, title: title, breakable: false)

// ── Definition ─────────────────────────────────────────────────
// Formal term definition. `term` becomes the bold heading.
#let definition(body, term: none) = didactic-box("definition", body, title: term)

// ── Exkurs / Vertiefung ────────────────────────────────────────
#let excursus(body, title: none) = didactic-box("excursus", body, title: title)

// ── Mnemonic / Eselsbrücke ─────────────────────────────────────
// `phrase` is rendered large and playful above the explanation body.
#let mnemonic(body, phrase: none, title: none) = didactic-box(
  "mnemonic",
  title: title,
  {
    if phrase != none {
      block(
        below: space.sm,
        text(size: type-scale.h4, style: "italic", fill: palette.accent-dark, weight: "bold", phrase),
      )
    }
    body
  },
)

// ── Differenzialdiagnose-Box ───────────────────────────────────
#let ddx-box(body, title: none) = didactic-box("ddx", body, title: title)

// ── Klinischer Fall ────────────────────────────────────────────
// Structured clinical case with optional labeled fields. Any of the
// fields may be omitted; an extra free `body` is appended.
#let clinical-case(
  body: none,
  title: none,
  anamnese: none,
  befund: none,
  diagnose: none,
  therapie: none,
) = {
  let meta = didactics.at("case")
  let color = meta.color

  let field(name, value) = if value != none {
    grid(
      columns: (auto, 1fr),
      column-gutter: space.sm,
      row-gutter: space.xs,
      text(weight: "bold", font: fonts.sans, fill: color.darken(15%), name),
      value,
    )
    v(space.xs)
  }

  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: color.lighten(94%),
    stroke: (left: 3pt + color),
    radius: (right: 4pt),
    breakable: true,
    above: space.lg,
    below: space.lg,
    {
      _label-chip(color, meta.label)
      if title != none {
        h(space.sm)
        text(weight: "bold", font: fonts.sans, fill: color.darken(20%), title)
      }
      v(space.sm)
      field("Anamnese", anamnese)
      field("Befund", befund)
      field("Diagnose", diagnose)
      field("Therapie", therapie)
      if body != none { body }
    },
  )
}
