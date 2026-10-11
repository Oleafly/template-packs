#import "@preview/touying:0.6.1": *
#import "../components/cube_position.typ": *

// -----------------------------------------------------------------------------
// Base Configuration
// -----------------------------------------------------------------------------

#let footer = config-page(
  footer: self => {
    set text(size: 10pt, fill: self.colors.text)
    let short-title = if self.info.short-title != auto {
      self.info.short-title
    } else {
      self.info.title
    }

    // Extract dynamic footer logo if available in the theme
    let logo-content = if "logo-header" in self.store.graphics and self.store.graphics.logo-header != none {
      (self.store.graphics.logo-header)()
    }

    align(bottom, block(width: 100%, height: 40pt, inset: 8pt, fill: self.colors.white, grid(
      align: (center + horizon, left + horizon, left + horizon, center + horizon, left + horizon),
      columns: (4%, 1fr, auto, 4%),
      column-gutter: 1em,
      logo-content,
      block(width: 100%)[#short-title --- #self.info.authors.at(0).name],
      self.info.conference + [ --- ] + utils.display-info-date(self),
      block(width: 100%, height: 100%, text(
        weight: "bold",
        fill: self.colors.primary,
        context utils.slide-counter.display("1/1", both: true),
      )),
    )))
  },
  footer-descent: 0%,
  margin: (bottom: 20pt + 5%),
)

#let header = config-page(
  header: self => {
    set text(weight: "bold", fill: self.colors.primary, size: 28pt)
    let title = if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2, numbered: false)
    }

    align(top, block(width: 100%, height: 300pt, fill: self.colors.white, {
      if "slide-header-bg" in self.store.graphics and self.store.graphics.slide-header-bg != none {
        (self.store.graphics.slide-header-bg)()
      }
      block(height: 100%, width: 100%, inset: 1em, title)
    }))
  },
  header-ascent: 0%,
  margin: (top: 50pt + 5%),
)

// -----------------------------------------------------------------------------
// Slide Layouts
// -----------------------------------------------------------------------------

#let title-slide(config: (:)) = touying-slide-wrapper(self => {
  let get-affs(person) = {
    let affs = person.at("affiliations", default: person.at("affiliation", default: ()))
    if type(affs) == array {
      affs
    } else if affs != none and affs != "" {
      (affs,)
    } else {
      ()
    }
  }

  let all-affs = (
    self.info.authors.map(get-affs).flatten() + self.info.supervisors.map(get-affs).flatten()
  ).dedup()

  let auths = self
    .info
    .authors
    .enumerate()
    .map(((i, author)) => {
      let name = if i == 0 { underline(author.name) } else { author.name }
      let aff-indices = get-affs(author).map(aff => str(all-affs.position(a => a == aff) + 1))
      name + if aff-indices.len() > 0 { super(typographic: false, aff-indices.join(",")) } else { "" }
    })
  let fmt-auths = auths.join([, ], last: [ & ])

  let sups = self.info.supervisors.map(sup => {
    let aff-indices = get-affs(sup).map(aff => str(all-affs.position(a => a == aff) + 1))
    sup.name + if aff-indices.len() > 0 { super(typographic: false, aff-indices.join(",")) } else { "" }
  })
  let fmt-supervisors = sups.join([, ], last: [ & ])

  let fmt-affs = all-affs
    .enumerate()
    .map(((i, aff)) => {
      super(typographic: false, str(i + 1)) + [ ] + aff
    })
    .join[\ ]

  let logo-content = if "logo-slide" in self.store.graphics and self.store.graphics.logo-slide != none {
    (self.store.graphics.logo-slide)()
  }

  let body = {
    set text(fill: self.colors.text)
    stack(
      dir: ttb,
      spacing: 5%,
      logo-content,
      v(10%),
      text(size: 36pt, weight: "bold", self.info.title),
      text(size: 24pt, self.info.subtitle),
      v(1fr),
      text(size: 18pt, fmt-auths),
      if fmt-supervisors != "" { text(size: 16pt, fill: luma(140), "Supervised by " + fmt-supervisors) },
      v(0.5fr),
      text(size: 12pt, fmt-affs),
      text(size: 12pt, {
        box(width: 1fr, repeat(" "))
        self.info.conference + [ --- ] + utils.display-info-date(self)
      }),
    )
  }

  let background-content = if "title-slide-bg" in self.store.graphics and self.store.graphics.title-slide-bg != none {
    (self.store.graphics.title-slide-bg)()
  }

  let background = config-page(fill: self.colors.white, background: background-content)
  self = utils.merge-dicts(self, background, config)
  touying-slide(self: self, body)
})

#let end-slide(config: (:), thanks: "Thank you for your attention", questions: "Questions?") = touying-slide-wrapper(
  self => {
    let main-author = self.info.authors.at(0)
    let logo-content = if "logo-slide" in self.store.graphics and self.store.graphics.logo-slide != none {
      (self.store.graphics.logo-slide)()
    }

    let body = {
      set text(fill: self.colors.text)
      stack(
        dir: ttb,
        spacing: 5%,
        logo-content,
        v(10%),
        text(size: 36pt, weight: "bold", thanks),
        text(size: 24pt, weight: "bold", questions),
        v(1fr),
        text(size: 16pt, {
          [
            #text(weight: "bold")[#main-author.affiliations.at(0)] \
            #main-author.name \
            #link("mailto:" + main-author.email)
          ]
        }),
        text(size: 12pt, {
          box(width: 1fr, repeat(" "))
          self.info.conference + [ --- ] + utils.display-info-date(self)
        }),
      )
    }

    let background-content = if "end-slide-bg" in self.store.graphics and self.store.graphics.end-slide-bg != none {
      (self.store.graphics.end-slide-bg)()
    }

    let background = config-page(fill: self.colors.white, background: background-content)
    self = utils.merge-dicts(self, background, config)
    touying-slide(self: self, body)
  }
)

