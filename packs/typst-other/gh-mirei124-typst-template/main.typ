#import "@preview/touying:0.6.1": *
#import "@preview/clean-math-presentation:0.1.1": *
#import "@preview/mitex:0.2.6": *

#show: clean-math-presentation-theme.with(
  config-info(
    title: [title],
    // short-title: [Short title that will be shown in the footer],
    authors: (
      (name: "name"),
    ),
    // author: "Presenting Author",
    affiliations: (
      // (id: 1, name: "Fancy Department, University of Somewhere"),
    ),
    date: datetime.today(),
  ),
  config-common(
    slide-level: 2,
    // handout: true,
    //show-notes-on-second-screen: right,
  ),
  progress-bar: false,
  // navigation 0.8em header 2.2em
  config-page(margin: (top: 2.7em)),
  config-store(
    navigation: none,
    header: self => {
      block(
        width: 100%,
        height: 2.2em,
        // fill: gradient.linear(self.colors.primary, self.colors.secondary),
        place(
          left + horizon,
          text(
            fill: self.colors.primary,
            weight: "bold",
            size: 1.2em,
            utils.call-or-display(self, self.store.title),
          ),
          dx: 1.0em,
        ),
      )
    },
  ),
  footer-columns: (75%, 0%, 15%, 10%),
  footer-a: self => align(left, utils.display-current-short-heading(level: self.slide-level)),
  footer-b: none,
)

#let img(source, height: auto) = figure(image(source, height: height))
#let flexrow(columns: auto, gutter: 1em, ..bodies) = {
  let bodies = bodies.pos()
  let columns = if columns == auto { (1fr,) * bodies.len() } else { columns }
  grid(columns: columns, gutter: gutter, ..bodies)
}

#set text(font: ("Times New Roman", "Microsoft YaHei"), size: 18pt)

#title-slide(
  // logo1: image("images/logo_placeholder.svg", height: 4.5em),
)

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none))

= First Section

== Softmax

#lorem(80)

