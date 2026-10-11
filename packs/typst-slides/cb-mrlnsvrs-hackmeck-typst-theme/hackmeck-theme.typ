// hackmeck-theme.typ
// A dark terminal-aesthetic Touying theme.
#import "@preview/touying:0.6.1": *

// ── Palette ──────────────────────────────────────────────────────────────────
#let _bg       = rgb("#0a0d0a")   // near-black, faint green tint
#let _bg-bar   = rgb("#0d120d")   // slightly lighter for the header bar
#let _green    = rgb("#33cc33")   // body text
#let _green-hi = rgb("#7dff7d")   // headings, title, bright accents
#let _green-lo = rgb("#1d6b1d")   // muted: dividers, counter, decorations
#let _code-bg  = rgb("#001800")   // inline code box fill


// ── Default slide ─────────────────────────────────────────────────────────────
#let slide(
  title:    auto,
  config:   (:),
  repeat:   auto,
  setting:  body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  // Compute the heading to show in the header bar (resolved at render time)
  let title-display = if title != auto {
    title
  } else {
    utils.display-current-heading(depth: self.slide-level)
  }

  // Header bar: "\> TITLE" on the left, "[n/N]" on the right
  // Note: \> and \[ \] are escaped so > and [ ] are treated as literal characters
  let header(self) = {
    v(1.2em)
    block(
      width: 100%,
      fill:  _bg-bar,
      inset: (x: 1.1em, y: 0.6em),
    )[
      #grid(
        columns: (1fr, auto),
        align:   horizon,
        text(fill: _green-hi, size: 1.4em, weight: "bold")[\> #title-display],
        context text(fill: _green-lo, size: 0.8em)[
          \[#utils.slide-counter.display()/#utils.last-slide-number\]
        ],
      )
      #v(-0.3em)
      #line(length: 100%, stroke: 0.5pt + _green-lo)
    ]
  }

  let self = utils.merge-dicts(
    self,
    config-page(
      fill:          _bg,
      header:        header,
      footer:        none,
      header-ascent: 30%,
      margin:        (top: 4em, bottom: 1em, x: 1.5em),
    ),
  )

  let new-setting = body => {
    show: std.align.with(horizon)
    setting(body)
  }
  touying-slide(
    self:     self,
    config:   config,
    repeat:   repeat,
    setting:  new-setting,
    composer: composer,
    ..bodies,
  )
})


// ── Title slide ───────────────────────────────────────────────────────────────
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(fill: _bg, margin: 3em, header: none, footer: none),
  )
  touying-slide(
    self: self,
    align(center + horizon)[
      #text(size: 0.9em, fill: _green-lo)[#info.subtitle]
      #v(0.3em)
      #text(size: 3.8em, weight: "bold", fill: _green-hi)[#info.title]
      #v(0.8em)
      #line(length: 35%, stroke: 0.7pt + _green-lo)
      #if info.author != none [
        #v(0.5em)
        #text(size: 0.8em, fill: _green-lo)[#info.author]
      ]
    ]
  )
})


// ── Focus slide (optional) ────────────────────────────────────────────────────
// Use for dramatic single-line statements: #focus-slide[Wake up!]
#let focus-slide(config: (:), body) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: _green-hi, margin: 2em, header: none, footer: none),
  )
  set text(fill: _bg, size: 1.8em, weight: "bold")
  touying-slide(self: self, config: config, align(center + horizon, body))
})


// ── Theme entry point ─────────────────────────────────────────────────────────
#let hackmeck-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper:          "presentation-" + aspect-ratio,
      fill:           _bg,
      header-ascent:  0%,
      footer-descent: 0%,
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(fill: _green, size: 20pt, font: "Courier Prime")
        show raw.where(block: false): it => box(
          fill:   _code-bg,
          inset:  (x: 5pt, y: 2pt),
          radius: 2pt,
          text(fill: _green-hi, size: 0.9em, it),
        )
        body
      },
      alert: (self: none, body) => text(fill: _green-hi, weight: "bold", body),
    ),
    config-colors(
      primary:          _green-hi,
      neutral-lightest: _bg,
      neutral-darkest:  _green,
    ),
    ..args,
  )
  body
}
