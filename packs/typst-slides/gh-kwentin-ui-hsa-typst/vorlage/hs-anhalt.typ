#import "@preview/touying:0.8.0": *

#let header-height = 2.2cm

#let hsa-header(self) = {
  rect(width: 100%, height: 100%, fill: self.colors.neutral-light)[
    #show: pad.with(left: .8cm, right: .8cm, top: .3cm, bottom: .3cm)
    #grid(
      columns: (1fr, auto),
      rows: 100%,
      align: (horizon + left, horizon + right),
      [
        #set text(fill: self.colors.primary, size: 12pt, font: "Montserrat")
        | #self.store.header
      ],
      image("logo_full.svg", height: 100%),
    )
  ]
}

#let hsa-footer(self) = {
  set align(alignment.horizon)
  show: components.cell.with(fill: gradient.linear(
    self.colors.secondary,
    self.colors.secondary,
    self.colors.primary,
    angle: 5deg,
  ))
  show: pad.with(x: 1cm)
  set text(fill: self.colors.neutral-light, size: 12pt)
  grid(
    columns: (1fr, 4fr, 1fr),
    align: (left, center, right),
    self.store.datum, utils.call-or-display(self, self.store.footer), "Seite " + context utils.slide-counter.display(),
  )
}

#let slide-title-block(self, actual-title) = context {
  let current-page = here().page()
  let hs = query(selector(heading))
  let hs-before = hs.filter(h => h.location().page() <= current-page)

  let slide-headings = hs-before.filter(h => h.level <= self.slide-level)
  let slide-heading = if slide-headings.len() > 0 { slide-headings.last() } else { none }

  let levels = ()
  if slide-heading != none {
    let current-level = slide-heading.level
    let found-slide-heading = false

    for h in hs-before.rev() {
      if not found-slide-heading {
        if h.location() == slide-heading.location() {
          found-slide-heading = true
        }
        continue
      }

      if h.level < current-level {
        levels.insert(0, h.body)
        current-level = h.level
      }
      if current-level <= 1 {
        break
      }
    }
  }

  let the-title = if actual-title != auto and actual-title != none {
    actual-title
  } else if actual-title == auto and slide-heading != none and slide-heading.level > 1 {
    utils.display-current-heading(depth: self.slide-level)
  } else {
    none
  }

  if the-title != none {
    block(width: 100%, below: 0.6em)[
      #if actual-title == auto and levels.len() > 0 {
        text(fill: self.colors.neutral.lighten(50%), size: 12pt, weight: "regular")[
          #levels.join([ #sym.space #sym.dash.en #sym.space ])
        ]
        linebreak()
      }
      #text(fill: self.colors.neutral, size: 24pt, weight: "bold", font: "Montserrat")[
        #the-title
      ]
    ]
  }
}

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  let args-named = args.named()
  // Titel extrahieren und im Store speichern, falls vorhanden
  let actual-title = if title != auto { title } else { args-named.at("title", default: auto) }

  if actual-title != none and actual-title != auto {
    self.store.title = actual-title
  } else {
    self.store.title = none
  }

  // Titel aus den named args entfernen, damit touying-slide ihn nicht im Body rendert
  let named = (:)
  for (k, v) in args.named() {
    if k != "title" {
      named.insert(k, v)
    }
  }

  // Linkfarbe setzen
  show link: set text(fill: rgb(255, 0, 0))

  self = utils.merge-dicts(
    self,
    config-page(
      header: hsa-header,
      footer: hsa-footer,
    ),
  )

  let title-content = slide-title-block(self, actual-title)
  let pos = args.pos()
  let content = pos.join()
  let body = pad(top: 0.5cm, bottom: 0.5cm, if title-content != none {
    grid(
      columns: 100%,
      rows: (auto, 1fr),
      row-gutter: 0.8em,
      title-content,
      content,
    )
  } else {
    block(width: 100%, height: 100%, content)
  })

  touying-slide(self: self, ..named, body)
})

#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  let title-background(self) = {
    rect(
      width: 100%,
      height: 100%,
      fill: gradient.linear(
        self.colors.secondary, // Rot
        self.colors.primary, // Blau
        angle: 55deg,
      ),
    )
  }

  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(
      background: title-background(self),
      header: hsa-header(self),
      footer: none,
    ),
  )

  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info { info.authors } else { info.author }
    if type(authors) == array { authors } else { (authors,) }
  }

  let body(self) = {
    pad(top: 3.5cm, bottom: 1cm, left: 1.5cm, right: 1.5cm)[
      #box(width: 100%, height: 100%)[
        #place(top + left)[
          #text(size: 2.5em, weight: "bold", fill: self.colors.neutral-light, font: "Montserrat", info.title)
          #if info.subtitle != none {
            linebreak()
            v(0.2cm)
            text(size: 1.5em, weight: "regular", fill: self.colors.neutral-light, info.subtitle)
          }
        ]
        #place(bottom + right)[
          // Autoren
          #set text(size: 1.2em, fill: self.colors.neutral-light)
          #stack(
            dir: ttb,
            spacing: 0.3em, // Vertikaler Abstand zwischen den Namen
            ..info.authors, // Fügt alle Autoren als einzelne Elemente hinzu
          )
        ]
      ]
    ]
  }

  touying-slide(self: self, body(self))
})

