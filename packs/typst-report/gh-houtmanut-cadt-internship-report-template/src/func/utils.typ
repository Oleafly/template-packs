
#import "../config.typ": body-font, body-font-size, code-font

#let under-construction(label) = context {
  // return label // uncomment this line to disable the warning strips
  let p-width = page.width

  set text(fill: yellow)

  align(center)[
    #box(width: 0pt)[
      #align(center)[
        #block(width: p-width)[
          #stack(
            dir: ttb,
            spacing: 0pt,

            pdf.artifact(image("../media/warning.svg", width: 100%, height: 20pt)),

            block(
              width: 100%,
              fill: black,
              inset: 2em,
              align(center)[
                //#text(fill: rgb("#E0C600"))[#label]
                #label
              ],
            ),

            pdf.artifact(image("../media/warning.svg", width: 100%, height: 20pt)),
          )
        ]
      ]
    ]
  ]
}



#let bordered-box(child, radius: 8pt) = box(
  radius: radius,
  clip: true,
  stroke: 0.5pt + luma(200),
  child,
)

#let aspect-ratio-image(img, ratio: 2, alt: none) = layout(size => box(
  clip: true,
  width: 100%,
  height: size.width * ratio,
  image(img, width: 100%, height: 100%, fit: "cover", alt: alt),
))

#let image-with-font(path, font: body-font, ..args) = {
  set text(font: font, weight: 600)
  image(path, ..args)
}

#let appendix(child, caption: none) = {
  figure(
    child,
    supplement: [Appendix],

    numbering: "1",
    kind: "appendix",
    caption: caption,
  )
}

#let code-figure(body, caption: none) = appendix(
  align(left, body),
  caption: caption,
)

// Lays out multiple appendix figures side by side in one centered row.
#let appendix-row(..figs, widths: none, gutter: 5%) = {
  let items = figs.pos()
  let cols = if widths != none { widths } else { (1fr,) * items.len() }
  align(center, grid(
    columns: cols,
    column-gutter: gutter,
    align: center,
    ..items,
  ))
}
