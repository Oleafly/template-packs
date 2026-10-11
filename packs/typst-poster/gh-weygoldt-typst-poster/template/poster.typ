// =============================================================================
//  A sleek, Apple-inspired scientific poster template for Typst.
//
//  Design system: cool near-black canvas, one confident accent, generous
//  negative space, an Inter type scale, hairline rules, soft rounded panels,
//  and a full-bleed hero. Built to be composed, not filled in — every block
//  below is a reusable component.
//
//  Usage (see ../main.typ for a worked example):
//
//    #import "template/poster.typ": *
//    #show: poster.with(
//      title: [ ... ],
//      authors: ((name: "Ada Lovelace", affil: (1,), corresponding: true),),
//      affiliations: ("Analytical Engine Institute",),
//      hero: image("figures/hero.png"),
//    )
//    = ... your content, using #section, #stat-row, #figure-card, #hl, ...
//
//  Everything is A0 portrait by default; change `paper` / `flipped` to retarget.
// =============================================================================

// -----------------------------------------------------------------------------
//  THEME — color roles. Dark by default; pass your own dict to `poster(theme:)`
//  or just override the accent with `poster(accent:)`.
// -----------------------------------------------------------------------------
#let dark-theme = (
  bg:         rgb("#000000"), // true black canvas (print-black, blends with maps)
  surface:    rgb("#0e0e13"), // panels / cards (matches dark-figure backgrounds)
  surface-2:  rgb("#17171d"), // insets, stat block
  border:     rgb("#2c2c35"), // hairlines (just visible on black)
  ink:        rgb("#f3f0e9"), // titles / headings (warm white)
  body:       rgb("#c9c6d1"), // running text
  muted:      rgb("#918e9c"), // captions, secondary
  faint:      rgb("#868391"), // affiliations, footer (>=4.5:1 on bg)
  accent:     rgb("#f2683c"), // coral-orange — the one loud color
  accent-2:   rgb("#5aa2ff"), // cool blue — used sparingly
  // "paper" figure tiles: a light mat so light-background figures read as
  // intentional white cards on the dark canvas (see figure-card `paper:`).
  paper:       rgb("#f6f5f1"),
  paper-ink:   rgb("#1b1a17"),
  paper-muted: rgb("#5c584f"),
)

#let light-theme = (
  bg:         rgb("#faf9f5"),
  surface:    rgb("#ffffff"),
  surface-2:  rgb("#f1efe8"),
  border:     rgb("#e3e0d6"),
  ink:        rgb("#1c1b19"),
  body:       rgb("#3b3a38"),
  muted:      rgb("#6f6c65"),
  faint:      rgb("#8a877e"),
  accent:     rgb("#e05a2b"),
  accent-2:   rgb("#2f6fd8"),
  paper:       rgb("#ffffff"),
  paper-ink:   rgb("#1c1b19"),
  paper-muted: rgb("#6f6c65"),
)

// Live theme + section counter, so components can read colors at render time.
#let __theme = state("__poster_theme", dark-theme)
#let __sec = counter("__poster_section")

// Read the active palette inside a `context`.
#let palette = () => __theme.get()

// -----------------------------------------------------------------------------
//  TYPE SCALE — tuned for A0 portrait, read from ~1–2 m.
// -----------------------------------------------------------------------------
#let scale = (
  title:       88pt,
  subtitle:    34pt,
  authors:     28pt,
  affil:       20pt,
  section:     47pt,
  secnum:      27pt,
  h3:          29pt,
  body:        27pt,
  small:       20pt,
  stat:        48pt,
  stat-label:  19pt,
  caption:     22.5pt,
  take-title:  26pt,
  take-body:   23.5pt,
  footer:      20pt,
)

#let fonts = (
  display: "Inter Display",
  text:    "Inter",
  mono:    "JetBrainsMono NF",
)

// -----------------------------------------------------------------------------
//  INLINE HELPERS
// -----------------------------------------------------------------------------

// Highlight a key phrase in the accent color.
#let hl(body) = context text(fill: palette().accent, weight: "medium")[#body]

