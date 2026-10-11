#import "@preview/touying:0.8.0": *
#import "colors.typ": tum-colors

#let _university-name = (en: "Technical University of Munich", de: "Technische Universität München")
#let _default-location = (en: "Munich", de: "München")
// `[month repr:long]` always renders English month names.
#let _months-de = (
  "Januar", "Februar", "März", "April", "Mai", "Juni",
  "Juli", "August", "September", "Oktober", "November", "Dezember",
)

#let _localized(dict) = context dict.at(text.lang, default: dict.en)

#let _display-date(self) = {
  let date = self.info.date
  if type(date) != datetime { return date }
  context if text.lang == "de" {
    [#date.display("[day]"). #_months-de.at(date.month() - 1) #date.year()]
  } else {
    date.display("[day]. [month repr:long] [year]")
  }
}

#let _authors(self) = {
  let author = self.info.author
  if type(author) == array { author } else if author in (none, "") { () } else { (author,) }
}

#let _footer(self) = {
  set align(bottom)
  set text(size: 11pt)
  pad(x: 1cm, bottom: 0.4cm, {
    (_authors(self) + self.info.footer-infos).join(" | ")
    h(1fr)
    context utils.slide-counter.display()
  })
}

#let _logo(white: false) = place(top + right, pad(1cm, image(
  if white { "resources/TUM-logo-white.svg" } else { "resources/TUM-logo.svg" },
  height: 1cm,
  alt: "TUM logo",
)))

// Special slides have no `==` heading of their own, so the notes panel and
// header would otherwise show the previous slide's title.
#let _hidden-heading(self, title) = place(hide(heading(
  level: self.slide-level,
  title,
  bookmarked: false,
  outlined: false,
  numbering: none,
)))


/// The default content slide. A `== Title` heading creates one automatically;
/// call it directly to use a `composer` for multi-column layouts:
///
/// ```typst
/// == Comparison
/// #slide(composer: (1fr, 1fr))[Left][Right]
/// ```
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set align(top)
    pad(x: 1cm, top: 2.6cm, text(size: 25pt, utils.display-current-heading(level: 2)))
  }
  self = utils.merge-dicts(self, config-page(header: header, footer: _footer))
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})


/// Opening slide with title, authors, university, school, chair, location and
/// date, as passed to `tum-theme`. Named arguments override single fields,
/// e.g. `#title-slide(subtitle: [Final talk])`.
///
/// - flags (bool): Full-bleed TUM flags photo with white text instead of the
///   TUM tower watermark.
#let title-slide(config: (:), flags: false, ..args) = touying-slide-wrapper(self => {
  // The article theme prints its own title block.
  if self.at("article-mode", default: false) { return touying-slide(self: self, []) }
  let info = self.info + args.named()
  let background = if flags {
    image("resources/TUM-flags.jpg", width: 100%, height: 100%, fit: "cover")
    _logo(white: true)
  } else {
    _logo()
    place(bottom + right, pad(1cm, image("resources/TUM-turm.jpg", height: 12cm)))
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(background: background, header: none, footer: none, margin: 0cm),
    config,
  )

  let lines = (
    _authors(self).join(", "),
    _localized(_university-name),
    info.school,
    info.chair,
    [#if info.location == auto { _localized(_default-location) } else { info.location }, #_display-date(self + (info: info))],
  ).filter(line => line not in (none, ""))

  let body = {
    set text(fill: white) if flags
    pad(x: 2cm, y: 3cm, {
      block(below: 0.8cm, {
        text(size: 25pt, info.title)
        if info.subtitle != none {
          block(above: 0.4cm, text(size: 18pt, info.subtitle))
        }
      })
      stack(dir: ttb, spacing: 0.5cm, ..lines)
    })
  }
  touying-slide(self: self, body)
})


/// Section divider. Touying calls it for every `= Section` heading, so you
/// rarely call it yourself.
#let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(footer: _footer))
  let setting(body) = {
    set align(horizon)
    show: pad.with(x: 2cm)
    text(size: 32pt, fill: self.colors.primary, utils.display-current-heading(level: level, numbered: numbered))
    block(above: 0.6cm, line(length: 4cm, stroke: 3pt + self.colors.primary))
    body
  }
  touying-slide(self: self, config: config, setting: setting, body)
})


/// Table of contents built from the `=` section headings.
#let outline-slide(config: (:), title: utils.i18n-outline-title) = slide(config: config, self => {
  if self.at("article-mode", default: false) { return }
  // The header renders this as the slide title.
  _hidden-heading(self, title)
  set text(size: 18pt)
  show outline.entry: it => block(below: 0.6cm, link(it.element.location(), it.indented(it.prefix(), it.body())))
  components.adaptive-columns(outline(title: none, depth: 1))
})


