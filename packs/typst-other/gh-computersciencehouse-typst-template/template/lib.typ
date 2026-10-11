/*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at https://mozilla.org/MPL/2.0/.
*/


#let primary = rgb(225, 28, 82)
#let accent = rgb(176, 25, 126)
#let csh(title: "", subtitle: "", author: "", body) = {
  // --- Configuration ---
  let date = datetime.today().display()

  let logo = image("assets/logos/csh_logo_square.svg", width: 3cm)

  let stripe_gap = 0.175cm
  let stripe_offset = 1cm
  let stripe_small_size = 0.5cm
  let stripe_large_size = 1cm

  let stripe_total = stripe_offset + 2*stripe_small_size + 2*stripe_gap + stripe_large_size

  // The striped header is placed in the background,
  // so the margins of the header are defined here
  // so text does not go over the custom stripes
  set page(
    paper: "us-letter",
    margin: (
      top: stripe_total + 1cm, 
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    )
  )

  set text(font: "IBM Plex Sans")

  let y1 = stripe_offset
  let y2 = y1 + stripe_small_size + stripe_gap
  let y3 = y2 + stripe_large_size + stripe_gap

  // ------------ Header + watermark --------------
  set page(
    background: [
      // Top stripe
      #place(top + left, dy: y1)[
        #box(width: 100%, height: stripe_small_size, fill: accent)
      ]

      // Second stripe
      #place(top + left, dy: y2)[
        #box(width: 100%, height: stripe_large_size, fill: primary)
      ]

      // Third stripe
      #place(top + left, dy: y3)[
        #box(width: 100%, height: stripe_small_size, fill: accent)
      ]
      
      // Text inside the second stripe
      #place(top + right, dy: y2, dx: -stripe_offset)[
        // Creates a box the same size as the stripe
        #box(height: stripe_large_size)[
          #align(right+horizon)[
            #text(font: "IBM Plex Sans", size: 16pt, weight: "semibold", fill: white)[
              computer science house 
              #sym.bullet 
              #text(font: "IBM Plex Serif", size: 16pt, weight: "semibold", fill: white)[RIT]
              ]
          ]
        ]
      ]

      // logo inside stripes
      #place(top + left, dx: stripe_offset, dy: stripe_offset - 0.45cm)[
        #box(
          fill: white,
          inset: 0.2cm, // creates the white border around the logo
          logo
        )
      ]

      // watermark logo
      #place(center, dy: 5.5cm,
        rotate(15deg, image("assets/logos/csh_logo_watermark.svg", width: 100%))
      )
    ]
  )
  // -----------------------------------------------

  // ---------------- Title ------------------------
  v(1fr)

  align(left)[
    #text(size: 28pt, weight: "bold")[#title]

    #text(size: 16pt, style: "italic")[#subtitle]

    #text(size: 12pt)[#author]

    #text(size: 11pt)[#date]
  ]

  v(1fr)

  pagebreak()
  // -------------------------------------------------


  // --------------- content -------------------------

  // Reset page number to 1, display page number on bottom
  counter(page).update(1)
  set page(footer: context [
    #align(center)[
      #counter(page).display(
        "1",
      )
    ]
  ])

  set heading(numbering: "1.")
  show heading.where(level: 1): set text(font: "IBM Plex Sans", size: 16pt)
  show heading.where(level: 2): set text(font: "IBM Plex Sans", size: 14pt)
  set text(font: "Alegreya", size: 12pt)

  // Table of contents
  outline()
  pagebreak()

  // normal page
  body
}
