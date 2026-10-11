// uiuc.typ — Siebel School of Computing and Data Science / Grainger Engineering
// slide template, built on touying 0.8.0. A 1:1 recreation of the Grainger
// PowerPoint template, with defaults branded for the Siebel School (every
// string is an option of `uiuc-slides`, so other units can override them).
//
// Quick start (see README.md for the full guide):
//
//   #import "uiuc.typ": *
//   #show: uiuc-slides.with(title: "My Talk", date: "August 2026")
//
//   = Section divider
//   == A content slide
//   Body text, bullets, anything Typst can do.
//   #pause
//   Revealed on the next click (any touying animation works).
//   === Orange subheading
//   ==== Navy subheading
//
// Geometry reference: the original slide is 960x540pt (13.33x7.5in). The
// slides are 18.667x10.5cm (16:9), so 1 pptx-pt = 0.5512 typst-pt and
// 1 reference-pixel (of a 1333x750 screenshot grid) = 0.014cm.

// Re-exported, so `#import "uiuc.typ": *` also brings in touying's `pause`,
// `meanwhile`, `uncover`, `only`, `alternatives`, `slide`, `utils`, ...
#import "@preview/touying:0.8.0": *

// ---------------------------------------------------------------- constants
#let uiuc-navy = rgb("#13294B")
#let uiuc-orange = rgb("#FF5F05")
// heading accent colors used by the original template's text styles
#let heading-orange = rgb("#E84B36")
#let heading-navy = rgb("#15264B")
#let ph-fill = rgb("#D9D9D9")
#let ph-text = rgb("#A5A5A5")

// Arial per the brand guidelines; Liberation Sans is its metric-compatible
// stand-in on systems without it (most Linux machines). Typst warns about
// whichever of the two is missing — the deck still renders in the other.
#let uiuc-font = ("Arial", "Liberation Sans")

// slide size (16:9, 10.5cm tall)
#let slide-width = 18.667cm
#let slide-height = 10.5cm

// reference-pixel -> length (1333x750 screenshot grid)
#let px(n) = n * 0.014cm
// pptx font size -> typst font size
#let fs(n) = n * 0.5512pt

#let footer-left-text = state("uiuc-footer-left", "SIEBEL SCHOOL OF COMPUTING AND DATA SCIENCE")
#let footer-right-text = state("uiuc-footer-right", "GRAINGER ENGINEERING")

// ---------------------------------------------------------------- components
#let uiuc-footer(dark: false) = context {
  let col = if dark { white } else { uiuc-navy }
  set text(font: uiuc-font, size: fs(9), fill: col, tracking: 1.1pt)
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 0.55cm,
    align: (left + horizon, horizon, right + horizon),
    footer-left-text.get(),
    grid(
      columns: (1fr, auto),
      align: (horizon, horizon),
      line(length: 100%, stroke: 0.6pt + col),
      circle(radius: 1.15pt, fill: col, stroke: none),
    ),
    footer-right-text.get(),
  )
}

// Block I logo, absolutely placed at the top-right corner of a full-bleed page
#let block-i(kind: "orange") = place(
  top + right,
  dx: -px(38),
  dy: px(28),
  image("static/image" + (if kind == "orange" { "4" } else { "6" }) + ".svg", height: px(44)),
)

/// Gray IMAGE / GRAPHIC placeholder box, like the ones in the original template.
/// Drop one anywhere you don't have the final figure yet.
#let placeholder(label, width: 100%, height: 100%) = box(
  width: width,
  height: height,
  fill: ph-fill,
  align(center + horizon, text(font: uiuc-font, size: fs(18), fill: ph-text, label)),
)

// the angled "swoosh" underline used on divider slides
#let _swoosh(col) = {
  let stroke = (paint: col, thickness: 1.2pt, cap: "round")
  place(top + left, line(start: (px(480), px(292)), end: (px(855), px(292)), stroke: stroke))
  place(top + left, line(start: (px(430), px(325)), end: (px(480), px(292)), stroke: stroke))
}

// ---------------------------------------------------------------- slide types
/// Content slide: navy title band + Block I, UIUC footer. `== Heading` makes
/// one of these automatically; call `#slide[...]` directly for a slide that
/// continues under the previous title, or to use touying's `composer:` /
/// `repeat:` options.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => touying-slide(
  self: self,
  config: config,
  repeat: repeat,
  setting: setting,
  composer: composer,
  ..bodies,
))

