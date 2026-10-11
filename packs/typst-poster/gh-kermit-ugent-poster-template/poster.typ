// ══════════════════════════════════════════════════════════════════════════════
//  A0 CONFERENCE POSTER
//
//  Fork the repo, then edit two regions of this file and nothing else:
//    1. the CONFIG block, immediately below;
//    2. the CONTENT section, at the very bottom.
//  Everything in between is machinery. A diff between two posters should show
//  only config and content.
//
//  Drop your figure exports in  figures/   (dummies are shipped; keep the names
//  or change the paths here).    Institutional logos live in  logos/.
//
//  The header's right-hand slot (`art:`) is for a teaser figure, graphical
//  abstract or portrait. Logos belong in the footer, once.
//
//  Compile:  typst compile poster.typ
//  Watch:    typst watch poster.typ poster.pdf
//  Proof:    set `paper: "a4"` for a printable, proportionally identical proof
// ══════════════════════════════════════════════════════════════════════════════

// ─── CONFIG ───────────────────────────────────────────────────────────────────
#let cfg = (
  // ── content ────────────────────────────────────────────────────────────────
  title: "The poster title, which wraps to two lines",
  subtitle: "A subtitle, or a one-line tagline that says what you actually found",

  // presenter first; `presenter: true` bolds the name.
  // `affil` indexes into `affiliations` below (1-based). Markers are omitted
  // automatically when there is only one affiliation.
  authors: (
    (name: "Presenting Author", affil: (1,), presenter: true),
    (name: "Second Author", affil: (1, 2)),
    (name: "Senior Author", affil: (1,)),
  ),
  affiliations: (
    "KERMIT, Dept. of Data Analysis and Mathematical Modelling, Ghent University",
    "Some Other Institute, Some Other City",
  ),

  // affiliations cost ~12 mm of header each; true moves them to the footer
  affiliations-in-footer: false,
  bib: none,          // path to a .bib file, for `bibrefs()`

  // Right-hand slot of the header: a teaser figure, a graphical abstract, or a
  // portrait of the presenter. A path, `(src:, scale:)`, or content. `none` lets
  // the title run the full width. Logos do NOT go here — they are in the footer.
  art: "figures/header-art.svg",
  // The only logo slot, bottom-left. `logos/kermit-cold.svg` is the quieter mark
  // and `logos/ugent-white.png` the knockout, for a dark `brand`.
  footer-logos: (
    "logos/kermit-warm.svg",
    (src: "logos/ugent.png", scale: 1.2),
  ),
  qr: "figures/qr.png",   // a QR *image*; there is no in-Typst QR generation
  qr-caption: "github.com/your/repo",
  // one-line acknowledgement, sits in the footer
  funding: "Funded by <agency> under grant <number>.",

  // ── layout ─────────────────────────────────────────────────────────────────
  paper: "a0",            // "a0" | "a1" | "a2" | "a3" | "a4" | "us-36x48"
  columns: 3,             // default column count for `band()`
  scale-factor: 1.0,      // density knob; type stops at the legibility floor
  legibility-floor: 24pt, // smallest type on the poster; 0pt to opt out
  draft: false,           // grid overlay + DRAFT marker (see README §draft)
  placeholder-figs: false, // force every fig() to render as a placeholder box
  // section-heading treatment: "none" | "bar" | "tick" | "text" | "full"
  heading-mark: "none",
  heading-mark-role: "support", // which role colours the mark, if any
  frame-role: "accent",   // which role strokes frame: "box" / "rule"
  keymessage-bleed: false, // full-bleed key-message bands instead of margin-respecting

  // ── style ──────────────────────────────────────────────────────────────────
  flavour: "frappe",      // "latte" | "frappe" | "macchiato" | "mocha"
  // Override any role with either a colour value or a hue name from the flavour:
  //   roles: (accent: rgb("#c04a3f"), support: "mauve")
  roles: (:),
  fonts: (
    sans: ("Helvetica Neue", "Helvetica", "Inter", "Libertinus Sans"),
    mono: ("JetBrains Mono", "Fira Code", "DejaVu Sans Mono"),
    hand: ("Excalifont", "Comic Neue"),
  ),
)
// ─── END CONFIG ───────────────────────────────────────────────────────────────



// ══════════════════════════════════════════════════════════════════════════════
//  1. COLOUR — Catppuccin flavours, then a role map. Component code below uses
//     role names only, never hue names.
// ══════════════════════════════════════════════════════════════════════════════