#let outline-slide(title: auto, config: (:)) = touying-slide-wrapper(
  self => {
    if title == auto {
      self.store.title = "Contents"
    } else {
      self.store.title = title
    }

    let outline = {
      show outline.entry: it => {
        let prefix = (
          text(size: 20pt, weight: "bold", fill: self.colors.primary, str(
            counter(heading).at(it.element.location()).at(0),
          ))
            + text(size: 8pt, fill: self.colors.primary, sym.square.filled)
        )
        let inner = text(size: 20pt, weight: "bold", fill: self.colors.text, it.element.body)
        set block(spacing: 2em)
        link(it.element.location(), it.indented(prefix, inner))
      }
      align(top, block(outline(title: "", target: heading.where(level: 1))))
    }

    self = utils.merge-dicts(self, footer, header, config)
    touying-slide(self: self, outline)
  }
)

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  set align(bottom)

  let body-stack = stack(
    dir: ttb,
    grid(
      align: (right + bottom, right + bottom, left + horizon),
      columns: (0.22fr, auto, 0.7fr),
      column-gutter: (1pt, 3em),
      text(weight: "bold", size: 128pt, fill: self.colors.primary, utils.display-current-heading-number(
        level: 1,
        numbering: "1",
      )),
      text(weight: "bold", size: 48pt, fill: self.colors.primary, sym.square.filled),
      text(weight: "bold", size: 64pt, utils.display-current-heading(level: 1, numbered: false)),
    ),
    v(75pt + 5em),
  )

  let background-content = if "section-slide-bg" in self.store.graphics and self.store.graphics.section-slide-bg != none {
    (self.store.graphics.section-slide-bg)()
  }

  let background = config-page(fill: self.colors.white, background: background-content)
  self = utils.merge-dicts(self, footer, background)
  set text(fill: self.colors.text)
  touying-slide(self: self, body-stack)
})

#let slide(title: auto, config: (:), ..bodies) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  self = utils.merge-dicts(self, footer, header, config)
  set text(fill: self.colors.text, size: 14pt)
  touying-slide(self: self, ..bodies)
})

// -----------------------------------------------------------------------------
// Main Slides Template Definition
// -----------------------------------------------------------------------------

#let slides(
  theme: none,
  aspect-ratio: "16-9",
  lang: "en",
  ..args,
  body,
) = {
  assert(theme != none, message: "A theme dictionary must be explicitly provided to the `slides` template.")

  let t-colors = theme.at("colors", default: (:))
  let t-fonts = theme.at("fonts", default: (:))
  let t-graphics = theme.at("graphics", default: (:))

  let text-font = t-fonts.at("main", default: "Poppins")
  let math-font = t-fonts.at("math", default: "Libertinus Math")
  let code-font = t-fonts.at("code", default: "Geist Mono")

  let colors = config-colors(
    text: t-colors.at("text", default: rgb("#000000")),
    black: t-colors.at("black", default: rgb("#000000")),
    white: t-colors.at("white", default: rgb("#FFFFFF")),
    primary: t-colors.at("primary", default: rgb("#E50019")),
    secondary: t-colors.at("secondary", default: rgb("#FFCD31")),
    complementary-dark: t-colors.at("complementary-dark", default: rgb("#3E4A83")),
    complementary-light: t-colors.at("complementary-light", default: rgb("#7E9CBB")),
  )

  let store = config-store(
    title: none,
    graphics: t-graphics,
  )

  let page = config-page(paper: "presentation-" + aspect-ratio)
  let common = config-common(
    slide-fn: slide,
    new-section-slide-fn: new-section-slide,
    datetime-format: "[year]-[month]-[day]",
  )

  show: touying-slides.with(page, common, colors, store, ..args)

  show math.equation: set text(font: math-font)

  show raw.where(block: false): set text(font: code-font, size: 12pt)
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show raw.where(block: true): set text(font: code-font, size: 12pt)
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  set heading(numbering: "1.")
  set text(lang: lang, font: text-font)

  set list(marker: x => {
    let primary-color = t-colors.at("primary", default: rgb("#E50019"))
    let markers = (text(fill: primary-color, sym.square.filled), sym.square.filled)
    markers.at(calc.min(x, markers.len() - 1))
  })

  set enum(full: true, numbering: (..n) => {
    let primary-color = t-colors.at("primary", default: rgb("#E50019"))
    let level = n.pos().len()
    if level == 1 {
      text(fill: primary-color)[*#n.pos().at(level - 1).*]
    } else if level == 2 {
      [*#n.pos().at(level - 1).*]
    } else {
      [#n.pos().at(level - 1).]
    }
  })

  body
}