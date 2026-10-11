#import "@preview/touying:0.6.1": *

// Project
#import "helper.typ": *
#import "logos.typ": *
#import "cover.typ": *

// Core Imports
#import "@preview/codly:1.3.0": * // For bindings
#import "@preview/codly-languages:0.1.8": *
#import "@preview/cetz:0.4.1" // For bindings
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node // For bindings
#import "@preview/tiaoma:0.3.0" // For auto QR generation
#import "@preview/pinit:0.2.2": *
#import "@preview/cheq:0.3.0": checklist
#import "@preview/lovelace:0.3.0": *
#import "@preview/quick-maths:0.2.1": shorthands
#import "@preview/physica:0.9.8": *

//prequery
#import "@preview/prequery:0.2.0": image as prequery_image


// Styling Macro Imports
#import "@preview/showybox:2.0.4": showybox

// -----------------------------------------------------------------------------
// Appendix state
// -----------------------------------------------------------------------------

#let appendix-state = state("appendix-mode", false)
#let slide-tag-state = state("slide-tag-state", ())

// -----------------------------------------------------------------------------
// General Config
// -----------------------------------------------------------------------------

// Touying bindings for cetz
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)

// Touying bindings for fletcher
#let fletcher-diagram = touying-reducer.with(
  reduce: fletcher.diagram,
  cover: fletcher.hide,
)

// -----------------------------------------------------------------------------
// Slide Types
// -----------------------------------------------------------------------------

/// Normal slide for the presentation, with title (header) and footer
///
/// Example:
///
/// ```typst
/// #slide(title: [Slide Title])[
///   #lorem(20)
/// ]
/// ```
///
/// - title (content): Title for the slide
/// - alignment (alignment): Alignment of the contents of the slide
/// - outlined (boolean): If the slide shows on the PDF ToC
///
/// -> content
#let slide(
  title: auto,
  alignment: none,
  outlined: true,
  head: 2,
  size: none,
  spacing: none,
  tag: none,
  ..args,
) = touying-slide-wrapper(self => context {
  let appendix = appendix-state.get()
  let info = self.info + args.named()


  // Header:slide
  // ---------------------------------------------------------------------------
  // [ ] Slide Title                                                [ ] Logo [ ]
  // ---------------------------------------------------------------------------
  //I made a mess but it works fine with 3 logos. To be improved in the future
  let header(self) = {
    // Slide Title: if the user overrides the title of a certain slide, use it
    let hdr = if title != none { title } else { "" }

    let height = 1.4cm
    show heading: set text(size: 24pt, weight: "bold")

    rect(fill: self.colors.primary, height: height, width: 100%, radius: 0pt, [
      #place(horizon)[
        #grid(
          columns: (80%, 20%),
          align: (left + horizon, right + horizon),
          [
            #context {
              if tag != none and not slide-tag-state.get().contains(tag) [
                #heading(
                  level: head,
                  outlined: outlined,
                  [
                    #set text(fill: self.colors.tertiary)
                    #h(7pt)#hdr
                  ],
                )#tag
              ] else [
                #heading(
                  level: head,
                  outlined: outlined,
                  [
                    #set text(fill: self.colors.tertiary)
                    #h(7pt)#hdr
                  ],
                )
              ]
            }
            #slide-tag-state.update(tags => {
              tags.push(tag)
              tags
            })
          ],
          [
            #grid(
              columns: (1fr,) * self.store.logo.len(),
              column-gutter: -6cm + 1.5cm * self.store.logo.len(),
              ..self.store.logo.map(logo => image(logo, height: height * 0.85)),
            )
          ],
        )
      ]
    ])
  }

  // Footer:
  // ---------------------------------------------------------------------------
  // Slide Number [ ] First Author
  // ---------------------------------------------------------------------------
  let footer(self) = context {
    set block(height: 100%, width: 100%)
    set text(size: info.footer_size, fill: self.colors.footer, weight: "medium")

    let scope = (
      title: info.at("title", default: ""),
      authors: info.at("authors", default: ()),
      subtitle: info.at("subtitle", default: ""),
      conference: info.at("conference", default: ""),
      location: info.at("location", default: ""),
      date: info.at("date", default: ""),
    )
    [ #set align(center + bottom)
      #set text(size: info.footer_size)
      #let foot_info = info.at("footer", default: ("", "", ""))
      #rect(fill: white, height: 0.9cm, width: 100%, [
        #place(horizon + left)[
          #grid(
            columns: (1fr, 1fr, 1fr),
            align: (left + horizon, center + horizon, right + horizon),
            column-gutter: 0cm,
            [
              #set align(left + horizon)
              #h(-5pt)
              #box(fill: self.colors.secondary, height: 0.9cm, width: 0.9cm)[
                #set align(center + horizon)
                #set text(weight: "bold", fill: self.colors.tertiary, size: 14pt)
                #utils.slide-counter.display()
              ]
              #place(horizon + left)[
                #h(26pt)
                #eval(foot_info.at(0), mode: "markup", scope: scope)
              ]
            ],
            [
              #place(horizon+center)[
                #eval(foot_info.at(1), mode: "markup", scope: scope)
              ]
            ],
            [
              #place(horizon + right)[
                #eval(foot_info.at(2), mode: "markup", scope: scope)
                #h(5pt)
              ]
            ],
          )
        ]
      ])
    ]


    // Progress bar
    if self.store.progress-bar {
      place(bottom + left, float: false, move(
        dy: 0.61cm, // Bad solution, I know
        components.progress-bar(
          height: 5pt,
          self.colors.secondary,
          white,
        ),
      ))
    }
  }

  set text(size: if size != none { size } else { text.size })
  set par(leading: if spacing != none { spacing } else { par.leading })

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: appendix,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: header,
    footer: footer,
  ))

  set align(
    if alignment == none {
      self.store.default-alignment
    } else {
      alignmentcounter
    },
  )

  touying-slide(self: self, ..args)
})

