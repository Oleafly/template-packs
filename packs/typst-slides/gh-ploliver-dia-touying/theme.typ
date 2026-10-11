// This theme is a fork of https://touying-typ.github.io/docs/themes/simple, which is a fork of https://github.com/andreasKroepelin/polylux/blob/main/themes/simple.typ
// The objective is to be visually similar to https://typst.app/universe/package/diatypst.
// Pau López Oliver

#import "@preview/touying:0.6.1": *
#import "@preview/showybox:2.0.4": showybox


/// A definition box for highlighting definitions or important concepts.
///
/// Example: `#defbox([Definition], [A *group* is a set with an operation...])`
///
/// - title: The title of the box (e.g., "Definition", "Example").
/// - content: The content of the box.
/// - title-color: The primary color for the box styling. Default is `aqua.darken(50%)`.
#let defbox(title, content, title-color: aqua.darken(50%)) = {
  showybox(
    align: center,
    width: 95%,
    frame: (
      title-color: title-color.lighten(60%),
      border-color: rgb(0, 0, 0, 0),
      body-color: title-color.lighten(90%),
      title-inset: 0.5em,
    ),
    title-style: (color: title-color.darken(90%), weight: "bold"),
    breakable: true,
    title: title,
  )[
    #content
  ]
}


/// A theorem/proof box with a footer section.
///
/// Example: `#theoremproofbox([Theorem], [For all $n$...], [_Proof._ By induction...])`
///
/// - title: The title of the box (e.g., "Theorem", "Lemma").
/// - content: The main content of the box.
/// - footer: The footer content (typically a proof or remark).
/// - title-color: The primary color for the box styling. Default is `aqua.darken(50%)`.
#let theoremproofbox(title, content, footer, title-color: aqua.darken(50%)) = {
  showybox(
    align: center,
    width: 95%,
    frame: (
      title-color: title-color.lighten(60%),
      border-color: rgb(0, 0, 0, 0),
      body-color: title-color.lighten(90%),
      title-inset: 0.5em,
    ),
    title-style: (color: title-color.darken(90%), weight: "bold"),
    breakable: true,
    title: title,
    footer: footer,
  )[
    #content
  ]
}


/// A manicule (pointing hand) symbol for drawing attention.
///
/// Example: `#manicule() Check this out!`
#let manicule() = [☞]


/// Default slide function for the presentation.

#let slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  /// The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
  ///
  /// The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
  /// -> int | auto
  repeat: auto,
  /// The setting of the slide. You can use it to add some set/show rules for the slide.
  /// -> function
  setting: body => body,
  /// The composer of the slide. You can use it to set the layout of the slide.
  ///
  /// For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
  ///
  /// If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
  ///
  /// The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
  ///
  /// For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
  ///
  /// If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
  /// -> function | int | array
  composer: auto,
  /// The contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.
  ..bodies,
) = touying-slide-wrapper(self => {
  let deco-format(it) = text(size: .6em, fill: self.colors.neutral-darkest, it)
  let header(self) = block({
    v(1.5em)
    align(top, components.left-and-right(
      text(1.2em, weight: "bold", fill: self.colors.primary, context {
        let current-page = here().page()
        let headings = query(heading.where(level: 2))
        let headings-before = headings.filter(h => h.location().page() <= current-page)

        if headings-before.len() > 0 {
          let current-heading = headings-before.last()
          let next-headings = headings.filter(h => h.location().page() > current-page)
          let section-start-page = current-heading.location().page()
          let section-end-page = if next-headings.len() > 0 {
            next-headings.first().location().page() - 1
          } else {
            counter(page).final().first()
          }
          let total-pages = section-end-page - section-start-page + 1
          let index = current-page - section-start-page + 1

          utils.display-current-heading(level: 2)
          if total-pages > 1 and index > 1 and self.at("subslide", default: 1) == 1 {
            " " + numbering("(i)", index)
          }
        } else {
          utils.display-current-heading(level: 2)
        }
      }),
      text(0.7em, fill: self.colors.neutral-light, context utils.slide-counter.display()
        + " / "
        + utils.last-slide-number),
    ))
  })
  let footer(self) = {
    v(.5em)
    v(.5em)
    deco-format(
      grid(
        columns: (1fr, 1fr),
        column-gutter: 0pt,
        stack(
          spacing: 0.6em,
          rect(width: 100%, height: 2pt, fill: self.colors.primary),
          align(right, strong(self.info.authors) + h(0.25em)),
        ),
        stack(
          spacing: 0.6em,
          rect(width: 100%, height: 2pt, fill: self.colors.neutral-light),
          align(left, h(0.25em) + smallcaps(utils.call-or-display(self, self.store.footer))),
        ),
      ),
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
    config-common(subslide-preamble: self.store.subslide-preamble),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})


/// Centered slide for the presentation.
#let centered-slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 2em, header: none, footer: none),
  )
  touying-slide(self: self, ..args.named(), config: config, align(
    center + horizon,
    args.pos().sum(default: none),
  ))
})

