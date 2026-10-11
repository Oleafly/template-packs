// This project is modified from sdu-touying-simpl
// https://github.com/Dregen-Yor/sdu-touying-simpl

// https://typst.app/universe/package/touying
#import "@preview/touying:0.7.4" as ty: *

#let oxygen-blue = rgb("#062958")
#set text(region: "CN")

#let primary = oxygen-blue
#let primary-dark = rgb("#1a1a59")
#let secondary = rgb("#ffffff")
#let neutral-lightest = rgb("#ffffff")
#let neutral-darkest = rgb("#000000")
#let themeblue = rgb("#3333b2")
#let themegreen = rgb("#34a853")
#let themeyellow = rgb("#fbbc05")
#let themepureblue = rgb("#262686")

#let tblock(title: none, it) = {
    grid(
        columns: 1,
        row-gutter: 0pt,
        block(
          fill: primary,
          width: 100%,
          radius: (top: 6pt),
          inset: (top: 0.4em, bottom: 0.3em, left: 0.5em, right: 0.5em),
          text(fill: neutral-lightest, weight: "bold", title),
        ),
        rect(
            fill: gradient.linear(primary, primary.lighten(90%), angle: 90deg),
            width: 100%,
            height: 4pt,
        ),
        block(
            fill: primary.lighten(90%),
            width: 100%,
            radius: (bottom: 6pt),
            inset: (top: 0.4em, bottom: 0.5em, left: 0.5em, right: 0.5em),
            it,
        ),
    )
}

#let outline-slide(title: [目录], column: 2, marker: auto, ..args) = touying-slide-wrapper(self => {
    let info = self.info + args.named()
    let header = {
        set align(center + bottom)
        block(
          fill: self.colors.neutral-lightest,
          outset: (x: 2.4em, y: .8em),
          stroke: (bottom: self.colors.primary + 3.2pt),
          text(self.colors.primary, weight: "bold", size: 1.6em, title),
        )
    }
    let body = {
        set align(horizon)
        show outline.entry: it => {
            let mark = if (marker == auto) {
                // image("img/uob-bullet.svg", height: .8em)
            } else if type(marker) == image {
                set image(height: .8em)
                image
            } else if type(marker) == symbol {
                text(fill: self.colors.primary, marker)
            }
            // block(stack(dir: ltr, spacing: .8em, mark, link(it.element.location(), it.body())), below: 0pt)

            block(
                // stack(dir: ltr, spacing: .8em, mark, heading(it.body())),

                stack(dir: ltr, spacing: .8em, mark, strong(text(size: 25pt, fill: self.colors.primary, link(
                  it.element.location(),
                  it.indented(it.prefix(), it.body()),
                )))),
                below: 0pt,
            )
        }
        show: pad.with(x: 1.1em)
        pad(left: 0%)[
            // #show outline: set heading(numbering: "1.")
            #components.adaptive-columns(outline(title: none, indent: 1em, depth: 1))
            // #set align(horizon)
            // #columns(2, gutter: 2em)[
            //   #components.adaptive-columns(outline(title: none, indent: 1em, depth: 1))
            // ]
        ]
    }
    self = utils.merge-dicts(self, config-page(
        header: header + v(-4em),
        margin: (top: 0.5em, bottom: 1.6em),
        fill: self.colors.neutral-lightest,
    ))
    touying-slide(self: self, body)
})


#let title-slide(..args) = touying-slide-wrapper(self => {
    let info = self.info + args.named()
    let body = {
        set align(center + horizon)
        block(fill: self.colors.primary, width: 100%, inset: (y: 1.2em), radius: 1em, text(
            size: 2em,
            fill: self.colors.neutral-lightest,
            weight: "bold",
            info.title,
        ))
        set text(fill: self.colors.neutral-darkest)
        if info.subtitle != none {
            block(text(size: 1.2em, info.subtitle))
        }
        if info.institution != none {
            block(text(size: 1em, info.institution))
        }
        if info.author != none {
            block(text(size: 1em, info.author))
        }
        if info.date != none {
            block(utils.display-info-date(self))
        }
        if info.logo != none {
            block(info.logo)
        }
    }
    touying-slide(self: self, body)
})


