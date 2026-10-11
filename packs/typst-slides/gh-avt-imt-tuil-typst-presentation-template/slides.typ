#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/suboutline:0.3.0": *

#import "template.typ": *


#let bib-file="refs.bib"



#show: theme.with(
    title: "A brief presentation demo",
    subtitle: "where no one has gone before",
    author: "Steve Göring",
)



#title-slide()


== Einleitung Motivation

- demonstration des typst templates

== Zwei Spalten
#slide(composer: components.side-by-side.with(columns: (70%, 30%), gutter: 1em))[
- spalte 1
][
  #figure(
    image("imgs/winter.jpg", width: 80%),
  )
]



= übersicht
#suboutline()

== misc
testslide

- #emoji.cat
- a
- b

@raake2014quality

@goering2024-aiupscaling, @goering2025-aiupscaling-german @bhattacharya2025-amis
@menz2025-360_videos
@rao2025-rating
@goering2025-clipse



== tt
#slide[

  one  two
][

  image
][

  image
]

= whereever
#suboutline()


== X

u

== Y

o


#heading(outlined: false, depth:2)[References]

#bibliography(bib-file, style:"ieee", title:"References")

