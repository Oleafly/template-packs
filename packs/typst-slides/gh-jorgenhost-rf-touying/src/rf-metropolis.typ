// This theme is inspired by https://github.com/matze/mtheme
// The origin code was written by https://github.com/Enivex

#import "@preview/touying:0.6.3" as ty
#import "colors.typ" as colors
#import "utils.typ" as rf-utils
#import "logos.typ" as rf-logos
/// Default slide function for the presentation.
///
/// - title (string): The title of the slide. Default is `auto`.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - repeat (int, string): The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
///
///   The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
///
/// - setting (function): The setting of the slide. You can use it to add some set/show rules for the slide.
///
/// - composer (function, array): The composer of the slide. You can use it to set the layout of the slide.
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
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = ty.touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    show: ty.components.cell.with(
      fill: self.colors.secondary,
      inset: 1em,
      height: self.store.header-block-size,
    )
    set std.align(horizon)
    set text(
      fill: self.colors.neutral-lightest,
      weight: "medium",
      size: self.store.header-text-size,
    )

    ty.components.left-and-right(
      {
        if title != auto {
          ty.utils.fit-to-width(grow: false, 100%, title)
        } else {
          ty.utils.call-or-display(self, self.store.header)
        }
      },
      ty.utils.call-or-display(self, self.store.header-right),
    )
  }

  let footer(self) = {
    set std.align(bottom)
    set text(size: 14pt)
    pad(.5em, ty.components.left-and-right(
      text(fill: self.colors.neutral-darkest.lighten(40%), ty.utils.call-or-display(self, self.store.footer)),
      text(fill: self.colors.neutral-darkest, ty.utils.call-or-display(self, self.store.footer-right)),
    ))
    if self.store.footer-progress {
      place(bottom, ty.components.progress-bar(height: 2pt, self.colors.primary, self.colors.primary-light))
    }
  }
  let self = ty.utils.merge-dicts(self, ty.config-page(
    fill: self.colors.neutral-lightest,
    header: header,
    footer: footer,
  ), config)
  let new-setting = body => {
    show: std.align.with(self.store.align)
    set text(fill: self.colors.neutral-darkest)
    show: setting

    // progress bar directly under the header, in the body area
    if self.store.header-progress {
      // This anchors to the top of the BODY region (below header),
      // so it will always be "just below the gray header".
      place(
        top,
        pad(
          // If you want it to span the full slide width, cancel page x margins:
          x: -2em,
          block(width: 100%, spacing: 0pt)[
            #ty.components.progress-bar(
              height: 2.5pt,
              self.colors.primary,
              self.colors.primary-light,
            )
          ]
        )
      )
    }

    body
  }

  ty.touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})


/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
///
/// Example:
///
/// ```typst
/// #import "@preview/rf-touying:0.1.0" as rf
/// #show: rfph-metropolis-theme.with(
///   config-info(
///     title: [Title],
///     logo: rf.logos.rf-logo,
///     logo-height: 2.5pt
///   ),
/// )
///
/// #rf.title-slide()
/// ```
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - extra (string, none): The extra information you want to display on the title slide.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = ty.touying-slide-wrapper(self => {
  self = ty.utils.merge-dicts(
    self,
    ty.config-common(freeze-slide-counter: true),
    ty.config-page(
    fill: self.colors.neutral-lightest,
    margin: (top: 1em, bottom: 1em)
  ),
    config,
  )

  let info = self.info + args.named()
  let logo-height = 1.2cm

  let body = {
    set text(fill: self.colors.neutral-darkest)
    set std.align(horizon)

    // 1) Draw your normal title content
    block(width: 100%, inset: 2em, {
      text(size: 1.3em, text(weight: "medium", info.title))
      if info.subtitle != none {
        linebreak()
        text(size: 0.9em, info.subtitle)
      }

      line(length: 100%, stroke: .05em + self.colors.primary)

      set text(size: .8em)
      if info.author != none { block(spacing: 1em, info.author) }
      if info.date != none { block(spacing: 1em, ty.utils.display-info-date(self)) }
      if info.institution != none { block(spacing: 1em, info.institution) }
      if extra != none { block(spacing: 1em, extra) }
    })

    // 2) Overlay the logo at the bottom-right of the SLIDE
    //    (use the same inset as your content so it aligns with margins)
    place(right + bottom,
      pad(right: 2em, bottom: 1em, image(rf-logos.rf-logo-path, height: logo-height))
    )
  }

  ty.touying-slide(self: self, body)
})
/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `ty.config-common` function.
///
/// Example: `ty.config-common(new-section-slide-fn: new-section-slide.with(numbered: false))`
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - level (int): The level of the heading.
///
/// - numbered (boolean): Indicates whether the heading is numbered.
///
/// - body (auto): The body of the section. It will be passed by touying automatically. 
#let new-section-slide(config: (:), level: 1, numbered: true, body) = ty.touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    stack(
      dir: ttb,
      spacing: 1em,
      text(self.colors.neutral-darkest, ty.utils.display-current-heading(
        level: level,
        numbered: numbered,
        style: auto,
      )),
      block(height: 2pt, width: 100%, spacing: 0pt, ty.components.progress-bar(
        height: 2pt,
        self.colors.primary,
        self.colors.primary-light,
      )),
    )
    text(self.colors.neutral-dark, body)
  }
  self = ty.utils.merge-dicts(self, ty.config-page(fill: self.colors.neutral-lightest, margin: (top: 1em, bottom: 1em)), config)  
  ty.touying-slide(self: self, config: config, slide-body)
})


