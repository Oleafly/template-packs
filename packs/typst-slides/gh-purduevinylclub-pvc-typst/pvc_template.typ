#import "@preview/touying:0.8.0": *

#let maroon = rgb("#2D0A0E")
#let tan = rgb("#DFB75F")
#let offtan = rgb("#FABF33")
#let orange = rgb("#E36E21")
#let offwhite = rgb("#F5F0EA")

// Background band proportions, from the source images.
#let text-header-height = 135 / 540 * 100%
#let title-dark-left = 400 / 960 * 100%
#let title-dark-bottom = 355 / 540 * 100%

// Hi-res logo drawn over the background's copy.
// Slightly oversized to cover the original's blurred edge.
#let logo = context {
  let d = 384 / 960 * page.width
  place(
    top + left,
    dx: 217 / 960 * page.width - d / 2,
    dy: 246.5 / 540 * page.height - d / 2,
    image("resources/pvc_logo.png", width: d),
  )
}

/// Default text slide: tan title band above maroon body.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = block(
    width: 100%,
    height: 100%,
    inset: (x: 2.5em),
    align(horizon, text(
      fill: self.colors.primary,
      size: 2em,
      weight: "bold",
      utils.display-current-heading(level: 2),
    )),
  )
  let self = utils.merge-dicts(
    self,
    config-page(
      background: image("resources/text_slide_bg.png"),
      header: header,
      margin: (top: text-header-height + 1.5em, left: 2.5em, right: 1.5em, bottom: 1.5em),
      header-ascent: 1em,
    ),
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

/// Orange-bordered panel,
/// usually for text content on the side of the slide.
#let boxed(body) = block(
  width: 100%,
  stroke: 2pt + orange,
  inset: (x: 0.6em, y: 0.8em),
  {
    set text(size: 0.8em)
    set par(spacing: 1.3em)
    body
  },
)

/// Full-maroon slide with a tan border and big centered bold tan text.
///
/// Example: `#emphasis-slide[Don't do this.]`
#let emphasis-slide(config: (:), body) = touying-slide-wrapper(self => {
  let border = context {
    let w = 6 / 960 * page.width
    place(top + left, dx: w / 2, dy: w / 2, rect(
      width: 100% - w,
      height: 100% - w,
      stroke: w + tan,
    ))
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.primary, background: border, margin: 2em),
    config,
  )
  touying-slide(self: self, align(center + horizon, text(
    size: 2.4em,
    weight: "bold",
    fill: tan,
    body,
  )))
})

#let list-depth = state("list-depth", 0)

/// Title slide. An optional body (e.g. a photo)
/// is scaled to fit the maroon area right of the logo
/// and outlined in orange.
///
/// Example: `#title-slide(subtitle: [Something else])[#image("photo.jpg")]`
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      background: image("resources/title_slide_bg.png"),
      margin: 0em,
    ),
    config,
  )
  let info = self.info + args.named()
  let extra = args.pos().sum(default: none)
  let label(size, body) = box(
    fill: self.colors.neutral-lightest,
    outset: (x: 0.25em, y: 0.22em),
    text(size: size, fill: self.colors.primary, body),
  )
  // Title block centered on the tan bottom shape.
  let body = (
    logo
      + place(
        top + left,
        dx: title-dark-left,
        block(
          width: 100% - title-dark-left,
          height: title-dark-bottom,
          inset: (x: 2em, y: 1.5em),
          align(center + horizon, if extra != none {
            layout(size => {
              let n = measure(extra)
              let r = calc.min(size.width / n.width, size.height / n.height)
              box(stroke: 5pt + orange, scale(r * 100%, reflow: true, extra))
            })
          }),
        ),
      )
      + place(
        top + left,
        dx: title-dark-left,
        dy: title-dark-bottom,
        block(
          width: 100% - title-dark-left,
          height: 100% - title-dark-bottom,
          align(center + horizon, {
            set par(spacing: 1em)
            label(2.4em, info.title)
            let date = if info.date != none { utils.display-info-date(self) }
            let byline = (info.author, date).filter(x => x != none)
            for line in (info.subtitle, byline.join[ · ]) {
              if line != none {
                parbreak()
                label(1.2em, line)
              }
            }
          }),
        ),
      )
  )
  touying-slide(self: self, body)
})

