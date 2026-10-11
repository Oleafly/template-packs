#import "@preview/touying:0.6.1": *
#import "shared/base.typ": palette
#import "subject/subject.typ": subject-slide

#let presentation-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(font: ("Songti SC", "STSong", "Avenir Next", "Helvetica Neue"), size: 15.5pt)
  set par(justify: false, leading: 0.5em)
  set list(marker: ([•], [◦], [▪]))
  show strong: it => text(weight: "bold", fill: palette.primary)[#it.body]

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 1.4em, bottom: 1.2em, x: 1.35em),
    ),
    config-common(
      slide-fn: subject-slide,
    ),
    config-methods(
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: palette.primary,
      secondary: palette.accent,
      neutral-lightest: white,
      neutral-darkest: palette.ink,
    ),
    config-store(
      title: none,
      subtitle: none,
      footer: footer,
      date: none,
      institution: none,
    ),
    ..args,
  )

  body
}