/// Title slide for the presentation
///
/// Example:
///
/// ```typst
/// #title-slide()
/// ```
///

/// Standout slide for the presentation
///
/// Example:
///
/// ```typst
/// #standout-slide(title: [Text])
/// ```
///
/// - title (content): Title for the standout slide
///
/// -> content
#let standout-slide(
  title: none,
  ..args,
) = touying-slide-wrapper(self => context {
  let appendix = appendix-state.get()
  let body = {
    set align(center + horizon)
    set text(size: 28pt)
    if title != none {
      move(dy: -2.08cm)[
        #text(weight: "semibold")[#title]
      ]
    }
  }

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: appendix,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
  ))

  //counter("touying-slide-counter").update(n => if n > 0 { n - 1 } else { 0 })

  touying-slide(self: self, body, ..args)
})

/// Section slide for the presentation
///
/// Example:
///
/// ```typst
/// #section-slide(title: [Section A], subtitle: [Subtitle])
/// ```
///
/// - title (content): Title for the section
/// - subtitle (content): Subtitle for the section
///
/// -> content
#let section-slide(
  title: none,
  subtitle: none,
  ..args,
) = touying-slide-wrapper(self => context {
  let appendix = appendix-state.get()
  let body = {
    align(center + horizon)[
      #move(dy: -0.4cm)[
        #if title != none [
          #text(size: 36pt, weight: "semibold")[#title]
        ]

        #if subtitle != none [
          #text(size: 20pt)[#subtitle]
        ]
      ]
    ]
  }

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: appendix,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
  ))

  touying-slide(self: self, body, ..args)
})

