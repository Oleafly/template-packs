// --- Configuration Defaults ---
#let card-width = 55mm
#let card-height = 91mm

// --- Color Palette (Luna Say Maybe Theme) ---
#let theme-colors = (
  base: cmyk(60%, 40%, 40%, 100%),
  cyan: cmyk(33%, 0%, 0%, 0%),
  blue: cmyk(42%, 68%, 0%, 2%),
  yellow: cmyk(0%, 0%, 100%, 0%),
)

// --- Helper Layout Components ---

#let draw-background-image(image-path, bleed) = {
  rotate(-90deg)[
    #box(width: card-height + .5mm + bleed * 2, height: card-width + .5mm + bleed * 2, clip: true)[
      #align(top + center)[
        #image(image-path, width: card-height + 16mm)
      ]
    ]
  ]
}

#let draw-cyber-grid(bleed) = {
  let grid-offset-x = (calc.rem(card-width / 1mm, 5) * 1mm) / 2 + bleed
  let grid-offset-y = (calc.rem(card-height / 1mm, 5) * 1mm) / 2 + bleed

  place(top + left)[
    #for i in range(-1, 13) {
      place(top + left, dx: i * 5mm + grid-offset-x)[
        #line(start: (0pt, 0pt), end: (0pt, 100%), stroke: rgb(theme-colors.cyan).transparentize(80%) + 0.1pt)
      ]
    }
    #for i in range(-1, 20) {
      place(top + left, dy: i * 5mm + grid-offset-y)[
        #line(start: (0pt, 0pt), end: (100%, 0pt), stroke: rgb(theme-colors.cyan).transparentize(80%) + 0.1pt)
      ]
    }

    // --- Diagonal Accents ---
    #for i in range(-3, 4) {
      let offset = i * 2mm
      place(top + left, dx: -20mm + offset + bleed, dy: 10mm + offset + bleed)[
        #rotate(-45deg)[
          #rect(width: 150mm, height: 0.2pt, fill: rgb(theme-colors.cyan).transparentize(80%))
        ]
      ]
    }
  ]
}

#let draw-print-guides(show-guides, bleed) = {
  if not show-guides { return }
  place(top + left, dx: bleed, dy: bleed)[
    // Trim Line (finish size)
    #rect(width: card-width, height: card-height, stroke: 0.5pt + green.transparentize(50%))
  ]
}

#let draw-scanlines() = {
  let scanline-pattern = tiling(size: (2mm, 0.5mm))[
    #place(top + left)[
      #rect(width: 2mm, height: 0.1mm, fill: white.transparentize(95%))
    ]
  ]
  place(top + left)[
    #rect(width: 100%, height: 100%, fill: scanline-pattern)
  ]
}

#let draw-producer-name(name) = {
  place(center + horizon, dy: -5mm)[
    #stack(spacing: -15pt)[
      #text(
        font: "Syncopate",
        size: 32pt,
        weight: "bold",
        fill: theme-colors.cyan,
        tracking: -0.05em,
      )[#name]
    ]
  ]
}

#let draw-id-section(id) = {
  place(bottom + left, dx: 5mm, dy: -10mm)[
    #stack(dir: ltr, spacing: 5pt)[
      #stack(dir: ttb, spacing: 2pt)[
        #text(font: "Montserrat", size: 7pt, weight: "bold", fill: theme-colors.yellow)[PRODUCER ID]
        #text(font: "IBM Plex Sans JP", size: 11pt, weight: "bold", tracking: 0.1em)[#id]
      ]
    ]
  ]
}

#let draw-sns-section(handle) = {
  place(bottom + right, dx: -5mm, dy: -5mm)[
    #text(font: "Montserrat", size: 6pt, fill: rgb(theme-colors.cyan).transparentize(50%))[
      #handle
    ]
  ]
}

#let draw-timeline(history) = {
  place(top + left, dx: 4.3mm, dy: 20mm)[
    #box(width: auto, height: auto)[
      #place(dx: 2pt, dy: 2pt)[
        #line(start: (0pt, 0pt), end: (0pt, 100% - 4pt), stroke: rgb(theme-colors.cyan).transparentize(60%) + 0.5pt)
      ]
      #stack(
        dir: ttb,
        spacing: 0pt,
        ..history
          .enumerate()
          .map(((i, event)) => {
            stack(dir: ltr, spacing: 10pt)[
              // Marker Part (Circle only at index 0)
              #stack(dir: ttb, spacing: 0pt)[
                #if i == 0 {
                  circle(radius: 2pt, fill: theme-colors.cyan, stroke: rgb(theme-colors.cyan).transparentize(50%) + 1pt)
                } else {
                  v(4pt)
                }
              ]
              // Event Text
              #set align(horizon)
              #grid(
                columns: (10mm, 37mm),
                column-gutter: 0pt,
                text(font: "Montserrat", size: 6pt, fill: theme-colors.yellow)[#event.year],
                text(font: "IBM Plex Sans JP", size: 8pt, weight: "bold")[#event.title],
              )
              #v(4pt)
            ]
          }),
        {
          // Final concluding marker
          place(top + left, dx: 0mm, dy: 4pt)[
            #circle(radius: 2pt, fill: theme-colors.cyan, stroke: rgb(theme-colors.cyan).transparentize(50%) + 1pt)
          ]
        },
      )
    ]
  ]
}