// full-bleed slide helper: no margins, no page header/footer. The Block I and
// footer are drawn by `setting`, outside the animated body, so `#pause` in a
// slide's content never hides them.
#let _bleed(
  self,
  fill: none,
  background: none,
  footer: none,
  logo: none,
  config: (:),
  body,
) = {
  self = utils.merge-dicts(
    self,
    config-page(
      margin: 0cm,
      header: none,
      footer: none,
      fill: fill,
      background: background,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    setting: body => {
      set text(font: uiuc-font)
      body
      if logo != none { block-i(kind: logo) }
      if footer != none {
        place(bottom + center, dy: -px(16), block(width: 100% - 2 * px(50), footer))
      }
    },
    body,
  )
}

/// Title slide (navy doodle background, UIUC wordmark). Emitted automatically
/// by `uiuc-slides` — call it directly only with `show-title-slide: false`.
#let title-slide(
  title: [],
  subtitle: none,
  authors: (),
  notes: (),
  date: none,
  config: (:),
) = touying-slide-wrapper(self => _bleed(
  self,
  background: image("static/image1.jpg", width: 100%, height: 100%),
  config: utils.merge-dicts(config-common(freeze-slide-counter: true), config),
  {
    place(top + center, dy: px(100), image("static/image2.svg", width: px(330)))
    let authors = if type(authors) == str { (authors,) } else { authors }
    // title, subtitle, authors and notes flow down from the title, so a title
    // that wraps pushes the rest down instead of running into it. The gaps put
    // a one-line title's block where the original template has it.
    let flow = block(width: slide-width - 2 * px(80), {
      set align(center)
      set text(fill: white)
      set block(spacing: 0pt)
      block(text(size: fs(45), weight: "bold", title))
      if subtitle != none {
        v(px(37))
        block(text(size: fs(25), subtitle))
      }
      if authors != () {
        v(px(41))
        block(text(size: fs(20), authors.join(", ", last: " & ")))
      }
      if notes != () {
        v(if authors == () { px(61) } else { px(18) })
        block({
          set par(leading: 0.9em)
          text(size: fs(18), notes.join([\ ]))
        })
      }
    })
    place(top + center, dy: px(300), flow)
    if date != none {
      // on the original's date line, or just below the text if it reaches that far
      context place(
        top + center,
        dy: calc.max(px(600), px(300) + measure(flow).height + px(30)),
        text(size: fs(18), fill: white, tracking: 2.2pt, date),
      )
    }
  },
))

// divider page contents, shared by `divider` and the `= Heading` section slide
#let _divider(self, title, body: none, note: none, config: (:)) = _bleed(
  self,
  background: image("static/image3.jpg", width: 100%, height: 100%),
  logo: "orange",
  footer: uiuc-footer(dark: true),
  config: config,
  {
    place(top + center, dy: px(180), text(size: fs(60), weight: "bold", fill: white, title))
    _swoosh(uiuc-orange)
    if body != none {
      place(top + center, dy: px(360), block(width: px(990), {
        set text(size: fs(28), fill: white)
        align(center, body)
      }))
    }
    if note != none {
      place(top + center, dy: px(548), text(size: fs(18), fill: white, note))
    }
  },
)

/// Main section divider (navy background, orange swoosh). `= Heading` produces
/// this slide with no body; call `#divider(...)` directly for body/note text.
#let divider(title, body: none, note: none, config: (:)) = touying-slide-wrapper(
  self => _divider(self, title, body: body, note: note, config: config),
)

// `= Heading` -> divider titled with the heading's text
#let _section-slide(config: (:), body) = touying-slide-wrapper(self => {
  let h = self.at("headings", default: ()).rev().find(h => h.depth == 1)
  _divider(self, if h != none { h.body }, body: body, config: config)
})

/// Transition / section divider option two (orange background, white swoosh).
#let transition(title, note: none, config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  background: image("static/image5.jpg", width: 100%, height: 100%),
  logo: "blue",
  footer: uiuc-footer(dark: false),
  config: config,
  {
    _swoosh(white)
    place(top + center, dy: px(335), text(size: fs(45), weight: "bold", fill: uiuc-navy, title))
    if note != none {
      place(top + center, dy: px(435), text(size: fs(18), fill: uiuc-navy, note))
    }
  },
))

/// Photo across the top two-thirds of the slide, caption strip below.
#let photo-slide(img, caption, config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  fill: white,
  logo: "orange",
  footer: uiuc-footer(dark: false),
  config: config,
  {
    place(top + left, box(width: 100%, height: px(500), clip: true, img))
    place(top + center, dy: px(553), block(width: px(1160), {
      set text(size: fs(22), fill: black)
      set par(leading: 0.65em)
      align(center, caption)
    }))
  },
))