/// Blank slide for free content in the presentation
///
/// Example:
///
/// ```typst
/// #blank-slide[
///   #align(center + horizon)[#lorem(5)]
/// ]
/// ```
///
/// -> content
#let blank-slide(
  title: none,
  size: 25pt,
  weight: "regular",
  color: none,
  text-color: none,
  tag: none,
  ..args,
  body,
) = touying-slide-wrapper(self => context {
  let appendix = appendix-state.get()
  let c = color
  let tc = text-color
  if color == none {
    c = self.colors.primary
  }
  if text-color == none {
    tc = self.colors.tertiary
  }

  set text(fill: tc, size: size, weight: weight)
  let body = {
    align(center + horizon)[
      #if title != none [
        #set text(size: size * 1.3, weight: "bold", fill: tc)
        #context {
          if tag != none and not slide-tag-state.get().contains(tag) [
            #heading(level: 1, outlined: true)[
              #title
            ]#tag
          ] else [
            #heading(level: 1, outlined: true)[
              #title
            ]
          ]
        }
        #v(1.2cm)
      ]
      #body
    ]
  }

  set list(
    marker: (
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
    ),
    body-indent: 1.2em,
  )

  set enum(
    numbering: n => {
      square(stroke: none, fill: tc, size: 0.53cm)[
        #align(center + horizon)[ #text(size: 12pt, fill: tc)[#n] ]
      ]
    },
    body-indent: 0.6cm,
  )

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: appendix,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
    fill: c,
  ))
  touying-slide(self: self, body, ..args)
})



#let toc-slide(
  size: 20pt,
  weight: "regular",
  color: none,
  text-color: none,
  ..args,
  body,
) = touying-slide-wrapper(self => context {
  let appendix = appendix-state.get()
  let c = color
  let tc = text-color
  if color == none {
    c = self.colors.primary
  }
  if text-color == none {
    tc = self.colors.tertiary
  }
  set text(fill: tc, size: size, weight: weight)
  set list(
    marker: (
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
      (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: tc))),
    ),
    body-indent: 1.2em,
  )

  set enum(
    numbering: n => {
      square(stroke: none, fill: tc, size: 0.53cm)[
        #align(center + horizon)[ #text(size: 12pt, fill: tc)[#n] ]
      ]
    },
    body-indent: 0.6cm,
  )
  let chapters = query(
    heading.where(
      level: 1,
      outlined: true,
    ),
  )

  let body = {
    align(left + horizon)[
      #heading(level: 1, outlined: false)[
        #h(-0.8cm)
        #text(size: size * 1.6, weight: "bold")[Outline]
      ]
      #set text(size: size)
      #v(0.8cm)
      #for (idx, chapter) in chapters.enumerate() [
        #(idx + 1). #chapter.body
        #v(0.4cm)
      ]
      #body
    ]
  }

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: appendix,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
    fill: c,
    margin: (
      left: 3.5cm,
      right: 3.5cm,
      top: 2.6cm,
      bottom: 1.6cm,
    ),
  ))
  touying-slide(self: self, body, ..args)
})


#let backup-cover(
  title: none,
  size: 80pt,
  color: none,
  text-color: none,
  background: "/template/assets/backup_cover.png",
  ..args,
) = touying-slide-wrapper(self => context {
  appendix-state.update(_ => true)

  set page(background: context [
    #image(background, height: page.height)
  ])
  let c = color
  let tc = text-color
  if color == none {
    c = self.colors.primary
  }
  if text-color == none {
    tc = self.colors.tertiary
  }
  let body = {
    align(center + horizon)[
      #set text(size: size, weight: "bold", fill: tc, font: "Verdana", stroke: black + 3pt)
      *BACKUP*
    ]
  }

  let self = utils.merge-dicts(
    self,
    config-common(
      appendix: true,
    ),
  )
  let self = utils.merge-dicts(self, config-page(
    header: none,
    footer: none,
    fill: c,
  ))
  touying-slide(self: self, body, ..args)
})
// -----------------------------------------------------------------------------
// Main Function
// -----------------------------------------------------------------------------