#let catppuccin = (
  latte: (
    rosewater: rgb("#dc8a78"), flamingo: rgb("#dd7878"), pink: rgb("#ea76cb"),
    mauve: rgb("#8839ef"), red: rgb("#d20f39"), maroon: rgb("#e64553"),
    peach: rgb("#fe640b"), yellow: rgb("#df8e1d"), green: rgb("#40a02b"),
    teal: rgb("#179299"), sky: rgb("#04a5e5"), sapphire: rgb("#209fb5"),
    blue: rgb("#1e66f5"), lavender: rgb("#7287fd"),
    text: rgb("#4c4f69"), subtext1: rgb("#5c5f77"), subtext0: rgb("#6c6f85"),
    overlay2: rgb("#7c7f93"), overlay1: rgb("#8c8fa1"), overlay0: rgb("#9ca0b0"),
    surface2: rgb("#acb0be"), surface1: rgb("#bcc0cc"), surface0: rgb("#ccd0da"),
    base: rgb("#eff1f5"), mantle: rgb("#e6e9ef"), crust: rgb("#dce0e8"),
  ),
  frappe: (
    rosewater: rgb("#f2d5cf"), flamingo: rgb("#eebebe"), pink: rgb("#f4b8e4"),
    mauve: rgb("#ca9ee6"), red: rgb("#e78284"), maroon: rgb("#ea999c"),
    peach: rgb("#ef9f76"), yellow: rgb("#e5c890"), green: rgb("#a6d189"),
    teal: rgb("#81c8be"), sky: rgb("#99d1db"), sapphire: rgb("#85c1dc"),
    blue: rgb("#8caaee"), lavender: rgb("#babbf1"),
    text: rgb("#c6d0f5"), subtext1: rgb("#b5bfe2"), subtext0: rgb("#a5adce"),
    overlay2: rgb("#949cbb"), overlay1: rgb("#838ba7"), overlay0: rgb("#737994"),
    surface2: rgb("#626880"), surface1: rgb("#51576d"), surface0: rgb("#414559"),
    base: rgb("#303446"), mantle: rgb("#292c3c"), crust: rgb("#232634"),
  ),
  macchiato: (
    rosewater: rgb("#f4dbd6"), flamingo: rgb("#f0c6c6"), pink: rgb("#f5bde6"),
    mauve: rgb("#c6a0f6"), red: rgb("#ed8796"), maroon: rgb("#ee99a0"),
    peach: rgb("#f5a97f"), yellow: rgb("#eed49f"), green: rgb("#a6da95"),
    teal: rgb("#8bd5ca"), sky: rgb("#91d7e3"), sapphire: rgb("#7dc4e4"),
    blue: rgb("#8aadf4"), lavender: rgb("#b7bdf8"),
    text: rgb("#cad3f5"), subtext1: rgb("#b8c0e0"), subtext0: rgb("#a5adcb"),
    overlay2: rgb("#939ab7"), overlay1: rgb("#8087a2"), overlay0: rgb("#6e738d"),
    surface2: rgb("#5b6078"), surface1: rgb("#494d64"), surface0: rgb("#363a4f"),
    base: rgb("#24273a"), mantle: rgb("#1e2030"), crust: rgb("#181926"),
  ),
  mocha: (
    rosewater: rgb("#f5e0dc"), flamingo: rgb("#f2cdcd"), pink: rgb("#f5c2e7"),
    mauve: rgb("#cba6f7"), red: rgb("#f38ba8"), maroon: rgb("#eba0ac"),
    peach: rgb("#fab387"), yellow: rgb("#f9e2af"), green: rgb("#a6e3a1"),
    teal: rgb("#94e2d5"), sky: rgb("#89dceb"), sapphire: rgb("#74c7ec"),
    blue: rgb("#89b4fa"), lavender: rgb("#b4befe"),
    text: rgb("#cdd6f4"), subtext1: rgb("#bac2de"), subtext0: rgb("#a6adc8"),
    overlay2: rgb("#9399b2"), overlay1: rgb("#7f849c"), overlay0: rgb("#6c7086"),
    surface2: rgb("#585b70"), surface1: rgb("#45475a"), surface0: rgb("#313244"),
    base: rgb("#1e1e2e"), mantle: rgb("#181825"), crust: rgb("#11111b"),
  ),
)

#let flav = catppuccin.at(cfg.flavour)

// Default role map. `bg`, `ink`, `muted` and `panel` are deliberately not
// Catppuccin values: the poster is dark ink on warm paper regardless of flavour.
#let default-roles = (
  bg: rgb("#f7f5f0"),      // page background — warm off-white
  ink: rgb("#1e1e1e"),     // all body and heading text
  muted: rgb("#6c6f85"),   // captions, affiliations, references, funding
  brand: flav.lavender,    // header band, footer band
  accent: flav.red,        // key-message band, frame strokes
  support: flav.blue,      // second accent
  note: flav.yellow,       // note box, callout fill
  panel: rgb("#ffffff"),   // fill for boxed blocks
)

// Resolve overrides. A string is looked up as a hue name in the active flavour;
// anything else is used as a colour directly.
#let rc = {
  let out = default-roles
  for (role, value) in cfg.roles {
    out.insert(role, if type(value) == str { flav.at(value) } else { value })
  }
  out
}

// ── luminance, for the draft-mode palette check ─────────────────────────────
// Two things can go wrong with a palette and only one of them is about hue.
//   1. A fill that ink cannot sit on. Checked as a WCAG contrast ratio; 4.5:1 is
//      the floor for the caption-size text that appears on `note` fills.
//   2. Two large colour areas at the same lightness. The header band and the
//      key-message fill are the two biggest, and if they match in luminance the
//      page reads flat and collapses entirely in greyscale or under a red-green
//      deficiency. 0.12 is the gap worth holding.
// Role fills that are never in a discrimination task — `note` versus `brand`,
// say, which sit in different structural positions — do not need separating.
// What genuinely does is any *figure* that encodes a category by hue alone; no
// template can check that for you.
#let luminance(c) = {
  let comp = rgb(c).components()
  let lin(x) = {
    let u = x / 100%
    if u <= 0.04045 { u / 12.92 } else { calc.pow((u + 0.055) / 1.055, 2.4) }
  }
  0.2126 * lin(comp.at(0)) + 0.7152 * lin(comp.at(1)) + 0.0722 * lin(comp.at(2))
}

