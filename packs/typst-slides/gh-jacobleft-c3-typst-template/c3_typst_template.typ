#import "@preview/touying:0.7.3": *

#let asset-root = "c3_template_media"
#let logo-c3 = asset-root + "/image4.png"
#let logo-curi = asset-root + "/image3.jpeg"
#let logo-mae = asset-root + "/image2.png"
#let logo-cuhk = asset-root + "/image1.png"

#let theme-font-heading = "Raleway"
#let theme-font-body = "Lato"
#let theme-ink = rgb(26, 26, 26)
#let theme-muted = rgb(95, 95, 95)
#let theme-soft = rgb(246, 247, 248)
#let theme-paper = rgb(252, 252, 251)
#let theme-line = rgb(218, 221, 224)
#let theme-c3-purple = rgb(112, 48, 160)
#let theme-c3-orange = rgb(255, 153, 0)
#let theme-c3-orange-light = rgb(251, 174, 64)
#let theme-c3-nav = rgb(231, 230, 230)
#let theme-gray = rgb(86, 86, 86)
#let theme-gray-dark = rgb(55, 55, 55)

#let navigation-logo-cluster() = align(right + horizon)[
  #stack(
    dir: ltr,
    spacing: 0.24cm,
    image(logo-c3, height: 0.82cm),
    image(logo-curi, height: 0.82cm),
    image(logo-mae, height: 0.82cm),
    image(logo-cuhk, height: 0.82cm),
  )
]

// Signature brand mark: two horizontal segments — orange then purple —
// joined end-to-end, mirroring the C3 group-meeting PowerPoint title underline.
#let c3-pinstripe(seg-width: 1.48cm, thick: 0.07cm) = stack(
  dir: ltr,
  spacing: 0pt,
  rect(width: seg-width, height: thick, fill: theme-c3-orange),
  rect(width: seg-width, height: thick, fill: theme-c3-purple),
)

#let left-navigation(
  self: none,
  short-heading: true,
  primary: white,
  secondary: gray,
  background: black,
  logo: none,
) = (
  context {
    let body() = {
      let sections = query(heading.where(level: 1, outlined: true))
      if sections.len() == 0 {
        return
      }
      let current-page = here().page()
      set text(size: 0.62em, weight: "medium")
      for (section, next-section) in sections.zip(sections.slice(1) + (none,)) {
        let active = (
          section.location().page() <= current-page
          and (
            next-section == none
              or current-page < next-section.location().page()
          )
        )
        set text(
          fill: if active { primary } else { secondary },
          weight: if active { "bold" } else { "regular" },
        )
        box(inset: (x: 0.48em, y: 0.3em))[
          #link(
            section.location(),
            if short-heading {
              utils.short-heading(self: self, section)
            } else {
              section.body
            },
          )<touying-link>
        ]
      }
    }
    block(
      fill: background,
      inset: 0pt,
      outset: 0pt,
      grid(
        align: left + horizon,
        columns: (1fr, auto),
        rows: 1.42em,
        gutter: 0em,
        grid.cell(
          fill: background,
          body(),
        ),
        block(fill: background, inset: (right: 0.25em), height: 100%, text(
          fill: primary,
          logo,
        )),
      ),
    )
  }
)

#let _tblock(self: none, title: none, it) = {
  grid(
    columns: 1,
    row-gutter: 0pt,
    block(
      fill: self.colors.primary-dark,
      width: 100%,
      radius: (top: 6pt),
      inset: (top: 0.34em, bottom: 0.28em, left: 0.62em, right: 0.62em),
      text(font: theme-font-heading, fill: self.colors.neutral-lightest, weight: "bold", title),
    ),

    rect(
      fill: gradient.linear(
        self.colors.primary-dark,
        self.colors.primary.lighten(88%),
        angle: 90deg,
      ),
      width: 100%,
      height: 4pt,
    ),

    block(
      fill: self.colors.primary.lighten(91%),
      width: 100%,
      radius: (bottom: 6pt),
      inset: (top: 0.42em, bottom: 0.5em, left: 0.62em, right: 0.62em),
      it,
    ),
  )
}

