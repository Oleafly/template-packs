#import "@preview/touying:0.7.4": *
#import "presentation-boxes.typ": *
#import "presentation-slides.typ": *

#let presentation(
  aspect-ratio: "16-9",
  lang: "fr",
  navigation: "topbar",
  ..args,
  body
) = {
  show: touying-slides.with(
    config-info(
      title: none,
      short-title: none,
      author: none,
      institution: none,
      font: "Lato",
      math-font: "Lete Sans Math",
      code-font: "DejaVu Sans Mono",
      logo: image("resources/assets/logo_cnam_lmssc.png"),
      footer-logo: image("resources/assets/lecnam.png"),
      title-logo-height: 4em
    ),

    config-colors(
      primary: rgb("#c1002a"),
      secondary: rgb("#405a68"),
      background: rgb("#405a68").lighten(95%),
      box: rgb("#405a68"),
      info: rgb("#c1002a"),
      tip: rgb(31, 136, 61),
      important: rgb(9, 105, 218),
      question: rgb(130, 80, 223),
    ),

    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 30%,
      footer-descent: 30%,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),

    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),

    config-methods(
      init: (self: none, body) => {
        set text(font: self.info.font, size: 20pt, lang: lang, ligatures: false)
        show math.equation: set text(font: self.info.math-font)
        show raw: set text(font: self.info.code-font)
        set par(justify: true)

        set list(marker: ([#text(fill:self.colors.primary)[#sym.bullet]], [#text(fill:self.colors.primary)[#sym.triangle.filled.small.r]], [#text(fill:self.colors.primary)[#sym.square.filled]]))
        let list-counter = counter("list")
        show list: it => context {
          list-counter.step()
          let lc = list-counter.get().first() + 1
          set text(size: 1em - (lc - 1)*0.05em)
          it
          list-counter.update(i => i - 1)
        }

        set enum(numbering: n => text(fill:self.colors.primary)[#n.])

        // Footnote configuration
        set footnote.entry(separator: none)
        show footnote: set text(fill: self.colors.primary)
        show footnote.entry: it => {
          let loc = it.note.location()
          let cfoot = counter(footnote).at(loc).first()
          set text(size: 0.8em, style: "italic")

          v(-1.25em)
          [#super[#text(fill: self.colors.primary)[#cfoot]] #it.note.body]
          v(1em)
        }

        //  Link styling
        show link: set text(fill: self.colors.primary)
        set heading(numbering: "1.")

        body
      }
    ),

    config-store(
      align: align,
      lang: lang,
      navigation: navigation,
      mini-slides: (display-section: false, display-subsection: true, short-heading: false),
      sec-count: counter("sec-count"),
      app-count: counter("app-count"),
    ),
    ..args,
  )

  body
}