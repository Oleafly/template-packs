#import "@preview/touying:0.7.4": *
#import "@preview/cetz:0.5.2"
#import "definitions.typ": ivc-color, tug-color
#let margin_left = 2em
#let margin_right = 2em
#let header_depth = 2em
#let header_title_size = 1.5em
#let page_no_block_size = 1.5em
#let footer_depth = 2em

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    set align(center + horizon)
    // v(-1em)
    layout(size => block(fill: white, width: 100%, height: 100%, cetz.canvas({
      import cetz.draw: *
      content(
        (0, 0),
        block(image("assets/16b_tug_building-min.jpg", width: size.width + 0.1em, fit: "cover")),
        name: "background",
      )

      content((to: "background.north-west", rel: (1em, -2em)), anchor: "north-west", block({
        image("assets/ivc-logo.pdf", width: 30mm, fit: "cover")
        v(2em)

        block({
          set text(size: 1.5em, fill: self.colors.primary)
          if info.title != none {
            set text(weight: "extrabold")
            block(info.title, width: 24em)
          }
          set text(size: 0.7em, fill: self.colors.neutral-darkest)
          if info.author != none {
            block(info.author, width: 28em)
          }
          set text(size: 0.8em, fill: self.colors.neutral-darkest, weight: "light")
          if info.date != none {
            block(utils.display-info-date(self), width: 25em)
          }
          if "additional_info" in info and info.additional_info != none {
            block(info.additional_info, width: 28em)
          }
        }, inset: (x: margin_left - 1em))
      }, fill: rgb("#ffffff64")), name: "ivc-logo")

      content((to: "background.north-east", rel: (-1em, -2em)), anchor: "north-east", block(
        {
          set align(right)
          image("assets/tugraz-logo.pdf", width: 30mm)
          v(-0.5em)
          set text(size: 0.7em, fill: self.colors.neutral-darkest, weight: "light", font: "PT Sans Caption")
          [
            SCIENCE \
            PASSION \
            TECHNOLOGY
          ]
        },
        // fill: rgb("#f8f7f7bb")
      ), name: "tug-logo")

      rect(
        (to: "background.south-east", rel: (0em, 2em)),
        (to: "background.south-west", rel: (0em, 0em)),
        fill: rgb(255, 255, 255, 192),
        name: "bottom-bar",
        stroke: 0.2pt + black,
      )

      // circle(
      //   (to: "bottom-bar.west", rel: (0em, 0em)),
      //   anchor: "south",
      //   fill: self.colors.primary,
      //   stroke: none,
      // )
      content((to: "bottom-bar.north-west", rel: (2em, -0.7em)), anchor: "south-west", block({
        set text(size: 0.7em, fill: self.colors.neutral-darkest, weight: "light", font: "PT Sans Caption")
        set align(horizon + left)
        if info.institution != none {
          block(info.institution)
        }
        if info.institute_url != none {
          block(info.institute_url)
        }
        // [Testassociation of Graz University of Technology]
      }, height: 0em), name: "institution")

      // add an arrow to the institute content i.e. > ivc.tugraz.at but draw it using lines
      circle(
        (to: "institution.west", rel: (-0.5em, 0em)),
        anchor: "east",
        fill: none,
        radius: 0.1em,
        stroke: none,
        name: "institution-dot",
      )
      let inst_arrow_length = 0.3em
      line(
        (to: "institution-dot", rel: (-inst_arrow_length, inst_arrow_length)),
        (to: "institution-dot", rel: (0em, 0em)),
        (to: "institution-dot", rel: (-inst_arrow_length, -inst_arrow_length)),
        stroke: 2pt + self.colors.tug,
      )
    })))
    // set text(fill: self.colors.neutral-darkest)
    // if info.author != none {
    //   block(info.author)
    // }
    // if info.date != none {
    //   block(utils.display-info-date(self))
    // }
    // if info.contact != none {
    //   block(info.contact)
    // }
  }
  self = utils.merge-dicts(self, config-page(margin: 0em, fill: self.colors.neutral-lightest))
  touying-slide(self: self, body)
})