/// Navy full-bleed content slide: tall image left, text right.
#let navy-slide(img, body, config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  fill: uiuc-navy,
  logo: "orange",
  footer: uiuc-footer(dark: true),
  config: config,
  {
    place(top + left, dx: px(46), dy: px(35), box(width: px(451), height: px(655), clip: true, img))
    place(top + left, dx: px(571), dy: px(115), block(width: px(710), {
      set text(fill: white, size: fs(18))
      body
    }))
  },
))

/// Full-slide photo with a navy call-out panel on the left.
/// `img` is a path or content; `panel-body` is placed inside the navy panel.
#let photo-callout(img, panel-body, panel-width: 50%, config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  background: if type(img) == str { image(img, width: 100%, height: 100%) } else { img },
  logo: "orange",
  footer: uiuc-footer(dark: true),
  config: config,
  {
    place(top + left, block(width: panel-width, height: 100%, fill: uiuc-navy, {
      set text(fill: white)
      panel-body
    }))
  },
))

/// Closing slide: bold summary lines + optional note and body text.
#let closing-slide(note: none, lines: (), body: none, config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  background: image("static/image3.jpg", width: 100%, height: 100%),
  logo: "orange",
  footer: uiuc-footer(dark: true),
  config: config,
  place(top + left, dx: px(258), dy: px(202), {
    set text(fill: white)
    if note != none {
      text(size: fs(18), note)
      v(px(38))
    }
    block({
      set text(size: fs(26), weight: "bold")
      set par(leading: 0.62em)
      lines.join([\ ])
    })
    if body != none {
      v(px(48))
      block(width: px(800), text(size: fs(18), body))
    }
  }),
))

/// Branded final slide (orange, Grainger wordmark). Emitted automatically by
/// `uiuc-slides` — call it directly only with `show-brand-slide: false`.
#let brand-slide(config: (:)) = touying-slide-wrapper(self => _bleed(
  self,
  background: image("static/image5.jpg", width: 100%, height: 100%),
  config: utils.merge-dicts(config-common(freeze-slide-counter: true), config),
  place(center + horizon, image("static/image8.svg", width: px(600))),
))

// ---------------------------------------------------------------- layout helpers
/// Two columns of content (the original slide-5 layout).
#let two-col(a, b, columns: (1fr, 1fr), gutter: px(71)) = grid(
  columns: columns,
  column-gutter: gutter,
  a, b,
)

// normalize one-or-many figures into a vertical stack
#let _fig-stack(figs) = {
  if type(figs) != array { figs = (figs,) }
  stack(spacing: px(17), ..figs)
}

/// Figure column on the left, text on the right (original slides 6 and 8).
/// `figs` is a single image/placeholder or an array of them (stacked vertically).
#let img-left(figs, body, width: px(477), gutter: px(43)) = grid(
  columns: (width, 1fr),
  column-gutter: gutter,
  _fig-stack(figs), body,
)

/// Text on the left, figure column on the right (original slides 7 and 9).
// The figure cell comes first in content order (placed into column 1
// explicitly), so a `#pause` in the text never delays the figure.
#let img-right(figs, body, width: px(477), gutter: px(43)) = grid(
  columns: (1fr, width),
  column-gutter: gutter,
  grid.cell(x: 1, y: 0, _fig-stack(figs)),
  grid.cell(x: 0, y: 0, body),
)

/// Centered chart / figure with an optional commentary line below
/// (original slide 10).
#let chart(body, caption: none) = align(center, {
  body
  if caption != none {
    v(px(20))
    text(size: fs(16), caption)
  }
})