#let tblock(title: none, it) = touying-fn-wrapper(_tblock.with(
  title: title,
  it,
))

#let text-panel(body) = block(
  width: 100%,
  fill: theme-soft,
  stroke: (paint: theme-line, thickness: 0.6pt),
  radius: 5pt,
  inset: (x: 0.52em, y: 0.42em),
)[#body]

#let eq-panel(body) = block(
  width: 100%,
  fill: theme-paper,
  stroke: (paint: theme-line, thickness: 0.6pt),
  radius: 5pt,
  inset: (x: 0.42em, y: 0.34em),
)[
  #set text(size: 0.84em, fill: theme-ink)
  #align(center)[#body]
]

#let fig-card(path, caption, height: 100%) = block(width: 100%, height: height)[
  #grid(
    rows: (1fr, auto),
    row-gutter: 0.08cm,
    [#image(path, width: 100%, height: 100%, fit: "contain")],
    [#align(center)[#text(font: theme-font-body, size: 0.62em, fill: theme-muted)[#caption]]],
  )
]

#let pair-card(left-path, left-caption, right-path, right-caption, height: 100%) = block(width: 100%, height: height)[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr,),
    column-gutter: 0.24cm,
    fig-card(left-path, left-caption),
    fig-card(right-path, right-caption),
  )
]

#let triple-card(a-path, a-caption, b-path, b-caption, c-path, c-caption, height: 100%) = block(width: 100%, height: height)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (1fr,),
    column-gutter: 0.18cm,
    fig-card(a-path, a-caption),
    fig-card(b-path, b-caption),
    fig-card(c-path, c-caption),
  )
]

#let slide(
  title: auto,
  header: auto,
  footer: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  if title != auto {
    self.store.title = title
  }
  if header != auto {
    self.store.header = header
  }
  if footer != auto {
    self.store.footer = footer
  }
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
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

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(
      self,
      config,
      config-page(
        fill: theme-c3-nav,
        header: self => {
          set std.align(top)
          block(
            width: 100%,
            fill: white,
            inset: (top: 0.45em, bottom: 0.45em, right: 1.85em),
          )[
            #navigation-logo-cluster()
          ]
        },
        margin: (top: 2.4em, bottom: 2em, x: 2.15em),
      ),
    )
    self.store.title = none
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
      show: std.align.with(left + horizon)
      block(
        width: 100%,
        inset: (left: 1.5em, top: 0.6em, right: 1em),
        stack(
          dir: ttb,
          spacing: 0.55em,
          text(
            font: theme-font-heading,
            size: 28pt,
            fill: theme-ink,
            weight: "bold",
            info.title,
          ),
          c3-pinstripe(),
          ..info.authors.map(author => text(
            font: theme-font-heading,
            size: 20pt,
            fill: theme-ink,
            author,
          )),
        ),
      )
      if info.institution != none {
        v(0.45em)
        block(
          width: 100%,
          inset: (left: 1.5em, right: 1em),
          text(
            font: theme-font-heading,
            size: 16pt,
            fill: theme-gray,
            style: "italic",
            info.institution,
          ),
        )
      }
      if extra != none {
        v(0.45em)
        block(
          width: 100%,
          inset: (left: 1.5em, right: 1em),
          text(size: 0.8em, extra),
        )
      }
    }
    touying-slide(self: self, body)
  },
)

#let outline-slide(
  config: (:),
  title: utils.i18n-outline-title,
  numbered: true,
  level: none,
  ..args,
) = touying-slide-wrapper(self => {
  self.store.title = title
  touying-slide(
    self: self,
    config: config,
    std.align(
      left + horizon,
      components.adaptive-columns(
        text(
          fill: self.colors.primary,
          weight: "bold",
          components.custom-progressive-outline(
            level: level,
            alpha: self.store.alpha,
            indent: (0em, 1em),
            vspace: (.4em,),
            numbered: (numbered,),
            depth: 1,
            ..args.named(),
          ),
        ),
      )
        + args.pos().sum(default: none),
    ),
  )
})