/// Title slide for the presentation.
///
/// Example: `#title-slide[Hello, World!]`
#let title-slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  /// The title of the presentation. Default is `none`.
  /// -> content
  title: none,
  /// The supertitle (subtitle) of the presentation. Default is `none`.
  /// -> content
  supertitle: none,
  /// The authors of the presentation. Default is `none`.
  /// -> content | array
  authors: none,
  /// The date of the presentation. Default is `auto`, which means `self.info.date` if it exists, otherwise `datetime.today().display()`.
  /// -> content | auto
  date: auto,
  /// The institution of the presentation. Default is `none`.
  /// -> content
  institution: none,
  /// The logo of the presentation. Default is `auto`, which means `self.info.logo` if it exists, otherwise `none`.
  /// -> content | auto
  logo: auto,
  /// The logo position. Default is `auto`, which means `self.info.logo-at` if it exists, otherwise `none`.
  /// -> array | auto
  logo-at: auto,
  /// The logo size. Default is `auto`, which means `self.info.logo-size` if it exists, otherwise `none`.
  /// -> length | auto
  logo-size: auto,
  /// The horizontal offset of the logo. Default is `auto`, which means `self.info.logo-dx` if it exists, otherwise `0pt`.
  /// -> length | auto
  logo-dx: auto,
  /// The vertical offset of the logo. Default is `auto`, which means `self.info.logo-dy` if it exists, otherwise `0pt`.
  /// -> length | auto
  logo-dy: auto,
  /// The content of the title slide. Default is `none`.
  /// -> content
  body: none,
) = touying-slide-wrapper(self => {
  let date = if date == auto {
    if self.info.at("date", default: auto) != auto {
      self.info.date
    } else {
      datetime.today().display()
    }
  } else {
    date
  }
  let logo = if logo == auto {
    self.info.at("logo", default: none)
  } else {
    logo
  }
  let logo-at = if logo-at == auto {
    self.info.at("logo-at", default: none)
  } else {
    logo-at
  }
  let logo-size = if logo-size == auto {
    self.info.at("logo-size", default: none)
  } else {
    logo-size
  }
  let logo-dx = if logo-dx == auto {
    self.info.at("logo-dx", default: 0pt)
  } else {
    logo-dx
  }
  let logo-dy = if logo-dy == auto {
    self.info.at("logo-dy", default: 0pt)
  } else {
    logo-dy
  }
  // Determine default dx/dy if info lookup returned none (defensive)
  let logo-dx = if logo-dx == none { 0pt } else { logo-dx }
  let logo-dy = if logo-dy == none { 0pt } else { logo-dy }

  touying-slide(
    self: self,
    config: utils.merge-dicts(
      config,
      config-page(margin: 0em),
      config-common(freeze-slide-counter: true),
    ),
    {
      grid(
        rows: (auto, auto, 1fr, auto),
        columns: 1fr,
        if title != none or supertitle != none {
          block(
            width: 100%,
            fill: self.colors.primary,
            inset: (x: 1.5em, y: 1.5em),
            text(fill: self.colors.neutral-lightest, {
              grid(
                columns: if logo != none and logo-at == none { (1fr, auto) } else { 1fr },
                align(left + horizon, {
                  if supertitle != none {
                    grid(
                      columns: (auto, 1fr),
                      gutter: 1em,
                      align(horizon, supertitle),
                      align(horizon, line(length: 100%, stroke: 1pt + self.colors.neutral-lightest)),
                    )
                  }
                  if title != none {
                    heading(level: 1, title)
                  }
                }),
                if logo != none and logo-at == none {
                  align(right + horizon, logo)
                }
              )
            }),
          )
        },
        if authors != none {
          block(
            width: 100%,
            inset: (x: 1.5em, top: 1em),
            text(fill: self.colors.primary, weight: "bold", authors),
          )
        },
        align(left + horizon, block(
          width: 100%,
          inset: (x: 1.5em),
          if body != none {
            body
          },
        )),
        if date != none or institution != none {
          block(
            width: 100%,
            inset: (x: 1.5em, bottom: 1.5em),
            if institution != none and date != none {
              stack(
                dir: ttb,
                spacing: 0.6em,
                institution,
                date,
              )
            } else if institution != none {
              institution
            } else {
              date
            },
          )
        }
      )
      if logo != none and logo-at != none {
        if type(logo-at) == alignment {
          place(logo-at, dx: logo-dx, dy: logo-dy, if logo-size != none {
            set image(width: logo-size)
            logo
          } else {
            logo
          })
        } else {
          place(top + left, dx: logo-at.at(0) + logo-dx, dy: logo-at.at(1) + logo-dy, move(
            dx: -50%,
            dy: -50%,
            if logo-size != none {
              set image(width: logo-size)
              logo
            } else {
              logo
            },
          ))
        }
      }
    },
  )
})


