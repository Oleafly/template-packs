#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": (
  corner-design,
  leipzig-footer,
  leipzig-header,
  plaque,
  side-design,
)

// Regular content slide.
//
// The slide header (ALL CAPS, bold) is taken from the preceding level-2
// heading (`== ...`); the optional subheader (ALL CAPS) is passed explicitly.
//
// - subheader (content, none): the slide subheader shown below the header.
#let slide(
  subheader: none,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(header: leipzig-header, footer: leipzig-footer),
  )
  let new-setting = body => {
    show: setting
    set align(top + left)
    // Slide header from the current level-2 heading + optional subheader.
    block(
      width: 100%,
      below: 0.8em,
      {
        context {
          let h = utils.current-heading(level: 2, depth: self.slide-level)
          if h != none {
            text(
              size: slide-header-size,
              weight: "bold",
              fill: LeipzigSchwarz,
              upper(h.body),
            )
          }
        }
        if subheader != none {
          linebreak()
          text(size: subheader-size, fill: LeipzigSchwarz, upper(subheader))
        }
      },
    )
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


// Title slide: a blank page with the Leipzig plaque in the top-left, a
// vertically centered text block (subtitle, title, place/date, author, logos)
// and the three-coloured corner accent in the bottom-right.
//
// Reads `title`, `subtitle`, `author`, `date`, `place` and `logos` from the
// presentation info (set via `config-info`); any of them may also be passed
// directly to `title-slide`. `logos` is an array of already-constructed
// `image(..)` values (paths are resolved relative to your document, so they
// must be built on your side).
#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(header: none, footer: none, margin: 0pt, fill: LeipzigWeiss),
    config,
  )
  let info = self.info + args.named()
  let pad-x = 1.4cm
  let logos = info.at("logos", default: ())
  let talk-place = info.at("place", default: none)

  let meta-line(left, right) = {
    set text(size: date-size, fill: LeipzigSchwarz)
    if left != none and right != none {
      [#left, #right]
    } else if left != none {
      left
    } else if right != none {
      right
    }
  }

  let blocks = ()
  if info.subtitle != none {
    blocks.push(text(size: subtitle-size, fill: LeipzigSchwarz, info.subtitle))
  }
  if info.title != none {
    blocks.push(text(
      size: title-size,
      weight: "bold",
      fill: LeipzigSchwarz,
      upper(info.title),
    ))
  }
  if talk-place != none or info.date != none {
    blocks.push(meta-line(
      talk-place,
      if info.date != none { utils.display-info-date(self) },
    ))
  }
  if info.author != none {
    blocks.push(text(size: date-size, fill: LeipzigSchwarz, info.author))
  }
  if logos != () {
    blocks.push(stack(dir: ltr, spacing: 1cm, ..logos))
  }

  let body = {
    place(top + left, dx: pad-x, dy: 1.2cm, plaque(height: 2.2cm))
    // Anchor the corner accent's right-top to the page's top-right corner.
    // The accent is drawn into a square whose side equals the page height, so
    // it never stretches with the page aspect ratio.
    place(top + right, layout(size => box(
      width: size.height,
      height: size.height,
      corner-design,
    )))
    align(
      horizon + left,
      pad(x: pad-x, stack(dir: ttb, spacing: 0.9em, ..blocks)),
    )
  }
  touying-slide(self: self, body)
})


// Intermission / section slide, generated automatically for every level-1
// heading (`= ...`). A white slide with a large bold black title and the
// `side-design` band on the right (full height, anchored top-right). The
// automatic invocation does not pass a subheader, but it is available when
// calling `intermission` manually.
//
// - subheader (content, none): an optional line shown below the title.
#let intermission(
  config: (:),
  level: 1,
  numbered: false,
  subheader: none,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(fill: LeipzigWeiss, header: none, footer: none, margin: 0pt),
  )
  let slide-body = {
    // Side band, full height, anchored to the page's top-right corner; drawn
    // into a square of the page height so it stays aspect-ratio independent.
    place(top + right, layout(size => box(
      width: size.height,
      height: size.height,
      side-design,
    )))
    set text(fill: LeipzigSchwarz)
    align(
      horizon + left,
      pad(x: 1.4cm, block({
        text(
          size: title-size,
          weight: "bold",
          upper(utils.display-current-heading(level: level, numbered: numbered)),
        )
        if subheader != none {
          linebreak()
          text(size: subtitle-size, subheader)
        }
        if body != none {
          linebreak()
          text(size: subtitle-size, body)
        }
      })),
    )
  }
  touying-slide(self: self, config: config, slide-body)
})


// Filled section slide: the previous intermission design, kept as a reusable
// template. White title on the primary colour, no header or footer.
#let intermission-filled(
  config: (:),
  level: 1,
  numbered: false,
  subheader: none,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.primary, header: none, footer: none),
  )
  let slide-body = {
    set align(horizon + left)
    set text(fill: self.colors.neutral-lightest)
    block({
      text(
        size: title-size,
        weight: "bold",
        upper(utils.display-current-heading(level: level, numbered: numbered)),
      )
      if subheader != none {
        linebreak()
        text(size: subtitle-size, subheader)
      }
      if body != none {
        linebreak()
        text(size: subtitle-size, body)
      }
    })
  }
  touying-slide(self: self, config: config, slide-body)
})


// Focus slide: large centered content on the primary colour, used to draw
// attention to a single statement.
#let focus-slide(
  config: (:),
  background: auto,
  foreground: auto,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if background == auto { self.colors.primary } else { background },
      header: none,
      footer: none,
      margin: 2em,
    ),
  )
  set text(
    fill: if foreground == auto { self.colors.neutral-lightest } else {
      foreground
    },
    weight: "bold",
    size: title-size,
  )
  touying-slide(self: self, config: config, align(center + horizon, body))
})
