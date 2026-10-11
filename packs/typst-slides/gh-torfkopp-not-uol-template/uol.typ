#import "@preview/touying:0.6.1": *
#import "util/colours.typ": *

#let height = 473.56pt
#let width = 841.89pt

#let uol-footer(self) = {
    // set align(left)
    v(-0.5em)
    show: pad.with(.4em)
    set text(fill: white, size: 10pt)
    utils.call-or-display(self, self.store.footer)
    stack(
      dir: ltr,
      spacing: 7em,
      box()[
        #h(1em)
        #text(weight: "bold","Seite " + context utils.slide-counter.display())
        #linebreak()
        #h(1em)
        #self.info.date.display("[day].[month].[year]")
      ],
      box(width: 100%)[
        #text(fill: black, weight: "bold", self.info.short-title)
        #text(fill:black, " — " + self.info.short-subtitle)
        #linebreak()
        #text(fill: gray, self.info.author + " — " + self.info.institution)
      ]
    )
  }

#let uol-background(self) = {
  context[
    #set align(left+ top)
    #box()[
      #rect(height: 60%, width: 12.5%,fill: uolblue)[
        #v(1em)
        #set align(center)
        #image("util/UOL_Logo_Negativ.png", width: 80%)
      ]
      #let right = 0.125 * width + 5pt
      #move(dx: -5pt, dy: -25pt)[
        #curve(
          fill: blue2,
          curve.quad((40pt, -40pt), (right, -80pt)),
          curve.line((right, 0pt)),
          curve.close(mode: "straight")
        )
      ]
      #move(dy: -50pt)[
        #rect(height: 60%, width: 12.5%, fill: blue2)
      ]
    ]
  ]
}

#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config)
  self.store.title = none
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }

  let body = {
    set page(
      margin: (top: 1cm, left: 1cm),
      height: 473.56pt, width: 841.89pt,
      fill: uolblue,
      background: 
        context[
          #set align(right+bottom)
          #let width = 0.66 * page.width
          #let height = 0.8 * page.height
          #box(
            height: height,
            width: width,
          )[
            #curve(
              fill: blue2,
              curve.move((width, 0pt)),
              curve.quad((width/4, height/5), (0pt, height)),
              curve.line((width, height)),
              curve.close(mode: "straight"),
            )
          ]
        ]
    )
    align(top + left)[#image("util/UOL_Logo_Negativ.png", width: 20%)]
    
    set text(fill: white)
    set par(leading: 0.45em)
    v(-5pt)
    text(size: 44pt, info.title)
    v(-20pt)
    text(size: 24pt, info.subtitle)
    v(1pt)
    text(info.author) + ", "
    text(info.date.display("[day].[month].[year]"))
  }
  touying-slide(self: self, body)
})

#let slide(title: auto, skip-header: false, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    h(7em)
    text(fill: uolblue, size: 20pt)[#utils.display-current-heading(level: 2)]
  }
  let footer(self) = uol-footer(self)
  self = utils.merge-dicts(
    self,
    config-page(
      header: if not skip-header {header} else {none},
      footer: footer,
      margin:if skip-header {(top: 2em)} else {(top: 6em)},
    ),
  )
  set page(background: uol-background(self))
  touying-slide(self: self, ..args)
})

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  let main-body = {
    v(2em)
    text(size: 20pt,fill: uolblue, body)
  }
  // set page
  let header(self) = {
    h(7em)
    text(fill: uolblue, size: 60pt)[#utils.display-current-heading()]
  }
  let footer(self) = uol-footer(self)
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      header-ascent: 0%,
      footer: footer,
    ),
  )
  set page(background: uol-background(self))
  touying-slide(self: self, main-body)
  
})

#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: uolblue,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em)
  touying-slide(self: self, align(horizon + center, body))
})

#let uol-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body
) = {
  set text(size: 20pt)

  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-store(
      footer: footer,
    ),
    ..args,
  )

  body
}