#let contrast(a, b) = {
  let (x, y) = (luminance(a), luminance(b))
  let (hi, lo) = if x > y { (x, y) } else { (y, x) }
  (hi + 0.05) / (lo + 0.05)
}


// ══════════════════════════════════════════════════════════════════════════════
//  2. GEOMETRY AND TYPE SCALE — everything derives from these. No magic numbers
//     in component bodies.
// ══════════════════════════════════════════════════════════════════════════════

#let sf = cfg.scale-factor

// ── paper ──────────────────────────────────────────────────────────────────
// Every length below is written at A0 and multiplied by `pf`, the page width
// relative to A0. So `paper: "a4"` gives a proportionally identical poster that
// compiles in a fraction of the time and can be printed and held — the fast
// proof. A1/A2 are real venue sizes, not just proofs.
#let papers = (
  a0: (841mm, 1189mm),
  a1: (594mm, 841mm),
  a2: (420mm, 594mm),
  a3: (297mm, 420mm),
  a4: (210mm, 297mm),
  "us-36x48": (36in, 48in), // common US venue size; aspect differs from ISO
)
#let (page-w, page-h) = papers.at(cfg.paper)
#let pf = page-w / 841mm

#let sp = (
  margin: 45mm * pf * sf,           // body inset; bands ignore it for their fill
  gutter: 30mm * pf * sf,           // between columns
  block: 24mm * pf * sf,            // minimum vertical gap between blocks
  box-inset: 18mm * pf * sf,        // inset of a frame:"box" block
  box-radius: 8mm * pf * sf,        // corner radius of a frame:"box" block
  key-inset: 30mm * pf * sf,        // inset of a full-width keymessage
  key-inset-narrow: 14mm * pf * sf, // ... when nested in a column
  key-radius: 10mm * pf * sf,
  head-rule-gap: 6mm * pf * sf,     // heading text → mark
  head-body-gap: 14mm * pf * sf,    // heading block → body text
  head-bar-len: 58mm * pf * sf,     // length of the "bar" mark
  head-tick-gap: 7mm * pf * sf,     // gap between a "tick" mark and the heading
  caption-gap: 8mm * pf * sf,       // figure → caption
  band-pad-y: 28mm * pf * sf,       // vertical inset of the header band
  foot-pad-y: 24mm * pf * sf,       // vertical inset of the footer band
  art-h: 130mm * pf * sf,           // max height of the header art slot
  foot-logo-h: 38mm * pf * sf,      // max footer logo height
  qr-size: 56mm * pf * sf,
)

// ── legibility floor ───────────────────────────────────────────────────────
// A0 posters are read from ~1.5 m; anything a reader is expected to read has to
// clear roughly 24 pt. `scale-factor` is a density knob, and letting it drag the
// smallest steps under the floor trades legibility for fit without saying so —
// so type sizes are clamped and only the spacing actually shrinks. Set
// `legibility-floor: 0pt` in the config to opt out.
#let floor-sz = cfg.legibility-floor * pf

#let ts(base) = {
  let scaled = base * pf * sf
  if base * pf >= floor-sz { calc.max(scaled, floor-sz) } else { scaled }
}

#let sz = (
  title: ts(130pt),
  subtitle: ts(58pt),
  authors: ts(36pt),
  affil: ts(28pt),
  section: ts(46pt),
  key: ts(44pt),
  body: ts(30pt),
  caption: ts(24pt),
  chip: ts(24pt),
  small: ts(24pt),   // references, funding — at the floor, never below it
  mono: ts(24pt),    // code; DejaVu Sans Mono's x-height runs slightly larger
)                    // than Helvetica Neue's at the same size, so 24 pt is safe

#let body-w = page-w - 2 * sp.margin
#let col-w(n: cfg.columns) = (body-w - (n - 1) * sp.gutter) / n

// Strokes
#let hairline = 2pt * pf * sf
#let head-rule-w = 4pt * pf * sf
#let head-bar-w = 7pt * pf * sf
#let box-stroke-w = 2pt * pf * sf


// ══════════════════════════════════════════════════════════════════════════════
//  3. OVERLAY LAYER — `free()` records an item; the page foreground draws it.
//     Coordinates are fractions of the *full page*, bleed to bleed.
// ══════════════════════════════════════════════════════════════════════════════

#let overlay-items = state("poster-overlay", ())

#let free(x: 0.5, y: 0.5, width: 0.2, align-to: left + top, body) = {
  overlay-items.update(items => items + ((
    x: x, y: y, width: width, align-to: align-to, body: body,
  ),))
}