/// Outline slide for the presentation.
#let outline-slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  /// The title of the slide. Default is "Table of Contents".
  /// -> content
  title: "Table of Contents",
  /// The arguments for the `outline` function.
  ..args,
) = touying-slide-wrapper(self => {
  let header(self) = block({
    v(1.5em)
    align(top, components.left-and-right(
      text(1.2em, weight: "bold", fill: self.colors.primary, title),
      text(0.7em, fill: self.colors.neutral-light, context utils.slide-counter.display()
        + " / "
        + utils.last-slide-number),
    ))
  })
  self = utils.merge-dicts(
    self,
    config-page(header: header),
  )
  touying-slide(
    self: self,
    config: config,
    outline(title: none, indent: 1em, depth: 2, ..args),
  )
})


/// Split slide for multi-page content with automatic Roman numbering.
///
/// The objective to split slides is to be compatible with `#pause`.
///
/// Example: `#split-slide(title: [First slide])[Content of page 1][Content of page 2]`
#let split-slide(
  /// The configuration of the slide.
  /// -> dictionary
  config: (:),
  /// The title of the slide.
  /// -> content
  title: none,
  /// The content blocks for each page/slide.
  ..bodies,
) = {
  let body-list = bodies.pos()
  if body-list.len() == 1 and body-list.first().has("children") {
    let chunks = ()
    let current-chunk = ()
    for child in body-list.first().children {
      if child.func() == pagebreak {
        chunks.push(current-chunk.sum(default: []))
        current-chunk = ()
      } else {
        current-chunk.push(child)
      }
    }
    chunks.push(current-chunk.sum(default: []))
    body-list = chunks
  } else if body-list.len() == 1 {
    // Single element without children and no pagebreaks
    body-list = (body-list.first(),)
  }

  for (i, body) in body-list.enumerate() {
    let new-title = if i == 0 { title } else { title + " " + numbering("(i)", i + 1) }
    let hidden-heading = place(top + left, block(width: 0pt, height: 0pt, hide(heading(
      level: 2,
      outlined: i == 0,
      new-title,
    ))))
    slide(config: config, hidden-heading + body)
  }
}


/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
#let new-section-slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  /// The content of the section slide.
  /// -> content
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 2em, header: none, footer: none),
  )
  touying-slide(self: self, config: config, align(
    center + horizon,
    {
      block(
        width: auto,
        fill: self.colors.primary,
        inset: 0.8em,
        text(1.4em, weight: "bold", fill: self.colors.neutral-lightest, utils.display-current-heading(level: 1)),
      )
      if body != none and body != [] {
        v(1em)
        body
      }
    },
  ))
})


