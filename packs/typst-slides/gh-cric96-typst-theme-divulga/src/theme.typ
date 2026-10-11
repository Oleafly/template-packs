// divulga — a big-type, image-friendly Touying theme for popular-science talks.
// https://github.com/cric96/typst-theme-divulga
//
// Design rules:
// - few words per slide, set big: the talk carries the content, slides anchor it;
// - one accent colour per part of the talk (set by `part-slide`);
// - dictionary-style definitions, full-bleed images, statements and big numbers.
#import "@preview/touying:0.7.4": *

#let palette = (
  paper: rgb("#F5F3EE"),
  paper-dark: rgb("#ECE8DF"),
  ink: rgb("#121317"),
  ink-soft: rgb("#2A2C33"),
  muted: rgb("#74767D"),
  line: rgb("#D9D4C9"),
  blue: rgb("#2E4BFF"),
  green: rgb("#00A07E"),
  coral: rgb("#FF5233"),
  sun: rgb("#FFC531"),
  violet: rgb("#7A4DFF"),
)

#let fonts = (
  display: ("Space Grotesk", "Inter"),
  body: ("Inter", "Roboto"),
  mono: ("JetBrains Mono", "DejaVu Sans Mono"),
)

// Images: pass `image("photo.jpg")` (works from a package), or a path string
// (only works when the theme files live inside your project).
// Sizing arguments are applied with a set rule, so they reach images built outside.
#let _img(src, ..args) = if type(src) == str {
  image(if src.starts-with("/") { src } else { "/" + src }, ..args)
} else {
  set image(..args)
  src
}

// Current accent colour and part label (updated by `part-slide`).
#let accent = state("divulga-accent", palette.blue)
#let part-label = state("divulga-part", none)

/// Colour the content with the current accent.
#let hl(body) = context text(fill: accent.get(), body)

/// Small uppercase monospaced label.
#let kicker(body, fill: auto) = context text(
  font: fonts.mono,
  size: 0.62em,
  weight: "medium",
  tracking: 0.12em,
  fill: if fill == auto { accent.get() } else { fill },
  upper(body),
)

// `kicker` is shadowed by the argument of `slide`, keep an alias.
#let divulga-kicker = kicker

/// Solid label.
#let pill(body, fill: auto, text-fill: white) = context box(
  fill: if fill == auto { accent.get() } else { fill },
  inset: (x: 0.55em, y: 0.35em),
  text(font: fonts.mono, size: 0.6em, weight: "medium", fill: text-fill, tracking: 0.05em, upper(body)),
)

// ---------------------------------------------------------------------------
// Slides
// ---------------------------------------------------------------------------

#let _footer(self) = context {
  set text(font: fonts.mono, size: 11pt, fill: palette.muted)
  let label = part-label.get()
  pad(x: 2.2em, bottom: 0.9em, grid(
    columns: (1fr, auto),
    align: (left + bottom, right + bottom),
    if label != none { upper(label) },
    utils.slide-counter.display() + " / " + utils.last-slide-number,
  ))
  place(bottom + left, utils.call-or-display(
    self,
    components.progress-bar(height: 3pt, accent.get(), palette.paper-dark),
  ))
}

/// Standard slide: optional kicker + big title + free body.
///
/// - title (content, none): slide title, set big.
/// - kicker (content, auto, none): small label above the title (defaults to the part name).
/// - align (alignment): alignment of the body.
#let slide(
  title: none,
  kicker: auto,
  align: horizon + left,
  fill: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: if fill == auto { palette.paper } else { fill },
      header: none,
      footer: _footer,
      margin: (top: 1.4em, bottom: 2.2em, x: 2.2em),
    ),
  )
  let head = {
    if kicker != none {
      let k = if kicker == auto { context part-label.get() } else { kicker }
      std.align(left, divulga-kicker(k))
      v(-0.2em)
    }
    if title != none {
      block(
        below: 0.9em,
        text(font: fonts.display, size: 1.75em, weight: "bold", tracking: -0.02em, fill: palette.ink, title),
      )
    }
  }
  let new-setting = body => {
    set text(fill: palette.ink)
    show: setting
    head
    block(width: 100%, height: 1fr, std.align(align, body))
  }
  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

/// Title slide. `image` is an optional picture shown on the right (e.g. `image("cover.jpg")`).
#let title-slide(title: [], subtitle: none, author: none, affiliation: none, date: none, image: none) = touying-slide-wrapper(self => {
  let image-path = image
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: palette.ink, header: none, footer: none, margin: 0pt),
  )
  let body = {
    set text(fill: palette.paper)
    if image-path != none {
      place(right, box(width: 42%, height: 100%, clip: true, _img(image-path, width: 100%, height: 100%, fit: "cover")))
      place(right, box(width: 42%, height: 100%, fill: gradient.linear(palette.ink, palette.ink.transparentize(100%), angle: 0deg)))
    }
    place(left + horizon, dx: 2.4em, box(width: if image-path != none { 62% } else { 85% }, {
      stack(
        spacing: 0pt,
        box(width: 3.2em, height: 0.35em, fill: palette.coral),
        h(0.25em),
      )
      v(0.6em)
      text(font: fonts.display, size: 2.3em, weight: "bold", tracking: -0.03em, title)
      if subtitle != none {
        v(0.2em)
        text(size: 1.05em, weight: "light", fill: palette.paper.darken(15%), subtitle)
      }
      v(0.9em)
      set text(font: fonts.mono, size: 0.7em, fill: palette.paper.darken(25%))
      if author != none { text(fill: palette.paper, weight: "bold", author); linebreak() }
      if affiliation != none { affiliation; linebreak() }
      if date != none { date }
    }))
  }
  touying-slide(self: self, body)
})

