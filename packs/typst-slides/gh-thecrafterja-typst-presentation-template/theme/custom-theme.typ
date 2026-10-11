#import "@preview/touying:0.6.1": *

// ---------------------------------------------------------------------------
// Custom Touying theme
//
// Provides a title slide, section slide, and the standard `slide` wrapper.
// Every content slide carries a footer with: logo, author, date, page number.
// ---------------------------------------------------------------------------

#let _accent = rgb("#1f3a5f")
#let _accent-light = rgb("#4a6d99")
#let _gray = rgb("#6b6b6b")

#let _sidebar-width = 4.2cm

// Persistent sidebar: level-1 section outline, current section highlighted.
#let _sidebar(self) = {
  place(
    left + top,
    block(width: _sidebar-width, height: 100%, inset: (top: 1.3cm, left: 0.9cm, right: 0.6cm))[
      #set text(size: 11pt)
      #set par(justify: false, leading: 0.65em)
      #components.custom-progressive-outline(
        self: self,
        level: auto,
        alpha: 45%,
        title: none,
        depth: 1,
        text-fill: (_accent,),
        text-weight: ("bold",),
        vspace: (0.55em,),
        indent: (0em,),
        filled: (false,),
        paged: (false,),
        short-heading: true,
      )
    ],
  )
}

// Footer shown on every slide: logo (left), author · date (center), page number (right).
#let _footer(self) = {
  set text(size: 10pt, fill: _gray)
  pad(left: _sidebar-width + 1.4cm, right: 1.4cm, bottom: 0.5cm)[
    #grid(
      columns: (1fr, 2fr, 1fr),
      align: (left, horizon + center, horizon + right),
      image("/assets/logo.svg", height: 0.6cm),
      [#self.info.author  -  #utils.display-info-date(self)],
      context utils.slide-counter.display() + " / " + utils.last-slide-number,
    )
  ]
}

// Standard content slide: title at top, sidebar at left, footer at bottom.
//
// `notes`: optional speaker notes (any content). When set, they are embedded
// as invisible pdfpc metadata via touying's `speaker-note()` — not visible in
// the PDF itself, but picked up by presenter apps like pympress or pdfpc once
// the deck is exported to a sidecar `.pdfpc` file (see the export command
// documented in main.typ).
#let slide(
  title: auto,
  align: auto,
  notes: none,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set std.align(top)
    _sidebar(self)
    let heading-title = if title != auto {
      title
    } else {
      utils.display-current-heading(depth: self.slide-level)
    }
    if heading-title != none {
      pad(left: _sidebar-width + 1.4cm, right: 1.4cm, top: 0.9cm)[
        #set text(size: 26pt, fill: _accent, weight: "bold")
        #block(above: 0em, below: 0.8em, heading-title)
        #line(length: 100%, stroke: 0.6pt + _accent-light)
      ]
    }
  }

  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: _footer,
      margin: (top: 1.6cm, bottom: 1.2cm, left: _sidebar-width + 1.4cm, right: 1.4cm),
    ),
  )

  let new-setting = body => {
    show: std.align.with(if align != auto { align } else { horizon })
    show: setting
    body
  }

  let bodies = if notes != none {
    let pos = bodies.pos()
    pos.slice(0, -1) + (pos.last() + speaker-note(notes),)
  } else {
    bodies.pos()
  }

  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

// Title slide: large title, subtitle, logo, author(s), date.
#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  let body = {
    set std.align(center + horizon)
    set text(fill: _accent)

    image("/assets/logo.svg", height: 2cm)
    v(0.8cm)

    text(size: 34pt, weight: "bold", info.title)
    if info.subtitle != none {
      v(0.3cm)
      text(size: 20pt, fill: _accent-light, info.subtitle)
    }

    v(1.5cm)
    set text(size: 16pt, fill: black)
    text(weight: "medium", info.author)
    linebreak()
    text(fill: _gray, utils.display-info-date(self))
  }

  touying-slide(self: self, body)
})

// Section divider slide.
// #let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
//   let slide-body = {
//     set std.align(center + horizon)
//     set text(size: 30pt, fill: _accent, weight: "bold")
//     utils.display-current-heading(level: level, numbered: numbered, style: auto)
//   }
//   touying-slide(self: self, config: config, slide-body)
// })

// Dedicated sources / bibliography slide, IEEE-numbered via Typst's bibliography().
#let sources-slide(bib-path) = {
  slide(title: "Sources")[
    #set text(size: 16pt)
    #set bibliography(title: none, style: "ieee")
    #bibliography(bib-path)
  ]
}

#let custom-theme(
  aspect-ratio: "16-9",
  align: horizon,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0%,
      footer-descent: 0%,
      margin: (top: 1.6cm, bottom: 1.2cm, x: 1.4cm),
    ),
    config-common(
      slide-fn: slide,
      //new-section-slide-fn: new-section-slide,
    ),
    ..args,
  )

  set text(font: "72 Brand", size: 20pt)
  set par(justify: true)
  show heading.where(level: 1): set text(fill: _accent, weight: "bold")
  show heading.where(level: 2): set text(fill: _accent-light, weight: "bold")

  body
}
