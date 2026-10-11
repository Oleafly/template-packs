//-------------------------------------
// ATLAS Paper Template by PIRCA George
//-------------------------------------

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/wrap-it:0.1.0": *
#import "@preview/showybox:2.0.3": *

#let color_box(title, col, body) = {
  showybox(
    frame: (
      border-color: col.darken(50%),
      title-color: col.lighten(50%),
      body-color: col.lighten(80%),
    ),
    title-style: (
      boxed-style: (
        anchor: (
          x: center,
          y: horizon,
        ),
        radius: (top-left: 10pt, bottom-right: 10pt, rest: 10pt),
      ),
      color: black,
      align: center,
    ),
    shadow: (
      offset: 3pt,
    ),
    title: [#title],
    [#body #v(.3cm)],
  )
}
#let todo(message) = {
  rect(stroke: 1pt + red, radius: 2pt)[
    #text(red, weight: "bold")[TODO #message]
  ]
}





#let ATLAS-document(
  title: "TITLE",
  footer-title: "FOOTER-TITLE",
  header-title: "HEADER-TITLE",
  icons-top: [],
  icons-bottom: [],
  information: [],
  funky-mode: false,
  dark-mode: false,
  debug: false,
  body,
) = {
  // ATLAS colors
  let ATLAS_black = black
  let ATLAS_white = white
  let ATLAS_rainbow = gradient.linear(..color.map.rainbow)

  
  if dark-mode {
    ATLAS_black = white
    ATLAS_white = black
  }

  // ATLAS fonts
  let ATLAS_font = "TeX Gyre Adventor"

  let ATLAS_debug = if (debug) {
    ATLAS_black
  } else {
    ATLAS_black.transparentize(100%)
  }
  let ATLAS_accent = if (funky-mode) {
    ATLAS_rainbow
  } else {
    ATLAS_black
  }

  // ATLAS-logos
  let ATLAS-logo-text(width: auto, height: auto) = {
    if (dark-mode) {
      image(
        "assets/ATLAS-logo/ATLAS-logo-text-light.svg",
        width: width,
        height: height,
      )
    } else {
      image(
        "assets/ATLAS-logo/ATLAS-logo-text-dark.svg",
        width: width,
        height: height,
      )
    }
  }
  let ATLAS-logo-full(width: auto, height: auto) = {
    if (dark-mode) {
      image(
        "assets/ATLAS-logo/ATLAS-logo-full-light.svg",
        width: width,
        height: height,
      )
    } else {
      image(
        "assets/ATLAS-logo/ATLAS-logo-full-dark.svg",
        width: width,
        height: height,
      )
    }
  }

  let ATLAS-logo-icon(width: auto, height: auto) = {
    if (dark-mode) {
      image(
        "assets/ATLAS-logo/ATLAS-logo-icon-light.svg",
        width: width,
        height: height,
      )
    } else {
      image(
        "assets/ATLAS-logo/ATLAS-logo-icon-dark.svg",
        width: width,
        height: height,
      )
    }
  }


  let moon-progress-indicator = context {
    // Parameters
    let orbit-radius = 0.3cm
    let planet-radius = 0.06cm
    let stroke-width = .7pt

    // Adjust orbit radius to account for stroke thickness
    let visual-orbit-radius = orbit-radius - stroke-width / 2

    // Calculate progression angle
    let current-page = counter(page).get().first()
    let total-pages = counter(page).final().first()

    // Adjust for footer starting from page 2
    // Pages with footer: 2, 3, 4, ..., total-pages
    // Progress should be
    // 0.0 when current-page = 2
    // 1.0 when current-page = total-pages
    let progress = if total-pages > 2 {
      (current-page - 2) / (total-pages - 2)
    } else if total-pages == 2 {
      // Special case: only 2 pages total, page 2 should show full progress
      1
    } else {
      0
    }

    let angle = progress * 2 * calc.pi - calc.pi / 2

    // Planet position on orbit (starting from right, going counter-clockwise)
    let cx = visual-orbit-radius * calc.cos(angle)
    let cy = visual-orbit-radius * calc.sin(angle)
    box(width: 0.7cm, height: 0.7cm)[

      // Create a container that centers everything
      #box(width: 2 * orbit-radius + 2 * planet-radius, height: 2 * orbit-radius + 2 * planet-radius)[
        // Position everything relative to the center of this box
        #place(
          center + horizon,
          // Orbit circle centered in the box
          circle(radius: orbit-radius, fill: none, stroke: stroke-width + ATLAS_black, circle(
            fill: ATLAS_black,
            radius: 5pt,
          )),
        )
        #place(
          center + horizon,
          dx: cx, // Now these offsets are relative to the center
          dy: cy,
          circle(radius: planet-radius, fill: ATLAS_black),
        )

      ]
    ]
  }


  let signature-id = context {
    // CONFIGURATION: Change this value to adjust the big circle size
    let big-circle-radius = 150pt // Try values like 50pt, 150pt, 200pt, etc.

    // Auto-calculate related values based on the big circle size
    let center = big-circle-radius
    let big-radius = big-circle-radius - 5pt // Slightly smaller for padding
    let box-size = big-circle-radius * 2
    let grid-range = calc.ceil((big-circle-radius * 2) / 8pt) + 2 // Dynamic grid size

    // Alternative: Using length division to convert to numbers
    box(width: box-size, height: box-size)[
      #place(dx: 0pt, dy: 0pt)[
        #circle(radius: big-circle-radius, fill: none, stroke: none)
      ]

      // Create a time-based seed using current date
      #let today = datetime.today()
      #let seed = today.year() + today.month() + today.day()

      #for row in range(grid-range) {
        for col in range(grid-range) {
          let x = col * 14pt
          let y = row * 14pt
          let dx-num = (x - center) / 1pt // Convert length to number
          let dy-num = (y - center) / 1pt // Convert length to number
          let distance = calc.sqrt(dx-num * dx-num + dy-num * dy-num)

          if distance <= (big-radius / 1pt) {
            // Create a pseudo-random value with multiple factors for more variation
            let random-val = calc.rem(seed * 3 + row * 1 * col, 80)
            // Randomly choose between three sizes (roughly 33% chance each)
            let radius = if random-val < 33 { 1pt } else if random-val < 67 { 2pt } else { 3pt }
            // Center the circle on the grid point by offsetting by the radius
            place(dx: x - radius, dy: y - radius, circle(radius: radius, fill: ATLAS_black))
          }
        }
      }
    ]
  }

  // Set the document's basic properties.
  set document(title: title)
  set text(font: ATLAS_font, lang: "en", ATLAS_black)
  set par(justify: true)
  set heading(numbering: "I.1 )")
  set page(
    fill: ATLAS_white,
    margin: (
      top: 2cm,
      left: 1.5cm,
      right: 1.5cm,
      bottom: 2cm,
    ),
    footer: context [
      #if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 1pt + ATLAS_black)
        v(-.3cm)
        grid(
          columns: (.5fr, auto, .5fr),
          column-gutter: 10pt,
          align: horizon,
          stroke: 1pt + ATLAS_debug
        )[
          #text(size: 9pt, ATLAS_accent, emph(footer-title))
        ][
          #align(horizon + center)[
            #moon-progress-indicator
          ]
        ][
          #align(right)[
            #text(size: 9pt, ATLAS_accent, [_Page #counter(page).display("1 of 1", both: true)_])
          ]
        ]
      }
    ],
    header: context [
      #if counter(page).get().first() > 1 {
        grid(
          columns: (auto, 1fr),
          column-gutter: 10pt,
          align: horizon,
          stroke: 1pt + ATLAS_debug
        )[
          #ATLAS-logo-text(height: 0.7cm)
        ][
          #align(right)[#text(size: 9pt, ATLAS_accent)[#header-title]]
        ]
        v(-.3cm)
        line(length: 100%, stroke: 1pt + ATLAS_black)
      } else {
        grid(
          columns: 1fr,
          column-gutter: 10pt,
          align: horizon,
          stroke: 1pt + ATLAS_debug,
        )[
          #ATLAS-logo-full()
        ]
        v(-1.3cm)
      }
    ],
  )

  place(dx: 418pt, dy: 650pt)[
    #signature-id
  ]

  grid(
    columns: 1fr,
    rows: (.3fr,1fr, .5fr, 1fr, .5fr),
    stroke: 1pt + ATLAS_debug,
    align: center + horizon,"",
    icons-top,
    block(
      stroke: 1pt + ATLAS_black.transparentize(50%),
      radius: 8pt,
      inset: 1.5em,
      fill: none,
    )[
      #text(
        weight: 600,
        size: 1.8em,
        title,
      )
    ],
    information,
    icons-bottom,
  )
  // Custom show setups

  show link: it => {
    text(red, underline(it))
  }

  show figure: body => {
    rect(inset: 10pt, radius: 10pt, stroke: ATLAS_black.transparentize(50%), body)
  }

  show figure.caption: it => [
    #text(weight: 600)[
      #it.supplement
      #context it.counter.display("1"):
    ] #it.body
  ]

  show heading: it => {
    if it.level == 1 {
      it
      v(10pt)
    } else {
      it
      v(5pt)
    }
  }


  show outline.entry.where(
    level: 1,
  ): it => {
    v(15pt, weak: true)
    text(weight: "bold")[#it]
  }


  show: codly-init
  pagebreak()
  body
}