#let oxygen-footer(self) = {
    // set align(bottom + center)
    // set text(size: 0.8em)
    // show: pad.with(.0em)
    // // block(width: 100%, height: 1.5em, fill: self.colors.primary, pad(y: .4em, x: 2em, grid(
    // //   columns: (auto, 1fr, auto, auto),
    //   block(width: 100%, height: 1.5em, fill: self.colors.primary, pad(y: .4em, x: 2em, grid(
    //   columns: (25%, 1fr, 25%),

    //   text(fill: self.colors.neutral-lightest, ty.utils.call-or-display(self, self.store.footer-a)),
    //   utils.fit-to-width(grow: false, 100%, text(
    //     fill: self.colors.neutral-lightest.lighten(40%),
    //     ty.utils.call-or-display(self, self.store.footer-b),
    //   )),
    //   text(fill: self.colors.neutral-lightest.lighten(10%), ty.utils.call-or-display(self, self.store.footer-c)),
    // )))
    set std.align(center + bottom)
    set text(size: .8em)
    {
        let cell(..args, it) = components.cell(..args, inset: 1mm, std.align(horizon, text(fill: white, it)))
        show: block.with(width: 100%, height: 1.5em)
        grid(
            columns: (25%, 1fr, 25%),
            rows: 1.5em,
            cell(fill: self.colors.primary-dark, utils.call-or-display(self, self.store.footer-a)),
            cell(fill: self.colors.themepureblue, utils.call-or-display(self, self.store.footer-b)),
            cell(fill: self.colors.themeblue, utils.call-or-display(self, self.store.footer-c)),
        )
    }
}

#let slide(
    title: auto,
    align: auto,
    config: (:),
    repeat: auto,
    setting: body => body,
    composer: auto,
    ..bodies,
) = touying-slide-wrapper(self => {
    let header(self) = {
        set std.align(top)

        ty.components.progress-bar(
            height: 8pt,
            self.colors.primary.lighten(20%),
            self.colors.primary.lighten(40%)
        )

        set text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.2em)
        set std.align(horizon)
        // v(1em)
        show: components.cell.with(fill: self.colors.primary, inset: 2em)
        utils.fit-to-width(grow: false, 100%, ty.utils.display-current-heading(level: 2, numbered: false))
    }
    self = ty.utils.merge-dicts(self, config, config-common(freeze-slide-counter: false), config-page())
    let self = ty.utils.merge-dicts(self, config-page(
        fill: self.colors.neutral-lightest,
        header: header,
        footer: if self.store.show-footer { self.methods.footer } else { none },
    ))
    let new-setting = body => {
        show: std.align.with(horizon)
        set text(fill: self.colors.neutral-darkest)
        show: setting
        body
    }
    touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})
#let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
    let header = {
        set std.align(top)
        ty.components.progress-bar(height: 8pt, self.colors.primary, self.colors.primary.lighten(40%))
    }
    let slide-body = {
        set std.align(horizon)
        show: pad.with(20%)
        let heading-font-size = 1.5em
        let heading-area = {
            set text(size: heading-font-size)
            stack(
              dir: ttb,
              spacing: 1em,
              text(self.colors.neutral-darkest, utils.display-current-heading(
                  level: level,
                  numbered: numbered,
                  style: (setting: none, numbered: true, current-heading) => {
                      let current-level = current-heading.level
                      if current-level == 1 {
                          text(.715em, current-heading)
                      } else if current-level == 2 {
                          text(.835em, current-heading)
                      } else {
                          current-heading
                      }
                  },
              )),
              block(height: 2pt, width: 100%, spacing: 0pt, components.progress-bar(
                  height: 2pt,
                  self.colors.primary,
                  self.colors.primary-light,
              )),
            )
        }
        let body-area = { text(self.colors.neutral-dark, body) }
        stack(
            dir: ttb,
            spacing: 0pt,
            context place(
                dy: measure(heading-area).height + heading-font-size,
                body-area,
            ),
            heading-area,
        )
    }
    self = utils.merge-dicts(self, config-page(fill: self.colors.neutral-lightest, header: header))
    touying-slide(self: self, config: config, slide-body)
})

#let ending-slide(config: (:), title: none, body) = touying-slide-wrapper(self => {
    let content = {
        set align(center + horizon)
        if title != none {
            block(
              fill: self.colors.tertiary,
              inset: (top: 0.7em, bottom: 0.7em, left: 3em, right: 3em),
              radius: 0.5em,
              text(
                  size: 1.5em,
                  fill: self.colors.neutral-lightest,
                  title,
              ),
            )
        }
        body
    }
    touying-slide(self: self, content)
})

#let focus-slide(body, background-color: none, text-color: none, text-size: 60pt) = touying-slide-wrapper(self => {
    let focus-color = if background-color == none { self.colors.primary } else { background-color }
    let content-color = if text-color == none { self.colors.neutral-lightest } else { text-color }

    self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config-page(
        fill: focus-color,
        margin: 2em,
        header: none,
        footer: none,
    ))

    set text(fill: content-color, weight: "bold", size: text-size)

    touying-slide(self: self, align(horizon + center, body))
})