#let overlay-layer = context {
  // ── free-placed items ────────────────────────────────────────────────────
  // Page 1 only: a poster is one page, and repeating the overlay on an overflow
  // page would hide the overflow rather than expose it.
  if here().page() == 1 {
    for it in overlay-items.final() {
      place(
        top + left,
        dx: it.x * page-w,
        dy: it.y * page-h,
        box(width: it.width * page-w, align(it.align-to, it.body)),
      )
    }
  }

  // ── draft grid ───────────────────────────────────────────────────────────
  if cfg.draft {
    let tint = rc.support.transparentize(88%)
    let wire = rc.accent.transparentize(70%)

    // column bands and gutters, so #free() can be aimed at a column
    for i in range(cfg.columns) {
      let x0 = sp.margin + i * (col-w() + sp.gutter)
      place(top + left, dx: x0, dy: 0mm, rect(
        width: col-w(), height: page-h, fill: tint, stroke: none,
      ))
    }

    // hairlines every 0.1 in both axes, with fraction labels
    for i in range(1, 10) {
      let f = i / 10
      place(top + left, dx: f * page-w, dy: 0mm,
        line(end: (0mm, page-h), stroke: (paint: wire, thickness: 1pt * pf)))
      place(top + left, dx: 0mm, dy: f * page-h,
        line(end: (page-w, 0mm), stroke: (paint: wire, thickness: 1pt * pf)))
      place(top + left, dx: f * page-w + 2mm, dy: 3mm,
        text(size: 14pt * pf, fill: rc.accent, weight: "bold", "x " + str(f)))
      place(top + left, dx: 3mm, dy: f * page-h + 2mm,
        text(size: 14pt * pf, fill: rc.accent, weight: "bold", "y " + str(f)))
    }

    // margin box
    place(top + left, dx: sp.margin, dy: sp.margin, rect(
      width: body-w, height: page-h - 2 * sp.margin,
      fill: none, stroke: (paint: wire, thickness: 2pt * pf, dash: "dashed"),
    ))

    place(top + right, dx: -sp.margin, dy: sp.margin * 0.4, box(
      fill: rc.accent, inset: 8mm * pf, radius: 3mm * pf,
      text(size: 40pt * pf, weight: "bold", fill: rc.ink, "DRAFT"),
    ))

    // palette check — luminance and ink contrast per role, plus the one pair
    // that has to be separated (see §1)
    let gap = calc.abs(luminance(rc.brand) - luminance(rc.accent))
    place(bottom + left, dx: sp.margin, dy: -sp.margin, box(
      fill: rc.panel, stroke: (paint: rc.muted, thickness: 1pt * pf),
      inset: 6mm * pf, radius: 3mm * pf,
      text(size: 15pt * pf, fill: rc.ink, {
        grid(
          columns: (auto, auto, auto), column-gutter: 5mm * pf, row-gutter: 2mm * pf,
          text(weight: "bold")[role], text(weight: "bold")[lum],
          text(weight: "bold")[ink],
          ..("brand", "accent", "support", "note", "panel", "bg")
            .map(r => (
              raw(r),
              [#calc.round(luminance(rc.at(r)), digits: 2)],
              {
                let c = contrast(rc.ink, rc.at(r))
                text(
                  fill: if c < 4.5 { rgb("#d20f39") } else { rc.ink },
                  [#calc.round(c, digits: 1):1],
                )
              },
            ))
            .flatten()
        )
        v(2mm * pf)
        text(
          fill: if gap < 0.12 { rgb("#d20f39") } else { rc.ink },
          [brand↔accent lum gap #calc.round(gap, digits: 2)
            #if gap < 0.12 [— too flat] else [— ok]],
        )
      }),
    ))
  }

  // ── overflow alarm ───────────────────────────────────────────────────────
  // A poster is one page. Silently spilling onto a second is the failure mode
  // that survives a quick glance, so make it impossible to miss. Always on.
  if here().page() > 1 {
    place(top + left, dx: 0mm, dy: 0mm, rect(
      width: page-w, height: page-h, fill: rgb(255, 255, 255, 160), stroke: none,
    ))
    place(top + center, dy: page-h * 0.4, box(
      width: page-w * 0.8, fill: rgb("#d20f39"), inset: 30mm * pf, radius: 10mm * pf,
      align(center, text(size: 70pt * pf, weight: "bold", fill: white, {
        [OVERFLOW]
        linebreak()
        text(size: 40pt * pf, weight: "regular", [
          This poster no longer fits on one page. Cut content, lower
          `scale-factor`, or widen a figure’s aspect ratio.
        ])
      })),
    ))
  }
}


// ══════════════════════════════════════════════════════════════════════════════
//  4. BANDS — the page flow is a vertical stack of these.
// ══════════════════════════════════════════════════════════════════════════════

// Typst's `columns()` only balances inside a container of *known* height, and a
// band's height is by definition unknown until its content is laid out. So the
// band measures each of its block-level children and packs them into n columns
// itself. This keeps unbreakable blocks (figures, boxed panels) intact and is
// deterministic: nothing is ever pushed off the region.

// Classification is deliberately inverted: a child counts as inline only if it
// is one of these known inline element functions, and *everything else* is a
// block-level packing unit. Listing the block-level types instead would silently
// merge two adjacent custom components — anything returning a bare `context` or
// `styled` element, which is what a component that needs `measure` or a state
// lookup returns — into a single unit the packer can only place whole. Comparing
// element functions by identity also avoids depending on `repr()`, which is a
// debug representation with no stability guarantee across Typst versions.
#let inline-funcs = (
  text, strong, emph, sub, super, h, linebreak, smartquote,
  box, link, cite, footnote, underline, strike, highlight,
)

// `raw` and `equation` exist in both flavours; ask the element which it is.
#let is-inline(c) = {
  let f = c.func()
  if f == raw or f == math.equation {
    not c.at("block", default: false)
  } else {
    f in inline-funcs
  }
}