#let zwischentitel-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let pos = args.pos()
  let named = args.named()
  let subtitle = named.at("subtitle", default: auto)
  let numbered = named.at("numbered", default: true)
  let title = named.at("title", default: auto)
  let blau = named.at("blau", default: true)
  let config = named.at("config", default: (:))

  // Positional argument if passed manually (and not none)
  if pos.len() > 0 and pos.first() != none and subtitle == auto {
    subtitle = pos.first()
  }

  // Heading check if called via Touying's new-section-slide-fn
  let current-heading = if "headings" in self and self.headings.len() > 0 {
    self.headings.last()
  } else {
    none
  }
  if current-heading != none {
    let outlined = current-heading.at("outlined", default: true)
    let numbering = current-heading.at("numbering", default: auto)
    if not outlined or numbering == none {
      return none
    }
  }

  let title-background(self) = {
    rect(
      width: 100%,
      height: 100%,
      fill: if blau == false { self.colors.secondary } else { self.colors.primary },
    )
  }

  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(
      background: title-background(self),
      header: hsa-header(self),
      footer: none,
    ),
  )

  let info = self.info + named
  info.authors = {
    let authors = if "authors" in info { info.authors } else { info.author }
    if type(authors) == array { authors } else { (authors,) }
  }

  let body(self) = {
    pad(top: 2.5cm, bottom: 1cm, left: 1.5cm, right: 1.5cm)[
      #box(width: 100%, height: 100%)[
        #place(top + left)[
          #text(size: 2em, weight: "bold", font: "Montserrat", fill: self.colors.neutral-light)[
            #if title != auto {
              title
            } else {
              utils.display-current-heading(level: 1, numbered: numbered)
            }
          ]
          #context {
            let sub-content = if subtitle != auto {
              subtitle
            } else {
              let current-page = here().page()
              let all-headings = query(heading.where(outlined: true))
              let sections = all-headings.filter(h => h.level == 1)
              let current-section = sections.filter(h => h.location().page() <= current-page).at(-1, default: none)

              if current-section != none {
                let idx = all-headings.position(h => h.location() == current-section.location())
                if idx != none {
                  let subs = ()
                  let remaining = if idx + 1 < all-headings.len() { all-headings.slice(idx + 1) } else { () }
                  for h in remaining {
                    if h.level <= 1 {
                      break
                    }
                    if h.level == 2 {
                      subs.push(h.body)
                    }
                  }
                  if subs.len() > 0 {
                    if subs.len() > 5 {
                      let mid = calc.ceil(subs.len() / 2)
                      grid(
                        columns: (1fr, 1fr),
                        gutter: 1.5cm,
                        subs.slice(0, mid).join(linebreak()), subs.slice(mid).join(linebreak()),
                      )
                    } else {
                      subs.join(linebreak())
                    }
                  }
                }
              }
            }
            if sub-content != none {
              linebreak()
              v(0.4cm)
              text(size: 1.5em, weight: "regular", fill: self.colors.neutral-light)[#sub-content]
            }
          }
        ]
      ]
    ]
  }

  touying-slide(self: self, body(self))
})


#let hsa-theme(
  aspect-ratio: "16-9",
  header-height: header-height,
  header: [Funktion, Fachbereich, Struktureinheit oder Name],
  footer: [Name, Anlass],
  datum: [#datetime.today().display("[day].[month].[year]")],
  bibliographie_path: "../zotero.bib",
  ..args,
  body,
) = {
  set text(size: 18pt, font: "Source Sans 3", lang: "de")
  show figure.caption: set text(size: 14pt)
  set figure(numbering: none)

  // Code
  // show raw: set text(font: "JetBrains Mono")

  show raw.where(block: true): it => block(
    fill: rgb("#f5f3fc"), // Ganz leichtes Grau als Hintergrund
    inset: (left: 10pt, y: 8pt, right: 8pt), // Innenabstand
    radius: (left: 0pt, right: 3pt), // Nur rechts abgerundet
    stroke: (left: 1.5pt + rgb("#2B347A")),
    width: 100%,
    it,
  )

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0%,
      footer-descent: 0%,
      margin: (
        top: header-height, // Platz für den schlanken Header
        bottom: 1.2cm, // Platz für den Footer
        left: 1cm, // Horizontaler Rand
        right: 1cm, // Horizontaler Rand
      ),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: zwischentitel-slide,
      slide-level: 4,
    ),
    config-colors(
      primary: rgb("#13017C"),
      secondary: rgb("#D40009"),
      neutral: black,
      neutral-light: white,
    ),
    config-methods(alert: utils.alert-with-primary-color),
    config-store(
      title: none,
      footer: footer,
      header: header,
      datum: datum,
    ),
    ..args,
  )

  body

  if bibliographie_path != none {
    // Bibliographie-Folie mit Titel für den Header
    slide(title: [Literatur])[
      #hide(heading(level: 1, numbering: none, outlined: false)[Literatur])
      #set text(size: 12pt)
      #bibliography(bibliographie_path, title: none, style: "ieee")
    ]
  }
}
