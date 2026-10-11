#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "config.typ": *

#let slide-title(title) = {
  text(size: 25pt, weight: "bold", fill: brand-ink)[#title]
  v(0.25em)
  rect(width: 3.2em, height: 2.4pt, fill: brand-accent, stroke: none)
  v(0.55em)
}

#let beamer-block(title: none, body: none, kind: "normal") = {
  let accent = if kind == "alert" {
    rgb("#d43d2f")
  } else if kind == "example" {
    brand-accent
  } else {
    brand-primary
  }
  let fill = if kind == "alert" {
    rgb("#fff4f2")
  } else if kind == "example" {
    rgb("#fff7ef")
  } else {
    brand-surface
  }

  block(
    fill: fill,
    stroke: 0.8pt + accent,
    inset: 1em,
    radius: 7pt,
    width: 100%,
  )[
    #if title != none [
      #text(size: 18pt, weight: "bold", fill: accent)[#title]
      #v(0.45em)
    ]
    #if body != none [
      #body
    ]
  ]
}

#let callout(title: none, body: none, kind: "normal") = beamer-block(
  title: title,
  body: body,
  kind: kind,
)

#let icon(name, size: 1.1em) = image(
  "../assets/icons/" + name + ".svg",
  width: size,
  height: size,
)

#let title-slide(
  title: deck-title,
  subtitle: deck-subtitle,
  author: deck-author,
  date: deck-date,
) = slide[
  #grid(columns: (1.1fr, 0.9fr), gutter: 2em)[
    #v(1.2em)
    #text(size: 15pt, weight: "bold", fill: brand-accent)[Sample deck]
    #v(0.65em)
    #text(size: 39pt, weight: "bold", fill: brand-primary)[#title]
    #v(0.45em)
    #text(size: 19pt, fill: brand-muted)[#subtitle]
    #v(1.5em)
    #text(size: 15pt, fill: brand-ink)[#author]
    #h(0.7em)
    #text(size: 13pt, fill: brand-muted)[#date]
  ][
    #v(1.4em)
    #beamer-block(
      title: [今日決めること],
      body: [
        - 対象範囲
        - 初回ゴール
        - 次の担当
      ],
      kind: "example",
    )
  ]
]

#let section-slide(title: none, kicker: none) = slide[
  #align(horizon)[
    #block(fill: brand-primary, inset: 1.2em, radius: 8pt, width: 100%)[
      #if kicker != none [
        #text(size: 15pt, fill: white, weight: "bold")[#kicker]
        #v(0.6em)
      ]
      #text(size: 36pt, fill: white, weight: "bold")[#title]
    ]
  ]
]

#let message-slide(title: none, message: none, note: none) = slide[
  #slide-title(title)
  #block(fill: brand-surface, inset: 1em, radius: 8pt, width: 100%)[
    #text(size: 29pt, weight: "bold", fill: brand-primary)[#message]
  ]
  #if note != none [
    #v(0.7em)
    #text(size: 16pt, fill: brand-muted)[#note]
  ]
]

#let bullets-slide(title: none, bullets: (), lead: none) = slide[
  #slide-title(title)
  #if lead != none [
    #text(size: 17pt, fill: brand-muted)[#lead]
    #v(0.6em)
  ]
  #for item in bullets [
    #grid(columns: (1.3em, 1fr), gutter: 0.6em)[
      #text(size: 18pt, fill: brand-accent, weight: "bold")[●]
    ][
      #text(size: 18pt)[#item]
    ]
    #v(0.35em)
  ]
]

#let two-column-slide(
  title: none,
  left-title: none,
  left: none,
  right-title: none,
  right: none,
) = slide(composer: (1fr, 1fr))[
  #slide-title(title)
  #if left-title != none [
    #text(weight: "bold", fill: brand-primary)[#left-title]
    #v(0.4em)
  ]
  #left
][
  #v(3.2em)
  #if right-title != none [
    #text(weight: "bold", fill: brand-primary)[#right-title]
    #v(0.4em)
  ]
  #right
]

#let block-slide(title: none, block-title: none, body: none, kind: "normal") = slide[
  #slide-title(title)
  #v(0.8em)
  #beamer-block(title: block-title, body: body, kind: kind)
]

#let agenda-slide(title: [本日の流れ], items: (), lead: none) = slide[
  #slide-title(title)
  #if lead != none [
    #text(size: 16pt, fill: brand-muted)[#lead]
    #v(0.55em)
  ]
  #for item in items [
    #block(fill: brand-surface, inset: 0.55em, radius: 6pt, width: 100%)[
      #text(size: 18pt, weight: "bold", fill: brand-ink)[#item]
    ]
    #v(0.3em)
  ]
]

#let comparison-slide(
  title: none,
  left-title: none,
  left: none,
  right-title: none,
  right: none,
  left-kind: "normal",
  right-kind: "example",
) = slide[
  #slide-title(title)
  #grid(columns: (1fr, 1fr), gutter: 1.2em)[
    #beamer-block(title: left-title, body: left, kind: left-kind)
  ][
    #beamer-block(title: right-title, body: right, kind: right-kind)
  ]
]

#let process-slide(title: none, lead: none, steps: ()) = slide[
  #slide-title(title)
  #if lead != none [
    #text(size: 16pt, fill: brand-muted)[#lead]
    #v(0.55em)
  ]
  #for step in steps [
    #grid(columns: (1.8em, 1fr), gutter: 0.55em)[
      #align(center)[
        #block(fill: brand-primary, inset: 0.32em, radius: 99pt)[
          #text(size: 15pt, fill: white, weight: "bold")[→]
        ]
      ]
    ][
      #block(fill: brand-surface, inset: 0.55em, radius: 6pt, width: 100%)[
        #step
      ]
    ]
    #v(0.3em)
  ]
]

#let timeline-slide(title: none, lead: none, events: ()) = slide[
  #slide-title(title)
  #if lead != none [
    #text(size: 16pt, fill: brand-muted)[#lead]
    #v(0.55em)
  ]
  #for event in events [
    #grid(columns: (1em, 1fr), gutter: 0.6em)[
      #text(size: 18pt, fill: brand-accent)[●]
    ][
      #block(fill: brand-surface, inset: 0.55em, radius: 6pt, width: 100%)[
        #event
      ]
    ]
    #v(0.3em)
  ]
]

#let metric-slide(title: none, metric: none, label: none, note: none) = slide[
  #slide-title(title)
  #align(center + horizon)[
    #text(size: 52pt, weight: "bold", fill: brand-primary)[#metric]
    #v(0.45em)
    #if label != none [
      #text(size: 21pt, weight: "bold", fill: brand-ink)[#label]
    ]
    #if note != none [
      #v(0.6em)
      #text(size: 15pt, fill: brand-muted)[#note]
    ]
  ]
]

#let image-slide(
  title: none,
  path: none,
  caption: none,
  image-width: 82%,
) = slide[
  #slide-title(title)
  #align(center)[
    #if path != none [
      #image(path, width: image-width)
    ]
    #if caption != none [
      #v(0.6em)
      #text(size: 15pt, fill: brand-muted)[#caption]
    ]
  ]
]

#let takeaway-slide(title: [結論], message: none, next: none) = slide[
  #align(center + horizon)[
    #text(size: 18pt, weight: "bold", fill: brand-accent)[#title]
    #v(0.8em)
    #text(size: 34pt, weight: "bold", fill: brand-primary)[#message]
    #if next != none [
      #v(1.2em)
      #align(left)[
        #beamer-block(title: [次にやること], body: next, kind: "example")
      ]
    ]
  ]
]