// Whitespace between blocks. `parbreak` is a public element function; `space`
// has no public constructor, so it is matched by name — the one place a repr
// comparison is unavoidable.
#let is-gap(c) = c.func() == parbreak or repr(c.func()) == "space"

// Split a band body into the units that get packed. Runs of inline content
// between blocks are merged into one unit rather than shattered.
#let band-items(body) = {
  let fields = body.fields()
  let kids = if "children" in fields { fields.children } else { (body,) }
  let items = ()
  let group = ()
  for c in kids {
    if is-gap(c) {
      if group.len() > 0 { group.push(c) }
    } else if is-inline(c) {
      group.push(c)
    } else {
      if group.len() > 0 { items.push(group.join()); group = () }
      items.push(c)
    }
  }
  if group.len() > 0 { items.push(group.join()) }
  items
}

// Cut an ordered list of heights into consecutive groups, none taller than
// `cap`, advancing early when the items left are only just enough to give every
// remaining column something.
#let cut-at(hs, n, cap) = {
  let groups = ()
  let cur = ()
  let acc = 0.0
  for (i, h) in hs.enumerate() {
    let must = cur.len() > 0 and hs.len() - i <= n - groups.len() - 1
    if cur.len() > 0 and (must or acc + h > cap) {
      groups.push(cur)
      cur = ()
      acc = 0.0
    }
    cur.push(i)
    acc += h
  }
  if cur.len() > 0 { groups.push(cur) }
  groups
}

// Pack items into n columns so that the tallest column is as short as possible.
// Bisects on the height cap; `cut-at` is monotone in `cap`, so this converges on
// the optimum rather than the greedy approximation of it.
#let pack-columns(items, n, cw) = {
  let hs = items.map(it => (measure(block(width: cw, it)).height + sp.block).mm())
  let buckets = if hs.len() == 0 {
    ()
  } else {
    let lo = hs.fold(0.0, calc.max)
    let hi = hs.sum(default: 0.0)
    let best = hi // always feasible: one group, or n groups via `must`
    for _ in range(32) {
      let mid = (lo + hi) / 2
      if cut-at(hs, n, mid).len() <= n { hi = mid; best = mid } else { lo = mid }
    }
    cut-at(hs, n, best).map(g => g.map(i => items.at(i)))
  }
  buckets + ((),) * (n - buckets.len())
}

// `cols: 1` gives a full-width band. `bleed: true` lets the fill (and the
// content) run to the page edge instead of stopping at the margin.
#let band(cols: auto, bleed: false, fill: none, body) = {
  let n = if cols == auto { cfg.columns } else { cols }
  let inner = if n <= 1 { body } else {
    layout(size => {
      let cw = (size.width - (n - 1) * sp.gutter) / n
      grid(
        columns: (1fr,) * n,
        column-gutter: sp.gutter,
        align: top,
        ..pack-columns(band-items(body), n, cw).map(b => b.join()),
      )
    })
  }
  block(
    width: 100%,
    fill: fill,
    inset: (x: if bleed { 0mm } else { sp.margin }),
    above: sp.block, below: sp.block,
    breakable: false,
    inner,
  )
}


// ══════════════════════════════════════════════════════════════════════════════
//  5. COMPONENTS
// ══════════════════════════════════════════════════════════════════════════════

// ── section heading ─────────────────────────────────────────────────────────
// `cfg.heading-mark` picks the treatment:
//   "none"  bare bold heading (default) — weight carries the hierarchy
//   "bar"   a short bar above the heading, in `heading-mark-role`
//   "tick"  a short bar to the left of the heading
//   "text"  underline the width of the heading text
//   "full"  underline the width of the column
// Underlines default to `support`, not `accent`: accent is the key message's
// colour, and repeating it on every heading spends it before you get there.
#let sec(title) = {
  let t = text(size: sz.section, weight: "bold", fill: rc.ink, title)
  let mark = rc.at(cfg.heading-mark-role)
  let mode = cfg.heading-mark
  block(above: 0pt, below: sp.head-body-gap, breakable: false, {
    if mode == "none" {
      t
    } else if mode == "bar" {
      stack(dir: ttb, spacing: sp.head-rule-gap,
        line(length: sp.head-bar-len, stroke: (paint: mark, thickness: head-bar-w)),
        t)
    } else if mode == "tick" {
      // the bar is sized from the heading's own height, so it tracks the type
      context {
        let h = measure(t).height
        grid(columns: (head-bar-w, 1fr), column-gutter: sp.head-tick-gap,
          align: horizon + left,
          rect(width: head-bar-w, height: h, fill: mark, stroke: none),
          t)
      }
    } else {
      layout(size => {
        let w = if mode == "full" {
          size.width
        } else {
          calc.min(measure(t).width, size.width)
        }
        stack(dir: ttb, spacing: sp.head-rule-gap,
          box(width: size.width, t),
          line(length: w, stroke: (paint: mark, thickness: head-rule-w)))
      })
    }
  })
}

