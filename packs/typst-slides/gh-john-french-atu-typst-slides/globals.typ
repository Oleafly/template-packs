#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
//#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
//#import "@preview/numbly:0.1.0": numbly
// #import "@preview/drafting:0.1.0": *
// #import "@preview/showybox:2.0.4": showybox
// #import "@preview/theorion:0.3.2": *
//#import cosmos.clouds: *
//#show: show-theorion
#import "@preview/showybox:2.0.4": showybox

#import "./atu-colours.typ": *

#let atu-logo--full-green = image("./logos/atu-logo-full-green.svg", width: 8cm);
#let atu-logo--initial-white = align(
    right,
    image(
        "./logos/atu-initial-white.svg", 
        height: 6cm,
        width: 3.8cm,
        fit: "cover"
        )
)

#let showybox-frame = (
    border-color: orange.darken(50%),
    title-color: orange.lighten(60%),
    body-color: orange.lighten(80%)
  )

#let showybox-title-style = (
    color: navy,
    weight: "regular",
    align: center
  )

#let showybox-body-style = (
    color: teal,
    weight: "regular",
  )

#let styled-showybox(title, body) = {
  showybox(
    frame: showybox-frame,
    title-style: showybox-title-style,
    title: title,
    body-style: showybox-body-style,
    body
  )
}

#let global-aspect-ratio = "16-9"
#let global-config-common = config-common(
    handout: sys.inputs.at("handout", default: false) == "true",
)

#let global-config-info = config-info(
    author: [John French],
    institution: [ATU Galway],
    logo: atu-logo--full-green,
    header-logo: atu-logo--initial-white
)

// Colour scheme
#let global-config-colors = config-colors(
    primary: orange,
    secondary: teal,
    tertiary: light-blue,
    neutral-lightest: white,
    neutral-darkest: navy,
)

// Header
#let global-header-right = self => self.info.header-logo

// Footer
// #let global-footer-columns = (1fr, 3fr, 1fr)
// #let global-footer-progress = false
// #let global-footer = self => {
//     set text(
//         // size: .9em,
//         fill: self.colors.primary.lighten(60%)
//     )
//     [
//         #self.info.title:  
//         #utils.display-current-heading(
//             level: 1
//         )
//     ]
// }

#let global-footer = self => {
    // Create a colored rectangle that spans the entire footer area
    block(
      width: 100%,
      height: 1em,  // Adjust height as needed
      fill: self.colors.primary.lighten(80%),  // Light version of primary color
      stroke: none,
      inset: (x: 0pt, y: 0.5em),  // Add some padding inside the block
      radius: (top: 4pt),  // Optional: rounded top corners
    )[
      // Center the content vertically and add some left padding
      #align(horizon)[
        #pad(1em)[
          #text(
            size: 0.7em,
            fill: self.colors.primary.darken(20%),  // Dark text for contrast
          )[
            #self.info.title #h(1em) 
            #text(fill: self.colors.primary)[#sym.triangle.r] #h(1em) 
            #utils.display-current-heading(level: 1)
          ]
        ]
      ]
    ]
  }
    
// #let global-footer-right = self => {
//     set text(
//         // size: .9em,
//         fill: self.colors.primary.lighten(60%)
//     )
//     [#context utils.slide-counter.display() / #utils.last-slide-number]
// }

#let global-footer-right = self => {
    // Create a colored rectangle that spans the entire footer area
    block(
      // width: 100%,
      width: auto,
      height: 1em,  // Adjust height as needed
      fill: self.colors.primary.lighten(80%),  // Light version of primary color
      stroke: none,
      inset: (x: 0pt, y: 0.5em),  // Add some padding inside the block
      radius: (top: 4pt),  // Optional: rounded top corners
    )[
      // Center the content vertically and add some left padding
      #align(right + horizon)[
        #pad(1em)[
          #text(
            size: .7em,
            fill: self.colors.primary.darken(20%),  // Dark text for contrast
          )[#context utils.slide-counter.display() / #utils.last-slide-number]
        ]
      ]
    ]
  }