/// Opens a part of the talk: sets accent colour and footer label.
#let part-slide(number: "01", title: [], subtitle: none, color: palette.blue, label: none, minutes: none) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: color, header: none, footer: none, margin: (x: 2.4em, y: 2em)),
  )
  let body = {
    accent.update(color)
    part-label.update(if label != none { label } else { title })
    set text(fill: white)
    place(top + right, text(font: fonts.display, size: 11em, weight: "bold", fill: white.transparentize(78%), tracking: -0.05em, number))
    place(bottom + left, {
      if minutes != none { pill([#minutes min], fill: white, text-fill: color); v(0.6em) }
      text(font: fonts.display, size: 3.2em, weight: "bold", tracking: -0.03em, title)
      if subtitle != none {
        v(-0.4em)
        text(size: 1.2em, weight: "light", subtitle)
      }
    })
  }
  touying-slide(self: self, body)
})

/// One idea, set huge. `dark: true` for an ink background.
#let statement-slide(body, kicker: none, dark: false, fill: none, size: 2.4em, attribution: none) = touying-slide-wrapper(self => {
  let bg = if fill != none { fill } else if dark { palette.ink } else { palette.paper }
  let fg = if dark or fill != none { white } else { palette.ink }
  self = utils.merge-dicts(
    self,
    config-page(fill: bg, header: none, footer: none, margin: (x: 2.6em, y: 2em)),
  )
  let content = {
    set text(fill: fg)
    show strong: it => context text(fill: if dark { accent.get() } else if fill != none { palette.ink } else { accent.get() }, it.body)
    set std.align(horizon + left)
    if kicker != none { divulga-kicker(kicker, fill: if dark or fill != none { white.transparentize(30%) } else { auto }); v(0.4em) }
    block(width: 90%, text(font: fonts.display, size: size, weight: "bold", tracking: -0.025em, body))
    if attribution != none {
      v(0.6em)
      text(font: fonts.mono, size: 0.75em, fill: fg.transparentize(35%), [— ] + attribution)
    }
  }
  touying-slide(self: self, content)
})

/// Full-bleed photo with an optional caption band. `path`: `image("...")` or a path.
#let image-slide(path, caption: none, kicker: none, credit: none, position: bottom + left, dark: true) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(fill: palette.ink, header: none, footer: none, margin: 0pt),
  )
  let body = {
    place(_img(path, width: 100%, height: 100%, fit: "cover"))
    if caption != none {
      place(bottom, block(width: 100%, height: 55%, fill: gradient.linear(palette.ink.transparentize(100%), palette.ink.transparentize(15%), angle: 90deg)))
      place(position, dx: 2.2em, dy: -1.6em, box(width: 75%, {
        set text(fill: white)
        show strong: it => text(fill: palette.sun, it.body)
        if kicker != none { divulga-kicker(kicker, fill: white.transparentize(25%)); v(0.2em) }
        text(font: fonts.display, size: 2em, weight: "bold", tracking: -0.02em, caption)
      }))
    }
    if credit != none {
      place(bottom + right, dx: -0.8em, dy: -0.5em, text(font: fonts.mono, size: 8pt, fill: white.transparentize(40%), credit))
    }
  }
  touying-slide(self: self, body)
})

/// Image bleeding on one side, text on the other. `path`: `image("...")` or a path.
#let split-slide(path, title: none, kicker: auto, side: left, ratio: 45%, credit: none, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(fill: palette.paper, header: none, footer: _footer, margin: (top: 0pt, bottom: 2.4em, x: 0pt)),
  )
  let pic = box(width: 100%, height: 100%, clip: true, {
    _img(path, width: 100%, height: 100%, fit: "cover")
    if credit != none {
      place(top + right, dx: -0.6em, dy: 0.5em, text(font: fonts.mono, size: 8pt, fill: white.transparentize(30%), credit))
    }
  })
  let txt = pad(x: 1.8em, top: 1.6em, {
    if kicker != none {
      divulga-kicker(if kicker == auto { context part-label.get() } else { kicker })
      v(-0.2em)
    }
    if title != none {
      block(below: 0.8em, text(font: fonts.display, size: 1.75em, weight: "bold", tracking: -0.02em, title))
    }
    body
  })
  let page-body = place(top, dy: 0pt, box(height: 100%, grid(
    columns: if side == left { (ratio, 1fr) } else { (1fr, ratio) },
    rows: 100%,
    ..if side == left { (pic, txt) } else { (txt, pic) },
  )))
  touying-slide(self: self, page-body)
})

