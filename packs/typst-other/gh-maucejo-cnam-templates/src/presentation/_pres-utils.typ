#import "../common/_deps.typ": *
#import "../common/_colors.typ": *

#let _over-title(self: none, title, size) = {
  let box1 = {
    box(fill: white, stroke: 1pt + self.store.colors.box, inset: 8pt)[
      #set text(size: size, font: "Crimson Pro", weight: "semibold", fill: self.store.colors.blue)
      #title.first()
    ]
  }

  let box2 = {
    box(fill: white, stroke: 1pt + self.store.colors.box, inset: 8pt)[
      #set text(size: size, font: "Crimson Pro", weight: "semibold", fill: self.store.colors.blue)
      #title.last()
    ]
  }

  context{
    let box1-size = measure(box1).width
    let box2-size = measure(box2).width

    box1

    let dec = box1-size - box2-size/2.5
    if dec < 0cm {
      dec = box1-size/3
    }
    place(dx: dec, box2)
  }
  v(1em)
}
#let over-title(title, size: 16pt) = touying-fn-wrapper(_over-title.with(title, size))

#let _title-box(self: none, colors, title, subtitle, color-title) = {
  let title-logo-height = 6.5%
  let dy = -1.25cm
  if self.store.composante != "cnam" {
    title-logo-height= 12%
    dy = -1.75cm
  }
  set image(height: title-logo-height)
  place(top + right, dx: -1cm, dy: dy, self.store.logo)

  if type(colors) == color {
    box(fill: colors, width: 100%, height: 110%)[
      #set align(center + horizon)
      #set text(fill: color-title)

      #v(-50pt)
      #title
      #linebreak()

      #subtitle
    ]
  } else {
    box[
      #colors
      #let box-title = {
        box(fill: self.store.colors.primary.transparentize(29%), width: 87%, height: 70%)[
        #set align(center + horizon)
        #set text(fill: color-title)

        #title

        #subtitle
      ]
    }

      #place(center + horizon, dy: 1.6cm, box-title)
    ]
  }
}
#let title-box(colors, title: none, subtitle: none, color-title: white) = touying-fn-wrapper(_title-box.with(colors, title, subtitle, color-title))
