// Unofficial, logo-free academic slide theme inspired by HIT Shenzhen.
// Pass logo content explicitly when you are authorized to use a school mark.
#import "@preview/touying:0.7.4": *
#import themes.simple: *

#let hit-blue = rgb("#005375")
#let ink = rgb("#172632")
#let muted = rgb("#53616c")
#let hairline = rgb("#cbd6dc")
#let pale-blue = rgb("#eaf1f4")

#let hitsz-theme(body) = {
  show: simple-theme.with(
    aspect-ratio: "16-9",
    header: none,
    header-right: none,
    footer: none,
    footer-right: none,
    primary: hit-blue,
    config-page(margin: 1em),
  )
  set text(font: "Noto Sans CJK SC", fill: ink, size: 20pt)
  set par(justify: false, leading: .32em)
  body
}

#let brand(name, logo: none, color: hit-blue, size: 15pt) = {
  if logo == none {
    text(size: size, weight: "bold", fill: color)[#name]
  } else {
    logo
  }
}

#let cover-slide(
  title,
  kind: [学术汇报],
  school: [哈尔滨工业大学（深圳）],
  author: none,
  program: none,
  advisor: none,
  date: none,
  logo: none,
) = slide(config: config-common(
  freeze-slide-counter: true,
  zero-margin-header: true,
  zero-margin-footer: true,
) + config-page(margin: 0pt, header: none, footer: none, fill: hit-blue))[
  #set text(font: "Noto Sans CJK SC", fill: ink)
  #place(top + left, dy: -30pt)[#rect(width: 100%, height: 124pt, fill: hit-blue)]
  #grid(
    columns: (1fr,),
    rows: (94pt, 329pt, 20pt),
    row-gutter: 0pt,
    fill: (x, y) => if y == 1 { white } else { hit-blue },
    [
      #pad(left: 44pt, top: 27pt)[
        #brand(school, logo: logo, color: white, size: 21pt)
      ]
    ],
    [
      #align(center + horizon)[
        #text(size: 31pt, weight: "bold")[#title]
        #v(23pt)
        #line(length: 76%, stroke: hairline + 1pt)
        #v(19pt)
        #text(size: 21pt, fill: hit-blue)[#kind]
        #v(13pt)
        #grid(
          columns: (auto, auto),
          gutter: 65pt,
          [#if author != none { [*汇报人：* #author] }],
          [#if advisor != none { [*指导教师：* #advisor] }],
        )
        #v(15pt)
        #text(size: 15pt, fill: muted)[#program · #date]
      ]
    ],
    [],
  )
]

#let slide-heading(
  title,
  school: [哈尔滨工业大学（深圳）],
  logo: none,
  title-size: 29pt,
) = [
  #grid(
    columns: (1fr, 220pt),
    gutter: 10pt,
    [#text(size: title-size, weight: "bold")[#title]],
    [#align(right)[#brand(school, logo: logo, size: 14pt)]],
  )
  #v(6pt)
  #line(length: 100%, stroke: hit-blue + 1.5pt)
  #v(13pt)
]

#let slide-number() = place(bottom + right)[
  #text(size: 11pt, fill: muted)[#context counter(page).display()]
]

#let content-slide(
  title,
  body,
  school: [哈尔滨工业大学（深圳）],
  logo: none,
  title-size: 29pt,
  source: none,
) = slide[
  #set text(font: "Noto Sans CJK SC", fill: ink, size: 19pt)
  #slide-number()
  #slide-heading(title, school: school, logo: logo, title-size: title-size)
  #body
  #if source != none {
    v(1fr)
    text(size: 12pt, fill: muted)[#source]
  }
]

#let figure-slide(
  title,
  body,
  school: [哈尔滨工业大学（深圳）],
  logo: none,
  title-size: 29pt,
) = slide[
  #set text(font: "Noto Sans CJK SC", fill: ink, size: 18pt)
  #slide-number()
  #slide-heading(title, school: school, logo: logo, title-size: title-size)
  #body
]

#let kicker(body) = text(size: 16pt, fill: hit-blue, weight: "bold")[#body]
#let subdued(body) = text(fill: muted)[#body]
#let emphasis(body) = text(fill: hit-blue, weight: "bold")[#body]
