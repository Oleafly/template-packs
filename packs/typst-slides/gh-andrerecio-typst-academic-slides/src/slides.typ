// Slide functions. Each one only configures the page chrome and hands the
// body to `touying-slide`; all slide mechanics stay in Touying.

#import "@preview/touying:0.7.4": *
#import "tokens.typ": *

#let _pad2(n) = if n < 10 { "0" + str(n) } else { str(n) }

// Slide title from the current `==` heading, over a hairline rule.
#let _header(self) = {
  let title = utils.display-current-heading(level: 2, numbered: false)
  block(
    width: 100%,
    inset: (bottom: 10pt),
    stroke: (bottom: 0.75pt + rule),
    {
      set text(size: size.title, weight: 700, fill: title-ink(self.colors.primary), tracking: -0.01em)
      set par(leading: 0.4em)
      title
    },
  )
}

// "Back" link, shown when some `#goto(<label>)` points at the current slide.
// It returns to the last subslide of the first slide that links here: fully
// revealed, so nothing the audience has already seen disappears.
#let _back-link(self) = context {
  let current = utils.current-heading(level: 2)
  if current == none or not current.has("label") { return }
  let hits = query(<brownbag-goto>).filter(m => m.value == str(current.label))
  if hits.len() == 0 { return }
  let origin = utils.slide-counter.at(hits.first().location())
  let same-slide = hits.filter(m => utils.slide-counter.at(m.location()) == origin)
  link(
    same-slide.last().location(),
    text(fill: self.colors.primary, weight: 500, sym.arrow.l + sym.space.nobreak + [Back]),
  )
}

// Short title on the left; back-link (if any) and `nn / NN` on the right.
#let _footer(self) = {
  let label = self.store.footer
  if label == auto {
    label = if self.info.short-title == auto { self.info.title } else { self.info.short-title }
  }
  set text(size: size.micro, fill: ink-subtle)
  grid(
    columns: (1fr, auto, auto),
    column-gutter: 3em,
    align: (left + horizon, right + horizon, right + horizon),
    utils.call-or-display(self, label),
    _back-link(self),
    // Backup slides are outside the total, so "of N" would read "03 / 02".
    text(font: font-mono, context {
      let n = utils.slide-counter.get().first()
      if self.appendix {
        _pad2(n)
      } else {
        _pad2(n) + " / " + _pad2(utils.last-slide-counter.final().first())
      }
    }),
  )
}

/// Content slide. Normally created by a `== Title` heading rather than called
/// directly. Arguments are Touying's: pass several bodies with
/// `composer: (1fr, 1fr)` for columns, or `repeat:` for callback-style reveals.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: _header, footer: _footer),
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

/// Section divider, created by a `= Section` heading.
#let new-section-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: _footer),
  )
  // Sections after `#show: appendix` (e.g. `= Appendix`) are not numbered.
  let number = if self.appendix { none } else {
    context _pad2(query(heading.where(level: 1).before(here())).len())
  }
  touying-slide(self: self, config: config, {
    v(1fr)
    text(font: font-mono, size: size.small, fill: self.colors.primary, number)
    v(14pt, weak: true)
    block(width: 85%, {
      set text(size: size.display, weight: 600, fill: title-ink(self.colors.primary), tracking: -0.02em)
      set par(leading: 0.4em)
      utils.display-current-heading(level: 1, numbered: false)
    })
    v(22pt, weak: true)
    line(length: 30%, stroke: 0.75pt + rule)
    body
    v(1.4fr)
  })
})

// Slides without chrome sit on symmetric margins and do not advance the counter.
#let _bare(self) = utils.merge-dicts(
  self,
  config-common(freeze-slide-counter: true),
  config-page(
    header: none,
    footer: none,
    margin: (x: space.page-x, y: space.page-bottom),
  ),
)

/// Title slide, filled from `config-info(title:, subtitle:, author:,
/// institution:, date:)`. For coauthors pass `author` as an array of strings
/// (Touying also writes it to the PDF metadata, which rejects content).
///
/// - extra (content): A last line, e.g. `[Joint with ..]` or the venue.
#let title-slide(config: (:), extra: none) = touying-slide-wrapper(self => {
  let info = self.info
  let authors = if type(info.author) == array { info.author.join(h(1.6em)) } else { info.author }
  touying-slide(self: _bare(self), config: config, {
    v(1fr)
    block(width: 92%, {
      set text(size: size.deck-title, weight: 600, fill: title-ink(self.colors.primary), tracking: -0.02em)
      set par(leading: 0.42em)
      info.title
    })
    if info.subtitle != none {
      v(16pt, weak: true)
      text(size: size.subtitle, fill: ink-muted, info.subtitle)
    }
    v(26pt, weak: true)
    line(length: 100%, stroke: 0.75pt + rule)
    v(26pt, weak: true)
    if authors != none {
      text(weight: 500, authors)
    }
    if info.institution != none {
      v(10pt, weak: true)
      text(size: size.small, fill: ink-muted, info.institution)
    }
    if info.date != none or extra != none {
      v(24pt, weak: true)
      set text(size: size.small, fill: ink-subtle)
      if info.date != none {
        text(font: font-mono, size: 0.85em, utils.display-info-date(self))
      }
      if info.date != none and extra != none { h(1.2em) }
      extra
    }
    v(1.2fr)
  })
})

/// One large statement on an otherwise empty slide: the research question,
/// the takeaway, "Thank you". `#alert` works inside.
#let focus-slide(config: (:), body) = touying-slide-wrapper(self => {
  touying-slide(self: _bare(self), config: config, {
    set text(size: size.focus, weight: 600, fill: title-ink(self.colors.primary), tracking: -0.015em)
    set par(leading: 0.45em)
    v(1fr)
    block(width: 88%, body)
    v(1.2fr)
  })
})