/// Theme cofniguration
///
/// Example:
///
/// ```typst
/// #show: definitely-not-isec-theme.with(
///   aspect-ratio: "16-9",
///   slide-alignment: top,
///   config-info(
///     title: [Long Paper Title \ with One to Three Lines],
///     subtitle: [An optional short subtitle],
///     authors: ([*First Author*], [Second Author], [Third Author]),
///     extra: [SomeConf 2025],
///     footer: [First Author, Second Author, Third Author],
///     download-qr: "",
///   ),
///   config-common(
///     handout: false,
///   ),
///   config-colors(
///   ),
/// )
/// ```
///
/// - aspect-ratio (str): Aspect ratio for the page. See typst documentatin.
/// - slide-alignemnt (alignment): Default alignment for `#slide()`
/// - config-info (dict):
///     - title (content): Title for the presentation
///     - subtitle (content): Subtitle for the presentation
///     - authors (array): Arrray of authors (content)
///     - extra (content): Extra information for the presentation
///     - footer (content): Footer for each `#slide()`
///     - download-qr (str): URL to show on `#title-slide()` with a QR
/// - config-common (dict):
///     - handout (bool): Boolean for handout mode
/// - config-colors (dict): Colors for the presentation
///     - ... see definition of `#definitely-not-isec-theme`
#let definitely-not-isec-theme(
  aspect-ratio: "16-9",
  header: utils.display-current-heading(level: 1),
  font: "Open Sans",
  logo: (cms),
  slide-alignment: top,
  progress-bar: true,
  ..args,
  body,
) = {
  // Touying configuration
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (
        left: 1cm,
        right: 1cm,
        top: 2cm,
        bottom: 1cm,
      ),
    ),
    config-store(
      header: header,
      font: font,
      institute: none,
      logo: logo,
      default-alignment: slide-alignment,
      progress-bar: progress-bar,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: none,
      preamble: {
        codly(
          display-name: true,
          display-icon: true,
          radius: 6pt,
          stroke: 1pt + black,
          smart-indent: true,
          fill: luma(260),
          zebra-fill: luma(250),
          number-format: number => [#text(size: 10pt, fill: gray)[#number]],
          number-align: right + horizon,
          breakable: true,
          inset: 0.25em,
          languages: codly-languages,
        )
      },
    ),
    config-colors(
      // Exported from official template
      tug: rgb("e4154b"),
      primary: rgb("e4154b"),
      footer: rgb("808080"),
      isec: rgb("272733"),
      foot: rgb("e1e1e1"),
      web: rgb("0c5a77"),
      csbme: rgb("19b4e3"),
      arch: rgb("0a98a2"),
      bauw: rgb("d68e23"),
      etec: rgb("68242c"),
      mach: rgb("3066ba"),
      chem: rgb("5e60a8"),
      math: rgb("1e6934"),
      crypto: rgb("a6c947"),
      system: rgb("1171a8"),
      formal: rgb("f7931e"),
      applied: rgb("7d219e"),
      page: rgb("e4154b"),
      fore: rgb("0f0f0f"),
      back: rgb("ffffff"),
      dark: rgb("3b5a70"),
      lite: rgb("eeece1"),
      head: rgb("245b78"),
      body: rgb("e2e9ed"),
      urlA: rgb("0066d8"),
      urlB: rgb("6c2f91"),
      colA: rgb("e4154b"),
      colB: rgb("5191c1"),
      colC: rgb("a5a5a5"),
      colD: rgb("285f82"),
      colE: rgb("78b473"),
      colF: rgb("e59352"),
      tugred: rgb("e4154b"),
      tuggreen: rgb("78b473"),
      tugblue: rgb("285f82"),
      tugyellow: rgb("e59352"),
      tugcyan: rgb("19b4e3"),
      tugpurple: rgb("7d219e"),
      tugviolet: rgb("5e60a8"),
      tugmagenta: rgb("7d219e"),
      tugturquoise: rgb("0a98a2"),
      tugbrown: rgb("68242c"),
      tugblack: rgb("0f0f0f"),
      tugwhite: rgb("ffffff"),
      tuggray: rgb("a5a5a5"),
      tuggrey: rgb("a5a5a5"),
      tugdark: rgb("3b5a70"),
      tugmid: rgb("5191c1"),
      tuglite: rgb("eeece1"),
      main: rgb("e4154b"),
      emph: rgb("285f82"),
      standout: rgb("245b78"),
    ),
    config-methods(
      cover: (self: none, body) => hide(body),
      init: (
        self: none,
        body,
      ) => {
        show: checklist.with(fill: luma(95%), stroke: self.colors.primary, radius: .2em)
        // TUGraz uses Source Sans Pro, but its a licensed Adobe font
        set text(size: 20pt, lang: "en", region: "US", font: font)
        show smallcaps: set text(font: "Latin Modern Roman Caps")

        show emph: it => { text(self.colors.primary, it.body) }
        show cite: it => { text(self.colors.primary, it) }
        show strong: it => { text(weight: "bold", it.body) }
        show figure.where(kind: image): it => align(center)[
          #block(below: 0.65em, it.body)
          #it.caption.body
        ]

        //Links
        show link: underline
        show link: set text(fill: self.colors.urlA)

        // Slide tag references: @label -> Page <n>
        show ref: it => {
          let targets = query(it.target)
          if targets.len() > 0 {
            let target = targets.at(0)
            if target.has("level") {
              if target.level == 1 or target.level == 2 {
                let loc = locate(it.target)
                if loc != none {
                  link(loc)[Pag. #loc.page()]
                } else {
                  it
                }
              }
            } else {
              it
            }
          } else {
            it
          }
        }

        // Bibliography
        set bibliography(title: none, style: "ieee")
        set cite(style: "ieee")
        show bibliography: set par(spacing: 0.4cm)
        show bibliography: set grid(align: top + left)
        show bibliography: set text(17pt)
        show bibliography: t => {
          show grid.cell.where(x: 0): set text(fill: self.colors.primary)
          show grid.cell.where(x: 0): set align(top + left)
          show link: set text(fill: gray)
          t
        }

        // Lists & Enums
        set list(
          marker: (
            (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: self.colors.primary))),
            (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: black))),
            (move(dy: 0.11cm, square(width: 0.4em, height: 0.4em, fill: gray))),
          ),
          body-indent: 0.3cm,
          indent: 0.1cm
        )
        set enum(
          numbering: n => {
            square(stroke: none, fill: self.colors.primary, size: 0.53cm)[
              #align(center + horizon)[ #text(size: 12pt, fill: white)[#n] ]
            ]
          },
          body-indent: 0.3cm,
          indent: 0.1cm
        )

        // Code blocks
        show: codly-init.with()
        show raw.where(block: true): set text(size: 11pt)

        // Hotfixes, the messy part

        // https://github.com/touying-typ/touying/issues/136
        set par(spacing: 0.65em)

        body
      },
    ),
    ..args,
  )

  body
}