/// Weekly new releases slide, albums with covers.
///
/// - `featured`: dictionaries with `artist`, `album`, `genres`, `cover`
///   (content, e.g. `image("flash.jpg")`), and
///   `border` (cover outline colour, default black).
/// - `releases`: `(artist, album)` or `(artist, album, kind)` arrays,
///   where `kind` is a tag like `"Single"` or `"EP"`.
/// - `linktree`: `true` shows linktree QR code, `false` shows club logo.
///
/// Example:
/// ```
/// #releases-slide(
///   next-theme: [Halloween Albums],
///   featured: (
///     (cover: image("flash.jpg"), artist: [Bird's Eye Thief], album: [Flash], genres: [IDM, Glitch]),
///   ),
///   releases: (("Tortoise", "Touch"), ("Oneohtrix Point Never", "Tra", "Single")),
/// )
/// ```
#let releases-slide(
  config: (:),
  next-theme: none,
  linktree: true,
  featured: (),
  releases: (),
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(background: image("resources/releases_slide_bg.png"), margin: 0em),
    config,
  )
  // Laid out on a fixed 720×405pt canvas (the 960×540px background at 0.75pt/px)
  // and scaled to the page, so it renders the same at any page size.
  let px(n) = n * 0.75pt
  // Stand-ins for headings with Typst's default per-level heading spacing;
  // real headings would be picked up by touying as slide titles.
  let heading(level, size, body, ..args) = {
    let (above, below) = ((1.8em / 1.4, 0.75em / 1.4), (1.2em, 0.625em), (1.44em, 0.75em)).at(level - 1)
    set text(size: size, weight: "bold", ..args)
    block(above: above, below: below, sticky: true, body)
  }

  let panel = align(center)[
    \
    #heading(1, 22pt, underline[Next Week's Theme:])

    #v(-1em)
    #align(heading(2, 30pt, style: "italic", fill: offtan, next-theme))
    #v(1fr)

    #if linktree [
      #heading(3, 19pt, underline[Linktree:])

      #rect(stroke: px(5) + offtan, inset: 0%)[#image("resources/linktree_qr.png", width: 70%)]
    ] else [
      #image("resources/pvc_logo.png", width: 70%)
    ]
    \
  ]

  let placeholder = box(width: px(161), height: px(161), fill: white, align(center + horizon, text(
    size: 10pt,
    fill: black.transparentize(50%),
  )[No Image]))
  let features = grid(
    columns: (px(161), px(19), px(191)),
    rows: (1fr,) * featured.len(),
    ..featured
      .map(f => (
        align(center + horizon, rect(
          inset: 0%,
          stroke: px(3) + f.at("border", default: black),
          f.at("cover", default: placeholder),
        )),
        [],
        align(left + horizon)[
          #set text(font: "Lora", fill: black)
          #text(size: 18pt)[*#f.artist*] \
          #text(size: 14pt)[#underline(f.album)] \
          #text(size: 10pt)[#emph(f.genres)]
        ],
      ))
      .flatten(),
  )

  let release-list = {
    set text(fill: black)
    v(15pt)
    align(center, heading(1, 22pt, underline[Weekly Releases]))
    v(5pt)
    set text(size: 10pt)
    set list(
      marker: [#h(10pt)#box(width: 10pt, align(center, move(dy: -1pt, scale(130%)[❖])))],
      indent: 0pt,
      body-indent: 0.5em,
      spacing: auto,
    )
    let items = releases.map(((artist, album, ..kind)) => {
      let tag = if kind.len() > 0 [(#kind.first())]
      // Long titles push the tag onto its own line.
      let long = type(album) == str and album.len() > 15
      [*#underline[#artist:]* \ \"#album\" #if tag != none and long [\ ]#tag]
    })
    // Pushing list-depth past 3 opts out of the theme's per-depth list sizing.
    list-depth.update(d => d + 3)
    for item in items {
      list(item)
      v(1fr)
    }
    list-depth.update(d => d - 3)
  }

  touying-slide(self: self, context {
    let k = calc.min(page.width / 720pt, page.height / 405pt)
    scale(k * 100%, origin: top + left, reflow: true, block(width: 720pt, height: 405pt, {
      set text(size: 11pt, font: ("Merriweather", "Zapf Dingbats"), fill: white)
      set par(spacing: 1.2em, leading: 0.65em)
      set underline(offset: auto, stroke: auto)
      grid(
        columns: (px(43), px(268), px(32), px(161 + 19 + 191), px(220), px(26)),
        rows: auto,
        [], panel, [], features, release-list, [],
      )
    }))
  })
})

#let vinyl-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(..utils.page-args-from-aspect-ratio(aspect-ratio)),
    config-common(slide-fn: slide, show-strong-with-alert: false),
    config-colors(
      primary: maroon,
      secondary: tan,
      tertiary: orange,
      neutral-lightest: offwhite,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: ("Merriweather", "Zapf Dingbats"), size: 20pt, fill: self.colors.neutral-lightest)
        show link: set text(fill: self.colors.secondary)
        show link: underline
        set par(spacing: 1em)
        set underline(offset: 0.15em, stroke: 0.06em)
        set list(
          marker: ([❖], [➢], [➢]),
          indent: 0em,
          body-indent: 0.7em,
          spacing: 1.2em,
        )
        set enum(
          numbering: n => text(number-width: "tabular")[#n.],
          indent: 0em,
          body-indent: 0.7em,
          spacing: 1.2em,
        )
        let lists = selector.or(list, enum)
        // Top-level items act as section headings
        show lists: it => {
          list-depth.update(d => d + 1)
          context {
            let depth = list-depth.get()
            if depth == 1 {
              set text(size: 1.3em)
              set list(spacing: 0.9em)
              set enum(spacing: 0.9em)
              it
            } else if depth == 2 {
              set text(size: 1em / 1.3)
              it
            } else if depth == 3 {
              set text(size: 0.9em)
              it
            } else { it }
          }
          list-depth.update(d => d - 1)
        }
        body
      },
      // for `#alert`s
      alert: utils.alert-with-primary-color,
    ),
    ..args,
  )

  body
}