// --- Main Template Interface ---

#let business-card(
  is-print-ready: false,
  show-guides: false,
  producer-name: [NAME],
  producer-id: "00000000",
  sns-id: "@your_sns_id",
  idol-name: [Idol Name],
  history: (),
  qr-image-path: "figs/qr-code.png",
  qr-label: [SNS],
  bg-image-path: "figs/background.jpg",
) = {
  let bleed = if is-print-ready { 3mm } else { 0mm }

  // --- Front Side Page Setup ---
  set page(
    width: card-width + bleed * 2,
    height: card-height + bleed * 2,
    margin: bleed,
    fill: theme-colors.base,
    background: [
      #place(center + horizon)[
        #draw-background-image(bg-image-path, bleed)
      ]
      #place(rect(width: 100%, height: 100%, fill: rgb(theme-colors.base).transparentize(60%)))
      #draw-cyber-grid(bleed)
      #draw-scanlines()
      #draw-print-guides(show-guides, bleed)
    ],
  )

  set text(
    font: "IBM Plex Sans JP",
    size: 8pt,
    fill: white,
  )

  // --- Front Side Content ---

  // Cyber Accents (Triangles/Paths)
  place(top + right, dx: -5mm, dy: 5mm)[
    #polygon(
      fill: theme-colors.yellow,
      (0pt, 0pt),
      (10pt, 0pt),
      (10pt, 10pt),
    )
  ]

  place(bottom + left, dx: 5mm, dy: -15mm)[
    #polygon(
      fill: theme-colors.yellow,
      (0pt, 0pt),
      (0pt, 10pt),
      (10pt, 10pt),
    )
  ]

  draw-producer-name(producer-name)
  draw-id-section(producer-id)
  draw-sns-section(sns-id)

  // Bottom Label
  place(bottom + left, dx: 5mm, dy: -5mm)[
    #text(font: "Montserrat", size: 8pt, weight: "bold", fill: white)[
      #idol-name
    ]
  ]

  // Copyright Section (Bottom-Right, Vertical)
  place(top + right, dx: -2.5mm, dy: 2.5mm)[
    #rotate(-90deg, reflow: true)[
      #text(size: 4pt, fill: white.transparentize(60%))[
        THE IDOLM\@STER™& ©Bandai Namco Entertainment Inc. Developed by QualiArts Inc.
      ]
    ]
  ]

  // --- Back Side Page Setup ---
  pagebreak()
  set page(background: [
    #place(center + horizon)[
      #draw-background-image(bg-image-path, bleed)
    ]
    #place(rect(width: 100%, height: 100%, fill: rgb(theme-colors.base).transparentize(30%)))
    #draw-cyber-grid(bleed)
    #draw-print-guides(show-guides, bleed)
  ])

  // --- Back Side Content ---

  place(top + left, dx: 4.3mm, dy: 5mm)[
    #text(
      font: "Syncopate",
      size: 10pt,
      weight: "bold",
      fill: rgb(theme-colors.cyan).transparentize(40%),
    )[MY HISTORY]
  ]

  draw-timeline(history)

  // QR Code Section (Top-Right)
  place(top + right, dx: -3mm, dy: 4mm)[
    #set align(center)
    #stack(
      dir: ttb,
      spacing: 5pt,
      rect(
        width: 15.5mm,
        height: 15.5mm,
        stroke: theme-colors.cyan + 0.5pt,
        fill: white.transparentize(90%),
        radius: 0.5mm,
      )[
        #place(center + horizon)[
          #image(qr-image-path, width: 15mm, height: 15mm)
        ]
      ],
      text(font: "Montserrat", size: 5pt, fill: rgb(theme-colors.cyan).transparentize(40%))[#qr-label],
    )
  ]

  // Build Info (Bottom-Right)
  place(bottom + right, dx: -5mm, dy: -5mm)[
    #text(font: "Montserrat", size: 5pt, fill: rgb(theme-colors.cyan).transparentize(40%))[
      BUILD: #datetime.today().display("[year]-[month]-[day]")
    ]
  ]
}
