// Brookhaven National Laboratory theme for Touying 0.7.4.
// The geometry and supplied raster assets follow bnl-ppt-template-standard.potx.

#import "@preview/touying:0.7.4": *

#let bnl-deep-teal = rgb("#105C78")
#let bnl-cyan = rgb("#00ADDC")
#let bnl-lime = rgb("#B2D33B")
#let bnl-orange = rgb("#F68B1F")
#let bnl-magenta = rgb("#B72467")
#let bnl-gold = rgb("#FFCD34")

#let _page-background(path) = image(
  path,
  width: 100%,
  height: 100%,
  fit: "stretch",
)

#let _display-author(self, author) = {
  if type(author) == array {
    author.join(", ")
  } else {
    utils.call-or-display(self, author)
  }
}

#let _display-date(self, date) = {
  if type(date) == datetime {
    date.display("[month repr:long] [day], [year]")
  } else {
    utils.call-or-display(self, date)
  }
}

/// Standard BNL content slide.
///
/// Use a level-two heading for the common case, or call
/// `#slide(title: [Title])[Body]` directly. Multiple bodies use Touying's
/// normal column composer.
#let slide(
  title: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  } else {
    self.store.title = none
  }
  if align != auto {
    self.store.align = align
  }

  let header(self) = {
    set std.align(left + top)
    // Display headings use a tighter rhythm than normal slide content.
    set par(leading: 0.3em, spacing: 0.4em)
    pad(
      top: 0.91in,
      text(
        font: "Arial",
        size: 36pt,
        weight: "bold",
        fill: black,
        if self.store.title != none {
          utils.call-or-display(self, self.store.title)
        } else {
          utils.display-current-heading(level: 2, style: auto)
        },
      ),
    )
  }

  let footer(self) = {
    set std.align(right + bottom)
    pad(
      right: 0.03in,
      bottom: 0.27in,
      text(
        font: "Arial",
        size: 7.5pt,
        fill: black,
        context utils.slide-counter.display(),
      ),
    )
  }

  self = utils.merge-dicts(
    self,
    config-page(
      fill: white,
      background: _page-background("assets/bnl-content.png"),
      header: header,
      footer: footer,
      margin: (
        top: 1.76in,
        bottom: 0.82in,
        left: 0.57in,
        right: 0.48in,
      ),
      header-ascent: 0in,
      footer-descent: 0in,
    ),
  )

  let slide-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }

  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: slide-setting,
    composer: composer,
    ..bodies,
  )
})

/// BNL title slide. Set `print-friendly: true` for the white alternative.
#let title-slide(
  print-friendly: false,
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let foreground = if print-friendly { black } else { white }
  let social = if print-friendly {
    "assets/bnl-social-gray.png"
  } else {
    "assets/bnl-social-white.png"
  }
  let background = if print-friendly {
    "assets/bnl-title-print.png"
  } else {
    "assets/bnl-title.png"
  }

  self = utils.merge-dicts(
    self,
    config,
    config-common(detect-overflow: false),
    config-page(
      fill: white,
      background: _page-background(background),
      header: none,
      footer: none,
      margin: 0in,
    ),
  )

  let body = {
    // Preserve compact display spacing for the fixed title-slide layout.
    set par(leading: 0.3em, spacing: 0.4em)
    place(
      top + left,
      dx: 0.77in,
      dy: 2.93in,
      block(
        width: 8.15in,
        text(
          font: "Arial",
          size: 48pt,
          weight: "bold",
          fill: foreground,
          info.title,
        ),
      ),
    )
    if info.subtitle != none {
      place(
        top + left,
        dx: 0.78in,
        dy: 3.82in,
        block(
          width: 8in,
          text(font: "Arial", size: 24pt, fill: foreground, info.subtitle),
        ),
      )
    }
    if info.author != none {
      place(
        top + left,
        dx: 0.78in,
        dy: 5.02in,
        text(
          font: "Arial",
          size: 24pt,
          fill: foreground,
          _display-author(self, info.author),
        ),
      )
    }
    if info.date != none {
      place(
        top + left,
        dx: 0.78in,
        dy: 6.39in,
        text(
          font: "Arial",
          size: 18pt,
          fill: foreground,
          _display-date(self, info.date),
        ),
      )
    }
    place(
      top + left,
      dx: 5.99in,
      dy: 6.37in,
      image(social, width: 3.33in),
    )
  }

  touying-slide(self: self, body)
})

