#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": badge

/// Title slide for seminar / workshop presentation
#let title-slide(
  title: auto,
  subtitle: none,
  author: auto,
  institution: auto,
  date: auto,
  extra: none,
  tags: (),
  dark: false,
  ..args,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.modern)

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if dark { hcs-navy-dark } else { hcs-bg },
      header: none,
      footer: none,
      margin: (x: 2.2cm, top: 1.8cm, bottom: 1.8cm),
    ),
  )

  let info-title = if title != auto { title } else { self.info.at("title", default: "") }
  let info-subtitle = if subtitle != none { subtitle } else { self.info.at("subtitle", default: none) }
  let info-author = if author != auto { author } else { self.info.at("author", default: none) }
  let info-inst = if institution != auto { institution } else { self.info.at("institution", default: none) }
  let info-date = if date != auto { date } else { utils.display-info-date(self) }

  let body = {
    set align(left + horizon)

    grid(
      columns: (1fr, auto),
      gutter: 1.5cm,
      align: (left + horizon, right + horizon),
      [
        // Tags / pills row
        #if tags.len() > 0 [
          #stack(
            dir: ltr,
            spacing: 0.5em,
            ..tags.map(t => if dark {
              box(
                fill: rgb("#172554"),
                radius: 100pt,
                inset: (x: 0.7em, y: 0.3em),
                text(font: fonts.accent, fill: hcs-cyan, size: 0.78em, weight: "bold")[#t]
              )
            } else {
              badge(t, fill: hcs-slate-light, color: hcs-navy)
            })
          )
          #v(0.8em)
        ]

        // Title with cute accent indicator
        #block(
          stroke: (left: 5pt + if dark { hcs-cyan } else { hcs-blue }),
          inset: (left: 0.8em),
          [
            #block[
              #set text(
                font: fonts.heading,
                size: 2.1em,
                weight: "bold",
                fill: if dark { white } else { hcs-navy },
              )
              #set par(leading: 0.28em)
              #info-title
            ]
            #if info-subtitle != none [
              #v(0.4em)
              #text(
                font: fonts.body,
                size: 1.15em,
                weight: "medium",
                fill: if dark { hcs-slate } else { hcs-slate-dark },
                info-subtitle,
              )
            ]
          ]
        )

        #v(1em)

        // Metadata block (Author, Institution, Date)
        #block[
          #set text(font: fonts.body, size: 0.88em)
          #if info-author != none [
            #text(
              font: fonts.heading,
              weight: "bold",
              fill: if dark { white } else { hcs-text },
              info-author,
            )
            #h(0.8em)
          ]
          #if info-inst != none [
            #text(
              font: fonts.body,
              fill: if dark { hcs-slate } else { hcs-text-muted },
              [| #h(0.8em) #info-inst],
            )
          ]
          #if info-date != none [
            #v(0.3em)
            #text(
              font: fonts.body,
              fill: if dark { rgb("#94A3B8") } else { hcs-text-muted },
              size: 0.88em,
              info-date,
            )
          ]
          #if extra != none [
            #v(0.5em)
            #extra
          ]
        ]
      ],
      [
        // Large HCS Emblem
        #box(
          width: 5cm,
          image(if dark { "assets/hcs-logo-invert.png" } else { "assets/hcs-logo.png" }, width: 100%)
        )
      ]
    )
  }

  touying-slide(self: self, repeat: 1, body)
})

/// Outline / Agenda slide for seminar roadmap
#let outline-slide(
  title: [Seminar Roadmap],
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
  ))
  touying-slide(
    self: self,
    [
      #v(0.5em)
      #set outline(title: none, indent: 1.2em, depth: self.slide-level)
      #show outline.entry: it => {
        text(fill: hcs-text, weight: "medium", it)
      }
      #outline(..args)
    ]
  )
})

/// Section divider slide for workshop modules
#let section-slide(
  title: auto,
  subtitle: none,
  number: auto,
  level: 1,
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: hcs-bg,
      header: none,
      footer: none,
      margin: (x: 2.5cm, y: 2cm),
    ),
  )

  let display-title = if title != auto and title != none {
    title
  } else {
    utils.display-current-heading(level: level)
  }

  let sec-num = if number != auto {
    number
  } else {
    context {
      let sec = query(heading.where(level: 1)).filter(h => h.location().page() <= here().page())
      if sec.len() > 0 {
        let n = sec.len()
        if n < 10 { "0" + str(n) } else { str(n) }
      } else { "01" }
    }
  }

  let fonts = self.store.at("fonts", default: default-font-presets.modern)

  let content = {
    set align(left + horizon)

    // Background watermark dragon
    place(
      right + horizon,
      dx: 1.5cm,
      image("assets/hcs-dragon-dark.svg", width: 9.5cm)
    )

    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2cm,
      align: (left + horizon, left + horizon),
      [
        // Big Module Number pill
        #box(
          fill: hcs-navy,
          radius: 8pt,
          inset: (x: 0.7em, y: 0.5em),
          text(font: fonts.accent, fill: hcs-cyan, size: 2.8em, weight: "black")[#sec-num]
        )
      ],
      [
        #block[
          #set text(font: fonts.heading, size: 2.2em, weight: "bold", fill: hcs-navy)
          #set par(leading: 0.28em)
          #display-title
        ]
        #if subtitle != none [
          #v(0.3em)
          #text(font: fonts.body, size: 1.2em, fill: hcs-text-muted)[#subtitle]
        ]
        #let extra = args.pos().filter(it => it != none and it != [])
        #if extra.len() > 0 [
          #v(0.8em)
          #extra.first()
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Standout / Focus slide with midnight navy background
#let focus-slide(
  title: none,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.modern)

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: hcs-navy-dark,
      header: none,
      footer: none,
      margin: 2.5cm,
    ),
  )

  let content = {
    set align(center + horizon)
    set text(font: fonts.body, fill: white, size: 1.6em)

    // Subtle background dragon
    place(
      center + horizon,
      image("assets/hcs-dragon.svg", width: 13cm)
    )

    block(
      width: 85%,
      [
        #if title != none [
          #text(font: fonts.heading, size: 1.3em, weight: "bold", fill: hcs-cyan)[#title]
          #v(0.8em)
        ]
        #body
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Blank slide without header/footer for full diagrams or live demos
#let blank-slide(..args, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: none,
      margin: 1cm,
    ),
  )
  touying-slide(self: self, align(center + horizon, body), ..args)
})

/// Standard lecture / workshop slide
#let slide(
  title: auto,
  subtitle: none,
  quote: none,
  alignment: top + left,
  ..args,
) = touying-slide-wrapper(self => {
  let named = args.named()
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
    current-slide-subtitle: subtitle,
  ))

  set align(alignment)

  if quote != none {
    let rest-composer = named.remove("composer", default: auto)
    let quote-composer = (..composer-args) => {
      let composer-bodies = composer-args.pos()
      quote-block(quote)
      if type(rest-composer) == function {
        rest-composer(..composer-bodies)
      } else {
        components.side-by-side(columns: rest-composer, ..composer-bodies)
      }
    }
    touying-slide(self: self, composer: quote-composer, ..args.pos(), ..named)
  } else {
    touying-slide(self: self, ..args)
  }
})
