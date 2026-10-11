#import "../lib/presets/slide.typ": *

#let metadata = (
  title: [Speaker notes workflow],
  subtitle: [Minimal Touying notes example],
  authors: (
    (
      name: [Ryo Araki],
      affiliation: [Typst Templates],
      email: [],
    ),
  ),
  date: datetime.today(),
  summary: [#("notes")#sym.at#("slide")],
  abstract: [],
  venue: [],
  logo: [],
  bibliography: none,
)

#show: slide-theme.with(config: metadata)
#slide-title-slide()

== Opening

#slide[
  This slide is visible to the audience.

  #speaker-note[
    - Greet the audience.
    - State the topic in one sentence.
  ]
]

== Main point

#slide[
  Speaker notes stay out of the normal PDF view.

  #speaker-note[
    Mention that `.pdfpc` metadata can be exported with `typst eval`.
  ]
]