// -----------------------------------------------------------------------------
// Macros
// -----------------------------------------------------------------------------

/// Macro for a pdfpc note
///
/// Example:
///
/// ```typst
///   #note("This will show on pdfpc speaker notes")
/// ```
///
/// - text (str): Note for pdfpc
///
/// -> content
#let note(text) = [
  #pdfpc.speaker-note(text)
]

/// Quote block for phrases. Has a color.primary rectangle in the left
///
/// Example:
///
/// ```typst
/// #quote-block[
///   #lorem(10)
/// ]
/// ```
///
/// - top-pad (length): Extra height of the quote colored block
/// - color (color): Color of the quote block
/// - spacing (length): Spacing after the `#quote-block`
///
/// -> content
#let quote-block(
  top-pad: 0.55cm,
  color: none,
  spacing: 0.3cm,
  body,
) = [
  #touying-fn-wrapper((self: none) => [
    // Grid with the design
    #let g(s: 0cm, body) = [
      #grid(
        columns: (0.195cm, auto),
        column-gutter: 0.7cm,
        row-gutter: 0cm,
        [
          #rect(
            fill: if color == none { self.colors.primary } else { color },
            height: s + top-pad,
          )
        ],
        align(horizon, body),
      )
    ]

    // We compute its "auto" heigth and then print it with the correct height
    #layout(size => {
      let (height,) = measure(width: size.width, g(body))
      g(s: height, body)
    })

    #v(spacing)
  ])
]

