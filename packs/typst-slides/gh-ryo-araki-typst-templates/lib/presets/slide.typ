#import "@preview/cjk-spacer:0.2.1": cjk-spacer
#import "../core/config.typ": slide-config
#import "../core/tokens.typ": slide-palette
#import "../core/locale.typ": apply-japanese-text
#import "../components/aligned-list.typ": aligned-items, aligned-enum
#import "../components/math.typ": apply-math-font, apply-inline-japanese-math-spacing, apply-block-equation-spacing, apply-referenced-only-equation-numbering
#import "../adapters/touying.typ": *

#let slide-date-formats = (
  en: "[month repr:short]. [day], [year]",
  ja: "[year]年[month]月[day]日",
)

#let resolve-slide-datetime-format(config) = {
  let explicit-format = config.at("datetime-format", default: auto)
  if explicit-format != auto {
    explicit-format
  } else {
    let locale = config.at("date-locale", default: "en")
    slide-date-formats.at(locale, default: slide-date-formats.at("en"))
  }
}

#let slide-title-author-has-content(author) = {
  let name = author.at("name", default: [])
  let affiliation = author.at("affiliation", default: [])
  let email = author.at("email", default: [])
  name != [] and name != "" or affiliation != [] and affiliation != "" or email != [] and email != ""
}

#let slide-title-author-email(email) = {
  if type(email) == str {
    raw(email)
  } else {
    email
  }
}

#let slide-title-author-table(authors, fill) = {
  let rows = authors.filter(slide-title-author-has-content)
  let cells = ()
  for author in rows {
    let name = author.at("name", default: [])
    let affiliation = author.at("affiliation", default: [])
    let email = author.at("email", default: [])
    cells.push(std.align(left, text(fill: fill, name)))
    cells.push(std.align(left, text(fill: fill, affiliation)))
    cells.push(std.align(left, text(fill: fill, slide-title-author-email(email))))
  }
  grid(
    columns: (auto, auto, auto),
    column-gutter: 1em,
    row-gutter: .6em,
    ..cells,
  )
}

#let _slide-footer-has-linebreak(body) = {
  if body.func() == linebreak {
    return true
  }
  let children = body.at("children", default: none)
  if children != none {
    for child in children {
      if _slide-footer-has-linebreak(child) {
        return true
      }
    }
  } else if body.has("body") and type(body.body) == content {
    return _slide-footer-has-linebreak(body.body)
  } else if body.has("child") and type(body.child) == content {
    return _slide-footer-has-linebreak(body.child)
  }
  false
}

#let _slide-footer-heading-body(body) = {
  if body.func() == linebreak {
    return []
  }
  let children = body.at("children", default: none)
  if children == none {
    if body.has("body") and type(body.body) == content and _slide-footer-has-linebreak(body.body) {
      _slide-footer-heading-body(body.body)
    } else if body.has("child") and type(body.child) == content and _slide-footer-has-linebreak(body.child) {
      _slide-footer-heading-body(body.child)
    } else {
      body
    }
  } else {
    let title = []
    let skip-space = false
    for child in children {
      if child.func() == linebreak {
        skip-space = true
      } else if skip-space and child.func() == [ ].func() {
        skip-space = false
      } else {
        title += _slide-footer-heading-body(child)
        skip-space = false
      }
    }
    title
  }
}

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
        inset: (x: .5em),
        components.left-and-right(
          text(
            fill: self.colors.primary,
            weight: "bold",
            size: 1.2em,
            utils.call-or-display(self, self.store.header),
          ),
          text(fill: self.colors.primary.lighten(65%), utils.call-or-display(
            self,
            self.store.header-right,
          )),
        ),
      ),
    )
  }
  let footer(self) = {
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
        cell(fill: self.colors.primary, utils.call-or-display(
          self,
          self.store.footer-a,
        )),
        cell(fill: self.colors.secondary, utils.call-or-display(
          self,
          self.store.footer-b,
        )),
        cell(fill: self.colors.tertiary, utils.call-or-display(
          self,
          self.store.footer-c,
        )),
      )
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  // Keep equation identities on each subslide for referenced-only numbering.
  // Its reference renderer resolves these repeated labels to the final copy.
  if self.at("equation-numbering", default: none) == "referenced-only" {
    self.label-only-on-last-subslide = self.label-only-on-last-subslide.filter(it => it != math.equation)
  }
  let slide-bodies = if self.at("equation-numbering", default: none) == "referenced-only" {
    bodies.pos().map(body => {
      show: apply-referenced-only-equation-numbering(
        numbering: self.at("equation-numbering-pattern", default: "(1)"),
      )
      body
    })
  } else {
    bodies.pos()
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..slide-bodies,
  )
})

