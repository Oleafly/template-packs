// MWIT Unofficial Presentation Theme for Touying
// Direct fork of clear-tub (TU Berlin) — MIT License
// This is an UNOFFICIAL theme — not affiliated with Mahidol Wittayanusorn School.

#import "@preview/touying:0.7.4": *

// --- MWIT Colors (oklch) ---
// Official brand: Mahidol Blue Pantone 286C, Mahidol Gold Pantone 123C
// MWIT shares the Mahidol University color identity.
// Blue = king, wisdom. Gold = science, imagination.

#let mwit-primary      = oklch(39.5%, 0.196, 263deg) // #0035AD  Pantone 286C
#let mwit-secondary    = oklch(84.1%, 0.157,  81deg) // #FEBF3A  Pantone 123C
#let mwit-tertiary     = oklch(64.5%, 0.146, 255deg) // #4A8FE4
#let mwit-primary-dark = oklch(30.6%, 0.150, 263deg) // #002379
#let mwit-text         = oklch(21.7%, 0.098, 262deg) // #001446
#let mwit-text-muted   = oklch(62.4%, 0.125,  85deg) // #AA800E  Pantone 1255C
#let mwit-bg           = oklch(96.7%, 0.015, 270deg) // #F0F4FF
#let mwit-surface      = oklch(97.8%, 0.032,  94deg) // #FFF8E0
#let mwit-white        = oklch(100%, 0.000,  90deg)  // #FFFFFF
#let mwit-black        = oklch(0%,   0.000,   0deg)  // #000000

// --- Content Helpers ---

#let mwit-block(title: none, body) = {
  block(
    width: 100%,
    clip: true,
    radius: 4pt,
    stroke: 0.5pt + mwit-text.lighten(70%),
    {
      if title != none {
        block(
          width: 100%,
          fill: mwit-primary-dark,
          inset: (x: 0.6em, y: 0.4em),
          text(fill: mwit-white, weight: "bold", size: 0.85em, title),
        )
      }
      block(
        width: 100%,
        fill: mwit-bg,
        inset: 0.6em,
        body,
      )
    },
  )
}

#let mwit-theorem(body) = mwit-block(title: [Theorem], body)
#let mwit-definition(body) = mwit-block(title: [Definition], body)
#let mwit-example(body) = mwit-block(title: [Example], body)

#let quote-block(attribution: none, body) = {
  block(
    width: 100%,
    inset: (left: 1em, y: 0.4em),
    stroke: (left: 3pt + mwit-secondary),
    {
      text(style: "italic", body)
      if attribution != none {
        v(0.3em)
        align(right, text(size: 0.75em, fill: mwit-text-muted, [--- #attribution]))
      }
    },
  )
}

#let alert-box(content) = {
  block(
    width: 100%,
    fill: mwit-surface,
    stroke: (left: 3pt + mwit-secondary),
    inset: 0.5cm,
    content,
  )
}

#let highlight-box(content) = {
  block(
    width: 100%,
    fill: mwit-surface,
    stroke: (left: 3pt + mwit-secondary),
    inset: 0.5cm,
    {
      set text(weight: "bold", fill: mwit-text)
      content
    },
  )
}

#let mwit-emphasis(body) = {
  text(fill: mwit-primary, weight: "bold", body)
}

#let slide-cite(body) = {
  footnote(body)
}

#let slide-ref(body) = {
  v(1fr)
  text(size: 0.55em, fill: mwit-text, body)
}

// --- Slide Functions ---

#let slide(
  title: auto,
  header: auto,
  footer: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  if header != auto {
    self.store.header = header
  }
  if footer != auto {
    self.store.footer = footer
  }
  let new-setting = body => {
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

#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: none),
  )
  let info = self.info + args.named()
  let body = {
    set align(center + horizon)

    if info.logo != none {
      set image(height: 1.5cm)
      info.logo
      v(0.8cm)
    }

    text(
      size: 2.7em,
      weight: "bold",
      fill: self.colors.primary,
      info.title,
    )

    if info.subtitle != none {
      v(0.2cm)
      text(size: 1.6em, weight: "bold", fill: self.colors.neutral-dark, info.subtitle)
    }

    v(0.2cm)

    if info.author != none {
      text(size: 1.2em, fill: self.colors.neutral-darkest, info.author)
    }

    if self.store.department != none {
      v(0.1cm)
      text(size: 1.0em, fill: self.colors.neutral-dark, self.store.department)
    }

    if info.date != none {
      v(0.1cm)
      text(
        size: 1.0em,
        fill: self.colors.neutral-dark,
        utils.display-info-date(self),
      )
    }
  }
  touying-slide(self: self, config: config, body)
})

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  let main-body = {
    set align(center + horizon)
    block(
      width: 100%,
      inset: 2em,
      {
        text(
          size: 2.3em,
          weight: "bold",
          fill: self.colors.primary,
          utils.display-current-heading(level: 1),
        )
      },
    )
  }
  touying-slide(self: self, main-body)
})

#let outline-slide(config: (:)) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(
      self,
      config-page(header: none, footer: none, margin: (top: 1.2em, bottom: 0.8em, x: 1.2em)),
    )
    let body = {
      set align(top)
      block(
        width: 100%,
        inset: (x: 2em, y: 1em),
        {
          components.progressive-outline(level: 1, depth: 1)
        },
      )
    }
    touying-slide(self: self, config: config, body)
  },
)