// ── frame helper, shared by every block-level component ─────────────────────
#let framed(frame: none, body) = {
  let edge = rc.at(cfg.frame-role)
  if frame == "box" {
    block(
      width: 100%, fill: rc.panel, radius: sp.box-radius,
      inset: sp.box-inset, above: sp.block, below: sp.block, breakable: false,
      stroke: (paint: edge, thickness: box-stroke-w),
      body,
    )
  } else if frame == "rule" {
    block(width: 100%, above: sp.block, below: sp.block, breakable: false, {
      line(length: 100%, stroke: (paint: edge, thickness: head-rule-w))
      v(sp.head-rule-gap, weak: false)
      body
    })
  } else {
    block(width: 100%, above: sp.block, below: sp.block, breakable: false, body)
  }
}

// ── panel: the generic content unit ─────────────────────────────────────────
#let panel(title: none, frame: none, body) = framed(frame: frame, {
  if title != none { sec(title) }
  body
})

// ── key message ─────────────────────────────────────────────────────────────
// Adapts to its container so the same call works in three places:
//   * at the top of the document flow (container = full page) it insets itself
//     to the margin, or bleeds if `cfg.keymessage-bleed` is set;
//   * inside a full-width band it fills the content area;
//   * inside a column it shrinks its inset so the measure stays readable.
#let keymessage(body) = block(
  above: sp.block, below: sp.block, width: 100%, breakable: false,
  layout(size => {
    let full-page = size.width >= page-w - 1mm
    let side = if full-page and not cfg.keymessage-bleed { sp.margin } else { 0mm }
    let pad = if size.width - 2 * side > page-w / 2 {
      sp.key-inset
    } else {
      sp.key-inset-narrow
    }
    block(inset: (x: side), width: 100%, block(
      width: 100%, fill: rc.accent, radius: sp.key-radius, inset: pad,
      align(center, text(size: sz.key, weight: "bold", fill: rc.ink, body)),
    ))
  }),
)

// ── figure ──────────────────────────────────────────────────────────────────
// Typst cannot probe the filesystem, so a placeholder is requested explicitly:
// pass `src: none`, or set `placeholder-figs: true` to stub out every figure at
// once (the drafting workflow — lay the poster out before the exports exist).
#let fig(src, caption: none, width: 100%, ratio: 4 / 3, label: none) = {
  let stub = src == none or cfg.placeholder-figs

  let picture = if stub {
    layout(size => {
      let w = size.width
      let h = w / ratio
      let dims = (
        str(calc.round(w.mm(), digits: 0)) + " × "
          + str(calc.round(h.mm(), digits: 0)) + " mm"
      )
      let name = if src != none { src } else if label != none { label } else { "unset source" }
      box(
        width: w, height: h, radius: sp.box-radius,
        stroke: (paint: rc.muted, thickness: 3pt * pf * sf, dash: "dashed"),
        align(center + horizon, text(size: sz.caption, fill: rc.muted, {
          raw(name)
          linebreak()
          dims
        })),
      )
    })
  } else {
    image(src, width: 100%)
  }

  block(above: sp.block, below: sp.block, breakable: false, {
    box(width: width, {
      picture
      if caption != none {
        block(width: 100%, above: sp.caption-gap, below: 0pt, {
          set par(leading: 0.42em)
          text(size: sz.caption, fill: rc.muted, caption)
        })
      }
    })
  })
}

// ── callout ─────────────────────────────────────────────────────────────────
#let callout(kind: "note", body) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  fill: if kind == "definition" { rc.accent } else { rc.note },
  radius: sp.box-radius, inset: sp.box-inset,
  body,
)

// ── chip ────────────────────────────────────────────────────────────────────
#let chip(body) = box(
  fill: rc.support, radius: 1em, outset: (y: 0.32em),
  inset: (x: 0.7em),
  text(size: sz.chip, weight: "medium", fill: rc.ink, body),
)

// ── code block ──────────────────────────────────────────────────────────────
// Dig the source text out of a fenced ```lang block, so the language can be
// dropped. Syntax highlighting would import hues from outside the role map and
// break the "at most three accents" rule, and a show rule cannot undo it — the
// highlighter sets an explicit fill on every span. `highlight: true` opts in.
#let raw-source(body) = {
  if type(body) == str { body } else if body.func() == raw { body.text } else {
    let kids = body.fields().at("children", default: ())
    let hit = kids.find(c => c.func() == raw)
    if hit != none { hit.text }
  }
}

#let codeblk(lang: none, highlight: false, body) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  // a faint ink wash, not `panel`: a white code block inside a white boxed
  // panel has no visible edge
  fill: rc.ink.transparentize(94%), radius: sp.box-radius * 0.5,
  inset: sp.box-inset * 0.6,
  {
    set text(font: cfg.fonts.mono, size: sz.mono, fill: rc.ink)
    set par(leading: 0.55em)
    let src = raw-source(body)
    if src == none or highlight {
      body
    } else {
      raw(src, lang: none, block: true)
    }
  },
)

// ── table ───────────────────────────────────────────────────────────────────
// No vertical rules, one rule under the header row, generous row padding.
#let tbl(..args) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  table(
    // the only rule: the top edge of the first body row, i.e. under the header
    stroke: (x, y) => if y == 1 { (top: hairline + rc.muted) },
    inset: (x: 0.6em, y: 0.75em),
    fill: none,
    ..args,
  ),
)
#let thead(..cells) = table.header(
  ..cells.pos().map(c => text(weight: "bold", c)),
)