// Highlight in the secondary (cool) accent.
#let hl2(body) = context text(fill: palette().accent-2, weight: "medium")[#body]

// Small-caps tracked label (used for eyebrow labels / stat captions).
#let eyebrow(body) = context text(
  fill: palette().muted, size: scale.stat-label, weight: "semibold",
  tracking: 0.14em,
)[#upper(body)]

// -----------------------------------------------------------------------------
//  SECTION HEADER — numbered badge + title + hairline rule.
//  Auto-numbers (01, 02, …); pass `number:` to override, or `number: none`.
// -----------------------------------------------------------------------------
#let section(title, number: auto) = context {
  let t = palette()
  if number == auto {
    __sec.step()
  }
  let n = if number == auto {
    let v = __sec.get().first() + 1
    if v < 10 { "0" + str(v) } else { str(v) }
  } else if number == none { none } else { number }

  // Rule sits ABOVE the header: a big beat then the rule separate this section
  // from the previous one, and a tight gap below groups the header with its
  // own content.
  block(width: 100%, above: 1.15em, below: 0.7em, {
    line(length: 100%, stroke: 1.4pt + t.border)
    v(0.42em)
    grid(
      columns: (auto, 1fr),
      align: (left + horizon, left + horizon),
      column-gutter: 0.6em,
      if n != none {
        text(fill: t.accent, size: scale.secnum, weight: "bold", font: (fonts.mono, fonts.text))[#n]
      } else { [] },
      text(fill: t.ink, size: scale.section, weight: 800, font: (fonts.display, fonts.text))[#title],
    )
  })
}

// A lighter sub-heading inside a column / card.
#let subhead(title) = context text(
  fill: palette().ink, size: scale.h3, weight: 700, font: (fonts.display, fonts.text),
)[#title]

// -----------------------------------------------------------------------------
//  PANELS
// -----------------------------------------------------------------------------

// A soft rounded panel. Everything sits on these.
#let card(body, fill: auto, inset: 34pt, radius: 22pt, stroke: auto) = context {
  let t = palette()
  block(
    width: 100%,
    fill: if fill == auto { t.surface } else { fill },
    inset: inset,
    radius: radius,
    stroke: if stroke == auto { 1pt + t.border } else { stroke },
    body,
  )
}

// Tracks whether the caption currently rendering sits on a light "paper" tile,
// so `cap` can pick dark-on-light colors automatically.
#let __on-paper = state("__poster_on_paper", false)

// A figure inside a panel, with an optional bold-lead caption underneath.
// The image always fills the card's width; its height follows the aspect
// ratio, so control a figure's size by the width of the grid column you
// place it in. `pad` insets the image from the card edge (0 = edge-to-edge).
// `caption` content: use #cap[Bold lead.][the muted remainder.]
//
// `paper: true` renders the figure on a light "paper" tile with a matching
// dark caption — use it for figures with a light/white background so they read
// as intentional white cards on the dark canvas rather than clashing with it.
// `cap-above: true` places the caption ABOVE the image (message-first: the bold
// lead reads as a headline the viewer sees before the plot — good for a scanned
// poster). `cap-height` reserves a uniform caption height so plots still align
// across a grid row despite unequal caption lengths (bare variant only).
#let figure-card(
  img,
  caption: none,
  boxed: false,
  paper: false,
  fill: auto,
  inset: 14pt,
  radius: 18pt,
  pad: auto,
  cap-above: false,
  cap-height: auto,
) = context {
  let t = palette()
  let is-card = boxed or paper or (fill != auto)
  let caption-block = {
    if caption != none {
      v(if is-card { 9pt } else { 12pt })
      set par(leading: 0.5em)
      __on-paper.update(paper)
      caption
      __on-paper.update(false)
    }
  }
  if not is-card {
    // BARE (default): the figure sits directly on the canvas — caption below,
    // or above when `cap-above`. Best for dark-background figures on a dark poster.
    block(width: 100%, breakable: false, {
      if cap-above and caption != none {
        // Anchor the caption to the BOTTOM of its reserved block so the heading
        // sits tight to its own plot; the reserved slack becomes separation
        // ABOVE (a clear gap from the previous row's plot).
        block(width: 100%, height: cap-height, {
          v(1fr)
          set par(leading: 0.5em)
          __on-paper.update(paper)
          caption
          __on-paper.update(false)
        })
        v(5pt)
      }
      block(width: 100%, { set image(width: 100%); img })
      if not cap-above { caption-block }
    })
  } else {
    // Boxed / paper tile.
    let card-fill = if fill != auto { fill } else if paper { t.paper } else { t.surface }
    let img-pad = if pad != auto { pad } else if paper { 15pt } else { 0pt }
    block(
      width: 100%, fill: card-fill, inset: inset, radius: radius,
      stroke: if paper { none } else { 1pt + t.border }, breakable: false,
      {
        block(width: 100%, radius: 10pt, clip: true, inset: img-pad, fill: none, {
          set image(width: 100%); img
        })
        caption-block
      },
    )
  }
}