#let matrix-slide(config: (:), columns: none, rows: none, ..bodies) = touying-slide-wrapper(self => {
    self = ty.utils.merge-dicts(self, config, config-common(freeze-slide-counter: true), config-page(margin: 0em))
    touying-slide(
        self: self,
        config: config,
        composer: (..bodies) => {
            let bodies = bodies.pos()
            let columns = if type(columns) == int {
                (1fr,) * columns
            } else if columns == none {
                (1fr,) * bodies.len()
            } else {
                columns
            }
            let num-cols = columns.len()
            let rows = if type(rows) == int {
                (1fr,) * rows
            } else if rows == none {
                let quotient = calc.quo(bodies.len(), num-cols)
                let correction = if calc.rem(bodies.len(), num-cols) == 0 { 0 } else { 1 }
                (1fr,) * (quotient + correction)
            } else {
                rows
            }
            let num-rows = rows.len()
            if num-rows * num-cols < bodies.len() {
                panic(
                    "number of rows ("
                        + str(num-rows)
                        + ") * number of columns ("
                        + str(num-cols)
                        + ") must at least be number of content arguments ("
                        + str(bodies.len())
                        + ")",
                )
            }
            let cart-idx(i) = (calc.quo(i, num-cols), calc.rem(i, num-cols))
            let color-body(idx-body) = {
                let (idx, body) = idx-body
                let (row, col) = cart-idx(idx)
                let color = if calc.even(row + col) { self.colors.neutral-lightest } else { silver }
                set align(center + horizon)
                rect(inset: .5em, width: 100%, height: 100%, fill: color, body)
            }
            let content = grid(
                columns: columns, rows: rows,
                gutter: 0pt,
                ..bodies.enumerate().map(color-body)
            )
            content
        },
        ..bodies,
    )
})

#let oxygen-theme(
    aspect-ratio: "16-9",
    handout: false,
    show-footer: true,
    header: self => utils.display-current-heading(
        setting: utils.fit-to-width.with(grow: false, 100%),
        depth: self.slide-level,
    ),
    footer-a: self => self.info.author,
    footer-b: self => if self.info.short-title == auto {
        self.info.title
    } else {
        self.info.short-title
    },
    footer-c: context ty.utils.slide-counter.display() + " / " + ty.utils.last-slide-number,
    ..args,
    body,
) = {
    show: touying-slides.with(
        config-colors(
            primary: primary,
            primary-dark: primary-dark,
            secondary: secondary,
            neutral-lightest: neutral-lightest,
            neutral-darkest: neutral-darkest,
            themeblue: themeblue,
            themegreen: themegreen,
            themeyellow: themeyellow,
            themepureblue: themepureblue,
        ),
        config-store(
            align: align,
            alpha: 60%,
            show-footer: show-footer,
            footer: true,
            header: header,
            header-right: none,
            footer-a: footer-a,
            footer-b: footer-b,
            footer-c: footer-c,
        ),
        config-common(
            handout: handout,
            slide-fn: slide,
            new-section-slide-fn: new-section-slide,
            receive-body-for-new-section-slide-fn: true,
            // slide-level: 2
        ),
        config-page(
            paper: "presentation-" + aspect-ratio,
            margin: (top: 2.4em, bottom: 1.7em, x: 2.5em),
            header-ascent: 10%,
            footer-descent: 30%,
        ),
        config-methods(
            d-cover: (self: none, body) => {
                utils.cover-with-rect(
                    fill: utils.update-alpha(
                        constructor: rgb,
                        self.page-args.fill,
                        self.d-alpha,
                    ),
                    body,
                )
            },
            footer: oxygen-footer,
            alert: (self: none, it) => text(fill: self.colors.primary, it),
            init: (self: none, body) => {
                set text(size: 20pt)
                show heading: set text(fill: self.colors.primary)
                set list(marker: (
                    text([#v(-0.2em)‣], fill: self.colors.primary, size: 1.6em),
                    text([•], fill: self.colors.primary, size: 1em),
                ))
                set enum(numbering: "1.1.", full: true)
                show figure.caption: set text(size: 0.6em)
                show footnote.entry: set text(size: 0.6em)
                set footnote.entry(indent: 0em)
                show footnote.entry: it => par(hanging-indent: 0.4em, it)
                show link: it => if type(it.dest) == str {
                    set text(fill: self.colors.primary)
                    it
                } else {
                    it
                }
                body
            },
        ),
        ..args,
    )
    body
}