/// Focus on some content.
///
/// Example: `#focus-slide[Wake up!]`
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - align (alignment): The alignment of the content. Default is `horizon + center`.
#let focus-slide(
  config: (:),
  align: horizon + center,
  fill: colors.rff-red,
  body,
) = ty.touying-slide-wrapper(self => {
  self = ty.utils.merge-dicts(self, ty.config-common(freeze-slide-counter: true), ty.config-page(
    fill: fill,
    margin: 2em,
  ), config)
  set text(fill: self.colors.neutral-lightest, size: 1.5em)
  ty.touying-slide(self: self, config: config, std.align(align, body))
})

/// Touying metropolis theme styled to fit the University of Copenhagen.
///
/// The default colors:
///
/// ```typ
/// ty.config-colors(
///   primary: rgb("901a1E"), // The "default" dark red rfPH color
///   primary-light: rgb("#d6c6b7"),
///   secondary: rgb("666666"), // "Medium" rfPH grey
///   neutral-lightest: rgb("#fafafa"),
///   neutral-dark: rgb("#23373b"),
///   neutral-darkest: rgb("#23373b"),
///   bold-color: black
/// )
/// ```
///
/// - aspect-ratio (string): The aspect ratio of the slides. Default is `16-9`.
///
/// - align (alignment): The alignment of the content. Default is `horizon`.
///
/// - header (content, function): The header of the slide. Default is `self => utils.display-current-heading(setting: utils.fit-to-width.with(grow: false, 100%), depth: self.slide-level)`.
///
/// - header-right (content, function): The right part of the header. Default is `self => self.info.logo`.
///
/// - footer (content, function): The footer of the slide. Default is `none`.
///
/// - footer-right (content, function): The right part of the footer. Default is `context utils.slide-counter.display() + " / " + utils.last-slide-number`.
/// - footer-appendix-label (str): Suffix to put on the slide counter in the appendix. #link("https://github.com/spidersouris/touying-unistra-pristine/blob/8c19b94a20edbde35d06a8cb9c4fc4a1c3c8a79c/src/unistra.typ#L91-L106")[Based on] `touying-unistra-pristine`.
/// - language (str): Specify language in the presentation. ("en" for English or "dk" for Danish currently supported)
/// - footer-progress (boolean): Whether to show the progress. Default is `true`.
#let rf-metropolis-theme(
  aspect-ratio: "16-9",
  align: horizon,
  language: "en",
  header: self => ty.utils.display-current-heading(
    setting: ty.utils.fit-to-width.with(grow: false, 100%),
    depth: self.slide-level,
  ),
  header-block-size: 3em,
  header-text-size: 25pt,
  header-right: self => none,
  footer: self => rf-utils.section-links(self),
  footer-right: self => rf-utils.slide-counter-label(self),
  header-progress: true,
  footer-progress: false,
  footer-appendix-label: "A-",
  ..args,
  body,
) = {
  set text(size: 18pt, lang: language)
  show cite: it => {
    show regex("\d{4}"): set text(blue)
    it
  }
    
  show: ty.touying-slides.with(
    ty.config-page(..ty.utils.page-args-from-aspect-ratio(aspect-ratio), header-ascent: 30%, footer-descent: 30%, margin: (
      top: header-block-size,
      bottom: 1.5em,
      x: 2em,
    )),
    ty.config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    ty.config-methods(alert: rf-utils.alert-bold-color),
    ty.config-colors(
      primary: colors.rff-orange,
      primary-light: rgb("#d6c6b7"),
      secondary: colors.rff-secondary,
      neutral-lightest: rgb("#fafafa"),
      neutral-dark: rgb("#23373b"),
      neutral-darkest: rgb("#23373b"),
      bold-color: black,
    ),
    // save the variables for later use
    ty.config-store(
      language: language,
      align: align,
      header-block-size: header-block-size,
      header-text-size: header-text-size,
      header: header,
      header-right: header-right,
      header-progress: header-progress,
      footer: footer,
      footer-right: footer-right,
      footer-progress: footer-progress,
      footer-appendix-label: footer-appendix-label,
    ),
    ..args,
  )

  body
}