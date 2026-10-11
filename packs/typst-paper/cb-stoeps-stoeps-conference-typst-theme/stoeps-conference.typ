// Stoeps Conference theme
// Based on the University theme by Pol Dellaiera - https://github.com/drupol

//#import "../src/exports.typ": *
#import "@preview/touying:0.7.0": *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.4.1": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/chronos:0.3.0": *
#import "@preview/zeitline:0.1.0": timeline
#import cosmos.clouds: *

/// Helper function for rendering keyboard key badges.
#let kbd(key) = box(
  fill: rgb(245, 245, 245),
  stroke: 1pt + rgb(200, 200, 200),
  radius: 3pt,
  inset: (x: 15pt, y: 10pt),
  baseline: 25%,
  text(font: "CaskaydiaCove NFM", size: 0.8em, weight: "medium", key),
)

/// Sidebar displayed vertically along the right edge of each slide.
/// The text is set via config-store(sidebar-text: "...") in your presentation file.
#let sidebar(content) = {
  let chars = content.clusters()
  align(right + horizon, box(
    inset: 6pt,
    width: auto,
    height: auto,
    stack(
      dir: ttb,
      spacing: 4pt,
      ..chars.map(c => align(center, text(size: 14pt, fill: luma(200), c))),
    ),
  ))
}

#let no-sidebar(body, restore: none) = {
  show: touying-set-config.with(config-store(sidebar-text: none))
  body
  show: touying-set-config.with(config-store(sidebar-text: restore))
}

#let image-slide(body, background: none) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      background: background,
      margin: 2em,
    ),
  )
  touying-slide(self: self, {
    set text(fill: self.colors.neutral-lightest, size: 2em)
    set image(width: 100%, height: auto)
    align(horizon + center, body)
  })
})

#let image-slide-cropped(body, image-path: none, quarter: "top-left", dx: 0%, dy: 0%) = touying-slide-wrapper(self => {
  let path = if image-path != none { image-path } else { self.image-path }
  let (h-align, v-align) = if quarter == "top-left"     { (left,  top)    }
                       else if quarter == "top-right"    { (right, top)    }
                       else if quarter == "bottom-left"  { (left,  bottom) }
                       else if quarter == "bottom-right" { (right, bottom) }
                       else                              { (left,  top)    }
  let bg = box(
    width: 100%,
    height: 100%,
    clip: true,
    align(h-align + v-align,
      image(path, width: 200%, height: 200%, fit: "contain")
    )
  )
  self = utils.merge-dicts(self, config-page(background: bg, margin: 2em))
  touying-slide(self: self, {
    set text(fill: self.colors.neutral-lightest, size: 2em)
    align(horizon + center, body)
  })
})

#let adm-colors = (
  info: (icon: rgb("#1a6fa8"), body: rgb("#eef5fb")),
  idea: (icon: rgb("#c47f0a"), body: rgb("#fdf8ec")),
  warning: (icon: rgb("#a82020"), body: rgb("#fdf0f0")),
)

#let adm-icons = (
  info: fa-circle-info(),
  idea: fa-lightbulb(),
  warning: fa-triangle-exclamation(),
)

#let admonition(kind: "info", body) = {
  let colors = adm-colors.at(kind)
  let icon = adm-icons.at(kind)
  let strip-width = 2.2em

  // Render the body first so the outer box sizes to it
  box(
    radius: 6pt,
    clip: true,
    width: 100%,
    fill: colors.body,
    // Left icon strip, stretched via place
    {
      place(
        left + top,
        dx: 0pt,
        dy: 0pt,
        box(
          fill: colors.icon,
          width: strip-width,
          height: 100%,
        ),
      )
      // Icon centred over the strip
      place(
        left + horizon,
        dx: 0pt,
        dy: 0pt,
        box(
          width: strip-width,
          height: 100%,
          align(center + horizon, text(fill: rgb("#fafafa"), size: 1.1em, move(
            dy: -3pt,
            icon,
          ))),
        ),
      )
      // Body text, padded so it clears the icon strip
      pad(
        left: strip-width + 10pt,
        top: 14pt,
        bottom: 14pt,
        right: 10pt,
        text(size: 0.9em, body),
      )
    },
  )
}

#pdfpc.config(
  duration-minutes: 45,
  start-time: datetime(hour: 15, minute: 0, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "box",
    duration-seconds: 1,
    angle: rtl,
    alignment: "vertical",
    direction: "outward",
  ),
)