// ---------------------------------------------------------------------------
// Building blocks
// ---------------------------------------------------------------------------

/// Dictionary-style definition.
///
/// ```
/// #definition([intelligence], pron: [in·tel·li·gence], kind: [n.])[...]
/// ```
#let definition(term, pron: none, kind: none, size: 3.4em, body) = context {
  let c = accent.get()
  block(width: 100%, {
    text(font: fonts.display, size: size, weight: "bold", tracking: -0.03em, fill: palette.ink, term)
    if pron != none or kind != none {
      v(-0.5em)
      text(font: fonts.mono, size: 0.8em, fill: palette.muted, {
        if pron != none { [/#pron/] }
        if kind != none { h(0.8em); text(style: "italic", kind) }
      })
    }
    v(0.2em)
    block(stroke: (left: 5pt + c), inset: (left: 1em, y: 0.2em), text(size: 1.1em, body))
  })
}

/// Numbered senses for a definition: `#senses[first][second]`.
#let senses(..items) = context {
  let c = accent.get()
  set par(leading: 0.55em)
  for (i, it) in items.pos().enumerate() {
    block(spacing: 0.7em, grid(
      columns: (1.4em, 1fr),
      text(font: fonts.mono, weight: "bold", fill: c, str(i + 1) + "."),
      it,
    ))
  }
}

/// Big figure with a label.
#let big-number(n, label, color: auto, size: 2.8em) = context block({
  text(font: fonts.display, size: size, weight: "bold", tracking: -0.04em, fill: if color == auto { accent.get() } else { color }, n)
  v(-0.5em)
  text(size: 0.8em, fill: palette.ink-soft, label)
})

/// Editorial card: a thick rule on top, no box. `tag` is a small label (or a big number with `number: true`).
#let card(title: none, tag: none, number: false, fill: none, height: auto, body) = context block(
  width: 100%,
  height: height,
  fill: fill,
  stroke: (top: 3pt + accent.get()),
  inset: (top: 0.55em, bottom: if fill != none { 0.6em } else { 0pt }, x: if fill != none { 0.6em } else { 0pt }),
  {
    if tag != none {
      if number {
        text(font: fonts.display, size: 2em, weight: "bold", tracking: -0.04em, fill: accent.get(), tag)
        v(-0.7em)
      } else {
        text(font: fonts.mono, size: 0.62em, weight: "bold", tracking: 0.06em, fill: accent.get(), upper(tag))
        v(-0.3em)
      }
    }
    if title != none {
      text(font: fonts.display, size: 1.05em, weight: "bold", title)
      v(-0.4em)
    }
    text(size: 0.85em, fill: palette.ink-soft, body)
  },
)

/// Big pull quote.
#let quote-block(body, who: none, size: 1.5em) = context grid(
  columns: (auto, 1fr),
  column-gutter: 0.4em,
  align: top,
  text(font: fonts.display, size: size * 2, weight: "bold", fill: accent.get(), top-edge: "cap-height", "“"),
  {
    text(font: fonts.display, size: size, weight: "medium", tracking: -0.01em, body)
    if who != none {
      v(-0.2em)
      text(font: fonts.mono, size: 0.65em, fill: palette.muted, [— ] + who)
    }
  },
)

/// Muted small note (sources, footnotes on the slide).
#let source(body) = place(bottom + right, dy: 0.4em, text(font: fonts.mono, size: 9pt, fill: palette.muted, body))

/// Cropped image (`image("...")` or a path).
#let pic(path, width: 100%, height: auto, radius: 0pt, fit: "cover") = box(
  width: width,
  height: height,
  radius: radius,
  clip: true,
  _img(path, width: 100%, height: if height == auto { auto } else { 100% }, fit: fit),
)

// ---------------------------------------------------------------------------
// Theme entry point
// ---------------------------------------------------------------------------

/// Theme entry point.
///
/// - lang (str): text language (hyphenation, quotes).
/// - font-size (length): base size; everything else scales with it.
/// - accent-color (color): accent before the first `part-slide`.
#let divulga-theme(aspect-ratio: "16-9", lang: "en", font-size: 23pt, accent-color: palette.blue, ..args, body) = {
  set text(font: fonts.body, size: font-size, weight: "regular", lang: lang, fill: palette.ink)
  accent.update(accent-color)
  set par(leading: 0.6em, justify: false)
  set strong(delta: 300)
  show strong: it => context text(fill: accent.get(), weight: "bold", it.body)
  show emph: it => text(style: "italic", it.body)
  set list(marker: context text(fill: accent.get(), sym.square.filled.small), spacing: 0.75em, indent: 0.2em)
  set enum(numbering: n => context text(font: fonts.mono, weight: "bold", fill: accent.get(), str(n)))
  show raw: set text(font: fonts.mono)

  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio),
    config-common(slide-fn: slide, new-section-slide-fn: none),
    config-methods(alert: (self: none, it) => hl(it)),
    ..args,
  )
  body
}