// Created using Claude Opus: https://claude.ai/share/b21520b1-d904-4799-81c5-6bf3d5035bc9
#let nav(normal_color: gray, current_color: black) = context {
  let sections = query(heading.where(level: 1))

  // last section that started at or before this point - had to modify without before!
  let current = query(heading
  .where(level: 1)
  .before(inclusive: false, utils.current-heading().location())).at(-1, default: none)

  for s in sections {
    let is-current = current != none and s.location() == current.location()
    box(inset: (x: 4pt, top: 7pt, bottom: 1pt), text(
      fill: if is-current { current_color } else { normal_color },
      weight: if is-current { "bold" } else { "regular" },
      s.body,
    ))
  }
}

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    set align(top)

    layout(size => block(fill: white, width: 100%, height: 100%, {
      grid(
        columns: (margin_left, size.width - margin_left - margin_right, margin_right),
        rows: (header_depth, header_title_size),
        [],
        cetz.canvas({
          import cetz.draw: *
          rect(
            (0, 0),
            (size.width - margin_right - margin_left, header_depth),
            fill: white,
            stroke: none,
            // stroke: 1pt + self.colors.primary + bottom,
            name: "background",
          )
          line(
            (to: "background.south-west", rel: (0em, 0em)),
            (to: "background.south-east", rel: (0em, 0em)),
            stroke: 1pt + black,
          )
          content((to: "background.east", rel: (0em, 0em)), anchor: "east", block({
            image("assets/tugraz-logo.pdf", width: 30mm)
          }))
          content((to: "background.west", rel: (0em, 0em)), anchor: "west", block({
            set text(size: 0.9em, fill: black, weight: "extrabold")
            if self.at("enable-nav") == false {} else {
              nav(normal_color: gray, current_color: self.colors.primary)
            }
            // components.custom-progressive-outline(
            //   level: 1,
            // )
          }))
        }),
        [

        ],
        cetz.canvas({
          import cetz.draw: *
          rect(
            (0, 0),
            (page_no_block_size, page_no_block_size),
            fill: self.colors.primary,
            // stroke: 1pt + self.colors.primary + bottom,
            name: "page-no-bg",
          )
          content((to: "page-no-bg.center", rel: (0em, 0em)), anchor: "center", block({
            set text(size: .8em, fill: self.colors.neutral-lightest)
            utils.slide-counter.display()
          }))
        }),
        block({
          set align(horizon + center)
          set text(size: 1.5em, fill: black, weight: "extrabold")
          v(0.4em)
          if self.store.title != none {
            utils.call-or-display(self, self.store.title)
          } else {
            utils.display-current-heading(level: 2)
          }
        }),
      )
    }))
  }
  let footer(self) = {
    set align(bottom)
    if self.at("enable-footer") == false {
      return block()
    }
    layout(size => block(fill: white, width: 100%, height: 100%, {
      grid(
        columns: (margin_left, size.width - margin_left - margin_right, margin_right),
        rows: (footer_depth),
        [],
        cetz.canvas({
          import cetz.draw: *
          rect(
            (0, 0),
            (size.width - margin_right - margin_left, footer_depth),
            fill: white,
            stroke: none,
            // stroke: 1pt + self.colors.primary + bottom,
            name: "background",
          )
          line(
            (to: "background.north-west", rel: (0em, 0em)),
            (to: "background.north-east", rel: (0em, 0em)),
            stroke: 1pt + black,
          )
          content((to: "background.north-east", rel: (0em, -0.2em)), anchor: "north-east", block({
            // v(-0.5em)
            image("assets/ivc-logo.pdf", width: 15mm, fit: "cover")
          }))
          content((to: "background.north-west", rel: (0em, -0.2em)), anchor: "north-west", block({
            // v(-0.5em)
            set text(size: 0.7em, fill: gray)
            let footer-author = info.at("short-author", default: none)
            if footer-author == none { footer-author = info.author }
            let short-conf = info.at("short-conference", default: none)
            if footer-author != none or short-conf != none {
              block({
                if footer-author != none { footer-author }
                if footer-author != none and short-conf != none [, ]
                if short-conf != none { short-conf }
              })
            }
            // components.custom-progressive-outline(
            //   level: 1,
            // )
          }))
        }),
        [

        ],
      )
    }))
  }
  self = utils.merge-dicts(self, config-page(header: header, footer: footer))
  touying-slide(self: self, ..args)
})

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  let main-body = {
    set align(center + horizon)
    set text(size: 2em, fill: self.colors.primary, weight: "bold", style: "italic")
    utils.display-current-heading(level: 1)
  }
  touying-slide(self: self, main-body)
})

#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(fill: self.colors.primary, margin: 2em))
  set text(fill: self.colors.neutral-lightest, size: 2em)
  touying-slide(self: self, align(horizon + center, body))
})
#let ivc-theme(aspect-ratio: "16-9", footer: none, ..args, body) = {
  set text(size: 20pt)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: header_depth + header_title_size + 1em, bottom: footer_depth, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      // new-section-slide-fn: new-section-slide,
      datetime-format: "[day].[month].[year]",
      enable-footer: true,
      enable-nav: true,
    ),
    config-methods(alert: utils.alert-with-primary-color),
    config-colors(tug: tug-color, primary: ivc-color, neutral-lightest: rgb("#e4e4e4"), neutral-darkest: rgb("#171717")),
    config-store(
      title: none,
      footer: footer,
      additional_info: none,
      author: none,
      short-author: none,
      email: "your.mail@tugraz.at",
    ),
    ..args,
  )
  // the marker at the reference point stays, the repeated one in the footnote area goes
  show footnote.entry: it => block(it.note.body)
  body
}

// Footnote whose marker shows the citation number(s) instead of a running count.
#let footcite(..keys) = {
  let ks = keys.pos()
  let marker = {
    // the cite renders as "[1]" - keep the number, drop the brackets
    show "[": none
    show "]": none
    ks.map(k => cite(k)).join()
  }
  footnote(numbering: _ => marker, {
    set text(size: 14pt)
    ks.map(k => cite(k, style: "assets/fullcite.csl")).join(linebreak()) + "."
  })
}

