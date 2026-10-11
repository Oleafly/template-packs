#import "template/lib.typ": *

#show: definitely-not-isec-theme.with(
  aspect-ratio: "16-9",
  font: "Open Sans",
  slide-alignment: top,
  progress-bar: true,
  logo: (cern_white, uzh_compact_white, cms_white),
  config-info(
    title: [Typst meets CMS: Creating Presentation Slides with Typst],
    subtitle: [...and let beamer retire!!!],
    authors: (
      "*Piero Viscone*": ("CERN", "University of Zürich"),
      "Author Second": ("CERN", "University of Zürich"),
      "Author Third": ("CERN",),
      "\ on behalf of the CMS Collaboration": (),
    ),
    conference: "Conference 2077",
    location: "New Tokyo",
    date: "29-31 February 2077",
    footer: ("Piero Viscone", "#title", "#conference"),
    footer_size: 10pt,
  ),
  config-common(
    handout: false,
  ),
  config-colors(
    primary: rgb("2651a8"),
    secondary: rgb("F75C2F"),
    tertiary: rgb("FFFFFF"),
    footer: rgb("808080"),
  ),
)

#title-slide(
  //background: "image.png", //If you want to customize the cover image
  title_multiplier: 0.9,
  subtitle_multiplier: 1.0,
  author_multiplier: 1.0,
  extra_multiplier: 1.0,
)

//Set some defaults if you want
#set rect(radius: 10pt)
#set text(size: 14pt)
#set par(leading: 0.7em)

#include "chapters/showcase.typ"
#include "chapters/slides.typ"

#slide(title: [Bibliography])[
  #bibliography("references/bibliography.bib")
]