#let _section-slide(self, title, subtitle: none, print-friendly: false, config: (:)) = {
  let foreground = if print-friendly { black } else { white }
  let background = if print-friendly {
    "assets/bnl-section-print.png"
  } else {
    "assets/bnl-section.png"
  }

  let footer(self) = {
    set std.align(right + bottom)
    pad(
      right: 0.48in,
      bottom: 0.27in,
      text(
        font: "Arial",
        size: 7.5pt,
        fill: black,
        context utils.slide-counter.display(),
      ),
    )
  }

  self = utils.merge-dicts(
    self,
    config,
    config-common(detect-overflow: false),
    config-page(
      fill: white,
      background: _page-background(background),
      header: none,
      footer: footer,
      margin: 0in,
      footer-descent: 0in,
    ),
  )

  let body = {
    // Preserve compact display spacing for the fixed section-slide layout.
    set par(leading: 0.3em, spacing: 0.4em)
    place(
      top + left,
      dx: 0.78in,
      dy: 2.93in,
      block(
        width: 8.2in,
        text(
          font: "Arial",
          size: 48pt,
          weight: "bold",
          fill: foreground,
          title,
        ),
      ),
    )
    if subtitle != none {
      place(
        top + left,
        dx: 0.78in,
        dy: 5.01in,
        block(
          width: 8.1in,
          text(font: "Arial", size: 24pt, fill: foreground, subtitle),
        ),
      )
    }
  }
  touying-slide(self: self, body)
}

/// Manual section divider with optional subtitle and print-friendly styling.
#let section-slide(
  title,
  subtitle: none,
  print-friendly: false,
  config: (:),
) = touying-slide-wrapper(self => {
  _section-slide(
    self,
    title,
    subtitle: subtitle,
    print-friendly: print-friendly,
    config: config,
  )
})

/// Automatic section divider used for level-one headings.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: false,
  body,
) = touying-slide-wrapper(self => {
  _section-slide(
    self,
    utils.display-current-heading(level: level, numbered: numbered),
    config: config,
  )
})

/// BNL theme entry point. The supplied master artwork is designed for 4:3.
#let bnl-theme(
  aspect-ratio: "4-3",
  align: top,
  ..args,
  body,
) = {
  assert(
    aspect-ratio == "4-3",
    message: "The BNL master artwork is fixed to a 4:3 aspect ratio.",
  )
  show: touying-slides.with(
    config-page(
      width: 10in,
      height: 7.5in,
      fill: white,
      background: _page-background("assets/bnl-content.png"),
      margin: (
        top: 1.76in,
        bottom: 0.82in,
        left: 0.57in,
        right: 0.48in,
      ),
      header-ascent: 0in,
      footer-descent: 0in,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      breakable: false,
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "Arial", size: 24pt, fill: black)
        // Comfortable content-slide rhythm without the document-oriented
        // looseness of Typst's defaults. Display slides override this locally.
        set par(leading: 0.45em, spacing: 0.55em)
        set list(
          marker: [•],
          indent: 0.19in,
          body-indent: 0.16in,
          spacing: 0.22em,
        )
        show list: it => {
          // Scale hierarchy gently and give nested lists explicit separation.
          set text(size: 0.92em)
          v(0.08em, weak: false)
          it
          v(0.06em, weak: false)
        }
        show heading.where(level: 3): set text(
          font: "Arial",
          size: 20pt,
          weight: "bold",
          fill: self.colors.primary,
        )
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: bnl-deep-teal,
      secondary: bnl-cyan,
      tertiary: bnl-lime,
      neutral-lightest: white,
      neutral-darkest: black,
    ),
    config-store(
      align: align,
      title: none,
      orange: bnl-orange,
      magenta: bnl-magenta,
      gold: bnl-gold,
    ),
    ..args,
  )
  body
}