#let info(body) = admonition(kind: "info", body)
#let idea(body) = admonition(kind: "idea", body)
#let warning(body) = admonition(kind: "warning", body)
// Default slide function for the presentation.
///
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 3mm,
      if self.store.progress-bar {
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.tertiary,
        )
      },
      block(
        inset: (x: 0.7em, y: 0.5em),
        components.left-and-right(
          text(
            fill: self.colors.primary,
            weight: "bold",
            size: 1.2em,
            utils.call-or-display(self, self.store.header),
          ),
          if self.store.logo-on-slides and self.info.logo != none {
            set image(height: 0.8em)
            self.info.logo
          } else {
            text(fill: self.colors.primary.lighten(65%), utils.call-or-display(
              self,
              self.store.header-right,
            ))
          },
        ),
      ),
    )
  }
  let footer = if (
    self.store.footer != auto and type(self.store.footer) == function
  ) {
    self.store.footer
  } else {
    let footer(self) = {
      set std.align(center + bottom)
      set text(size: .4em)
      {
        let cell(..args, it) = components.cell(
          ..args,
          inset: 1mm,
          std.align(horizon, text(fill: gray, it)),
        )
        show: block.with(width: 100%, height: auto)
        grid(
          columns: self.store.footer-columns,
          rows: 1.5em,
          cell(fill: self.colors.neutral-lightest, utils.call-or-display(
            self,
            self.store.footer-a,
          )),
          cell(fill: self.colors.neutral-lightest, utils.call-or-display(
            self,
            self.store.footer-b,
          )),
          cell(fill: self.colors.neutral-lightest, utils.call-or-display(
            self,
            self.store.footer-c,
          )),
        )
      }
    }
    footer
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
      foreground: if self.store.sidebar-text != none {
        sidebar(self.store.sidebar-text)
      },
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
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


/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    if info.logo != none {
      place(top + right, dx: 0.5cm, dy: -1.5cm, text(
        fill: self.colors.primary,
        info.logo,
      ))
    }
    std.align(
      center + horizon,
      {
        block(
          inset: 0em,
          breakable: false,
          {
            text(size: 2em, fill: self.colors.primary, strong(info.title))
            if info.subtitle != none {
              parbreak()
              text(size: 1.2em, fill: self.colors.primary, info.subtitle)
            }
          },
        )
        set text(size: .8em)
        grid(
          columns: (1fr,) * calc.min(info.authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..info.authors.map(author => text(
            fill: self.colors.neutral-darkest,
            author,
          ))
        )
        v(1em)
        if info.institution != none {
          parbreak()
          text(size: .9em, info.institution)
        }
        if info.date != none {
          parbreak()
          text(size: .8em, utils.display-info-date(self))
        }
      },
    )
  }
  touying-slide(self: self, body)
})


/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
///
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: self.colors.primary, weight: "bold")
    stack(
      dir: ttb,
      spacing: .65em,
      utils.display-current-heading(level: level, numbered: numbered),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
    body
  }
  touying-slide(self: self, config: config, slide-body)
})


/// Focus on some content.
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
    config-page(margin: 1em, ..args),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em)
  touying-slide(self: self, std.align(horizon, body))
})


// Create a slide where the provided content blocks are displayed in a grid and coloured in a checkerboard pattern without further decoration. You can configure the grid using the rows and `columns` keyword arguments (both default to none). It is determined in the following way:
///
#let matrix-slide(
  config: (:),
  columns: none,
  rows: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(
    self: self,
    config: config,
    composer: components.checkerboard.with(columns: columns, rows: rows),
    ..bodies,
  )
})


#let stoeps-conference-theme(
  aspect-ratio: "16-9",
  align: top,
  progress-bar: true,
  header: utils.display-current-heading(level: 2, style: auto),
  header-right: self => (
    box(utils.display-current-heading(level: 1)) + h(.3em) + self.info.logo
  ),
  footer: auto,
  footer-columns: (25%, 1fr, 25%),
  footer-a: self => {
    self.info.author
  },
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    h(1fr)
    utils.display-info-date(self)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
    h(1fr)
  },
  sidebar-text: none,
  logo-on-slides: false,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 2em, bottom: 1.25em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt, fill: self.colors.neutral-darkest)
        set page(fill: self.colors.neutral-lightest)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        show heading.where(level: 4): set text(fill: self.colors.primary)

        // Font of normal text
        set text(font: "Lato")
        // Font for source code
        show raw: set text(font: "Hack Nerd Font Mono")
        // show raw.where(block: true): it => block(
        //   fill: luma(240),
        //   radius: 6pt,
        //   width: 100%,
        //   inset: (x: 14pt, y: 10pt),
        //   {
        //     set text(size: 14pt)
        //     it
        //   },
        // )
        show raw.where(block: true): it => block(
          fill: luma(240),
          radius: 6pt,
          width: 100%,
          inset: (x: 14pt, y: 10pt),
          {
            if it.lang != none {
              place(
                top + right,
                text(size: 10pt, fill: luma(130), it.lang)
              )
            }
            set text(size: 14pt)
            it
          },
        )
        show raw.where(block: false): set text(size: 1.0em, rgb(4, 98, 81))
        // Set caption font size
        show figure.caption: set text(size: .5em)
        show figure: it => {
          if it.kind == image {
            set image(fit: "cover")
            box(
              clip: true,
              radius: 6pt,
              it.body,
            )
            // still show caption etc.
            it.caption
          } else {
            it
          }
        }
        // Configure link color and add icon after links
        show link: it => [#text(fill: rgb(8, 106, 145), it)#h(
            0.1em,
          )#super[#text(
            fill: rgb(8, 106, 145),
            size: 0.4em,
            baseline: -0.8em,
          )[#fa-external-link()]]#h(0.2em)]

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#04364A"),
      secondary: rgb("#176B87"),
      tertiary: rgb("#448C95"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      progress-bar: progress-bar,
      header: header,
      header-right: header-right,
      footer: footer,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
      sidebar-text: sidebar-text,
      logo-on-slides: logo-on-slides,
    ),
    ..args,
  )

  body
}