#let slide-theme(body, config: none) = {
  let resolved = slide-config(overrides: config)
  let metadata = resolved.at("metadata")
  let datetime-format = resolve-slide-datetime-format(resolved)
  show: cjk-spacer
  set text(font: resolved.at("text-font"))
  show raw: set text(font: resolved.at("code-font"))
  show raw.where(block: true): set block(
    fill: rgb("#f6f7f9"),
    stroke: rgb("#d9dde3"),
    inset: 0.65em,
    radius: 4pt,
    width: 100%,
  )
  apply-math-font(font: resolved.at("math-font"))
  set math.accent(dotless: false)
  apply-japanese-text(cjk-font: resolved.at("cjk-font"))
  apply-inline-japanese-math-spacing()
  apply-block-equation-spacing()
  show: university-theme.with(
    header-right: "",
    footer-columns: resolved.at("footer-columns"),
    footer-a: self => {
      sym.section + " " + utils.display-current-heading(
        level: 1,
        setting: _slide-footer-heading-body,
      )
    },
    footer-b: self => {
      h(1fr)
      self.info.summary
      h(1fr)
      self.info.date.display(datetime-format)
      h(1fr)
    },
    footer-c: context utils.slide-counter.display() + " / " + utils.last-slide-number,
    config-info(
      title: metadata.at("title"),
      subtitle: metadata.at("subtitle"),
      author: if metadata.at("author-names") == [] { "" } else { metadata.at("author-names") },
      authors: metadata.at("slide-title-authors"),
      title-author-entries: metadata.at("authors"),
      date: metadata.at("date"),
      institution: if resolved.at("institution") != [] {
        resolved.at("institution")
      } else {
        metadata.at("affiliations-inline")
      },
      logo: metadata.at("logo"),
      logo-position: metadata.at("logo-position"),
      summary: metadata.at("summary"),
    ),
    config-common(
      datetime-format: datetime-format,
      equation-numbering: resolved.at("equation-numbering"),
      equation-numbering-pattern: resolved.at("equation-numbering-pattern"),
      receive-body-for-new-section-slide-fn: false,
    ),
    // config-common(new-section-slide-fn: none),
    config-common(handout: resolved.at("handout")),
  )
  body
}

#let setup-slide(config: none) = [#show: slide-theme.with(config: config)]
#let slide-title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  let named-args = args.named()
  let info = self.info + named-args
  let has-direct-title-authors = "authors" in named-args
  let title-author-entries = info.at("title-author-entries", default: ())
  let structured-title-authors = if type(title-author-entries) == array {
    title-author-entries.filter(slide-title-author-has-content)
  } else {
    ()
  }
  let has-metadata-author-table = not has-direct-title-authors and structured-title-authors.len() > 1
  let title-authors = {
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
  let has-institution = info.institution != none and info.institution != [] and info.institution != ""
  let body = {
    if info.logo != none {
      let logo-alignment = if info.logo-position == "right-top" {
        right + top
      } else if info.logo-position == "right-bottom" {
        right + bottom
      } else {
        panic("unsupported slide logo-position: " + repr(info.logo-position))
      }
      place(logo-alignment, text(fill: self.colors.primary, info.logo))
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
        if has-metadata-author-table {
          slide-title-author-table(structured-title-authors, self.colors.neutral-darkest)
        } else if "authors" in info {
          stack(
            dir: ttb,
            spacing: .6em,
            ..title-authors.map(author => text(
              fill: self.colors.neutral-darkest,
              author,
            )),
          )
        } else {
          stack(
            dir: ttb,
            spacing: 1em,
            ..title-authors
              .chunks(3)
              .map(author-chunk => {
                grid(
                  columns: (1fr,) * author-chunk.len(),
                  column-gutter: 1em,
                  ..author-chunk.map(author => text(
                    fill: self.colors.neutral-darkest,
                    author,
                  ))
                )
              }),
          )
        }
        v(1em)
        if not ("authors" in info) and has-institution {
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
