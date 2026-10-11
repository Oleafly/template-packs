// NSS slide theme for Typst/Touying.
//
// Models the "archetype" Keynote look (see ~/Desktop/full_archetype.pdf):
// light blue-gray background, dark slate title text, muted-blue accent
// for subtitles/statements, left-aligned content. Also ships a dark
// variant (`dark-palette`) that keeps the same layout.
//
// Import + apply (light theme):
//
//   #import "theme.typ": *
//   #show: nss-theme.with()
//
//   #cover-slide(
//     title: [Presentation title],
//     subtitle: [Presentation subtitle],
//     author: [Ashton Wiersdorf · 2026],
//   )
//
//   = Beginning of a section
//
//   == Title & bullets
//   #slide-subtitle[Slide subtitle]
//
//   - Bullet 1
//   - Bullet 2
//   - Bullet 3
//
//   #statement-slide[This is a statement]
//
//   #big-bullets(
//     [First point],
//     [Second point],
//     [Third point],
//   )
//
//   #photo-slide(
//     title: [Title, photo, & bullets],
//     subtitle: [Slide subtitle],
//     image: image("photo.jpg"),
//   )[
//     - Bullet one
//     - Bullet two
//   ]
//
// For the dark variant:
//
//   #show: nss-theme.with(palette: dark-palette)
//
// All colors, fonts, and sizes are exposed as top-level dicts. Edit them
// here to retheme the whole deck, or pass `palette:`, `type-scale:`,
// `font-config:`, `aspect-ratio:` as keyword args to `nss-theme`.

#import "@preview/touying:0.7.4": *

// ============ Palettes ============================================

#let nord-palette = (
    nord1:       rgb("#2e3440"),
    nord2:       rgb("#3b4252"),
    nord3:       rgb("#434c5e"),
    nord4:       rgb("#4c566a"),
    nord5:       rgb("#d8dee9"),
    nord6:       rgb("#e5e9f0"),
    nord7:       rgb("#eceff4"),
    red:         rgb("#bf616a"),
    green:       rgb("#a3be8c"),
    yellow:      rgb("#ebcb8b"),
    orange:      rgb("#d08770"),
    blue:        rgb("#5e81ac"),
    blue-warmer: rgb("#81a1c1"),
    blue-faint:  rgb("#8fbcbb"),
    cyan:        rgb("#88c0d0"),
    purple:      rgb("#b48ead"),)
)

#let light-palette = (
    bg:     nord-palette.nord7,  // light blue-gray page fill
    fg:     nord-palette.nord1,  // dark slate — titles, body
    accent: nord-palette.blue,  // muted blue — subtitles, statements
    muted:  nord-palette.nord4,  // secondary gray — author, footer
)

#let dark-palette = (
    bg:     nord-palette.nord1,  // nord polar-night — page fill
    fg:     nord-palette.nord7,  // nord snow-storm — titles, body
    accent: nord-palette.cyan,  // nord frost blue — subtitles, statements
    muted:  nord-palette.nord5,  // secondary gray — author, footer
)

#let print-palette = (
  bg:     rgb("#FFFFFF"),  // pure white for background
  fg:     rgb("#000000"),  // pure black for text
  accent: rgb("#7B95B0"),  // muted blue — subtitles, statements
  muted:  rgb("#6B7280"),  // secondary gray — author, footer
)

// Default palette used by inline helpers and nss-theme's default arg.
#let palette = light-palette

// ============ Type scale ==========================================

#let type-scale = (
    body:      26pt,
    title:     50pt,   // slide `== title`
    author:    16pt,   // slide `== title`
    subtitle:  32.5pt,   // `slide-subtitle[...]`
    cover:     80pt,   // cover-slide (auto-fit to width)
    section:   63pt,   // section-slide
    statement: 63pt,   // statement-slide
    bullet:    40pt,   // big-bullets item
    footer:    10pt,
    // Vertical padding beneath the content-slide title. Kept in em so it
    // scales with the title font.
    title-pad: 1.2em,
)

// ============ Fonts ===============================================

#let font-config = (
  sans: ("Concourse 3", "Fira Sans", "Inter", "Helvetica Neue"),
  // mono: ("Iosevka Output", "Fira Mono", "Menlo"),
  mono: ("Iosevka Output",),
  // Cover title uses wider letter-spacing to match the Keynote look
  cover-tracking: 0.00em,
)

// ============ State for inline helpers ============================
// Inline helpers (`hi`, `dim`, `mono`) live inside slide bodies where
// `self.store` isn't reachable, so we mirror the active palette into
// a Typst state that `nss-theme` updates at setup time.

#let _palette-state = state("nss-palette", palette)
#let _font-state = state("nss-font-config", font-config)

#let hi(body, color: auto) = context {
  let c = if color == auto { _palette-state.get().accent } else { color }
  text(fill: c, weight: "bold", body)
}

#let dim(body, color: auto) = context {
  let c = if color == auto { _palette-state.get().muted } else { color }
  text(fill: c, body)
}

#let mono(body) = context text(font: _font-state.get().mono, body)


// ============ Slide-level marks ===================================

#let slide-subtitle(body) = touying-fn-wrapper((self: none) => {
  let p = self.store.palette
  let ts = self.store.type-scale
  block(
    above: 0.2em,
    below: 1.2em,
    text(size: ts.subtitle, fill: p.accent, weight: "semibold", body),
  )
})

// ============ Custom slide layouts ================================