#let ending-slide(title: none, config: (:), body) = touying-slide-wrapper(
  self => {
    let main-body = {
      set align(center + horizon)
      if title != none {
        block(
          fill: self.colors.primary,
          radius: 8pt,
          inset: (x: 1.5em, y: 0.8em),
          text(
            size: 1.3em,
            weight: "bold",
            fill: self.colors.neutral-lightest,
            title,
          ),
        )
        v(1cm)
      }
      body
    }
    touying-slide(self: self, config: config, main-body)
  },
)

// --- Main Theme Function ---

#let mwit-unof-theme(
  aspect-ratio: "16-9",
  department: none,
  logo: none,
  serif: true,
  progress-bar: true,
  footer-height: 1.3em,
  footer-a-font-size: 0.7em,
  footer-b-font-size: 0.7em,
  footer-c-font-size: 0.7em,
  footer-a: self => self.info.author,
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    utils.display-info-date(self)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  },
  ..args,
  body,
) = {
  let _header(self) = {
    set align(top)
    set text(font: ("Noto Sans", "Noto Sans Thai"))
    block(
      width: 100%,
      inset: (x: 0.8em, y: 0.6em),
      fill: mwit-primary-dark,
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        {
          if self.store.title != none {
            text(
              size: 0.85em,
              weight: "bold",
              fill: mwit-white,
              utils.call-or-display(self, self.store.title),
            )
          } else {
            text(
              size: 0.85em,
              weight: "bold",
              fill: mwit-white,
              utils.display-current-heading(level: 2),
            )
          }
        },
        {
          if self.store.logo != none {
            set image(height: 0.8cm)
            self.store.logo
          }
        },
      ),
    )
  }

  let _footer(self) = {
    set text(font: ("Noto Sans", "Noto Sans Thai"))
    place(bottom + center,
      stack(
        dir: ttb,
        spacing: 0pt,
        if self.store.at("progress-bar", default: false) {
          components.progress-bar(
            height: 3pt,
            self.colors.primary,
            self.colors.tertiary,
          )
        },
          grid(
            columns: (1fr, 1fr, 1fr),
            rows: self.store.footer-height,
            rect(
              width: 100%, height: 100%,
              fill: self.colors.neutral-darkest,
              inset: (x: 0.8em, top: 0.5em, bottom: 0.5em), stroke: none,
              {
                set text(size: self.store.footer-a-font-size, fill: self.colors.neutral-lightest)
                align(center + horizon, utils.call-or-display(self, self.store.footer-a))
              },
            ),
            rect(
              width: 100%, height: 100%,
              fill: self.colors.primary,
              inset: (x: 0.8em, top: 0.5em, bottom: 0.5em), stroke: none,
              {
                set text(size: self.store.footer-b-font-size, fill: self.colors.neutral-lightest)
                align(center + horizon, utils.call-or-display(self, self.store.footer-b))
              },
            ),
            rect(
              width: 100%, height: 100%,
              fill: self.colors.neutral-darkest,
              inset: (x: 0.8em, top: 0.5em, bottom: 0.5em), stroke: none,
              {
                set text(size: self.store.footer-c-font-size, fill: self.colors.neutral-lightest)
                align(center + horizon, utils.call-or-display(self, self.store.footer-c))
              },
            ),
          ),
      ),
    )
  }

  let _bottom-margin = if footer-height == auto {
    2em
  } else {
    footer-height + 3pt + 0.8em
  }

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header: _header,
      footer: _footer,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 2.8em, bottom: _bottom-margin, x: 1.2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: if serif {("TH Sarabun New")} else {("Noto Sans", "Noto Sans Thai")}, size: 24pt, fill: self.colors.neutral-darkest)
        set par(leading: 0.55em)
        set list(marker: ("•", "◦", "▪"))
        set footnote.entry(separator: none, gap: 0.35em)
        show footnote.entry: set text(size: 0.75em, fill: mwit-text)
        set footnote(numbering: "1")
        show heading: set text(fill: self.colors.primary)
        set bibliography(style: "apa")
        show bibliography: set par(first-line-indent: 0in, hanging-indent: 6em)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: mwit-primary,
      primary-dark: mwit-primary-dark,
      secondary: mwit-secondary,
      tertiary: mwit-tertiary,
      neutral-lightest: mwit-white,
      neutral-light: mwit-bg,
      neutral-dark: mwit-text,
      neutral-darkest: mwit-black,
    ),
    config-store(
      title: none,
      department: department,
      logo: logo,
      progress-bar: progress-bar,
      footer-height: footer-height,
      footer-a-font-size: footer-a-font-size,
      footer-b-font-size: footer-b-font-size,
      footer-c-font-size: footer-c-font-size,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
    ..args,
  )

  body
}

// --- Focus slide ---

#let focus-slide(
  config: (:),
  background-color: none,
  background-img: none,
  body,
) = touying-slide-wrapper(self => {
  let background-color = if (
    background-img == none and background-color == none
  ) {
    rgb(self.colors.primary)
  } else {
    background-color
  }
  let args = (:)
  if background-color != none {
    args.fill = background-color
  }
  if background-img != none {
    args.background = {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    }
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(..args),
  )
  touying-slide(self: self, std.align(horizon, text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em, body)))
})

// --- Matrix slide ---

#let matrix-slide(
  config: (:),
  columns: none,
  rows: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
  )
  touying-slide(
    self: self,
    config: config,
    composer: components.checkerboard.with(columns: columns, rows: rows),
    ..bodies,
  )
})

// --- Bibliography slide ---

#let bibliography-slide(body) = touying-slide-wrapper(self => {
  touying-slide(
    self: self,
    pad(top: 1.5em, bottom: 0.5em, left: 2em, right: 2em, body)
  )
})