#let new-section-slide(
  config: (:),
  title: utils.i18n-outline-title,
  level: 1,
  numbered: true,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  // Section divider uses reversed colors: white nav strip on an off-white slide.
  self.store.nav-fill = white
  self = utils.merge-dicts(self, config-page(fill: theme-c3-nav))
  self.store.title = title
  touying-slide(
    self: self,
    config: config,
    std.align(
      left + horizon,
      components.adaptive-columns(
        text(
          fill: self.colors.primary,
          weight: "bold",
          components.custom-progressive-outline(
            level: level,
            alpha: self.store.alpha,
            indent: (0em, 1em),
            vspace: (.4em,),
            numbered: (numbered,),
            depth: 1,
            ..args.named(),
          ),
        ),
      )
        + args.pos().sum(default: none),
    ),
  )
})

#let focus-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.primary,
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.5em)
  touying-slide(self: self, config: config, std.align(align, body))
})

#let c3-theme(
  aspect-ratio: "16-10",
  align: top + left,
  alpha: 20%,
  title: self => utils.display-current-heading(depth: self.slide-level),
  header-right: self => navigation-logo-cluster(),
  progress-bar: false,
  ..args,
  body,
) = {
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 0.4em,
      utils.call-or-display(self, self.store.navigation),
      utils.call-or-display(self, self.store.header),
    )
  }
  let footer(self) = {
    block(width: 100%, inset: (x: 2em, bottom: 0.46em))[
      #utils.call-or-display(self, self.store.footer)
    ]
  }

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header: header,
      footer: footer,
      header-ascent: 0em,
      footer-descent: 0.08em,
      margin: (top: 4.7em, bottom: 1.8em, x: 2.15em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: theme-font-body, size: 18.5pt, fill: theme-ink)
        set par(justify: false, leading: 0.62em)
        set list(marker: components.knob-marker(primary: self.colors.primary))
        show figure.caption: set text(size: 0.6em)
        show footnote.entry: set text(size: 0.6em)
        show strong: set text(fill: theme-ink, weight: "bold")
        show heading: set text(font: theme-font-heading, fill: theme-ink, weight: "bold")
        show link: it => if type(it.dest) == str {
          set text(fill: self.colors.primary)
          it
        } else {
          it
        }
        show figure.where(kind: table): set figure.caption(position: top)

        body
      },
      alert: utils.alert-with-primary-color,
      tblock: _tblock,
    ),
    config-colors(
      primary: theme-ink,
      primary-dark: theme-gray-dark,
      secondary: rgb("#ffffff"),
      tertiary: theme-c3-orange,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: theme-ink,
    ),
    config-store(
      align: align,
      alpha: alpha,
      title: title,
      header-right: header-right,
      progress-bar: progress-bar,
      navigation: self => {
        let nav-fill = self.store.at("nav-fill", default: theme-c3-nav)
        block(
          width: 100%,
          fill: nav-fill,
          inset: (top: 0.45em, bottom: 0.45em),
        )[
          #set text(font: theme-font-heading, size: 17.8pt, fill: theme-ink)
          #std.align(left + horizon)[
            #left-navigation(
              self: self,
              primary: theme-ink,
              secondary: theme-muted,
              background: nav-fill,
              logo: utils.call-or-display(self, self.store.header-right),
            )
          ]
        ]
      },
      header: self => if self.store.title != none {
        block(
          width: 100%,
          inset: (left: 1.6em, right: 1.6em, top: 0.08em, bottom: 0.26em),
        )[
          #stack(
            dir: ttb,
            spacing: 0.3cm,
            text(
              font: theme-font-heading,
              fill: theme-ink,
              weight: "bold",
              size: 21.5pt,
              utils.call-or-display(self, self.store.title),
            ),
            c3-pinstripe(),
          )
        ]
      },
      footer: self => std.align(right)[#text(
        font: theme-font-body,
        size: 9.2pt,
        fill: theme-muted,
        context utils.slide-counter.display(),
      )],
    ),
    ..args,
  )

  body
}
