#import "@preview/touying:0.6.1": *

#let format-date(datetime) = datetime.display("[day].[month].[year]")

#let default-footer(self) = {
  set text(size: 10pt)
  components.left-and-right(
    box(
      height: 0.7in,
      stack(
        dir: ltr,
        spacing: 0.11in,
        image("../cd/logo/Logo_Dresdenrb_Voll_4c_icon.svg", width: 1in),
      )
    ),
    align(horizon, context utils.slide-counter.display()),
  )
}

/// Default slide function for the presentation.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - repeat (int, auto): The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
///
////   The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
///
/// - setting (function): The setting of the slide. You can use it to add some set/show rules for the slide.
///
/// - composer (function): The composer of the slide. You can use it to set the layout of the slide.
///
///   For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
///
///   If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
///
///   The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
///
///   For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
///
///   If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
///
/// - bodies (array): The contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.
#let slide(
  config: (:),
  header-below: 1.13in,
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let footer(self) = pad(left: -0.5in, default-footer(self))

  let self = utils.merge-dicts(
    self,
    config-page(
      footer: footer,
      footer-descent: 0.05in,
    ),
    config-common(subslide-preamble: block(
      below: header-below,
      text(30pt, weight: "semibold", utils.display-current-heading(level: 2)),
    )),
  )

  show heading.where(level: 2): set text(weight: "semibold", size: 30pt)

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
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
#let centered-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  touying-slide(self: self, ..args.named(), config: config, align(
    center + horizon,
    args.pos().sum(default: none),
  ))
})


/// Title slide for the presentation.
///
/// Example: `#title-slide[Hello, World!]`
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
#let title-slide(config: (:), ..bodies) = touying-slide-wrapper(self => {
  let background = [
    #place(
      top + left,
      polygon(
        fill: color.rgb(75, 0, 45),
        (5in, 100%),
        (10in, 0%),
        (100%, 0%),
        (100%, 100%),
      ),
    )
    #place(
      top + left,
      polygon(
        fill: tiling(size: (56pt, 75pt))[#image("../cd/logo/Logo_Dresdenrb_Pattern_Purple.svg"))],
        (5in, 100%),
        (10in, 0%),
        (100%, 0%),
        (100%, 100%),
      ),
    )

     #place(
      top + end,
      dx: -0.8in,
      dy: 2.4in,
      image("../cd/logo/Logo_Dresdenrb_Outline_1c_w.svg", width: 3in),
    )
  ]

  let footer(self) = align(top)[
    #set text(size: 16pt)

    \ // empty line for author title
    #text(weight: "semibold", self.info.author) \
    #self.info.institution \
    #format-date(self.info.date)
  ]

  let self = utils.merge-dicts(
    self,
    config-page(
      footer: footer,
      margin: (x: 0.59in, top: 2.5in, bottom: 2.69in),
      footer-descent: 0.69in,
      background: background,
    ),
  )

  touying-slide(self: self, config: utils.merge-dicts(config, config-common()))[
    #show heading.where(level: 1): set text(weight: "semibold", size: 32pt)
    #block(width: 6in, heading(level: 1, self.info.title))
  ]
})

#let colors = config-colors(
  neutral-light: gray,
  neutral-lightest: rgb("#ffffff"),
  neutral-darkest: rgb("#000000"),
  primary: color.rgb(75, 0, 45),
).colors

/// Dresden.rb Theme.
///
/// Example:
///
/// ```typst
/// #show: dresdenrb-theme.with(aspect-ratio: "16-9", config-colors(primary: blue))`
/// ```
///
/// - aspect-ratio (string): The aspect ratio of the slides. Default is `16-9`.
///
/// - header (function): The header of the slides. Default is `self => utils.display-current-heading(setting: utils.fit-to-width.with(grow: false, 100%), depth: self.slide-level)`.
///
/// - header-right (content): The right part of the header. Default is `self.info.logo`.
///
/// - footer (content): The footer of the slides. Default is `none`.
///
/// - footer-right (content): The right part of the footer. Default is `context utils.slide-counter.display() + " / " + utils.last-slide-number`.
///
/// - primary (color): The primary color of the slides. Default is `aqua.darken(50%)`.
///
/// - subslide-preamble (content): The preamble of the subslides. Default is `block(below: 1.5em, text(1.2em, weight: "bold", utils.display-current-heading(level: 2)))`.
#let dresdenrb-theme(
  show-notes-on-second-screen: right,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      width: 13.33in,
      height: 7.5in,
      margin: (x: 0.6in, top: 0.4in, bottom: 0.75in),
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      zero-margin-header: false,
      zero-margin-footer: false,
      show-notes-on-second-screen: show-notes-on-second-screen,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "Montserrat", size: 18pt)
        set strong(delta: 50)
        set par(spacing: 0.14in, leading: 1.1em)
        show list: set block(spacing: 1em)
        show enum: set block(spacing: 1em)
        show figure.caption: set text(size: 14pt, fill: self.colors.neutral)
        show footnote.entry: set text(size: 12pt, fill: self.colors.neutral)

        body
      },
    ),
    (colors: colors),
    // save the variables for later use
    config-store(),
    ..args,
  )

  body
}