// ── references ──────────────────────────────────────────────────────────────
#let refs(items) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  {
    set text(size: sz.small, fill: rc.muted)
    set par(leading: 0.45em, spacing: 0.7em)
    for (i, it) in items.enumerate() {
      block(width: 100%, [[#(i + 1)]~~#it])
    }
  },
)

// ── references from a .bib file ──────────────────────────────────────────────
// The alternative to hand-maintaining `refs`, which drifts from the paper the
// moment either changes. `full: false` prints only entries you have cited with
// `@key` elsewhere on the poster; `full: true` prints the whole file. Typst
// allows one `bibliography` per document, so this can be called once.
#let bibrefs(path, style: "ieee", full: true) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  {
    set text(size: sz.small, fill: rc.muted)
    set par(leading: 0.45em, spacing: 0.7em)
    bibliography(path, title: none, style: style, full: full)
  },
)

// ── funding line ────────────────────────────────────────────────────────────
#let funding(body) = block(
  width: 100%, above: sp.block, below: sp.block, breakable: false,
  text(size: sz.small, fill: rc.muted, body),
)


// ══════════════════════════════════════════════════════════════════════════════
//  6. HEADER AND FOOTER BANDS
// ══════════════════════════════════════════════════════════════════════════════

#let author-line(authors, n-affils) = {
  let parts = authors.map(a => {
    let nm = if a.at("presenter", default: false) {
      text(weight: "bold", a.name)
    } else { a.name }
    let marks = if n-affils > 1 and a.at("affil", default: ()).len() > 0 {
      super(a.affil.map(str).join(","))
    }
    [#nm#marks]
  })
  parts.join(", ")
}

// One affiliation per line. Two long department names side by side wrap into
// each other and become unreadable.
#let affil-line(affils) = {
  if affils.len() == 1 { affils.first() } else {
    affils.enumerate().map(((i, a)) => [#super(str(i + 1))#a]).join(linebreak())
  }
}

// A logo slot is either a path, or `(src: .., scale: ..)`. Two institutional
// logos almost never carry the same optical weight at the same height — line art
// with internal whitespace reads smaller than a filled mark — so each one can be
// nudged without touching the shared cap.
#let logo-img(entry, h) = {
  let (src, s) = if type(entry) == str {
    (entry, 1.0)
  } else {
    (entry.src, entry.at("scale", default: 1.0))
  }
  image(src, height: h * s)
}

// The right-hand slot of the header. Institutional logos belong in the footer and
// only there — repeating them at the top spends the second-most valuable space on
// the page saying something the reader already knows. Put something they cannot
// get elsewhere here instead: a teaser figure, a graphical abstract, or a
// portrait of whoever is standing next to the poster.
//
// Accepts a path, `(src: .., scale: ..)`, or arbitrary content.
#let header-art(entry) = {
  if entry == none {
    none
  } else if type(entry) == str {
    image(entry, height: sp.art-h)
  } else if type(entry) == dictionary and "src" in entry {
    image(entry.src, height: sp.art-h * entry.at("scale", default: 1.0))
  } else {
    box(height: sp.art-h, entry)
  }
}

#let header-band(c) = block(
  width: 100%, fill: rc.brand, above: 0pt, below: sp.block, breakable: false,
  inset: (x: sp.margin, y: sp.band-pad-y),
  grid(
    columns: if c.at("art", default: none) == none { (1fr,) } else { (1fr, auto) },
    column-gutter: sp.gutter,
    align: horizon,
    {
      set par(leading: 0.3em, spacing: 0.55em)
      text(size: sz.title, weight: "bold", fill: rc.ink, c.title)
      if c.subtitle != none {
        parbreak()
        text(size: sz.subtitle, fill: rc.ink, c.subtitle)
      }
      v(sp.head-body-gap, weak: false)
      set par(leading: 0.4em, spacing: 0.5em)
      text(size: sz.authors, weight: "medium", fill: rc.ink,
        author-line(c.authors, c.affiliations.len()))
      // Affiliations are the cheapest thing to move off the most expensive part
      // of the page: at A0 each line costs ~12 mm of header, and almost nobody
      // reads them at a poster session.
      if not c.at("affiliations-in-footer", default: false) {
        parbreak()
        text(size: sz.affil, fill: rc.muted, affil-line(c.affiliations))
      }
      if c.at("contact", default: none) != none {
        parbreak()
        text(size: sz.affil, fill: rc.muted, c.contact)
      }
    },
    ..if c.at("art", default: none) == none { () } else { (header-art(c.art),) },
  ),
)

