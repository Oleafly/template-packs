
#import "@preview/touying:0.6.1": *
#import "@preview/showybox:2.0.4" as mod-showybox
#import "@preview/curryst:0.5.1" as curryst: rule

#let current-heading(level: auto, outlined: true) = {
  let here = here()
  query(heading.where(outlined: outlined).before(inclusive: false, here))
    .at(-1, default: none)
}

#let headings-context(target: heading.where(outlined: true)) = {
  let current-heading = current-heading()
  
  let headings = query(target)
  let path = ()
  let level = 0
  let current-heading-idx = none

  let result = ()

  for hd in headings {
    let diff = hd.level - level
    if diff > 0 {
      for _ in range(diff) {
        path.push(1)
      }
    } else {
      for _ in range(-diff) {
        let _ = path.pop()
      }
      path.at(-1) = path.at(-1) + 1
    }

    result.push((
      path: path,
      heading: hd
    ))

    if current-heading != none and hd.location() == current-heading.location() {
      current-heading-idx = result.len() - 1
    }
    
    level = hd.level
  }

  return (
    current-heading: current-heading,
    current-heading-idx: current-heading-idx,
    headings: result
  )
}

#let custom-outline(
  filter: hd => true,
  transform: (_, it) => it,
  target: heading.where(outlined: true),
  ..args
) = context {
  let cx = headings-context(target: target)
  let idx = cx.at("current-heading-idx", default: none)
  let scope-path = if idx != none {
    cx.headings.at(idx).path
  }

  let headings = cx.headings.map(hd => {
    let level = hd.path.len()

    let relation = if scope-path != none {
      let path-len = calc.min(level, scope-path.len())
      let common-path = hd.path.slice(0, path-len) == scope-path.slice(0, path-len)

      let same = hd.path == scope-path
      let parent = not same and common-path and level < scope-path.len()
      let child = not same and common-path and level > scope-path.len()
      let sibling = not same and level == scope-path.len() and hd.path.slice(0, path-len - 1) == scope-path.slice(0, path-len - 1)

      (
        same: same,
        parent: parent,
        child: child,
        sibling: sibling,
        unrelated: not same and not parent and not child and not sibling,
      )
    }
    
    (
      here-path: scope-path,
      here-level: if scope-path != none { scope-path.len() },
      level: level,
      path: hd.path,
      relation: relation,
      loc: hd.heading.location(),
      heading: hd.heading
    )
  }).filter(filter)

  if headings == () {
    let nonsense-target = selector(<P>).and(<NP>)
    outline(target: nonsense-target, ..args)
    return
  }

  let find-heading(location) = {
    for x in headings {
      if x.loc == location {
        return x
      }
    }
  }

  show outline.entry: it => {
    let hd = find-heading(it.element.location())
    transform(hd, it)
  }

  let selection = selector(headings.at(0).loc)
  for idx in range(1, headings.len()) {
    selection = selection.or(headings.at(idx).loc)
  }

  outline(target: selection, ..args)
}

#let primary-color = rgb("#004782")
#let secondary-color = rgb("#87CEEB")
#let tertiary-color = rgb("#4682B4")
#let text-color = black.transparentize(20%)

#let todo(content: text(style: "oblique")[TODO]) = box(stroke: 2pt + red, content)
#let smc(content) = text(font: "Linux Libertine", smallcaps[#content])

#let showybox-frame-style = (
  title-color: secondary-color.lighten(25%),
  body-color: secondary-color.transparentize(80%),
  border-color: color.luma(100%, 0%),
)
#let showybox = mod-showybox.showybox.with(
  frame: showybox-frame-style,
  body-style: (
    color: text-color,
  ),
)

#let definition(of-thing, content) = { 
  showybox(
    frame: showybox-frame-style + (border-color: primary-color),
    title-style: (
      boxed-style: (
        anchor: (y: horizon, x: center),
      )
    ),
    title: of-thing.replace(regex("^\w"), m=>upper(m.text)),
    {
      show of-thing: v => underline[*#v*]
      content
    }
  )
}

#let large-center-text(content) = [
  #set text(72pt)
  #set align(center)
  #content
]

#let proof-tree = curryst.prooftree.with(min-premise-spacing: 2em, stroke: 0.8pt)

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 3mm,
      if self.store.progress-bar {
        components.progress-bar(height: 2pt, self.colors.primary, self.colors.tertiary)
      },
      block(
        inset: (x: .5em),
        components.left-and-right(
          text(fill: self.colors.primary, weight: "bold", size: 1.2em, utils.call-or-display(self, self.store.header)),
          text(fill: self.colors.primary.lighten(65%), utils.call-or-display(self, self.store.header-right)),
        ),
      ),
    )
  }
  let footer(self) = {
    set align(center + bottom)
    set text(size: .4em)
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 1mm,
        align(horizon, text(fill: white, it)),
      )
      show: block.with(width: 100%, height: auto)
      grid(
        columns: self.store.footer-columns,
        rows: 1.5em,
        cell(fill: self.colors.primary, utils.call-or-display(self, self.store.footer-a)),
        cell(fill: self.colors.secondary, utils.call-or-display(self, self.store.footer-b)),
        cell(fill: self.colors.tertiary, utils.call-or-display(self, self.store.footer-c)),
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
  touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
})

#let title-slide(
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
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
      place(right, text(fill: self.colors.primary, info.logo))
    }
    align(
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
          ..info.authors.map(author => text(fill: self.colors.neutral-darkest, author))
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
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, body)
})

#let new-section-slide(level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  let slide-body = {
    set align(horizon)
    show: pad.with(left: 15%, right: 15%)

    custom-outline(
      title: none,
      filter: hd => hd.relation != none and not hd.relation.unrelated,
      depth: 2,
      transform: (hd, it) => {
        set text(size: 1.25em, fill: self.colors.primary, weight: "bold") if hd.relation != none and hd.relation.same
        set text(fill: self.colors.primary) if hd.relation != none and hd.relation.child
        set text(fill: text.fill.transparentize(60%)) if hd.relation != none and hd.relation.sibling

        it
      }
    )
    
    body
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, slide-body)
})

#let focus-slide(background-color: none, background-img: none, body) = touying-slide-wrapper(self => {
  let background-color = if background-img == none and background-color == none {
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
  touying-slide(self: self, align(horizon, body))
})

#let matrix-slide(columns: none, rows: none, ..bodies) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(self: self, composer: components.checkerboard.with(columns: columns, rows: rows), ..bodies)
})

#let presentation-theme(
  aspect-ratio: "16-9",
  progress-bar: true,
  header: utils.display-current-heading(level: 2),
  header-right: self => utils.display-current-heading(level: 1),
  footer-columns: (25%, 1fr, 25%),
  footer-a: self => self.info.author,
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
        set text(fill: self.colors.neutral-darkest, size: 22pt)
        show heading: set text(fill: self.colors.primary)
  
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: primary-color,
      secondary: secondary-color,
      tertiary: tertiary-color,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: text-color,
    ),
    config-store(
      progress-bar: progress-bar,
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
