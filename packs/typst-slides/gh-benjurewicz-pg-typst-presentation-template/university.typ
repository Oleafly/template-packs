// This file is heavily based on:
// https://github.com/touying-typ/touying/blob/main/themes/university.typ
// University theme

// Originally contributed by Pol Dellaiera - https://github.com/drupol

#import "@preview/touying:0.7.2": *

// Helper to normalize authors into an array of structured dictionaries
// Each author should be (name: "...", surname: "...", email: "...")
#let _normalize-authors(authors) = {
  let authors = if type(authors) == array { authors } else if authors == none { () } else { (authors,) }
  authors.map(a => {
    if type(a) == dictionary { a } else { (name: "", surname: [#a], email: "") }
  })
}

// Format author for the title slide (Name Surname + Email)
#let _format-author-title(a) = {
  [#a.name #a.surname]
  if a.email != "" {
    [\ #text(size: 0.8em, a.email)]
  }
}

// Format authors for the footer
// 1 author: Full Name
// 2 authors: Full Names
// 3+ authors: Surnames only
#let _format-authors-footer(authors) = {
  let authors = _normalize-authors(authors)
  if authors.len() == 0 {
    none
  } else if authors.len() == 1 {
    let a = authors.at(0)
    [#a.name #a.surname]
  } else if authors.len() == 2 {
    authors.map(a => [#a.name #a.surname]).join(", ")
  } else {
    authors.map(a => a.surname).join(", ")
  }
}

#let _header(self) = {
  set std.align(top)
  grid(
    rows: (auto, auto),
    row-gutter: 0mm,
    if self.store.progress-bar {
      components.progress-bar(
        height: 2pt,
        self.colors.primary,
        self.colors.tertiary,
      )
    },
    block(
      width: 100%,
      inset: (x: 1.5em, y: 1.2em),
      components.left-and-right(
        {
          set std.align(horizon)
          stack(
            dir: ltr,
            spacing: .5em,
            if self.store.logo-in-header and self.info.logo-small != none { self.info.logo-small },
            if self.store.logo-in-header and self.info.logo-small != none {
              text(fill: self.colors.primary, weight: "bold", size: 1.3em, [|])
            },
            text(
              fill: self.colors.primary,
              weight: "bold",
              size: 1.4em,
              utils.call-or-display(self, self.store.header),
            ),
          )
        },
        text(fill: self.colors.primary.lighten(65%), utils.call-or-display(
          self,
          self.store.header-right,
        )),
      ),
    ),
  )
}

#let _footer(self) = {
  set std.align(center + bottom)
  set text(size: .4em)
  {
    let cell(..args, it) = components.cell(
      ..args,
      inset: 1mm,
      std.align(horizon, text(fill: white, it)),
    )
    show: block.with(width: 100%, height: auto)
    grid(
      columns: self.store.footer-columns,
      rows: 1.5em,
      cell(fill: self.colors.primary, _format-authors-footer(self.info.authors)),
      cell(fill: self.colors.tertiary, utils.call-or-display(
        self,
        self.store.footer-b,
      )),
      cell(fill: self.colors.secondary, utils.call-or-display(
        self,
        self.store.footer-c,
      )),
    )
  }
}

/// Default slide function for the presentation.
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
  let self = utils.merge-dicts(
    self,
    config-page(
      header: _header,
      footer: _footer,
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


/// Title slide for the presentation.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 1em),
    config,
  )
  let info = self.info + args.named()
  let authors = _normalize-authors(if "authors" in info { info.authors } else { info.author })

  let body = {
    set text(fill: white)
    std.align(
      center + horizon,
      {
        if info.logo != none {
          info.logo
          v(5mm)
        }
        block(
          inset: 0.5em,
          breakable: false,
          {
            text(size: 1.5em, weight: "bold", info.title)
            if info.subtitle != none {
              parbreak()
              text(size: 1.2em, info.subtitle)
            }
          },
        )
        v(1.5cm)
        set text(size: .8em)
        stack(
          dir: ttb,
          spacing: 1em,
          ..authors
            .chunks(3)
            .map(author-chunk => {
              grid(
                columns: (1fr,) * author-chunk.len(),
                column-gutter: 1em,
                ..author-chunk.map(author => _format-author-title(author))
              )
            }),
        )
        v(1.5cm)
        if info.date != none {
          parbreak()
          text(size: .8em, utils.display-info-date(self))
        }
      },
    )
  }
  touying-slide(self: self, body)
})


/// Last slide for the presentation.
#let last-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 1em),
    config,
  )
  let info = self.info + args.named()
  let body = args.pos().at(0, default: none)
  let authors = _normalize-authors(if "authors" in info { info.authors } else { info.author })

  let slide-body = {
    set text(fill: white)
    std.align(
      center + horizon,
      {
        if info.logo != none {
          info.logo
          v(5mm)
        }
        if body != none {
          v(5mm)
          set text(size: 1.5em, weight: "bold")
          body
          v(5mm)
        } else {
          v(1cm)
        }
        text(size: 1.2em, weight: "bold", info.title)
        v(5mm)
        set text(size: .8em)
        grid(
          columns: (1fr,) * calc.min(authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..authors.map(a => {
            _format-author-title(a)
          })
        )
      },
    )
  }
  touying-slide(self: self, slide-body)
})


/// New section slide for the presentation.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon + center)
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


/// Matrix slide.
#let matrix-slide(
  config: (:),
  columns: none,
  rows: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      header: _header,
      footer: _footer,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    composer: components.checkerboard.with(columns: columns, rows: rows),
    ..bodies,
  )
})


/// Outline slide for the presentation.
#let outline-slide(
  title: [Outline],
  config: (:),
  ..args,
) = slide(
  config: utils.merge-dicts(
    config-store(header: title),
    config,
  ),
  outline(title: none, indent: 1em, depth: 1, ..args),
)

/// Creates a slide title that repeats the current top-level section title.
///
/// Pattern covered:
/// - `= Section title` appears in outline
/// - next slide gets an unnumbered title with the same text
#let repeated-section-title-slide(section-level: 1) = [
  == #utils.display-current-heading(level: section-level) <touying:unnumbered>
]

/// Touying university theme for PG.
#let university-theme(
  aspect-ratio: "16-9",
  align: top,
  progress-bar: false,
  logo-in-header: true,
  header: utils.display-current-heading(level: 2, style: auto),
  header-right: none,
  footer-columns: (25%, 1fr, 25%),
  footer-a: auto, // Handled in slide function
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
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 3em, bottom: 1.5em, x: 2.5em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(fill: self.colors.primary, size: 20pt, font: "Arial")
        show heading.where(level: 2): set text(fill: self.colors.primary)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        show heading.where(level: 4): set text(fill: self.colors.primary)

        // Math and code should be black for better contrast and highlighting
        show math.equation: set text(fill: black)
        show raw: set text(fill: black)

        set list(marker: (
          text(fill: self.colors.alert, [•]),
          text(fill: self.colors.alert, [--]),
          text(fill: self.colors.alert, size: 0.6em, [•]),
        ))
        set enum(numbering: n => text(fill: self.colors.alert, weight: "bold", [#n.]))

        body
      },
      alert: (self: none, it) => text(fill: self.colors.alert, it),
    ),
    config-colors(
      primary: rgb("#003865"),
      secondary: rgb("#286083"),
      tertiary: rgb("#144C74"),
      alert: rgb("#C10A27"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      progress-bar: progress-bar,
      logo-in-header: logo-in-header,
      header: header,
      header-right: header-right,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
    ..args,
  )

  body
}