/// Focus on some content.
///
/// Example: `#focus-slide[Wake up!]`

#let focus-slide(
  /// The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
  /// -> dictionary
  config: (:),
  /// The background color of the slide. Default is `auto`, which means the primary color of the slides.
  /// -> color | auto
  background: auto,
  /// The foreground color of the slide. Default is `white`.
  /// -> color
  foreground: white,
  /// The content of the focus slide.
  /// -> content
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if background == auto {
        self.colors.primary
      } else {
        background
      },
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  set text(fill: foreground, size: 1.5em)
  set par(justify: false)
  touying-slide(self: self, config: config, align(center + horizon, body))
})


/// Touying simple theme.
///
/// Example:
///
/// ```typst
/// #show: dia-touying.with(aspect-ratio: "16-9", config-colors(primary: blue))
/// ```
///
/// The default colors:
///
/// ```typst
/// config-colors(
///   neutral-light: gray,
///   neutral-lightest: rgb("#ffffff"),
///   neutral-darkest: rgb("#000000"),
///   primary: aqua.darken(50%),
/// )
/// ```
#let dia-touying(
  /// The aspect ratio of the slides. Default is `"16-9"`.
  /// -> string
  aspect-ratio: "16-9",
  /// The header of the slides. Default is `none`.
  /// -> content | function
  header: none,
  /// The right part of the header. Default is `none`.
  /// -> content
  header-right: none,
  /// The footer of the slides. Default is `none`.
  /// -> content | function
  footer: none,
  /// The right part of the footer. Default is `none`.
  /// -> content
  footer-right: none,
  /// The preamble of the subslides. Default is `none`.
  /// -> content
  subslide-preamble: none,
  /// The primary color of the slides. Default is `aqua.darken(50%)`.
  /// -> color
  primary: aqua.darken(50%),
  /// The color for neutral light elements (e.g. secondary text). Default is `gray`.
  /// -> color
  neutral-light: gray,
  /// The color for neutral lightest elements (e.g. background). Default is `rgb("#ffffff")`.
  /// -> color
  neutral-lightest: rgb("#ffffff"),
  /// The color for neutral darkest elements (e.g. main text). Default is `rgb("#000000")`.
  /// -> color
  neutral-darkest: rgb("#000000"),
  /// The font family of the text. Default is `"New Computer Modern"`.
  /// -> string
  font: "New Computer Modern",
  /// The font size of the text. Default is `23pt`.
  /// -> length
  font-size: 23pt,
  /// The authors of the presentation. Default is `none`.
  /// -> content | array
  authors: none,
  /// The date of the presentation. Default is `auto`.
  /// -> content | auto
  date: auto,
  /// The logo of the presentation. Default is `none`.
  /// -> content
  logo: none,
  /// The logo position. Default is `none`.
  /// -> array
  logo-at: none,
  /// The logo size. Default is `none`.
  /// -> length
  logo-size: none,
  /// The horizontal offset of the logo. Default is `auto`.
  /// -> length | auto
  logo-dx: auto,
  /// The vertical offset of the logo. Default is `auto`.
  /// -> length | auto
  logo-dy: auto,
  /// Whether to enable handout mode (disable animations). Default is `false`.
  /// -> bool
  handout: false,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (x: 1.5em, top: 3.8em, bottom: 2.2em),
      header-ascent: 2.5em,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      zero-margin-header: false,
      zero-margin-footer: false,
      handout: handout,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: font, size: font-size)
        set par(justify: true)
        show footnote.entry: set text(size: .6em)
        show heading.where(level: 1): set text(1.4em)
        show strong: set text(fill: black)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-info(
      authors: authors,
      date: date,
      logo: logo,
      logo-at: logo-at,
      logo-size: logo-size,
    ),
    (info: (logo-dx: logo-dx, logo-dy: logo-dy)),
    config-colors(
      neutral-light: neutral-light,
      neutral-lightest: neutral-lightest,
      neutral-darkest: neutral-darkest,
      primary: primary,
    ),
    // save the variables for later use
    config-store(
      header: header,
      header-right: header-right,
      footer: footer,
      footer-right: footer-right,
      subslide-preamble: subslide-preamble,
    ),
    ..args,
  )

  body
}
