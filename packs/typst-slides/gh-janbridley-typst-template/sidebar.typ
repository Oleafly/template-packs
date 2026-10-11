// sidebar.typ
//
// The SVG viewBox is 4800 x 2700 units, i.e. a 16:9 slide at 300 units per inch.
// The sidebar graphic spans x = 0 .. 210.585, which is exactly 0.70" of the 16" wide
// page, so the deck uses a 16in x 9in page and the art is placed as a full-page
// background at 100%.
//
// Usage:
//   #import "@preview/touying:0.8.0": *
//   #import "sidebar.typ": *
//   #show: sidebar-theme.with(config-info(title: [...], author: [...]))
//
// Requires typst >= 0.15 (touying 0.8.0).

#import "@preview/touying:0.8.0": *
#import "palette.typ": palette

// Width of the sidebar art on a 16in-wide page (210.585 / 4800 * 16in).
#let sidebar-width = 16in * (210.585 / 4800)

/// Regular slide: slide title (+ optional logo) and an orange rule in the header
#let slide(
  title: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set align(top)
    set text(fill: self.colors.neutral-darkest)
    pad(
      top: 0.05in,
      {
        v(0.35in)
        components.left-and-right(
          block(width: 100%, {
            // slide title (explicit `title:` argument, else the current heading)
            set text(
              size: 1.6em,
              weight: "bold",
              tracking: 0.02em,
              font: self.store.title-font,
            )
            utils.fit-to-width(
              grow: false,
              100%,
              if title != auto {
                utils.call-or-display(self, title)
              } else {
                utils.display-current-heading(depth: self.slide-level)
              },
            )
          }),
          utils.call-or-display(self, self.store.header-right),
        )
        v(0.5em, weak: true)
        line(length: 100%, stroke: 1.5pt + self.colors.primary)
      },
    )
  }
  let footer(self) = {
    set align(bottom)
    set text(size: 0.7em, fill: self.colors.neutral-light)
    pad(
      bottom: 0.15in,
      components.left-and-right(
        utils.call-or-display(self, self.store.footer),
        context utils.slide-counter.display()
          + " / "
          + utils.last-slide-number,
      ),
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(header: header, footer: footer),
  )
  let new-setting = body => {
    set text(fill: self.colors.neutral-darkest)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


/// Vertical geometry of the title slide, as explicit fixed buffers.
///
/// The stack is anchored to the top of the content area rather than centred, so
/// each buffer is literally the gap it claims to be; `top` is set so the orange
/// rule lands on the vertical centre of the page, and whatever height is left
/// over falls below the last detail line.
#let title-slide-unit = 6pt
#let title-slide-pad = (
  top: 15 * title-slide-unit,   //  90pt: content top -> title (puts the rule on center)
  pair: 5 * title-slide-unit,   //  30pt: title -> subtitle
  rule: 3 * title-slide-unit,   //  18pt: subtitle -> orange rule
  group: 16 * title-slide-unit, //  96pt: orange rule -> first detail line
  line: 4 * title-slide-unit,   //  24pt: between the detail lines
)


/// Title slide. Fill the details via `config-info(..)` or pass them here:
///   #title-slide(subtitle: [..], author: [..], date: [..])
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  let info = self.info + args.named()
  let pad = title-slide-pad
  // only the detail lines that exist, so `pad.line` never leaves trailing gaps
  let details = (
    info.author,
    if info.date != none { utils.display-info-date(self) } else { none },
    info.institution,
    info.contact,
  ).filter(line => line != none)
  let body = {
    // top-anchored: see `title-slide-pad`: the buffers below are the gaps
    set align(top)
    block(width: 100%, {
      v(pad.top)
      set text(
        // title size; the subtitle and the detail lines are 3/4 of it, so they
        // take `0.75em` here
        size: 2.1em,
        weight: "bold",
        fill: self.colors.neutral-darkest,
        font: self.store.title-font,
      )
      block(above: 0pt, below: 0pt, info.title)
      if info.subtitle != none {
        set text(size: 0.75em, fill: self.colors.neutral-light)
        v(pad.pair)
        block(above: 0pt, below: 0pt, info.subtitle)
      }
      v(pad.rule)
      // orange bar echoing the sidebar, sitting on the line above it
      block(
        above: 0pt, below: 0pt,
        width: 3in, height: 4pt, fill: self.colors.primary, spacing: 0pt,
      )
      if details.len() > 0 {
        v(pad.group)
        set text(size: 0.75em, fill: self.colors.neutral-darkest)
        for (i, line) in details.enumerate() {
          if i > 0 { v(pad.line) }
          block(above: 0pt, below: 0pt, spacing: pad.line, line)
        }
      }
    })
  }
  touying-slide(self: self, setting: align.with(left + top), body)
})