// Bold-lead caption helper: #cap[Lead phrase][the rest of the sentence.]
// Auto-adapts to a paper figure-card (dark-on-light) via the __on-paper state.
#let cap(lead, rest) = context {
  let t = palette()
  let on-paper = __on-paper.get()
  let lead-col = if on-paper { t.paper-ink } else { t.ink }
  let rest-col = if on-paper { t.paper-muted } else { t.muted }
  set text(size: scale.caption)
  text(fill: lead-col, weight: 600)[#lead] + [ ] + text(fill: rest-col)[#rest]
}

// A key point with an accent-bold lead term (Methods-style list item).
#let keypoint(lead, body) = context {
  let t = palette()
  block(below: 1.4em, {
    text(fill: t.ink, weight: 700)[#lead]
    h(0.4em)
    text(fill: t.body)[#body]
  })
}

// A themed accent lead-in / dek (e.g. the one-line hook under a section head).
#let dek(body) = context text(
  fill: palette().accent, weight: "semibold", size: scale.h3,
)[#body]

// A promoted "pull stat": eyebrow label, one big accent number, a short line.
// Themed (reads the live palette), vertically centered for balanced rows.
#let pull-stat(label, value, body, fill: auto) = context {
  let t = palette()
  block(
    width: 100%,
    fill: if fill == auto { t.surface } else { fill },
    inset: 30pt, radius: 20pt, stroke: 1pt + t.border,
    stack(
      spacing: 12pt,
      eyebrow(label),
      text(fill: t.accent, size: 66pt, weight: 800, font: (fonts.display, fonts.text))[#value],
      text(fill: t.body)[#body],
    ),
  )
}

// -----------------------------------------------------------------------------
//  STAT ROW — Apple-keynote "at a glance" numbers on one inset panel.
//  #stat-row((value: "~70", label: "rec. days"), (value: "16", label: "sites"))
// -----------------------------------------------------------------------------
// `cols` sets how many stats sit per row (default: all on one row). Use
// `cols: 2` for a compact 2×2 block that fits in a one-third column.
#let stat-row(
  ..items, label: none, fill: auto, cols: auto,
  value-size: auto, inset: 24pt, row-gutter: 22pt, label-side: false,
) = context {
  let t = palette()
  let cells = items.pos()
  let ncol = if cols == auto { cells.len() } else { cols }
  let vsize = if value-size == auto { scale.stat } else { value-size }
  let stats = grid(
    columns: (1fr,) * ncol,
    column-gutter: 26pt,
    row-gutter: row-gutter,
    ..cells.map(c => {
      stack(
        spacing: 7pt,
        box(text(fill: t.ink, size: vsize, weight: 800, font: (fonts.display, fonts.text))[#c.value]),
        text(fill: t.muted, size: scale.stat-label, weight: "medium")[#c.label],
      )
    }),
  )
  block(
    width: 100%,
    fill: if fill == auto { t.surface-2 } else { fill },
    inset: inset,
    radius: 18pt,
    stroke: 1pt + t.border,
    if label != none and label-side {
      // descriptor sits in its own left column -> saves vertical space
      grid(
        columns: (auto, 1fr),
        column-gutter: 48pt,
        align: (left + horizon, left + horizon),
        box(width: 104pt, eyebrow(label)),
        stats,
      )
    } else {
      if label != none { eyebrow(label); v(0.55 * inset) }
      stats
    },
  )
}

// -----------------------------------------------------------------------------
//  TAKE-HOME BAND — accent-topped panel with N short conclusions.
//  #take-home(title: "Take-home", (title: "…", body: [ … ]), …)
// -----------------------------------------------------------------------------
#let take-home(..items, title: "Take-home", cols: auto) = context {
  let t = palette()
  let cells = items.pos()
  let ncol = if cols == auto { cells.len() } else { cols }
  block(
    width: 100%,
    fill: t.surface,
    radius: 22pt,
    stroke: 1pt + t.border,
    inset: 0pt,
    {
      block(inset: 30pt, {
        text(fill: t.ink, size: 34pt, weight: 800, font: (fonts.display, fonts.text))[#title]
        v(24pt)
        grid(
          columns: (1fr,) * ncol,
          column-gutter: 40pt,
          row-gutter: 36pt,
          ..cells.map(c => {
            stack(
              spacing: 12pt,
              text(fill: t.accent, size: scale.take-title, weight: 700, font: (fonts.display, fonts.text))[#c.title],
              text(fill: t.body, size: scale.take-body)[#c.body],
            )
          }),
        )
      })
    },
  )
}

// -----------------------------------------------------------------------------
//  LAYOUT HELPERS
// -----------------------------------------------------------------------------

// Equal-width column grid with a sensible default gutter. Pass content per col.
#let cols(..content, gutter: 40pt) = {
  let items = content.pos()
  grid(columns: (1fr,) * items.len(), column-gutter: gutter, row-gutter: gutter, ..items)
}

// Vertical rhythm between poster blocks.
#let gap(h: 34pt) = v(h)

// -----------------------------------------------------------------------------
//  AUTHOR / AFFILIATION RENDERING
// -----------------------------------------------------------------------------
#let __render-authors(authors, affiliations, t) = {
  set text(size: scale.authors, fill: t.ink, weight: "medium")
  let parts = authors.map(a => {
    let name = if a.at("corresponding", default: false) {
      underline(offset: 5pt, stroke: 1pt + t.accent)[#a.name]
    } else { a.name }
    let marks = a.at("affil", default: ())
    // box each author so a multi-word name never breaks across lines
    box(name + super(text(size: 0.74em, fill: t.accent)[#marks.map(str).join(",")]))
  })
  parts.join(text(fill: t.faint)[#"  ·  "])
}

#let __render-affils(affiliations, t) = {
  set text(size: scale.affil, fill: t.faint)
  affiliations.enumerate(start: 1).map(((i, name)) => {
    super(text(size: 0.74em, fill: t.accent)[#str(i)]) + h(3pt) + name
  }).join(text[#"    "])
}

// -----------------------------------------------------------------------------
//  HERO — full-bleed image with a left-dark scrim and the title block overlaid
//  bottom-left. If no hero image is given, falls back to a clean title band.
// -----------------------------------------------------------------------------
#let __hero(
  title, subtitle, authors, affiliations, hero, hero-height, side, t, title-width,
) = {
  let title-stack = {
    box(width: title-width, {
      text(fill: t.ink, size: scale.title, weight: 800, font: (fonts.display, fonts.text))[#title]
      if subtitle != none {
        v(11pt)
        text(fill: t.body, size: scale.subtitle, weight: "regular")[#subtitle]
      }
      v(15pt)
      __render-authors(authors, affiliations, t)
      if affiliations.len() > 0 {
        v(7pt)
        __render-affils(affiliations, t)
      }
    })
  }

  if hero == none {
    // No image: a clean title band on the canvas.
    block(width: 100%, inset: (x: side, top: side, bottom: 24pt), title-stack)
  } else {
    block(width: 100%, height: hero-height, clip: true, {
      // image covers the band
      place(top + left, box(width: 100%, height: hero-height, clip: true, {
        set image(fit: "cover", width: 100%, height: 100%)
        hero
      }))
      // left-dark scrim: concentrated on the left (title legibility) and fully
      // faded out by ~55% so the right side of the image stays vivid
      place(top + left, rect(
        width: 100%, height: hero-height,
        fill: gradient.linear(
          dir: ltr,
          (t.bg, 0%),
          (t.bg, 30%),
          (t.bg.transparentize(100%), 55%),
          (t.bg.transparentize(100%), 100%),
        ),
      ))
      // gentle bottom-up scrim so the author line stays readable
      place(bottom + left, rect(
        width: 100%, height: 52%,
        fill: gradient.linear(
          dir: ttb,
          (t.bg.transparentize(100%), 0%),
          (t.bg.transparentize(48%), 100%),
        ),
      ))
      // Bottom-anchored: the title sits low (matching the reference) and a
      // longer title/author list grows UP into the visible image instead of
      // being clipped off the bottom edge.
      place(bottom + left, dx: side, dy: -26mm, title-stack)
    })
  }
}

// -----------------------------------------------------------------------------
//  FOOTER
// -----------------------------------------------------------------------------
#let __footer(footer-left, footer-right, side, t) = {
  if footer-left == none and footer-right == none { return }
  block(width: 100%, inset: (x: side, y: 20pt), {
    set text(size: scale.footer, fill: t.faint)
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      if footer-left != none { footer-left } else { [] },
      if footer-right != none { footer-right } else { [] },
    )
  })
}

// -----------------------------------------------------------------------------
//  MAIN TEMPLATE
// -----------------------------------------------------------------------------
#let poster(
  title: [Poster title],
  subtitle: none,
  authors: (),
  affiliations: (),
  hero: none,
  hero-height: 335mm,
  title-width: 66%,
  theme: dark-theme,
  accent: none,
  side: 46mm,
  paper: "a0",
  flipped: false,
  footer-left: none,
  footer-right: none,
  body,
) = {
  // resolve theme (+ optional accent override)
  let t = theme
  if accent != none { t.accent = accent }
  __theme.update(t)

  // `typst compile --input measure=1` grows the page to fit content, so the
  // resulting page height reveals exactly how tall the poster is (for one-page
  // tuning). It keeps the target paper's WIDTH (and `flipped`) so the reflow —
  // and thus the reported height — is correct for any paper size, not just A0.
  let measuring = sys.inputs.at("measure", default: "0") == "1"
  set page(
    paper: paper,
    flipped: flipped,
    margin: 0pt,
    fill: t.bg,
    ..(if measuring { (height: auto) } else { (:) }),
  )
  set text(
    font: (fonts.text, "Inter"),
    fill: t.body,
    size: scale.body,
    lang: "en",
    hyphenate: false,
  )
  set par(leading: 0.58em, justify: false, spacing: 0.82em)

  // Headings map to poster sections by default.
  show heading.where(level: 1): it => section(it.body)
  show heading.where(level: 2): it => subhead(it.body)

  // Citations/links recede (muted) so the coral accent stays reserved for
  // semantic #hl highlights — the one loud color that guides the eye.
  show link: it => text(fill: t.muted)[#it]
  show ref: it => text(fill: t.muted)[#it]
  show cite: it => text(fill: t.muted)[#it]

  // Bibliography styled for dark mode.
  show bibliography: it => {
    set text(size: 18pt, fill: t.muted)
    set par(leading: 0.45em, spacing: 0.6em)
    it
  }

  // --- render ---
  __hero(title, subtitle, authors, affiliations, hero, hero-height, side, t, title-width)

  block(width: 100%, inset: (x: side, top: 15pt, bottom: 12pt), {
    body
  })

  __footer(footer-left, footer-right, side, t)
}
