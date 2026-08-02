#import "@preview/catppuccin:1.1.0": flavors

// ── Table of Contents ─────────────────────────────────────────────────────────
// Call between your title/cover page and the first chapter.
// `depth` controls how many heading levels appear (default: 2 = H1 + H2).
//
//   #toc()
//   #toc(depth: 3)
//
#let toc(depth: 2) = {
  let primary-blue = rgb("#1a3a5f")
  let body-gray = rgb("#2c3e50")

  set page(paper: "a5", margin: (x: 0.8in, y: 1in), header: none, footer: none)
  set text(font: "Inter", size: 9.5pt, fill: body-gray)

  // Title styled to match H1
  block(width: 100%, below: 1.5em)[
    #set text(size: 18pt, weight: "bold", fill: primary-blue)
    #stack(dir: ttb, spacing: 12pt, [Contents], line(length: 100%, stroke: 1.5pt + primary-blue))
  ]

  // H1 entries — semibold navy with a little breathing room above
  show outline.entry.where(level: 1): it => {
    v(0.5em, weak: true)
    set text(weight: "semibold", fill: primary-blue)
    it
  }

  // H2 entries — muted, slightly smaller
  show outline.entry.where(level: 2): it => {
    set text(size: 8.5pt, fill: body-gray.lighten(40%))
    it
  }

  outline(title: none, indent: 1.5em, depth: depth)
  pagebreak(weak: true)
}

// ── Block Quote ───────────────────────────────────────────────────────────────
#let block-quote(body, author: "", source: "") = {
  v(1em)
  block(
    width: 100%,
    inset: (left: 1.5em, top: 0.5em, bottom: 0.5em),
    stroke: (left: 2pt + black.lighten(70%)),
  )[
    #set text(style: "italic", fill: black.lighten(10%))
    #body

    #if author != "" [
      #v(0.5em)
      #set text(style: "normal", weight: "bold", size: 0.9em)
      --- #author #if source != "" [, #set text(weight: "regular"); #source]
    ]
  ]
  v(1em)
}

#let overflowing-image(img) = layout(container => {
  let dim = measure(img)
  let container-ratio = container.width / container.height
  let img-ratio = dim.width / dim.height

  if img-ratio > container-ratio {
    // the image will have horizontal overflow; set the width according to the aspect ratio
    set image(height: 100%, width: container.height * img-ratio)
    img
  } else {
    // the image will have vertical overflow; set the height according to the aspect ratio
    set image(width: 100%, height: container.width / img-ratio)
    img
  }
})

#let image-fig(img, cap) = {
  set text(size: 8pt, weight: "light", fill: black.lighten(15%))

  block(width: 100%)[
    #v(1.25em)
    #figure(img, caption: cap, gap: 1.5em)
    #v(1.25em)
  ]
}

#let callout(title, color, content) = rect(
  fill: color.lighten(90%),
  stroke: (left: 4pt + color),
  inset: 12pt,
  width: 100%,
  radius: 2pt,
)[
  #set text(weight: "bold", fill: color.darken(20%))
  #title \
  #set text(weight: "light", fill: black)
  #content
]

#let goal(body) = callout("Design Goal", rgb("#2ecc71"), body)
#let pitfall(body) = callout("Performance Pitfall", rgb("#e74c3c"), body)
#let concept(body) = callout("Core Concept", rgb("#3498db"), body)
#let definition(body) = callout("Definition", rgb("#f39c12"), body)

#let chapter(
  name: "Untitle",
  title: "Untitled Module",
  subtitle: "Untitled",
  author: "Nakuya",
  cover_image: none,
  body,
) = {
  // Macchiato palette for code blocks
  let macchiato = flavors.macchiato.colors

  set raw(theme: "macchiato.tmTheme")
  // Scaled down code font for A5
  show raw: set text(font: "Fira Code", weight: "medium", size: 8.5pt)

  show raw: it => {
    if it.block {
      v(1em)
      block(
        fill: macchiato.base.rgb,
        stroke: 1pt + macchiato.surface1.rgb,
        width: 100%,
        inset: 12pt,
        radius: 6pt,
      )[
        #set text(fill: macchiato.text.rgb)

        #if it.has("lang") {
          place(top + right, text(7pt, fill: macchiato.overlay1.rgb, weight: "bold")[#it.lang])
        }
        #it
      ]
    } else {
      box(
        fill: macchiato.surface0.rgb,
        inset: (x: 4pt, y: 2pt),
        radius: 4pt,
        text(fill: macchiato.sky.rgb, it),
      )
    }
  }

  // Scaled down body text for A5
  set text(font: "Inter", size: 9.5pt, fill: rgb("#2c3e50"))
  set par(justify: true)

  show heading.where(level: 1): it => [
    #set text(size: 18pt, weight: "bold", fill: rgb("#1a3a5f"))
    #block(width: 100%, below: 1em)[
      #stack(
        dir: ttb,
        spacing: 12pt,
        it.body,
        line(length: 100%, stroke: 1.5pt + rgb("#1a3a5f")),
      )
    ]
  ]

  show heading.where(level: 2): it => [
    #set text(size: 14pt, weight: "semibold", fill: rgb("#2980b9"))
    #block(it, above: 1.5em, below: 1em, sticky: true)
  ]

  page(paper: "a5", header: none, footer: none, margin: 0.8in)[
    #if cover_image != none [
      #align(center)[
        #cover_image
      ]
    ]
    #v(1fr)
    #align(bottom + left)[
      #text(size: 14pt, weight: "medium", fill: gray, subtitle) \
      #text(size: 24pt, weight: "bold", fill: rgb("#1a3a5f"), title)
      #line(length: 60%, stroke: 1.5pt + rgb("#1a3a5f"))
    ]
  ]

  set page(
    paper: "a5",
    margin: (x: 0.8in, y: 1in),
    header: context {
      set text(8pt, fill: gray)
      grid(
        columns: (1fr, 1fr),
        [#name], align(right, [#subtitle - #title]),
      )
    },
    footer: context {
      set text(8pt, fill: gray)
      line(length: 100%, stroke: 0.5pt + gray)
      grid(
        columns: (1fr, 1fr),
        [#author], align(right, counter(page).display("1/1", both: true)),
      )
    },
  )

  body
}
