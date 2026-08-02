#import "@preview/fontawesome:0.2.1": *

/** Page Config **/
#let page-margin = (left: 10mm, right: 10mm, top: 10mm, bottom: 5mm)
#let main-font = ("DejaVu Sans")
#let main-font-size = 10pt
#let full-name-font-size = 30pt
#let contacts-font-size = 9pt
#let roles-padding = 10pt
#let contacts-padding = 0pt
#let footer-font-size = 8pt

/** User Data **/
#let userInfo = (

  firstname: "John",
  lastname: "Doe",
  fullName: "John Doe",
  roles: ("Lead Engineer", "Software Engineer"),
  urls: (
    linkedin: "https://www.linkedin.com/in/",
    github: "https://github.com/",
    email: "mailto:",
    homepage: "https://site.com/johndoeeeeeeeee",
  ),

  /** Try to change order and/or comment line :) **/
  contacts: (
    // homepage: "Home Page",
    // birth: "March 1 1900",
    address: "Earth | Remote",
    email: "john.doe@gmail.com",
    phone: "(+123) 123 123 32 09",
    github: "johndoeeeeeeeeex",
    linkedin: "johndoeeeeeeeeeeeeeeeeeeeeex",
  ),

  footer: ("phone", "telegram", "email"),
)

/** Color Schemes **/
#let palettes = (
  _selected: "sunrise",
  bluefish: (
    regular-color: rgb("#333333"),
    regular-color-desat: rgb("#666666"),
    accent-color: rgb("#262F99"),
  ),
  forest: (
    regular-color: rgb("#022015"),
    regular-color-desat: rgb("#153328"),
    accent-color: rgb("#1aa572"),
  ),
  sunrise: (
    regular-color: rgb("#252020"),
    regular-color-desat: rgb("#524848"),
    accent-color: rgb("#b9831e"),
  ),
  blackwhite: (
    regular-color: rgb("#000000"),
    regular-color-desat: rgb("#444444"),
    accent-color: rgb("#000000"),
  ),
)
#let pal = palettes.at(palettes._selected);

/** Icons **/
#let icons = (
  address: box(fa-icon("home", fill: pal.accent-color)),
  birth: box(fa-icon("cake", fill: pal.regular-color)),
  homepage: box(fa-icon("link", fill: pal.regular-color)),
  linkedin: box(fa-icon("linkedin", fill: rgb("0077b5"))),
  github: box(fa-icon("github", fill: rgb("#000000"))),
  phone: box(fa-icon("square-phone", fill: rgb("#588f53"))),
  email: box(fa-icon("envelope", fill: rgb("#884a45"))),
)

#let size90x10 = (left: 9fr, right: 1fr)
#let size80x20 = (left: 8fr, right: 2fr)
#let size70x30 = (left: 7fr, right: 3fr)
#let size60x40 = (left: 6fr, right: 4fr)
#let size50x50 = (left: 5fr, right: 5fr)
#let size60x40 = (left: 4fr, right: 6fr)
#let size30x70 = (left: 3fr, right: 7fr)
#let size20x80 = (left: 2fr, right: 8fr)
#let size10x90 = (left: 1fr, right: 9fr)
#let inset-row(i) = {
  (
    top: if i > 0 {
      7pt
    } else {
      0pt
    },
  )
}


