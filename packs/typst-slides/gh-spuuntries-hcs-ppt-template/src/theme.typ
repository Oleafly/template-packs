#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": *
#import "slides.typ": slide, title-slide, outline-slide, section-slide, focus-slide, blank-slide

#let _hcs-header(self) = {
  let fonts = self.store.at("fonts", default: default-font-presets.modern)
  let title = self.store.at("current-slide-title", default: auto)
  let hdr = if title != auto {
    title
  } else {
    utils.display-current-heading(level: 2)
  }

  // Header layout:
  // Top mini-progress line + breadcrumb
  // Title on left with cyan indicator, HCS logo on right
  block(
    width: 100%,
    inset: (x: 1.5cm, top: 0pt),
    stack(
      spacing: 1.0em,
      // Breadcrumbs / Section category
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #set text(font: fonts.accent, size: 0.68em, fill: hcs-slate-dark, weight: "bold")
          #let sec = utils.display-current-heading(level: 1)
          #if sec != none [ #sec ] else [ #text(fill: hcs-slate-dark.lighten(20%))[AGENDA] ]
        ],
        [
          #box(
            fill: hcs-slate-light,
            radius: 100pt,
            inset: (x: 0.6em, y: 0.18em),
            text(font: fonts.accent, fill: hcs-navy, size: 0.62em, weight: "bold")[HCS SEMINAR]
          )
        ]
      ),
      // Main slide title + logo
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #if hdr != none and hdr != [] and hdr != "" [
            #box(
              stroke: (left: 4.5pt + hcs-cyan-deep),
              inset: (left: 0.6em, y: 0.05em),
              text(font: fonts.heading, size: 1.25em, weight: "bold", fill: hcs-navy, hdr)
            )
          ]
        ],
        [
          #move(dy: -0.15cm, image("assets/hcs-logo.png", height: 1.3em))
        ]
      )
    )
  )
}

#let _hcs-footer(self) = context {
  let fonts = self.store.at("fonts", default: default-font-presets.modern)
  set text(font: fonts.accent, size: 0.72em, fill: hcs-text-muted)

  block(
    width: 100%,
    inset: (x: 1.5cm, bottom: 0.6cm),
    [
      // Segmented accent line inspired by Endfield HUD
      #stack(
        dir: ltr,
        line(stroke: 2.5pt + hcs-navy, length: 2.2em),
        line(stroke: 2.5pt + hcs-blue, length: 2.2em),
        line(stroke: 2.5pt + hcs-cyan-deep, length: 2.2em),
        line(stroke: 1pt + hcs-slate-light, length: 100% - 6.6em),
      )

      #v(0.35em)

      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #let author = self.info.at("author", default: "")
          #let inst = self.info.at("institution", default: "")
          #let title = self.info.at("title", default: "")
          #if author != "" [ #strong(author) ]
          #if inst != "" [ #h(0.4em) · #h(0.4em) #inst ]
          #if title != "" [ #h(0.4em) · #h(0.4em) #title ]
        ],
        [
          // Cute rounded pill slide counter
          #box(
            fill: hcs-navy,
            radius: 100pt,
            inset: (x: 0.7em, y: 0.25em),
            [
              #set text(font: fonts.accent, fill: white, weight: "bold", size: 0.9em)
              #utils.slide-counter.display()
              #text(fill: hcs-slate, weight: "regular")[ \/ #utils.last-slide-number]
            ]
          )
        ]
      )

      // Optional progress bar along the very bottom
      #if self.store.progress-bar {
        place(
          bottom + left,
          float: true,
          move(dy: 0.5cm)[
            #components.progress-bar(
              height: 2pt,
              hcs-cyan-deep,
              hcs-slate-light,
            )
          ]
        )
      }
    ]
  )
}

/// Main HCS Theme function for Touying presentations
#let hcs-theme(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  font-style: "cute", // "cute" | "modern" | "tech"
  font-heading: auto,
  font-body: auto,
  font-code: auto,
  font-accent: auto,
  ..args,
  body,
) = {
  // Extract font configuration if passed via config-fonts()
  let font-config = args.pos().find(item => type(item) == dictionary and "fonts" in item)
  let fonts = if font-config != none {
    font-config.fonts
  } else {
    config-fonts(
      style: font-style,
      heading: font-heading,
      body: font-body,
      code: font-code,
      accent: font-accent,
    ).fonts
  }

  // Update global typography state
  hcs-fonts-state.update(fonts)

  // Document-wide typographic foundations
  set text(font: fonts.body, size: 20pt, fill: hcs-text, lang: "en", number-type: "lining")
  set par(justify: false, leading: 0.7em)
  show heading: set text(font: fonts.heading, fill: hcs-navy)
  show raw: set text(font: fonts.code)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      fill: hcs-bg,
      margin: (top: 3.4cm, bottom: 1.6cm, x: 1.5cm),
      header: _hcs-header,
      footer: _hcs-footer,
      header-ascent: 0.6cm,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: section-slide,
    ),
    config-colors(
      primary: hcs-blue,
      secondary: hcs-navy,
      tertiary: hcs-cyan-deep,
      neutral-darkest: hcs-text,
      neutral-dark: hcs-text-muted,
      neutral-lightest: hcs-bg,
    ),
    config-store(
      navigation: navigation,
      progress-bar: progress-bar,
      current-slide-title: auto,
      current-slide-subtitle: none,
      fonts: fonts,
    ),
    config-methods(
      init: (self: none, body) => {
        let f = if self != none and "fonts" in self.store { self.store.fonts } else { fonts }
        set text(font: f.body, size: 20pt, fill: hcs-text, lang: "en", number-type: "lining")
        set par(justify: false, leading: 0.7em)
        show heading: set text(font: f.heading, fill: hcs-navy)
        show raw: set text(font: f.code)

        // Cute bullet styling
        set list(
          marker: (
            text(fill: hcs-blue, size: 0.75em)[◆],
            text(fill: hcs-navy, size: 0.6em)[▪],
            text(fill: hcs-slate-dark, size: 0.6em)[•],
          ),
          spacing: 0.5em,
          body-indent: 0.6em,
        )

        // Cute numbered list styling
        set enum(
          numbering: n => box(
            fill: hcs-blue,
            radius: 100pt,
            inset: (x: 0.45em, y: 0.15em),
            text(font: f.accent, fill: white, size: 0.75em, weight: "bold")[#n]
          ),
          spacing: 0.5em,
          body-indent: 0.6em,
        )

        // Codly code block initialization
        show: codly-init.with()
        codly(
          stroke: 1pt + hcs-slate-light,
          radius: 5pt,
          fill: hcs-surface,
          zebra-fill: hcs-bg-tint,
          display-name: false,
          display-icon: false,
          number-format: n => text(font: f.code, fill: hcs-slate-dark, size: 0.75em)[#n],
        )

        // Links and emphasis
        show link: set text(fill: hcs-blue)
        show emph: it => text(fill: hcs-navy, style: "italic", it.body)
        show strong: it => text(fill: hcs-navy, weight: "bold", it.body)

        body
      },
    ),
    ..args,
  )

  body
}