// Standard content slide. Title comes from the current `==` heading and
// is rendered inline at the top of the body (via subslide-preamble) so
// it inherits the page's x-margin.
#let content-slide(config: (:), ..bodies) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let preamble = block(
    below: ts.title-pad,
    text(size: ts.title, weight: "semibold", fill: p.fg,
         utils.display-current-heading(level: 2)),
  )
  let self = utils.merge-dicts(
    self,
    config-common(subslide-preamble: preamble),
    config-page(header: none),
  )
  touying-slide(
    self: self,
    config: config,
    ..bodies,
  )
})

// Cover / title slide. All-caps title auto-fit to width, subtitle in
// accent color, author tucked near the bottom-left.
#let cover-slide(
  title: [Presentation title],
  subtitle: none,
  author: none,
) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let fc = self.store.font-config
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(header: none, footer: none),
  )
  touying-slide(
    self: self,
    align(left + horizon)[
      #utils.fit-to-width(width: 100%,
        text(
          size: ts.cover,
          weight: "regular",
          fill: p.fg,
          tracking: fc.cover-tracking,
          upper(title),
        ),
      )
      #if subtitle != none {
        // v(0.3em)
        text(size: ts.subtitle, fill: p.accent,
             weight: "semibold", subtitle)
      }
      #if author != none {
          place(bottom + left, dy: 0.1em,
          text(size: ts.author, fill: p.muted,
               weight: "regular", author))
      }
    ],
  )
})

// Section-break slide. Big left-aligned semibold title, vertically centered.
// Auto-shrinks to fit the page width. Keeps the page-number footer.
#let section-slide(config: (:), body) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let self = utils.merge-dicts(self, config-page(header: none))
  touying-slide(
    self: self,
    config: config,
    align(left + horizon,
      utils.fit-to-width(width: 100%, grow: false,
        text(size: ts.section, weight: "semibold", fill: p.fg,
             utils.display-current-heading(level: 1)))),
  )
})

// Statement slide. Big semibold accent-color line, centered.
#let statement-slide(body) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let self = utils.merge-dicts(self, config-page(header: none))
  touying-slide(
    self: self,
    align(center + horizon,
      utils.fit-to-width(width: 100%, grow: false,
        text(size: ts.statement, weight: "semibold", fill: p.accent, body))),
  )
})

// Big centered bullets that reveal one at a time. Each subslide shows
// the first `i` bullets stacked and re-centered, so the group stays
// vertically centered as new items appear.
//
// Usage:  #big-bullets([First], [Second], [Third])
#let big-bullets(
  ..items,
  sep: 2.0em,
) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let bullets = items.pos()
  let render(b) = text(size: ts.bullet, weight: "semibold", fill: p.fg, b)
  let stack-of(n) = {
    set block(above: sep, below: sep)
    for b in bullets.slice(0, n) {
      block(render(b))
    }
  }
  let stages = range(1, bullets.len() + 1).map(stack-of)
  let self = utils.merge-dicts(self, config-page(header: none))
  // Body is a function so touying re-invokes it per subslide with
  // `self.subslide` populated — `alternatives` needs that to pick the
  // correct stage on each pass.
  touying-slide(
    self: self,
    repeat: bullets.len(),
    self => align(center + horizon,
      utils.alternatives(
        self: self,
        position: center + horizon,
        ..stages,
      )),
  )
})

// Two-column layout: title + subtitle + bullets on the left, image on
// the right. Column widths default to 1:1. Title auto-fits its column.
#let photo-slide(
  title: none,
  subtitle: none,
  image: none,
  ratio: (1fr, 1fr),
  gutter: 2em,
  body,
) = touying-slide-wrapper(self => {
  let p = self.store.palette
  let ts = self.store.type-scale
  let self = utils.merge-dicts(self, config-page(header: none))
  touying-slide(
    self: self,
    grid(
      columns: ratio,
      column-gutter: gutter,
      align: (left + horizon, center + horizon),
      [
        #if title != none {
          block(above: 0em, below: 0.3em,
            utils.fit-to-width(width: 100%, grow: false,
              text(size: ts.title, weight: "semibold",
                   fill: p.fg, title)))
        }
        #if subtitle != none {
          block(above: 0em, below: 1em,
            text(size: ts.subtitle, weight: "semibold",
                 fill: p.accent, subtitle))
        }
        #body
      ],
      image,
    ),
  )
})

// ============ Theme entry point ===================================

#let nss-theme(
  aspect-ratio: "16-9",
  palette: light-palette,
  type-scale: type-scale,
  font-config: font-config,
  ..args,
  body,
) = {
  // Mirror palette/font into Typst state so inline helpers can read them.
  _palette-state.update(palette)
  _font-state.update(font-config)

    show raw: set text(font: font-config.mono)
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (x: 0.5in, y: 0.5in),
      fill: palette.bg,
      footer-descent: 0.3em,
      footer: context {
        set text(size: type-scale.footer, fill: palette.muted, weight: "light")
        align(center, utils.slide-counter.display())
      },
    ),
    config-common(
      slide-fn: content-slide,
      new-section-slide-fn: section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: font-config.sans, size: type-scale.body, fill: palette.fg)
        set list(marker: text(fill: palette.fg, "•"),
                 indent: 0.5em, body-indent: 0.6em)
        show heading: set text(fill: palette.fg)
        set strong(delta: 100)
        body
      },
    ),
    config-colors(
      primary: palette.accent,
      neutral-darkest: palette.fg,
      neutral-light: palette.muted,
      neutral-lightest: palette.bg,
    ),
    // Threaded into every slide function via `self.store`.
    config-store(
      palette: palette,
      type-scale: type-scale,
      font-config: font-config,
    ),
    ..args,
  )
  body
}