/// Block with title and content
///
/// Example:
///
/// ```typst
/// #color-block(title: [Advantages])[
///   - A
///   - B
///   - C
/// ]
/// ```
///
/// - title (content): Title for the color block
/// - icon (str): Icon to show at the left of the title (Tableau Icons) https://tabler.io/icons
/// - spacing (length): Spacing before and after the color block
/// - color (color): Color for the title block
/// - color-body (color): Color for the background of the body
///
/// -> content
#let color-block(
  title: [],
  icon: none,
  spacing: 0.78em,
  color: none,
  color-body: none,
  body,
) = [
  #import "@preview/tableau-icons:0.331.0": *
  #touying-fn-wrapper((self: none) => [
    #show emph: it => {
      text(weight: "medium", fill: self.colors.primary, it.body)
    }

    #showybox(
      title-style: (
        color: white,
        sep-thickness: 0pt,
      ),
      frame: (
        //inset: 0.4em,
        radius: 0pt,
        thickness: 0pt,
        border-color: if color == none { self.colors.primary } else { color },
        title-color: if color == none { self.colors.primary } else { color },
        body-color: if color-body == none { self.colors.lite } else { color-body },
        inset: (x: 0.55em, y: 0.65em),
      ),
      above: spacing,
      below: spacing,
      title: if icon == none {
        align(horizon)[#strong(title)]
      } else {
        align(horizon)[
          #draw-icon(icon, height: 1.2em, baseline: 20%, fill: white) #h(0.2cm) #strong[#title]
        ]
      },
      body,
    )
  ])
]

/// Showcase the colors of the slide
///
/// Example:
///
/// ```typst
/// #showcase-colors
/// ```
///
/// -> content
#let showcase-colors = [
  #touying-fn-wrapper((self: none) => [
    #set rect(width: 7.4cm, height: 1.5cm)
    #set text(fill: white)
    #set align(center)
    #grid(
      columns: 3,
      rows: 6,
      column-gutter: 1.8cm,
      row-gutter: 0.05cm,
      align: left,
      rect(fill: self.colors.isec)[isec],
      rect(fill: self.colors.tug)[tug = main],
      rect(fill: self.colors.colA)[colA = tugred],

      rect(fill: self.colors.csbme)[csbme = tugcyan],
      rect(fill: self.colors.fore)[fore],
      rect(fill: self.colors.colB)[colB = tugmid],

      rect(fill: self.colors.crypto)[crypto],
      rect(fill: self.colors.back)[#text(fill: black)[back]],
      rect(fill: self.colors.colC)[colC = tuggray],

      rect(fill: self.colors.system)[system],
      rect(fill: self.colors.foot)[#text(fill: black)[foot]],
      rect(fill: self.colors.colD)[colD = tugblue],

      rect(fill: self.colors.formal)[formal],
      rect(fill: self.colors.emph)[emph],
      rect(fill: self.colors.colE)[colE = tuggreen],

      rect(fill: self.colors.applied)[applied = tugpurple],
      rect(fill: self.colors.lite)[#text(fill: black)[lite]],
      rect(fill: self.colors.colF)[colF = tugyellow],
    )
  ])
]

//vim:tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab colorcolumn=81
#let cols(count, gutter: 1em, align: top, ..cells) = [
  #grid(columns: count, gutter: gutter, align: align, ..cells)
]

#let rows(count, gutter: 1em, align: top, ..cells) = [
  #grid(rows: count, gutter: gutter, align: align, ..cells)
]

#let put(position, body, height: 100%, width: 100%) = {
  block(height: height, width: width)[
    #align(position)[
      #body
    ]
  ]
}

#let bx(position: left, ..any, body) = rect(..any)[
  #align(position)[
    #body
  ]
]

#let pinit-highlight-equation-from(
  height: 2em,
  pos: bottom,
  fill: rgb(0, 180, 255),
  highlight-pins,
  point-pin,
  body,
) = {
  pinit-highlight(..highlight-pins, dy: -0.9em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0.5em } else { -0.9em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      },
    ),
  )
}

#let set_base_imgurl(webeos_base, image_base) = {
  // Define the inner function
  let webeos_image(image_path, ..any) = {
    return prequery_image(webeos_base + image_path, image_base + image_path, ..any)
  }
  // Return the function itself (no parentheses!)
  return webeos_image
}