// ---------------------------------------------------------------- main wrapper
/// The template's show rule. Everything on the title slide comes from the
/// named arguments; the deck body is plain markup:
///   `= Heading`   -> navy section divider slide
///   `== Heading`  -> new content slide (title in the navy band)
///   `=== Heading` -> orange subheading inside a slide
///   `==== Heading`-> navy subheading inside a slide
/// Extra positional arguments are touying configs (`config-common(handout:
/// true)`, ...) and are applied last.
#let uiuc-slides(
  title: "Presentation",
  subtitle: "Siebel School of Computing and Data Science",
  authors: (),
  date: none,
  notes: (),
  footer-left: "SIEBEL SCHOOL OF COMPUTING AND DATA SCIENCE",
  footer-right: "GRAINGER ENGINEERING",
  // body text and band-title sizes; the original PowerPoint uses fs(18) / fs(24)
  text-size: fs(24),
  title-size: fs(36),
  show-title-slide: true,
  show-brand-slide: true,
  ..args,
  content,
) = {
  // tints of the title color used by the code, table and quote styles below
  let block-color = uiuc-navy.lighten(90%)
  let fill-color = uiuc-navy.lighten(50%)
  let header-color = uiuc-navy.lighten(65%)

  set document(title: title, author: authors)
  set text(font: uiuc-font)
  set heading(numbering: "1.a")
  set text(size: text-size)
  set par(leading: 0.48em, spacing: 1.15em)

  // footnotes: small gray entries with a short separator, so numeric source
  // notes read as fine print rather than body text
  set footnote.entry(
    separator: line(length: px(220), stroke: 0.5pt + rgb("#9a9a9a")),
    clearance: 0.8em,
    gap: 0.3em,
  )
  show footnote.entry: set text(size: fs(12), fill: rgb("#4a4a4a"))

  // headings: `=` and `==` become slides (see touying config below);
  // === orange subheading, ==== navy subheading
  show heading: set text(1.1em, fill: uiuc-navy)
  show heading.where(level: 3): it => block(
    above: 1.65em, below: 1.45em,
    text(size: fs(26), weight: "bold", fill: heading-orange, it.body),
  )
  show heading.where(level: 4): it => block(
    above: 1.65em, below: 1.45em,
    text(size: fs(20), weight: "bold", fill: heading-navy, it.body),
  )

  // body element styles
  show terms.item: it => stack(
    block(width: 100%, inset: 5pt, fill: header-color, radius: (top: 0.2em, bottom: 0cm), strong(it.term)),
    block(width: 100%, inset: 5pt, fill: block-color, radius: (top: 0cm, bottom: 0.2em), it.description),
  )
  show raw.where(block: false): it => box(fill: block-color, inset: 1pt, radius: 1pt, baseline: 1pt, text(it))
  show raw.where(block: true): it => block(radius: 0.5em, fill: block-color, width: 100%, inset: 1em, it)
  show list: set list(marker: (
    text(fill: uiuc-navy)[•],
    text(fill: uiuc-navy)[‣],
    text(fill: uiuc-navy)[-],
  ))
  set enum(numbering: nr => text(fill: uiuc-navy)[*#nr.*])
  show table: set table(stroke: (x, y) => (
    x: none,
    bottom: 0.8pt + black,
    top: if y == 0 { 0.8pt + black } else if y == 1 { 0.4pt + black } else { 0pt },
  ))
  show table.cell.where(y: 0): set text(style: "normal", weight: "bold")
  set table.hline(stroke: 0.4pt + black)
  set table.vline(stroke: 0.4pt)
  set quote(block: true)
  show quote.where(block: true): it => {
    v(-5pt)
    block(
      fill: block-color, inset: 5pt, radius: 1pt,
      stroke: (left: 3pt + fill-color), width: 100%,
      outset: (left: -5pt, right: -5pt, top: 5pt, bottom: 5pt),
      it,
    )
    v(-5pt)
  }
  show link: it => if type(it.dest) != str { it } else { underline(stroke: 0.5pt + uiuc-navy, it) }
  set outline(indent: auto)
  set bibliography(title: none)

  footer-left-text.update(footer-left)
  footer-right-text.update(footer-right)

  show: touying-slides.with(
    config-page(
      width: slide-width,
      height: slide-height,
      fill: white,
      numbering: none,
      // content-slide page chrome: navy band with slide title + Block I, UIUC footer
      margin: (x: px(50), top: px(135), bottom: px(60)),
      header: context {
        let page = here().page()
        let headings = query(selector(heading.where(level: 2)))
        let h = headings.rev().find(x => x.location().page() <= page)
        if h != none {
          // outset overshoots the page edges (clipped) so viewers can't show a
          // hairline seam where the fill would end exactly on the boundary
          block(width: 100%, fill: uiuc-navy, height: px(95), outset: (x: px(60), top: px(10)), {
            set text(size: title-size, fill: white, weight: "regular")
            align(left + horizon, h.body)
            place(right + horizon, dx: px(12), image("static/image4.svg", height: px(44)))
          })
        }
      },
      header-ascent: px(40),
      footer: uiuc-footer(dark: false),
      // px(30) puts the footer text at the same height as the hand-placed
      // footers on the full-bleed slides, and keeps footnotes clear of it
      footer-descent: px(30),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: _section-slide,
      slide-level: 2,
      // the chrome above is laid out against the real page margins
      zero-margin-header: false,
      zero-margin-footer: false,
      // keep **bold** plain bold, and footnotes numbered across the deck
      show-strong-with-alert: false,
      reset-footnote-number-per-slide: false,
    ),
    config-info(title: title, author: authors, date: date),
    ..args,
  )

  if show-title-slide {
    title-slide(title: title, subtitle: subtitle, authors: authors, notes: notes, date: date)
  }

  content

  if show-brand-slide {
    brand-slide()
  }
}
