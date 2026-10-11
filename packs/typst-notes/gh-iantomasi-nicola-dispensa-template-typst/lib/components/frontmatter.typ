#import "../theme.typ": *
#import "../state.typ": course-info
#import "../i18n.typ": t

// Autore/data/CFU, badge versione e titolo, sopra il frontespizio.
#let title-block(title: none, author: none, date: none, cfu: none, version: none) = block(
  width: 100%,
)[
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(font: f-mono, size: 6.3pt, tracking: 0.1em, fill: c-gray)[
      #upper(author) #h(4pt) · #h(4pt) #upper(date) #h(4pt) · #h(4pt) #cfu CFU
    ],
    box(stroke: 0.4pt + c-ink, inset: (x: 6pt, y: 3pt))[
      #text(
        font: f-mono,
        size: 6.3pt,
        tracking: 0.05em,
        fill: c-ink,
      )[#version]
    ],
  )

  #v(6pt)
  #text(font: f-sans-bold, size: 14pt, fill: c-ink)[#title]
]

// Introduzione, mappa argomenti (colonne), fonti principali, fair use,
// licenza, feedback. Ogni sezione compare solo se i relativi dati sono
// stati forniti in config.typ.
#let frontmatter() = context [
  #let d = course-info.get()
  #let lang = d.lang

  #heading(numbering: none, outlined: false)[#t("before-you-start", lang: lang)]

  #if d.intro != none [
    #v(2pt)
    #block(width: 100%)[
      #set text(font: f-serif, size: 7pt, fill: c-body)
      #d.intro
    ]
  ]

  #if d.topics.len() > 0 [
    #v(6pt)
    #text(font: f-mono, size: 7.2pt, tracking: 0.1em, fill: c-ink)[#t(
      "contents",
      lang: lang,
    )]
    #v(1pt)
    #grid(
      columns: (1fr,) * d.topics.len(),
      gutter: 2pt,
      ..d.topics.map(topic => [
        #text(font: f-sans-bold, size: 7pt, fill: c-ink)[#topic.title]
        #v(1pt)
        #set text(font: f-serif, size: 6pt, fill: c-body)
        #for item in topic.items [- #item]
      ]),
    )
  ]

  #if d.sources.len() > 0 [
    #v(6pt)
    #text(font: f-mono, size: 6.3pt, tracking: 0.1em, fill: c-ink)[#t(
      "main-sources",
      lang: lang,
    )]
    #v(2pt)
    #set text(font: f-serif, size: 6.9pt, fill: c-body)
    #set par(leading: 2.6pt, spacing: 3pt)

    #enum(..d.sources.map(key => [
      #box[#cite(label(key), form: "full", style: "apa")] #box[#cite(label(key))]
    ]))

    #v(2pt)
    #text(font: f-serif, size: 6.9pt, fill: c-gray, style: "italic")[#t(
      "sources-note",
      lang: lang,
    )]
  ]

  #v(6pt)
  #line(length: 100%, stroke: 0.4pt + c-line)
  #v(4pt)

  #set text(font: f-sans, size: 6pt, fill: c-gray)
  #set par(justify: true, leading: 2.3pt, spacing: 2.6pt)

  #text(font: f-sans-bold, fill: c-ink)[#t("fair-use-label", lang: lang)] #t(
    "fair-use-text",
    lang: lang,
  )(emph(d.class), d.university)
  #text(font: f-sans-bold, fill: c-ink)[#t("license-label", lang: lang)] #t(
    "license-text",
    lang: lang,
  )(
    d.author,
    datetime.today().year(),
    d.cdl,
    d.university,
    d.university-short,
  )
  #text(font: f-sans-bold, fill: c-ink)[#t("feedback-label", lang: lang)] #t("feedback-text", lang: lang) #link("mailto:" + d.mail)[#d.mail].
  #text(font: f-sans-bold, fill: c-ink)[#t("support-label", lang: lang)] #link("https://www.paypal.com/paypalme/")[paypal.me/tuonome].
]
