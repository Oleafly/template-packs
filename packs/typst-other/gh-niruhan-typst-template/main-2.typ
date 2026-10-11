#import "@preview/touying:0.5.3": *
#import themes.university: *
#import "shared.typ": *

// -------------------------------------------------------------
// PAPER METADATA
// -------------------------------------------------------------
#let paper-title  = "Title"
#let sub-title    = "Subtitle"

#let presenter    = "Niruhan Viswarupan"
#let group-name   = "IDSL"
#let present-date = datetime.today()

// -------------------------------------------------------------
// THEME
// -------------------------------------------------------------
#show: university-theme.with(
  aspect-ratio: "16-9",
  align: horizon,

  config-info(
    title: [#paper-title],
    subtitle: [#sub-title],
    author: [#presenter],
    date: present-date,
    institution: [#group-name \ Western University],
    logo: image("images/western-logo.png", width: 2.2cm),
  ),

  config-colors(
    primary: western-purple,
    secondary: western-grey,
    tertiary: western-orchid,
    neutral-lightest: western-white,
    neutral-darkest: western-purple,
  ),

  config-common(
    handout: false,
  ),

  // Regular slides: section name without the logo.
  header-right: self => utils.display-current-heading(level: 1),
)

// -------------------------------------------------------------
// TYPOGRAPHY
// -------------------------------------------------------------
#set text(
  font: "Libertinus Serif",
  size: 20pt,
  lang: "en",
)

#show heading: set text(
  font: "Libertinus Serif",
  fill: western-purple,
)

#set strong(delta: 0)

#show strong: set text(
  fill: western-orchid.darken(10%),
  weight: "bold",
)

// -------------------------------------------------------------
// TITLE SLIDE
// -------------------------------------------------------------
#title-slide()

// -------------------------------------------------------------
// SECTIONS — include in presentation order
// -------------------------------------------------------------
#include "sections/section-1.typ"
#include "sections/references.typ"
#include "sections/appendix.typ"