/// Full-bleed TUM blue slide for a single statement, e.g. "Questions?".
/// Does not count towards the slide number.
#let focus-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, background: _logo(white: true), header: none, footer: none, margin: 2cm),
    config,
  )
  touying-slide(
    self: self,
    setting: body => {
      set align(horizon)
      set text(fill: self.colors.neutral-lightest, size: 32pt)
      body
    },
    body,
  )
})


/// A slide whose content is scaled to fill the space below the title, so a
/// large image or diagram never spills onto a second page.
///
/// ```typst
/// == The TUM tower
/// #image-slide(image("/resources/TUM-turm.jpg", alt: "The TUM tower"))
/// ```
#let image-slide(config: (:), body) = slide(
  config: config,
  setting: body => align(center, utils.fit-to-height(1fr, body)),
  body,
)


// Title block for `--input export-mode=article`. The stock one prints an
// author array as its repr.
#let _article-title-block(title: none, subtitle: none, author: (), institution: none, date: none, ..) = {
  block(below: 1.5em, {
    text(size: 20pt, fill: tum-colors.primary-blue, title)
    if subtitle != none { block(above: 0.5em, text(size: 14pt, subtitle)) }
    set text(fill: tum-colors.secondary-grey-dark)
    block(above: 1em, {
      if type(author) == array { author.join(", ") } else { author }
      if institution != none { [ | #institution] }
      if type(date) == datetime { [ | #date.display("[day].[month].[year]")] }
    })
  })
}

#let notes(self: none, ..args) = touying-notes(
  self: self,
  header: self => pad(x: 32pt, y: 16pt, text(
    fill: self.colors.neutral-lightest,
    utils.display-current-heading(depth: self.slide-level),
  )),
  header-fill: self.colors.primary,
  fill: self.colors.neutral-lightest,
  ..args,
)


/// TUM corporate design theme.
///
/// ```typst
/// #show: tum-theme.with(
///   title: [My talk],
///   authors: ("Max Mustermann",),
///   school: [TUM School of Computation, Information and Technology],
///   chair: [Chair of Software Engineering],
/// )
/// ```
///
/// Any `config-*` dictionary is passed through to Touying, e.g.
/// `config-common(handout: true)` or
/// `config-common(show-notes-on-second-screen: right)`.
///
/// - aspect-ratio (str): `"16-9"` or `"4-3"`.
/// - lang (str): `"en"` or `"de"`. Localizes the university name, the default
///   location, the date and the outline title.
/// - font (str, array): Font family for all text.
/// - title (content): Shown on the title slide and set as the PDF title.
/// - subtitle (content, none): Shown below the title.
/// - authors (str, array): Shown on the title slide and at the start of the footer.
/// - date (datetime, content): Defaults to today.
/// - school (content, none): Title slide only, omitted if unset.
/// - chair (content, none): Title slide only, omitted if unset.
/// - location (content, auto): `auto` means Munich, localized.
/// - footer-infos (array): Appended to the authors in the footer, joined with ` | `.
#let tum-theme(
  aspect-ratio: "16-9",
  lang: "en",
  font: "Arial",
  title: [Title of the TUM presentation],
  subtitle: none,
  authors: (),
  date: auto,
  school: none,
  chair: none,
  location: auto,
  footer-infos: (),
  ..args,
  body,
) = {
  assert(type(footer-infos) == array, message: "footer-infos must be an array, e.g. (\"Excellence\",)")
  set text(lang: lang, font: font, size: 14pt)

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 4.4cm, bottom: 1.5cm, x: 1cm),
      background: _logo(),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      notes-fn: notes,
      article-theme: themes.article.article-theme.with(font: font, title-block-fn: _article-title-block),
    ),
    config-methods(
      init: (self: none, body) => {
        set block(spacing: 1em)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: tum-colors.primary-blue,
      primary-light: tum-colors.accent-blue-light,
      secondary: tum-colors.secondary-blue,
      tertiary: tum-colors.secondary-blue-dark,
      neutral: tum-colors.secondary-grey-mid,
      neutral-lightest: tum-colors.primary-white,
      neutral-darkest: tum-colors.primary-black,
    ),
    config-info(
      title: title,
      subtitle: subtitle,
      // Touying calls it `author`; it also feeds the PDF metadata.
      author: if type(authors) == array { authors } else { (authors,) },
      date: if date == auto { datetime.today() } else { date },
      school: school,
      chair: chair,
      location: location,
      footer-infos: footer-infos,
    ),
    config-article(available-fields: (
      title: "info.title",
      subtitle: "info.subtitle",
      author: "info.author",
      institution: "info.school",
      date: "info.date",
    )),
    ..args,
  )

  body
}
