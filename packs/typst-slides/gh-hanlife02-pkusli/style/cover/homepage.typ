#import "@preview/touying:0.6.1": *
#import "../shared/base.typ": page-background, page-footer, palette

#let cover-slide(
  title: none,
  subtitle: none,
  author: none,
  institution: none,
  date: none,
  title-size: 2.5em,
  subtitle-size: 1.28em,
  author-size: 1.2em,
  meta-size: 1em,
  title-fill: palette.ink,
  subtitle-fill: palette.primary,
  author-fill: palette.primary,
  meta-fill: palette.muted,
  content-width: 88%,
  content-inset: (x: 0.4em, y: 0.2em),
  subtitle-gap: 0.32em,
  title-line-gap: 0.1em,
  line-width: 38%,
  line-stroke: 1.1pt + palette.line,
  line-author-gap: 0.2em,
  meta-gap: 0.16em,
) = touying-slide-wrapper(self => {
  let config = utils.merge-dicts(
    config-page(
      background: page-background(),
      margin: (top: 1.5em, bottom: 1.5em, x: 1.45em),
      header: self => [],
      footer: self => page-footer(self),
    ),
  )

  touying-slide(
    self: self,
    config: config,
    align(center + horizon)[
      #block(width: content-width, inset: content-inset)[
        #set align(center + horizon)
        #text(size: title-size, weight: "bold", fill: title-fill)[#title]
        #if subtitle != none [
          #v(subtitle-gap)
          #text(size: subtitle-size, fill: subtitle-fill)[#subtitle]
        ]
        #v(title-line-gap)
        #line(length: line-width, stroke: line-stroke)
        #v(line-author-gap)
        #if author != none [
          #text(size: author-size, weight: "bold", fill: author-fill)[#author]
        ]
        #if institution != none [
          #v(meta-gap)
          #text(size: meta-size, fill: meta-fill)[#institution]
        ]
        #if date != none [
          #v(meta-gap)
          #text(size: meta-size, fill: meta-fill)[#date]
        ]
      ]
    ],
  )
})