// The leading `v()` is not decoration. The content section ends with `v(1fr)` to
// push this band to the bottom edge, and an explicit `v()` absorbs the automatic
// block spacing that would otherwise sit above it — so on a poster that exactly
// fills the page the last block would come to rest flush against the footer.
// An explicit, non-weak spacer adds to the `1fr` instead of being swallowed by
// it, which guarantees the clearance whether or not there is slack left.
#let footer-band(c) = {
  v(sp.block, weak: false)
  block(
  width: 100%, fill: rc.brand, above: 0pt, below: 0pt, breakable: false,
  inset: (x: sp.margin, y: sp.foot-pad-y),
  grid(
    columns: (auto, 1fr, auto),
    rows: (sp.qr-size,), // fixes the band height whatever the slots contain
    column-gutter: sp.gutter,
    align: horizon,
    // left — institutional logos
    grid(
      columns: c.footer-logos.map(_ => auto),
      column-gutter: sp.gutter * 0.8,
      align: horizon,
      ..c.footer-logos.map(e => logo-img(e, sp.foot-logo-h)),
    ),
    // middle — affiliations if they were moved off the header, then funding
    {
      set par(leading: 0.4em, spacing: 0.45em)
      if c.at("affiliations-in-footer", default: false) {
        text(size: sz.small, fill: rc.muted, affil-line(c.affiliations))
        if c.at("funding", default: none) != none { parbreak() }
      }
      if c.at("funding", default: none) != none {
        text(size: sz.small, fill: rc.muted, c.funding)
      }
    },
    // right — QR plus a short repo-or-contact line
    if c.at("qr", default: none) != none {
      stack(dir: ltr, spacing: 0.5 * sp.gutter,
        align(horizon, text(size: sz.caption, weight: "medium", fill: rc.ink,
          c.at("qr-caption", default: ""))),
        image(c.qr, height: sp.qr-size),
      )
    },
  ),
  )
}


// ══════════════════════════════════════════════════════════════════════════════
//  7. DOCUMENT SET-UP
//     Page margin is zero: bands manage their own inset, which is what lets
//     them bleed. The body is header → bands → v(1fr) → footer.
// ══════════════════════════════════════════════════════════════════════════════

#set page(
  width: page-w,
  height: page-h,
  margin: 0mm,
  fill: rc.bg,
  foreground: overlay-layer,
)

#set text(
  font: cfg.fonts.sans,
  size: sz.body,
  fill: rc.ink,
  lang: "en",
  hyphenate: false,
)
#set par(leading: 0.5em, spacing: 1.1em, justify: false)
#set list(spacing: 0.9em, indent: 0.6em)
#set enum(spacing: 0.9em, indent: 0.6em)
#show link: it => it

// `= Heading` in markup gets the same treatment as `panel(title: ..)`.
#show heading.where(level: 1): it => sec(it.body)

#let hand(body) = text(font: cfg.fonts.hand, body)



// ══════════════════════════════════════════════════════════════════════════════
//  8. CONTENT — this is the part you write.
// ══════════════════════════════════════════════════════════════════════════════

#header-band(cfg)

#band[
  #panel(title: "The question")[
    Replace this paragraph. One idea per panel; a poster is read standing up, so
    keep each block to a few sentences and let the figures carry the argument.

    Body text is #sz.body.pt() pt, which gives roughly 43 characters to the line
    in a three-column layout. That is tight, deliberately — a figure-forward
    poster wants short paragraphs.
  ]

  #panel(title: "Approach")[
    A second block. Blocks are separated by whitespace, not by outlines;
    `frame: "rule"` and `frame: "box"` exist for the cases that genuinely need
    them.

    Content is packed into the columns of the band automatically, so a block
    that does not fit continues at the top of the next column.
  ]

  #panel(title: "How it works")[
    A third text block. Text is the cheap thing on a poster: it reflows when you
    change the column count, whereas a figure keeps its aspect ratio and grows
    taller as its column gets wider.

    So if you switch `columns`, expect to re-cut the figures rather than the
    prose.
  ]

  #fig(
    "figures/fig-overview.svg",
    ratio: 16 / 9,
    caption: [Replace `figures/fig-overview.svg` with your own export, keeping
      the filename. Set `ratio` to its aspect so the layout does not move.],
  )
]

#keymessage[
  The one sentence you want somebody to remember from ten metres away.
]

#band(cols: 2)[
  #fig(
    "figures/fig-results.svg",
    ratio: 5 / 2,
    caption: [A wide figure across a two-column band. Prefer wide figures: a
      figure keeps its aspect, so its height grows with its column.],
  )

  #panel(title: "What it means", frame: "box")[
    A boxed panel, for the one block on the poster that genuinely needs to be
    set apart. Everything else should hold together on whitespace alone.
  ]
]

#band[
  #panel(title: "What we measured")[
    Keep this kind of block short. If you find yourself writing five sentences,
    the sentences probably belong in the talk and a figure belongs here.
  ]

  #fig(
    none,
    ratio: 4 / 3,
    label: "figures/fig-method.svg",
    caption: [And this is the other way round: `src: none` draws the box without
      the image, so you can lay the poster out before the export exists. The box
      reports the path it is waiting for and its own size in mm.],
  )

  #panel(title: "Take-aways")[
    - Short, parallel, verb-first.
    - Three of them, not seven.
    - The one you care about goes first.
  ]

  #panel(title: "Limitations")[
    Say the honest thing here. It is the block experienced readers look for, and
    its absence is conspicuous.
  ]

  #panel(title: "References")[
    #refs((
      [Author, A. and Author, B. (2025). A paper this poster builds on.
        _Journal Name_ 12, 34–56.],
      [Author, C. (2024). Another one. _Preprint_, arXiv:2401.00000.],
    ))
  ]
]

#v(1fr)

#footer-band(cfg)