/// Section divider, shown automatically for every level-1 heading.
#let new-section-slide(config: (:), body) = touying-slide-wrapper(self => {
  let setting(body) = {
    set align(horizon)
    block(width: 100%, {
      set text(
        size: 1.9em,
        weight: "bold",
        fill: self.colors.neutral-darkest,
        font: self.store.title-font,
      )
      utils.display-current-heading(level: 1)
      v(0.8em)
      block(width: 2.2in, height: 4pt, fill: self.colors.primary, spacing: 0pt)
      if body != none {
        v(0.8em)
        set text(size: 0.8em, fill: self.colors.neutral-light)
        body
      }
    })
  }
  touying-slide(self: self, config: config, setting: setting, body)
})


/// Big centered statement. Keeps the sidebar background.
#let focus-slide(
  config: (:),
  alignment: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  touying-slide(
    self: self,
    config: config,
    setting: it => align(
      alignment,
      text(fill: self.colors.neutral-darkest, size: 1.6em, weight: "bold", it),
    ),
    body,
  )
})


/// Table of contents (sections only).
#let outline-slide(config: (:), title: [Outline], depth: 1) = {
  slide(config: config, title: title)[
    #set text(size: 0.8em)
    #outline(title: none, depth: depth)
  ]
}


/// Speaker-note panel styled to match (orange header strip).
#let notes(self: none, ..args) = touying-notes(
  self: self,
  header: self => pad(
    x: 24pt,
    y: 12pt,
    text(fill: self.colors.neutral-lightest, utils.display-current-heading(depth: self.slide-level)),
  ),
  header-fill: self.colors.primary,
  fill: self.colors.neutral-lightest,
  ..args,
)


/// Register the theme. Example:
///
/// ```typst
/// #show: sidebar-theme.with(
///   config-info(
///     title: [Deck title],
///     author: [You],
///     date: datetime.today(),
///   ),
/// )
/// ```
///
/// - footer (content, function, auto): bottom-left of every slide.
///   `auto` shows the current section title (nothing before the first
///   `= heading`).
/// - header-right (content, function): top-right of every slide.
///   Default is `self.info.logo`.
/// - margin (dictionary): page margins; the left margin keeps content
///   clear of the 0.7" sidebar.
/// - background (content, str, auto): full-page background. `auto` uses
///   `template.svg` next to this file; a string is an image path (relative
///   to this file); pass `none` for a plain white deck.
#let sidebar-theme(
  footer: auto,
  header-right: self => self.info.logo,
  margin: (left: 1.25in, right: 0.85in, top: 1.6in, bottom: 0.95in),
  background: auto,
  // fonts: each entry falls back to the next if unavailable
  body-font: ("Iosevka SS07", "Libertinus Serif"),
  title-font: ("Iosevka SS07", "Libertinus Serif"),
  code-font: ("Iosevka SS07", "Iosevka Term SS07", "DejaVu Sans Mono"),
  ..args,
  body,
) = {
  // NB: don't `set`/`show` anything in this leading region: otherwise we get
  // blank leading pages, as in touying#394

  let background = {
    if background == auto {
      image("template.svg", width: 100%)
    } else if type(background) == str {
      image(background, width: 100%)
    } else {
      background
    }
  }
  let footer = if footer == auto {
    // current section title (empty before the first `= heading`)
    self => utils.display-current-heading(level: 1)
  } else {
    footer
  }

  show: touying-slides.with(
    // 16in x 9in so the SVG lands at its designed scale (sidebar = 0.7").
    // Explicit width/height override touying's default 10in "presentation-16-9".
    config-page(
      width: 16in,
      height: 9in,
      margin: margin,
      fill: white,
      background: background,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      notes-fn: notes,
      // keep header/footer inside the margins so they don't run over the sidebar
      zero-margin-header: false,
      zero-margin-footer: false,
      // `*bold*` stays ink-colored text; use `#alert[..]` for orange emphasis
      show-strong-with-alert: false,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 26pt, font: body-font)
        show raw: set text(font: code-font)
        body
      },
      alert: (self: none, it) => text(
        fill: self.colors.accent,
        weight: "semibold",
        it,
      ),
    ),
    config-colors(
      // roles mapped from the brand palette (palette.typ)
      primary: palette.orange,          // sidebar / accents
      secondary: palette.purple,        // the palette's anchor color
      neutral-light: palette.gray-dark, // meta text (footer, …)
      neutral-lightest: rgb("#FFFFFF"),
      neutral-darkest: palette.ink,     // body text
      accent: palette.accent,           // #alert emphasis
    ),
    config-store(
      footer: footer,
      header-right: header-right,
      title-font: title-font,
    ),
    ..args,
  )

  body
}
