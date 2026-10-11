#import "../src/lib.typ" as rf
#import "@preview/touying:0.6.3" as ty
#import "@preview/theorion:0.5.0" as th
#import th.cosmos.clouds as thc

// Font settings
#set text(font: "Fira Sans", weight: "light")
// Settings for theorion package
#show: th.show-theorion
#th.set-inherited-levels(0)

#show: rf.rf-metropolis-theme.with(
  header-block-size: 3em,
  // header-progress: true, // default is true
  // footer-progress: false, // default is false
  ty.config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [Rockwool Fonden],
    logo: rf.logos.rf-logo,
    logo-height: 2.5pt
  ),
  ty.config-common(frozen-counters: (
    th.theorem-counter, // If you are using "animations", add this config option to stop touying from counting the same theorem multiple times
    // handout: true, // if you have animations in your slides and only want to keep the last subslide
    // new-section-slide-fn: none // if you wish to remove 'new section' slides
  )), 
)

#rf.title-slide()

// If you want a table of contents
// #rf.components.adaptive-columns(outline(indent: 1em))

= First section
== First slide
Wow, this is a slide.
#th.emph-block()[
  We can emphasize something here.
]

= Examples
== Example with `theorion`: OLS estimator
#pagebreak()
#thc.definition()[
  The OLS estimator
  $
    hat(bold(beta)) = (bold(X)^T bold(X))^(-1) bold(X)^T bold(y)
  $
]
#th.important-block(fill: rf.colors.rff-orange)[
  - This is very important.
  - Remember this.
]
== Third slide
#rf.slide(align: center + horizon, composer: (1fr, 1fr))[
  First column.
][
  Second column. #cite(<schelling1971dynamic>, form: "prose")#footnote("a footnote")
]

// A "focus" slide that is colored according to the primary color
#let my-gradient = gradient.linear(rf.colors.rff-orange, rf.colors.rff-secondary, angle: 45deg)
#rf.focus-slide(
  [
    Wake up!
  ],
  fill: my-gradient,
)

== References
#set text(size: 14pt)
#bibliography("bibliography.bib", style: "harvard-cite-them-right", title: none)
